const publicDocument = '!(_id in path("drafts.**")) && defined(slug.current)';
const publishedDocument = `${publicDocument} && defined(publishedAt) && publishedAt <= now()`;

const summaryFields = `
  _id,
  _type,
  title,
  "slug": slug.current,
  summary,
  publishedAt,
  featuredImage,
  featured,
  format,
  "kind": coalesce(format, kind),
  primaryTopic->{_id, title, "slug": slug.current},
  "relatedTopics": relatedTopics[]->{_id, title, "slug": slug.current}
`;

export const latestContentQuery = `*[_type in ["article", "project"] && ${publishedDocument}] | order(publishedAt desc)[0...6] {${summaryFields}}`;

export const workshopsQuery = `*[_type == "article" && (format == "workshop" || kind == "workshop") && ${publishedDocument}] | order(publishedAt desc) {${summaryFields}}`;

export const featuredArticlesQuery = `*[_type == "article" && ${publishedDocument}] | order(coalesce(featured, false) desc, publishedAt desc)[0...3] {${summaryFields}}`;

export const homepageQuery = `{
  "featured": *[_type == "article" && ${publishedDocument}] | order(coalesce(featured, false) desc, publishedAt desc)[0...3] {${summaryFields}},
  "latest": *[_type in ["article", "project"] && ${publishedDocument}] | order(publishedAt desc)[0...6] {${summaryFields}},
  "workshops": *[_type == "article" && (format == "workshop" || kind == "workshop") && ${publishedDocument}] | order(publishedAt desc)[0...3] {${summaryFields}},
  "systemDesignTopic": *[_type == "topic" && kind == "domain" && slug.current == "system-design" && ${publicDocument}][0] {
    _id, title, "slug": slug.current, summary,
    "archetypesTopic": *[_type == "topic" && parent._ref == ^._id && (slug.current == "archetypes" || title match "Archetype*") && ${publicDocument}][0] {
      _id, title, "slug": slug.current, summary
    }
  },
  "archetypesArticles": *[_type == "article" && ${publishedDocument} && (primaryTopic->slug.current == "archetypes" || "archetypes" in relatedTopics[]->slug.current)] | order(publishedAt desc)[0...3] {${summaryFields}},
  "systemDesignArticles": *[_type == "article" && ${publishedDocument} && (primaryTopic->slug.current in ["system-design", "distributed-systems", "design-patterns", "reliability-and-scale", "data-systems"] || "system-design" in relatedTopics[]->slug.current)] | order(publishedAt desc)[0...3] {${summaryFields}},
  "platformTopic": *[_type == "topic" && kind == "domain" && slug.current == "platform-engineering" && ${publicDocument}][0] {
    _id, title, "slug": slug.current, summary
  },
  "aiTopic": *[_type == "topic" && kind == "domain" && slug.current == "ai-engineering" && ${publicDocument}][0] {
    _id, title, "slug": slug.current, summary
  }
}`;

export const articlesQuery = `*[_type == "article" && ${publishedDocument}] | order(publishedAt desc) {${summaryFields}}`;
export const projectsQuery = `*[_type == "project" && ${publishedDocument}] | order(publishedAt desc) {${summaryFields}}`;

export const articleSlugsQuery = `*[_type == "article" && ${publishedDocument}].slug.current`;
export const projectSlugsQuery = `*[_type == "project" && ${publishedDocument}].slug.current`;
export const topicSlugsQuery = `*[_type == "topic" && ${publicDocument}].slug.current`;

export const topicsListQuery = `*[_type == "topic" && ${publicDocument}] | order(coalesce(order, 999) asc, title asc) {
  _id,
  _type,
  title,
  "slug": slug.current,
  kind,
  summary,
  icon,
  order,
  featured,
  parent->{_id, title, "slug": slug.current, kind},
  "articleCount": count(*[_type == "article" && ${publishedDocument} && (primaryTopic._ref == ^._id || ^._id in relatedTopics[]._ref)])
}`;

export const topicBySlugQuery = `*[_type == "topic" && slug.current == $slug && ${publicDocument}][0] {
  _id,
  _type,
  title,
  "slug": slug.current,
  kind,
  summary,
  description,
  icon,
  order,
  featured,
  parent->{_id, title, "slug": slug.current, kind},
  "subtopics": *[_type == "topic" && parent._ref == ^._id && ${publicDocument}] | order(coalesce(order, 999) asc, title asc) {
    _id,
    _type,
    title,
    "slug": slug.current,
    kind,
    icon
  },
  "articles": *[_type == "article" && ${publishedDocument} && (primaryTopic._ref == ^._id || ^._id in relatedTopics[]._ref)] | order(publishedAt desc) {
    ${summaryFields}
  }
}`;

export const articleBySlugQuery = `*[_type == "article" && slug.current == $slug && ${publishedDocument}][0] {
  ${summaryFields},
  body,
  format,
  "kind": coalesce(format, kind),
  primaryTopic->{_id, title, "slug": slug.current},
  relatedTopics[]->{_id, title, "slug": slug.current},
  difficulty,
  topics,
  repositoryUrl,
  demoUrl,
  technologies,
  bookAuthor,
  referenceUrl,
  seo
}`;

export const projectBySlugQuery = `*[_type == "project" && slug.current == $slug && ${publishedDocument}][0] {
  ${summaryFields}, body, technologies, repositoryUrl, projectUrl, seo
}`;

export const wikiNavQuery = `{
  "topics": *[_type == "topic" && ${publicDocument}] | order(coalesce(order, 999) asc, title asc) {
    _id,
    _type,
    title,
    "slug": slug.current,
    kind,
    summary,
    icon,
    order,
    featured,
    parent->{_id, title, "slug": slug.current, kind}
  },
  "articles": *[_type == "article" && ${publishedDocument}] {
    _id,
    title,
    "slug": slug.current,
    publishedAt,
    featured,
    primaryTopic->{_id, title, "slug": slug.current},
    "relatedTopics": relatedTopics[]->{_id, title, "slug": slug.current}
  }
}`;
