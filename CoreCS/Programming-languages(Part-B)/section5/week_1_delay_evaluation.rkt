#lang racket
(provide (all-defined-out))

(define (factorial-normal n)
  (if (= n 0)
      1
      (* n (factorial-normal (- n 1)))))

(define (my-if-bad e1 e2 e3)
  (if e1 e2 e3))

(define (factorial-bad n)
  (my-if-bad (= n 0)
             1
             (* n (factorial-bad (- n 1)))))

;; e2 and e3 should be zero-argument functions (delays evaluation)
(define (my-if-strange-but-works e1 e2 e3)
  (if e1 (e2) (e3)))

(define (factorial-okay n)
  (my-if-strange-but-works (= n 0)
                           (λ () 1)
                           (λ () (* n (factorial-okay (- n 1))))))