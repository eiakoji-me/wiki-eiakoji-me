export type TopicKind = 'domain' | 'topic';

export const TOPIC_KINDS: Array<{ title: string; value: TopicKind }> = [
  { title: 'Domain', value: 'domain' },
  { title: 'Topic', value: 'topic' },
];

export const MAX_TOPIC_ANCESTORS = 4;

export interface TopicPlacement {
  kind?: string;
  hasParent: boolean;
  /** Kinds from the immediate parent up to the root ancestor. */
  ancestorKinds: Array<string | undefined>;
  cycle?: boolean;
}

export function isTopicKind(value: unknown): value is TopicKind {
  return value === 'domain' || value === 'topic';
}

/**
 * Returns why a topic cannot sit where it is, or null when its placement is valid.
 * Domains are roots; topics must descend from a domain within the depth limit.
 */
export function topicPlacementError({ kind, hasParent, ancestorKinds, cycle }: TopicPlacement): string | null {
  if (!isTopicKind(kind)) return 'Choose whether this is a Domain or a Topic.';
  if (kind === 'domain') {
    return hasParent ? 'A domain cannot have a parent.' : null;
  }
  if (!hasParent) return 'A topic must have a parent topic or domain.';
  if (cycle) return 'Circular parent reference detected in topic hierarchy.';
  if (ancestorKinds.length > MAX_TOPIC_ANCESTORS) {
    return `Topic hierarchy exceeds maximum supported depth of ${MAX_TOPIC_ANCESTORS} levels.`;
  }
  if (ancestorKinds[ancestorKinds.length - 1] !== 'domain') {
    return 'A topic must sit under a domain.';
  }
  return null;
}
