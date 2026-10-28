import { MAX_TOPIC_ANCESTORS, topicPlacementError } from '../src/lib/taxonomy.ts';
import { DOMAIN_SEEDS } from './domains.ts';

/** A topic the seed creates, or classifies and fills in when it already exists. */
export interface TopicSeed {
  _id: string;
  title: string;
  slug: string;
  /** `_id` of the parent topic or domain. */
  parent: string;
  summary?: string;
  order?: number;
  featured?: boolean;
}

/** An article whose `featured` flag and primary topic the seed asserts. */
export interface ArticleSeed {
  _id: string;
  featured?: boolean;
  /** `_id` of a topic or domain. */
  primaryTopic?: string;
}

export interface TaxonomySeed {
  topics: TopicSeed[];
  articles: ArticleSeed[];
}

type Maybe<T> = T | null | undefined;

/** Published topic as returned by `TAXONOMY_STATE_QUERY`; GROQ returns null for absent fields. */
export interface TaxonomyStateTopic {
  _id: string;
  title?: Maybe<string>;
  slug?: Maybe<string>;
  hasSlug: boolean;
  kind?: Maybe<string>;
  order?: Maybe<number>;
  summary?: Maybe<string>;
  featured?: Maybe<boolean>;
  parent?: Maybe<string>;
  hasParent: boolean;
}

export interface TaxonomyStateArticle {
  _id: string;
  featured?: Maybe<boolean>;
  primaryTopic?: Maybe<string>;
}

export interface TaxonomyStateSlugOwner {
  _id: string;
  _type: string;
  title?: Maybe<string>;
  slug: string;
}

/** The published state the planner needs, plus the ids of drafts of seeded documents. */
export interface TaxonomyState {
  topics: TaxonomyStateTopic[];
  articles: TaxonomyStateArticle[];
  /** Published documents of any type that use one of the seeded slugs. */
  slugOwners: TaxonomyStateSlugOwner[];
  /** Ids of `drafts.<id>` documents that exist for seeded ids. */
  drafts: string[];
}

export const TAXONOMY_STATE_QUERY = `{
  "topics": *[_type == "topic" && !(_id in path("drafts.**"))] {
    _id, title, "slug": slug.current, "hasSlug": defined(slug), kind, order, summary, featured,
    "parent": parent._ref, "hasParent": defined(parent)
  },
  "articles": *[_type == "article" && _id in $articleIds] { _id, featured, "primaryTopic": primaryTopic._ref },
  "slugOwners": *[defined(slug.current) && slug.current in $slugs && !(_id in path("drafts.**"))] {
    _id, _type, title, "slug": slug.current
  }
}`;

/**
 * Ids of existing drafts of seeded documents. Must run with the `raw` perspective: from API
 * version v2025-02-19 the default `published` perspective hides every `drafts.*` document.
 * Without a token the dataset's drafts stay private, so this returns no ids.
 */
export const TAXONOMY_DRAFTS_QUERY = '*[_id in $draftIds]._id';

/** Perspective each query must run with. `TAXONOMY_STATE_QUERY` stays published on purpose. */
export const TAXONOMY_STATE_PERSPECTIVE = 'published';
export const TAXONOMY_DRAFTS_PERSPECTIVE = 'raw';

export interface TaxonomyQueryParams {
  [key: string]: string[];
  articleIds: string[];
  slugs: string[];
  draftIds: string[];
}

function isId(value: unknown): value is string {
  return typeof value === 'string' && value.length > 0 && !value.startsWith('drafts.');
}

/** Parameters for `TAXONOMY_STATE_QUERY` and `TAXONOMY_DRAFTS_QUERY` (`draftIds`). Malformed entries are skipped here and blocked by the planner. */
export function taxonomyQueryParams(seed: TaxonomySeed): TaxonomyQueryParams {
  const topicIds = (seed.topics ?? []).map((t) => t?._id).filter(isId);
  const articleIds = (seed.articles ?? []).map((a) => a?._id).filter(isId);
  const slugs = (seed.topics ?? []).map((t) => t?.slug).filter((s): s is string => typeof s === 'string' && s.length > 0);
  return {
    articleIds: [...new Set(articleIds)],
    slugs: [...new Set(slugs)],
    draftIds: [...new Set([...topicIds, ...articleIds])].map((id) => `drafts.${id}`),
  };
}

/** Published state from `TAXONOMY_STATE_QUERY`, before the drafts are merged in. */
export type PublishedTaxonomyState = Omit<TaxonomyState, 'drafts'>;

