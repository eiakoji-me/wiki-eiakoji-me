import type { Topic, ContentSummary } from './sanity/types';
import { MAX_TOPIC_ANCESTORS, isTopicKind, topicPlacementError } from './taxonomy.ts';

export interface TopicNode {
  topic: Topic;
  parent?: TopicNode;
  children: TopicNode[];
  ancestors: Array<{ title: string; slug: string }>;
  descendantIds: Set<string>;
  directArticleIds: Set<string>;
  rollupArticleIds: Set<string>;
  directArticleCount: number;
  rollupArticleCount: number;
}

export interface ExcludedTopic {
  topic: Topic;
  reason: string;
}

export interface TopicTree {
  /** Domains, ordered by `order` then title. */
  rootTopics: TopicNode[];
  nodeMap: Map<string, TopicNode>;
  slugMap: Map<string, TopicNode>;
  /** Topics left out of the tree because they are unclassified or misplaced. */
  excluded: ExcludedTopic[];
}

export interface TopicHierarchyValidation {
  valid: boolean;
  errors: string[];
}

/**
 * Validates a list of topics for self-references, multi-hop circular dependencies,
 * orphaned parent references, maximum hierarchy depth, and domain/topic placement.
 */
export function validateTopicHierarchy(topics: Topic[], maxDepth = MAX_TOPIC_ANCESTORS): TopicHierarchyValidation {
  const errors: string[] = [];
  const topicMap = new Map<string, Topic>();

  // Index documents, explicitly prioritizing drafts over published versions
  for (const t of topics) {
    const canonicalId = t._id.replace(/^drafts\./, '');
    if (t._id.startsWith('drafts.') || !topicMap.has(canonicalId)) {
      topicMap.set(canonicalId, t);
    }
    topicMap.set(t._id, t);
  }

  for (const topic of topics) {
    if (!isTopicKind(topic.kind)) {
      errors.push(`Topic "${topic.title}" (${topic._id}) is not classified as a domain or topic.`);
    } else if (topic.kind === 'domain' && topic.parent?._id) {
      errors.push(`Domain "${topic.title}" (${topic._id}) cannot have a parent.`);
    } else if (topic.kind === 'topic' && !topic.parent?._id) {
      errors.push(`Topic "${topic.title}" (${topic._id}) must have a parent topic or domain.`);
    }

    if (!topic.parent?._id) continue;

    const parentId = topic.parent._id;
    const parentCanonical = parentId.replace(/^drafts\./, '');

    // Check for orphaned parent
    if (!topicMap.has(parentId) && !topicMap.has(parentCanonical)) {
      errors.push(`Topic "${topic.title}" (${topic._id}) references non-existent parent ID "${parentId}".`);
      continue;
    }

    // Check for direct self-reference
    const topicCanonical = topic._id.replace(/^drafts\./, '');
    if (parentId === topic._id || parentCanonical === topicCanonical) {
      errors.push(`Topic "${topic.title}" (${topic._id}) directly references itself as parent.`);
      continue;
    }

    // Traverse ancestors to check for multi-document cycles and depth limits
    const visited = new Set<string>([topicCanonical]);
    let currentParentId: string | undefined = parentCanonical;
    let depth = 0;

    while (currentParentId) {
      if (visited.has(currentParentId)) {
        errors.push(`Circular parent reference detected involving topic "${topic.title}" (${topic._id}) and ancestor ID "${currentParentId}".`);
        break;
      }
      visited.add(currentParentId);
      depth++;

      if (depth > maxDepth) {
        errors.push(`Topic "${topic.title}" (${topic._id}) exceeds maximum supported hierarchy depth of ${maxDepth} levels.`);
        break;
      }

      const parentDoc: Topic | undefined = topicMap.get(currentParentId) ?? topicMap.get(`drafts.${currentParentId}`);
      if (!parentDoc?.parent?._id && topic.kind === 'topic' && parentDoc?.kind !== 'domain') {
        errors.push(`Topic "${topic.title}" (${topic._id}) does not sit under a domain.`);
      }
      currentParentId = parentDoc?.parent?._id?.replace(/^drafts\./, '');
    }
  }

  return {
    valid: errors.length === 0,
    errors,
  };
}

export function compareTopics(a: Topic, b: Topic): number {
  return (a.order ?? 999) - (b.order ?? 999) || a.title.localeCompare(b.title);
}

/**
 * Builds the domain-rooted taxonomy. Domains become roots; a topic attaches to its
 * parent only when its whole ancestor chain is valid and ends at a domain. Anything
 * else is reported in `excluded` instead of being promoted to a root.
 */
