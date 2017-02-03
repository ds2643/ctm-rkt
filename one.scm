#lang racket

; recursive factorial definition (1.3)
; non-tail-recursive

(define (fact n)
  (cond
    [(zero? n) 1]
    [#t (* n (fact (- n 1)))]))

(fact 10)

; combinations (1.3)

(define (comb n r)
  (/ (fact n)
     (* (fact r) (fact (- n r)))))

(comb 10 3)

;; pascal's triangle (1.5)
(define (add-list xs ys)
  (cond
    [(null? xs) '()]
    [#t
     (cons (+ (car xs) (car ys))
           (add-list (cdr xs) (cdr ys)))]))

(define (shift-left xs)
  (reverse (cons 0 (reverse xs))))

(define (shift-right xs)
  (cons 0 xs))

(define (pascal n)
  (cond
    [(= n 1) '(1)]
    [#t (add-list
         (shift-left (pascal (sub1 n)))
         (shift-right (pascal (sub1 n))))]))

;; optimize pascal from exponential to quadratic time (1.7)

(define (faster-pascal n)
  (cond
    [(= n 1) '(1)]
    [#t
     (let ([l (faster-pascal (sub1 n))])
       (add-list (shift-left l) (shift-right l)))]))

;; lazily-evaluated pascal sequence (1.8)
;; TODO: complete definition using delay and force 

(define (lazy-pascal n)
  null)

;; illustrating higher-order function approach to generics (1.9)

(define (oplist o xs ys)
  (cond
    [(null? xs) '()]
    [#t (cons (o (car xs) (car ys))
              (oplist o (cdr xs) (cdr ys)))]))

(define (generic-pascal o n)
  (cond
    [(= n 1) '(1)]
    [#t (let ([l (generic-pascal o (sub1 n))])
          (oplist o (shift-left l) (shift-right l)))]))

;; run lambda within a thread (1.11)

(thread
 (lambda ()
   (sleep 10)
   (let ([x 99])
     (println (number->string (* x x))))))

;; implementing analog to object and class (1.13, 1.14)
;; TODO: complete

