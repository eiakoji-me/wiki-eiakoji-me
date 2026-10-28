// Unit and fixture tests for the taxonomy seed planner. No network access.
import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { buildNavigation, buildTopicTree } from '../src/lib/topics.ts';
import { MAX_TOPIC_ANCESTORS } from '../src/lib/taxonomy.ts';
import {
  TAXONOMY_DRAFTS_QUERY,
  TAXONOMY_STATE_QUERY,
  fetchTaxonomyState,
  mergeTaxonomyState,
  planTaxonomySeed,
  taxonomyQueryParams,
} from './taxonomy.ts';

const clone = (value) => JSON.parse(JSON.stringify(value));
const allPlans = [];
const plan = (state, seed) => {
  const result = planTaxonomySeed(state, seed);
  allPlans.push({ result, seed });
  return result;
};

/** Applies a plan to an in-memory copy of the state, the way Sanity would. */
function apply(state, result) {
  const next = clone(state);
  const findDoc = (id) => next.topics.find((t) => t._id === id) ?? next.articles.find((a) => a._id === id);
  const write = (doc, key, value, onlyIfMissing) => {
    if (key === 'slug') {
      if (onlyIfMissing && doc.hasSlug) return;
      doc.slug = value.current;
      doc.hasSlug = true;
    } else if (key === 'parent' || key === 'primaryTopic') {
      if (onlyIfMissing && (key === 'parent' ? doc.hasParent : doc.primaryTopic != null)) return;
      doc[key] = value._ref;
      if (key === 'parent') doc.hasParent = true;
    } else {
      if (onlyIfMissing && doc[key] != null) return;
      doc[key] = value;
    }
  };
  for (const mutation of result.mutations) {
    const ops = Object.keys(mutation);
    assert.equal(ops.length, 1, 'one operation per mutation');
    if (mutation.createIfNotExists) {
      const { _id, _type, ...fields } = mutation.createIfNotExists;
      assert.equal(_type, 'topic', 'only topics may be created');
      if (findDoc(_id)) continue;
      const doc = { _id, hasSlug: false, hasParent: false };
      for (const [key, value] of Object.entries(fields)) write(doc, key, value, false);
      next.topics.push(doc);
    } else if (mutation.patch) {
      const { id, set, setIfMissing, ...rest } = mutation.patch;
      assert.deepEqual(Object.keys(rest), [], `unexpected patch operation on ${id}`);
      const doc = findDoc(id);
      assert.ok(doc, `patch target ${id} must exist when the patch runs`);
      for (const [key, value] of Object.entries(setIfMissing ?? {})) write(doc, key, value, true);
      for (const [key, value] of Object.entries(set ?? {})) write(doc, key, value, false);
    } else {
      throw new Error(`unexpected mutation ${JSON.stringify(mutation)}`);
    }
  }
  return next;
}

const domain = (id, title, slug, order) => ({
  _id: id, title, slug, hasSlug: true, kind: 'domain', order, summary: `${title} domain summary text.`, featured: null, parent: null, hasParent: false,
});
const domains = [
  domain('domain-software-architecture', 'Software Architecture', 'software-architecture', 1),
  domain('domain-system-design', 'System Design', 'system-design', 2),
  domain('domain-platform-engineering', 'Platform Engineering', 'platform-engineering', 3),
];
const existingTopic = (id, slug, parent, extra = {}) => ({
  _id: id, title: extra.title ?? slug, slug, hasSlug: true, kind: null, order: null, summary: 'An existing topic summary.', featured: null,
  parent, hasParent: Boolean(parent), ...extra,
});
const baseState = (extra = {}) => ({ topics: clone(domains), articles: [], slugOwners: [], drafts: [], ...extra });
const summary = 'A seeded summary that is long enough.';
const newTopic = (id, parent, extra = {}) => ({ _id: id, title: `Title ${id}`, slug: id, parent, summary, ...extra });

