# ElkaRec Website - Documentation Projet

## Vue d'ensemble

Site web moderne pour ElkaRec, une association audiovisuelle et événementielle collégiale basée à Paris.

**Technologies principales:**
- Framework: Astro 5.15.4
- Styling: Tailwind CSS 4.1.17
- Déploiement: Cloudflare Pages
- Langage: TypeScript

## Architecture du projet

### Structure des dossiers

```
ElkaRec_Website_Astro/
├── .claude/              # Configuration Claude
├── public/               # Assets statiques
│   ├── favicon.svg       # Icône du site
│   ├── logo.png          # Logo ElkaRec (utilisé dans Header)
│   ├── robots.txt        # Directives pour les crawlers
│   ├── elkast.jpg        # Image projet ELKAST
│   ├── concert.jpg       # Image projet Festivals & Concerts
│   ├── regie.jpg         # Image projet Régie Mobile
│   ├── video-ip.jpg      # Image projet Formations IP Video
│   └── eco.jpg           # Image projet Éco-conception AV
├── src/
│   ├── components/       # Composants réutilisables
│   │   ├── Header.astro  # Navigation principale (desktop + mobile)
│   │   └── Footer.astro  # Pied de page
│   ├── content/          # Collections de contenu
│   │   ├── blog/         # Articles de blog (markdown)
│   │   │   ├── eco-conception-audiovisuel.md
│   │   │   ├── introduction-video-ip.md
│   │   │   └── regie-mobile-multicam.md
│   │   └── config.ts     # Schémas Zod pour les collections
│   ├── layouts/          # Layouts de pages
│   │   └── Layout.astro  # Layout principal avec SEO
│   ├── pages/            # Routes et pages
│   │   ├── index.astro   # Page d'accueil
│   │   ├── about.astro   # À propos
│   │   ├── services.astro # Services
│   │   ├── projects.astro # Projets
│   │   ├── join.astro    # Rejoindre l'association
│   │   ├── contact.astro # Contact
│   │   └── blog/
│   │       ├── index.astro      # Liste des articles
│   │       └── [...slug].astro  # Page article dynamique
│   └── styles/
│       └── global.css    # Styles globaux (import Tailwind)
├── astro.config.mjs      # Configuration Astro
├── wrangler.toml         # Configuration Cloudflare
├── package.json          # Dépendances et scripts
└── tsconfig.json         # Configuration TypeScript
```

## Caractéristiques techniques

