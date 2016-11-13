```lisp
For these exercuse,
                    aexp1 is (1 + (3 * 4))
                    aexp2 is ((3 ^ 4) + 5)
                    aexp3 is (3 * (4 * (5 * 6)))
                    aexp4 is 5
                       l1 is ()
                       l2 is (3 + (66 6))
                    lexp1 is (AND (OR x y) y)
                    lexp2 is (AND (NOT y) (OR u v))
                    lexp3 is (OR x y)
                    lexp4 is z
```

###7.1 So far we have neglected functions that build representations for arithmetic expressions###
```lisp
For example, mk+exp
(define mk+exp
  (lambda (aexp1 exp2)
    (cons aexp1
      (cons (quote +)
        (cons aexp2 ())))))
makes an arithmetic expression of the form (aexp1 + aexp2), where aexp1, aexp2 are already
arithmetic expressions. Write the corresponding functions mk*exp and mk^exp.

The arithmetic expression (1 + 3) can now be built by (mk+exp x y), where x is 1 and y is 3
Show how to build aexp1, aexp2, and aexp3.
```
```lisp
(define mk*exp
  (lambda (aexp1 aexp2)
    (cons aexp1
      (cons (quote *)
        (cons aexp2 (quote ()))))))

(define mk^exp
  (lambda (aexp1 aexp2)
    (cons aexp1
      (cons (quote *)
        (cons aexp2 (quote ()))))))

aexp1 can be built by (mk+exp 1 (mk*exp 3 4)),
aexp2 can be built by (mk+exp (mk^exp 3 4) 5),
aexp3 can be built by (mk*exp 3 (mk*exp 4 (mk*exp 5 6)))
```

###7.2 A useful function is aexp? that checks whether an S-expression is the representation of an arithmetic expression. Write the function aexp? and test it with some of the arithmetic expressions from the chapter. Also test it with S-expression that are not arithmetic expressions.
```lisp
Example: (aexp? aexp1) is true,
         (aexp? aexp2) is true,
            (aexp? l1) is false,
            (aexp? l2) is false
```
```lisp
(define 1st-sub-exp
  (lambda (aexp)
    (cond
      ((null? aexp) (quote ()))
      (t (car aexp)))))

(define 2nd-sub-exp
  (lambda (aexp)
    (cond
      ((null? aexp) (quote ()))
      ((null? (cdr aexp)) (quote ()))
      ((null? (cdr (cdr aexp))) (quote ()))
      (t (car (cdr (cdr aexp)))))))

(define operator
  (lambda (aexp)
    (cond
      ((null? aexp) (quote ()))
      ((null? (cdr aexp)) (quote ()))
      (t (car (cdr aexp))))))

(define aexp?
  (lambda (aexp)
    (cond
      ((null? aexp) nil)
      ((atom? aexp) t)
      ((or
         (eq? (operator aexp) (quote +))
         (eq? (operator aexp) (quote *))
         (eq? (operator aexp) (quote ^)))
       (and (aexp? (1st-sub-exp aexp))
            (aexp? (2nd-sub-exp aexp))))
      (t nil))))

(aexp? 1) is t,
(aexp? 3) is t,
(aexp? '(1 + 3 * 4)) is t,
(aexp? 'cookie) is t,
(aexp? '(3 ^ y + 5)) is t,
(aexp? '(3 +)) is nil,
(aexp? '(3)) is nil
```
