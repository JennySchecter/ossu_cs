#lang racket
(provide (all-defined-out))

(define (fibonacci1 x)
  (if (or (= x 1) (= x 2))
      1
      (+ (fibonacci1 (- x 1))
         (fibonacci1 (- x 2)))))

(define (fibonacci2 x)
  (letrec ([f (lambda (acc1 acc2 y)
                (if (= y x)
                    (+ acc1 acc2)
                    (f  (+ acc1 acc2) acc2 (+ y 1))))])
    (if (or (= x 1) (= x 2))
        1
        (f 1 1 3))))

;; third version, use memo
(define fibonacci3
  (letrec ([memo null]
           [f (λ (x)
                (let ([ans (assoc x memo)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (if (or (= x 1) (= x 2))
                                         1
                                         (+ (f (- x 1))
                                            (f (- x 2))))])
                        (begin (set! memo (cons (cons x new-ans) memo))
                               new-ans)))))])
    f))