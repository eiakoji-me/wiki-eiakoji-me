import assert from 'node:assert/strict';
import { spawn } from 'node:child_process';
import { readdir, readFile, stat } from 'node:fs/promises';
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
  topicBySlugQuery,
  topicsListQuery,
  topicSlugsQuery,
  wikiNavQuery,
  workshopsQuery,
} from '../src/lib/sanity/queries.ts';
import * as queriesModule from '../src/lib/sanity/queries.ts';
import { contentHref, formatPageTitle, showRepositoryLink, SITE_TITLE } from '../src/lib/content.ts';
import { extractHeadings } from '../src/lib/slugify.ts';
import * as topicsModule from '../src/lib/topics.ts';
import { buildNavigation, buildTopicTree, getTopicBreadcrumbs, topicHref, validateTopicHierarchy } from '../src/lib/topics.ts';
import { validateTopicParent } from '../sanity/schemaTypes/topic.ts';
import { MAX_TOPIC_ANCESTORS, topicPlacementError } from '../src/lib/taxonomy.ts';
import { DOMAIN_SEEDS, planDomainSeed } from './domains.ts';
import { queryFixtures } from '../src/lib/fixtures/index.ts';

const origin = 'http://127.0.0.1:4322';
const expectedPages = [
  { path: '/', file: 'dist/index.html', emptyText: 'Publication ready' },
  { path: '/workshops/', file: 'dist/workshops/index.html', emptyText: 'No published workshops yet' },
  { path: '/topics/', file: 'dist/topics/index.html', emptyText: 'No published topics yet' },
  { path: '/topics/software-architecture/', file: 'dist/topics/software-architecture/index.html', requiredText: 'Software Architecture' },
  { path: '/topics/system-design/', file: 'dist/topics/system-design/index.html', requiredText: 'System Design' },
  { path: '/topics/platform-engineering/', file: 'dist/topics/platform-engineering/index.html', requiredText: 'Platform Engineering' },
  { path: '/articles/', file: 'dist/articles/index.html', emptyText: 'No published articles yet' },
  { path: '/projects/', file: 'dist/projects/index.html', emptyText: 'No published projects yet' },
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

  for (const label of ['Software Architecture', 'System Design', 'Platform Engineering', 'Workshops', 'Projects']) {
    assert.ok(html.includes(label), `${path} must include the ${label} navigation item`);
  }
  const primaryNav = html.match(/<nav[^>]*aria-label="Primary navigation"[^>]*>[\s\S]*?<\/nav>/)?.[0] ?? '';
  assert.ok(primaryNav.includes('System Design'), `${path} primary navigation must be found to check its items`);
  for (const excluded of ['>Articles<', '>Series<', '>Writing<', '>Archetypes<']) {
    assert.ok(!primaryNav.includes(excluded), `${path} must not include ${excluded} in top-level navigation`);
  }
  assert.ok(html.includes('https://eiakoji.me'), `${path} must include the eiakoji.me return link in footer`);
  assert.ok(!html.includes('href="/series/'), `${path} must not link to retired /series/ pages`);
  const leftNav = html.match(/<aside[^>]*class="wiki-left-nav[^"]*"[\s\S]*?<\/aside>/)?.[0];
  // The homepage and 404 use BaseLayout and have no left nav; every WikiLayout page renders it.
  if (!['/', '/404.html'].includes(path)) {
    assert.ok(leftNav, `${path} must render the left nav`);
  }
  if (leftNav) {
    for (const removed of ['Browse', 'Curated Series', 'href="/articles/"', 'href="/series/"']) {
      assert.ok(!leftNav.includes(removed), `${path} left nav must not contain ${removed}`);
    }
    // The top nav already links the domains; the left nav must not repeat them.
    for (const domain of ['software-architecture', 'system-design', 'platform-engineering']) {
      assert.ok(!leftNav.includes(`href="/topics/${domain}/"`), `${path} left nav must not link the ${domain} domain`);
    }
    assert.ok(leftNav.includes('Featured &amp; Topics') || leftNav.includes('Featured & Topics'), `${path} left nav disclosure must be labelled Featured & Topics`);
    if (['/workshops/', '/topics/', '/articles/', '/projects/'].includes(path)) {
      assert.ok(leftNav.includes('href="/topics/"') && leftNav.includes('All topics'), `${path} left nav must show popular topics with an All topics link`);
      assert.ok(!leftNav.includes('nav-domain-label'), `${path} left nav must not show a domain context`);
    }
    const domainTitle = { '/topics/software-architecture/': 'Software Architecture', '/topics/system-design/': 'System Design', '/topics/platform-engineering/': 'Platform Engineering' }[path];
    if (domainTitle && leftNav.includes('nav-domain-label')) {
      assert.match(leftNav, new RegExp(`class="nav-section-title nav-domain-label"[^>]*>${domainTitle}<`), `${path} left nav must label its domain ${domainTitle}`);
      assert.ok(!leftNav.includes('All topics'), `${path} left nav must not show the popular fallback in domain mode`);
    }
  }
  const footer = html.match(/<footer class="site-footer"[\s\S]*?<\/footer>/)?.[0] ?? '';
  assert.ok(footer.includes(`© ${new Date().getFullYear()} Eiakoji`), `${path} footer must show the build-year copyright line`);
  assert.match(
    footer,
    /<a href="https:\/\/eiakoji\.me" aria-label="Visit personal website at eiakoji\.me"/,
    `${path} footer must keep the labelled eiakoji.me link`,
  );
  assert.equal(footer.match(/<a /g)?.length, 1, `${path} footer must contain only the eiakoji.me link`);
  assert.ok(!footer.includes('Notes from building, testing, and learning in public.'), `${path} footer must drop the old tagline`);
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

async function waitForServer(process, logsRef, timeoutMs = 15_000) {
  const started = Date.now();
  while (Date.now() - started < timeoutMs) {
    if (process.exitCode !== null) throw new Error(`preview server exited with ${process.exitCode}: ${logsRef.logs}`);
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
  const preview = spawn('./node_modules/.bin/astro', ['preview', '--host', '127.0.0.1', '--port', '4322', '--ignore-lock'], {
    stdio: ['ignore', 'pipe', 'pipe'],
  });
  const logsRef = { logs: '' };
  preview.stdout.on('data', (chunk) => { logsRef.logs += chunk; });
  preview.stderr.on('data', (chunk) => { logsRef.logs += chunk; });

  try {
    await waitForServer(preview, logsRef);
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

    await assert.rejects(stat('dist/series'), 'the build must not produce /series/ pages');
    const articleSlugs = await readdir('dist/articles', { withFileTypes: true });
    for (const entry of articleSlugs.filter((e) => e.isDirectory())) {
      const html = await readFile(`dist/articles/${entry.name}/index.html`, 'utf8');
      for (const removed of ['series-pager', 'series-card', 'aria-label="Series navigation"']) {
        assert.ok(!html.includes(removed), `/articles/${entry.name}/ must not render series UI (${removed})`);
      }
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

  assert.ok(!logsRef.logs.includes('[ERROR]'), `preview server logged an error:\n${logsRef.logs}`);
}

async function testSanityQueries() {
  const requiredPublicFilter = '!(_id in path("drafts.**")) && defined(slug.current)';
  for (const query of [latestContentQuery, articlesQuery, projectsQuery, topicsListQuery]) {
    assert.ok(query.includes(requiredPublicFilter), 'public list queries must exclude drafts and require slugs');
  }
  for (const query of [latestContentQuery, articlesQuery, projectsQuery, articleBySlugQuery, projectBySlugQuery]) {
    assert.ok(query.includes('publishedAt <= now()'), 'published article/project queries must exclude future content');
  }

  for (const query of [topicsListQuery, topicBySlugQuery, wikiNavQuery]) {
    assert.match(query, /"slug": slug\.current,\n\s+kind,/, 'topic queries must project kind');
  }
  for (const domain of ['software-architecture', 'system-design', 'platform-engineering']) {
    assert.ok(homepageQuery.includes(`kind == "domain" && slug.current == "${domain}"`), `homepage must select the ${domain} domain by kind`);
  }
  for (const alias of ['systems-design', 'cloud-platform', '"cloud"', 'ai-systems', '"ai"', 'multi-agent-systems']) {
    assert.ok(!homepageQuery.includes(alias), `homepage must not match legacy domain alias ${alias}`);
  }

  for (const [name, query] of Object.entries(queriesModule)) {
    assert.ok(typeof query !== 'string' || !/series/i.test(query), `${name} must not reference the retired series type`);
  }

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
    articleSlugsQuery,
    projectSlugsQuery,
    topicSlugsQuery,
    topicsListQuery,
    workshopsQuery,
    featuredArticlesQuery,
  ];
  for (const query of listQueries) {
    const result = await client.fetch(query);
    assert.ok(Array.isArray(result), 'list and slug queries must return arrays');
  }

  for (const query of [articleBySlugQuery, projectBySlugQuery, topicBySlugQuery]) {
    const result = await client.fetch(query, { slug: 'not-a-real-slug' });
    assert.equal(result, null, 'unknown detail queries must resolve to null');
  }

  const navResult = await client.fetch(wikiNavQuery);
  assert.ok(navResult && typeof navResult === 'object', 'wikiNavQuery must return an object');
  assert.ok(Array.isArray(navResult.topics), 'wikiNavQuery topics must be an array');
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
    { _id: 'd-sa', _type: 'topic', kind: 'domain', title: 'Software Architecture', slug: 'software-architecture', order: 1 },
    { _id: 'd-sd', _type: 'topic', kind: 'domain', title: 'System Design', slug: 'system-design', order: 2 },
    { _id: 'd-pe', _type: 'topic', kind: 'domain', title: 'Platform Engineering', slug: 'platform-engineering', order: 3 },
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
  assert.deepEqual(domainTree.rootTopics.map((n) => n.topic.slug), ['software-architecture', 'system-design', 'platform-engineering'], 'roots must be domains ordered by order');
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

  // Left nav: featured articles plus the current domain's topics, never the domains themselves.
  const nav = buildNavigation(domainTree, { currentSlug: 'write-through' });
  assert.deepEqual(Object.keys(nav), ['featured', 'topics'], 'navigation must contain only featured articles and topics');
  assert.deepEqual(nav.featured, [], 'no featured articles must yield an empty Featured section');
  assert.equal(nav.topics.mode, 'domain', 'a nested topic must resolve to its domain');
  assert.deepEqual(nav.topics.domain, { title: 'System Design', slug: 'system-design' }, 'the domain is a plain label');
  assert.deepEqual(nav.topics.topics.map((i) => i.slug), ['batching', 'caching', 'zookeeper'], 'domain mode must list the domain children in order');
  const cachingItem = nav.topics.topics.find((i) => i.slug === 'caching');
  assert.deepEqual(cachingItem.children.map((i) => i.slug), ['write-through'], 'the current path must be expanded');
  assert.equal(cachingItem.current, false, 'ancestors of the current topic must not be highlighted');
  assert.equal(cachingItem.children[0].current, true, 'the current topic must be highlighted');
  assert.equal(cachingItem.children[0].href, '/topics/write-through/', 'topic items must link through topicHref');
  assert.equal(cachingItem.count, domainTree.nodeMap.get('t-c').rollupArticleCount, 'item counts must be rollup counts');
  assert.equal(cachingItem.count, 1, 'caching must roll up its nested article');
  for (const sibling of nav.topics.topics.filter((i) => i.slug !== 'caching')) {
    assert.equal(sibling.children.length, 0, `${sibling.slug} is off the current path and must stay collapsed`);
    assert.equal(sibling.current, false, `${sibling.slug} must not be highlighted`);
    assert.equal(sibling.count, 0, `${sibling.slug} has no articles`);
  }
  const allItems = (items) => items.flatMap((i) => [i, ...allItems(i.children)]);
  const domainSlugs = domainTree.rootTopics.map((n) => n.topic.slug);
  const hubNav = buildNavigation(domainTree, { currentSlug: 'system-design' });
  assert.equal(hubNav.topics.mode, 'domain', 'a domain hub must resolve to domain mode');
  assert.ok(allItems(hubNav.topics.topics).every((i) => !i.current), 'nothing is highlighted on a domain hub');
  assert.ok(hubNav.topics.topics.every((i) => i.children.length === 0), 'a domain hub shows its children collapsed');
  for (const n of [nav, hubNav]) {
    assert.ok(allItems(n.topics.topics).every((i) => !domainSlugs.includes(i.slug)), 'domains must never be nav items');
  }
  for (const slug of ['legacy-root', 'not-a-topic', 'articles', undefined]) {
    const fallback = buildNavigation(domainTree, { currentSlug: slug });
    assert.equal(fallback.topics.mode, 'popular', `currentSlug ${slug} must fall back to popular topics`);
    assert.equal(fallback.topics.allTopicsHref, '/topics/', 'popular mode must link All topics');
    assert.deepEqual(fallback.topics.topics.map((i) => i.slug), ['caching', 'write-through'], 'popular mode lists only non-domain topics with articles');
  }
  assert.equal(buildNavigation(domainTree, { currentSlug: 'software-architecture' }).topics.mode, 'popular', 'a domain with no topics must fall back to popular topics');

  // Popular ordering: featured first, then rollup count, then order and title; capped at 8.
  const popularTaxonomy = [
    { _id: 'pd', _type: 'topic', kind: 'domain', title: 'Domain', slug: 'domain' },
    ...Array.from({ length: 10 }, (_, i) => ({
      _id: `p${i}`, _type: 'topic', kind: 'topic', title: `Topic ${String.fromCharCode(74 - i)}`, slug: `p${i}`, parent: ref('pd'),
      ...(i === 9 ? { featured: true } : {}),
      ...(i === 4 ? { order: 1 } : {}),
    })),
    { _id: 'p-empty', _type: 'topic', kind: 'topic', title: 'Empty', slug: 'p-empty', parent: ref('pd'), featured: true },
  ];
  const counts = { p0: 5, p1: 4, p2: 3, p3: 3, p4: 3, p5: 2, p6: 2, p7: 2, p8: 1, p9: 1 };
  const popularArticles = Object.entries(counts).flatMap(([topic, n]) =>
    Array.from({ length: n }, (_, i) => ({ _id: `${topic}-a${i}`, _type: 'article', title: 't', slug: `${topic}-a${i}`, summary: 's', primaryTopic: ref(topic) })),
  );
  const popular = buildNavigation(buildTopicTree(popularTaxonomy, popularArticles)).topics;
  assert.equal(popular.mode, 'popular', 'no currentSlug must yield popular mode');
  assert.deepEqual(
    popular.topics.map((i) => i.slug),
    ['p9', 'p0', 'p1', 'p4', 'p3', 'p2', 'p7', 'p6'],
    'popular topics must order featured, count desc, then order, then title, capped at 8',
  );
  assert.ok(popular.topics.every((i) => i.count > 0 && i.children.length === 0), 'popular topics have counts and no children');

  // Featured articles: up to 5, newest first, current article highlighted.
  const featuredFixture = [
    ...Array.from({ length: 7 }, (_, i) => ({
      _id: `f${i}`, _type: 'article', title: `Featured ${i}`, slug: `featured-${i}`, summary: 's',
      featured: true, publishedAt: `2026-0${i + 1}-01T00:00:00Z`,
    })),
    { _id: 'f-undated', _type: 'article', title: 'Undated', slug: 'undated', summary: 's', featured: true },
    { _id: 'n1', _type: 'article', title: 'Plain', slug: 'plain', summary: 's', featured: false, publishedAt: '2026-12-01T00:00:00Z' },
  ];
  const featuredNav = buildNavigation(domainTree, { articles: featuredFixture, currentArticleSlug: 'featured-5' });
  assert.deepEqual(
    featuredNav.featured.map((i) => i.slug),
    ['featured-6', 'featured-5', 'featured-4', 'featured-3', 'featured-2'],
    'Featured must show the 5 newest featured articles',
  );
  assert.equal(featuredNav.featured[0].href, '/articles/featured-6/', 'featured items must link their article');
  assert.deepEqual(featuredNav.featured.map((i) => i.current), [false, true, false, false, false], 'the current article must be highlighted');

  assert.deepEqual(buildNavigation(buildTopicTree([])), { featured: [], topics: null }, 'an empty site must yield an empty navigation');
  assert.ok(!('BROWSE_LINKS' in topicsModule), 'BROWSE_LINKS must no longer be exported');
  assert.ok(!wikiNavQuery.includes('"series"'), 'wikiNavQuery must not project series');
  assert.ok(!wikiNavQuery.includes('_type == "series"'), 'wikiNavQuery must not query series');
  assert.equal(topicHref(domainTree, 'write-through'), '/topics/write-through/', 'topics in the tree link to their hub');
  for (const missing of ['legacy-root', 'orphan', 'nested-domain', undefined]) {
    assert.equal(topicHref(domainTree, missing), undefined, `excluded topic ${missing} must not get a hub link`);
  }

  // 6. Test validateTopicParent in Studio schema validation (including failure and error paths)
  const selfRefResult = await validateTopicParent({ _ref: 't-self' }, { document: { _id: 't-self', kind: 'topic' } });
  assert.equal(selfRefResult, 'A topic cannot reference itself as its parent.');

  // Transient query error must NOT fail open
  const failingContext = {
    document: { _id: 't-child', kind: 'topic' },
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
  assert.equal(await validateTopicParent(undefined, { document: { _id: 't-new' } }), true, 'a missing kind is reported only by the required Kind field');
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
    ['domain-software-architecture', 'domain-system-design', 'domain-platform-engineering'],
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
  assert.deepEqual(legacyPlan.blocked, ['domain-system-design'], 'a domain skipped for a slug conflict must block the seed');
  assert.deepEqual(firstPlan.blocked, [], 'a clean seed must not be blocked');
  assert.equal(DOMAIN_SEEDS.length, 3);

  // 6c. The real queries, run against the full fixture, drive the same tree
  const fixtureTopics = await queryFixtures('full', topicsListQuery);
  assert.ok(fixtureTopics.every((t) => t.kind || t.slug === 'languages'), 'topicsListQuery must project kind');
  assert.ok(!fixtureTopics.some((t) => t.slug === 'draft-only'), 'topic queries must exclude drafts');
  const fixtureArticles = await queryFixtures('full', articlesQuery);
  assert.ok(!fixtureArticles.some((a) => a.slug === 'future-post'), 'article queries must exclude future content');
  const fixtureTree = buildTopicTree(fixtureTopics, fixtureArticles);
  assert.deepEqual(fixtureTree.rootTopics.map((n) => n.topic.slug), ['software-architecture', 'system-design', 'platform-engineering']);
  assert.equal(fixtureTree.slugMap.get('system-design').rollupArticleCount, 2, 'domain rollups must count nested articles once');
  assert.deepEqual(fixtureTree.excluded.map((e) => e.topic.slug), ['languages']);
  const orphanedArticle = await queryFixtures('full', articleBySlugQuery, { slug: 'language-notes' });
  assert.equal(orphanedArticle.primaryTopic.slug, 'languages');
  assert.equal(topicHref(fixtureTree, orphanedArticle.primaryTopic.slug), undefined, 'an excluded primary topic must not be linked');
  const fixtureHome = await queryFixtures('full', homepageQuery);
  assert.equal(fixtureHome.platformTopic?.slug, 'platform-engineering', 'homepage must find domains by kind');
  assert.equal((await queryFixtures('empty', wikiNavQuery)).topics.length, 0);
  const fixtureNavData = await queryFixtures('full', wikiNavQuery);
  const fixtureNav = buildNavigation(buildTopicTree(fixtureNavData.topics, fixtureNavData.articles), {
    articles: fixtureNavData.articles,
    currentSlug: 'raft',
    currentArticleSlug: 'lsm-trees',
  });
  assert.deepEqual(
    fixtureNav.featured.map((i) => [i.slug, i.title, i.href, i.current]),
    [
      ['golden-paths', 'Golden Paths', '/articles/golden-paths/', false],
      ['lsm-trees', 'LSM Trees', '/articles/lsm-trees/', true],
    ],
    'wikiNavQuery must project article title, slug, publishedAt, and featured, excluding scheduled posts',
  );
  assert.equal(fixtureNav.topics?.mode, 'domain', 'a nested fixture topic must resolve its domain');
  assert.equal(fixtureNav.topics.domain.slug, 'system-design');
  await assert.rejects(queryFixtures('staging', topicsListQuery), /Unknown WIKI_FIXTURES/);

  const fixtureArticle = await queryFixtures('full', articleBySlugQuery, { slug: 'raft-log-replication' });
  assert.ok(!('series' in fixtureArticle), 'article detail must not project series');
  assert.ok(
    (await queryFixtures('full', latestContentQuery)).every((item) => ['article', 'project'].includes(item._type)),
    'latest content must list only articles and projects',
  );

  const aeeFixture = await queryFixtures('full', articleBySlugQuery, { slug: 'ai-execution-environment-architecture' });
  assert.equal(aeeFixture.title, 'Architecture of an Issue-Driven AI Execution Environment');
  assert.equal(aeeFixture.primaryTopic?.slug, 'platform-engineering');

  // 7. Test showRepositoryLink: repository links are public only for workshops
  const repo = 'https://github.com/eiakoji-me/example';
  assert.equal(showRepositoryLink({ repositoryUrl: repo, format: 'workshop' }), true, 'workshop format must show its repository');
  assert.equal(showRepositoryLink({ repositoryUrl: repo, kind: 'workshop' }), true, 'workshop kind must show its repository');
  assert.equal(showRepositoryLink({ repositoryUrl: 'https://github.com/eiakoji-me/wiki-eiakoji-me', format: 'workshop' }), true, 'no repository is excluded by name');
  assert.equal(showRepositoryLink({ repositoryUrl: repo, format: 'article' }), false, 'articles must not show a repository link');
  assert.equal(showRepositoryLink({ format: 'workshop' }), false, 'a workshop without a URL must not show a repository link');
  assert.equal(showRepositoryLink(undefined), false, 'a missing item must not show a repository link');
  assert.equal(contentHref('topic', 'raft'), '/topics/raft/');
  assert.equal(contentHref('project', 'aee'), '/projects/aee/');
  assert.equal(contentHref('article', 'raft'), '/articles/raft/');
  assert.equal(contentHref('unknown', 'x'), '/articles/x/', 'unknown content types must not link to /series/');

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
  const [styles, netlify, ignore, envExample, readme, articleSchema, projectSchema, imageSchema, topicSchema, tocComponent, topicsIndexPage, leftNavComponent, wikiLayout] = await Promise.all([
    readFile('src/styles/global.css', 'utf8'),
    readFile('netlify.toml', 'utf8'),
    readFile('.gitignore', 'utf8'),
    readFile('.env.example', 'utf8'),
    readFile('README.md', 'utf8'),
    readFile('sanity/schemaTypes/article.ts', 'utf8'),
    readFile('sanity/schemaTypes/project.ts', 'utf8'),
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
  assert.ok(
    !/\.footer-inner[^{]*\{[^}]*flex-direction:\s*column/.test(styles),
    'the footer copyright line and link must stay in one row at every width',
  );
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
  for (const field of ['slug', 'summary', 'publishedAt', 'featuredImage', 'body', 'format', 'primaryTopic', 'featured']) {
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
  const rightRail = await readFile('src/components/RightRail.astro', 'utf8');
  assert.ok(!rightRail.includes('/topics/${'), 'RightRail must build topic links with topicHref so excluded topics are not linked');
  assert.ok(rightRail.includes('topicHref('), 'RightRail must use topicHref');
  const articlePage = await readFile('src/pages/articles/[slug].astro', 'utf8');
  assert.ok(!articlePage.includes('topicHref'), 'the article page must not build topic links; related topics live in the right rail');
  assert.ok(!/href=\{?[`'"]\/topics\//.test(articlePage), 'the article page must not link to /topics/');
  for (const file of ['src/lib/content.ts', 'src/pages/topics/index.astro', 'src/pages/topics/[slug].astro']) {
    assert.ok(!(await readFile(file, 'utf8')).includes('CORE_DOMAIN_TOPICS'), `${file} must not keep reader-side domain fallbacks`);
  }
  assert.ok(leftNavComponent.includes('buildNavigation(tree, {'), 'LeftNav must render from buildNavigation');
  assert.ok(!leftNavComponent.includes('Sections') && !leftNavComponent.includes('/projects/'), 'LeftNav must not keep the Sections block or a Projects link');
  for (const removed of ['Browse', 'Curated Series', '/articles/', '/series/', 'series', 'Series']) {
    assert.ok(!leftNavComponent.includes(removed), `LeftNav must not repeat the top nav or contain ${removed}`);
  }
  assert.match(
    leftNavComponent,
    /\{\(nav\.featured\.length > 0 \|\| topics\) && \(\s*<aside class="wiki-left-nav"/,
    'LeftNav must omit the whole aside when there is nothing to show',
  );
  assert.ok(leftNavComponent.includes('Featured & Topics'), 'LeftNav disclosure must be labelled Featured & Topics');
  assert.ok(!leftNavComponent.includes('Navigation & Topics'), 'LeftNav must drop the old disclosure label');
  assert.ok(wikiLayout.includes('currentArticleSlug={currentArticleSlug}'), 'WikiLayout must pass the current article to LeftNav');
  assert.ok(wikiLayout.includes('articles={navData?.articles ?? []}'), 'WikiLayout must pass nav articles to LeftNav');
  const articlePageSource = await readFile('src/pages/articles/[slug].astro', 'utf8');
  assert.ok(articlePageSource.includes('currentArticleSlug={article.slug}'), 'article pages must pass currentArticleSlug');
  assert.ok(!articlePageSource.includes("?? 'articles'"), 'article pages must not pass a fake topic slug');
  const navArticles = wikiNavQuery.slice(wikiNavQuery.indexOf('"articles"'));
  for (const field of ['featured', 'publishedAt', 'title', '"slug": slug.current']) {
    assert.ok(navArticles.includes(field), `wikiNavQuery articles must project ${field}`);
  }
  assert.ok(styles.includes('.wiki-shell:not(:has(.wiki-left-nav))'), 'styles must lay out the shell without a left nav');
  assert.ok(!wikiLayout.includes('series='), 'WikiLayout must not pass series to LeftNav');
  const navDataType = wikiLayout.match(/fetchContent<([^>]*)>\(wikiNavQuery\)/)?.[1] ?? '';
  assert.ok(navDataType.includes('topics'), 'WikiLayout navData type must be found');
  assert.ok(!navDataType.includes('Series'), 'WikiLayout navData type must not include Series');
  for (const field of ['slug', 'summary', 'publishedAt', 'featuredImage', 'body', 'repositoryUrl', 'projectUrl']) {
    assert.ok(projectSchema.includes(`name: '${field}'`), `project schema must define ${field}`);
  }
  assert.ok(!articleSchema.includes("name: 'series'"), 'article schema must not keep the retired series field');
  assert.ok(!/series/i.test(await readFile('sanity/schemaTypes/index.ts', 'utf8')), 'Studio must not register a series schema type');
  await assert.rejects(stat('sanity/schemaTypes/series.ts'), 'the series schema file must be deleted');
  assert.ok(!(await readFile('sanity/structure.ts', 'utf8')).includes('series'), 'Studio structure must not list series');
  for (const file of ['src/pages/articles/[slug].astro', 'src/components/RightRail.astro', 'src/lib/sanity/types.ts', 'src/lib/content.ts', 'src/layouts/BaseLayout.astro', 'README.md']) {
    assert.ok(!/series|learning path/i.test(await readFile(file, 'utf8')), `${file} must not reference series or learning paths`);
  }
  const railSource = await readFile('src/components/RightRail.astro', 'utf8');
  assert.ok(railSource.includes('article?.relatedTopics') && railSource.includes('Related topics'), 'RightRail must keep related topics in a "Related topics" card');
  assert.ok(imageSchema.includes("name: 'alt'"), 'images must define alternative text');
  assert.ok(imageSchema.includes('rule.required()'), 'image alternative text must be required');
}

// Reads flat CSS rules plus one level of @media so assertions ignore formatting and declaration order.
const normalizeCss = (text) => text.replace(/\s+/g, ' ').replace(/\s*([,()>+~/])\s*/g, '$1').replace(/:\s+/g, ':').trim();

function parseCss(text) {
  const rules = [];
  const open = [];
  for (const [, chunk, brace] of text.replace(/\/\*[\s\S]*?\*\//g, '').matchAll(/([^{}]*)([{}])/g)) {
    if (brace === '{') {
      open.push(normalizeCss(chunk));
      continue;
    }
    const selector = open.pop();
    const media = open.length === 1 && open[0].startsWith('@media') ? open[0].slice('@media'.length) : null;
    if (selector.startsWith('@') || (open.length && !media)) continue;
    const decls = new Map();
    for (const declaration of chunk.split(';')) {
      const colon = declaration.indexOf(':');
      if (colon > 0) decls.set(declaration.slice(0, colon).trim().toLowerCase(), normalizeCss(declaration.slice(colon + 1)));
    }
    rules.push({ media, selector, decls });
  }
  const matching = (selector, media) => rules.filter((rule) => rule.selector === normalizeCss(selector) && rule.media === (media && normalizeCss(media)));
  return {
    decl: (selector, prop, { media = null } = {}) => matching(selector, media).findLast((rule) => rule.decls.has(prop))?.decls.get(prop),
    hasRule: (selector, { media = null } = {}) => matching(selector, media).length > 0,
  };
}

// Issue #33: listings render as compact list rows rather than boxed cards.
async function testListingRows() {
  const card = await readFile('src/components/ContentCard.astro', 'utf8');
  assert.ok(!card.includes('card-placeholder'), 'ContentCard must not emit a placeholder block');
  assert.ok(!card.includes('card-action'), 'ContentCard rows must not emit an Explore action');
  assert.match(card, /\{item\.featuredImage\?\.asset && \(/, 'ContentCard must render a thumbnail only when a featured image exists');
  assert.match(card, /imageUrl\(item\.featuredImage\.asset, 320\)/, 'ContentCard thumbnails must request a small image');
  const order = ['<h2>', '<p>{item.summary}</p>', 'class="card-meta"', 'class="card-image"'].map((needle) => card.indexOf(needle));
  assert.ok(order.every((index, i) => index >= 0 && (i === 0 || index > order[i - 1])), 'ContentCard rows must order title, summary, meta, then thumbnail');

  const fixture = parseCss(`/* fixture */
.card-grid{gap:0;
   grid-template-columns : minmax( 0,1fr ) }
.content-card  +  .content-card { border-top:1px  solid var(--border) }
@media (max-width:720px){ .card-image{ width : 96px } }`);
  assert.equal(fixture.decl('.card-grid', 'grid-template-columns'), normalizeCss('minmax(0, 1fr)'), 'CSS reader must ignore spacing and declaration order');
  assert.equal(fixture.decl('.content-card + .content-card', 'border-top'), '1px solid var(--border)', 'CSS reader must normalize combinators');
  assert.equal(fixture.decl('.card-image', 'width', { media: '(max-width: 720px)' }), '96px', 'CSS reader must read @media rules');

  const { decl, hasRule } = parseCss(await readFile('src/styles/global.css', 'utf8'));
  const expectDecl = (selector, prop, value, message, options) => assert.equal(decl(selector, prop, options), normalizeCss(value), message);
  expectDecl('.card-grid', 'grid-template-columns', 'minmax(0, 1fr)', 'card-grid must be a single column of rows');
  expectDecl('.card-grid', 'gap', '0', 'card-grid rows must not be spaced apart');
  expectDecl('.content-card + .content-card', 'border-top', '1px solid var(--border)', 'rows must be separated by dividers');
  assert.notEqual(decl('.content-card', 'overflow'), 'hidden', 'rows must not clip the focus ring');
  expectDecl('.card-link:focus-visible', 'outline-offset', '2px', 'row links must keep a visible outer focus ring');
  expectDecl('.card-body p', '-webkit-line-clamp', '2', 'row summaries must clamp to two lines');
  expectDecl('.card-body p', 'line-clamp', '2', 'row summaries must clamp to two lines');
  expectDecl('.card-image', 'width', '160px', 'row thumbnails must be 160px wide');
  expectDecl('.card-image', 'aspect-ratio', '16 / 9', 'row thumbnails must be 16:9');
  for (const selector of ['.card-grid .card-placeholder', '.card-grid .card-action', '.card-grid .card-topics', '.card-topics', '.card-domain', '.card-format']) {
    assert.ok(!hasRule(selector), `global.css must not keep the unused ${selector} rule`);
  }
  for (const [file, source] of [['src/components/ContentCard.astro', card], ['src/pages/topics/index.astro', await readFile('src/pages/topics/index.astro', 'utf8')]]) {
    for (const removed of ['card-placeholder', 'card-topics', 'card-format']) {
      assert.ok(!source.includes(removed), `${file} must not render ${removed}`);
    }
  }
  expectDecl('.card-grid .card-link', 'padding', '10px 0', 'rows must use tight vertical padding');
  expectDecl('.card-grid .card-meta', 'order', '1', 'row meta must stay visible after the summary');
  assert.notEqual(decl('.card-grid .card-meta', 'display'), 'none', 'row meta must stay visible');
  expectDecl('.card-grid .card-body :is(h2, h3)', 'margin', '0 0 2px', 'row titles must keep tight spacing');
  expectDecl('.card-grid .card-body :is(h2, h3)', 'font-size', 'var(--text-row-title)', 'row titles must use the row title size');
  assert.equal(decl('.card-link', 'padding'), undefined, 'base card links must not declare padding that rows override');
  assert.ok(!hasRule('.card-body :is(h2, h3)'), 'base card titles must not declare sizing that rows override');
  expectDecl('.card-link', 'gap', '14px', 'row links must tighten their gap on narrow screens', { media: '(max-width: 720px)' });
  expectDecl('.card-image', 'width', '96px', 'row thumbnails must shrink to 96px on narrow screens', { media: '(max-width: 720px)' });

  const listing = ':is(.articles-index-page, .projects-index-page, .workshops-index-page, .topic-index-page)';
  expectDecl(`${listing} .page-heading`, 'padding', '0 0 12px', 'listing pages must use a compact heading');
  expectDecl(`${listing} .page-heading .eyebrow`, 'display', 'none', 'listing headings must drop the eyebrow');
  expectDecl(`${listing} h1`, 'font-size', 'var(--title-listing)', 'listing page titles must use the listing size');
  assert.ok(!hasRule(':is(.articles-index-page, .projects-index-page, .workshops-index-page, .topic-index-page, .topic-hub-page) h1'), 'topic hub titles must not rely on the lower-specificity listing rule');
  expectDecl('.topic-hub-page .entry-header h1', 'font-size', 'var(--title-listing)', 'topic hub titles must use the listing size');
  expectDecl('.page-heading', 'padding', '40px 0 24px', 'non-listing page headings must keep their spacing');
  expectDecl('.page-heading h1', 'font-size', 'var(--title-page)', 'page headings must keep the page title size');
  expectDecl('.entry-header h1', 'font-size', 'var(--title-article)', 'article and project titles must keep the article size');
  expectDecl('.entry-header h1', 'margin', '10px 0 0', 'article and project titles must keep their spacing');

  for (const file of ['dist/index.html', 'dist/articles/index.html', 'dist/topics/system-design/index.html']) {
    const html = await readFile(file, 'utf8');
    const cards = html.match(/<article class="content-card">[\s\S]*?<\/article>/g) ?? [];
    for (const markup of cards) {
      assert.ok(!markup.includes('card-placeholder'), `${file} rows must not render a placeholder`);
      const image = markup.match(/<img class="card-image"[^>]*>/)?.[0];
      if (image) {
        assert.match(image, /[?&](amp;)?w=320/, `${file} row thumbnails must request width 320`);
        assert.match(image, /alt="[^"]+"/, `${file} row thumbnails must keep alt text`);
        assert.match(image, /width="160" height="90"/, `${file} row thumbnails must declare 160x90`);
      }
    }
  }
}

// Public templates must not render article or entry counts (issue #41).
async function testNoPublicCounts() {
  const [treeItem, card, topicHub, topicIndex] = await Promise.all([
    readFile('src/components/TopicTreeItem.astro', 'utf8'),
    readFile('src/components/ContentCard.astro', 'utf8'),
    readFile('src/pages/topics/[slug].astro', 'utf8'),
    readFile('src/pages/topics/index.astro', 'utf8'),
  ]);

  assert.ok(!treeItem.includes('topic-count'), 'TopicTreeItem must not render a topic count');
  assert.ok(!/> articles<|" articles"/.test(treeItem), 'TopicTreeItem must not render hidden "articles" count text');
  assert.ok(!card.includes('articleCount'), 'ContentCard must not accept or render an article count');
  for (const [file, source] of [['src/pages/topics/[slug].astro', topicHub], ['src/pages/topics/index.astro', topicIndex]]) {
    assert.ok(!/\b\w+ArticleCount\b/.test(source), `${file} must not render article counts`);
  }
  assert.ok(!topicHub.includes('Published Entries'), 'topic hubs must not render a Published Entries header');
  assert.ok(topicHub.includes('aria-label="Entries under this topic"'), 'topic hubs must keep the labelled entries section');
  assert.match(topicHub, /\.section \+ \.articles-section\s*\{\s*padding-top: 0;/, 'topic hubs must keep the entry list attached to the section above it');
  assert.ok(!topicIndex.includes('domain-meta'), 'the topics index must not render the domain count wrapper');
  assert.ok(!topicIndex.includes('rollup-badge'), 'the topics index must not keep the rollup badge');

  const domainPages = [
    'dist/topics/software-architecture/index.html',
    'dist/topics/system-design/index.html',
    'dist/topics/platform-engineering/index.html',
  ];
  for (const file of ['dist/topics/index.html', ...domainPages]) {
    const html = await readFile(file, 'utf8');
    assert.ok(!html.includes('Published Entries'), `${file} must not render a Published Entries header`);
    assert.ok(!/\d+ (total )?entr(y|ies)\b/.test(html), `${file} must not render entry counts`);
    assert.ok(!/\d+ direct\b/.test(html), `${file} must not render direct entry counts`);
  }
  for (const file of domainPages) {
    const html = await readFile(file, 'utf8');
    assert.ok(html.includes('aria-label="Entries under this topic"'), `${file} must keep the labelled entries section`);
  }
  for (const page of expectedPages) {
    const html = await readFile(page.file, 'utf8');
    assert.ok(!html.includes('topic-count'), `${page.path} navigation must not render topic counts`);
    assert.ok(!html.includes('visually-hidden"> articles'), `${page.path} navigation must not render hidden article counts`);
  }
}

async function listFiles(dir, extension) {
  const entries = await readdir(dir, { withFileTypes: true });
  const nested = await Promise.all(entries.map((entry) => {
    const path = `${dir}/${entry.name}`;
    if (entry.isDirectory()) return listFiles(path, extension);
    return !extension || entry.name.endsWith(extension) ? [path] : [];
  }));
  return nested.flat();
}

// Public templates show content only: no type labels, internal jargon, CMS names or source links (issue #49).
// Returns the outer HTML of every element whose class list contains `cls`,
// matching nested tags of the same name so the closing tag is the right one.
function findElements(html, cls) {
  const elements = [];
  const opening = new RegExp(`<([a-z][a-z0-9]*)\\b[^>]*\\bclass="[^"]*\\b${cls}\\b[^"]*"[^>]*>`, 'g');
  let match;
  while ((match = opening.exec(html))) {
    const tag = match[1];
    const tags = new RegExp(`<(/?)${tag}\\b[^>]*>`, 'g');
    tags.lastIndex = match.index + match[0].length;
    let depth = 1;
    let end = html.length;
    let next;
    while (depth > 0 && (next = tags.exec(html))) {
      depth += next[1] ? -1 : 1;
      if (depth === 0) end = next.index + next[0].length;
    }
    elements.push(html.slice(match.index, end));
    opening.lastIndex = end;
  }
  return elements;
}

// Empties every element carrying one of `classes`, keeping its tags. Used to
// drop content-owned text (titles and summaries from Sanity) so text checks
// only see template-owned markup.
function blankElements(html, classes) {
  let result = html;
  for (const cls of classes) {
    for (const element of findElements(result, cls)) {
      const openEnd = element.indexOf('>') + 1;
      const closeStart = element.lastIndexOf('</');
      const blanked = closeStart >= openEnd ? element.slice(0, openEnd) + element.slice(closeStart) : element;
      result = result.replace(element, blanked);
    }
  }
  return result;
}

async function testNoInternalMetadata() {
  // Strings scanned across whole built pages. They do not occur naturally in
  // content. "Sequence", "Sanity", "Part of" and "Part n:" can, so they are
  // checked below against template-owned elements only.
  const forbiddenText = ['Domain Overview', 'Topic Hub', 'ARCHETYPES', 'WORKSHOPS', 'Read complete entry', 'Layering Invariants', 'knowledge hubs'];
  const forbiddenClasses = ['card-format', 'card-domain', 'card-topics', 'card-placeholder', 'archetypes-badge', 'workshops-badge', 'discipline-tag', 'callout-badge', 'callout-item-prefix', 'entry-taxonomy', 'workshop-callout', 'tech-tags'];
  const htmlFiles = await listFiles('dist', '.html');
  assert.ok(htmlFiles.length > 0, 'dist must contain built HTML');
  let calloutCount = 0;
  for (const file of htmlFiles) {
    const html = await readFile(file, 'utf8');
    for (const text of forbiddenText) {
      assert.ok(!html.includes(text), `${file} must not contain "${text}"`);
    }
    assert.ok(!/\bSubtopic\b/.test(html), `${file} must not label topics as "Subtopic"`);
    for (const cls of forbiddenClasses) {
      assert.ok(!new RegExp(`class="[^"]*\\b${cls}\\b`).test(html), `${file} must not render .${cls}`);
    }
    // Series callouts: the item titles and the callout title come from
    // content, so blank them; whatever remains is Callout.astro markup.
    for (const callout of findElements(html, 'article-callout')) {
      calloutCount += 1;
      const template = blankElements(callout, ['callout-title', 'callout-item-link', 'callout-item-text']);
      assert.ok(!template.includes('Sequence'), `${file} callout must not render a "Sequence" badge`);
      assert.ok(!/Part \d+:/.test(template), `${file} callout must not render a generated "Part n:" prefix`);
    }
    for (const emptyState of findElements(html, 'empty-state')) {
      assert.ok(!emptyState.includes('Sanity'), `${file} empty state must not mention Sanity`);
    }
  }
  assert.ok(calloutCount > 0, 'built articles must contain at least one series callout to check');

  const topicPages = htmlFiles.filter((file) => /^dist\/topics\/[^/]+\/index\.html$/.test(file));
  assert.ok(topicPages.length > 0, 'topic pages must be built');
  for (const file of topicPages) {
    const html = await readFile(file, 'utf8');
    const header = html.match(/<header class="entry-header"[^>]*>[\s\S]*?<\/header>/)?.[0] ?? '';
    assert.ok(header, `${file} must render an entry header`);
    assert.ok(!header.includes('class="badge"'), `${file} must not render a Domain/Topic badge`);
    // The title and summary are content; the rest of the header is template.
    const headerTemplate = blankElements(header.replace(/<h1\b[^>]*>[\s\S]*?<\/h1>/, '<h1></h1>'), ['entry-summary']);
    assert.ok(!headerTemplate.includes('Part of'), `${file} must not render a "Part of" parent line`);
  }

  const topicsIndex = await readFile('dist/topics/index.html', 'utf8');
  assert.ok(topicsIndex.includes('class="domain-topics'), 'the topics index must list child topics as plain links');
  for (const cls of ['domain-main-card', 'subtopic-card', 'card-action']) {
    assert.ok(!topicsIndex.includes(cls), `the topics index must not render .${cls}`);
  }

  const articlePages = htmlFiles.filter((file) => /^dist\/articles\/[^/]+\/index\.html$/.test(file));
  assert.ok(articlePages.length > 0, 'article pages must be built');
  for (const file of articlePages) {
    const html = await readFile(file, 'utf8');
    assert.ok(!html.includes('href="https://github.com/'), `${file} must not link to GitHub source`);
    assert.ok(!/<ul class="tags[" ]/.test(html), `${file} must not render the free-text topics list`);
    const rail = html.match(/<aside class="wiki-right-rail"[\s\S]*?<\/aside>/)?.[0];
    if (rail?.includes('topic-card')) {
      assert.ok(rail.includes('Related topics'), `${file} right rail topic card must be headed "Related topics"`);
      assert.ok(!/class="(topic-link|related-tag|related-label)/.test(rail), `${file} right rail must use plain topic links`);
    }
    if (file.includes('poeaa-part-1')) {
      assert.ok(html.includes('href="/articles/poeaa-part-2-data-source-persistence/"'), `${file} must link published Part 2`);
      assert.ok(html.includes('href="/articles/poeaa-part-3-web-presentation-distribution/"'), `${file} must link published Part 3`);
      assert.ok(html.includes('href="/articles/poeaa-part-4-offline-concurrency-session-state/"'), `${file} must link published Part 4`);
    }
    if (file.includes('poeaa-part-2')) {
      assert.ok(html.includes('href="/articles/poeaa-part-1-layering-and-domain-logic/"'), `${file} must link published Part 1`);
      assert.ok(html.includes('href="/articles/poeaa-part-3-web-presentation-distribution/"'), `${file} must link published Part 3`);
      assert.ok(html.includes('href="/articles/poeaa-part-4-offline-concurrency-session-state/"'), `${file} must link published Part 4`);
    }
    if (file.includes('poeaa-part-3')) {
      assert.ok(html.includes('href="/articles/poeaa-part-1-layering-and-domain-logic/"'), `${file} must link published Part 1`);
      assert.ok(html.includes('href="/articles/poeaa-part-2-data-source-persistence/"'), `${file} must link published Part 2`);
      assert.ok(html.includes('href="/articles/poeaa-part-4-offline-concurrency-session-state/"'), `${file} must link published Part 4`);
    }
    if (file.includes('poeaa-part-4')) {
      assert.ok(html.includes('href="/articles/poeaa-part-1-layering-and-domain-logic/"'), `${file} must link published Part 1`);
      assert.ok(html.includes('href="/articles/poeaa-part-2-data-source-persistence/"'), `${file} must link published Part 2`);
      assert.ok(html.includes('href="/articles/poeaa-part-3-web-presentation-distribution/"'), `${file} must link published Part 3`);
    }
  }

  const srcFiles = await listFiles('src');
  for (const file of srcFiles) {
    const source = await readFile(file, 'utf8');
    assert.ok(!source.includes("includes('wiki-eiakoji-me')"), `${file} must not hard-code a repository in a link guard`);
    assert.ok(!source.includes('Series Navigation'), `${file} must not contain "Series Navigation"`);
    if (file.endsWith('.astro')) {
      // Empty states only render without content, so check the template text
      // directly: everything after the frontmatter, minus the SanityImage tag.
      const markup = source.replace(/^---[\s\S]*?\n---/, '').replace(/<\/?SanityImage\b/g, '');
      assert.ok(!markup.includes('Sanity'), `${file} template must not mention Sanity`);
    }
  }
  for (const file of await listFiles('scripts/data')) {
    assert.ok(!(await readFile(file, 'utf8')).includes('Series Navigation'), `${file} must not contain "Series Navigation"`);
  }
  const content = await readFile('src/lib/content.ts', 'utf8');
  assert.ok(content.includes('export function showRepositoryLink'), 'content.ts must export showRepositoryLink');
  assert.ok(!content.includes('formatContentLabel') && !content.includes('FORMAT_LABELS'), 'content.ts must not keep format labels');
  assert.ok((await readFile('src/components/RightRail.astro', 'utf8')).includes('showRepositoryLink(article)'), 'RightRail must gate repository links with showRepositoryLink');
  const callout = await readFile('src/components/Callout.astro', 'utf8');
  assert.ok(callout.includes("item.status === 'completed' && item.href"), 'series callouts must link only completed items');
  assert.ok(!callout.includes('Sequence'), 'Callout.astro must not render a "Sequence" badge');
  assert.ok(!/Part \{/.test(callout), 'Callout.astro must not generate a "Part n:" prefix');
  const seed = JSON.parse(await readFile('scripts/data/article-poeaa-part-1.json', 'utf8'));
  const seedCallouts = JSON.stringify(seed).match(/"title":"Patterns of Enterprise Application Architecture[^"]*"/g) ?? [];
  assert.ok(seedCallouts.includes('"title":"Patterns of Enterprise Application Architecture"'), 'the PoEAA seed callout title must be "Patterns of Enterprise Application Architecture"');
  const home = await readFile('src/pages/index.astro', 'utf8');
  for (const removed of ['archetypes-badge', 'workshops-badge', 'discipline-tag', 'formatContentLabel']) {
    assert.ok(!home.includes(removed), `src/pages/index.astro must not contain ${removed}`);
  }
  const project = await readFile('src/pages/projects/[slug].astro', 'utf8');
  assert.ok(!project.includes('Case Study'), 'project pages must not render a Case Study badge');
}

await testUnitBehaviors();
await testConfiguration();
await testSanityQueries();
await testBuiltSite();
await testNoPublicCounts();
await testNoInternalMetadata();
await testListingRows();
console.log('publication integration checks passed');
process.exit(0);
