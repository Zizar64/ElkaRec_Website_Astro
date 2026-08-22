// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  site: 'https://elkarec.fr',
  output: 'static',
  integrations: [
    sitemap({
      // /join est préparée mais volontairement hors ligne tant que l'AGE
      // n'a pas modifié l'article 14 des statuts : hors navigation, en
      // noindex, et hors sitemap.
      filter: (page) => !page.includes('/join'),
    }),
  ],
  image: {
    service: {
      entrypoint: 'astro/assets/services/sharp'
    }
  },
  vite: {
    plugins: [tailwindcss()]
  }
});
