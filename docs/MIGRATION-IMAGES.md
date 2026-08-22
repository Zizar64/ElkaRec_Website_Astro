# 🔄 Guide de migration des images vers WebP

> 📌 **Document historique.** Il décrit une migration déjà faite et
> renvoie à des fichiers qui n'existent plus (`about.astro`,
> `projects.astro`, `src/pages/blog/`, `src/content/blog/`), supprimés
> lors de la refonte de contenu du 2026-08-22. Conservé pour la
> méthode, pas comme état courant du dépôt.

## ✅ Conversion terminée !

**27 images** ont été converties avec succès en WebP et placées dans `src/assets/images/`

## 📋 Fichiers à mettre à jour

### 1. src/pages/services.astro

**Avant :**
```astro
import regieImage from '../content/images/regie_service.png';
import sonoImage from '../content/images/sono.png';
```

**Après :**
```astro
import regieImage from '../assets/images/regie_service.webp';
import sonoImage from '../assets/images/sono.webp';
```

### 2. src/pages/index.astro

**Avant :**
```astro
image="/concert.jpg"
```

**Après :**
```astro
---
import concertImage from '../assets/images/concert.webp';
---
<Layout
  title="ElkaRec - Association audiovisuelle et événementielle"
  description="..."
  image={concertImage.src}
>
```

**OU** (si vous préférez garder dans public/) :
```astro
image="/concert.webp"
```
*Note: Dans ce cas, copiez `src/assets/images/concert.webp` vers `public/concert.webp`*

### 3. Autres pages avec images

Fichiers à vérifier :
- `src/pages/about.astro` → image="/concert.jpg"
- `src/pages/contact.astro` → image="/concert.jpg"
- `src/pages/join.astro` → image="/elkast.jpg"
- `src/pages/projects.astro` → image="/concert.jpg"
- `src/pages/blog/index.astro` → image="/concert.jpg"

**Option A - Images importées (recommandé pour SEO):**
```astro
---
import { Image } from 'astro:assets';
import concertImage from '../assets/images/concert.webp';
import elkastImage from '../assets/images/elkast.webp';
---

<Layout
  title="..."
  description="..."
  image={concertImage.src}
>
```

**Option B - Images dans public/ (plus simple):**
1. Copier les images nécessaires de `src/assets/images/` vers `public/`
2. Changer les extensions :
   - `/concert.jpg` → `/concert.webp`
   - `/elkast.jpg` → `/elkast.webp`
   - `/logo.png` → `/logo.webp`

### 4. Articles de blog (fichiers .md)

Vérifier les références d'images dans :
- `src/content/blog/eco-conception-audiovisuel.md`
- `src/content/blog/écoprod.md`
- `src/content/blog/introduction-video-ip.md`
- `src/content/blog/regie-mobile-multicam.md`
- `src/content/blog/telethon-gaming-2025.md`

**Avant :**
```markdown
image: "/recycling.png"
```

**Après :**
```markdown
image: "/recycling.webp"
```

## 🎯 Stratégie recommandée

### Pour les métadonnées (Open Graph, Twitter Cards)

