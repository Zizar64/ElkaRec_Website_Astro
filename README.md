# 🎬 ElkaRec — Site Vitrine

Site web de l'association collégiale d'audiovisuel et d'événementiel **ElkaRec**, installée à Antony (92).

🔗 [elkarec.fr](https://elkarec.fr) — domaine canonique depuis le 2026-08-13.
`elkarec.com` est conservé et redirige en 301 vers le `.fr`.

---

## Stack technique

| Techno | Rôle |
|:---|:---|
| [Astro 5](https://astro.build) | Framework SSG |
| [Tailwind CSS 4](https://tailwindcss.com) | Styling |
| [Caddy](https://caddyserver.com) | Serveur web, sur le LXC 105 du lab |
| [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/) | Exposition, TLS et cache, sans port ouvert |

---

## Lancer le projet en local

```bash
# Cloner le repo
git clone https://github.com/Zizar64/ElkaRec_Website_Astro.git
cd ElkaRec_Website_Astro

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
│   └── projects/      # Fiches projets (.md), affichées sur /services
├── layouts/           # Layout principal
├── pages/
│   ├── index.astro    # Accueil : accroche, références, parc, upcycling
│   ├── services.astro # Offres, tarifs et réalisations
│   ├── contact.astro  # Demande de devis
│   └── join.astro     # Adhérer — PRÉPARÉE, PAS PUBLIÉE (voir plus bas)
└── styles/
    └── global.css

public/                # Fichiers statiques (favicon, robots.txt)
```

---

## La page Adhérer n'est pas publiée

`src/pages/join.astro` existe et est complète, mais elle est
**volontairement hors ligne** : absente de la navigation, en `noindex`, et
exclue du sitemap par un filtre dans `astro.config.mjs`.

En l'état des statuts, l'article 14 fait de **chaque** adhérent un membre de
la direction collégiale : ouvrir les adhésions reviendrait à faire de chaque
nouveau venu un co-dirigeant engageant sa responsabilité personnelle. La page
ne sera mise en ligne qu'après l'assemblée générale extraordinaire.

Ne pas la remettre dans la navigation sans feu vert explicite.

---

## Ajouter un projet

Crée un fichier `.md` dans `src/content/projects/`. Il apparaît
automatiquement dans la section « Nos réalisations » de `/services` :

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

Le site n'est **plus sur Cloudflare Pages** : il est auto-hébergé sur le lab,
sur le conteneur LXC 105, servi par Caddy derrière un tunnel Cloudflare.
Éditer ce dépôt ne publie donc rien tant que les trois étapes suivantes ne
sont pas faites :

```bash
# 1. Publier la source
git push origin main

# 2. Sur le LXC 105 : récupère origin/main, build, bascule atomique
elkarec-deploy

# 3. Purger le cache Cloudflare  ← SINON RIEN NE CHANGE POUR LES VISITEURS
```

L'étape 3 n'est pas optionnelle : le cache est en « Cache Everything » avec
un Edge TTL d'un mois, pour que le site survive à l'extinction du serveur.
Un déploiement sans purge reste invisible pendant des heures.

Autres commandes disponibles sur le conteneur :

```bash
elkarec-deploy list       # liste les versions, marque celle qui est servie
elkarec-deploy rollback   # revient à la version précédente
```

⚠️ `elkarec-deploy` fait un `git reset --hard origin/main` : tout commit
resté local est perdu au déploiement suivant.

Les en-têtes de sécurité (CSP, HSTS, cache) ne sont **pas** dans ce dépôt :
ils vivent dans le `Caddyfile` du conteneur. L'ancien `public/_headers`
était propre à Cloudflare Pages et a été supprimé.

Documentation complète de l'hébergement : projet `Homelab`,
`KB/apps/elkarec-web/elkarec-web.md`.

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