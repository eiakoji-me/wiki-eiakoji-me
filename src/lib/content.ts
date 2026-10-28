import { createClient, type QueryParams } from '@sanity/client';

const sanityClient = createClient({
  projectId: (typeof import.meta !== 'undefined' && import.meta.env?.PUBLIC_SANITY_PROJECT_ID) || process.env.PUBLIC_SANITY_PROJECT_ID || '7rp2puan',
  dataset: (typeof import.meta !== 'undefined' && import.meta.env?.PUBLIC_SANITY_DATASET) || process.env.PUBLIC_SANITY_DATASET || 'production',
  apiVersion: '2026-10-01',
  useCdn: false,
});

export async function fetchContent<T>(query: string, params: QueryParams = {}): Promise<T> {
  // Local fixture builds only (see README); never set in Netlify or CI.
  const fixtures = process.env.WIKI_FIXTURES;
  if (fixtures) {
    const { queryFixtures } = await import('./fixtures/index.ts');
    return queryFixtures<T>(fixtures, query, params);
  }
  return sanityClient.fetch<T>(query, params);
}

export function formatDate(value: string): string {
  return new Intl.DateTimeFormat('en', {
    dateStyle: 'long',
    timeZone: 'UTC',
  }).format(new Date(value));
}

export function contentHref(type: string, slug: string): string {
  if (type === 'topic') return `/topics/${slug}/`;
  if (type === 'project') return `/projects/${slug}/`;
  return `/articles/${slug}/`;
}

export const SITE_TITLE = 'wiki.eiakoji.me';

export function formatPageTitle(title?: string): string {
  return title ? `${title} · ${SITE_TITLE}` : SITE_TITLE;
}

/** Repository links are public only for workshops; no repository is named here. */
export function showRepositoryLink(item?: { repositoryUrl?: string; format?: string; kind?: string }): boolean {
  return Boolean(item?.repositoryUrl && (item.format === 'workshop' || item.kind === 'workshop'));
}