// Snapshot of the published production dataset, read from the public API on 2026-10-28.
const prodState = {
  topics: [
    ...clone(domains),
    existingTopic('topic-architectural-patterns', 'architectural-patterns', 'domain-software-architecture', {
      title: 'Architectural Patterns',
      order: 10,
      summary: 'Enterprise application patterns, domain logic structuring, layering invariants, and object-relational mapping.',
    }),
    existingTopic('topic-domain-driven-design', 'domain-driven-design', 'domain-software-architecture', {
      title: 'Domain-Driven Design',
      order: 20,
      summary: 'Domain modeling principles, ubiquitous language, aggregate boundaries, value objects, and bounded contexts.',
    }),
    existingTopic('topic-agentic-workflows', 'agentic-workflows', 'domain-software-architecture', {
      title: 'Agentic Workflows',
      order: 30,
      summary: 'Multi-step agent pipelines, tool use, durable state, and human-in-the-loop control for LLM-driven work.',
    }),
    existingTopic('topic-distributed-systems', 'distributed-systems', 'domain-system-design', {
      title: 'Distributed Systems',
      order: 10,
      summary: 'Foundational consensus algorithms, replication strategies, partitioning, and high-availability systems.',
    }),
    existingTopic('topic-execution-environments', 'execution-environments', 'domain-platform-engineering', {
      title: 'Execution Environments',
      order: 10,
      summary: 'Workspace control planes, isolated runtimes, and the boundaries that let agents and developers execute work safely.',
    }),
  ],
  articles: [
    { _id: 'article-ai-execution-environment-architecture', featured: true, primaryTopic: 'topic-execution-environments' },
    { _id: 'article-poeaa-part-1-layering-and-domain-logic', featured: false, primaryTopic: 'topic-architectural-patterns' },
  ],
  slugOwners: [
    { _id: 'topic-architectural-patterns', _type: 'topic', title: 'Architectural Patterns', slug: 'architectural-patterns' },
    { _id: 'topic-domain-driven-design', _type: 'topic', title: 'Domain-Driven Design', slug: 'domain-driven-design' },
    { _id: 'topic-agentic-workflows', _type: 'topic', title: 'Agentic Workflows', slug: 'agentic-workflows' },
    { _id: 'topic-distributed-systems', _type: 'topic', title: 'Distributed Systems', slug: 'distributed-systems' },
    { _id: 'topic-execution-environments', _type: 'topic', title: 'Execution Environments', slug: 'execution-environments' },
  ],
  drafts: [],
};
const prodArticles = [
  {
    _id: 'article-ai-execution-environment-architecture', slug: 'ai-execution-environment-architecture',
    title: 'Architecture of an Issue-Driven AI Execution Environment', publishedAt: '2026-10-27T17:03:11.012Z',
    related: ['domain-software-architecture', 'domain-system-design'],
  },
  {
    _id: 'article-poeaa-part-1-layering-and-domain-logic', slug: 'poeaa-part-1-layering-and-domain-logic',
    title: 'PoEAA Part I: Layering & Domain Logic Architecture', publishedAt: '2026-10-28T00:00:00.000Z',
    related: ['topic-domain-driven-design', 'domain-software-architecture'], featured: false, primaryTopic: 'topic-architectural-patterns',
  },
];

const ids = (result) => result.mutations.map((m) => m.createIfNotExists?._id ?? m.patch.id);
const assertBlocked = (result, id, ...fragments) => {
  assert.ok(result.blocked.includes(id), `${id} must be blocked; blocked=${JSON.stringify(result.blocked)}`);
  const warning = result.warnings.find((w) => w.startsWith(`${id} was not`));
  assert.ok(warning, `${id} must have a warning; warnings=${JSON.stringify(result.warnings)}`);
  for (const fragment of fragments) assert.ok(warning.includes(fragment), `warning for ${id} must mention "${fragment}": ${warning}`);
  assert.ok(!ids(result).includes(id), `blocked ${id} must get no mutations`);
};

