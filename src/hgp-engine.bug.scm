;; Copyright 2015 - William Emerison Six
;; All rights reserved
;; Distributed under LGPL 2.1 or Apache 2.0

(##include "config.scm")

;; Home Game Poker
{at-both-times
 {begin
   ;; Poker cards have two attributes, ranks and suits.
   ;; Ranks have an ordering.  The variable "ranks" are listed
   ;; in order from best to worst.
   {define ranks (reverse
		  '(two
		    three
		    four
		    five
		    six
		    seven
		    eight
		    nine
		    ten
		    jack
		    queen
		    king
		    ace))}
   ;; Suits have no ordering
   {define suits '(spades
		   clubs
		   hearts
		   diamonds)}

   ;; A poker card is comprised of two attributes, a rank and
   ;; a suit
   {define-structure poker-card rank suit}

   ;; Poker cards are grouped into something called a "hand", which
   ;; is represented in this program as a list of poker-cards
   ;; Poker hands are classified into categories based off patterns
   ;; in the hand.
   ;; When matching these patterns, a person matches a subset of the
   ;; list to a certain pattern, and the tries to classify the remaining
   ;; cards.
   ;; This concept is represented by "partially-matched-hand".
   
   {define-structure partially-matched-hand
     matched
     not-yet-matched}


   ;; One such pattern is when a hand has multiple cards of the same
   ;; rank.  "of-a-kind" takes a multiple as an input, and will return
   ;; a partially-matched-hand if a rank appears that multiple of times.
   ;; Since rank matters, only the rank with the highest multiple is
   ;; returned.
   (define of-a-kind?
     [|number-of-a-kind|
      [|hand|
       (first (filter identity
		      (map [|rank|
			    (let* ((p (partition hand
						 [|card|
						  (equal? rank
							  (poker-card-rank card))]))
				   (predsucces (car p))
				   (predfail (cadr p)))
			      (if (equal? (length predsucces)
					  number-of-a-kind)
				  [(make-partially-matched-hand
				    predsucces
				    predfail)]
				  [#f]))]
			   ranks))
	      onNull: [#f])]])}}


;; For testing purposes, create a few hands
{at-compile-time
 {begin
   {define list->poker-hand
     [|lst|
      (apply make-poker-card lst)]}
   {define sample-pair-hand
     (map list->poker-hand
	  '((two spades)
	    (two hearts)
	    (four spades)
	    (five spades)
	    (six spades)))}
   {define sample-two-pair
     (map list->poker-hand
	  '((two spades)
	    (two hearts)
	    (five diamonds)
	    (five spades)
	    (six spades)))}
   {define sample-three-of-a-kind-hand
     (map list->poker-hand
	  '((two spades)
	    (two hearts)
	    (two diamonds)
	    (five spades)
	    (six spades)))}
   {define sample-four-of-a-kind-hand
     (map list->poker-hand
	  '((two spades)
	    (two hearts)
	    (two diamonds)
	    (five spades)
	    (two clubs)))}}}

;; A procedure to test for pairs
{with-tests
 {define pair? (of-a-kind? 2)}
 (equal? (pair? sample-pair-hand)
	 (make-partially-matched-hand
	  (map list->poker-hand
	       '((two hearts)
		 (two spades)))
	  (map list->poker-hand
	       '((six spades)
		 (five spades)
		 (four spades)))))
 (equal? (pair? sample-two-pair) ;; (1)
	 (make-partially-matched-hand
	  (map list->poker-hand
	       '((five spades)
		 (five diamonds)))
	  (map list->poker-hand
	       '((six spades)
		 (two hearts)
		 (two spades)))))
 (satisfies-relation
  pair?
  `(
    (,sample-three-of-a-kind-hand #f)
    (,sample-four-of-a-kind-hand #f)))
 }

;; We must be careful about (1).  A hand which contains two pair will
;; infact match the predicate "pair?", returning only the highest pair.
;; This will not be an issue, so long as when we compare two hands, we
;; start looking for the highest ranked hands first.  If we do that, then
;; it will match two pair, and will never try to match "pair?"


;; A procedure to test for three of a kind
{with-tests
 {define three-of-a-kind? (of-a-kind? 3)}
 (equal? (three-of-a-kind? sample-three-of-a-kind-hand)
	 (make-partially-matched-hand
	  (map list->poker-hand
	       '((two diamonds)
		 (two hearts)
		 (two spades)))
	  (map list->poker-hand
	       '((six spades)
		 (five spades)))))
 (satisfies-relation
  three-of-a-kind?
  `(
    (,sample-pair-hand #f)
    (,sample-two-pair #f)
    (,sample-four-of-a-kind-hand #f)))
 }

;; A procedure to test for four of a kind
{with-tests
 {define four-of-a-kind? (of-a-kind? 4)}
 (equal? (four-of-a-kind? sample-four-of-a-kind-hand)
	 (make-partially-matched-hand
	  (map list->poker-hand
	       '((two clubs)
		 (two diamonds)
		 (two hearts)
		 (two spades)))
	  (map list->poker-hand
	       '((five spades)))))
 (satisfies-relation
  four-of-a-kind?
  `(
    (,sample-pair-hand #f)
    (,sample-two-pair #f)
    (,sample-three-of-a-kind-hand #f)))
 }



;; dummy program
(pp 'poker)
