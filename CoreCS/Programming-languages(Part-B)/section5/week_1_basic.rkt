#lang racket

; In racket every file is a module, Use this mean all define in this file is public ,other file can use them
(provide (all-defined-out))  
(define a 3)
(define L1 (cons "b" (cons "a" (cons 1 2))))
(define L2 (list "a" "b" "c" 1 1 3 "ss"))

(define (sum lon)
  (cond ((empty? lon) 0)
        ((+ (car lon)
            (sum (cdr lon))))))

(define (sum2 lon)
  (if (empty? lon)
      0
      (+ (car lon) (sum2 (cdr lon)))))

(define (addX x)
  x + "a")

(define (power1 x y)
  (if (= y 0)
      1
      (* x (power1 x (- y 1)))))

(define power2
  (lambda (x)
    (lambda (y)
      (power1 x y))))

(define (append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (append (cdr xs) ys))))

(define (map f xs)
  (if (null? xs)
      null
      (cons (f (car xs)) (map f (cdr xs)))))

(define (silly-double x)
  (let ([x (+ x 3)]
        [y (+ x 2)])
    (+ x y -5)))

(define (silly-double2 x)
  (let* ([x (+ x 3)]
         [y (+ x 2)])
    (+ x y -8)))

(define (bad-letrec x)
  (letrec ([w (+ 1 z)]
           [y (lambda (x) (+ z 1))]
           [z 13])
    (if x y z)))


(define (m x)
  (+ x 1))

