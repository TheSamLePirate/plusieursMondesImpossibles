# Démonstration Formelle : L'Unicité du Monde Impossible

Ce document présente la démonstration mathématique et logique de l'impossibilité d'une pluralité de mondes impossibles, basée sur la logique classique et le principe d'explosion.

## 1. Définitions Préliminaires

### 1.1 Principe d'Extensionnalité d'un Monde
Soit $\Omega$ l'ensemble de toutes les propositions logiques concevables.
Un monde $W$ n'est défini formellement que par son **extension**, c'est-à-dire le sous-ensemble de toutes les propositions $P \in \Omega$ qui y sont évaluées comme *vraies*.
Ainsi, deux mondes $W_1$ et $W_2$ sont strictement identiques si et seulement si exactement les mêmes propositions y sont vraies :

$$ W_1 = W_2 \iff \{ P \in \Omega \mid P \text{ est vraie dans } W_1 \} = \{ P \in \Omega \mid P \text{ est vraie dans } W_2 \} $$

### 1.2 Définition de l'Impossibilité
Un monde $W_{imp}$ est dit **impossible** s'il abrite une contradiction intrinsèque, c'est-à-dire s'il existe au moins une proposition $P$ telle que $P$ et sa négation $\neg P$ soient toutes deux simultanément vraies dans ce monde :

$$ \exists P \in \Omega, \quad (P \in W_{imp}) \land (\neg P \in W_{imp}) $$

## 2. Le Principe d'Explosion (*Ex Falso Quodlibet*)

Historiquement démontré par le logicien C.I. Lewis (1932), le Principe d'Explosion stipule que si un système admet les règles de base du raisonnement (l'addition logique et le syllogisme disjonctif), on peut déduire **n'importe quelle proposition** à partir d'une contradiction.

**Démonstration de Lewis :**
Supposons un monde imposssible $W_{imp}$ contenant une contradiction $A \land \neg A$.
1. Puisque $A$ est vraie, par **addition logique** ($A \implies A \lor B$), la disjonction $A \lor B$ est vraie pour toute proposition arbitraire $B \in \Omega$.
2. De plus, par définition de notre monde, $\neg A$ est aussi vraie.
3. Puisque l'on sait que $A \lor B$ est vraie, et que $\neg A$ est vraie, le **syllogisme disjonctif** $(((A \lor B) \land \neg A) \implies B)$ nous force à déduire que $B$ est vraie.

**Conclusion d'Explosion :**
$$ \forall B \in \Omega, \quad (A \land \neg A \implies B) $$

## 3. Le Théorème d'Unicité

**Théorème :** S'il existe plusieurs mondes impossibles obéissant à la logique classique, alors ils sont tous mathématiquement le même monde.

**Preuve :**
Soient $W_{imp_1}$ et $W_{imp_2}$ deux mondes que nous supposons être des mondes impossibles.
1. Par la définition (1.2), chacun de ces mondes contient une contradiction.
2. Par le Principe d'Explosion (2), toute contradiction provoque le statut de vérité pour *toutes* les propositions concevables.
3. Ainsi, pour $W_{imp_1}$, l'ensemble des propositions vraies est égal à l'ensemble universel absolu $\Omega$ :
   $$ \{ P \mid P \text{ est vraie dans } W_{imp_1} \} = \Omega $$
4. De la même manière irréfutable, pour $W_{imp_2}$, l'ensemble des propositions vraies est aussi l'ensemble universel absolu :
   $$ \{ P \mid P \text{ est vraie dans } W_{imp_2} \} = \Omega $$
5. Par le Principe d'Extensionnalité (1.1), puisque l'ensemble des propositions vraies de $W_{imp_1}$ est strictement égal à celui de $W_{imp_2}$ :
   $$ W_{imp_1} = W_{imp_2} $$

*Q.E.D.*

---
*Ce document mathématique valide exactement l'architecture implémentée dans le prouveur Lean 4 du fichier `PlusieursMondesImpossibles.lean`.*
