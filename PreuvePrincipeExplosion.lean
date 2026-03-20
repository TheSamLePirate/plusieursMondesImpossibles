-- =========================================================
-- PREUVE DU PRINCIPE D'EXPLOSION (PRÉMISSE 2)
-- La démonstration historique de Clarence Irving Lewis
-- =========================================================

namespace PreuveExplosion

-- On définit les briques fondamentales d'un langage logique
variable {Proposition : Type}
variable (Not : Proposition → Proposition)
variable (Or : Proposition → Proposition → Proposition)

-- Un monde est l'ensemble des propositions qui y sont vraies
def World (Proposition : Type) := Proposition → Prop

/-- 
Pour qu'un monde puisse faire l'objet de la logique, on postule 
que ce monde respecte deux règles élémentaires d'inférence (les lois de base du raisonnement humain).
-/
class RaisonnementLogique (w : World Proposition) where
  -- 1. L'Addition logique (Si j'ai une pomme, alors il est vrai que j'ai 'une pomme OU une banane')
  -- Si P est vrai, alors (P ou Q) est vrai
  or_intro : ∀ P Q : Proposition, w P → w (Or P Q)
  
  -- 2. Le Syllogisme Disjonctif (Si j'ai 'une pomme OU une banane', et que je n'ai pas de pomme, j'ai forcément la banane)
  -- Si (P ou Q) est vrai, et que (Non P) est vrai, alors Q est vrai
  syllogisme_disjonctif : ∀ P Q : Proposition, w (Or P Q) → w (Not P) → w Q



/-- 
THÉORÈME : Si un monde permet le Raisonnement Logique de base, 
alors il subit l'explosion (Ex Falso Quodlibet).
Autrement dit, si P et Non-P sont vrais, n'importe quelle proposition Q devient vraie.
-/
theorem la_preuve_de_lewis 
  (w : World Proposition) 
  [logique : RaisonnementLogique Not Or w] : 
  ∀ P Q : Proposition, w P → w (Not P) → w Q := by
  
  intro P Q
  intro hP       -- Supposons que P soit vrai dans le monde
  intro hNotP    -- Supposons que (Non P) soit aussi vrai
  
  -- ÉTAPE 1 : Puisque P est vrai (hP), on déduit que "P ou Q" est vrai.
  -- (C'est mathématiquement incontestable : si j'ai un chat, alors j'ai "un chat ou une licorne" !)
  have etape1 : w (Or P Q) := logique.or_intro P Q hP
  
  -- ÉTAPE 2 : Or on a aussi (Non P). (On n'a donc pas de chat, par contradiction !)
  -- Puisqu'on a prouvé "P ou Q", et qu'on sait "(Non P)",
  -- Le Syllogisme Disjonctif nous force à conclure Q. (On a donc la licorne).
  have etape2 : w Q := logique.syllogisme_disjonctif P Q etape1 hNotP
  
  exact etape2

end PreuveExplosion