/** Merges the result of `TAXONOMY_DRAFTS_QUERY` into the published state. Only `drafts.` ids are kept. */
export function mergeTaxonomyState(published: PublishedTaxonomyState, draftIds: unknown): TaxonomyState {
  const drafts = Array.isArray(draftIds)
    ? [...new Set(draftIds.filter((id): id is string => typeof id === 'string' && id.startsWith('drafts.')))]
    : [];
  return { ...published, drafts };
}

/** The subset of `SanityClient.fetch` that `fetchTaxonomyState` uses. */
export type TaxonomyFetch = (
  query: string,
  params: Record<string, string[]>,
  options: { perspective: typeof TAXONOMY_STATE_PERSPECTIVE | typeof TAXONOMY_DRAFTS_PERSPECTIVE },
) => Promise<unknown>;

/**
 * Reads the state the planner needs: published topics, articles and slug owners, plus the ids of
 * drafts of seeded documents, which only the `raw` perspective returns.
 */
export async function fetchTaxonomyState(fetch: TaxonomyFetch, seed: TaxonomySeed): Promise<TaxonomyState> {
  const { draftIds, ...stateParams } = taxonomyQueryParams(seed);
  const published = (await fetch(TAXONOMY_STATE_QUERY, stateParams, { perspective: TAXONOMY_STATE_PERSPECTIVE })) as PublishedTaxonomyState;
  const drafts = await fetch(TAXONOMY_DRAFTS_QUERY, { draftIds }, { perspective: TAXONOMY_DRAFTS_PERSPECTIVE });
  return mergeTaxonomyState(published, drafts);
}

export type TaxonomyMutation =
  | { createIfNotExists: Record<string, unknown> }
  | { patch: { id: string; setIfMissing: Record<string, unknown> } }
  | { patch: { id: string; set: Record<string, unknown> } };

export interface TaxonomySeedPlan {
  mutations: TaxonomyMutation[];
  /** Human-readable description of each planned document change, in mutation order. */
  changes: string[];
  /** Problems the seed will not resolve on its own; an editor must decide. */
  warnings: string[];
  /** Seed entries that were not applied; the seed has failed while any remain. */
  blocked: string[];
}

/** A topic as it will be after the plan is applied, which is what placement is checked against. */
interface EffectiveTopic {
  _id: string;
  title?: string;
  slug?: string;
  kind?: string;
  parent?: string;
}

interface Placement {
  reason: string | null;
  depth: number;
}

const DOMAIN_IDS = new Set(DOMAIN_SEEDS.map((d) => d._id));

function norm<T>(value: Maybe<T>): T | undefined {
  return value ?? undefined;
}

function show(value: unknown): string {
  return JSON.stringify(value);
}

function ref(id: string) {
  return { _type: 'reference', _ref: id };
}

function slugValue(current: string) {
  return { _type: 'slug', current };
}

function lengthError(field: string, value: string, min: number, max: number): string | null {
  return value.length < min || value.length > max ? `${field} must be ${min} to ${max} characters` : null;
}

/** Returns why a topic seed entry is malformed, or null. */
function topicShapeError(entry: unknown): string | null {
  if (!entry || typeof entry !== 'object') return 'entry is not an object';
  const t = entry as Record<string, unknown>;
  if (!isId(t._id)) return '_id must be a non-empty string that does not start with "drafts."';
  if (typeof t.title !== 'string') return 'title is required';
  const titleError = lengthError('title', t.title, 2, 100);
  if (titleError) return titleError;
  if (typeof t.slug !== 'string' || t.slug.length === 0) return 'slug is required';
  if (!isId(t.parent)) return 'parent must be the _id of a topic or domain';
  if (t.summary !== undefined) {
    if (typeof t.summary !== 'string') return 'summary must be a string';
    const summaryError = lengthError('summary', t.summary, 20, 300);
    if (summaryError) return summaryError;
  }
  if (t.order !== undefined && (typeof t.order !== 'number' || !Number.isFinite(t.order))) return 'order must be a finite number';
  if (t.featured !== undefined && typeof t.featured !== 'boolean') return 'featured must be true or false';
  return null;
}

/** Returns why an article seed entry is malformed, or null. */
function articleShapeError(entry: unknown): string | null {
  if (!entry || typeof entry !== 'object') return 'entry is not an object';
  const a = entry as Record<string, unknown>;
  if (!isId(a._id)) return '_id must be a non-empty string that does not start with "drafts."';
  if (a.featured !== undefined && typeof a.featured !== 'boolean') return 'featured must be true or false';
  if (a.primaryTopic !== undefined && !isId(a.primaryTopic)) return 'primaryTopic must be the _id of a topic or domain';
  if (a.featured === undefined && a.primaryTopic === undefined) return 'name featured, primaryTopic, or both';
  return null;
}

