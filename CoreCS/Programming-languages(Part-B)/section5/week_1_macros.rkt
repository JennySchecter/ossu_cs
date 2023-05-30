#lang racket
(provide (all-defined-out))

(define (db1 x) (+ x x))
(define (bd2 x) (* 2 x))

(define-syntax double2
  (syntax-rules ()
    [(double2 e)
     (+ e e)]))

(define-syntax double3
  (syntax-rules ()
    [(double3 e)
     (let ([x e])
       (+ x x))]))

(define-syntax double4
  (syntax-rules ()
    [(double4 e)
     (let* ([zero 0]
            [x e])
       (+ x x zero))]))

(define-syntax my-delay
  (syntax-rules ()
    [(my-delay e)
     (mcons #f (lambda () e))]))

(define (my-force p)
  (if (mcar p)
      (mcdr p)
      (begin (set-mcar! p #t)
             (set-mcdr! p ((mcdr p)))
             (mcdr p))))

;; do not do this because it repleace e in the macro expansion everywhere
;; we can use local bindings to prevent the side effects， but really don't do this,just define a function
(define-syntax my-force-macro1
  (syntax-rules ()
    [(my-force-macro1 e)
     (if (mcar e)
         (mcdr e)
         (begin (set-mcar! e #t)
                (set-mcdr! e ((mcdr e)))
                (mcdr e)))]))


;; a loop
;;
(define-syntax for
  (syntax-rules (to do)
    [(for lo to hi do body)
     (let ([l lo]
           [h hi])
       (letrec ([loop (lambda (x)
                       (if (> x h)
                           #t
                           (begin body (loop (+ x 1)))))])
         (loop l)))]))