### Configuration Astro
- **Mode de sortie:** Static (SSG - Static Site Generation)
- **Adapter:** Cloudflare (même en mode static pour l'optimisation)
- **Plugin Vite:** Tailwind CSS intégré via @tailwindcss/vite
- **Site URL:** https://elkarec.fr (configuré pour génération sitemap)
- **Intégrations:**
  - `@astrojs/sitemap`: Génération automatique du sitemap XML
- **Service d'images:** Sharp pour optimisation des images

### Schémas de contenu (src/content/config.ts)

**Collection Blog:**
- title: string
- description: string
- pubDate: date
- author: string
- tags: array de strings
- image: string (optionnel)

**Collection Projects:**
- title: string
- description: string
- category: string
- tags: array de strings
- date: date (optionnel)
- image: string (optionnel)

### Design System

**Palette de couleurs (Tailwind):**
- Fond principal: `bg-zinc-950` (noir profond)
- Texte principal: `text-zinc-100` (blanc cassé)
- Accent principal: `bg-red-500`, `text-red-400`, `text-red-500` (rouge ElkaRec)
- Titres principaux: `text-red-500` (rouge solide pour lisibilité)
- Accents secondaires: `bg-blue-500/10` (bleu transparent)
- Bordures: `border-zinc-800`
- Cartes: `bg-zinc-900`

**Décisions de design:**
- Tous les titres de pages (H1) utilisent un rouge solide (`text-red-500`) au lieu de dégradés pour améliorer la lisibilité
- Logo image utilisé dans le header au lieu de texte (hauteur: 24px)

**Composants de navigation:**
- Header fixe avec backdrop-blur
- Navigation responsive (desktop/mobile)
- Menu mobile avec toggle JavaScript vanilla
- Indicateur de page active (couleur rouge)

## Pages principales

### 1. Page d'accueil (index.astro)

**Sections:**
1. **Hero:** Titre rouge solide "Accompagner, Créer, Innover", CTA vers Services et Rejoindre
2. **Notre approche:** 3 cartes (Accompagner, Créer, Innover)
3. **Aperçu services:** 4 services principaux
4. **CTA Rejoindre:** Section avec gradient rouge

**Effets visuels:**
- Dégradés animés sur le fond (pulse)
- Éléments de fond flous (blur-3xl)
- Animations au survol (hover:scale-105)
- Indicateur de scroll animé (bounce)

**Accessibilité:**
- `<main id="main-content">` pour la navigation par clavier (skip navigation)

### 2. Structure du Header

**Logo:**
- Logo image ElkaRec (`/logo.png`)
- Dimensions: 140x25px (hauteur affichée: 24px)
- Optimisé avec `fetchpriority="high"` pour chargement prioritaire

**Navigation:**
- Accueil (/)
- À propos (/about)
- Services (/services)
- Projets (/projects)
- Blog (/blog)
- Nous rejoindre (/join)
- Contact (/contact)

**Comportement mobile:**
- Bouton hamburger avec ARIA attributes (`aria-expanded`, `aria-controls`, `aria-label`)
- Menu déroulant avec `<nav>` sémantique et `aria-label="Navigation mobile"`
- Script JavaScript pour le toggle avec mise à jour dynamique de `aria-expanded`

### 3. Layout principal (Layout.astro)

**Features SEO:**
- Meta description personnalisable
- Canonical URL dynamique
- Meta robots (index, follow)
- Open Graph complet (type, url, title, description, image, locale, site_name)
- Twitter Cards (summary_large_image)
- Theme color (#ef4444 - rouge ElkaRec)
- Preload des ressources critiques (logo)
- Schema.org Organization (JSON-LD) avec coordonnées et liens sociaux
- Viewport responsive
- Favicon SVG
- Generator meta tag (Astro)
- Langue: Français

**Accessibilité:**
- Lien "skip navigation" (sr-only, visible au focus) pour aller directement au contenu principal
- Classes de focus personnalisées pour une meilleure visibilité au clavier

**Style de base:**
- Fond sombre (zinc-950)
- Texte clair (zinc-100)
- Antialiasing activé

### 4. Page Projets (projects.astro)

**Projets affichés (avec images):**
1. **ELKAST** (elkast.jpg) - Production podcast
2. **Festivals & Concerts** (concert.jpg) - Technique événementielle
3. **Régie Mobile** (regie.jpg) - Infrastructure
4. **Conférences & Talks** (pas d'image) - Captation événementielle
5. **Formations IP Video** (video-ip.jpg) - Formation
6. **Éco-conception AV** (eco.jpg) - Recherche & Développement

**Optimisations images:**
- Toutes les images ont des dimensions explicites (1920x1080)
- `loading="lazy"` pour le chargement différé
- `decoding="async"` pour le décodage asynchrone
- Positionnement personnalisé selon le contenu:
  - ELKAST: `object-contain` (centré)
  - Festivals & Concerts: `object-cover` (remplit l'encart)
  - Régie Mobile: `object-cover` avec `object-position: center 45%`
  - Formations IP Video: `object-cover` avec `object-position: 70% center`
  - Éco-conception AV: `object-cover`

**Sections:**
- Hero avec titre rouge solide
- Grille de projets (3 colonnes sur desktop)
- Section statistiques avec 4 métriques
- Section technologies & expertises (4 domaines)
- CTA contact

## Optimisations récentes (2025)

### SEO
✅ **Sitemap & Robots.txt**
- Génération automatique du sitemap via `@astrojs/sitemap`
- Fichier `robots.txt` avec référence au sitemap
- URL du site configurée: https://elkarec.fr

✅ **Meta tags avancés**
- Open Graph pour Facebook/LinkedIn
- Twitter Cards pour partages sociaux
- Canonical URLs sur toutes les pages
- Meta robots (index, follow)
- Theme color pour les navigateurs mobiles

✅ **Structured Data**
- Schema.org Organization en JSON-LD
- Informations complètes (nom, description, logo, adresse, réseaux sociaux)

### Performance
✅ **Optimisation des images**
- Service Sharp configuré pour l'optimisation automatique
- Lazy loading sur toutes les images de projets
- Async decoding pour éviter le blocage du rendu
- Dimensions explicites pour éviter le layout shift
- Preload du logo critique avec `fetchpriority="high"`

### Accessibilité
✅ **Navigation clavier**
- Skip navigation link pour aller au contenu principal
- ID `#main-content` sur l'élément main

✅ **ARIA attributes**
- `aria-expanded` sur le bouton menu mobile
- `aria-controls` pour lier le bouton au menu
- `aria-label` descriptifs sur les contrôles interactifs
- `<nav>` sémantique avec `aria-label` pour le menu mobile

✅ **Focus management**
- États de focus visibles et personnalisés
- Outline rouge avec ring pour cohérence visuelle

### Scores d'analyse (avant optimisations)
- **Code Quality:** 6.5/10
- **Performance:** 5/10 (amélioré à ~7-8/10 après optimisations)
- **SEO:** 4/10 (amélioré à ~8/10 après optimisations)
- **Accessibilité:** 5.5/10 (amélioré à ~7.5/10 après optimisations)

## Scripts NPM

```bash
npm run dev      # Serveur de développement (localhost:4321)
npm run build    # Build de production (dist/)
npm run preview  # Preview du build
```

## Déploiement Cloudflare Pages

**Configuration:**
- Build command: `npm run build`
- Build output directory: `dist`
- Node version: 20+

**Fichier wrangler.toml:**
- Configuration pour déploiement via Wrangler CLI
- Alternative: déploiement via dashboard Cloudflare

## Philosophie de l'association

**ElkaRec est:**
- Une association collégiale (sans hiérarchie traditionnelle)
- Basée à Paris
- Axée sur l'audiovisuel et l'événementiel
- Composée de bénévoles passionnés

**Valeurs:**
1. **Accompagner:** Soutenir créateurs et événements
2. **Créer:** Développer des projets audiovisuels innovants
3. **Innover:** Favoriser le développement technologique

## Articles de blog existants

1. **Régie mobile multicam** (regie-mobile-multicam.md)
2. **Éco-conception audiovisuel** (eco-conception-audiovisuel.md)
3. **Introduction vidéo IP** (introduction-video-ip.md)

## Conventions de code

**Astro:**
- Composants en `.astro`
- Props TypeScript typées avec interface
- Frontmatter pour la logique
- Templates HTML en bas

**Styles:**
- Tailwind utility-first
- Classes longues sur plusieurs lignes pour lisibilité
- Pas de CSS custom (tout en Tailwind)

**Naming:**
- PascalCase pour composants
- kebab-case pour fichiers markdown
- camelCase pour variables JS

## Points d'attention pour le développement

1. **Performance:**
   - ✅ Site statique optimisé avec Sharp
   - ✅ Lazy loading et async decoding sur les images
   - ✅ Preload des ressources critiques
   - ⚠️ Images pourraient être converties en WebP pour meilleure compression

2. **Accessibilité:**
   - ✅ Skip navigation implémenté
   - ✅ ARIA labels et attributes sur composants interactifs
   - ✅ Structure sémantique (nav, main, article)
   - ✅ États de focus visibles

3. **Responsive:**
   - ✅ Mobile-first design
   - ✅ Breakpoints Tailwind (md:, lg:)
   - ✅ Menu mobile fonctionnel avec ARIA

4. **SEO:**
   - ✅ Sitemap automatique généré
   - ✅ robots.txt configuré
   - ✅ Meta descriptions sur toutes les pages
   - ✅ Open Graph et Twitter Cards
   - ✅ Schema.org Organization
   - ✅ Canonical URLs

5. **Animations:**
   - ✅ Subtiles et performantes (CSS uniquement)
   - Dégradés animés (pulse), hover effects, transitions

## Dépendances critiques

- `astro`: Framework principal (v5.15.4)
- `@astrojs/cloudflare`: Adapter Cloudflare
- `@astrojs/sitemap`: Génération automatique du sitemap
- `tailwindcss`: Styling (v4.1.17)
- `@tailwindcss/vite`: Plugin Vite pour Tailwind
- `sharp`: Optimisation des images

## Versions Node

Fichier `.node-version` présent (Node 20 recommandé)

## Prochaines étapes potentielles

### Améliorations prioritaires
- ✅ ~~Optimiser les images (Sharp configuré)~~
- ✅ ~~Ajouter des images/photos (5 projets avec images)~~
- ✅ ~~Améliorer SEO (sitemap, robots.txt, meta tags, Schema.org)~~
- ✅ ~~Améliorer accessibilité (skip nav, ARIA)~~
- Implémenter formulaire de contact fonctionnel (actuellement alert JS)
- Convertir images en WebP pour optimisation supplémentaire
- Créer des composants réutilisables (Card, Button, Section) pour réduire la duplication de code

### Fonctionnalités futures
- Ajouter plus de contenu blog
- Créer une page de détail pour chaque projet
- Ajouter analytics (Plausible ou Google Analytics)
- Configurer domaine custom (elkarec.fr déjà configuré)
- Ajouter un système de newsletter
- Implémenter un mode PWA (Service Worker, manifest)
- Ajouter un système de recherche pour le blog

### Optimisations techniques
- Implémenter Critical CSS inline
- Utiliser Astro Image component pour optimisation avancée
- Ajouter un système de cache pour les images
- Optimiser les fonts (preload, font-display: swap)
- Mettre en place des tests E2E (Playwright)
