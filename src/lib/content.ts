import { createClient, type QueryParams } from '@sanity/client';

const sanityClient = createClient({
  projectId: (typeof import.meta !== 'undefined' && import.meta.env?.PUBLIC_SANITY_PROJECT_ID) || process.env.PUBLIC_SANITY_PROJECT_ID || '7rp2puan',
  dataset: (typeof import.meta !== 'undefined' && import.meta.env?.PUBLIC_SANITY_DATASET) || process.env.PUBLIC_SANITY_DATASET || 'production',
  apiVersion: '2026-10-01',
  useCdn: false,
});

export async function fetchContent<T>(query: string, params: QueryParams = {}): Promise<T> {
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
  if (type === 'article') return `/articles/${slug}/`;
  if (type === 'project') return `/projects/${slug}/`;
  return `/series/${slug}/`;
}

export const SITE_TITLE = 'wiki.eiakoji.me';

export function formatPageTitle(title?: string): string {
  return title ? `${title} · ${SITE_TITLE}` : SITE_TITLE;
}

export const FORMAT_LABELS: Record<string, string> = {
  article: 'Article',
  'deep-dive': 'Deep Dive',
  tutorial: 'Tutorial',
  workshop: 'Workshop',
  'case-study': 'Case Study',
  showcase: 'Showcase',
  'reading-note': 'Reading Note',
  'reading-notes': 'Reading Note',
  reference: 'Reference',
};

export function formatContentLabel(
  formatOrKind?: string,
  type?: string
): string {
  if (type === 'series') return 'Series';
  if (type === 'project') return 'Case Study';
  if (!formatOrKind) return 'Article';
  return (
    FORMAT_LABELS[formatOrKind] ??
    formatOrKind
      .split('-')
      .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
      .join(' ')
  );
}

export interface CoreDomainTopic {
  _id: string;
  _type: 'topic';
  title: string;
  slug: string;
  summary: string;
}

export const CORE_DOMAIN_TOPICS: Record<string, CoreDomainTopic> = {
  'system-design': {
    _id: 'domain-system-design',
    _type: 'topic',
    title: 'System Design',
    slug: 'system-design',
    summary: 'Architecture patterns, distributed systems foundations, and real-world system case studies.',
  },
  'platform-engineering': {
    _id: 'domain-platform-engineering',
    _type: 'topic',
    title: 'Platform Engineering',
    slug: 'platform-engineering',
    summary: 'Internal developer platforms, infrastructure as code, runtime environments, and developer experience.',
  },
  'ai-engineering': {
    _id: 'domain-ai-engineering',
    _type: 'topic',
    title: 'AI Engineering',
    slug: 'ai-engineering',
    summary: 'Machine learning systems, generative AI architectures, agentic workflows, and LLM application engineering.',
  },
};
