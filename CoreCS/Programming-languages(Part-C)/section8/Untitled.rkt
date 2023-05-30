#lang racket

(define serial-no
  (letrec ([f (λ (x) (cons x (λ () (f (+ x 1)))))])
    (λ () (f 1))))

(define (twice-each s)
  (lambda ()
    (let ([pr (s)])
      (cons (car pr)
            (lambda ()
              (cons (car pr)
                    (twice-each (cdr pr))))))))

(define longer-strings
  (lambda ()
    (letrec ([f (lambda(s)
                  (cons s (λ ()(f (string-append "A" s)))))])
      (f "A"))))

(define f1 (lambda (y) (let ([x (begin (print (+ 2 4)) (+ 3 5))]) (+ x y))))

(define f2 (let ([x (begin (print (+ 2 4)) (+ 3 5))]) (lambda (y) (+ 1 y)))) 