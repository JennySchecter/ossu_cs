;; Section 6
;; Datatype Programming in Racket without Structs
#lang racket
(provide (all-defined-out))

;; bad style,without else clause
(define (funny-sum xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs)
                               (funny-sum (cdr xs)))]
        [(string? (car xs)) (+ (string-length (car xs))
                               (funny-sum (cdr xs)))]))


;; now implement same idea as
;; datatype exp = Const of int | Negate of exp | Add of exp * exp | Mutiply of exp * exp

;; just helper functions that make lists where first element is a symbol (construct)
(define (Const i) (list 'Const i))
(define (Negate i) (list 'Negate i))
(define (Add e1 e2) (list 'Add e1 e2))
(define (Mutiply e1 e2) (list 'Mutiply e1 e2))

;; just helper functions that test what "kind of exp", like a is instance of xxx, (eq? v1 v2) : v1 and v2 refer to the same object?
(define (Const? xs) (eq? (car xs) 'Const))
(define (Negate? xs) (eq? (car xs) 'Negate))
(define (Add? xs) (eq? (car xs) 'Add))
(define (Multiply? xs) (eq? (car xs) 'Mutiply))

;; just helper functions that get the pieces of "one kind of exp"
(define (Const-int e) (car (cdr e)))
(define (Negate-e e) (car (cdr e)))
(define (Add-e1 e) (car (cdr e)))
(define (Add-e2 e) (car (cdr (cdr e))))
(define (Multiply-e1 e) (car (cdr e)))
(define (Multiply-e2 e) (car (cdr (cdr e))))

;; same recursive structure as we have in ML, just without pattern-matching
;; And one change from what we did before : returning  an exp ,
;; in particular a Constant, rather than an int
(define (eval-exp e)
  (cond [(Const? e) e]
        [(Negate? e) (Const (- (Const-int (eval-exp e))))]
        [(Add? e) (Const (+ (Const-int (eval-exp (Add-e1 e)))
                            (Const-int (eval-exp (Add-e2 e)))))]
        [(Multiply? e) (Const (* (Const-int (eval-exp (Multiply-e1 e)))
                                 (Const-int (eval-exp (Multiply-e2 e)))))]
        [#t (error "eval-exp except an exp")]))