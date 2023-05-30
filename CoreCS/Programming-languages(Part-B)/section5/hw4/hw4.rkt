
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; Q1.
;; Number Number Number -> NumberOfList
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

;; Q2
;; StringOfList String -> StringOfList
(define (string-append-map los s)
  (map (lambda (n) (string-append n s)) los))

;; Q3
;; 
(define (list-nth-mod lst n)
  (cond [(negative? n) (error "list-nth-mod: negative number")]
        [(null? lst) (error "list-nth-mod: empty list")]
        [#t (let ([i (remainder n (length lst))])
              (car (list-tail lst i)))]))

;; Q4
;; define s stream
(define serial-no
  (letrec ([f (lambda (x)
                (cons x (lambda ()(f (+ x 1)))))])
    (lambda ()(f 1))))

(define (stream-for-n-steps s n)
  (letrec ([f (lambda (i s)
               (if (> i n)
                   null
                   (cons (car (s)) (f (+ i 1) (cdr (s))))))])
    (f 1 s)))

;; Q5
;;
(define funny-number-stream
  (letrec ([f (lambda (x)
                (let* ([rdr (remainder (abs x) 5)]
                       [x1 (if (zero? rdr) (* -1 x) x)])
                  (cons x1 (lambda ()(f (+ 1 (abs x)))))))])
    (lambda () (f 1))))

;; Q6
;; 
(define dan-then-dog
  (letrec ([f (lambda (x)
                (let ([next (if (string=? x "dan.jpg") "dog.jpg" "dan.jpg")])
                  (cons x (lambda ()(f next)))))])
    (lambda ()(f "dan.jpg"))))

;; Q7
(define (stream-add-zero s)
  (letrec ([f (lambda (s)
               (cons (cons 0 (car (s))) (lambda () (f (cdr (s))))))])
    (lambda ()(f s))))

;; Q8
;; a fun take xs/ys two lists, return a stream like  (x1,y1)  
(define (cycle-lists xs ys)
  (letrec ([f (lambda (n)
                (cons (cons (list-nth-mod xs n)
                            (list-nth-mod ys n))
                      (lambda ()(f (+ n 1)))))])
    (lambda () (f 0))))

;; Q9
;;
(define (vector-assoc v vec)
  (letrec ([loop (lambda (n)
                   (if (>= n (vector-length vec))
                       #f
                       (let ([ele (vector-ref vec n)])
                         (if (and (pair? ele) (equal? v (car ele)))
                             ele
                             (loop (+ n 1))))))])
    (loop 0)))

;; Q10
;;
(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [slot 0]
           [f (lambda(v)
                (let ([vas (vector-assoc v memo)])
                  (if (false? vas)
                      (let ([memo-v (assoc v xs)])
                        (if (false? memo-v)
                            #f
                            (begin (vector-set! memo slot memo-v)
                                   (if (= slot (- n 1))
                                       (set! slot 0)
                                       (set! slot (+ slot 1)))
                                   memo-v)))
                      vas)))])
    f))

;; Q11 Challenge problem  define a macro
(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (letrec ([x e1]
              [loop (lambda()
                      (if (< e2 x)
                          (loop)
                          #t))])
       (loop))]))

