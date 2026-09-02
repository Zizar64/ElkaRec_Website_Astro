// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import sitemap from '@astrojs/sitemap';
import { execFileSync } from 'node:child_process';

// `lastmod` du sitemap : la date du dernier commit qui a touché la source de
// la page, pas la date du build. Toutes les pages sont bâties à la même
// seconde, donc dater du build reviendrait à annoncer le site entier comme
// modifié à chaque déploiement — Google ignore un lastmod qu'il constate
// faux, et le signal est perdu.
//
// Le dépôt est cloné en entier sur le conteneur de déploiement, `git log` y
// est disponible. En cas d'échec (dossier sans git, binaire absent), on
// n'écrit pas de lastmod : mieux vaut pas de signal qu'un faux signal.
function dateDuDernierCommit(fichier) {
  try {
    const sortie = execFileSync('git', ['log', '-1', '--format=%cI', '--', fichier], {
      encoding: 'utf8',
      stdio: ['ignore', 'pipe', 'ignore'],
    }).trim();
    return sortie || undefined;
  } catch {
    return undefined;
  }
}

// Source de chaque URL construite. Les fiches de réalisation sont générées
// depuis leur Markdown : c'est lui qui date la page, pas le gabarit.
function sourceDeLaPage(url) {
  const chemin = new URL(url).pathname.replace(/^\/|\/$/g, '');

  if (chemin === '') return 'src/pages/index.astro';
  if (chemin === 'realisations') return 'src/pages/realisations/index.astro';

  const fiche = chemin.match(/^realisations\/(.+)$/);
  if (fiche) return `src/content/projects/${fiche[1]}.md`;

  return `src/pages/${chemin}.astro`;
}

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
      serialize(item) {
        const lastmod = dateDuDernierCommit(sourceDeLaPage(item.url));
        if (lastmod) item.lastmod = lastmod;
        return item;
      },
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