export function buildTopicTree(
  topics: Topic[],
  articles: ContentSummary[] = []
): TopicTree {
  const nodeMap = new Map<string, TopicNode>();
  const slugMap = new Map<string, TopicNode>();
  const topicById = new Map(topics.map((t) => [t._id, t]));

  // Map article IDs by topic ID to avoid double-counting articles assigned via primary or related topics
  const topicArticleIdMap = new Map<string, Set<string>>();

  for (const article of articles) {
    const assignedTopicIds = new Set<string>();
    if (article.primaryTopic?._id) {
      assignedTopicIds.add(article.primaryTopic._id);
    }
    if (Array.isArray(article.relatedTopics)) {
      for (const rel of article.relatedTopics) {
        if (rel?._id) {
          assignedTopicIds.add(rel._id);
        }
      }
    }

    for (const topicId of assignedTopicIds) {
      let set = topicArticleIdMap.get(topicId);
      if (!set) {
        set = new Set<string>();
        topicArticleIdMap.set(topicId, set);
      }
      set.add(article._id);
    }
  }

  // Resolve each topic's placement once; a topic is valid only if its parent is.
  const placement = new Map<string, string | null>();
  function placementOf(t: Topic): string | null {
    if (placement.has(t._id)) return placement.get(t._id)!;
    const ancestorKinds: Array<string | undefined> = [];
    const visited = new Set<string>([t._id]);
    let cycle = false;
    let ancestorId = t.parent?._id;
    while (ancestorId && ancestorKinds.length <= MAX_TOPIC_ANCESTORS) {
      if (visited.has(ancestorId)) {
        cycle = true;
        break;
      }
      visited.add(ancestorId);
      const ancestor = topicById.get(ancestorId);
      ancestorKinds.push(ancestor?.kind);
      ancestorId = ancestor?.parent?._id;
    }
    let reason = topicPlacementError({ kind: t.kind, hasParent: Boolean(t.parent?._id), ancestorKinds, cycle });
    if (!reason && t.kind === 'topic') {
      // The cycle check above guarantees this recursion terminates.
      const parent = topicById.get(t.parent!._id)!;
      if (placementOf(parent)) reason = `Its parent "${parent.title}" is not in the taxonomy.`;
    }
    placement.set(t._id, reason);
    return reason;
  }

  const excluded: ExcludedTopic[] = [];
  const validTopics: Topic[] = [];
  for (const t of topics) {
    const reason = placementOf(t);
    if (reason) excluded.push({ topic: t, reason });
    else validTopics.push(t);
  }

  // Initialize nodes
  for (const t of validTopics) {
    const directSet = new Set<string>(topicArticleIdMap.get(t._id) ?? []);
    const directCount = directSet.size > 0 ? directSet.size : (t.articleCount ?? 0);
    const node: TopicNode = {
      topic: { ...t },
      children: [],
      ancestors: [],
      descendantIds: new Set(),
      directArticleIds: directSet,
      rollupArticleIds: new Set(directSet),
      directArticleCount: directCount,
      rollupArticleCount: directCount,
    };
    nodeMap.set(t._id, node);
    slugMap.set(t.slug, node);
  }

  const rootTopics: TopicNode[] = [];
  for (const t of [...validTopics].sort(compareTopics)) {
    const node = nodeMap.get(t._id)!;
    if (t.kind === 'domain') {
      rootTopics.push(node);
    } else {
      const parentNode = nodeMap.get(t.parent!._id)!;
      node.parent = parentNode;
      parentNode.children.push(node);
    }
  }

  // Compute ancestors, descendant ID sets, and union article rollups (no double-counting)
  function populateNode(node: TopicNode, currentAncestors: Array<{ title: string; slug: string }>) {
    node.ancestors = currentAncestors;
    const nextAncestors = [...currentAncestors, { title: node.topic.title, slug: node.topic.slug }];

    for (const child of node.children) {
      populateNode(child, nextAncestors);
      // Union descendant topic IDs
      node.descendantIds.add(child.topic._id);
      for (const descId of child.descendantIds) {
        node.descendantIds.add(descId);
      }

      // Union article IDs into parent rollup to guarantee no duplicate counts
      for (const articleId of child.rollupArticleIds) {
        node.rollupArticleIds.add(articleId);
      }
    }

    if (articles.length > 0) {
      node.directArticleCount = node.directArticleIds.size;
      node.rollupArticleCount = node.rollupArticleIds.size;
    } else {
      // If articles array was not supplied, aggregate static articleCount if available
      let sum = node.directArticleCount;
      for (const child of node.children) {
        sum += child.rollupArticleCount;
      }
      node.rollupArticleCount = sum;
    }
  }

  for (const root of rootTopics) {
    populateNode(root, []);
  }

  return { rootTopics, nodeMap, slugMap, excluded };
}

// Lives for the whole process, so a long-running `astro dev` warns about a
// topic once even if it is fixed and broken again; restart to see it again.
const reportedExclusions = new Set<string>();

/** Reports topics left out of the taxonomy once per build so they stay visible. */
export function logExcludedTopics(tree: TopicTree): void {
  for (const { topic, reason } of tree.excluded) {
    if (reportedExclusions.has(topic._id)) continue;
    reportedExclusions.add(topic._id);
    console.warn(`[taxonomy] Excluded "${topic.title}" (${topic._id}): ${reason}`);
  }
}

/** The hub URL for a topic in the tree, or undefined when the topic has no page. */
export function topicHref(tree: TopicTree, slug: string | undefined): string | undefined {
  return slug && tree.slugMap.has(slug) ? `/topics/${slug}/` : undefined;
}

export interface Navigation {
  domains: TopicNode[];
}

export function buildNavigation(tree: TopicTree): Navigation {
  return { domains: tree.rootTopics };
}

export function getTopicBreadcrumbs(
  topicSlug: string,
  tree: TopicTree
): Array<{ label: string; href?: string }> {
  const node = tree.slugMap.get(topicSlug);
  if (!node) {
    return [{ label: 'Topics', href: '/topics/' }];
  }

  const items: Array<{ label: string; href?: string }> = [
    { label: 'Topics', href: '/topics/' },
  ];

  for (const ancestor of node.ancestors) {
    items.push({
      label: ancestor.title,
      href: `/topics/${ancestor.slug}/`,
    });
  }

  items.push({ label: node.topic.title });
  return items;
}
