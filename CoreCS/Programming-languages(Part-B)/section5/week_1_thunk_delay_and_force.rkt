#lang racket
(provide (all-defined-out))

;; just simulate a very slow method to let you intuitive feel how slow it can be
(define (slow-add x y)
  (letrec ([slow-id (λ (a b)
                      (if (= b 0)
                          a
                          (slow-id a (- b 1))))])
    (+ (slow-id x 50000000) y)))



(define (my-delay th)
  (mcons #f th))

(define (my-force p)
  (if (mcar p)
      (mcdr p)
      (begin (set-mcar! p #t)
             (set-mcdr! p ((mcdr p)))
             (mcdr p))))

;; multiplies x and result of y-thunk , calling y-thunk x times, if y-thunk is so complex computation, it's not a good idea
(define (my-mult x y-thunk)
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)]
        [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))

;; use my-delay we can only need compute y-thunk once



(my-mult 0 (λ () (slow-add 3 4)))  ; slow by x increment, recomputation, if slow-add is a big computation, that's horrible

; better than before, but still computate once slow-add, but if slow-add is a big computation, that's horrible
(my-mult 0 (let [(x (slow-add 3 4))] (λ () x)))

; best, use mcons mutable, implementation lazy and delay evaluation; not compute slow-add or just compute once
(my-mult 0 (let ([p (my-delay (λ () (slow-add 3 4)))]) 
               (λ () (my-force p)))) 

(let* ([car 0]
       [car (+ car 2)])
  car)
