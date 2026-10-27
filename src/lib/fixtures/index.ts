// Local fixture datasets for checking taxonomy layouts without a seeded Sanity
// dataset. Enabled only when WIKI_FIXTURES is set for a local build; Netlify and
// CI never set it. Queries run unchanged through groq-js.
import { evaluate, parse } from 'groq-js';

type Doc = Record<string, unknown> & { _id: string; _type: string };

const slug = (current: string) => ({ _type: 'slug', current });
const ref = (_ref: string) => ({ _type: 'reference', _ref });

function topic(_id: string, kind: 'domain' | 'topic' | undefined, title: string, parent?: string, order?: number): Doc {
  const doc: Doc = {
    _id,
    _type: 'topic',
    title,
    slug: slug(_id.replace(/^(drafts\.)?(domain|topic)-/, '')),
    summary: `Notes, patterns, and references on ${title}.`,
  };
  if (kind) doc.kind = kind;
  if (parent) doc.parent = ref(parent);
  if (order !== undefined) doc.order = order;
  return doc;
}

function article(_id: string, title: string, publishedAt: string, primaryTopic: string, relatedTopics: string[] = []): Doc {
  return {
    _id,
    _type: 'article',
    title,
    slug: slug(_id.replace(/^article-/, '')),
    summary: `A fixture entry about ${title}.`,
    format: 'article',
    publishedAt,
    primaryTopic: ref(primaryTopic),
    relatedTopics: relatedTopics.map(ref),
  };
}

const systemDesign = topic('domain-system-design', 'domain', 'System Design', undefined, 1);

const partial: Doc[] = [
  systemDesign,
  topic('topic-distributed-systems', 'topic', 'Distributed Systems', 'domain-system-design'),
  topic('topic-languages', undefined, 'Languages'),
  topic('drafts.topic-draft-only', 'topic', 'Draft Only', 'domain-system-design'),
];

const full: Doc[] = [
  topic('domain-ai-engineering', 'domain', 'AI Engineering', undefined, 3),
  topic('domain-platform-engineering', 'domain', 'Platform Engineering', undefined, 2),
  systemDesign,
  topic('topic-reliability', 'topic', 'Reliability and Scale', 'domain-system-design', 2),
  topic('topic-distributed-systems', 'topic', 'Distributed Systems', 'domain-system-design', 1),
  topic('topic-consensus', 'topic', 'Consensus', 'topic-distributed-systems'),
  topic('topic-raft', 'topic', 'Raft', 'topic-consensus'),
  topic('topic-storage-engines', 'topic', 'Storage Engines', 'topic-distributed-systems'),
  topic('topic-internal-platforms', 'topic', 'Internal Developer Platforms', 'domain-platform-engineering'),
  topic('topic-infrastructure-as-code', 'topic', 'Infrastructure as Code', 'domain-platform-engineering'),
  topic('topic-agentic-workflows', 'topic', 'Agentic Workflows', 'domain-ai-engineering'),
  topic('topic-languages', undefined, 'Languages'),
  topic('drafts.topic-draft-only', 'topic', 'Draft Only', 'domain-system-design'),
  article('article-raft-log-replication', 'Raft Log Replication', '2026-09-01T00:00:00Z', 'topic-raft', ['topic-consensus']),
  article('article-lsm-trees', 'LSM Trees', '2026-09-15T00:00:00Z', 'topic-storage-engines'),
  article('article-golden-paths', 'Golden Paths', '2026-10-01T00:00:00Z', 'topic-internal-platforms'),
  article('article-ai-execution-environment-architecture', 'Architecture of an Issue-Driven AI Execution Environment', '2026-10-27T17:03:11.012Z', 'domain-platform-engineering', ['topic-agentic-workflows', 'topic-internal-platforms']),
  article('article-future-post', 'Scheduled Post', '2099-01-01T00:00:00Z', 'topic-agentic-workflows'),
  // Its primary topic is unclassified, so the article must not link to a topic page.
  article('article-language-notes', 'Language Notes', '2026-08-01T00:00:00Z', 'topic-languages'),
];

export const FIXTURE_DATASETS: Record<string, Doc[]> = { empty: [], partial, full };

export async function queryFixtures<T>(name: string, query: string, params: Record<string, unknown> = {}): Promise<T> {
  const dataset = FIXTURE_DATASETS[name];
  if (!dataset) {
    throw new Error(`Unknown WIKI_FIXTURES value "${name}"; use ${Object.keys(FIXTURE_DATASETS).join(', ')}.`);
  }
  const result = await evaluate(parse(query, { params }), { dataset, params });
  return (await result.get()) as T;
}
