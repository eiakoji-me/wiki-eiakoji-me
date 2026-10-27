// Seeds or updates the AI Execution Environment architecture article draft in Sanity.
//
//   npm run seed:article:aee -- --dataset <name> --dry-run
//   SANITY_WRITE_TOKEN=... npm run seed:article:aee -- --dataset <name> --write
//
// The write token is read only from the environment and is never stored.
import { readFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import { parseArgs } from 'node:util';
import { createClient } from '@sanity/client';

const usage = 'usage: seed-article-aee.mjs --dataset <name> (--dry-run | --write)';

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

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const articlePath = path.join(__dirname, 'data', 'article-aee.json');
const articleDoc = JSON.parse(await readFile(articlePath, 'utf8'));

console.log(`Dataset ${client.config().projectId}/${values.dataset} (${values.write ? 'write' : 'dry run'})`);
console.log(`Target document: ${articleDoc._id} ("${articleDoc.title}")`);

const existing = await client.getDocument(articleDoc._id);
if (existing) {
  console.log(`Document ${articleDoc._id} already exists in ${values.dataset} (revision: ${existing._rev}).`);
} else {
  console.log(`Document ${articleDoc._id} does not exist yet in ${values.dataset}.`);
}

if (values.write) {
  const result = await client.createOrReplace(articleDoc);
  console.log(`Created or replaced document ${result._id} (new rev: ${result._rev}).`);
} else {
  console.log('Dry run complete. No changes made.');
}