// 1. Classifying an existing topic patches kind only.
{
  const state = baseState({ topics: [...clone(domains), existingTopic('topic-x', 'x', 'domain-system-design', { title: 'X topic', order: 1 })] });
  const result = plan(state, { topics: [{ _id: 'topic-x', title: 'X topic', slug: 'x', parent: 'domain-system-design', order: 1 }], articles: [] });
  assert.deepEqual(result.mutations, [{ patch: { id: 'topic-x', setIfMissing: { kind: 'topic' } } }]);
  assert.deepEqual(result.changes, ['update topic-x: kind']);
  assert.deepEqual(result.warnings, []);
  assert.deepEqual(result.blocked, []);
}

// 1b. Production: all three topics are classified, including the child whose parent is classified in the same run.
{
  const seed = { topics: prodState.slugOwners.map((o) => {
    const t = prodState.topics.find((x) => x._id === o._id);
    return { _id: t._id, title: t.title, slug: t.slug, parent: t.parent, order: t.order };
  }), articles: [] };
  const result = plan(prodState, seed);
  assert.deepEqual(result.blocked, []);
  assert.deepEqual(ids(result), ['topic-architectural-patterns', 'topic-domain-driven-design', 'topic-agentic-workflows', 'topic-distributed-systems', 'topic-execution-environments']);
}

// 2. Nested creates: parents first whatever the seed order, with createIfNotExists only.
const nestedSeed = {
  topics: [newTopic('topic-child', 'topic-parent'), newTopic('topic-parent', 'domain-software-architecture', { order: 5, featured: true })],
  articles: [],
};
{
  const result = plan(baseState(), nestedSeed);
  assert.deepEqual(result.blocked, []);
  assert.deepEqual(result.changes, ['create topic-parent (Title topic-parent)', 'create topic-child (Title topic-child)']);
  assert.deepEqual(result.mutations.map((m) => Object.keys(m.patch ?? m)[0] === 'createIfNotExists' ? 'create' : Object.keys(m.patch).find((k) => k !== 'id')),
    ['create', 'setIfMissing', 'create', 'setIfMissing']);
  assert.deepEqual(result.mutations[0], {
    createIfNotExists: {
      _id: 'topic-parent', _type: 'topic', kind: 'topic', title: 'Title topic-parent', slug: { _type: 'slug', current: 'topic-parent' },
      parent: { _type: 'reference', _ref: 'domain-software-architecture' }, summary, order: 5, featured: true,
    },
  });
  assert.deepEqual(result.mutations[2].createIfNotExists.parent, { _type: 'reference', _ref: 'topic-parent' });
}

// 3. Idempotence: applying a plan and planning again yields nothing.
for (const [label, state, seed] of [
  ['nested', baseState(), nestedSeed],
  ['production', prodState, JSON.parse(await readFile(new URL('./data/taxonomy.json', import.meta.url), 'utf8'))],
]) {
  const first = plan(state, seed);
  const second = plan(apply(state, first), seed);
  assert.deepEqual(second.mutations, [], `${label}: a second run must plan no mutations`);
  assert.deepEqual(second.changes, [], `${label}: a second run must report no changes`);
  assert.deepEqual(second.blocked, [], `${label}: a second run must block nothing`);
  assert.deepEqual(second.warnings, [], `${label}: a second run must warn about nothing`);
}

