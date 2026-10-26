import assert from 'node:assert/strict';
import { spawn } from 'node:child_process';
import { readFile } from 'node:fs/promises';
import { createClient } from '@sanity/client';
import {
  articleBySlugQuery,
  articlesQuery,
  articleSlugsQuery,
  featuredArticlesQuery,
  homepageQuery,
  latestContentQuery,
  projectBySlugQuery,
  projectsQuery,
  projectSlugsQuery,
  seriesBySlugQuery,
  seriesListQuery,
  seriesSlugsQuery,
  topicBySlugQuery,
  topicsListQuery,
  topicSlugsQuery,
  wikiNavQuery,
  workshopsQuery,
} from '../src/lib/sanity/queries.ts';
import { formatContentLabel, formatPageTitle, SITE_TITLE } from '../src/lib/content.ts';
import { extractHeadings } from '../src/lib/slugify.ts';
import { buildNavigation, buildTopicTree, getTopicBreadcrumbs, validateTopicHierarchy } from '../src/lib/topics.ts';
import { validateTopicParent } from '../sanity/schemaTypes/topic.ts';
import { MAX_TOPIC_ANCESTORS, topicPlacementError } from '../src/lib/taxonomy.ts';
import { DOMAIN_SEEDS, planDomainSeed } from './domains.ts';
import { queryFixtures } from '../src/lib/fixtures/index.ts';

const origin = 'http://127.0.0.1:4322';
const expectedPages = [
  { path: '/', file: 'dist/index.html', emptyText: 'Publication ready' },
  { path: '/workshops/', file: 'dist/workshops/index.html', emptyText: 'No published workshops yet' },
  { path: '/topics/', file: 'dist/topics/index.html', emptyText: 'No published topics yet' },
  { path: '/topics/system-design/', file: 'dist/topics/system-design/index.html', requiredText: 'System Design' },
  { path: '/topics/platform-engineering/', file: 'dist/topics/platform-engineering/index.html', requiredText: 'Platform Engineering' },
  { path: '/topics/ai-engineering/', file: 'dist/topics/ai-engineering/index.html', requiredText: 'AI Engineering' },
  { path: '/articles/', file: 'dist/articles/index.html', emptyText: 'No published articles yet' },
  { path: '/projects/', file: 'dist/projects/index.html', emptyText: 'No published projects yet' },
  { path: '/series/', file: 'dist/series/index.html', emptyText: 'No published series yet' },
  { path: '/404.html', file: 'dist/404.html', requiredText: 'That note isn’t here.' },
];

