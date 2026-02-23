# 📸 Guide de gestion des images

## 🎯 Nouvelle structure optimisée

### Organisation des dossiers

```
src/assets/images/          # ✅ NOUVEAU - Toutes les images optimisées en WebP
├── logo.webp
├── favicon.webp
├── concert.webp
├── regie_service.webp
└── ...

public/                     # ⚠️ ANCIEN - À nettoyer après migration
├── _headers               # ✅ Garder
├── robots.txt             # ✅ Garder
├── favicon.svg            # ✅ Garder (SVG)
└── *.jpg, *.png           # ❌ À supprimer après migration

src/content/images/         # ❌ À SUPPRIMER après migration
```

## 📋 Règles d'organisation

### ✅ Où placer les images ?

| Type d'image | Emplacement | Format | Raison |
|--------------|-------------|--------|--------|
| **Images de contenu** | `src/assets/images/` | WebP | Optimisation automatique par Astro |
| **Logos/Icônes SVG** | `public/` | SVG | Pas besoin d'optimisation |
| **Favicon** | `public/` | SVG + PNG | Compatibilité navigateurs |
| **Images de blog** | `src/assets/images/` | WebP | Optimisation + responsive |
| **Images statiques** | `public/` | WebP | Si pas besoin d'optimisation |

### 🎨 Bonnes pratiques

1. **Format WebP** : Toujours privilégier WebP pour les photos et images complexes
2. **Format SVG** : Pour les logos, icônes et illustrations vectorielles
3. **Nommage** : Utiliser des noms descriptifs en kebab-case (ex: `regie-mobile-multicam.webp`)
4. **Taille** : Optimiser avant import (max 1920px de large pour les photos)
5. **Alt text** : Toujours fournir un texte alternatif descriptif

## 🔄 Migration des images

### Étape 1 : Conversion automatique

```bash
# Convertir toutes les images PNG/JPG en WebP
node scripts/convert-images-to-webp.js
```

Ce script va :
- ✅ Convertir toutes les images PNG/JPG en WebP (qualité 85%)
- ✅ Copier les SVG et WebP existants
- ✅ Créer le dossier `src/assets/images/`
- ✅ Conserver les originaux (pour vérification)

### Étape 2 : Mise à jour du code

#### Avant (ancien système)
```astro
---
// ❌ Ancien - Images dans public/
---
<img src="/concert.jpg" alt="Concert" />

---
// ❌ Ancien - Images dans src/content/images/
import regieImage from '../content/images/regie_service.png';
---
<Image src={regieImage} alt="Régie" />
```

#### Après (nouveau système)
```astro
---
// ✅ Nouveau - Images dans src/assets/images/
import { Image } from 'astro:assets';
import concertImage from '../assets/images/concert.webp';
import regieImage from '../assets/images/regie_service.webp';
---
<Image src={concertImage} alt="Concert live" />
<Image src={regieImage} alt="Notre régie mobile" />
```

### Étape 3 : Vérification

```bash
# Tester le build
npm run build

# Vérifier le résultat
npm run preview
```

### Étape 4 : Nettoyage

Une fois que tout fonctionne :

```bash
# Supprimer les anciennes images
rm -rf src/content/images/
rm public/*.jpg public/*.png

# Garder uniquement :
# - public/favicon.svg
# - public/favicon.png
# - public/_headers
# - public/robots.txt
```

## 🚀 Utilisation dans le code

### Images importées (recommandé)

```astro
---
import { Image } from 'astro:assets';
import heroImage from '../assets/images/hero.webp';
---

<!-- Optimisation automatique + responsive -->
<Image 
  src={heroImage} 
  alt="Description de l'image"
  width={1200}
  height={800}
  loading="lazy"
/>
```

**Avantages :**
- ✅ Optimisation automatique par Astro
- ✅ Génération de plusieurs tailles (responsive)
- ✅ Lazy loading natif
- ✅ Vérification à la compilation

### Images statiques (public/)

```astro
<!-- Pour les SVG et fichiers statiques -->
<img src="/logo.svg" alt="Logo ElkaRec" width="140" height="25" />
```

**Utiliser uniquement pour :**
- SVG (logos, icônes)
- Favicon
- Images qui ne nécessitent pas d'optimisation

## 📊 Avantages de la nouvelle structure

### Performance
- **-60% de poids** : WebP vs PNG/JPG
- **Responsive automatique** : Plusieurs tailles générées
- **Lazy loading** : Chargement différé des images

### Développement
- **Un seul endroit** : Toutes les images dans `src/assets/images/`
- **Type-safe** : Vérification des imports à la compilation
- **Optimisation auto** : Astro gère l'optimisation

### SEO
- **Meilleur score** : Images optimisées = site plus rapide
- **Alt text obligatoire** : Meilleure accessibilité
- **Formats modernes** : WebP supporté par tous les navigateurs modernes

## 🛠️ Commandes utiles

```bash
# Convertir les images en WebP
node scripts/convert-images-to-webp.js

# Ajouter au package.json pour faciliter l'usage
npm run convert:images

# Build et vérification
npm run build
npm run preview
```

## 📝 Checklist de migration

- [ ] Exécuter le script de conversion
- [ ] Vérifier les images dans `src/assets/images/`
- [ ] Mettre à jour les imports dans les fichiers .astro
- [ ] Mettre à jour les références dans les fichiers .md (blog)
- [ ] Tester le build : `npm run build`
- [ ] Vérifier visuellement : `npm run preview`
- [ ] Supprimer `src/content/images/`
- [ ] Nettoyer `public/` (garder SVG, favicon, _headers, robots.txt)
- [ ] Commit et push

## 🔍 Résolution de problèmes

### Erreur : "Cannot find module"
```bash
# Vérifier que l'image existe
ls src/assets/images/

# Vérifier le chemin d'import
# Depuis src/pages/ : '../assets/images/image.webp'
# Depuis src/components/ : '../assets/images/image.webp'
```

### Image floue ou pixelisée
```astro
<!-- Spécifier width et height -->
<Image 
  src={image} 
  alt="Description"
  width={1920}  <!-- Taille originale -->
  height={1080}
/>
```

### Build lent
```bash
# Les images sont optimisées au build
# C'est normal que ça prenne du temps
# Les builds suivants utilisent le cache
```

## 📚 Ressources

- [Astro Images](https://docs.astro.build/en/guides/images/)
- [Sharp (optimisation)](https://sharp.pixelplumbing.com/)
- [WebP (format)](https://developers.google.com/speed/webp)
