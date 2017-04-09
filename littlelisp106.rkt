; For exercise 10.6
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

(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 (quote ())))))

(define new-entry build)

(define extend-table
  (lambda (entry table)
    (lambda (name)
      (cond
	((member? name (first entry))
	 (pick (index name (first entry))
	       (second entry)))
	(else (table name))))))

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)
		(member? a (cdr lat)))))))

(define pick
  (lambda (n lat)
    (cond
      ((null? lat) #f)
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(define index
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eq? (car lat) a) 1)
      (else (add1 (index a (cdr lat)))))))

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
         ((eq? (car e) (quote cond))
          *cond)
         (else *application)))
      (else *application)))) 

; The value function
(define value
  (lambda (e)
    (meaning e initial-table)))

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
    (table e)))

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


; *cond
(define evcon
  (lambda (lines table)
    (cond
      ((meaning
         (question-of (car lines)) table)
       (meaning
         (answer-of (car lines)) table))
      (else (evcon (cdr lines) table)))))

(define question-of first)
(define answer-of second)

(define *cond
  (lambda (e table)
    (evcon (cond-lines e) table)))

(define cond-lines cdr)

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