// 4. Studio edits win: drift is warned about, never overwritten; unnamed fields survive.
{
  const state = baseState({
    topics: [...clone(domains), existingTopic('topic-y', 'y', 'domain-platform-engineering', { title: 'Studio title', order: 5, kind: 'topic', summary: '', icon: 'star' })],
  });
  const seed = { topics: [newTopic('topic-y', 'domain-system-design', { title: 'Seed title', slug: 'y', order: 7 })], articles: [] };
  const result = plan(state, seed);
  assert.deepEqual(result.mutations, [], 'no field may be overwritten');
  assert.deepEqual(result.blocked, []);
  for (const field of ['title', 'parent', 'order', 'summary']) {
    assert.ok(result.warnings.some((w) => w.startsWith(`topic-y.${field} is `) && w.includes('keeping')), `drift on ${field} must be warned about`);
  }
  assert.equal(apply(state, result).topics.find((t) => t._id === 'topic-y').icon, 'star');

  // Missing fields are filled; present ones are not.
  const partial = baseState({ topics: [...clone(domains), existingTopic('topic-z', 'z', null, { title: null, summary: null, hasSlug: false, slug: null })] });
  const fillPlan = plan(partial, { topics: [newTopic('topic-z', 'domain-system-design', { slug: 'z', order: 3 })], articles: [] });
  assert.deepEqual(fillPlan.mutations, [{
    patch: {
      id: 'topic-z',
      setIfMissing: {
        kind: 'topic', title: 'Title topic-z', slug: { _type: 'slug', current: 'z' }, parent: { _type: 'reference', _ref: 'domain-system-design' }, order: 3, summary,
      },
    },
  }]);
  assert.deepEqual(fillPlan.changes, ['update topic-z: kind, title, slug, parent, order, summary']);
}

