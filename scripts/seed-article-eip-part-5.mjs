// Seeds or updates the EIP Part V article in Sanity.
//
//   npm run seed:article:eip-part-5 -- --dataset <name> --dry-run
//   SANITY_WRITE_TOKEN=... npm run seed:article:eip-part-5 -- --dataset <name> --write
import { readFile, writeFile } from 'node:fs/promises';
import { createReadStream, existsSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import { parseArgs } from 'node:util';
import { createClient } from '@sanity/client';

const usage = 'usage: seed-article-eip-part-5.mjs --dataset <name> (--dry-run | --write)';

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
const articlePath = path.join(__dirname, 'data', 'article-eip-part-5.json');
const articleDoc = JSON.parse(await readFile(articlePath, 'utf8'));

console.log(`Dataset ${client.config().projectId}/${values.dataset} (${values.write ? 'write' : 'dry run'})`);
console.log(`Target document: ${articleDoc._id} ("${articleDoc.title}")`);

const diagramsDir = path.join(__dirname, '..', 'documentation', 'diagrams', 'eip-part-5');
const requiredDiagrams = [
  'eip-part-5-hero-monochrome.png',
  'eip-part-5-claim-check-pattern.png',
  'eip-part-5-canonical-model-vs-acl.png',
];

for (const filename of requiredDiagrams) {
  const filePath = path.join(diagramsDir, filename);
  if (!existsSync(filePath)) {
    console.error(`Required diagram file missing: ${filePath}`);
    process.exit(1);
  }
}
console.log(`Verified ${requiredDiagrams.length} diagram assets exist on disk.`);

const existing = await client.getDocument(articleDoc._id);
if (existing) {
  console.log(`Document ${articleDoc._id} already exists in ${values.dataset} (revision: ${existing._rev}).`);
} else {
  console.log(`Document ${articleDoc._id} does not exist yet in ${values.dataset}.`);
}

if (values.write) {
  const uploadDiagram = async (filename) => {
    console.log(`Uploading ${filename} to Sanity...`);
    const filePath = path.join(diagramsDir, filename);
    const asset = await client.assets.upload('image', createReadStream(filePath), {
      filename,
    });
    console.log(`Uploaded ${filename}: ${asset._id}`);
    return asset._id;
  };

  const heroAssetId = await uploadDiagram('eip-part-5-hero-monochrome.png');
  const claimCheckAssetId = await uploadDiagram('eip-part-5-claim-check-pattern.png');
  const canonicalAclAssetId = await uploadDiagram('eip-part-5-canonical-model-vs-acl.png');

  articleDoc.featuredImage = {
    _type: 'imageWithAlt',
    asset: {
      _type: 'reference',
      _ref: heroAssetId,
    },
    alt: 'Enterprise message transformation and data interoperability overview: normalizers, content enrichers, claim check storage, and bounded contexts.',
    caption: 'Figure 1: Enterprise Message Transformation Pipeline — from ingress normalization and schema adaptation to content hydration, privacy filtering, and blob offloading.',
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

  // Update content diagram image blocks
  for (const block of articleDoc.body) {
    if (block._type === 'imageWithAlt') {
      if (block._key === 'img-hero-transformation') {
        block.asset = { _type: 'reference', _ref: heroAssetId };
      } else if (block._key === 'img-claim-check') {
        block.asset = { _type: 'reference', _ref: claimCheckAssetId };
      } else if (block._key === 'img-canonical-vs-acl') {
        block.asset = { _type: 'reference', _ref: canonicalAclAssetId };
      }
    }
  }

  await writeFile(articlePath, JSON.stringify(articleDoc, null, 2) + '\n', 'utf8');

  const result = await client.createOrReplace(articleDoc);
  console.log(`Created or replaced document ${result._id} (new rev: ${result._rev}).`);
} else {
  console.log('Dry run complete. No changes made.');
}
