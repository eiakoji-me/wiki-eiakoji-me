import { defineArrayMember, defineField, defineType } from 'sanity';

export const blockContent = defineType({
  name: 'blockContent',
  title: 'Content',
  type: 'array',
  of: [
    defineArrayMember({
      type: 'block',
      styles: [
        { title: 'Normal', value: 'normal' },
        { title: 'Heading 2', value: 'h2' },
        { title: 'Heading 3', value: 'h3' },
        { title: 'Quote', value: 'blockquote' },
      ],
      marks: {
        annotations: [
          {
            name: 'link',
            title: 'Link',
            type: 'object',
            fields: [
              defineField({
                name: 'href',
                title: 'URL',
                type: 'url',
                validation: (rule) =>
                  rule.required().uri({
                    allowRelative: true,
                    scheme: ['http', 'https', 'mailto'],
                  }),
              }),
            ],
          },
        ],
      },
    }),
    defineArrayMember({ type: 'imageWithAlt' }),
    defineArrayMember({
      name: 'codeBlock',
      title: 'Code block',
      type: 'object',
      fields: [
        defineField({
          name: 'code',
          title: 'Code',
          type: 'text',
          rows: 14,
          validation: (rule) => rule.required(),
        }),
        defineField({
          name: 'language',
          title: 'Language',
          type: 'string',
        }),
        defineField({
          name: 'filename',
          title: 'Filename',
          type: 'string',
        }),
      ],
      preview: {
        select: { title: 'filename', subtitle: 'language' },
        prepare: ({ title, subtitle }) => ({
          title: title || 'Code block',
          subtitle: subtitle || 'Plain text',
        }),
      },
    }),
    defineArrayMember({
      name: 'callout',
      title: 'Callout',
      type: 'object',
      fields: [
        defineField({
          name: 'tone',
          title: 'Tone',
          type: 'string',
          options: {
            list: [
              { title: 'Series Navigation', value: 'series' },
              { title: 'Note', value: 'note' },
              { title: 'Tip', value: 'tip' },
              { title: 'Warning', value: 'warning' },
            ],
          },
          initialValue: 'series',
        }),
        defineField({
          name: 'title',
          title: 'Title',
          type: 'string',
        }),
        defineField({
          name: 'items',
          title: 'Items',
          type: 'array',
          of: [
            defineArrayMember({
              type: 'object',
              fields: [
                defineField({ name: 'title', title: 'Title', type: 'string', validation: (rule) => rule.required() }),
                defineField({ name: 'href', title: 'Link URL', type: 'string' }),
                defineField({
                  name: 'status',
                  title: 'Status',
                  type: 'string',
                  options: {
                    list: [
                      { title: 'Current', value: 'current' },
                      { title: 'Upcoming', value: 'upcoming' },
                      { title: 'Completed', value: 'completed' },
                    ],
                  },
                }),
              ],
            }),
          ],
        }),
      ],
      preview: {
        select: { title: 'title', subtitle: 'tone' },
        prepare: ({ title, subtitle }) => ({
          title: title || 'Callout',
          subtitle: subtitle || 'Callout card',
        }),
      },
    }),
  ],
});
