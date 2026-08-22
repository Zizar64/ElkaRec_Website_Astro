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
│   ├── robots.txt          # SEO
│   └── favicon.png         # Favicon
│   # _headers a ete supprime : il etait propre a Cloudflare Pages.
│   # Les en-tetes de securite vivent dans le Caddyfile du LXC 105.
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
│   ├── content/            # 📝 Contenu
│   │   ├── config.ts       # Configuration des collections
│   │   └── projects/       # Projets, affiches sur /services
│   │
│   ├── layouts/            # 🎨 Layouts
│   │   └── Layout.astro    # Layout principal
│   │
│   ├── pages/              # 📄 Pages du site
│   │   ├── index.astro     # Accueil : accroche, references, parc, upcycling
│   │   ├── services.astro  # Offres, tarifs et realisations
│   │   ├── contact.astro   # Demande de devis
│   │   └── join.astro      # Adherer - PREPAREE, PAS PUBLIEE
│   │
│   └── styles/             # 🎨 Styles
│       └── global.css      # Styles globaux
│
├── astro.config.mjs        # ⚙️ Configuration Astro (dont le filtre sitemap)
├── package.json            # 📦 Dépendances
└── tsconfig.json           # 🔧 Configuration TypeScript
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
- **Serveur web** : [Caddy](https://caddyserver.com) - sur le LXC 105 du lab
- **Exposition** : [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/) - TLS et cache, sans port ouvert
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

> **Le blog a été supprimé le 2026-08-22.** Pages, index, articles et
> collection `src/content/blog/` ont été retirés du dépôt. Les 5 Markdown sont
> archivés hors dépôt, dans
> `02_ELKAREC\05_COMMUNICATION\Archives_blog_site\`.
> `/blog` et `/blog/*` renvoient une 301 vers `/services`.

### Nouveau projet

Il apparaît automatiquement dans la section « Nos réalisations » de
`/services`, l'ancienne page `/projects` ayant fusionné là.
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

Le site **n'est plus sur Cloudflare Pages** depuis le 2026-08-16 : il est
auto-hébergé sur le lab (LXC 105, Caddy, derrière un tunnel Cloudflare).
Éditer le dépôt ne publie rien tant que ces trois étapes ne sont pas faites :

```bash
# 1. Publier la source
git push origin main

# 2. Sur le LXC 105 : fetch origin/main, build, bascule atomique
elkarec-deploy

# 3. Purger le cache Cloudflare  ← SINON RIEN NE CHANGE POUR LES VISITEURS
```

L'étape 3 n'est pas optionnelle : le cache est en « Cache Everything » avec un
Edge TTL d'un mois, pour que le site reste servi même serveur éteint. Sans
purge, un déploiement reste invisible pendant des heures.

⚠️ `elkarec-deploy` fait un `git reset --hard origin/main` : tout commit resté
local est perdu au déploiement suivant.

Détail complet de l'hébergement : projet `Homelab`,
`KB/apps/elkarec-web/elkarec-web.md`.

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
