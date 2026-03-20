-- =========================================================
-- UNICITÉ DU MONDE IMPOSSIBLE
-- Réfutation de la pluralité des mondes impossibles
-- avec Démonstration intégrée du Principe d'Explosion
-- =========================================================

namespace UniciteMondeImpossible

/-- Un monde abstrait est défini par l'ensemble des propositions qui y sont vraies. -/
def World (Proposition : Type) := Proposition → Prop

/-- Cible de la preuve : Le Principe d'Explosion (Ex Falso Quodlibet) appliqué à un monde. -/
def obeys_explosion {Proposition : Type} (Not : Proposition → Proposition) (w : World Proposition) : Prop :=
  ∀ P Q : Proposition, w P → w (Not P) → w Q

-- ==========================================
-- PREUVE DU PRINCIPE D'EXPLOSION (Lewis)
-- ==========================================

/-- Règles fondamentales de raisonnement dans un monde classique -/
class RaisonnementLogique {Proposition : Type} (Not : Proposition → Proposition) (Or : Proposition → Proposition → Proposition) (w : World Proposition) where
  or_intro : ∀ P Q, w P → w (Or P Q)
  ds : ∀ P Q, w (Or P Q) → w (Not P) → w Q  -- Syllogisme disjonctif

/-- PREUVE DE LA PRÉMISSE 2 : Tout monde logique classique subit l'explosion -/
theorem la_preuve_de_lewis {Proposition : Type} {Not : Proposition → Proposition} {Or : Proposition → Proposition → Proposition}
  (w : World Proposition) [logique : RaisonnementLogique Not Or w] : 
  obeys_explosion Not w := by
  intro P Q hP hNotP
  have etape1 : w (Or P Q) := logique.or_intro P Q hP
  exact logique.ds P Q etape1 hNotP

-- ==========================================
-- THÉORÈME FINAL D'UNICITÉ
-- ==========================================

/-- Un monde est "impossible" s'il abrite au moins une contradiction logique. -/
def is_impossible {Proposition : Type} (Not : Proposition → Proposition) (w : World Proposition) : Prop :=
  ∃ P : Proposition, w P ∧ w (Not P)

/-- THÉORÈME : Si deux mondes sont impossibles et respectent la logique classique, ils sont identiques. -/
theorem unique_impossible_world {Proposition : Type} {Not : Proposition → Proposition} {Or : Proposition → Proposition → Proposition}
    (w1 w2 : World Proposition)
    [log1 : RaisonnementLogique Not Or w1] (imp1 : is_impossible Not w1)
    [log2 : RaisonnementLogique Not Or w2] (imp2 : is_impossible Not w2) :
    w1 = w2 := by
  -- On prouve d'abord que les deux mondes obéissent à l'explosion 
  -- grâce à la démonstration de Lewis
  have ex1 : obeys_explosion Not w1 := @la_preuve_de_lewis Proposition Not Or w1 log1
  have ex2 : obeys_explosion Not w2 := @la_preuve_de_lewis Proposition Not Or w2 log2
  
  apply funext
  intro Q
  apply propext
  constructor
  · intro _
    have ⟨P2, hContradiction2⟩ := imp2
    exact ex2 P2 Q hContradiction2.1 hContradiction2.2
  · intro _
    have ⟨P1, hContradiction1⟩ := imp1
    exact ex1 P1 Q hContradiction1.1 hContradiction1.2

end UniciteMondeImpossible