// 5. Blocked topics.
{
  const missing = plan(baseState(), { topics: [newTopic('topic-a', 'topic-nope')], articles: [] });
  assertBlocked(missing, 'topic-a', 'parent topic-nope does not exist');

  const noDomains = plan({ topics: [], articles: [], slugOwners: [], drafts: [] }, { topics: [newTopic('topic-a', 'domain-system-design')], articles: [] });
  assertBlocked(noDomains, 'topic-a', 'domain-system-design', 'seed:domains');

  const cycle = plan(baseState(), { topics: [newTopic('topic-a', 'topic-b'), newTopic('topic-b', 'topic-a')], articles: [] });
  assertBlocked(cycle, 'topic-a', 'Circular');
  assertBlocked(cycle, 'topic-b', 'Circular');

  const rootState = baseState({ topics: [...clone(domains), existingTopic('topic-root', 'root', null, { title: 'Root' })] });
  const unrooted = plan(rootState, { topics: [newTopic('topic-a', 'topic-root')], articles: [] });
  assertBlocked(unrooted, 'topic-a', 'must sit under a domain');
  assert.ok(unrooted.warnings.some((w) => w.includes('(topic-root) is an unclassified topic')));

  const chain = [newTopic('topic-1', 'domain-system-design')];
  for (let i = 2; i <= MAX_TOPIC_ANCESTORS + 1; i += 1) chain.push(newTopic(`topic-${i}`, `topic-${i - 1}`));
  const deep = plan(baseState(), { topics: chain, articles: [] });
  assertBlocked(deep, `topic-${MAX_TOPIC_ANCESTORS + 1}`, 'maximum supported depth');
  assert.deepEqual(deep.blocked, [`topic-${MAX_TOPIC_ANCESTORS + 1}`]);
  assert.equal(deep.changes.length, MAX_TOPIC_ANCESTORS, 'topics within the depth limit are still created');

  const articleSlug = plan(
    baseState({ slugOwners: [{ _id: 'article-foo', _type: 'article', title: 'Foo article', slug: 'foo' }] }),
    { topics: [newTopic('topic-a', 'domain-system-design', { slug: 'foo' })], articles: [] },
  );
  assertBlocked(articleSlug, 'topic-a', 'article-foo', 'article', '"foo"');

  const topicSlugState = baseState({ topics: [...clone(domains), existingTopic('topic-other', 'foo', 'domain-system-design', { kind: 'topic' })] });
  const topicSlug = plan(topicSlugState, { topics: [newTopic('topic-a', 'domain-system-design', { slug: 'foo' })], articles: [] });
  assertBlocked(topicSlug, 'topic-a', 'topic-other', '"foo"');

  const domainSlug = plan(baseState(), { topics: [newTopic('topic-a', 'domain-system-design', { slug: 'system-design' })], articles: [] });
  assertBlocked(domainSlug, 'topic-a', 'domain-system-design');

  const isDomain = plan(baseState(), { topics: [newTopic('domain-system-design', 'domain-software-architecture', { slug: 'system-design' })], articles: [] });
  assertBlocked(isDomain, 'domain-system-design', 'domain');
  assert.deepEqual(isDomain.mutations, [], 'a domain must never be patched by the taxonomy seed');

  const transitive = plan(
    baseState({ slugOwners: [{ _id: 'article-foo', _type: 'article', title: 'Foo', slug: 'foo' }] }),
    { topics: [newTopic('topic-p', 'domain-system-design', { slug: 'foo' }), newTopic('topic-c', 'topic-p')], articles: [] },
  );
  assertBlocked(transitive, 'topic-p', 'foo');
  assertBlocked(transitive, 'topic-c', 'parent topic-p is blocked');

  const existingBlocked = plan(
    baseState({
      topics: [...clone(domains), existingTopic('topic-p', 'p', 'domain-system-design', { title: 'Topic P' }), existingTopic('topic-dup', 'p', 'domain-system-design', { kind: 'topic' })],
    }),
    { topics: [newTopic('topic-p', 'domain-system-design', { title: 'Topic P', slug: 'p' }), newTopic('topic-c', 'topic-p')], articles: [] },
  );
  assertBlocked(existingBlocked, 'topic-p', 'topic-dup');
  assertBlocked(existingBlocked, 'topic-c', 'parent topic-p is blocked');

  const malformed = plan(baseState(), {
    topics: [{ _id: 'topic-bad', title: 'X', slug: 'bad', parent: 'domain-system-design' }, { title: 'No id here' }, newTopic('topic-good', 'domain-system-design')],
    articles: [],
  });
  assertBlocked(malformed, 'topic-bad', 'title must be 2 to 100 characters');
  assertBlocked(malformed, 'topics[1]', '_id');
  assert.deepEqual(malformed.changes, ['create topic-good (Title topic-good)'], 'well-formed entries still plan');

  const shortSummary = plan(baseState(), { topics: [newTopic('topic-a', 'domain-system-design', { summary: 'too short' })], articles: [] });
  assertBlocked(shortSummary, 'topic-a', 'summary must be 20 to 300 characters');

  const noSummary = plan(baseState(), { topics: [{ _id: 'topic-a', title: 'Topic A', slug: 'a', parent: 'domain-system-design' }], articles: [] });
  assertBlocked(noSummary, 'topic-a', 'needs a summary');

  const duplicateId = plan(baseState(), { topics: [newTopic('topic-a', 'domain-system-design'), newTopic('topic-a', 'domain-software-architecture', { slug: 'a2' })], articles: [] });
  assertBlocked(duplicateId, 'topic-a', 'more than once');

  const duplicateSlug = plan(baseState(), { topics: [newTopic('topic-a', 'domain-system-design', { slug: 's' }), newTopic('topic-b', 'domain-system-design', { slug: 's' })], articles: [] });
  assertBlocked(duplicateSlug, 'topic-a', 'more than one topic');
  assertBlocked(duplicateSlug, 'topic-b', 'more than one topic');

  const draftId = plan(baseState(), { topics: [newTopic('drafts.topic-a', 'domain-system-design')], articles: [] });
  assertBlocked(draftId, 'topics[0]', 'drafts.');
}

