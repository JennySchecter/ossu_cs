#lang racket

(provide (all-defined-out))

(define b 3)
(define f
  (let ([b b])
    (lambda (x) (* 1 (+ x b)))))
(define c (+ b 4))
(set! b 5)
(define z (f 4))
(define w c)

(define pr (cons 1 (cons #t "hi"))) ; in ML like (1, (true,"hi"))
(define lst (cons 1 (cons #t (cons "hi" null)))) ; [1,true,"hi"]
(define hi (cdr (cdr pr)))
(define hi-again (car (cdr (cdr lst))))
(define hi-again-shorter (caddr lst))

