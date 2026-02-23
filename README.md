# 🎬 ElkaRec — Site Vitrine

Site web de l'association collégiale d'audiovisuel et d'événementiel **ElkaRec**, basée à Paris.

🔗 [elkarec.com](https://elkarec.com)

---

## Stack technique

| Techno | Rôle |
|:---|:---|
| [Astro 5](https://astro.build) | Framework SSG |
| [Tailwind CSS 4](https://tailwindcss.com) | Styling |
| [Cloudflare Pages](https://pages.cloudflare.com) | Hébergement & CDN |

---

## Lancer le projet en local

```bash
# Cloner le repo
git clone https://github.com/ton-org/elkarec-website.git
cd elkarec-website

# Installer les dépendances
npm install

# Lancer le serveur de dev
npm run dev
```

Le site tourne sur `http://localhost:4321`

---

## Commandes utiles

```bash
npm run dev       # Serveur de dev (hot reload)
npm run build     # Build de prod → ./dist/
npm run preview   # Prévisualiser le build en local
```

---

## Arborescence du projet

```
src/
├── assets/images/     # Images optimisées par Astro
├── components/        # Header, Footer, composants réutilisables
├── content/
│   ├── blog/          # Articles de blog (.md)
│   └── projects/      # Fiches projets (.md)
├── layouts/           # Layout principal
├── pages/             # Toutes les pages du site
│   ├── index.astro    # Accueil
│   ├── about.astro    # À propos
│   ├── services.astro # Services
│   ├── projects.astro # Projets
│   ├── join.astro     # Nous rejoindre
│   ├── contact.astro  # Contact
│   └── blog/          # Blog (index + articles dynamiques)
└── styles/
    └── global.css

public/                # Fichiers statiques (favicon, og-image, etc.)
```

---

## Ajouter un article de blog

Crée un fichier `.md` dans `src/content/blog/` :

```markdown
---
title: "Titre de l'article"
description: "Description courte"
pubDate: 2025-06-15
author: "Prénom Nom"
tags: ["Live", "Événement"]
image: "../../assets/images/mon-image.webp"
---

Contenu de l'article en markdown...
```

L'article apparaît automatiquement sur `/blog`.

---

## Ajouter un projet

Même principe dans `src/content/projects/` :

```markdown
---
title: "Nom du projet"
description: "Description courte"
category: "Live"
tags: ["Concert", "Streaming"]
date: 2025-01-10
image: "/image-dans-public.webp"
---
```

---

## Déploiement

Le site se déploie automatiquement sur **Cloudflare Pages** à chaque push sur `main`.

Pour un déploiement manuel :

```bash
npm run build
npx wrangler pages deploy dist
```

---

## Contribuer

1. Crée une branche depuis `main`
2. Fais tes modifs
3. Teste en local avec `npm run dev`
4. Push et ouvre une PR

---

## Licence

© 2025 ElkaRec — Tous droits réservés.

---

*Fait avec ☕ et beaucoup de gaffer par l'équipe ElkaRec.*