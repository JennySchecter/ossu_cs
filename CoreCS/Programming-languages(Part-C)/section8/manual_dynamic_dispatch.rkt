#lang racket

(struct obj (fields methods))
;; - struct obj is made of (ListOfPairs ListOfPairs)

;; String ListOfPairs -> Boolean | Pair
(define (assoc-m v xs)
  (cond [(null? xs) #f]
        [(equal? (mcar (car xs)) v) (car xs)]
        [#t (assoc-m v (cdr xs))]))

(define (get obj fld)
  (let ([pr (assoc-m fld (obj-fields obj))])
    (if pr
        (mcdr pr)
        (error "field not found"))))

(define (set obj fld v)
  (let ([pr (assoc-m fld (obj-fields obj))])
    (if pr
        (set-mcdr! pr v)
        (error "field not found"))))

(define (send obj msg . args)
  (let ([pr (assoc msg (obj-methods obj))])
    (if pr
        ((cdr pr) obj args)
        (error "method not found"))))

(define (make-point _x _y)
  (obj
   (list (mcons 'x _x)
         (mcons 'y _y))
   (list (cons 'get-x (lambda (self args) (get self 'x)))
         (cons 'get-y (lambda (self args) (get self 'y)))
         (cons 'set-x (lambda (self args) (set self 'x (car args))))
         (cons 'set-y (lambda (self args) (set self 'y (car args))))
         (cons 'distFromOrigin
               (lambda (self args)
                 (let ([a (send self 'get-x)]
                       [b (send self 'get-y)])
                   (sqrt (+ (* a a) (* b b)))))))))



(define (make-color-point _x _y _c)
  (let ([pt (make-point _x _y)])
    (obj
     (cons (mcons 'color _c)
           (obj-fields pt))
     (append (list
              (cons 'get-color (lambda (self args) (get self 'color)))
              (cons 'set-color (lambda (self args) (set self 'color (car args)))))
             (obj-methods pt)))))

(define (make-polar-point _r _theta)
  (let ([pt (make-point #f #f)])
    (obj
     (append (list (mcons 'r _r)
                   (mcons 'theta _theta))
             (obj-fields pt))
     (append (list
              (cons 'set-r (lambda (self args)
                             (set self 'r (car args))))
              (cons 'set-theta (lambda (self args)
                                 (set self 'theta (car args))))
              (cons 'get-x (lambda (self args)
                             (let ([r (get self 'r)]
                                   [theta (get self 'theta)])
                               (* r (cos theta)))))
              (cons 'get-y (lambda (self args)
                             (let ([r (get self 'r)]
                                   [theta (get self 'theta)])
                               (* r (sin theta)))))
              (cons 'set-x (lambda (self args)
                             (let* ([b (send self 'get-y)]
                                    [a (car args)]
                                    [theta (atan (/ b a))]
                                    [r (sqrt (+ (* a a) (* b b)))])
                               (begin (set self 'r r)
                                      (set self 'theta theta)))))
              (cons 'set-y (lambda (self args)
                             (let* ([a (send self 'get-x)]
                                    [b (car args)]
                                    [theta (atan (/ b a))]
                                    [r (sqrt (+ (* a a) (* b b)))])
                             (begin (set self 'r r)
                                    (set self 'theta theta))))))
             (obj-methods pt)))))






