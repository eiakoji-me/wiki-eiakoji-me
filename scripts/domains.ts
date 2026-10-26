export interface DomainSeed {
  _id: string;
  title: string;
  slug: string;
  summary: string;
  order: number;
}

export const DOMAIN_SEEDS: DomainSeed[] = [
  {
    _id: 'domain-system-design',
    title: 'System Design',
    slug: 'system-design',
    summary: 'Architecture patterns, distributed systems foundations, and real-world system case studies.',
    order: 1,
  },
  {
    _id: 'domain-platform-engineering',
    title: 'Platform Engineering',
    slug: 'platform-engineering',
    summary: 'Internal developer platforms, infrastructure as code, runtime environments, and developer experience.',
    order: 2,
  },
  {
    _id: 'domain-ai-engineering',
    title: 'AI Engineering',
    slug: 'ai-engineering',
    summary: 'Machine learning systems, generative AI architectures, agentic workflows, and LLM application engineering.',
    order: 3,
  },
];

/** Published topic documents as fetched by `EXISTING_TOPICS_QUERY`. */
export interface ExistingTopic {
  _id: string;
  title?: string;
  slug?: string;
  kind?: string;
  order?: number;
  summary?: string;
  hasParent?: boolean;
}

export const EXISTING_TOPICS_QUERY = `*[_type == "topic" && !(_id in path("drafts.**"))] {
  _id, title, "slug": slug.current, kind, order, summary, "hasParent": defined(parent)
}`;

export type SeedMutation =
  | { createIfNotExists: Record<string, unknown> }
  | { patch: { id: string; set: Record<string, unknown> } };

export interface DomainSeedPlan {
  mutations: SeedMutation[];
  /** Human-readable description of each mutation, in the same order. */
  changes: string[];
  /** Problems the seed will not resolve on its own; an editor must decide. */
  warnings: string[];
}

/**
 * Plans the mutations that bring the three domains to their canonical state.
 * It only creates or sets fields, never deletes, and never replaces a summary an
 * editor has written. Running the plan and planning again yields no mutations.
 */
export function planDomainSeed(existing: ExistingTopic[]): DomainSeedPlan {
  const byId = new Map(existing.map((doc) => [doc._id, doc]));
  const seedIds = new Set(DOMAIN_SEEDS.map((seed) => seed._id));
  const plan: DomainSeedPlan = { mutations: [], changes: [], warnings: [] };

  for (const seed of DOMAIN_SEEDS) {
    const current = byId.get(seed._id);
    const slugOwner = existing.find((doc) => doc.slug === seed.slug && doc._id !== seed._id);
    if (slugOwner) {
      plan.warnings.push(
        `"${slugOwner.title}" (${slugOwner._id}) already uses slug "${seed.slug}"; ${seed._id} was not seeded. Resolve the duplicate in Studio and rerun.`,
      );
      continue;
    }

    if (!current) {
      plan.mutations.push({
        createIfNotExists: {
          _id: seed._id,
          _type: 'topic',
          kind: 'domain',
          title: seed.title,
          slug: { _type: 'slug', current: seed.slug },
          summary: seed.summary,
          order: seed.order,
        },
      });
      plan.changes.push(`create ${seed._id} (${seed.title})`);
      continue;
    }

    const set: Record<string, unknown> = {};
    if (current.kind !== 'domain') set.kind = 'domain';
    if (current.title !== seed.title) set.title = seed.title;
    if (current.slug !== seed.slug) set.slug = { _type: 'slug', current: seed.slug };
    if (current.order !== seed.order) set.order = seed.order;
    if (!current.summary) set.summary = seed.summary;
    if (Object.keys(set).length > 0) {
      plan.mutations.push({ patch: { id: seed._id, set } });
      plan.changes.push(`update ${seed._id}: ${Object.keys(set).join(', ')}`);
    }
    if (current.hasParent) {
      plan.warnings.push(`${seed._id} has a parent; remove it in Studio so the domain validates.`);
    }
  }

  for (const doc of existing) {
    if (!seedIds.has(doc._id) && !doc.kind && !doc.hasParent) {
      plan.warnings.push(`"${doc.title}" (${doc._id}) is an unclassified root topic; set its kind in Studio.`);
    }
  }

  return plan;
}
