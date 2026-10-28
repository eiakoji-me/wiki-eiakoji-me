import type { TopicKind } from '../taxonomy.ts';
import type { PortableTextBlock } from '@portabletext/types';
import type { SanityImageSource } from '@sanity/image-url';

export interface SanityImage {
  asset: SanityImageSource;
  alt: string;
  caption?: string;
}

export interface SeoFields {
  title?: string;
  description?: string;
  image?: SanityImage;
}

export type ContentFormat =
  | 'article'
  | 'tutorial'
  | 'workshop'
  | 'case-study'
  | 'showcase'
  | 'reading-note'
  | 'reference';

export interface ContentSummary {
  _id: string;
  _type: 'article' | 'project' | 'topic';
  title: string;
  slug: string;
  summary: string;
  publishedAt?: string;
  featuredImage?: SanityImage;
  featured?: boolean;
  format?: ContentFormat;
  kind?: string;
  primaryTopic?: {
    _id: string;
    title: string;
    slug: string;
  };
  relatedTopics?: Array<{
    _id: string;
    title: string;
    slug: string;
  }>;
}

export interface CodeBlock {
  _key: string;
  _type: 'codeBlock';
  code: string;
  language?: string;
  filename?: string;
}

export interface CalloutItem {
  _key?: string;
  title: string;
  href?: string;
  status?: string;
}

export interface CalloutBlock {
  _key: string;
  _type: 'callout';
  tone?: string;
  title?: string;
  items?: CalloutItem[];
}

export type BodyBlock = PortableTextBlock | SanityImage | CodeBlock | CalloutBlock;

export interface Topic {
  _id: string;
  _type: 'topic';
  title: string;
  slug: string;
  kind?: TopicKind;
  summary: string;
  description?: BodyBlock[];
  icon?: string;
  order?: number;
  featured?: boolean;
  parent?: {
    _id: string;
    title: string;
    slug: string;
    kind?: TopicKind;
  };
  articleCount?: number;
}

export interface Article extends ContentSummary {
  _type: 'article';
  body: BodyBlock[];
  format?: ContentFormat;
  kind?: string;
  primaryTopic?: {
    _id: string;
    title: string;
    slug: string;
  };
  relatedTopics?: Array<{
    _id: string;
    title: string;
    slug: string;
  }>;
  difficulty?: 'Fundamentals' | 'Intermediate' | 'Advanced';
  topics?: string[];
  repositoryUrl?: string;
  demoUrl?: string;
  technologies?: string[];
  bookAuthor?: string;
  referenceUrl?: string;
  seo?: SeoFields;
}

export interface Project extends ContentSummary {
  _type: 'project';
  body: BodyBlock[];
  technologies?: string[];
  repositoryUrl?: string;
  projectUrl?: string;
  seo?: SeoFields;
}
