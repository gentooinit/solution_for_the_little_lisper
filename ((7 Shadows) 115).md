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

###7.3 Write the function count-op that counts the operators in an arithmetic expression###
```lisp
Example: (count-op aexp1) is 2,
         (count-op aexp3) is 3,
         (count-op aexp4) is 0.
Also write the functions cont+, count*, and count^ that count the respective operators
Example: (count+ aexp1) is 1,
         (count* aexp1) is 1,
         (count^ aexp1) is 0.
```
```lisp
(define count-op
  (lambda (aexp)
    (cond
      ((atom? aexp) 0)
      (t (add1
           (+ (count-op (1st-sub-exp aexp))
             (count-op (2nd-sub-exp aexp))))))))

(define count-op-x
  (lambda (aexp op)
    (cond
      ((atom? aexp) 0)
      ((eq? (operator aexp) op)
       (add1 (+ (count-op-x (1st-sub-exp aexp) op)
               (count-op-x (2nd-sub-exp aexp) op))))
      (t (+ (count-op-x (1st-sub-exp aexp) op)
           (count-op-x (2nd-sub-exp aexp) op))))))

(define count+
  (lambda (aexp)
    (count-op-x aexp (quote +))))

(define count*
  (lambda (aexp)
    (count-op-x aexp (quote *))))

(define count^
  (lambda (aexp)
    (count-op-x aexp (quote ^))))
```

###7.4 Write the function count-numbers that counts the numbers in an arithmetic expression###
```lisp
Example: (count-numbers aexp1) is 3,
         (count-numbers aexp3) is 4,
         (count-numbers aexp4) is 1
```
```lisp
(define count-numbers
  (lambda (aexp)
    (cond
      ((null? aexp) 0)
      ((number? aexp) 1)
      ((atom? aexp) 0)
      (t (+ (count-numbers (1st-sub-exp aexp))
           (count-numbers (2nd-sub-exp aexp)))))))
```