**Garder dans public/** pour simplicité :

```bash
# Copier les images essentielles dans public/
cp src/assets/images/concert.webp public/
cp src/assets/images/elkast.webp public/
cp src/assets/images/logo.webp public/
cp src/assets/images/recycling.webp public/
```

Puis dans les fichiers .astro :
```astro
<Layout
  title="..."
  description="..."
  image="/concert.webp"  <!-- Simple et efficace -->
>
```

### Pour les images de contenu

**Utiliser src/assets/images/** pour optimisation :

```astro
---
import { Image } from 'astro:assets';
import regieImage from '../assets/images/regie_service.webp';
---

<Image 
  src={regieImage} 
  alt="Notre régie mobile multicaméras"
  loading="lazy"
/>
```

## 🚀 Plan d'action étape par étape

### Étape 1 : Copier les images essentielles dans public/

```bash
# Images pour métadonnées
cp src/assets/images/concert.webp public/
cp src/assets/images/elkast.webp public/
cp src/assets/images/logo.webp public/
cp src/assets/images/recycling.webp public/
```

### Étape 2 : Mettre à jour src/pages/services.astro

```astro
---
import Layout from '../layouts/Layout.astro';
import Header from '../components/Header.astro';
import Footer from '../components/Footer.astro';
import { Image } from 'astro:assets';
import regieImage from '../assets/images/regie_service.webp';
import sonoImage from '../assets/images/sono.webp';
---
```

### Étape 3 : Mettre à jour les métadonnées des pages

Dans tous les fichiers .astro, changer :
- `/concert.jpg` → `/concert.webp`
- `/elkast.jpg` → `/elkast.webp`
- `/logo.png` → `/logo.webp`

### Étape 4 : Mettre à jour les articles de blog

Dans les fichiers .md, changer :
- `image: "/recycling.png"` → `image: "/recycling.webp"`
- etc.

### Étape 5 : Tester

```bash
npm run build
npm run preview
```

### Étape 6 : Nettoyer (après vérification)

```bash
# Supprimer src/content/images/
rm -rf src/content/images/

# Supprimer les anciennes images de public/
rm public/*.jpg
rm public/*.png
# SAUF favicon.png et favicon.svg (à garder)

# Garder uniquement dans public/ :
# - favicon.svg
# - favicon.png
# - _headers
# - robots.txt
# - concert.webp
# - elkast.webp
# - logo.webp
# - recycling.webp
# - 01v-repair.webp
# - fly-repair.webp
```

## 📝 Checklist complète

- [ ] Copier les images essentielles dans public/
- [ ] Mettre à jour src/pages/services.astro
- [ ] Mettre à jour src/pages/index.astro
- [ ] Mettre à jour src/pages/about.astro
- [ ] Mettre à jour src/pages/contact.astro
- [ ] Mettre à jour src/pages/join.astro
- [ ] Mettre à jour src/pages/projects.astro
- [ ] Mettre à jour src/pages/blog/index.astro
- [ ] Mettre à jour les articles de blog (.md)
- [ ] Tester le build : `npm run build`
- [ ] Vérifier visuellement : `npm run preview`
- [ ] Supprimer src/content/images/
- [ ] Nettoyer public/ (supprimer .jpg et .png sauf favicon)
- [ ] Commit et push

## 🔍 Vérification rapide

```bash
# Vérifier qu'il n'y a plus de références aux anciennes images
grep -r "\.jpg\|\.png" src/pages/ src/content/blog/

# Devrait retourner uniquement favicon.png et logo.png dans les imports
```

## 💡 Astuce

Pour faciliter la migration, vous pouvez faire une recherche/remplacement global :

**Dans VS Code :**
1. Ctrl+Shift+H (Rechercher et remplacer dans les fichiers)
2. Rechercher : `image="/concert\.jpg"`
3. Remplacer par : `image="/concert.webp"`
4. Répéter pour les autres images

## 📊 Gains attendus

- **Poids des images** : -60% en moyenne
- **Temps de chargement** : -40% environ
- **Score Lighthouse** : +10-15 points
- **Bande passante** : Économie significative

## ❓ Questions fréquentes

**Q: Dois-je vraiment supprimer les anciennes images ?**
R: Oui, après vérification. Elles prennent de la place inutilement.

**Q: Et si un navigateur ne supporte pas WebP ?**
R: Tous les navigateurs modernes supportent WebP (>95% des utilisateurs).

**Q: Puis-je garder certaines images en PNG/JPG ?**
R: Oui, pour les SVG (logo, favicon) et si vous avez une raison spécifique.

**Q: Le build est plus lent maintenant ?**
R: Le premier build optimise les images, les suivants utilisent le cache.