function assertPageMarkup(html, { path, emptyText, requiredText }) {
  assert.match(html, /<!doctype html>/i, `${path} must be an HTML document`);
  assert.match(html, /<html lang="en">/, `${path} must declare its language`);
  assert.match(html, /<meta name="viewport"/, `${path} must set a responsive viewport`);
  assert.match(html, /<meta name="description" content="[^"]+"/, `${path} must have a description`);
  assert.match(html, /<link rel="canonical" href="https:\/\/wiki\.eiakoji\.me\//, `${path} must have a production canonical URL`);
  assert.match(html, /<meta property="og:title"/, `${path} must have social title metadata`);
  assert.match(html, /class="skip-link" href="#main-content"/, `${path} must have skip navigation`);
  assert.match(html, /<main id="main-content">/, `${path} must expose the main landmark`);
  assert.match(html, /<nav[^>]*aria-label="Primary navigation"[^>]*>/, `${path} must label primary navigation`);
  assert.match(html, /<button[^>]*class="nav-toggle"[^>]*aria-expanded="false"[^>]*aria-controls="primary-nav-menu"/, `${path} must have an accessible mobile nav toggle`);
  assert.ok(!html.includes('Eiakoji wiki'), `${path} must not retain old Eiakoji wiki title`);
  assert.match(html, /<title>.*wiki\.eiakoji\.me<\/title>/, `${path} title must end with wiki.eiakoji.me`);

  for (const label of ['System Design', 'Platform Engineering', 'AI Engineering', 'Workshops', 'Projects']) {
    assert.ok(html.includes(label), `${path} must include the ${label} navigation item`);
  }
  for (const excluded of ['>Articles<', '>Series<', '>Writing<', '>Archetypes<']) {
    assert.ok(!html.includes(excluded), `${path} must not include ${excluded} in top-level navigation`);
  }
  assert.ok(html.includes('https://eiakoji.me'), `${path} must include the eiakoji.me return link in footer`);
  assert.ok(html.includes('src="/images/avatar.jpeg"'), `${path} must render the avatar brand image in header`);

  if (requiredText) {
    assert.ok(html.includes(requiredText), `${path} must render its expected recovery state`);
  } else {
    assert.ok(
      html.includes(emptyText) || html.includes('class="card-grid"') || html.includes('class="domains-container"') || html.includes('featured-grid'),
      `${path} must render either its empty state or published content`,
    );
  }
}

async function waitForServer(process, timeoutMs = 15_000) {
  const started = Date.now();
  while (Date.now() - started < timeoutMs) {
    if (process.exitCode !== null) throw new Error(`preview server exited with ${process.exitCode}`);
    try {
      const response = await fetch(`${origin}/`);
      if (response.ok) return;
    } catch {
      // The server is still starting.
    }
    await new Promise((resolve) => setTimeout(resolve, 200));
  }
  throw new Error('preview server did not start in time');
}

async function testBuiltSite() {
  const preview = spawn('./node_modules/.bin/astro', ['preview', '--host', '127.0.0.1', '--port', '4322'], {
    stdio: ['ignore', 'pipe', 'pipe'],
  });
  let logs = '';
  preview.stdout.on('data', (chunk) => { logs += chunk; });
  preview.stderr.on('data', (chunk) => { logs += chunk; });

  try {
    await waitForServer(preview);
    for (const page of expectedPages) {
      const builtHtml = await readFile(page.file, 'utf8').catch(() => {
        assert.fail(
          page.path.startsWith('/topics/') && page.path !== '/topics/'
            ? `${page.path} was not built: the domain is missing from the dataset. Run npm run seed:domains (see README).`
            : `${page.path} was not built (${page.file} is missing).`,
        );
      });
      assertPageMarkup(builtHtml, page);
      const response = await fetch(`${origin}${page.path}`);
      assert.equal(response.status, 200, `${page.path} must return HTTP 200`);
      assertPageMarkup(await response.text(), page);
    }

    const unknownArticle = await fetch(`${origin}/articles/not-a-real-slug/`);
    assert.equal(unknownArticle.status, 404, 'an unknown article slug must return HTTP 404');
    assert.ok((await unknownArticle.text()).includes('That note isn’t here.'), 'unknown slugs must use the recovery page');

    const unknownTopic = await fetch(`${origin}/topics/not-a-real-topic/`);
    assert.equal(unknownTopic.status, 404, 'an unknown topic slug must return HTTP 404');
    assert.ok((await unknownTopic.text()).includes('That note isn’t here.'), 'unknown topic slugs must use the recovery page');
  } finally {
    if (preview.exitCode === null) {
      preview.kill('SIGTERM');
      const exitPromise = new Promise((resolve) => preview.once('exit', resolve));
      const timeout = new Promise((resolve) => setTimeout(() => {
        if (preview.exitCode === null) {
          try { preview.kill('SIGKILL'); } catch { /* ignore */ }
        }
        resolve();
      }, 3000));
      await Promise.race([exitPromise, timeout]);
    }
  }

  assert.ok(!logs.includes('[ERROR]'), `preview server logged an error:\n${logs}`);
}

async function testSanityQueries() {
  const requiredPublicFilter = '!(_id in path("drafts.**")) && defined(slug.current)';
  for (const query of [latestContentQuery, articlesQuery, projectsQuery, seriesListQuery, topicsListQuery]) {
    assert.ok(query.includes(requiredPublicFilter), 'public list queries must exclude drafts and require slugs');
  }
  for (const query of [latestContentQuery, articlesQuery, projectsQuery, articleBySlugQuery, projectBySlugQuery, seriesBySlugQuery]) {
    assert.ok(query.includes('publishedAt <= now()'), 'published article/project queries must exclude future content');
  }

  for (const query of [topicsListQuery, topicBySlugQuery, wikiNavQuery]) {
    assert.match(query, /"slug": slug\.current,\n\s+kind,/, 'topic queries must project kind');
  }
  for (const domain of ['system-design', 'platform-engineering', 'ai-engineering']) {
    assert.ok(homepageQuery.includes(`kind == "domain" && slug.current == "${domain}"`), `homepage must select the ${domain} domain by kind`);
  }
  for (const alias of ['systems-design', 'cloud-platform', '"cloud"', 'ai-systems', '"ai"', 'multi-agent-systems']) {
    assert.ok(!homepageQuery.includes(alias), `homepage must not match legacy domain alias ${alias}`);
  }

  assert.ok(
    articleBySlugQuery.includes('"series": *[_type == "series" && ^._id in articles[]._ref'),
    'article detail query must resolve series via reverse lookup from series.articles',
  );

  const client = createClient({
    projectId: '7rp2puan',
    dataset: 'production',
    apiVersion: '2026-10-01',
    useCdn: false,
  });

  const listQueries = [
    latestContentQuery,
    articlesQuery,
    projectsQuery,
    seriesListQuery,
    articleSlugsQuery,
    projectSlugsQuery,
    seriesSlugsQuery,
    topicSlugsQuery,
    topicsListQuery,
    workshopsQuery,
    featuredArticlesQuery,
  ];
  for (const query of listQueries) {
    const result = await client.fetch(query);
    assert.ok(Array.isArray(result), 'list and slug queries must return arrays');
  }

  for (const query of [articleBySlugQuery, projectBySlugQuery, seriesBySlugQuery, topicBySlugQuery]) {
    const result = await client.fetch(query, { slug: 'not-a-real-slug' });
    assert.equal(result, null, 'unknown detail queries must resolve to null');
  }

  assert.ok(
    seriesBySlugQuery.includes('"articles": coalesce(') && seriesBySlugQuery.includes('[]'),
    'series detail queries must return an empty article array when the field is missing',
  );

  const navResult = await client.fetch(wikiNavQuery);
  assert.ok(navResult && typeof navResult === 'object', 'wikiNavQuery must return an object');
  assert.ok(Array.isArray(navResult.topics), 'wikiNavQuery topics must be an array');
  assert.ok(Array.isArray(navResult.series), 'wikiNavQuery series must be an array');
  assert.ok(Array.isArray(navResult.articles), 'wikiNavQuery articles must be an array');

  const homeResult = await client.fetch(homepageQuery);
  assert.ok(homeResult && typeof homeResult === 'object', 'homepageQuery must return an object');
  assert.ok(Array.isArray(homeResult.featured), 'homepageQuery featured must be an array');
  assert.ok(Array.isArray(homeResult.latest), 'homepageQuery latest must be an array');
  assert.ok(Array.isArray(homeResult.workshops), 'homepageQuery workshops must be an array');
}

async function testUnitBehaviors() {
  // 1. Test Heading ID uniqueness and duplicate disambiguation
  const mockBody = [
    { _type: 'block', _key: 'k1', style: 'h2', children: [{ text: 'Overview' }] },
    { _type: 'block', _key: 'k2', style: 'h2', children: [{ text: 'Overview' }] },
    { _type: 'block', _key: 'k3', style: 'h3', children: [{ text: 'Next Steps & Actions!' }] },
  ];
  const headings = extractHeadings(mockBody);
  assert.equal(headings.length, 3, 'all headings must be extracted');
  assert.equal(headings[0].slug, 'overview', 'first heading slug must be overview');
  assert.equal(headings[1].slug, 'overview-1', 'duplicate heading slug must receive unique index suffix');
  assert.equal(headings[2].slug, 'next-steps-actions', 'symbols should be cleanly normalized');

  // 2. Test Multi-Document Cycle Detection and Validation Gate
  const multiHopCycleTopics = [
    { _id: 't-a', _type: 'topic', title: 'Topic A', slug: 'topic-a', parent: { _id: 't-b', title: 'Topic B', slug: 'topic-b' } },
    { _id: 't-b', _type: 'topic', title: 'Topic B', slug: 'topic-b', parent: { _id: 't-c', title: 'Topic C', slug: 'topic-c' } },
    { _id: 't-c', _type: 'topic', title: 'Topic C', slug: 'topic-c', parent: { _id: 't-a', title: 'Topic A', slug: 'topic-a' } },
  ];
  const validationResult = validateTopicHierarchy(multiHopCycleTopics);
  assert.equal(validationResult.valid, false, 'validateTopicHierarchy must reject multi-document circular references');
  assert.ok(
    validationResult.errors.some((err) => err.includes('Circular parent reference detected')),
    'validation errors must report circular reference',
  );

  // Verify the runtime tree builder excludes cycle members instead of promoting them to roots
  const cycleTree = buildTopicTree(multiHopCycleTopics.map((t) => ({ ...t, kind: 'topic' })));
  assert.equal(cycleTree.rootTopics.length, 0, 'cycle members must not become roots');
  assert.deepEqual(cycleTree.excluded.map((e) => e.topic._id).sort(), ['t-a', 't-b', 't-c'], 'cycle members must be excluded');
  assert.ok(cycleTree.excluded.every((e) => e.reason.includes('Circular')), 'cycle exclusions must explain the cycle');

  // 3. Test Rollup Deduplication (prevent double counting an article in primary + related topics)
  const hierarchyTopics = [
    { _id: 't-root', _type: 'topic', kind: 'domain', title: 'Architecture', slug: 'architecture', summary: 'Root domain' },
    { _id: 't-child', _type: 'topic', kind: 'topic', title: 'Distributed Systems', slug: 'distributed-systems', summary: 'Subtopic', parent: { _id: 't-root', title: 'Architecture', slug: 'architecture' } },
    { _id: 't-leaf', _type: 'topic', kind: 'topic', title: 'Consensus', slug: 'consensus', summary: 'Leaf topic', parent: { _id: 't-child', title: 'Distributed Systems', slug: 'distributed-systems' } },
  ];

  // Article assigned to Leaf as primary AND Parent as related
  const mockArticles = [
    {
      _id: 'a1',
      _type: 'article',
      title: 'Raft Consensus',
      slug: 'raft-consensus',
      summary: 'Summary',
      primaryTopic: { _id: 't-leaf', title: 'Consensus', slug: 'consensus' },
      relatedTopics: [{ _id: 't-child', title: 'Distributed Systems', slug: 'distributed-systems' }],
    },
  ];

  const tree = buildTopicTree(hierarchyTopics, mockArticles);
  const rootNode = tree.nodeMap.get('t-root');
  const childNode = tree.nodeMap.get('t-child');
  const leafNode = tree.nodeMap.get('t-leaf');

  assert.ok(rootNode && childNode && leafNode, 'all nodes must exist in tree');
  assert.equal(leafNode.directArticleCount, 1, 'leaf direct count must equal 1');
  assert.equal(childNode.directArticleCount, 1, 'child direct count must equal 1 via related topic');
  // Child rollup should be 1 (union of a1, NOT 2)
  assert.equal(childNode.rollupArticleCount, 1, 'child rollup must union article IDs without double counting');
  // Root rollup should be 1 (union of a1, NOT 2)
  assert.equal(rootNode.rollupArticleCount, 1, 'root rollup must union all descendant article IDs without double counting');

  // Verify article array filter matches rollupArticleCount exactly
  const matchedForRoot = mockArticles.filter((a) => rootNode.rollupArticleIds.has(a._id));
  assert.equal(matchedForRoot.length, rootNode.rollupArticleCount, 'topic hub listing and count must agree');

  // 4. Test Draft-prioritized cycle detection
  const publishedAndDraftTopics = [
    { _id: 't-1', _type: 'topic', title: 'Topic 1', slug: 't-1', parent: { _id: 't-2', title: 'Topic 2', slug: 't-2' } },
    { _id: 't-2', _type: 'topic', title: 'Topic 2', slug: 't-2', parent: { _id: 't-3', title: 'Topic 3', slug: 't-3' } },
    { _id: 't-3', _type: 'topic', title: 'Topic 3', slug: 't-3' }, // published doc is root, no cycle
    { _id: 'drafts.t-3', _type: 'topic', title: 'Topic 3 Draft', slug: 't-3', parent: { _id: 't-1', title: 'Topic 1', slug: 't-1' } }, // draft introduces cycle
  ];
  const draftValidation = validateTopicHierarchy(publishedAndDraftTopics);
  assert.equal(draftValidation.valid, false, 'validateTopicHierarchy must prioritize draft and detect circular parent cycle');
  assert.ok(
    draftValidation.errors.some((err) => err.includes('Circular parent reference detected')),
    'draft cycle must be flagged in validation errors',
  );

  // 5. Test 4-level deep hierarchy and breadcrumbs
  const fourLevelTopics = [
    { _id: 'l1', _type: 'topic', kind: 'domain', title: 'Engineering', slug: 'engineering' },
    { _id: 'l2', _type: 'topic', kind: 'topic', title: 'Distributed Systems', slug: 'distributed-systems', parent: { _id: 'l1', title: 'Engineering', slug: 'engineering' } },
    { _id: 'l3', _type: 'topic', kind: 'topic', title: 'Storage Engines', slug: 'storage-engines', parent: { _id: 'l2', title: 'Distributed Systems', slug: 'distributed-systems' } },
    { _id: 'l4', _type: 'topic', kind: 'topic', title: 'LSM Trees', slug: 'lsm-trees', parent: { _id: 'l3', title: 'Storage Engines', slug: 'storage-engines' } },
  ];
  const fourLevelTree = buildTopicTree(fourLevelTopics);
  const crumbs = getTopicBreadcrumbs('lsm-trees', fourLevelTree);
  assert.equal(crumbs.length, 5, 'breadcrumbs must trace Topics -> Engineering -> Distributed Systems -> Storage Engines -> LSM Trees');
  assert.equal(crumbs[0].label, 'Topics');
  assert.equal(crumbs[1].label, 'Engineering');
  assert.equal(crumbs[2].label, 'Distributed Systems');
  assert.equal(crumbs[3].label, 'Storage Engines');
  assert.equal(crumbs[4].label, 'LSM Trees');

  // 5b. Domain-rooted tree: only domains are roots, ordering, exclusions, and navigation groups
  const ref = (id) => ({ _id: id, title: id, slug: id });
  const taxonomy = [
    { _id: 'd-ai', _type: 'topic', kind: 'domain', title: 'AI Engineering', slug: 'ai-engineering', order: 3 },
    { _id: 'd-sd', _type: 'topic', kind: 'domain', title: 'System Design', slug: 'system-design', order: 1 },
    { _id: 'd-pe', _type: 'topic', kind: 'domain', title: 'Platform Engineering', slug: 'platform-engineering', order: 2 },
    { _id: 't-z', _type: 'topic', kind: 'topic', title: 'Zookeeper', slug: 'zookeeper', parent: ref('d-sd') },
    { _id: 't-c', _type: 'topic', kind: 'topic', title: 'Caching', slug: 'caching', parent: ref('d-sd'), order: 1 },
    { _id: 't-b', _type: 'topic', kind: 'topic', title: 'Batching', slug: 'batching', parent: ref('d-sd'), order: 1 },
    { _id: 't-deep', _type: 'topic', kind: 'topic', title: 'Write-through', slug: 'write-through', parent: ref('t-c') },
    { _id: 'legacy', _type: 'topic', title: 'Legacy Root', slug: 'legacy-root' },
    { _id: 't-orphan', _type: 'topic', kind: 'topic', title: 'Orphan', slug: 'orphan', parent: ref('missing') },
    { _id: 't-under-legacy', _type: 'topic', kind: 'topic', title: 'Under Legacy', slug: 'under-legacy', parent: ref('legacy') },
    { _id: 'd-bad', _type: 'topic', kind: 'domain', title: 'Nested Domain', slug: 'nested-domain', parent: ref('d-sd') },
    { _id: 't-under-bad', _type: 'topic', kind: 'topic', title: 'Under Nested Domain', slug: 'under-nested-domain', parent: ref('d-bad') },
  ];
  const domainTree = buildTopicTree(taxonomy, [
    { _id: 'a-1', _type: 'article', title: 'A', slug: 'a', summary: 's', primaryTopic: ref('t-deep') },
  ]);
  assert.deepEqual(domainTree.rootTopics.map((n) => n.topic.slug), ['system-design', 'platform-engineering', 'ai-engineering'], 'roots must be domains ordered by order');
  assert.deepEqual(
    domainTree.nodeMap.get('d-sd').children.map((n) => n.topic.slug),
    ['batching', 'caching', 'zookeeper'],
    'children must be ordered by order, then title',
  );
  assert.deepEqual(
    domainTree.excluded.map((e) => e.topic._id).sort(),
    ['d-bad', 'legacy', 't-orphan', 't-under-bad', 't-under-legacy'],
    'unclassified, orphaned, and misplaced topics must be excluded',
  );
  assert.ok(!domainTree.slugMap.has('legacy-root'), 'excluded topics must not be routable through the tree');
  assert.equal(domainTree.nodeMap.get('d-sd').rollupArticleCount, 1, 'domain rollups must include nested topic articles');
  assert.deepEqual(
    getTopicBreadcrumbs('write-through', domainTree).map((c) => c.label),
    ['Topics', 'System Design', 'Caching', 'Write-through'],
    'breadcrumbs must follow the domain tree',
  );
  const domainValidation = validateTopicHierarchy(taxonomy);
  for (const expected of ['Legacy Root', 'Nested Domain', 'Under Legacy']) {
    assert.ok(domainValidation.errors.some((err) => err.includes(expected)), `validateTopicHierarchy must report ${expected}`);
  }

  const nav = buildNavigation(domainTree, 'articles');
  assert.equal(nav.domains, domainTree.rootTopics, 'navigation must start from the domain tree');
  assert.deepEqual(nav.browse.map((l) => l.href), ['/topics/', '/articles/', '/series/'], 'browse links must not include projects');
  assert.deepEqual(nav.browse.map((l) => l.active), [false, true, false], 'the current browse destination must be active');
  assert.equal(buildNavigation(buildTopicTree([])).domains.length, 0, 'an empty taxonomy must yield no domains');

  // 6. Test validateTopicParent in Studio schema validation (including failure and error paths)
  const selfRefResult = await validateTopicParent({ _ref: 't-self' }, { document: { _id: 't-self' } });
  assert.equal(selfRefResult, 'A topic cannot reference itself as its parent.');

  // Transient query error must NOT fail open
  const failingContext = {
    document: { _id: 't-child' },
    getClient: () => ({
      fetch: async () => {
        throw new Error('Sanity API connection timeout');
      },
    }),
  };
  const failResult = await validateTopicParent({ _ref: 't-parent' }, failingContext);
  assert.ok(
    typeof failResult === 'string' && failResult.includes('Sanity API connection timeout'),
    'validateTopicParent must report query failure rather than failing open',
  );

  // Multi-hop cycle via client lookup
  const cycleContext = {
    document: { _id: 't-a', kind: 'topic' },
    getClient: () => ({
      fetch: async (_query, params) => {
        if (params?.id === 't-b') return { parent: { _ref: 't-a' } };
        return null;
      },
    }),
  };
  const cycleValResult = await validateTopicParent({ _ref: 't-b' }, cycleContext);
  assert.equal(cycleValResult, 'Circular parent reference detected in topic hierarchy.');

  // Valid acyclic hierarchy passes
  const validContext = {
    document: { _id: 't-leaf', kind: 'topic' },
    getClient: () => ({
      fetch: async () => ({ parent: undefined, kind: 'domain' }),
    }),
  };
  const successResult = await validateTopicParent({ _ref: 't-root' }, validContext);
  assert.equal(successResult, true, 'valid hierarchy must pass validation');

  // Kind rules in Studio validation: ancestors are looked up draft-first with their kind
  const chainContext = (kind, chain) => ({
    document: { _id: 't-new', kind },
    getClient: () => ({
      fetch: async (query, params) => {
        assert.ok(query.includes('{ parent, kind }'), 'ancestor lookup must project kind');
        return chain[params.id] ?? null;
      },
    }),
  });
  const domainChain = {
    'd-1': { kind: 'domain' },
    't-1': { kind: 'topic', parent: { _ref: 'd-1' } },
    't-2': { kind: 'topic', parent: { _ref: 't-1' } },
    't-3': { kind: 'topic', parent: { _ref: 't-2' } },
    't-4': { kind: 'topic', parent: { _ref: 't-3' } },
    'orphan': { kind: 'topic' },
    'legacy-root': {},
  };
  assert.equal(await validateTopicParent(undefined, { document: { _id: 'd-new', kind: 'domain' } }), true, 'a domain without a parent is valid');
  assert.equal(await validateTopicParent({ _ref: 'd-1' }, chainContext('domain', domainChain)), 'A domain cannot have a parent.');
  assert.equal(await validateTopicParent(undefined, { document: { _id: 't-new', kind: 'topic' } }), 'A topic must have a parent topic or domain.');
  assert.equal(await validateTopicParent(undefined, { document: { _id: 't-new' } }), 'Choose whether this is a Domain or a Topic.');
  assert.equal(await validateTopicParent({ _ref: 'd-1' }, chainContext('topic', domainChain)), true, 'a topic directly under a domain is valid');
  assert.equal(await validateTopicParent({ _ref: 't-3' }, chainContext('topic', domainChain)), true, 'a topic with four ancestors is valid');
  assert.equal(
    await validateTopicParent({ _ref: 't-4' }, chainContext('topic', domainChain)),
    `Topic hierarchy exceeds maximum supported depth of ${MAX_TOPIC_ANCESTORS} levels.`,
  );
  assert.equal(await validateTopicParent({ _ref: 'orphan' }, chainContext('topic', domainChain)), 'A topic must sit under a domain.');
  assert.equal(await validateTopicParent({ _ref: 'legacy-root' }, chainContext('topic', domainChain)), 'A topic must sit under a domain.');

  // Pure placement rules
  assert.equal(topicPlacementError({ kind: 'domain', hasParent: false, ancestorKinds: [] }), null);
  assert.equal(topicPlacementError({ kind: 'topic', hasParent: true, ancestorKinds: ['domain'] }), null);
  assert.equal(topicPlacementError({ kind: 'topic', hasParent: true, ancestorKinds: ['topic', 'domain'], cycle: true }), 'Circular parent reference detected in topic hierarchy.');
  assert.equal(topicPlacementError({ kind: 'topic', hasParent: true, ancestorKinds: ['topic', 'topic'] }), 'A topic must sit under a domain.');
  assert.equal(topicPlacementError({ kind: 'area', hasParent: false, ancestorKinds: [] }), 'Choose whether this is a Domain or a Topic.');

  // 6b. Domain seed planning is idempotent, preserves editor summaries, and never deletes
  const applySeed = (docs, plan) => {
    const store = new Map(docs.map((doc) => [doc._id, { ...doc }]));
    for (const mutation of plan.mutations) {
      if (mutation.createIfNotExists) {
        const { slug, ...rest } = mutation.createIfNotExists;
        if (!store.has(rest._id)) store.set(rest._id, { ...rest, slug: slug.current, hasParent: false });
      } else {
        const { id, set } = mutation.patch;
        const next = { ...store.get(id), ...set };
        if (set.slug) next.slug = set.slug.current;
        store.set(id, next);
      }
    }
    return [...store.values()];
  };
  const firstPlan = planDomainSeed([]);
  assert.ok(firstPlan.mutations.every((m) => 'createIfNotExists' in m || 'patch' in m), 'the seed may only create or patch');
  assert.equal(firstPlan.mutations.length, 3, 'an empty dataset must plan three domain creates');
  assert.deepEqual(
    firstPlan.mutations.map((m) => m.createIfNotExists._id),
    ['domain-system-design', 'domain-platform-engineering', 'domain-ai-engineering'],
  );
  assert.ok(firstPlan.mutations.every((m) => m.createIfNotExists.kind === 'domain'), 'seeded documents must be domains');
  const seeded = applySeed([], firstPlan);
  assert.equal(planDomainSeed(seeded).mutations.length, 0, 'a second seed run must plan no changes');

  const edited = seeded.map((doc) =>
    doc._id === 'domain-system-design' ? { ...doc, title: 'Systems', summary: 'Written by an editor in Studio.' } : doc,
  );
  const repairPlan = planDomainSeed(edited);
  assert.deepEqual(repairPlan.mutations, [{ patch: { id: 'domain-system-design', set: { title: 'System Design' } } }], 'only drifted canonical fields may be patched');
  assert.equal(
    applySeed(edited, repairPlan).find((doc) => doc._id === 'domain-system-design').summary,
    'Written by an editor in Studio.',
    'the seed must not replace an editor-written summary',
  );

  const legacy = [
    { _id: 'legacy-sd', title: 'System Design (old)', slug: 'system-design' },
    { _id: 'legacy-root', title: 'Languages', slug: 'languages' },
  ];
  const legacyPlan = planDomainSeed(legacy);
  assert.equal(legacyPlan.mutations.length, 2, 'a slug already in use must not be seeded twice');
  assert.ok(legacyPlan.warnings.some((w) => w.includes('legacy-sd') && w.includes('system-design')), 'slug conflicts must be reported');
  assert.ok(legacyPlan.warnings.some((w) => w.includes('legacy-root') && w.includes('unclassified')), 'unclassified roots must be reported');
  assert.equal(DOMAIN_SEEDS.length, 3);

  // 6c. The real queries, run against the full fixture, drive the same tree
  const fixtureTopics = await queryFixtures('full', topicsListQuery);
  assert.ok(fixtureTopics.every((t) => t.kind || t.slug === 'languages'), 'topicsListQuery must project kind');
  assert.ok(!fixtureTopics.some((t) => t.slug === 'draft-only'), 'topic queries must exclude drafts');
  const fixtureArticles = await queryFixtures('full', articlesQuery);
  assert.ok(!fixtureArticles.some((a) => a.slug === 'future-post'), 'article queries must exclude future content');
  const fixtureTree = buildTopicTree(fixtureTopics, fixtureArticles);
  assert.deepEqual(fixtureTree.rootTopics.map((n) => n.topic.slug), ['system-design', 'platform-engineering', 'ai-engineering']);
  assert.equal(fixtureTree.slugMap.get('system-design').rollupArticleCount, 2, 'domain rollups must count nested articles once');
  assert.deepEqual(fixtureTree.excluded.map((e) => e.topic.slug), ['languages']);
  const fixtureHome = await queryFixtures('full', homepageQuery);
  assert.equal(fixtureHome.platformTopic?.slug, 'platform-engineering', 'homepage must find domains by kind');
  assert.equal((await queryFixtures('empty', wikiNavQuery)).topics.length, 0);
  await assert.rejects(queryFixtures('staging', topicsListQuery), /Unknown WIKI_FIXTURES/);

  // Filtering a dereferenced array must filter the array, not each element
  const fixtureArticle = await queryFixtures('full', articleBySlugQuery, { slug: 'raft-log-replication' });
  assert.deepEqual(fixtureArticle.series.articles.map((a) => a?.slug), ['raft-log-replication'], 'article series must list published articles');
  const fixtureSeries = await queryFixtures('full', seriesListQuery);
  assert.equal(fixtureSeries[0].publishedArticleCount, 1, 'series counts must count published articles');
  assert.deepEqual(
    (await queryFixtures('full', seriesBySlugQuery, { slug: 'consensus-from-scratch' })).articles.map((a) => a?.slug),
    ['raft-log-replication'],
  );

  // 7. Test formatContentLabel formatting
  assert.equal(formatContentLabel('case-study'), 'Case Study');
  assert.equal(formatContentLabel('reading-note'), 'Reading Note');
  assert.equal(formatContentLabel('reading-notes'), 'Reading Note');
  assert.equal(formatContentLabel('deep-dive'), 'Deep Dive');
  assert.equal(formatContentLabel('tutorial'), 'Tutorial');
  assert.equal(formatContentLabel('workshop'), 'Workshop');
  assert.equal(formatContentLabel('showcase'), 'Showcase');
  assert.equal(formatContentLabel('reference'), 'Reference');
  assert.equal(formatContentLabel(undefined, 'series'), 'Series');
  assert.equal(formatContentLabel(undefined, 'project'), 'Case Study');
  assert.equal(formatContentLabel(undefined, 'article'), 'Article');
  assert.equal(formatContentLabel('custom-type'), 'Custom Type');

  // 8. Test formatPageTitle and SITE_TITLE
  assert.equal(SITE_TITLE, 'wiki.eiakoji.me');
  assert.equal(formatPageTitle('Workshops'), 'Workshops · wiki.eiakoji.me');
  assert.equal(formatPageTitle('System Design'), 'System Design · wiki.eiakoji.me');
  assert.equal(formatPageTitle(), 'wiki.eiakoji.me');

  // 9. Test deduplication for System Design / Archetypes
  const mockArchetypes = [
    { _id: 'art-1', title: 'Write-Ahead Log' },
    { _id: 'art-2', title: 'Event Sourcing' },
  ];
  const mockSystemDesign = [
    { _id: 'art-1', title: 'Write-Ahead Log' }, // Assigned to both archetypes and system design
    { _id: 'art-3', title: 'Raft Consensus' },
  ];
  const seenIds = new Set();
  const dedupedArticles = [...mockArchetypes, ...mockSystemDesign].filter((item) => {
    if (!item?._id || seenIds.has(item._id)) return false;
    seenIds.add(item._id);
    return true;
  });
  assert.equal(dedupedArticles.length, 3, 'deduplication must eliminate duplicate article IDs');
  assert.deepEqual(dedupedArticles.map((a) => a._id), ['art-1', 'art-2', 'art-3']);
}

async function testConfiguration() {
  const [styles, netlify, ignore, envExample, readme, articleSchema, projectSchema, seriesSchema, imageSchema, topicSchema, tocComponent, topicsIndexPage, leftNavComponent, wikiLayout] = await Promise.all([
    readFile('src/styles/global.css', 'utf8'),
    readFile('netlify.toml', 'utf8'),
    readFile('.gitignore', 'utf8'),
    readFile('.env.example', 'utf8'),
    readFile('README.md', 'utf8'),
    readFile('sanity/schemaTypes/article.ts', 'utf8'),
    readFile('sanity/schemaTypes/project.ts', 'utf8'),
    readFile('sanity/schemaTypes/series.ts', 'utf8'),
    readFile('sanity/schemaTypes/imageWithAlt.ts', 'utf8'),
    readFile('sanity/schemaTypes/topic.ts', 'utf8'),
    readFile('src/components/TableOfContents.astro', 'utf8'),
    readFile('src/pages/topics/index.astro', 'utf8'),
    readFile('src/components/LeftNav.astro', 'utf8'),
    readFile('src/layouts/WikiLayout.astro', 'utf8'),
  ]);

  assert.match(styles, /@media \(max-width: 820px\)/, 'styles must include the 820px mobile nav breakpoint');
  assert.match(styles, /@media \(max-width: 720px\)/, 'styles must include a small-screen layout');
  assert.ok(styles.includes('.nav-toggle'), 'styles must include .nav-toggle rules');
  assert.ok(!/outline\s*:\s*none/.test(styles), 'styles must not suppress keyboard focus outlines');
  assert.match(netlify, /command = "npm run build"/, 'Netlify must use the production build command');
  assert.match(netlify, /publish = "dist"/, 'Netlify must publish dist');
  for (const ignored of ['.env', '.netlify', 'dist/', '.sanity-dist/']) {
    assert.ok(ignore.includes(ignored), `${ignored} must be ignored`);
  }
  assert.ok(envExample.includes('PUBLIC_SANITY_PROJECT_ID=7rp2puan'), 'the public project ID must be documented');
  assert.ok(envExample.includes('PUBLIC_SANITY_DATASET=production'), 'the public dataset must be documented');
  for (const section of ['Local setup', 'Content authoring', 'Netlify preparation', 'Verification']) {
    assert.ok(readme.includes(section), `README must document ${section}`);
  }
  for (const field of ['slug', 'summary', 'publishedAt', 'featuredImage', 'body', 'series', 'format', 'primaryTopic', 'featured']) {
    assert.ok(articleSchema.includes(`name: '${field}'`), `article schema must define ${field}`);
  }
  for (const field of ['kind', 'slug', 'summary', 'parent', 'order']) {
    assert.ok(topicSchema.includes(`name: '${field}'`), `topic schema must define ${field}`);
  }
  assert.ok(
    topicSchema.includes('cycle = true') && topicSchema.includes('topicPlacementError'),
    'topic schema must implement ancestor cycle validation through the shared placement rules',
  );
  assert.ok(
    topicSchema.includes('coalesce(*[_id == "drafts." + $id][0], *[_id == $id][0])'),
    'topic schema must prioritize drafts over published documents during cycle check',
  );
  assert.ok(
    tocComponent.includes('display: flex') && tocComponent.includes('flex-direction: column'),
    'TableOfContents .toc-list must enforce vertical column display to override global nav ul',
  );
  assert.ok(
    topicsIndexPage.includes('buildTopicTree(topics, articles)'),
    'topics index must pass articles to buildTopicTree for deduplicated rollups',
  );
  assert.ok(
    wikiLayout.includes("buildTopicTree(navData?.topics ?? [], navData?.articles ?? [])"),
    'WikiLayout must pass articles to buildTopicTree for deduplicated rollups',
  );
  assert.ok(wikiLayout.includes('tree={navTree}'), 'WikiLayout must pass the shared tree to LeftNav');
  for (const file of ['netlify.toml', '.env.example', '.github/workflows/ci.yml', 'package.json']) {
    assert.ok(!(await readFile(file, 'utf8')).includes('WIKI_FIXTURES'), `${file} must not enable fixture content`);
  }
  for (const file of ['src/lib/content.ts', 'src/pages/topics/index.astro', 'src/pages/topics/[slug].astro']) {
    assert.ok(!(await readFile(file, 'utf8')).includes('CORE_DOMAIN_TOPICS'), `${file} must not keep reader-side domain fallbacks`);
  }
  assert.ok(leftNavComponent.includes('buildNavigation(tree, currentSlug)'), 'LeftNav must render from buildNavigation');
  assert.ok(!leftNavComponent.includes('Sections') && !leftNavComponent.includes('/projects/'), 'LeftNav must not keep the Sections block or a Projects link');
  assert.ok(
    leftNavComponent.indexOf('Domains') < leftNavComponent.indexOf('Browse'),
    'LeftNav must list domains before the Browse group',
  );
  for (const field of ['slug', 'summary', 'publishedAt', 'featuredImage', 'body', 'repositoryUrl', 'projectUrl']) {
    assert.ok(projectSchema.includes(`name: '${field}'`), `project schema must define ${field}`);
  }
  assert.ok(seriesSchema.includes("name: 'articles'"), 'series schema must define its ordered articles');
  assert.ok(seriesSchema.includes("type: 'reference'"), 'series articles must use references');
  assert.ok(imageSchema.includes("name: 'alt'"), 'images must define alternative text');
  assert.ok(imageSchema.includes('rule.required()'), 'image alternative text must be required');
}

await testUnitBehaviors();
await testConfiguration();
await testSanityQueries();
await testBuiltSite();
console.log('publication integration checks passed');
process.exit(0);
