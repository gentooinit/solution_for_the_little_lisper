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
