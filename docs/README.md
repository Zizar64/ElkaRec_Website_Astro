# 📚 Documentation du projet ElkaRec Website

## 📖 Guides disponibles

### 🖼️ [Guide de gestion des images](./IMAGES.md)
Documentation complète sur la nouvelle structure d'organisation des images :
- Organisation des dossiers
- Bonnes pratiques
- Utilisation dans le code
- Avantages de la nouvelle structure

### 🔄 [Guide de migration des images](./MIGRATION-IMAGES.md)
Guide étape par étape pour migrer vers la nouvelle structure WebP :
- Plan d'action détaillé
- Checklist complète
- Exemples de code avant/après
- Résolution de problèmes

## 🚀 Démarrage rapide

### Installation
```bash
npm install
```

### Développement
```bash
npm run dev
# Ouvre http://localhost:4321
```

### Build
```bash
npm run build
```

### Prévisualisation
```bash
npm run preview
```

### Conversion des images en WebP
```bash
npm run convert:images
```

## 📁 Structure du projet

```
/
├── docs/                    # 📚 Documentation
│   ├── README.md           # Ce fichier
│   ├── IMAGES.md           # Guide des images
│   └── MIGRATION-IMAGES.md # Guide de migration
│
├── public/                  # 🌐 Fichiers statiques
│   ├── _headers            # Headers de sécurité
│   ├── robots.txt          # SEO
│   ├── favicon.svg         # Favicon
│   └── *.webp              # Images statiques
│
├── scripts/                 # 🛠️ Scripts utilitaires
│   ├── convert-images-to-webp.js  # Conversion WebP
│   └── security-check.sh   # Vérification sécurité
│
├── src/
│   ├── assets/             # 🖼️ Assets optimisés
│   │   └── images/         # Images WebP optimisées
│   │
│   ├── components/         # 🧩 Composants réutilisables
│   │   ├── Header.astro
│   │   └── Footer.astro
│   │
│   ├── content/            # 📝 Contenu (blog, projets)
│   │   ├── config.ts       # Configuration des collections
│   │   ├── blog/           # Articles de blog
│   │   └── projects/       # Projets
│   │
│   ├── layouts/            # 🎨 Layouts
│   │   └── Layout.astro    # Layout principal
│   │
│   ├── pages/              # 📄 Pages du site
│   │   ├── index.astro     # Page d'accueil
│   │   ├── about.astro     # À propos
│   │   ├── services.astro  # Services
│   │   ├── projects.astro  # Projets
│   │   ├── join.astro      # Nous rejoindre
│   │   ├── contact.astro   # Contact
│   │   └── blog/           # Blog
│   │
│   └── styles/             # 🎨 Styles
│       └── global.css      # Styles globaux
│
├── astro.config.mjs        # ⚙️ Configuration Astro
├── package.json            # 📦 Dépendances
├── tsconfig.json           # 🔧 Configuration TypeScript
└── wrangler.toml           # ☁️ Configuration Cloudflare
```

## 🎯 Commandes disponibles

| Commande | Description |
|----------|-------------|
| `npm install` | Installer les dépendances |
| `npm run dev` | Démarrer le serveur de développement |
| `npm run build` | Build de production |
| `npm run preview` | Prévisualiser le build |
| `npm run convert:images` | Convertir les images en WebP |

## 🔧 Technologies utilisées

- **Framework** : [Astro 5](https://astro.build) - Framework web moderne
- **Styling** : [Tailwind CSS 4](https://tailwindcss.com) - Framework CSS utility-first
- **Images** : [Sharp](https://sharp.pixelplumbing.com/) - Optimisation d'images
- **Déploiement** : [Cloudflare Pages](https://pages.cloudflare.com) - Hébergement et CDN
- **Language** : TypeScript - Type safety

## 📊 Optimisations appliquées

### ✅ Performance
- ⚡ Génération statique (SSG)
- 🖼️ Images optimisées en WebP
- 📦 Code splitting automatique
- 🚀 CDN global (Cloudflare)
- 💨 Lazy loading des images

### ✅ SEO
- 🔍 Sitemap automatique
- 🏷️ Métadonnées complètes (Open Graph, Twitter Cards)
- 📱 Schema.org (Organisation)
- 🤖 robots.txt configuré
- 🔗 URLs canoniques

### ✅ Sécurité
- 🔒 Headers de sécurité (CSP, HSTS, etc.)
- 🛡️ Protection contre clickjacking
- 🔐 HTTPS forcé
- 🚫 Permissions restrictives

### ✅ Accessibilité
- ♿ Skip navigation
- 🏷️ Attributs ARIA
- 🎯 Focus visible
- 📝 Alt texts sur les images

## 🎨 Personnalisation

### Couleurs
Les couleurs principales sont définies dans Tailwind CSS :
- **Rouge principal** : `red-500` (#ef4444)
- **Fond** : `zinc-950` (noir profond)
- **Texte** : `zinc-100` (blanc cassé)

### Polices
Le projet utilise les polices système pour de meilleures performances.

## 📝 Ajouter du contenu

### Nouvel article de blog
```bash
# Créer un fichier dans src/content/blog/
touch src/content/blog/mon-article.md
```

```markdown
---
title: "Titre de l'article"
description: "Description courte"
pubDate: 2026-02-22
author: "Nom de l'auteur"
tags: ["tag1", "tag2"]
image: "/image.webp"
---

# Contenu de l'article

Votre contenu en Markdown...
```

### Nouveau projet
```bash
# Créer un fichier dans src/content/projects/
touch src/content/projects/mon-projet.md
```

```markdown
---
title: "Titre du projet"
description: "Description courte"
category: "Catégorie"
tags: ["tag1", "tag2"]
date: 2026-02-22
image: "/image.webp"
---

# Description du projet

Votre contenu en Markdown...
```

## 🚀 Déploiement

### Cloudflare Pages (recommandé)

1. Connecter le repository GitHub
2. Configuration :
   - **Build command** : `npm run build`
   - **Build output** : `dist`
   - **Node version** : `20`
3. Déployer

### Via Wrangler CLI

```bash
# Build
npm run build

# Déployer
wrangler pages deploy dist
```

## 🐛 Résolution de problèmes

### Les dépendances ne s'installent pas
```bash
# Nettoyer le cache
rm -rf node_modules package-lock.json
npm install
```

### Le build échoue
```bash
# Vérifier les erreurs TypeScript
npm run astro check

# Nettoyer et rebuilder
rm -rf dist .astro
npm run build
```

### Les images ne s'affichent pas
```bash
# Vérifier que les images existent
ls src/assets/images/

# Vérifier les imports dans le code
grep -r "from.*images" src/
```

## 📞 Support

Pour toute question ou problème :
- 📧 Contact : via le [formulaire de contact](https://elkarec.fr/contact)
- 🐛 Issues : [GitHub Issues](https://github.com/Zizar64/ElkaRec_Website_Astro/issues)

## 📄 Licence

© 2025-2026 ElkaRec. Tous droits réservés.
