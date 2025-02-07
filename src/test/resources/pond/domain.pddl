(define (domain blocksworld)
  (:requirements :non-deterministic :equality :typing)
  (:types block)
  (:predicates (holding ?b - block) (emptyhand) (on-table ?b - block) (on ?b1 ?b2 - block) (clear ?b - block))
  
  (:action pick-up
    :parameters (?b1 ?b2 - block)
    :precondition (and (emptyhand) (clear ?b1) (on ?b1 ?b2) (not (= ?b1 ?b2)))
    :effect
      (oneof 
        (and (holding ?b1) (clear ?b2) (not (emptyhand)) (not (clear ?b1)) (not (on ?b1 ?b2)))
        (and (clear ?b2) (on-table ?b1) (not (on ?b1 ?b2))))
  )
  (:action pick-up-from-table
    :parameters (?b - block)
    :precondition (and (emptyhand) (clear ?b) (on-table ?b))
    :effect (oneof (and) (and (holding ?b) (not (emptyhand)) (not (on-table ?b)) (not (clear ?b))))
  )
  (:action put-on-block
    :parameters (?b1 ?b2 - block)
    :precondition (and (holding ?b1) (clear ?b2) (not (= ?b1 ?b2)))
    :effect (oneof (and (on ?b1 ?b2) (emptyhand) (clear ?b1) (not (holding ?b1)) (not (clear ?b2)))
                   (and (on-table ?b1) (emptyhand) (clear ?b1) (not (holding ?b1))))
  )
  (:action put-down
    :parameters (?b - block)
    :precondition (and (holding ?b))
    :effect (and (on-table ?b) (emptyhand) (clear ?b) (not (holding ?b)))
  )
  (:action pick-tower
    :parameters (?b1 ?b2 ?b3 - block)
    :precondition (and (emptyhand) (on ?b1 ?b2) (on ?b2 ?b3) (not (= ?b1 ?b2)) (not (= ?b1 ?b3)) (not (= ?b2 ?b3)))
    :effect (oneof (and) (and (holding ?b2) (clear ?b3) (not (emptyhand)) (not (on ?b2 ?b3)) (not (clear ?b1))))
  )
  (:action put-tower-on-block
    :parameters (?b1 ?b2 ?b3 - block)
    :precondition (and (holding ?b2) (on ?b1 ?b2) (clear ?b3) (not (= ?b1 ?b2)) (not (= ?b1 ?b3)) (not (= ?b2 ?b3)))
    :effect (oneof (and (on ?b2 ?b3) (emptyhand) (not (holding ?b2)) (not (clear ?b3)) (clear ?b1))
                   (and (on-table ?b2) (emptyhand) (not (holding ?b2)) (clear ?b1)))
  )
  (:action put-tower-down
    :parameters (?b1 ?b2 - block)
    :precondition (and (holding ?b2) (on ?b1 ?b2) (not (= ?b1 ?b2)))
    :effect (and (on-table ?b2) (emptyhand) (not (holding ?b2)) (clear ?b1))
  )
  (:action senseON
   :parameters (?b1 ?b2 - block)
   :precondition (not (= ?b1 ?b2))
   :observe (on ?b1 ?b2)
  )
  (:action senseCLEAR
   :parameters (?b1 - block)
   :observe (clear ?b1)
  )
  (:action senseONTABLE 
   :parameters (?b1 - block)
   :observe (on-table ?b1)
  )   
)