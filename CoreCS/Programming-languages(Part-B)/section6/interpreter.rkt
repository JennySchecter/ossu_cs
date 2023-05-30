;; section 6 : what your interpreter Can and Cannot Assume(你的解释器能假设什么以及不能假设什么)

#lang racket
(provide (all-defined-out))

;; A larger language with two kinds of values , boolean and numbers
;; an expression is any of these
(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct multiply (e1 e2) #:transparent)
(struct bool (b) #:transparent)
(struct eq-num (e1 e2) #:transparent)
(struct if-then-else (e1 e2 e3) #:transparent)

; a value in this language is a legal const or bool

;; to prevent this (multiply (const 3) (bool #f)), we can do interpreter like this

(define (eval-exp e)
  (cond [(const? e) e]
        [(negate? e)
         (let ([v (eval-exp (negate-e e))])
           (if (const? v)
               (const (- (const-int v)))
               (error "negate applied to non-number")))]
        [(add? e)
         (let ([v1 (eval-exp (add-e1 e))]
               [v2 (eval-exp (add-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (+ (const-int v1) (const-int v2)))
               (error "add applied to non-number")))]
        [(multiply? e)
         (let ([v1 (eval-exp (multiply-e1 e))]
               [v2 (eval-exp (multiply-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (* (const-int v1) (const-int v2)))
               (error "multiply applied to non-number")))]
        [(bool? e) e]
        [(eq-num? e)
         (let ([v1 (eval-exp (eq-num-e1 e))]
               [v2 (eval-exp (eq-num-e2 e))])
           (if (and (const? v1) (const v2))
               (bool (= (const-int v1) (const-int v2)))
               (error "eq-num applied to non-number")))]
        [(if-then-else? e)
         (let ([v-con (eval-exp (if-then-else-e1 e))])
           (if (bool? v-con)
               (if (bool-b v-con)
                   (eval-exp (if-then-else-e2 e))
                   (eval-exp (if-then-else-e3 e)))            
               (error "if-then-else applied to non-boolean")))]
        [#t (error "eval-exp expect an exp")]))



(define f (lambda (x)(+ x 1)))
(define a 1)
(define b "m")
(define c (cons 2 3))
(define d '())


(if (eq? d '())
    1
    0)



