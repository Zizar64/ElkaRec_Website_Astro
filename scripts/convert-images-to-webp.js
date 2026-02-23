#!/usr/bin/env node

/**
 * Script de conversion des images en WebP
 * Utilise Sharp pour convertir toutes les images PNG/JPG en WebP
 * 
 * Usage: node scripts/convert-images-to-webp.js
 */

import sharp from 'sharp';
import { readdir, mkdir, copyFile } from 'fs/promises';
import { join, extname, basename } from 'path';
import { existsSync } from 'fs';

// Configuration
const CONFIG = {
  // Dossiers sources
  sourceDirs: [
    'public',
    'src/content/images'
  ],
  // Dossier de destination pour les images optimisées
  outputDir: 'src/assets/images',
  // Extensions à convertir
  extensions: ['.jpg', '.jpeg', '.png'],
  // Qualité WebP (0-100)
  webpQuality: 85,
  // Conserver les originaux
  keepOriginals: true
};

/**
 * Récupère tous les fichiers images d'un dossier
 */
async function getImageFiles(dir) {
  try {
    const files = await readdir(dir);
    return files
      .filter(file => {
        const ext = extname(file).toLowerCase();
        return CONFIG.extensions.includes(ext);
      })
      .map(file => join(dir, file));
  } catch (error) {
    console.warn(`⚠️  Impossible de lire le dossier ${dir}:`, error.message);
    return [];
  }
}

/**
 * Convertit une image en WebP
 */
async function convertToWebP(inputPath, outputPath) {
  try {
    const info = await sharp(inputPath)
      .webp({ quality: CONFIG.webpQuality })
      .toFile(outputPath);
    
    return {
      success: true,
      originalSize: info.size,
      inputPath,
      outputPath
    };
  } catch (error) {
    return {
      success: false,
      error: error.message,
      inputPath
    };
  }
}

/**
 * Copie les fichiers SVG et WebP existants
 */
async function copySpecialFiles(inputPath, outputPath) {
  try {
    await copyFile(inputPath, outputPath);
    return { success: true, inputPath, outputPath };
  } catch (error) {
    return { success: false, error: error.message, inputPath };
  }
}

/**
 * Fonction principale
 */
async function main() {
  console.log('🖼️  Conversion des images en WebP\n');
  console.log(`📁 Dossier de sortie: ${CONFIG.outputDir}`);
  console.log(`⚙️  Qualité WebP: ${CONFIG.webpQuality}%\n`);

  // Créer le dossier de sortie s'il n'existe pas
  if (!existsSync(CONFIG.outputDir)) {
    await mkdir(CONFIG.outputDir, { recursive: true });
    console.log(`✅ Dossier créé: ${CONFIG.outputDir}\n`);
  }

  let totalConverted = 0;
  let totalErrors = 0;
  let totalSaved = 0;

  // Traiter chaque dossier source
  for (const sourceDir of CONFIG.sourceDirs) {
    console.log(`\n📂 Traitement de: ${sourceDir}`);
    
    if (!existsSync(sourceDir)) {
      console.log(`   ⚠️  Dossier non trouvé, ignoré`);
      continue;
    }

    const imageFiles = await getImageFiles(sourceDir);
    
    if (imageFiles.length === 0) {
      console.log(`   ℹ️  Aucune image à convertir`);
      continue;
    }

    console.log(`   📊 ${imageFiles.length} image(s) trouvée(s)`);

    // Convertir chaque image
    for (const inputPath of imageFiles) {
      const fileName = basename(inputPath, extname(inputPath));
      const outputPath = join(CONFIG.outputDir, `${fileName}.webp`);

      const result = await convertToWebP(inputPath, outputPath);

      if (result.success) {
        const savedKB = ((result.originalSize) / 1024).toFixed(2);
        console.log(`   ✅ ${basename(inputPath)} → ${basename(outputPath)} (${savedKB} KB)`);
        totalConverted++;
        totalSaved += result.originalSize;
      } else {
        console.log(`   ❌ ${basename(inputPath)}: ${result.error}`);
        totalErrors++;
      }
    }

    // Copier les SVG et WebP existants
    const allFiles = await readdir(sourceDir);
    const specialFiles = allFiles.filter(file => {
      const ext = extname(file).toLowerCase();
      return ext === '.svg' || ext === '.webp';
    });

    for (const file of specialFiles) {
      const inputPath = join(sourceDir, file);
      const outputPath = join(CONFIG.outputDir, file);
      
      const result = await copySpecialFiles(inputPath, outputPath);
      if (result.success) {
        console.log(`   📋 ${file} copié`);
      }
    }
  }

  // Résumé
  console.log('\n' + '='.repeat(50));
  console.log('📊 RÉSUMÉ');
  console.log('='.repeat(50));
  console.log(`✅ Images converties: ${totalConverted}`);
  console.log(`❌ Erreurs: ${totalErrors}`);
  console.log(`💾 Espace total: ${(totalSaved / 1024 / 1024).toFixed(2)} MB`);
  console.log(`📁 Destination: ${CONFIG.outputDir}`);
  
  if (CONFIG.keepOriginals) {
    console.log('\nℹ️  Les fichiers originaux ont été conservés');
    console.log('   Vous pouvez les supprimer manuellement après vérification');
  }

  console.log('\n✨ Conversion terminée!\n');
  console.log('📝 Prochaines étapes:');
  console.log('   1. Vérifiez les images dans src/assets/images/');
  console.log('   2. Mettez à jour les imports dans vos fichiers .astro');
  console.log('   3. Testez le build: npm run build');
  console.log('   4. Supprimez les anciennes images si tout fonctionne\n');
}

// Exécution
main().catch(console.error);
