// Patches the sequence callout items in Sanity for all 8 EIP articles without touching assets or other fields.
//
//   node scripts/patch-eip-callouts.mjs --dataset <name> --dry-run
//   SANITY_WRITE_TOKEN=... node scripts/patch-eip-callouts.mjs --dataset <name> --write
import { readFile } from 'node:fs/promises';
import path from 'node:path';
import os from 'node:os';
import { parseArgs } from 'node:util';
import { createClient } from '@sanity/client';

const usage = 'usage: patch-eip-callouts.mjs --dataset <name> (--dry-run | --write)';

const { values } = parseArgs({
  options: {
    dataset: { type: 'string' },
    'dry-run': { type: 'boolean', default: false },
    write: { type: 'boolean', default: false },
  },
});

if (!values.dataset || values['dry-run'] === values.write) {
  console.error(usage);
  process.exit(2);
}

const resolveToken = async () => {
  if (process.env.SANITY_WRITE_TOKEN) {
    return process.env.SANITY_WRITE_TOKEN;
  }
  try {
    const configPath = path.join(os.homedir(), '.config', 'sanity', 'config.json');
    const raw = await readFile(configPath, 'utf8');
    const parsed = JSON.parse(raw);
    if (parsed.authToken) return parsed.authToken;
  } catch {
    // ignore
  }
  return null;
};

const token = await resolveToken();
if (values.write && !token) {
  console.error('--write requires SANITY_WRITE_TOKEN in the environment or active Sanity CLI login.');
  process.exit(2);
}

const client = createClient({
  projectId: process.env.PUBLIC_SANITY_PROJECT_ID || '7rp2puan',
  dataset: values.dataset,
  apiVersion: '2026-10-01',
  useCdn: false,
  token,
});

const CANONICAL_SERIES = [
  { _key: 'nav-eip-1', title: 'Part I: Foundations of Enterprise Integration', href: '/articles/eip-part-1-foundations-of-enterprise-integration/' },
  { _key: 'nav-eip-2', title: 'Part II: Messaging Channels & Communication Models', href: '/articles/eip-part-2-messaging-channels/' },
  { _key: 'nav-eip-3', title: 'Part III: Message Construction & Exchange Semantics', href: '/articles/eip-part-3-message-construction/' },
  { _key: 'nav-eip-4', title: 'Part IV: Message Routing & Process Coordination', href: '/articles/eip-part-4-message-routing/' },
  { _key: 'nav-eip-5', title: 'Part V: Message Transformation & Interoperability', href: '/articles/eip-part-5-message-transformation/' },
  { _key: 'nav-eip-6', title: 'Part VI: Messaging Endpoints & Reliable Processing', href: '/articles/eip-part-6-messaging-endpoints/' },
  { _key: 'nav-eip-7', title: 'Part VII: Operations, Observability & Governance', href: '/articles/eip-part-7-integration-operations/' },
  { _key: 'nav-eip-8', title: 'Part VIII: Composing Enterprise Integration Patterns', href: '/articles/eip-part-8-composing-enterprise-integration-patterns/' },
];

const ARTICLE_IDS = [
  'article-eip-part-1-foundations-of-enterprise-integration',
  'article-eip-part-2-messaging-channels',
  'article-eip-part-3-message-construction',
  'article-eip-part-4-message-routing',
  'article-eip-part-5-message-transformation',
  'article-eip-part-6-messaging-endpoints',
  'article-eip-part-7-integration-operations',
  'article-eip-part-8-composing-enterprise-integration-patterns',
];

console.log(`Targeting dataset ${client.config().projectId}/${values.dataset} (${values.write ? 'WRITE' : 'DRY RUN'})`);

for (let part = 1; part <= 8; part++) {
  const docId = ARTICLE_IDS[part - 1];
  const updatedItems = CANONICAL_SERIES.map((item, idx) => {
    const isCurrent = (idx + 1) === part;
    if (isCurrent) {
      return {
        _key: item._key,
        title: item.title,
        status: 'current',
      };
    }
    return {
      _key: item._key,
      title: item.title,
      status: 'completed',
      href: item.href,
    };
  });

  console.log(`\nPart ${part} (${docId}):`);
  const doc = await client.getDocument(docId);
  if (!doc) {
    console.error(`Document not found: ${docId}`);
    continue;
  }
  const calloutIndex = (doc.body || []).findIndex((b) => b._type === 'callout' && b._key === 'b-eip-series-nav');
  if (calloutIndex === -1) {
    console.error(`Callout block b-eip-series-nav not found in ${docId}`);
    continue;
  }

  console.log(`Current revision: ${doc._rev}`);
  if (values.write) {
    const patchResult = await client
      .patch(docId)
      .set({ [`body[${calloutIndex}].items`]: updatedItems })
      .commit();
    console.log(`Patched ${docId} -> new rev: ${patchResult._rev}`);
  } else {
    console.log(`[DRY RUN] Would set callout items to 8 canonical completed/current parts.`);
  }
}

console.log(`\n${values.write ? 'Successfully patched all EIP series callouts.' : 'Dry run complete. No changes made.'}`);
