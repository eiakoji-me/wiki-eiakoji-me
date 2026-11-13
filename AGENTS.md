# Project instructions

- This repository owns the publication at `wiki.eiakoji.me`; it does not own
  the Hugo personal site at `eiakoji.me`.
- Use strict TypeScript and keep Sanity queries centralized under
  `src/lib/sanity/`.
- Public queries must exclude drafts, require slugs, and respect `publishedAt`.
- SEO metadata limits in `sanity/schemaTypes/seo.ts`:
  - `meta.title`: maximum 65 characters (`rule.max(65)`). Do not append site branding suffixes (`— wiki.eiakoji.me`), as the layout automatically appends `· wiki.eiakoji.me`.
  - `meta.description`: maximum 170 characters (`rule.max(170)`).
- Never commit tokens, `.env`, Netlify local state, build-hook URLs, or other
  credentials.
- Do not deploy the reader site or Studio, create webhooks, or change CORS/DNS
  without explicit operator approval.
- Before committing, run `npm run verify`.
