import { defineCollection, z } from 'astro:content';

const projects = defineCollection({
  type: 'content',
  schema: ({ image }) => z.object({
    title: z.string(),
    description: z.string(),
    category: z.string(),
    tags: z.array(z.string()),
    date: z.coerce.date().optional(),
    image: image().optional(),
    // 'realisation' = un evenement reel, date, qui a droit a un bloc detaille
    // sur /realisations. 'prestation' = les fiches generiques historiques, qui
    // restent en cartes sur /services. Par defaut on est generique.
    type: z.enum(['realisation', 'prestation']).default('prestation'),
    // Champs ajoutes pour les realisations reelles (evenement date, lieu,
    // captation en ligne). Les entrees generiques historiques ne les ont pas,
    // d'ou l'optionnel partout : la carte n'affiche que ce qui est renseigne.
    lieu: z.string().optional(),
    periode: z.string().optional(),
    diffuseur: z.string().optional(),
    porteur: z.string().optional(),
    // Liens externes du bloc detaille : direct, page de l'organisateur, site
    // de la competition. Verifier qu'une URL repond avant de l'ajouter, on ne
    // veut pas de lien mort en vitrine.
    liens: z.array(z.object({
      label: z.string(),
      url: z.string().url(),
    })).optional(),
    // Les chiffres marquants, affiches en tuiles dans la colonne de droite.
    // Deux ou trois maximum : au-dela ils ne marquent plus rien.
    chiffres: z.array(z.object({
      valeur: z.string(),
      label: z.string(),
    })).optional(),
    prestations: z.array(z.string()).optional(),
  }),
});

export const collections = { projects };