// 6. Blocked articles get no patch at all, not even featured.
{
  const state = baseState({
    topics: [...clone(domains), existingTopic('topic-excluded', 'excluded', null, { title: 'Excluded' })],
    articles: [{ _id: 'article-a', featured: false, primaryTopic: null }],
    slugOwners: [{ _id: 'article-foo', _type: 'article', title: 'Foo', slug: 'foo' }],
  });
  const cases = [
    [{ _id: 'article-missing', featured: true }, 'no published article'],
    [{ _id: 'article-a', featured: true, primaryTopic: 'topic-unknown' }, 'primaryTopic topic-unknown does not exist'],
    [{ _id: 'article-a', featured: true, primaryTopic: 'topic-blocked' }, 'primaryTopic topic-blocked is blocked'],
    [{ _id: 'article-a', featured: true, primaryTopic: 'topic-excluded' }, 'primaryTopic topic-excluded is not in the taxonomy'],
    [{ _id: 'article-a' }, 'name featured, primaryTopic, or both'],
  ];
  for (const [entry, reason] of cases) {
    const result = plan(state, { topics: [newTopic('topic-blocked', 'domain-system-design', { slug: 'foo' })], articles: [entry] });
    assertBlocked(result, entry._id, reason);
  }
  const toDomain = plan(state, { topics: [], articles: [{ _id: 'article-a', primaryTopic: 'domain-software-architecture' }] });
  assert.deepEqual(toDomain.blocked, []);
  assert.deepEqual(toDomain.mutations, [{ patch: { id: 'article-a', set: { primaryTopic: { _type: 'reference', _ref: 'domain-software-architecture' } } } }]);
}

// 7. Article patches set only featured and primaryTopic, and only when they differ.
{
  const state = baseState({
    topics: [...clone(domains), existingTopic('topic-t', 't', 'domain-system-design', { kind: 'topic' })],
    articles: [
      { _id: 'article-false', featured: false, primaryTopic: 'topic-t' },
      { _id: 'article-null', featured: null, primaryTopic: 'topic-t' },
      { _id: 'article-move', featured: true, primaryTopic: 'domain-system-design' },
      { _id: 'article-same', featured: true, primaryTopic: 'topic-t' },
    ],
  });
  const result = plan(state, {
    topics: [],
    articles: [
      { _id: 'article-false', featured: true },
      { _id: 'article-null', featured: true },
      { _id: 'article-move', featured: true, primaryTopic: 'topic-t' },
      { _id: 'article-same', featured: true, primaryTopic: 'topic-t' },
    ],
  });
  assert.deepEqual(result.mutations, [
    { patch: { id: 'article-false', set: { featured: true } } },
    { patch: { id: 'article-null', set: { featured: true } } },
    { patch: { id: 'article-move', set: { primaryTopic: { _type: 'reference', _ref: 'topic-t' } } } },
  ]);
  assert.deepEqual(result.blocked, []);
}

// 8. Drafts of patched documents are warned about.
{
  const state = baseState({
    topics: [...clone(domains), existingTopic('topic-d', 'd', 'domain-system-design', { title: 'Topic D' })],
    articles: [{ _id: 'article-d', featured: false, primaryTopic: null }],
    drafts: ['drafts.topic-d', 'drafts.article-d'],
  });
  const result = plan(state, { topics: [newTopic('topic-d', 'domain-system-design', { title: 'Topic D', slug: 'd', summary: undefined })], articles: [{ _id: 'article-d', featured: true }] });
  assert.deepEqual(result.blocked, []);
  assert.ok(result.warnings.some((w) => w.includes('draft values for topic-d')));
  assert.ok(result.warnings.some((w) => w.includes('draft values for article-d')));
}

// 9. An unlisted unclassified topic is a warning, not a block.
{
  const state = baseState({ topics: [...clone(domains), existingTopic('topic-legacy', 'legacy', null, { title: 'Legacy' })] });
  const result = plan(state, { topics: [], articles: [] });
  assert.deepEqual(result.mutations, []);
  assert.deepEqual(result.blocked, []);
  assert.deepEqual(result.warnings, ['"Legacy" (topic-legacy) is an unclassified topic that the seed does not list; set its kind in Studio.']);
}