###7.5 Since it is inconvenient to write (3 * (4 * (5 * 6))) for multiplying 4 numbers, we now introduce prefix notation and allow + and * expressions to contain 2, 3, or 4 subexpressions. For example, (+ 3 2 (* 7 8)), (* 3 4 5 6) etc. are now legal representations. ^-expressions are also in prefix form but are still binary. Rewrite the functions numbered? and value for the new definition of aexp.###
Hint: You will need functions for extracting the third and the fourth subexpression of an arithmetic expression. You will also need a function cnt-aexp that counts the number of arithmetic subexpressions in the *list* following an operator.
```lisp
Example: When aexp1 is (+ 3 2 (* 7 8)),
              aexp2 is (* 3 4 5 6), and
              aexp3 is (^ aexp1 aexp2), then
   (cnt-aexp aexp1) is 3,
   (cnt-aexp aexp2) is 4,
   (cnt-aexp aexp3) is 2.
```
```lisp
(define operator
  (lambda (aexp)
    (car aexp)))

(define 1st-sub-exp
  (lambda (aexp)
    (car (cdr aexp))))

(define 2nd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))))

(define 3rd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr (cdr aexp))))))

(define 4th-sub-exp
  (lambda (aexp)
    (car (cdr (cdr (cdr (cdr aexp)))))))

(define cnt-aexp*
  (lambda (aexp)
    (cond
      ((null? aexp) 0)
      (t (add1 (cnt-aexp* (cdr aexp)))))))

(define cnt-aexp
  (lambda (aexp)
    (cond
      ((or
         (eq? (operator aexp) (quote +))
         (eq? (operator aexp) (quote *))
         (eq? (operator aexp) (quote ^)))
       (cnt-aexp* (cdr aexp)))
      (t 0))))

(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      ((eq? (cnt-aexp aexp) 1) (numbered? (1st-sub-exp aexp)))
      ((eq? (cnt-aexp aexp) 2)
       (and (numbered? (1st-sub-exp aexp))
         (numbered? (2nd-sub-exp aexp))))
      ((eq? (cnt-aexp aexp) 3)
       (and (numbered? (1st-sub-exp aexp))
         (numbered? (2nd-sub-exp aexp))
         (numbered? (3rd-sub-exp aexp))))
      ((eq? (cnt-aexp aexp) 4)
       (and (numbered? (1st-sub-exp aexp))
         (numbered? (2nd-sub-exp aexp))
         (numbered? (3rd-sub-exp aexp))
         (numbered? (4th-sub-exp aexp))))
      (t nil))))

(define value
  (lambda (nexp)
    (cond
      ((number? nexp) nexp)
      ((eq? (cnt-aexp nexp) 2)
       (cond
         ((eq? (operator nexp) (quote +))
          (+ (value (1st-sub-exp nexp))
            (value (2nd-sub-exp nexp))))
         ((eq? (operator nexp) (quote *))
          (* (value (1st-sub-exp nexp))
            (value (2nd-sub-exp nexp))))
         (t (expt (value (1st-sub-exp nexp))
              (value (2nd-sub-exp nexp))))))
      ((eq? (cnt-aexp nexp) 3)
       (cond
         ((eq? (operator nexp) (quote +))
          (+ (value (1st-sub-exp nexp))
            (value (2nd-sub-exp nexp))
            (value (3rd-sub-exp nexp))))
         (t (* (value (1st-sub-exp nexp))
              (value (2nd-sub-exp nexp))
              (value (3rd-sub-exp nexp))))))
      ((eq? (cnt-aexp nexp) 4)
       (cond
         ((eq? (operator nexp) (quote +))
          (+ (value (1st-sub-exp nexp))
            (value (2nd-sub-exp nexp))
            (value (3rd-sub-exp nexp))
            (value (4th-sub-exp nexp))))
         (t (* (value (1st-sub-exp nexp))
              (value (2nd-sub-exp nexp))
              (value (3rd-sub-exp nexp))
              (value (4th-sub-exp nexp))))))
       (t 0))))
```

For exercise 7.6 through 7.10 we define a representation for L-expressions. An L-expression is defined in the following way: It is either:
 * (AND l1 l2), or
 * (OR l1 l2), or
 * (NOT l), or
 * an arbitrary symbol. We call such a symbol a variable.

In this definition, **AND**, **OR**, and **NOT** are literal symbols; *l*, *l1*, *l2* stand for arbitrary L-expressions.

