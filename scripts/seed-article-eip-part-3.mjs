// Seeds or updates the EIP Part III article in Sanity.
//
//   npm run seed:article:eip-part-3 -- --dataset <name> --dry-run
//   SANITY_WRITE_TOKEN=... npm run seed:article:eip-part-3 -- --dataset <name> --write
import { readFile, writeFile } from 'node:fs/promises';
import { createReadStream, existsSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import { parseArgs } from 'node:util';
import { createClient } from '@sanity/client';

const usage = 'usage: seed-article-eip-part-3.mjs --dataset <name> (--dry-run | --write)';

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
const articlePath = path.join(__dirname, 'data', 'article-eip-part-3.json');
const articleDoc = JSON.parse(await readFile(articlePath, 'utf8'));

console.log(`Dataset ${client.config().projectId}/${values.dataset} (${values.write ? 'write' : 'dry run'})`);
console.log(`Target document: ${articleDoc._id} ("${articleDoc.title}")`);

const diagramsDir = path.join(__dirname, '..', 'documentation', 'diagrams', 'eip-part-3');
const requiredDiagrams = [
  'eip-part-3-hero-monochrome.png',
  'eip-part-3-message-envelope.png',
  'eip-part-3-async-request-reply.png',
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

  const heroAssetId = await uploadDiagram('eip-part-3-hero-monochrome.png');
  const envelopeAssetId = await uploadDiagram('eip-part-3-message-envelope.png');
  const asyncReqReplyAssetId = await uploadDiagram('eip-part-3-async-request-reply.png');

  articleDoc.featuredImage = {
    _type: 'imageWithAlt',
    asset: {
      _type: 'reference',
      _ref: heroAssetId,
    },
    alt: 'Enterprise message construction and exchange semantics: envelope anatomy, command/document/event intent triad, and asynchronous request-reply correlation.',
    caption: 'Figure 1: Enterprise message construction and exchange semantics — deconstructing message envelopes, semantic intent classifications, and asynchronous request-reply correlation.',
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
      if (block._key === 'img-hero-construction') {
        block.asset = { _type: 'reference', _ref: heroAssetId };
      } else if (block._key === 'img-envelope-anatomy') {
        block.asset = { _type: 'reference', _ref: envelopeAssetId };
      } else if (block._key === 'img-async-request-reply') {
        block.asset = { _type: 'reference', _ref: asyncReqReplyAssetId };
      }
    }
  }

  await writeFile(articlePath, JSON.stringify(articleDoc, null, 2) + '\n', 'utf8');

  const result = await client.createOrReplace(articleDoc);
  console.log(`Created or replaced document ${result._id} (new rev: ${result._rev}).`);
} else {
  console.log('Dry run complete. No changes made.');
}
