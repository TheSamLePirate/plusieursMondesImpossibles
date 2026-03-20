# Pluralité des Mondes Impossibles - Réfutation Formelle

Ce dossier contient la réfutation de la pluralité des mondes impossibles, certifiée mathématiquement et logiquement par le prouveur de théorèmes **Lean 4**. 

## Contenu

- **`PlusieursMondesImpossibles.lean`** : Le code source Lean contenant la démonstration. Il prouve "Le Principe d'Explosion" puis s'en sert pour démontrer l'unicité du monde impossible.
- **`run_plusieursMondesImpossible.sh`** : Un script explicatif interactif qui vulgarise le code Lean.
- **`demonstration.md`** : La description mathématique exacte de la démarche, formatée avec des formules logiques en LaTeX.

## Comment valider la démonstration ?

Le moyen le plus simple de comprendre l'argument logique est d'exécuter le script bash :

```bash
./run_plusieursMondesImpossible.sh
```

Ce script va :
1. Afficher chaque prémisse conceptuelle en **langage humain**.
2. Montrer sa **transcription logique exacte** pour l'ordinateur.
3. Lancer le compilateur Lean en arrière-plan pour **certifier formellement** qu'il n'y a aucune faille philosophique ou syntaxique.

## Prérequis

Pour que la vérification finale (à la fin du script) passe au vert, **Lean 4** doit être installé sur votre machine et être accessible de manière globale via votre terminal (commande `lean`).
