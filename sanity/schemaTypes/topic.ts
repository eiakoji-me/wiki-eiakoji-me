import { defineField, defineType } from 'sanity';
import { MAX_TOPIC_ANCESTORS, TOPIC_KINDS, topicPlacementError } from '../../src/lib/taxonomy.ts';

export interface TopicParentValidationContext {
  document?: { _id?: string; kind?: string };
  getClient?: (options: { apiVersion: string }) => {
    fetch: <T = unknown>(query: string, params?: Record<string, unknown>) => Promise<T>;
  };
}

export async function validateTopicParent(
  parent: { _ref?: string } | undefined,
  context: TopicParentValidationContext
): Promise<true | string> {
  const kind = context.document?.kind;
  // The required Kind field already reports a missing kind.
  if (!kind) return true;
  if (!parent?._ref) {
    return topicPlacementError({ kind, hasParent: false, ancestorKinds: [] }) ?? true;
  }
  const currentDocId = context.document?._id?.replace(/^drafts\./, '');
  if (parent._ref === currentDocId) {
    return 'A topic cannot reference itself as its parent.';
  }
  if (kind === 'domain') {
    return topicPlacementError({ kind, hasParent: true, ancestorKinds: [] }) ?? true;
  }

  try {
    const client = context.getClient?.({ apiVersion: '2026-10-01' });
    if (!client) return true;

    const visited = new Set<string>([currentDocId || '']);
    const ancestorKinds: Array<string | undefined> = [];
    let currentParentId: string | undefined = parent._ref;
    let cycle = false;

    // Walk one ancestor past the limit so over-deep chains are reported.
    while (currentParentId && ancestorKinds.length <= MAX_TOPIC_ANCESTORS) {
      if (visited.has(currentParentId)) {
        cycle = true;
        break;
      }
      visited.add(currentParentId);

      const parentDoc: { parent?: { _ref: string }; kind?: string } | null = await client.fetch(
        `coalesce(*[_id == "drafts." + $id][0], *[_id == $id][0]){ parent, kind }`,
        { id: currentParentId }
      );
      ancestorKinds.push(parentDoc?.kind);
      currentParentId = parentDoc?.parent?._ref;
    }

    return topicPlacementError({ kind, hasParent: true, ancestorKinds, cycle }) ?? true;
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : String(err);
    return `Topic hierarchy validation could not be completed: ${message}`;
  }
}

export const topic = defineType({
  name: 'topic',
  title: 'Topic',
  type: 'document',
  fields: [
    defineField({
      name: 'kind',
      title: 'Kind',
      type: 'string',
      options: { list: TOPIC_KINDS, layout: 'radio' },
      initialValue: 'topic',
      description: 'Domains are the top-level areas shown first in navigation. Topics sit under a domain or another topic.',
      validation: (rule) => rule.required(),
    }),
    defineField({
      name: 'title',
      title: 'Title',
      type: 'string',
      validation: (rule) => rule.required().min(2).max(100),
    }),
    defineField({
      name: 'slug',
      title: 'Slug',
      type: 'slug',
      options: { source: 'title', maxLength: 96 },
      validation: (rule) => rule.required(),
    }),
    defineField({
      name: 'parent',
      title: 'Parent',
      type: 'reference',
      to: [{ type: 'topic' }],
      description: 'Required for topics. Domains have no parent.',
      // Keep a stale parent visible on a domain so the editor can remove it.
      hidden: ({ document }) => document?.kind === 'domain' && !document?.parent,
      validation: (rule) => rule.custom(validateTopicParent),
    }),
    defineField({
      name: 'summary',
      title: 'Summary',
      type: 'text',
      rows: 3,
      validation: (rule) => rule.required().min(20).max(300),
    }),
    defineField({
      name: 'description',
      title: 'Topic Overview',
      type: 'blockContent',
      description: 'Detailed curriculum notes, patterns, or introductory material rendered on the topic hub page.',
    }),
    defineField({
      name: 'icon',
      title: 'Icon Identifier',
      type: 'string',
      description: 'Optional icon keyword (e.g., cpu, server, code, book, cloud, brain).',
    }),
    defineField({
      name: 'order',
      title: 'Display Order',
      type: 'number',
      description: 'Sort weight in navigation and listings (lowest first).',
    }),
    defineField({
      name: 'featured',
      title: 'Featured',
      type: 'boolean',
      initialValue: false,
      description: 'Highlight prominently in navigation and topic hub listings.',
    }),
  ],
  orderings: [
    {
      title: 'Display Order',
      name: 'orderAsc',
      by: [
        { field: 'order', direction: 'asc' },
        { field: 'title', direction: 'asc' },
      ],
    },
    {
      title: 'Title',
      name: 'titleAsc',
      by: [{ field: 'title', direction: 'asc' }],
    },
  ],
  preview: {
    select: {
      title: 'title',
      kind: 'kind',
      parentTitle: 'parent.title',
    },
    prepare({ title, kind, parentTitle }) {
      let subtitle = 'Unclassified';
      if (kind === 'domain') subtitle = 'Domain';
      else if (kind === 'topic') subtitle = parentTitle ? `under ${parentTitle}` : 'Topic without a parent';
      return { title, subtitle };
    },
  },
});
