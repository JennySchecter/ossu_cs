;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

;; CHANGE (put your solutions here)
;; 1.(a)
(define (racketlist->mupllist rlst)
  (if (null? rlst)
      (aunit)
      (apair (car rlst) (racketlist->mupllist (cdr rlst)))))

;; 1.(b)
(define (mupllist->racketlist mlst)
  (if (aunit? mlst)
      '()
      (cons (apair-e1 mlst) (mupllist->racketlist (apair-e2 mlst)))))


;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e)
         (envlookup env (var-string e))]
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        ;; CHANGE add more cases here
        ;; MUPL-value int?
        [(int? e) e]
        ;; MUPL-value closure?
        [(closure? e) e]
        ;; MUPL-value aunit?
        [(aunit? e) e]
        ;; fun? 
        [(fun? e) (closure env e)]
        ;; ifgreater?
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1) (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL ifgreater applied to non-number")))]
        ;; mlet?
        [(mlet? e)
         (if (string? (mlet-var e))
             (let* ([v (eval-under-env (mlet-e e) env)]
                    [new-env (cons (cons (mlet-var e) v) env)])
               (eval-under-env (mlet-body e) new-env))
             (error "MUPL mlet applied to non-string"))]
        ;; call?
        [(call? e)
         (let ([v1 (eval-under-env (call-funexp e) env)]   ; Closure
               [v2 (eval-under-env (call-actual e) env)])  ; Actual Param
           (if (closure? v1)
               (let* ([formal (fun-formal (closure-fun v1))]    ; Formal Param Name
                      [fun-name (fun-nameopt (closure-fun v1))] ; Fun Name
                      [new-env (if (false? fun-name)            ; 不具名函数 Anonymous Function
                                   (cons (cons formal v2) (closure-env v1))   ; just binding formal->actual to cl-env
                                   (cons (cons formal v2)
                                         (cons (cons fun-name v1) (closure-env v1))))]) ; binding formal->actual and Funname -> Closure to cl-env
                 (eval-under-env (fun-body (closure-fun v1)) new-env))
              ;(begin (print new-env)
               ;       (eval-under-env (fun-body (closure-fun v1)) new-env)))
               (error "MUPL mlet applied to non-fun")))]
        ;; apair?
        [(apair? e) (let ([v1 (eval-under-env (apair-e1 e) env)]
                          [v2 (eval-under-env (apair-e2 e) env)])
                      (apair v1 v2))]
        ;; fst?
        [(fst? e) (let ([p (eval-under-env (fst-e e) env)])
                    (if (apair? p)
                        (apair-e1 p)
                        (error "MUPL fst applied to non-apair")))]
        ;; snd?
        [(snd? e) (let ([p (eval-under-env (snd-e e) env)])
                    (if (apair? p)
                        (apair-e2 p)
                        (error "MUPL snd applied to non-apair")))]
        ;; isaunit?
        [(isaunit? e) (if (aunit? (eval-under-env (isaunit-e e) env))
                          (int 1)
                          (int 0))]
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3
;; 3. (a)
(define (ifaunit e1 e2 e3)
  (ifgreater (isaunit e1) (int 0) e2 e3))

;; 3. (b)
;; may be it should be generate like (mlet s1 e1 (mlet s2 e2 (melt s3 e3  ... en+1
;; use test (mlet* (list (cons "x" (int 1)) (cons "y" (add (var "x") (int 2)))) (add (var "x") (var "y")))
(define (mlet* lst e2)
  (if (null? lst)
      e2
      (let* ([s (car (car lst))]
             [e (cdr (car lst))]
             [new-mlet (mlet s e e2)])
        (if (null? (cdr lst))
            new-mlet
            (mlet (mlet-var new-mlet)
                  (mlet-e new-mlet)
                  (mlet* (cdr lst) new-mlet))))))

;; 3. (c) bad style, e1 or e1 at least one computed more than once
(define (ifeq-bad e1 e2 e3 e4)
  (ifgreater e1 e2
             e4
             (ifgreater e2 e1 e4 e3)))

;; use mlet* that defined previous
(define (ifeq e1 e2 e3 e4)
  (mlet* (list (cons "_x" e1)
               (cons "_y" e2))
         (ifgreater (var "_x") (var "_y")
             e4
             (ifgreater (var "_y") (var "_x") e4 e3))))

;; Problem 4
;; (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 7)))) (apair (int 1) (aunit)))) 
(define mupl-map
  (fun "MAP" "f"
       (fun #f "lst"
            (ifaunit (var "lst")
                     (aunit)
                     (apair (call (var "f") (fst (var "lst")))
                            (call (call (var "MAP") (var "f"))
                                        (snd (var "lst"))))))))


(define mupl-mapAddN 
  (mlet "map" mupl-map
        (fun "MAP-ADDN" "i"
             (call (var "map") (fun #f "x" (add (var "x") (var "i")))))))

;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
