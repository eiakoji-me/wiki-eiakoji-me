// Publishes/syncs all production content and diagram assets to Sanity.
//
//   npm run seed:publish
import { execFileSync } from 'node:child_process';

const token = process.env.SANITY_WRITE_TOKEN;
if (!token) {
  console.error('SANITY_WRITE_TOKEN is required to publish content to Sanity.');
  process.exit(1);
}

const run = (script, ...args) => {
  console.log(`\n=== Running ${script} ${args.join(' ')} ===`);
  execFileSync('node', [script, ...args], {
    stdio: 'inherit',
    env: { ...process.env, SANITY_WRITE_TOKEN: token },
  });
};

console.log('Starting automated Sanity content synchronization...');

// 1. Domains & Taxonomy
run('scripts/seed-domains.mjs', '--dataset', 'production', '--write');
run('scripts/seed-taxonomy.mjs', '--dataset', 'production', '--write');

// 2. Individual Articles with Diagram Assets
run('scripts/seed-article-aee.mjs', '--dataset', 'production', '--write');
run('scripts/seed-article-poeaa-part-1.mjs', '--dataset', 'production', '--write');
run('scripts/seed-article-eip-part-1.mjs', '--dataset', 'production', '--write');
run('scripts/seed-article-eip-part-2.mjs', '--dataset', 'production', '--write');
run('scripts/seed-article-eip-part-3.mjs', '--dataset', 'production', '--write');
run('scripts/seed-article-eip-part-4.mjs', '--dataset', 'production', '--write');
run('scripts/seed-article-eip-part-5.mjs', '--dataset', 'production', '--write');
run('scripts/seed-article-eip-part-6.mjs', '--dataset', 'production', '--write');
run('scripts/seed-article-eip-part-7.mjs', '--dataset', 'production', '--write');

// 3. EIP Series Roadmap
run('scripts/seed-eip-series.mjs', '--dataset', 'production', '--write');

console.log('\nAll production content successfully synchronized to Sanity.');
