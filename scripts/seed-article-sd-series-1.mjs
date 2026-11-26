// Seeds or updates the System Design Series I article in Sanity.
//
//   npm run seed:article:sd-series-1 -- --dataset <name> --dry-run
//   npm run seed:article:sd-series-1 -- --dataset <name> --write
import { readFile } from 'node:fs/promises';
import { createReadStream } from 'node:fs';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import os from 'node:os';
import { parseArgs } from 'node:util';
import { createClient } from '@sanity/client';

const usage = 'usage: seed-article-sd-series-1.mjs --dataset <name> (--dry-run | --write)';

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
  console.error('--write requires SANITY_WRITE_TOKEN in the environment or active Sanity CLI login in ~/.config/sanity/config.json');
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
const articlePath = path.join(__dirname, 'data', 'article-sd-series-1-classification.json');
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
  const diagramsDir = path.join(__dirname, '..', 'documentation', 'diagrams', 'sd-series-1');
  const uploadDiagram = async (filename) => {
    console.log(`Uploading ${filename} to Sanity...`);
    const filePath = path.join(diagramsDir, filename);
    const asset = await client.assets.upload('image', createReadStream(filePath), {
      filename,
    });
    console.log(`Uploaded ${filename}: ${asset._id}`);
    return asset._id;
  };

  const heroAssetId = await uploadDiagram('F02_extended_archetype_framework_clean.png');

  articleDoc.featuredImage = {
    _type: 'imageWithAlt',
    asset: {
      _type: 'reference',
      _ref: heroAssetId,
    },
    alt: 'Extended architectural archetype framework: taxonomy of fourteen core distributed systems patterns and their compositional boundaries.',
    caption: 'Figure 1: Extended architectural archetype framework: taxonomy of fourteen core distributed systems patterns and their compositional boundaries.',
  };

  if (articleDoc.seo) {
    articleDoc.seo.image = {
      _type: 'image',
      asset: {
        _type: 'reference',
        _ref: heroAssetId,
      },
    };
  }

  const result = await client.createOrReplace(articleDoc);
  console.log(`Created or replaced document ${result._id} in Sanity (new rev: ${result._rev}).`);
} else {
  console.log('Dry run complete. No changes made.');
}
