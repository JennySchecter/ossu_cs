#lang racket
(provide (all-defined-out))

; 1 1 1 1 ...
(define ones (λ () (cons 1 ones)))

(define ones-bad (lambda () (cons 1 (ones-bad))))
; 1 2 3 4 ...
(define serial-no
  (letrec ([f (λ (x) (cons x (λ () (f (+ x 1)))))])
    (λ () (f 1))))

; or like this ,will be easy to understand
(define (f x) (lambda (x) (cons x (lambda () (f (+ x 1))))))
(define nats (lambda () (f 1)))

; 2 4 8 16 32 ...
(define powers-of-two
  (letrec ([f (λ (x) (cons x (λ () (f (* x 2)))))])
    (λ () (f 2))))

(define (number-until stream tester)
  (letrec ([f (lambda (stream ans)
                (let ([p (stream)])
                  (if (tester (car p))
                      ans
                      (f (cdr p) (+ ans 1)))))])
    (f stream 1)))

