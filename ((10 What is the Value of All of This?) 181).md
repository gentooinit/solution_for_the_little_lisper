```lisp
For these exercises,
                   e1 is ((lambda (x)
                            (cond
                              ((atom? x) (quote done))
                              ((null? x) (quote almost))
                              (t (quote never))))
                          (quote _____)),
                   e2 is (((lambda (x y)
                             (lambda (u)
                               (cond
                                 (u x)
                                 (t y))))
                           1 ())
                          nil),
                   e3 is ((lambda (x)
                            ((lambda (x)
                               (add1 x))
                             (add1 4)))
                          6),
                   e4 is (3 (quote a) (quote b)),
                   e5 is (lambda (lat) (cons (quote lat) lat)),
                   e6 is (lambda (lat (lyst)) a (quote b)).
```

###10.1 Make up examples for *e* and step through (value e). The examples should cover truth values, numbers, and quoted S-expressions.###
```lisp
Example1: (value e), where e is t,

Q1: What is the value of (value e), where e is t.
A1: Let's step through it.

Q2: (meaning e (quote ()))
A2: We have to get the value of (expression-to-action e), where e is t.
And apply its value as a function, with the arguments e and table.

Q3: (atom? e), where e is t
A3: t, so the value is (atom-to-action e).

Q4: (number? e)
A4: nil, so the value is *identifier.

Q5: (*identifier e table), where e is t and table is (quote ()).
A5: (lookup-in-table e table initial-table)

Q6: (null? table)
A6: t, then (initial-table e), where e is t.

Q7: (eq? 't (quote t))
A7: t, so the value is t!

Q8: Are got the answer?
A8: Yes, it is t.

Example2: (value e), where e is 42,

Q1: What is the value of (value e), where e is 42.
A1: Let's step through it.

Q2: (meaning e (quote ()))
A2: We have to get the value of (expression-to-action e), where e is 42.
And apply its value as a function, with the arguments e and table.

Q3: (atom? e), where e is 42
A3: t, so the value is (atom-to-action e).

Q4: (number? e)
A4: t, so the value is *self-evaluating

Q5: (*self-evaluating e table), where e is 42 and table is (quote ()).
A5: The value is 42.

Example3: (value e), where e is (quote (a b c)).

Q1: What is the value of (value e), where e is (quote (a b c)).
A1: Let's step through it.

Q2: (meaning e (quote ()))
A2: We have to get the value of (expression-to-action e), where e is (quote (a b c)).
And apply its value as a function, with the arguments e and table.

Q3: (atom? e), where e is (quote (a b c))
A3: nil, so the value is (list-to-action e).

Q4: (atom? (car e))
A4: t, because (car e) is quote.

Q5: (eq? (car e) (quote quote))
A5: t, (car e) is quote. So the value is *quote.

Q6: (*quote e table), where e is (quote (a b c)) and table is (quote ()).
A6: (text-of-quotation e), or (second e).

Q7: (car (cdr s)), s is e that is (quote (a b c))
A7: The value is (a b c).
```
  
