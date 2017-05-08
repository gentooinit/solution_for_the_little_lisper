#lang racket
(define atom? (let ((f1 pair?) (f2 not)) (lambda (x) (f2 (f1 x)))))
; Help funtions
(define first
  (lambda (s)
    (car s)))

(define second
  (lambda (s)
    (car (cdr s))))

(define third
  (lambda (s)
    (car (cdr (cdr s)))))

(define fourth
  (lambda (s)
    (car (cdr (cdr (cdr s))))))

(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 (quote ())))))

(define lookup-in-entry-help
  (lambda (name names values entry-f)
    (cond
      ((null? names) (entry-f name))
      ((eq? (car names) name)
       (car values))
      (else (lookup-in-entry-help
              name
              (cdr names)
              (cdr values)
              entry-f)))))

(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help
      name
      (first entry)
      (second entry)
      entry-f)))

(define new-entry build)

(define lookup-in-table
  (lambda (name table table-f)
    (cond
      ((null? table) (table-f name))
      (else (lookup-in-entry
              name
              (car table)
              (lambda (name)
                (lookup-in-table
                  name
                  (cdr table)
                  table-f)))))))

(define extend-table cons)

; Actions
(define expression-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else (list-to-action e)))))

(define atom-to-action
  (lambda (e)
    (cond
      ((number? e) *self-evaluating)
      (else *identifier))))

(define list-to-action
  (lambda (e)
    (cond
      ((atom? (car e))
       (cond
         ((eq? (car e) (quote quote))
          *quote)
         ((eq? (car e) (quote lambda))
          *lambda)
         ((eq? (car e) (quote if))
          *if)
         (else *application)))
      (else *application))))

; The value function
(define value
  (lambda (e)
    (meaning e (quote ()))))

(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))

; *self
(define *self-evaluating
  (lambda (e table)
    e))

; *quote
(define text-of-quotation second)
(define *quote
  (lambda (e table)
    (text-of-quotation e)))

; *identifier
(define *identifier
  (lambda (e table)
    (lookup-in-table
      e table initial-table)))

(define initial-table
  (lambda (name)
    (cond
      ((eq? name (quote t)) #t)
      ((eq? name (quote nil)) #f)
      (else (build
              (quote primitive)
              name)))))

; *lambda
(define *lambda
  (lambda (e table)
    (build (quote non-primitive)
      (cons table (cdr e)))))

(define table-of first)
(define formals-of second)
(define body-of third)

; *if
(define *if
  (lambda (e table)
    (if (meaning (test-pt e) table)
        (meaning (then-pt e) table)
	(meaning (else-pt e) table))))

(define test-pt second)
(define then-pt third)
(define else-pt fourth)


; *application
(define evlis
  (lambda (args table)
    (cond
      ((null? args) (quote ()))
      (else (cons (meaning (car args) table)
              (evlis (cdr args) table))))))

(define primitive?
  (lambda (l)
    (eq?
      (first l)
      (quote primitive))))

(define non-primitive?
  (lambda (l)
    (eq?
      (first l)
      (quote non-primitive))))

(define apply
  (lambda (fun vals)
    (cond
      ((primitive? fun)
       (apply-primitive
         (second fun) vals))
      ((non-primitive? fun)
       (apply-closure
         (second fun) vals)))))

(define apply-primitive
  (lambda (name vals)
    (cond
      ((eq? name (quote car))
       (car (first vals)))
      ((eq? name (quote cdr))
       (cdr (first vals)))
      ((eq? name (quote cons))
       (cons (first vals) (second vals)))
      ((eq? name (quote atom?))
       (atom? (first vals)))
      ((eq? name (quote not))
       (not (first vals)))
      ((eq? name (quote null?))
       (null? (first vals)))
      ((eq? name (quote number?))
       (number? (first vals)))
      ((eq? name (quote zero?))
       (zero? (first vals)))
      ((eq? name (quote add1))
       (add1 (first vals)))
      ((eq? name (quote sub1))
       (sub1 (first vals))))))

(define apply-closure
  (lambda (closure vals)
    (meaning (body-of closure)
      (extend-table
        (new-entry
          (formals-of closure) vals)
        (table-of closure)))))

(define *application
  (lambda (e table)
    (apply
      (meaning (function-of e) table)
      (evlis (arguments-of e) table))))

(define function-of car)
(define arguments-of cdr)
