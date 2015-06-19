;; Copyright 2015 - William Emerison Six
;; All rights reserved
;; Distributed under LGPL 2.1 or Apache 2.0

(##include "config.scm")

;; home Game Poker
{define ranks '(two three four five six seven eight nine ten jack queen
		    king ace)}
{define suits '(spades clubs hearts diamonds)}

{define-structure poker-card rank suit}

(define pair?
  [|hand|
   (filter
    (complement null?)
    (map [|rank|
   	  (let* ((p (list#partition hand [|card| (equal? rank
   							 (poker-card-rank card))]))
   		 (predsucces (car p))
   		 (predfail (cadr p)))
   	    (if (equal? (length predsucces)
   			2)
   		[(list predsucces predfail)]
   		['()]))]
   	 ranks))])


(define myhand
  (list
   (make-poker-card 'two 'spades)
   (make-poker-card 'two 'hearts)
   (make-poker-card 'four 'spades)
   (make-poker-card 'five 'spades)
   (make-poker-card 'six 'spades)))

(pp (pair? myhand))


