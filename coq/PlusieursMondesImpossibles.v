(* ========================================================= *)
(* UNICITÉ DU MONDE IMPOSSIBLE                               *)
(* Réfutation de la pluralité des mondes impossibles         *)
(* avec Démonstration intégrée du Principe d'Explosion       *)
(* ========================================================= *)

Section Unicite.

(* Types de base abstraits *)
Context {Proposition : Type}.
Context {Not : Proposition -> Proposition}.
Context {Or : Proposition -> Proposition -> Proposition}.

(* --------------------------------------------------------- *)
(* PRÉMISSE 1 : L'EXTENSIONNALITÉ                            *)
(* --------------------------------------------------------- *)

(* Un monde abstrait est défini par l'ensemble des propositions qui y sont vraies. *)
Definition World := Proposition -> Prop.

(* Axiome d'extensionnalité : deux mondes prouvant les mêmes propositions sont identiques *)
Axiom world_extensionality : forall (w1 w2 : World),
  (forall P : Proposition, w1 P <-> w2 P) -> w1 = w2.

(* Cible de la preuve : Le Principe d'Explosion (Ex Falso Quodlibet) *)
Definition obeys_explosion (w : World) : Prop :=
  forall P Q : Proposition, w P -> w (Not P) -> w Q.

(* --------------------------------------------------------- *)
(* PREUVE DU PRINCIPE D'EXPLOSION (Lewis)                    *)
(* --------------------------------------------------------- *)

(* Règles fondamentales de raisonnement dans un monde classique *)
Class RaisonnementLogique (w : World) := {
  or_intro : forall P Q : Proposition, w P -> w (Or P Q);
  ds : forall P Q : Proposition, w (Or P Q) -> w (Not P) -> w Q
}.

(* PREUVE : Tout monde logique classique subit l'explosion *)
Theorem la_preuve_de_lewis : forall (w : World) `{RaisonnementLogique w}, 
  obeys_explosion w.
Proof.
  intros w H P Q hP hNotP.
  assert (H_Or : w (Or P Q)).
  { apply or_intro. exact hP. }
  apply ds with (P := P).
  - exact H_Or.
  - exact hNotP.
Qed.

(* --------------------------------------------------------- *)
(* THÉORÈME FINAL D'UNICITÉ                                  *)
(* --------------------------------------------------------- *)

(* PRÉMISSE 2 : DEFINITION DE L'IMPOSSIBILITÉ *)
(* Un monde est "impossible" s'il abrite au moins une contradiction logique. *)
Definition is_impossible (w : World) : Prop :=
  exists P : Proposition, w P /\ w (Not P).

(* THÉORÈME : Si deux mondes sont impossibles et classiques, ils sont identiques. *)
Theorem unique_impossible_world : forall (w1 w2 : World) 
  `{RaisonnementLogique w1} `{RaisonnementLogique w2},
  is_impossible w1 -> is_impossible w2 -> w1 = w2.
Proof.
  intros w1 w2 H1 H2 imp1 imp2.
  apply world_extensionality.
  intro Q.
  split; intro HQ.
  - (* Montrer que Q est vrai dans w2 *)
    destruct imp2 as [P2 [hP2 hNotP2]].
    apply (la_preuve_de_lewis w2 P2 Q hP2 hNotP2).
  - (* Montrer que Q est vrai dans w1 *)
    destruct imp1 as [P1 [hP1 hNotP1]].
    apply (la_preuve_de_lewis w1 P1 Q hP1 hNotP1).
Qed.

End Unicite.
