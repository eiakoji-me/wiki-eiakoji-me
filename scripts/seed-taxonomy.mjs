// Seeds topics and featured-article flags from scripts/data/taxonomy.json into a Sanity dataset.
//
//   npm run seed:taxonomy -- --dataset <name> --dry-run
//   SANITY_WRITE_TOKEN=... npm run seed:taxonomy -- --dataset <name> --write
//
// Run seed:domains first. The write token is read only from the environment and is never stored.
import { readFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { parseArgs } from 'node:util';
import { createClient } from '@sanity/client';
import { TAXONOMY_STATE_QUERY, planTaxonomySeed, taxonomyQueryParams } from './taxonomy.ts';

const usage = 'usage: seed-taxonomy.mjs --dataset <name> (--dry-run | --write)';

let values;
try {
  ({ values } = parseArgs({
    options: {
      dataset: { type: 'string' },
      'dry-run': { type: 'boolean', default: false },
      write: { type: 'boolean', default: false },
    },
  }));
} catch (error) {
  console.error(error.message);
  console.error(usage);
  process.exit(2);
}

if (!values.dataset || values['dry-run'] === values.write) {
  console.error(usage);
  process.exit(2);
}

const token = process.env.SANITY_WRITE_TOKEN;
if (values.write && !token) {
  console.error('--write requires SANITY_WRITE_TOKEN in the environment.');
  process.exit(2);
}

const seedPath = fileURLToPath(new URL('./data/taxonomy.json', import.meta.url));
const seed = JSON.parse(await readFile(seedPath, 'utf8'));

const client = createClient({
  projectId: process.env.PUBLIC_SANITY_PROJECT_ID || '7rp2puan',
  dataset: values.dataset,
  apiVersion: '2026-10-01',
  useCdn: false,
  token,
});

const fetchState = () => client.fetch(TAXONOMY_STATE_QUERY, taxonomyQueryParams(seed));

function report(plan) {
  if (plan.changes.length === 0) console.log('No changes: the taxonomy is already seeded.');
  for (const change of plan.changes) console.log(`- ${change}`);
  for (const warning of plan.warnings) console.warn(`! ${warning}`);
}

const plan = planTaxonomySeed(await fetchState(), seed);
console.log(`Dataset ${client.config().projectId}/${values.dataset} (${values.write ? 'write' : 'dry run'})`);
report(plan);

if (values.write && plan.mutations.length > 0) {
  await client.mutate(plan.mutations, { visibility: 'sync' });
  const remaining = planTaxonomySeed(await fetchState(), seed);
  console.log(`Applied ${plan.mutations.length} mutation(s). Remaining changes: ${remaining.mutations.length}.`);
  if (remaining.mutations.length > 0) process.exit(1);
}

if (plan.blocked.length > 0) {
  console.error(`Not seeded: ${plan.blocked.join(', ')}. Resolve the warnings above and rerun.`);
  process.exit(1);
}