// 10. Fixture: the committed seed against the production snapshot.
const seed = JSON.parse(await readFile(new URL('./data/taxonomy.json', import.meta.url), 'utf8'));
{
  assert.deepEqual(taxonomyQueryParams(seed), {
    articleIds: ['article-poeaa-part-1-layering-and-domain-logic', 'article-ai-execution-environment-architecture'],
    slugs: ['architectural-patterns', 'domain-driven-design', 'agentic-workflows', 'distributed-systems', 'execution-environments'],
    draftIds: [
      'drafts.topic-architectural-patterns', 'drafts.topic-domain-driven-design', 'drafts.topic-agentic-workflows',
      'drafts.topic-distributed-systems', 'drafts.topic-execution-environments',
      'drafts.article-poeaa-part-1-layering-and-domain-logic', 'drafts.article-ai-execution-environment-architecture',
    ],
  });
  const result = plan(prodState, seed);
  assert.deepEqual(result.changes, [
    'update topic-architectural-patterns: kind',
    'update topic-domain-driven-design: kind',
    'update topic-agentic-workflows: kind',
    'update topic-distributed-systems: kind',
    'update topic-execution-environments: kind',
  ]);
  assert.deepEqual(result.warnings, []);
  assert.deepEqual(result.blocked, []);

  const after = apply(prodState, result);
  const topicById = new Map(after.topics.map((t) => [t._id, t]));
  const topics = after.topics.map((t) => {
    const parent = t.parent ? topicById.get(t.parent) : undefined;
    return {
      _id: t._id, _type: 'topic', title: t.title, slug: t.slug, kind: t.kind ?? undefined, summary: t.summary ?? '',
      order: t.order ?? undefined, featured: t.featured ?? undefined,
      parent: parent ? { _id: parent._id, title: parent.title, slug: parent.slug, kind: parent.kind ?? undefined } : undefined,
    };
  });
  const topicRef = (id) => {
    const t = topicById.get(id);
    return t ? { _id: t._id, title: t.title, slug: t.slug } : undefined;
  };
  const articles = prodArticles.map((a) => {
    const seeded = after.articles.find((x) => x._id === a._id);
    return {
      _id: a._id, _type: 'article', title: a.title, slug: a.slug, summary: '', publishedAt: a.publishedAt,
      featured: (seeded ?? a).featured ?? undefined,
      primaryTopic: topicRef((seeded ?? a).primaryTopic),
      relatedTopics: a.related.map(topicRef).filter(Boolean),
    };
  });

  const tree = buildTopicTree(topics, articles);
  assert.deepEqual(tree.excluded.map((e) => `${e.topic._id}: ${e.reason}`), [], 'the seeded taxonomy must exclude nothing');

  const popular = buildNavigation(tree, { articles });
  assert.deepEqual(popular.featured.map((f) => f.slug), ['ai-execution-environment-architecture']);
  assert.equal(popular.topics.mode, 'popular');
  const popularSlugs = popular.topics.topics.map((t) => t.slug);
  assert.ok(popularSlugs.includes('architectural-patterns'), 'Popular topics must list architectural-patterns');
  assert.ok(popularSlugs.includes('execution-environments'), 'Popular topics must list execution-environments');
  assert.ok(!popularSlugs.includes('agentic-workflows'), 'a topic with no articles is hidden from Popular topics');

  const platform = buildNavigation(tree, { articles, currentSlug: 'execution-environments', currentArticleSlug: 'ai-execution-environment-architecture' });
  assert.equal(platform.topics.mode, 'domain');
  assert.deepEqual(platform.topics.domain, { title: 'Platform Engineering', slug: 'platform-engineering' });
  assert.deepEqual(platform.topics.topics.map((t) => [t.slug, t.current]), [['execution-environments', true]]);
  assert.ok(platform.featured.find((f) => f.slug === 'ai-execution-environment-architecture').current);

  const softwareArch = buildNavigation(tree, { currentSlug: 'architectural-patterns' });
  assert.equal(softwareArch.topics.mode, 'domain');
  assert.deepEqual(softwareArch.topics.domain, { title: 'Software Architecture', slug: 'software-architecture' });
  assert.deepEqual(softwareArch.topics.topics.map((t) => t.slug), ['architectural-patterns', 'domain-driven-design', 'agentic-workflows']);
}