/** Counts how often each `key` value appears, so seed-internal duplicates can be blocked. */
function duplicates(entries: unknown[], key: '_id' | 'slug'): Set<string> {
  const counts = new Map<string, number>();
  for (const entry of entries) {
    const value = entry && typeof entry === 'object' ? (entry as Record<string, unknown>)[key] : undefined;
    if (typeof value === 'string') counts.set(value, (counts.get(value) ?? 0) + 1);
  }
  return new Set([...counts].filter(([, n]) => n > 1).map(([value]) => value));
}

/**
 * Plans the mutations that classify and create the seeded topics and assert the
 * seeded article flags. Topic fields are only filled where they are missing, so
 * values written in Studio win; article `featured` and `primaryTopic` are set to
 * the seed values. Placement is checked against the state after the plan, with
 * the same rule the site uses. The plan never deletes, unsets, or replaces a
 * document, and applying it then planning again yields no mutations.
 */
export function planTaxonomySeed(state: TaxonomyState, seed: TaxonomySeed): TaxonomySeedPlan {
  const plan: TaxonomySeedPlan = { mutations: [], changes: [], warnings: [], blocked: [] };
  const topicEntries: unknown[] = Array.isArray(seed?.topics) ? seed.topics : [];
  const articleEntries: unknown[] = Array.isArray(seed?.articles) ? seed.articles : [];

  const existing = new Map(state.topics.map((t) => [t._id, t]));
  const effective = new Map<string, EffectiveTopic>();
  for (const t of state.topics) {
    effective.set(t._id, { _id: t._id, title: norm(t.title), slug: norm(t.slug), kind: norm(t.kind), parent: norm(t.parent) });
  }

  // Seeded topic id -> reason it is blocked. Insertion order follows the seed.
  const blockedTopics = new Map<string, string>();
  const block = (label: string, reason: string) => {
    plan.blocked.push(label);
    plan.warnings.push(`${label} was not seeded: ${reason}.`);
  };

  // 1. Seed shape and seed-internal duplicates.
  const duplicateTopicIds = duplicates(topicEntries, '_id');
  const duplicateSlugs = duplicates(topicEntries, 'slug');
  const topics: TopicSeed[] = [];
  topicEntries.forEach((entry, index) => {
    const shapeError = topicShapeError(entry);
    if (shapeError) {
      const id = (entry as Record<string, unknown> | null)?._id;
      const label = isId(id) ? id : `topics[${index}]`;
      block(label, shapeError);
      if (isId(id)) blockedTopics.set(id, shapeError);
      return;
    }
    const t = entry as TopicSeed;
    if (duplicateTopicIds.has(t._id)) {
      if (!blockedTopics.has(t._id)) block(t._id, 'the seed lists this _id more than once');
      blockedTopics.set(t._id, 'duplicate _id in the seed');
      return;
    }
    if (duplicateSlugs.has(t.slug)) {
      block(t._id, `the seed gives slug "${t.slug}" to more than one topic`);
      blockedTopics.set(t._id, 'duplicate slug in the seed');
      return;
    }
    topics.push(t);
  });
  const seededTopicIds = new Set(topicEntries.map((e) => (e as Record<string, unknown> | null)?._id).filter(isId));

  // 2. Domains, new-topic requirements, fills, and the effective state.
  const fills = new Map<string, Record<string, unknown>>();
  const creates = new Map<string, Record<string, unknown>>();
  for (const t of topics) {
    const current = existing.get(t._id);
    if (DOMAIN_IDS.has(t._id) || current?.kind === 'domain') {
      block(t._id, 'it is a domain, and seed:domains owns domains');
      blockedTopics.set(t._id, 'it is a domain');
      continue;
    }

    if (!current) {
      if (t.summary === undefined) {
        block(t._id, 'a new topic needs a summary of 20 to 300 characters');
        blockedTopics.set(t._id, 'missing summary');
        continue;
      }
      const fields: Record<string, unknown> = {
        kind: 'topic',
        title: t.title,
        slug: slugValue(t.slug),
        parent: ref(t.parent),
        summary: t.summary,
      };
      if (t.order !== undefined) fields.order = t.order;
      if (t.featured !== undefined) fields.featured = t.featured;
      creates.set(t._id, fields);
      effective.set(t._id, { _id: t._id, title: t.title, slug: t.slug, kind: 'topic', parent: t.parent });
      continue;
    }

    const set: Record<string, unknown> = {};
    const drift = (field: string, value: unknown, seedValue: unknown) => {
      plan.warnings.push(`${t._id}.${field} is ${show(value)} in the dataset, seed says ${show(seedValue)}; keeping ${show(value)}.`);
    };
    const fill = (field: string, value: unknown, seedValue: unknown) => {
      if (seedValue === undefined) return;
      if (value === undefined) set[field] = seedValue;
      else if (value !== seedValue) drift(field, value, seedValue);
    };
    fill('kind', norm(current.kind), 'topic');
    fill('title', norm(current.title), t.title);
    if (!current.hasSlug) set.slug = slugValue(t.slug);
    else if (norm(current.slug) !== t.slug) drift('slug', norm(current.slug), t.slug);
    if (!current.hasParent) set.parent = ref(t.parent);
    else if (norm(current.parent) !== t.parent) drift('parent', norm(current.parent), t.parent);
    fill('order', norm(current.order), t.order);
    fill('summary', norm(current.summary), t.summary);
    fill('featured', norm(current.featured), t.featured);

    if (Object.keys(set).length > 0) fills.set(t._id, set);
    effective.set(t._id, {
      _id: t._id,
      title: norm(current.title) ?? t.title,
      slug: current.hasSlug ? norm(current.slug) : t.slug,
      kind: norm(current.kind) ?? 'topic',
      parent: current.hasParent ? norm(current.parent) : t.parent,
    });
  }

  // 3. Slugs: a seeded topic's resulting slug must be unique across every document type.
  for (const t of topics) {
    if (blockedTopics.has(t._id)) continue;
    const slug = effective.get(t._id)?.slug;
    if (!slug) continue;
    const owner =
      state.slugOwners.find((o) => o.slug === slug && o._id !== t._id) ??
      [...effective.values()]
        .filter((o) => o.slug === slug && o._id !== t._id && !creates.has(o._id))
        .map((o) => ({ _id: o._id, _type: 'topic', title: o.title }))[0];
    if (owner) {
      block(t._id, `"${owner.title ?? owner._id}" (${owner._id}, ${owner._type}) already uses slug "${slug}"; resolve the duplicate in Studio and rerun`);
      blockedTopics.set(t._id, 'duplicate slug');
    }
  }

  // A blocked topic keeps its current state: an existing one gets no fills, a new one is not created.
  for (const id of blockedTopics.keys()) {
    fills.delete(id);
    creates.delete(id);
    const current = existing.get(id);
    if (current) {
      effective.set(id, { _id: id, title: norm(current.title), slug: norm(current.slug), kind: norm(current.kind), parent: norm(current.parent) });
    } else {
      effective.delete(id);
    }
  }

  // 4. Placement, resolved once per topic, mirroring buildTopicTree.
  const placements = new Map<string, Placement>();
  const missingParent = (parent: string) =>
    blockedTopics.has(parent)
      ? `parent ${parent} is blocked`
      : `parent ${parent} does not exist${DOMAIN_IDS.has(parent) ? '; run seed:domains first' : ''}`;
  function placementOf(id: string): Placement {
    const known = placements.get(id);
    if (known) return known;
    const t = effective.get(id)!;
    const ancestorKinds: Array<string | undefined> = [];
    const visited = new Set<string>([id]);
    let cycle = false;
    let ancestorId = t.parent;
    while (ancestorId && ancestorKinds.length <= MAX_TOPIC_ANCESTORS) {
      if (visited.has(ancestorId)) {
        cycle = true;
        break;
      }
      visited.add(ancestorId);
      const ancestor = effective.get(ancestorId);
      ancestorKinds.push(ancestor?.kind);
      ancestorId = ancestor?.parent;
    }
    let reason: string | null = blockedTopics.get(id) ?? null;
    if (!reason && t.kind === 'topic' && t.parent && !effective.has(t.parent)) reason = missingParent(t.parent);
    if (!reason) {
      reason = topicPlacementError({ kind: t.kind, hasParent: Boolean(t.parent), ancestorKinds, cycle });
      if (reason) reason = reason.replace(/\.$/, '');
    }
    if (!reason && t.kind === 'topic') {
      // The cycle check above guarantees this recursion terminates.
      const parent = t.parent!;
      const parentReason = placementOf(parent).reason;
      if (parentReason) {
        reason = seededTopicIds.has(parent) ? `parent ${parent} is blocked` : `parent ${parent} is not in the taxonomy (${parentReason})`;
      }
    }
    const placement = { reason, depth: ancestorKinds.length };
    placements.set(id, placement);
    return placement;
  }

  const placed: Array<{ seed: TopicSeed; depth: number }> = [];
  for (const t of topics) {
    if (blockedTopics.has(t._id)) continue;
    const { reason, depth } = placementOf(t._id);
    if (reason) {
      block(t._id, reason);
      blockedTopics.set(t._id, reason);
      fills.delete(t._id);
      creates.delete(t._id);
    } else {
      placed.push({ seed: t, depth });
    }
  }

  // 5. Topic mutations, parents first so strong references resolve within one transaction.
  const mutatedIds: string[] = [];
  placed.sort((a, b) => a.depth - b.depth);
  for (const { seed: t } of placed) {
    const create = creates.get(t._id);
    if (create) {
      plan.mutations.push({ createIfNotExists: { _id: t._id, _type: 'topic', ...create } });
      plan.mutations.push({ patch: { id: t._id, setIfMissing: { ...create } } });
      plan.changes.push(`create ${t._id} (${t.title})`);
      mutatedIds.push(t._id);
      continue;
    }
    const set = fills.get(t._id);
    if (set) {
      plan.mutations.push({ patch: { id: t._id, setIfMissing: set } });
      plan.changes.push(`update ${t._id}: ${Object.keys(set).join(', ')}`);
      mutatedIds.push(t._id);
    }
  }

  // 6. Articles, last, so references to topics created above resolve.
  const articles = new Map(state.articles.map((a) => [a._id, a]));
  const duplicateArticleIds = duplicates(articleEntries, '_id');
  const reportedArticles = new Set<string>();
  const blockArticle = (label: string, reason: string) => {
    plan.blocked.push(label);
    plan.warnings.push(`${label} was not updated: ${reason}.`);
  };
  articleEntries.forEach((entry, index) => {
    const shapeError = articleShapeError(entry);
    if (shapeError) {
      const id = (entry as Record<string, unknown> | null)?._id;
      blockArticle(isId(id) ? id : `articles[${index}]`, shapeError);
      return;
    }
    const a = entry as ArticleSeed;
    if (duplicateArticleIds.has(a._id)) {
      if (!reportedArticles.has(a._id)) blockArticle(a._id, 'the seed lists this _id more than once');
      reportedArticles.add(a._id);
      return;
    }
    const current = articles.get(a._id);
    if (!current) {
      blockArticle(a._id, `no published article ${a._id}`);
      return;
    }
    if (a.primaryTopic !== undefined) {
      const target = a.primaryTopic;
      let reason: string | null = null;
      if (blockedTopics.has(target)) reason = `primaryTopic ${target} is blocked`;
      else if (!effective.has(target)) reason = `primaryTopic ${target} does not exist`;
      else {
        const targetReason = placementOf(target).reason;
        if (targetReason) reason = `primaryTopic ${target} is not in the taxonomy (${targetReason})`;
      }
      if (reason) {
        blockArticle(a._id, reason);
        return;
      }
    }
    const set: Record<string, unknown> = {};
    if (a.featured !== undefined && norm(current.featured) !== a.featured) set.featured = a.featured;
    if (a.primaryTopic !== undefined && norm(current.primaryTopic) !== a.primaryTopic) set.primaryTopic = ref(a.primaryTopic);
    if (Object.keys(set).length > 0) {
      plan.mutations.push({ patch: { id: a._id, set } });
      plan.changes.push(`update ${a._id}: ${Object.keys(set).join(', ')}`);
      mutatedIds.push(a._id);
    }
  });

  // 7. Drafts shadow the published values in Studio.
  const drafts = new Set(state.drafts);
  for (const id of mutatedIds) {
    if (drafts.has(`drafts.${id}`)) {
      plan.warnings.push(`Studio shows draft values for ${id} until the draft is published or discarded; publishing it would undo the seed.`);
    }
  }

  // 8. Unclassified topics the seed does not list are reported, not changed.
  for (const t of state.topics) {
    if (!seededTopicIds.has(t._id) && norm(t.kind) === undefined) {
      plan.warnings.push(`"${norm(t.title) ?? t._id}" (${t._id}) is an unclassified topic that the seed does not list; set its kind in Studio.`);
    }
  }

  return plan;
}
