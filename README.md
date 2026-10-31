# wiki.eiakoji.me

Technical articles, project write-ups, and engineering references published
with Astro and Sanity.

## Architecture

- **Astro + TypeScript** renders a static reader site.
- **Sanity** project `7rp2puan`, dataset `production`, stores structured content.
- **Sanity Studio** is configured in this repository and hosted by Sanity at
  <https://wiki-eiakoji-me.sanity.studio>, separately from the reader site.
- **Netlify** is prepared to build the static site from `main`; this repository
  does not create a Netlify project, deploy, or change DNS.

Published content is fetched during each Astro build. Sanity changes therefore
appear after the next build. Once deployment is approved, connect a private
Netlify build hook to a Sanity webhook; never commit the hook URL.

## Prerequisites

- Node.js 24
- npm 11+
- Access to Sanity project `7rp2puan` for authoring

## Local setup

```sh
cp .env.example .env
npm install
npm run dev
```

The reader site is available at `http://localhost:4321`.

Project ID and dataset are public identifiers, not secrets. Never add a Sanity
token to a `PUBLIC_` variable or commit a token to this repository.

## Content authoring

Publish from any machine with the hosted Studio at
<https://wiki-eiakoji-me.sanity.studio>. Sign in with an account that is a
member of Sanity project `7rp2puan`.

To work on the schema, run Studio locally in a separate terminal:

```sh
npm run studio
```

Studio defaults to `http://localhost:3333`. If Sanity asks for a CORS origin,
add only that controlled local origin and enable credentials.

Schema and Studio changes reach the hosted Studio only when it is redeployed.
After the change is merged to `main`, and with operator approval, run:

```sh
npm run studio:deploy
```

The app ID in `sanity.cli.ts` targets the existing hosted Studio, so the
command never creates a new one. `deployment.autoUpdates` keeps the hosted
Studio on the latest compatible `sanity` release without a redeploy.

The initial content model contains:

- `article` — long-form technical writing;
- `project` — project case studies and implementation notes;
- `topic` — the taxonomy. Each topic has a `kind`: a `domain` is a top-level
  area with no parent, and a `topic` sits under a domain or another topic. The
  left navigation is built from this tree, and topics outside it are left out
  and reported during the build.

Sanity's native draft/published lifecycle controls visibility. Public queries
also require a slug and a publication date that is not in the future.

### Seeding domains

The header links to the System Design, Platform Engineering, and AI Engineering
domains, so those documents must exist before the site builds them. Seed them
with a token that has write access, kept only in your shell:

```sh
npm run seed:domains -- --dataset production --dry-run
SANITY_WRITE_TOKEN=... npm run seed:domains -- --dataset production --write
```

The seed creates or corrects the three domains, never deletes, and never
replaces a summary written in Studio. Running it again reports no changes.

### Seeding topics and featured articles

`scripts/data/taxonomy.json` lists the topics under each domain and the articles
the left navigation features. Run `seed:domains` first, then:

```sh
npm run seed:taxonomy -- --dataset production --dry-run
SANITY_WRITE_TOKEN=... npm run seed:taxonomy -- --dataset production --write
```

- Topics are created, or classified as topics, and their placement is checked
  with the same rule the site uses. A topic with a missing parent, a cycle, a
  chain that does not end at a domain, a chain that is too deep, or a slug that
  is already taken is not seeded, and neither are its children. The command
  then exits 1.
- Topic fields are only filled in where they are missing. A value written in
  Studio is never overwritten; when it differs from the data file, the seed
  warns and keeps it. The titles, slugs, and summaries in the data file are
  defaults for new topics, so change an existing topic in Studio.
- The seed owns article `featured` and `primaryTopic`. Every run sets them to the
  values in the data file, so unfeaturing an article in Studio is undone by the
  next run; remove the entry from the data file instead.
- `seed:article:aee` and `seed:article:poeaa-part-1` replace the whole article,
  so run `seed:taxonomy` again after either of them.
- The seed warns when a seeded topic or article has an unpublished draft, because
  publishing that draft would replace the seeded values. Drafts are private, so
  these warnings appear only when `SANITY_WRITE_TOKEN` is set; a dry run without
  a token cannot see them.
- Nothing is ever deleted or unset, and domains are never changed. Running it
  again reports no changes.

## Commands

| Command | Purpose |
| --- | --- |
| `npm run dev` | Start Astro development server |
| `npm run check` | Run Astro and TypeScript diagnostics |
| `npm run build` | Build the static reader site into `dist/` |
| `npm run preview` | Preview the Astro production build |
| `npm run studio` | Start Sanity Studio locally |
| `npm run studio:build` | Validate and build Studio without deploying |
| `npm run studio:deploy` | Build and deploy the hosted Studio (operator approval required) |
| `npm run test:publication` | Exercise built routes, metadata, configuration, and live GROQ queries |
| `npm run test:taxonomy` | Check the taxonomy seed planner and its effect on the navigation |
| `npm run verify` | Run checks, both production builds, publication integration tests, and taxonomy seed tests |

## Netlify preparation

`netlify.toml` sets `npm run build` and publishes `dist`. The eventual Netlify
project needs these build variables:

```text
PUBLIC_SANITY_PROJECT_ID=7rp2puan
PUBLIC_SANITY_DATASET=production
```

Build-variable changes require a new deploy before they take effect. `.netlify`
is ignored because its local state must never be committed.

Deployment, build-hook creation, custom-domain configuration, and DNS changes
are intentionally deferred until explicit approval.

## Verification

```sh
npm ci
npm run verify
```

The production dataset may be empty. In that state, the site intentionally
builds useful empty pages rather than shipping fixture content.

To check layouts against a populated taxonomy without touching Sanity, build
from local fixtures into a scratch directory (never `dist/`):

```sh
WIKI_FIXTURES=full npx astro build --outDir /tmp/wiki-fixtures
```

`WIKI_FIXTURES` accepts `empty`, `partial`, or `full`, and runs the real queries
against `src/lib/fixtures/` with `groq-js`. Never set it in Netlify or CI.
