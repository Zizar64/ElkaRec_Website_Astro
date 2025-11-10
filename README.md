# ElkaRec Website

Modern website for ElkaRec, a collegial audiovisual and events association based in Paris.

Built with [Astro](https://astro.build), styled with [Tailwind CSS](https://tailwindcss.com), and deployed on [Cloudflare Pages](https://pages.cloudflare.com).

## Features

- Modern, responsive design with dark theme
- Static site generation for optimal performance
- Blog with markdown support
- SEO optimized
- Fast page loads
- Fully accessible

## Project Structure

```
/
├── public/              # Static assets (images, favicon, etc.)
├── src/
│   ├── components/      # Reusable components
│   │   ├── Header.astro
│   │   └── Footer.astro
│   ├── content/         # Content collections
│   │   ├── blog/        # Blog posts (markdown)
│   │   └── config.ts    # Content schema
│   ├── layouts/         # Page layouts
│   │   └── Layout.astro
│   ├── pages/           # Pages and routes
│   │   ├── index.astro  # Homepage
│   │   ├── about.astro
│   │   ├── services.astro
│   │   ├── projects.astro
│   │   ├── join.astro
│   │   ├── contact.astro
│   │   └── blog/
│   │       ├── index.astro
│   │       └── [...slug].astro
│   └── styles/
│       └── global.css   # Global styles
├── astro.config.mjs     # Astro configuration
├── wrangler.toml        # Cloudflare configuration
└── package.json
```

## Development

### Prerequisites

- Node.js 20 or higher
- npm or pnpm

### Commands

| Command | Action |
|:---|:---|
| `npm install` | Install dependencies |
| `npm run dev` | Start dev server at `localhost:4321` |
| `npm run build` | Build production site to `./dist/` |
| `npm run preview` | Preview production build locally |

### Development Workflow

1. Clone the repository
2. Install dependencies: `npm install`
3. Start dev server: `npm run dev`
4. Open `http://localhost:4321` in your browser

## Adding Content

### Blog Posts

Create new blog posts in `src/content/blog/` as markdown files:

```markdown
---
title: "Your Post Title"
description: "Post description"
pubDate: 2025-01-15
author: "Author Name"
tags: ["tag1", "tag2"]
---

# Your content here

Write your blog post content in markdown...
```

### Modifying Pages

Pages are in `src/pages/`. Edit the `.astro` files to modify content.

## Deployment to Cloudflare Pages

### Option 1: Via Cloudflare Dashboard (Recommended)

1. Push your code to a Git repository (GitHub, GitLab, etc.)
2. Log in to [Cloudflare Dashboard](https://dash.cloudflare.com)
3. Go to **Pages** → **Create a project**
4. Connect your Git repository
5. Configure build settings:
   - **Build command**: `npm run build`
   - **Build output directory**: `dist`
   - **Node version**: `20`
6. Click **Deploy**

### Option 2: Via Wrangler CLI

1. Install Wrangler: `npm install -g wrangler`
2. Login: `wrangler login`
3. Build: `npm run build`
4. Deploy: `wrangler pages deploy dist`

### Environment Variables

No environment variables are required for the static site. If you add dynamic features later (API routes, etc.), configure them in the Cloudflare Pages dashboard.

## Custom Domain

To use the custom domain `elkarec.com`:

1. In Cloudflare Pages dashboard, go to your project
2. Navigate to **Custom domains**
3. Click **Set up a custom domain**
4. Enter `elkarec.com` and `www.elkarec.com`
5. Follow the DNS configuration instructions

## Performance

The site is optimized for performance:

- Static site generation
- Minimal JavaScript
- Optimized assets
- CDN delivery via Cloudflare
- Fast first contentful paint

## Technologies

- **Framework**: [Astro 5](https://astro.build)
- **Styling**: [Tailwind CSS 4](https://tailwindcss.com)
- **Deployment**: [Cloudflare Pages](https://pages.cloudflare.com)
- **Language**: TypeScript

## Contributing

This is a private project for ElkaRec. If you're a member and want to contribute:

1. Create a feature branch
2. Make your changes
3. Test locally
4. Submit a pull request

## License

© 2025 ElkaRec. All rights reserved.

## Support

For questions or issues, contact the ElkaRec team via the [contact page](https://elkarec.com/contact).