// 11. State assembly: drafts come from a separate raw-perspective query and reach the planner.
{
  const draftSeed = { topics: [newTopic('topic-d', 'domain-system-design', { title: 'Topic D', slug: 'd' })], articles: [{ _id: 'article-d', featured: true }] };
  const published = {
    topics: [...clone(domains), existingTopic('topic-d', 'd', 'domain-system-design', { title: 'Topic D', summary })],
    articles: [{ _id: 'article-d', featured: false, primaryTopic: null }],
    slugOwners: [],
  };
  const calls = [];
  const fakeFetch = async (query, params, options) => {
    calls.push({ query, params, options });
    if (query === TAXONOMY_STATE_QUERY) return clone(published);
    if (query === TAXONOMY_DRAFTS_QUERY) return options.perspective === 'raw' ? ['drafts.topic-d', 'drafts.article-d'] : [];
    throw new Error(`unexpected query ${query}`);
  };
  const state = await fetchTaxonomyState(fakeFetch, draftSeed);
  assert.deepEqual(calls.map((c) => [c.query, c.options.perspective]), [
    [TAXONOMY_STATE_QUERY, 'published'],
    [TAXONOMY_DRAFTS_QUERY, 'raw'],
  ]);
  assert.deepEqual(calls[0].params, { articleIds: ['article-d'], slugs: ['d'] });
  assert.deepEqual(calls[1].params, { draftIds: ['drafts.topic-d', 'drafts.article-d'] });
  assert.ok(!TAXONOMY_STATE_QUERY.includes('$draftIds'), 'the published query must not look for drafts');
  assert.deepEqual(state.drafts, ['drafts.topic-d', 'drafts.article-d']);
  const result = plan(state, draftSeed);
  assert.ok(result.warnings.some((w) => w.includes('draft values for topic-d')));
  assert.ok(result.warnings.some((w) => w.includes('draft values for article-d')));

  // Without a token the raw query sees no drafts, and no draft warnings appear.
  const anonymous = await fetchTaxonomyState(async (query) => (query === TAXONOMY_STATE_QUERY ? clone(published) : []), draftSeed);
  assert.deepEqual(anonymous.drafts, []);
  assert.ok(!plan(anonymous, draftSeed).warnings.some((w) => w.includes('draft values')));

  // mergeTaxonomyState keeps only drafts. ids and tolerates a null result.
  assert.deepEqual(mergeTaxonomyState(published, null).drafts, []);
  assert.deepEqual(mergeTaxonomyState(published, ['drafts.a', 'a', 7, 'drafts.a']).drafts, ['drafts.a']);
}

// 12. Safety: only createIfNotExists, or patches with set/setIfMissing; topics never use set.
{
  const topicIds = new Set();
  for (const { result, seed: planSeed } of allPlans) {
    const articleIds = new Set((planSeed.articles ?? []).map((a) => a?._id));
    for (const m of result.mutations) {
      if (m.createIfNotExists) {
        topicIds.add(m.createIfNotExists._id);
        continue;
      }
      assert.deepEqual(Object.keys(m), ['patch'], `unexpected mutation ${JSON.stringify(m)}`);
      const ops = Object.keys(m.patch).filter((k) => k !== 'id');
      assert.equal(ops.length, 1, 'one operation per patch');
      assert.ok(['set', 'setIfMissing'].includes(ops[0]), `unexpected patch operation ${ops[0]}`);
      if (ops[0] === 'set') {
        assert.ok(articleIds.has(m.patch.id), `only seeded articles may use set: ${m.patch.id}`);
        for (const key of Object.keys(m.patch.set)) assert.ok(['featured', 'primaryTopic'].includes(key), `article set may not touch ${key}`);
      }
    }
  }
  assert.ok(allPlans.length > 20);
}

console.log('taxonomy seed checks passed');
