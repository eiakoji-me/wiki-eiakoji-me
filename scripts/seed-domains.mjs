// Seeds the three approved domains into a Sanity dataset.
//
//   npm run seed:domains -- --dataset <name> --dry-run
//   SANITY_WRITE_TOKEN=... npm run seed:domains -- --dataset <name> --write
//
// The write token is read only from the environment and is never stored.
import { parseArgs } from 'node:util';
import { createClient } from '@sanity/client';
import { EXISTING_TOPICS_QUERY, planDomainSeed } from './domains.ts';

const usage = 'usage: seed-domains.mjs --dataset <name> (--dry-run | --write)';

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

const token = process.env.SANITY_WRITE_TOKEN;
if (values.write && !token) {
  console.error('--write requires SANITY_WRITE_TOKEN in the environment.');
  process.exit(2);
}

const client = createClient({
  projectId: process.env.PUBLIC_SANITY_PROJECT_ID || '7rp2puan',
  dataset: values.dataset,
  apiVersion: '2026-10-01',
  useCdn: false,
  token,
});

function report(plan) {
  if (plan.changes.length === 0) console.log('No changes: the domains are already seeded.');
  for (const change of plan.changes) console.log(`- ${change}`);
  for (const warning of plan.warnings) console.warn(`! ${warning}`);
}

const plan = planDomainSeed(await client.fetch(EXISTING_TOPICS_QUERY));
console.log(`Dataset ${client.config().projectId}/${values.dataset} (${values.write ? 'write' : 'dry run'})`);
report(plan);

if (values.write && plan.mutations.length > 0) {
  await client.mutate(plan.mutations, { visibility: 'sync' });
  const remaining = planDomainSeed(await client.fetch(EXISTING_TOPICS_QUERY));
  console.log(`Applied ${plan.mutations.length} mutation(s). Remaining changes: ${remaining.mutations.length}.`);
  if (remaining.mutations.length > 0) process.exit(1);
}