###7.6 Write the function lexp? that tests whether an S-expression is a representation of an L-expression.###
```lisp
Example: (lexp? lexp1) is true,
         (lexp? lexp2) is true,
         (lexp? lexp3) is true,
         (lexp? aexp1) is false,
            (lexp? l2) is false.

Also write the functions and-exp? or-exp? and not-exp? which test whether or not an S-expression is a representation of an L-expression of the respective shape.
Write the functions and-exp-left and and-exp-right, which extract the left and the right part of an (recognized) L-expression.
Exampe: (and-exp-left lexp1) is (OR x y),
       (and-exp-right lexp1) is y,
        (and-exp-left lexp2) is (NOT y),
       (and-exp-right lexp2) is (OR u v).
Finally, write the functions or-exp-left, or-exp-right, and not-exp-subexp, which extract the respective piecs of OR and NOT L-expressions.
```
```lisp
(define operator-lexp
  (lambda (lexp)
    (cond
      ((null? lexp) (quote ()))
      (t (car lexp)))))

(define 1st-sub-lexp
  (lambda (lexp)
    (cond
      ((null? lexp) (quote ()))
      ((null? (cdr lexp)) (quote ()))
      (t (car (cdr lexp))))))

(define 2nd-sub-lexp
  (lambda (lexp)
    (cond
      ((null? lexp) (quote ()))
      ((null? (cdr lexp)) (quote ()))
      ((null? (cdr (cdr lexp))) (quote ()))
      (t (car (cdr (cdr lexp)))))))

(define 3rd-sub-lexp
  (lambda (lexp)
    (cond
      ((null? lexp) (quote ()))
      ((null? (cdr lexp)) (quote ()))
      ((null? (cdr (cdr lexp))) (quote ()))
      ((null? (cdr (cdr (cdr lexp)))) (quote ()))
      (t (car (cdr (cdr (cdr lexp))))))))

(define lexp?
  (lambda (lexp)
    (cond
      ((null? lexp) nil)
      ((atom? lexp) t)
      (t (or (and-exp? lexp)
           (or-exp? lexp)
           (not-exp? lexp))))))

(define and-exp?
  (lambda (lexp)
    (cond
      ((null? lexp) nil)
      ((and
         (eq? (operator-lexp lexp) (quote AND))
         (null? (3rd-sub-lexp lexp)))
       (and (lexp? (1st-sub-lexp lexp))
         (lexp? (2nd-sub-lexp lexp))))
      (t nil))))

(define or-exp?
  (lambda (lexp)
    (cond
      ((null? lexp) nil)
      ((and
         (eq? (operator-lexp lexp) (quote OR))
         (null? (3rd-sub-lexp lexp)))
       (and (lexp? (1st-sub-lexp lexp))
         (lexp? (2nd-sub-lexp lexp))))
      (t nil))))

(define not-exp?
  (lambda (lexp)
    (cond
      ((null? lexp) nil)
      ((and
         (eq? (operator-lexp lexp) (quote NOT))
         (null? (2nd-sub-lexp lexp)))
       (lexp? (1st-sub-lexp lexp)))
      (t nil))))

(define and-exp-left
  (lambda (lexp)
    (1st-sub-lexp lexp)))

(define and-exp-right
  (lambda (lexp)
    (2nd-sub-lexp lexp)))

(define or-exp-left
  (lambda (lexp)
    (1st-sub-lexp lexp)))

(define or-exp-right
  (lambda (lexp)
    (2nd-sub-lexp lexp)))

(define not-exp-subexp
  (lambda (lexp)
    (1st-sub-lexp lexp)))
```

###7.7 Write the functions covered? of an L-expression *lexp* and a list of symbols *los* that tests whether all the variables in *lexp* are in *los*.###
```lisp
Exampe: When l1 is (x y z u), then
  (covered? lexp1 l1) is true,
  (covered? lexp2 l1) is false,
  (covered? lexp4 l1) is true.
```
```lisp
(define covered?
  (lambda (lexp los)
    (cond
      ((null? lexp) nil)
      ((atom? lexp) (member? lexp los))
      ((and-exp? lexp) (and (covered? (and-exp-left lexp) los)
                         (covered? (and-exp-right lexp) los)))
      ((or-exp? lexp) (and (covered? (or-exp-left lexp) los)
                         (covered? (or-exp-right lexp) los)))
      ((not-exp? lexp) (covered? (not-exp-subexp lexp) los))
      (t nil))))
```

###7.8 For the evaluation of L-expressions we need *association lists (alists)*. An alist for L-expressions is a list of pairs. The first component of a pair is always a symbol, the second one is either the number 0 (signifiying false) or 1 (signifying true). The second component is referred to as the value of the variable. Write the function lookup of the symbol *var* and the association list *al*, which returns the value of the first pair in *al* whose car is eq? to *var*.###
```lisp
Exampe: When l1 is ((x 1) (y 0)),
             l2 is ((u 1) (v 1)),
             l3 is (),
              a is y,
              b is u, then
  (lookup a l1) is 0,
  (lookup b l2) is 1,
 (lookup a l3) has an unspecified answer.
```
```lisp
(define lookup
  (lambda (var al)
    (cond
      ((null? al) (quote ()))
      ((eq? (car (car al)) var) (car (cdr (car al))))
      (t (lookup var (cdr al))))))
```