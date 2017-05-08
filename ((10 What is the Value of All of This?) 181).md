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

### 10.1 Make up examples for *e* and step through (value e). The examples should cover truth values, numbers, and quoted S-expressions.
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

Q5: (*identifier e table), where e is t and table is ()
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

Q5: (*self-evaluating e table), where e is 42 and table is ()
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

Q6: (*quote e table), where e is (quote (a b c)) and table is ()
A6: (text-of-quotation e), or (second e).

Q7: (car (cdr s)), s is e that is (quote (a b c))
A7: The value is (a b c).
```

### 10.2 Make up some S-expressions, plug them into the ______ of *e1*, and step through the application of (value e1).
```lisp
Q1: Let's try to plug cookie.
A1: ((lambda (x)
       (cond
         ((atom? x) (quote done))
         ((null? x) (quote almost))
         (t (quote never))))
     (quote cookie)),
     step through (value e1).

Q2: (meaning e (quote ()))
A2: We have to get the value of (expression-to-action e).
And apply its value as a function, with the arguments e and table.

Q3: (atom? e)
A3: nil, so the value is (list-to-action e).

Q4: (atom? (car e))
A4: nil, because (car e) is
    (lambda (x)
      (cond
        ((atom? x) (quote done))
        ((null? x) (quote almost))
        (t (quote never))))
    So, the value is *application.

Q5: (*application e table), where e is e1
A5: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q6: (meaning (car e) table)
A6: Go get (expression-to-action e) first.

Q7: (atom? e)
A7: nil, (list-to-action e).

Q8: (atom? (car e))
A8: t, (car e) is lambda.

Q9: (eq? (car e) (quote quote))
A9: nil.

Q10: (eq? (car e) (quote lambda))
A10: t, so the value of (expression-to-action) is *lambda.

Q11: (*lambda e table), where e is the (lambda ...) part of e1.
A11: (non-primitive
      (()
       (x)
       (cond
         ((atom? x) (quote done))
         ((null? x) (quote almost))
         (t (quote never)))))

Q12: Let's go get the value of arguments.
A12: (evlis (arguments-of e) table), where (arguments-of e) is ((quote cookie)).

Q13: (null? args)
A13: nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q14: (meaning e table), where e is (quote cookie)
A14: ((expression-to-action e) e table), where e is (quote cookie).

Q15: (atom? e), where e is (quote cookie)
A15: nil.

Q16: (list-to-action e), where e is (quote cookie)
A16: (atom? (car e)), yes, it is t.

Q17: (eq? (car e) (quote quote)), where e is (quote cookie)
A17: t, then the value of (expression-to-action e) is *quote.

Q18: (*quote e table), where e is (quote cookie)
A18: (text-of-quotation e), where e is (quote cookie).

Q19: (second e), where e is (quote cookie)
A19: cookie.

Q20: What next?
A20: We cons the cookie onto the (evlis (cdr args) table), where args is ((quote cookie)).

Q21: (evlis '() table)
A21: (null? '()), t. So, the value of (evlis '() table) is ().
     So we got (evlis (arguments-of e) table) is (cookie).

Q22: (apply '(non-primitive
             (()
              (x)
              (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never)))))
            '(cookie))

A22: Let's step through it.

Q23: (primitive? fun)
A23: The first of fun is non-primitive, so it is not primitive function.

Q24: (non-primitive? fun)
A24: t, then we (apple-closure (second fun) vals), where the fun is (non-primitive ...), and the vals is (cookie).

Q25: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is (() (x) (cond ...)), and the vals is (cookie).

A25: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never))).

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is ().

     So, it equals to (meaning '(cond ...) new-table),
     where new-table is (((x) (cookie)))

Q25: ((expression-to-action e) e table), where e is (cond ...), and the table is (((x) (cookie))).
A25: (atom? e), of course not, then (list-to-action e).

Q25: (atom? (car e)), where e is (cond ...)
A25: t.

Q26: (eq? (car e) (quote quote))
A26: nil.

Q27: (eq? (car e) (quote lambda))
A27: nil.

Q28: (eq? (car e) (quote cond))
A28: t, so the value of (expression-to-action e), where e is (cond ...), is *cond.

Q29: (*cond e talbe), where e is (cond ...), and table is ((x) (cookie))
A29: (evcon (cond-lines e) table), where (cond-lines e) is (((atom? x) ...) ((null? x) ...) (t ...)).

Q30: (meaning (question-of (car lines)) table)
A30: That is (meaning e table), where e is (atom? x), and table is (((x) (cookie))).

Q31: ((expression-to-action e) e table), where e is (atom? x), and table is (((x) (cookie))).
A31: (atom? e), of course not, then (list-to-action e).

Q32: (atom? (car e)), where e is (atom? x)
A32: t.

Q33: (eq? (car e) (quote quote))
A33: nil.

Q34: (eq? (car e) (quote lambda))
A34: nil.

Q35: (eq? (car e) (quote cond))
A35: nil.

Q36: t
A36: t, so the value of (expression-to-action e), where e is (atom? x), is *application.

Q37: (*application e table), where e is (atom? x), and table is (((x) (cookie)))
A37: We have to get the value of (meaning (function-of e) table), which means to get the value of atom?.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q38: (meaning (function-of e) table), where e is (atom? x), and table is (((x) (cookie)))
A38: ((expression-to-action e) e table), where e is atom?

Q39: (atom? e)
A39: t, then (atom-to-action e), where e is atom?

Q40: (number? e)
A40: nil, so the value is (expression-to-action e), where e is atom?, is *identifier.

Q41: (*identifier e table), where e is atom?, and table is (((x) (cookie)))
A41: (lookup-in-table e table initial-table)

Q42: (null? table)
A42: nil.

Q43: (lookup-in-entry
       name
       (car table)
       (lambda (name)
         (lookup-in-table
           name
           (cdr table)
           table-f))),
      where name is atom?,
            (car table) is ((x) (cookie)), and
            entry-f is (lambda (name)
                         (lookup-in-table
                           name
                           (cdr table)
                           table-f))
A43: That is (lookup-in-entry-help
               name
               (first entry)
               (second entry)
               entry-f),
     where name is atom?,
           (first entry) is (x),
           (second entry) is (cookie).

Q44: (null? names)
A44: nil, names is (x)

Q45: (eq? (car names) name)
A45: nil, because (car names) is x, and name is atom?. Then recur with (cdr names) and (cdr values)

Q46: (null? names)
A46: t, then ((lambda (name)
                (lookup-in-table
                  name
                  (cdr table)
                  table-f))
               name),
        where name is atom?,
              (cdr table) is ().

Q47: (null? table)
A47: t, then (initial-table name), where name is atom?.

Q48: (eq? name (quote t))
A48: nil.

Q49: (eq? name (quote nil))
A49: nil, so the value of (*identifier e table) is (primitive atom?).

Q50: Let's go get the value of arguments.
A50: (evlis (arguments-of e) table), where (arguments-of e) is (x).

Q51: (null? args)
A51: nil.

Q52: (meaning (car args) table), where (car args) is x, table is (((x) (cookie)))
A52: ((expression-to-action e) e table), where e is x.

Q53: (atom? e)
A53: t, so the value is (atom-to-action e).

Q54: (number? e)
A54: nil, so the value is *identifier.

Q55: (*identifier e table), where e is x, and table is (((x) (cookie)))
A55: (lookup-in-table e table initial-table)

Q56: (null? table)
A56: nil.

Q57: (lookup-in-entry
       name
       (car table)
       (lambda (name)
         (lookup-in-table
           name
           (cdr table)
           table-f))),
      where name is x,
            (car table) is ((x) (cookie)), and
            entry-f is (lambda (name)
                         (lookup-in-table
                           name
                           (cdr table)
                           table-f))
A57: That is (lookup-in-entry-help
               name
               (first entry)
               (second entry)
               entry-f),
     where name is x,
           (first entry) is (x),
           (second entry) is (cookie).

Q58: (null? names)
A58: nil.

Q59: (eq? (car names) name)
A59: t, because (car names) is x, and name is x. So the value of (*identifier e table) is cookie.

Q60: What next?
A60: We cons the cookie onto the (evlis (cdr args) table), where args is (x).

Q61: (evlis '() table)
A61: (null? '()), t. So, the value of (evlis '() table) is ().
     So we got (evlis (arguments-of e) table) is (cookie).

Q62: (apply '(primitive atom?)
            '(cookie))

A62: Let's step through it.

Q63: (primitive? fun)
A63: The first of fun is primitive, so it is primitive function.
     Then (apply-primitive name vals), where name is atom? and vals is (cookie).

Q64: (eq? name (quote car))
A64: nil.

Q65: (eq? name (quote cdr))
A65: nil.

Q66: (eq? name (quote cons))
A66: nil.

Q67: (eq? name (quote atom?))
A67: t, so the value of (meaning (question-of (car lines)) table)
     is (atom? (first vals)), that is t.

Q68: (meaning (answer-of (car lines)) table)
A68: That is (meaning e table), where e is (quote done), and table is (((x) (cookie))).

Q69: ((expression-to-action e) e table), where e is (quote done), table is (((x) (cookie)))
A69: (atom? e), of course not, then (list-to-action e).

Q70: (atom? (car e))
A70: t.

Q71: (eq? (car e) (quote quote))
A71: t, so the value of (expression-to-action) is *quote.

Q72: (*quote e table), where e is (quote done), and table is (((x) (cookie)))
A72: (text-of-quotation e), it is done.

Q73: Is it done?
A73: done.



Q1: Let's try to plug ().
A1: ((lambda (x)
       (cond
         ((atom? x) (quote done))
         ((null? x) (quote almost))
         (t (quote never))))
     (quote ())),
     step through (value e1).

Q2: (meaning e (quote ()))
A2: We have to get the value of (expression-to-action e).
And apply its value as a function, with the arguments e and table.

Q3: (atom? e)
A3: nil, so the value is (list-to-action e).

Q4: (atom? (car e))
A4: nil, because (car e) is
    (lambda (x)
      (cond
        ((atom? x) (quote done))
        ((null? x) (quote almost))
        (t (quote never))))
    So, the value is *application.

Q5: (*application e table), where e is e1
A5: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q6: (meaning (car e) table)
A6: Go get (expression-to-action e) first.

Q7: (atom? e)
A7: nil, (list-to-action e).

Q8: (atom? (car e))
A8: t, (car e) is lambda.

Q9: (eq? (car e) (quote quote))
A9: nil.

Q10: (eq? (car e) (quote lambda))
A10: t, so the value of (expression-to-action) is *lambda.

Q11: (*lambda e table), where e is the (lambda ...) part of e1.
A11: (non-primitive
      (()
       (x)
       (cond
         ((atom? x) (quote done))
         ((null? x) (quote almost))
         (t (quote never)))))

Q12: Let's go get the value of arguments.
A12: (evlis (arguments-of e) table), where (arguments-of e) is ((quote ())).

Q13: (null? args)
A13: nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q14: (meaning e table), where e is (quote ())
A14: ((expression-to-action e) e table), where e is (quote ()).

Q15: (atom? e), where e is (quote ())
A15: nil.

Q16: (list-to-action e), where e is (quote ())
A16: (atom? (car e)), yes, it is t.

Q17: (eq? (car e) (quote quote)), where e is (quote ())
A17: t, then the value of (expression-to-action e) is *quote.

Q18: (*quote e table), where e is (quote ())
A18: (text-of-quotation e), where e is (quote ()).

Q19: (second e), where e is (quote ())
A19: ().

Q20: What next?
A20: We cons the abc onto the (evlis (cdr args) table), where args is ((quote ())).

Q21: (evlis '() table)
A21: (null? '()), t. So, the value of (evlis '() table) is ().
     So we got (evlis (arguments-of e) table) is (()).

Q22: (apply '(non-primitive
             (()
              (x)
              (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never)))))
            '(()))

A22: Let's step through it.

Q23: (primitive? fun)
A23: The first of fun is non-primitive, so it is not primitive function.

Q24: (non-primitive? fun)
A24: t, then we (apple-closure (second fun) vals), where the fun is (non-primitive ...), and the vals is (()).

Q25: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is (() (x) (cond ...)), and the vals is (()).

A25: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never))).

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is ().

     So, it equals to (meaning '(cond ...) new-table),
     where new-table is (((x) (())))

Q25: ((expression-to-action e) e table), where e is (cond ...), and the table is (((x) (()))).
A25: (atom? e), of course not, then (list-to-action e).

Q25: (atom? (car e)), where e is (cond ...)
A25: t.

Q26: (eq? (car e) (quote quote))
A26: nil.

Q27: (eq? (car e) (quote lambda))
A27: nil.

Q28: (eq? (car e) (quote cond))
A28: t, so the value of (expression-to-action e), where e is (cond ...), is *cond.

Q29: (*cond e talbe), where e is (cond ...), and table is ((x) (abc))
A29: (evcon (cond-lines e) table), where (cond-lines e) is (((atom? x) ...) ((null? x) ...) (t ...)).

Q30: (meaning (question-of (car lines)) table)
A30: That is (meaning e table), where e is (atom? x), and table is (((x) (()))).

Q31: ((expression-to-action e) e table), where e is (atom? x), and table is (((x) (()))).
A31: (atom? e), of course not, then (list-to-action e).

Q32: (atom? (car e)), where e is (atom? x)
A32: t.

Q33: (eq? (car e) (quote quote))
A33: nil.

Q34: (eq? (car e) (quote lambda))
A34: nil.

Q35: (eq? (car e) (quote cond))
A35: nil.

Q36: t
A36: t, so the value of (expression-to-action e), where e is (atom? x), is *application.

Q37: (*application e table), where e is (atom? x), and table is (((x) (())))
A37: We have to get the value of (meaning (function-of e) table), which means to get the value of atom?.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q38: (meaning (function-of e) table), where e is (atom? x), and table is (((x) (())))
A38: ((expression-to-action e) e table), where e is atom?

Q39: (atom? e)
A39: t, then (atom-to-action e), where e is atom?

Q40: (number? e)
A40: nil, so the value is (expression-to-action e), where e is atom?, is *identifier.

Q41: (*identifier e table), where e is atom?, and table is (((x) (())))
A41: (lookup-in-table e table initial-table)

Q42: (null? table)
A42: nil.

Q43: (lookup-in-entry
       name
       (car table)
       (lambda (name)
         (lookup-in-table
           name
           (cdr table)
           table-f))),
      where name is atom?,
            (car table) is ((x) (())), and
            entry-f is (lambda (name)
                         (lookup-in-table
                           name
                           (cdr table)
                           table-f))
A43: That is (lookup-in-entry-help
               name
               (first entry)
               (second entry)
               entry-f),
     where name is atom?,
           (first entry) is (x),
           (second entry) is (()).

Q44: (null? names)
A44: nil, names is (x)

Q45: (eq? (car names) name)
A45: nil, because (car names) is x, and name is atom?. Then recur with (cdr names) and (cdr values)

Q46: (null? names)
A46: t, then ((lambda (name)
                (lookup-in-table
                  name
                  (cdr table)
                  table-f))
               name),
        where name is atom?,
              (cdr table) is ().

Q47: (null? table)
A47: t, then (initial-table name), where name is atom?.

Q48: (eq? name (quote t))
A48: nil.

Q49: (eq? name (quote nil))
A49: nil, so the value of (*identifier e table) is (primitive atom?).

Q50: Let's go get the value of arguments.
A50: (evlis (arguments-of e) table), where (arguments-of e) is (x).

Q51: (null? args)
A51: nil.

Q52: (meaning (car args) table), where (car args) is x, table is (((x) (())))
A52: ((expression-to-action e) e table), where e is x.

Q53: (atom? e)
A53: t, so the value is (atom-to-action e).

Q54: (number? e)
A54: nil, so the value is *identifier.

Q55: (*identifier e table), where e is x, and table is (((x) (())))
A55: (lookup-in-table e table initial-table)

Q56: (null? table)
A56: nil.

Q57: (lookup-in-entry
       name
       (car table)
       (lambda (name)
         (lookup-in-table
           name
           (cdr table)
           table-f))),
      where name is x,
            (car table) is ((x) (())), and
            entry-f is (lambda (name)
                         (lookup-in-table
                           name
                           (cdr table)
                           table-f))
A57: That is (lookup-in-entry-help
               name
               (first entry)
               (second entry)
               entry-f),
     where name is x,
           (first entry) is (x),
           (second entry) is (()).

Q58: (null? names)
A58: nil.

Q59: (eq? (car names) name)
A59: t, because (car names) is x, and name is x. So the value of (*identifier e table) is ().

Q60: What next?
A60: We cons the abc onto the (evlis (cdr args) table), where args is (x).

Q61: (evlis '() table)
A61: (null? ()), t. So, the value of (evlis '() table) is ().
     So we got (evlis (arguments-of e) table) is (()).

Q62: (apply '(primitive atom?)
            '(()))

A62: Let's step through it.

Q63: (primitive? fun)
A63: The first of fun is primitive, so it is primitive function.
     Then (apply-primitive name vals), where name is atom? and vals is (()).

Q64: (eq? name (quote car))
A64: nil.

Q65: (eq? name (quote cdr))
A65: nil.

Q66: (eq? name (quote cons))
A66: nil.

Q67: (eq? name (quote atom?))
A67: t, so the value of (meaning (question-of (car lines)) table)
     is (atom? (first vals)), that is t.

Q68: (meaning (answer-of (car lines)) table)
A68: That is (meaning e table), where e is (quote done), and table is (((x) (()))).

Q69: ((expression-to-action e) e table), where e is (quote done), table is (((x) (())))
A69: (atom? e), of course not, then (list-to-action e).

Q70: (atom? (car e))
A70: t.

Q71: (eq? (car e) (quote quote))
A71: t, so the value of (expression-to-action) is *quote.

Q72: (*quote e table), where e is (quote done), and table is (((x) (())))
A72: (text-of-quotation e), it is done.

Q73: Is it done?
A73: done.


Q1: Let's try to plug (banana).
A1: ((lambda (x)
       (cond
         ((atom? x) (quote done))
         ((null? x) (quote almost))
         (t (quote never))))
     (quote (banana))),
     step through (value e1).

Q2: (meaning e (quote ()))
A2: We have to get the value of (expression-to-action e).
And apply its value as a function, with the arguments e and table.

Q3: (atom? e)
A3: nil, so the value is (list-to-action e).

Q4: (atom? (car e))
A4: nil, because (car e) is
    (lambda (x)
      (cond
        ((atom? x) (quote done))
        ((null? x) (quote almost))
        (t (quote never))))
    So, the value is *application.

Q5: (*application e table), where e is e1
A5: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q6: (meaning (car e) table)
A6: Go get (expression-to-action e) first.

Q7: (atom? e)
A7: nil, (list-to-action e).

Q8: (atom? (car e))
A8: t, (car e) is lambda.

Q9: (eq? (car e) (quote quote))
A9: nil.

Q10: (eq? (car e) (quote lambda))
A10: t, so the value of (expression-to-action) is *lambda.

Q11: (*lambda e table), where e is the (lambda ...) part of e1.
A11: (non-primitive
      (()
       (x)
       (cond
         ((atom? x) (quote done))
         ((null? x) (quote almost))
         (t (quote never)))))

Q12: Let's go get the value of arguments.
A12: (evlis (arguments-of e) table), where (arguments-of e) is ((quote (banana))).

Q13: (null? args)
A13: nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q14: (meaning e table), where e is (quote (banana))
A14: ((expression-to-action e) e table), where e is (quote (banana)).

Q15: (atom? e), where e is (quote (banana))
A15: nil.

Q16: (list-to-action e), where e is (quote (banana))
A16: (atom? (car e)), yes, it is t.

Q17: (eq? (car e) (quote quote)), where e is (quote (banana))
A17: t, then the value of (expression-to-action e) is *quote.

Q18: (*quote e table), where e is (quote (banana))
A18: (text-of-quotation e), where e is (quote (banana)).

Q19: (second e), where e is (quote (banana))
A19: (banana).

Q20: What next?
A20: We cons the (banana) onto the (evlis (cdr args) table), where args is ((quote (banana))).

Q21: (evlis '() table)
A21: (null? '()), t. So, the value of (evlis '() table) is ().
     So we got (evlis (arguments-of e) table) is ((banana)).

Q22: (apply '(non-primitive
             (()
              (x)
              (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never)))))
            '((banana)))

A22: Let's step through it.

Q23: (primitive? fun)
A23: The first of fun is non-primitive, so it is not primitive function.

Q24: (non-primitive? fun)
A24: t, then we (apple-closure (second fun) vals), where the fun is (non-primitive ...), and the vals is ((banana)).

Q25: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is (() (x) (cond ...)), and the vals is ((banana)).

A25: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never))).

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is ().

     So, it equals to (meaning '(cond ...) new-table),
     where new-table is (((x) ((banana))))

Q25: ((expression-to-action e) e table), where e is (cond ...), and the table is (((x) ((banana)))).
A25: (atom? e), of course not, then (list-to-action e).

Q25: (atom? (car e)), where e is (cond ...)
A25: t.

Q26: (eq? (car e) (quote quote))
A26: nil.

Q27: (eq? (car e) (quote lambda))
A27: nil.

Q28: (eq? (car e) (quote cond))
A28: t, so the value of (expression-to-action e), where e is (cond ...), is *cond.

Q29: (*cond e talbe), where e is (cond ...), and table is ((x) ((banana)))
A29: (evcon (cond-lines e) table), where (cond-lines e) is (((atom? x) ...) ((null? x) ...) (t ...)).

Q30: (meaning (question-of (car lines)) table)
A30: That is (meaning e table), where e is (atom? x), and table is (((x) ((banana)))).

Q31: ((expression-to-action e) e table), where e is (atom? x), and table is (((x) ((banana)))).
A31: (atom? e), of course not, then (list-to-action e).

Q32: (atom? (car e)), where e is (atom? x)
A32: t.

Q33: (eq? (car e) (quote quote))
A33: nil.

Q34: (eq? (car e) (quote lambda))
A34: nil.

Q35: (eq? (car e) (quote cond))
A35: nil.

Q36: t
A36: t, so the value of (expression-to-action e), where e is (atom? x), is *application.

Q37: (*application e table), where e is (atom? x), and table is (((x) ((banana))))
A37: We have to get the value of (meaning (function-of e) table), which means to get the value of atom?.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q38: (meaning (function-of e) table), where e is (atom? x), and table is (((x) ((banana))))
A38: ((expression-to-action e) e table), where e is atom?

Q39: (atom? e)
A39: t, then (atom-to-action e), where e is atom?

Q40: (number? e)
A40: nil, so the value is (expression-to-action e), where e is atom?, is *identifier.

Q41: (*identifier e table), where e is atom?, and table is (((x) ((banana))))
A41: (lookup-in-table e table initial-table)

Q42: (null? table)
A42: nil.

Q43: (lookup-in-entry
       name
       (car table)
       (lambda (name)
         (lookup-in-table
           name
           (cdr table)
           table-f))),
      where name is atom?,
            (car table) is ((x) ((banana))), and
            entry-f is (lambda (name)
                         (lookup-in-table
                           name
                           (cdr table)
                           table-f))
A43: That is (lookup-in-entry-help
               name
               (first entry)
               (second entry)
               entry-f),
     where name is atom?,
           (first entry) is (x),
           (second entry) is ((banana)).

Q44: (null? names)
A44: nil, names is (x)

Q45: (eq? (car names) name)
A45: nil, because (car names) is x, and name is atom?. Then recur with (cdr names) and (cdr values)

Q46: (null? names)
A46: t, then ((lambda (name)
                (lookup-in-table
                  name
                  (cdr table)
                  table-f))
               name),
        where name is atom?,
              (cdr table) is ().

Q47: (null? table)
A47: t, then (initial-table name), where name is atom?.

Q48: (eq? name (quote t))
A48: nil.

Q49: (eq? name (quote nil))
A49: nil, so the value of (*identifier e table) is (primitive atom?).

Q50: Let's go get the value of arguments.
A50: (evlis (arguments-of e) table), where (arguments-of e) is (x).

Q51: (null? args)
A51: nil.

Q52: (meaning (car args) table), where (car args) is x, table is (((x) ((banana))))
A52: ((expression-to-action e) e table), where e is x.

Q53: (atom? e)
A53: t, so the value is (atom-to-action e).

Q54: (number? e)
A54: nil, so the value is *identifier.

Q55: (*identifier e table), where e is x, and table is (((x) ((banana))))
A55: (lookup-in-table e table initial-table)

Q56: (null? table)
A56: nil.

Q57: (lookup-in-entry
       name
       (car table)
       (lambda (name)
         (lookup-in-table
           name
           (cdr table)
           table-f))),
      where name is x,
            (car table) is ((x) ((banana))), and
            entry-f is (lambda (name)
                         (lookup-in-table
                           name
                           (cdr table)
                           table-f))
A57: That is (lookup-in-entry-help
               name
               (first entry)
               (second entry)
               entry-f),
     where name is x,
           (first entry) is (x),
           (second entry) is ((banana)).

Q58: (null? names)
A58: nil.

Q59: (eq? (car names) name)
A59: t, because (car names) is x, and name is x. So the value of (*identifier e table) is (banana).

Q60: What next?
A60: We cons the (banana) onto the (evlis (cdr args) table), where args is (x).

Q61: (evlis '() table)
A61: (null? '()), t. So, the value of (evlis '() table) is ().
     So we got (evlis (arguments-of e) table) is ((banana)).

Q62: (apply '(primitive atom?)
            '((banana)))

A62: Let's step through it.

Q63: (primitive? fun)
A63: The first of fun is primitive, so it is primitive function.
     Then (apply-primitive name vals), where name is atom? and vals is ((banana)).

Q64: (eq? name (quote car))
A64: nil.

Q65: (eq? name (quote cdr))
A65: nil.

Q66: (eq? name (quote cons))
A66: nil.

Q67: (eq? name (quote atom?))
A67: t, so the value of (meaning (question-of (car lines)) table)
     is (atom? (first vals)), that is nil.

Q68: (evcon (cdr lines) table), where (cdr lines) is (((null? x) (quote almost)) (t (quote never))), and table is (((x) ((banana))))
A68: (meaning (question-of (car lines)) table), that is (meaning e table), where e is (null? x)

Q69: ((expression-to-action e) e table), where e is (null? x), and table is (((x) ((banana)))).
A69: (atom? e), of course not, then (list-to-action e).

Q70: (atom? (car e)), where e is (atom? x)
A70: t.

Q71: (eq? (car e) (quote quote))
A71: nil.

Q72: (eq? (car e) (quote lambda))
A72: nil.

Q73: (eq? (car e) (quote cond))
A73: nil.

Q74: t
A74: t, so the value of (expression-to-action e), where e is (null? x), is *application.

Q75: (*application e table), where e is (null? x), and table is (((x) ((banana))))
A75: We have to get the value of (meaning (function-of e) table), which means to get the value of null?.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q76: (meaning (function-of e) table), where e is (null? x), and table is (((x) ((banana))))
A76: ((expression-to-action e) e table), where e is null?

Q77: (atom? e)
A77: t, then (atom-to-action e), where e is null?

Q78: (number? e)
A78: nil, so the value is (expression-to-action e), where e is null?, is *identifier.

Q79: (*identifier e table), where e is null?, and table is (((x) ((banana))))
A79: (lookup-in-table e table initial-table)

Q80: (null? table)
A80: nil.

Q81: (lookup-in-entry
       name
       (car table)
       (lambda (name)
         (lookup-in-table
           name
           (cdr table)
           table-f))),
      where name is null?,
            (car table) is ((x) ((banana))), and
            entry-f is (lambda (name)
                         (lookup-in-table
                           name
                           (cdr table)
                           table-f))
A81: That is (lookup-in-entry-help
               name
               (first entry)
               (second entry)
               entry-f),
     where name is null?,
           (first entry) is (x),
           (second entry) is ((banana)).

Q82: (null? names)
A82: nil, names is (x)

Q83: (eq? (car names) name)
A83: nil, because (car names) is x, and name is null?. Then recur with (cdr names) and (cdr values)

Q84: (null? names)
A84: t, then ((lambda (name)
                (lookup-in-table
                  name
                  (cdr table)
                  table-f))
               name),
        where name is null?,
              (cdr table) is ().

Q85: (null? table)
A85: t, then (initial-table name), where name is null?.

Q86: (eq? name (quote t))
A86: nil.

Q87: (eq? name (quote nil))
A87: nil, so the value of (*identifier e table) is (primitive null?).

Q88: Let's go get the value of arguments.
A88: (evlis (arguments-of e) table), where (arguments-of e) is (x).

Q89: (null? args)
A89: nil.

Q90: (meaning (car args) table), where (car args) is x, table is (((x) ((banana))))
A90: ((expression-to-action e) e table), where e is x.

Q91: (atom? e)
A91: t, so the value is (atom-to-action e).

Q92: (number? e)
A92: nil, so the value is *identifier.

Q93: (*identifier e table), where e is x, and table is (((x) ((banana))))
A93: (lookup-in-table e table initial-table)

Q94: (null? table)
A94: nil.

Q95: (lookup-in-entry
       name
       (car table)
       (lambda (name)
         (lookup-in-table
           name
           (cdr table)
           table-f))),
      where name is x,
            (car table) is ((x) ((banana))), and
            entry-f is (lambda (name)
                         (lookup-in-table
                           name
                           (cdr table)
                           table-f))
A95: That is (lookup-in-entry-help
               name
               (first entry)
               (second entry)
               entry-f),
     where name is x,
           (first entry) is (x),
           (second entry) is ((banana)).

Q96: (null? names)
A96: nil.

Q97: (eq? (car names) name)
A97: t, because (car names) is x, and name is x. So the value of (*identifier e table) is (banana).

Q98: What next?
A98: We cons the (banana) onto the (evlis (cdr args) table), where args is (x).

Q99: (evlis '() table)
A99: (null? '()), t. So, the value of (evlis '() table) is ().
     So we got (evlis (arguments-of e) table) is ((banana)).

Q100: (apply '(primitive null?)
             '((banana)))

A100: Let's step through it.

Q101: (primitive? fun)
A101: The first of fun is primitive, so it is primitive function.
     Then (apply-primitive name vals), where name is null? and vals is ((banana)).

Q102: (eq? name (quote car))
A102: nil.

Q103: (eq? name (quote cdr))
A103: nil.

Q104: (eq? name (quote cons))
A104: nil.

Q105: (eq? name (quote atom?))
A105: nil.

Q106: (eq? name (quote not))
A106: nil.

Q107: (eq? name (quote null?))
A107: t, so the value of (meaning (question-of (car lines)) table)
     is (null? (first vals)), that is nil.

Q108: (evcon (cdr lines) table), where (cdr lines) is ((t (quote never))), and table is (((x) ((banana))))
A108: (meaning (question-of (car lines)) table), that is (meaning e table), where e is t.

Q109: ((expression-to-action e) e table), where e is t, and table is (((x) ((banana)))).
A109: (atom? e), t, then (atom-to-action e).

Q110: (number? e)
A110: nil, then the value of (expression-to-action e) is *identifier.

Q111: (*identifier e table), where e is t, and table is (((x) ((banana))))
A111: (lookup-in-table e table initial-table)

Q112: (null? table)
A112: nil.

Q113: (lookup-in-entry
       name
       (car table)
       (lambda (name)
         (lookup-in-table
           name
           (cdr table)
           table-f))),
      where name is t,
            (car table) is ((x) ((banana))), and
            entry-f is (lambda (name)
                         (lookup-in-table
                           name
                           (cdr table)
                           table-f))
A113: That is (lookup-in-entry-help
               name
               (first entry)
               (second entry)
               entry-f),
     where name is t,
           (first entry) is (x),
           (second entry) is ((banana)).

Q114: (null? names)
A114: nil, names is (x)

Q115: (eq? (car names) name)
A115: nil, because (car names) is x, and name is t. Then recur with (cdr names) and (cdr values)

Q116: (null? names)
A116: t, then ((lambda (name)
                (lookup-in-table
                  name
                  (cdr table)
                  table-f))
               name),
        where name is t,
              (cdr table) is ().

Q117: (null? table)
A117: t, then (initial-table name), where name is t.

Q118: (eq? name (quote t))
A118: t, so the value of (*identifier e table) is t.

Q119: (meaning (answer-of (car lines)) table)
A119: That is (meaning e table), where e is (quote never), and table is (((x) ((banana)))).

Q120: ((expression-to-action e) e table), where e is (quote never), table is (((x) ((banana))))
A120: (atom? e), of course not, then (list-to-action e).

Q121: (atom? (car e))
A121: t.

Q122: (eq? (car e) (quote quote))
A122: t, so the value of (expression-to-action) is *quote.

Q123: (*quote e table), where e is (quote never), and table is (((x) ((banana))))
A123: (text-of-quotation e), it is never.

Q124: Is it done?
A124: done.
```

### 10.3 Step through the application of (value e2). How many closures are produced during the application?
```lisp
Q1: What is the value of (value e), where e is
    (((lambda (x y)
        (lambda (u)
          (cond
            (u x)
            (t y))))
      1 ())
     nil)
A1: Let's step through it.

Q2: (meaning e (quote ()))
A2: We have to get the value of (expression-to-action e), where e is e2.
And apply its value as a function, with the arguments e and table.

Q3: (atom? e)
A3: nil, then (list-to-action e)

Q4: (atom? (car e)), where e is e2
A4: nil, then the value of (expression-to-action e) is *application.

Q5: (*application e table), where e is e2
A5: We have to get the value of (meaning (function-of e) table), which means to get the value of the ((lambda ...)) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q6: (meaning (function-of e) table), e is e2
A6: (function-of e) is
    ((lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))
     1 ())

    Go get (expression-to-action e) first, where e is
    ((lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))
     1 ())

Q7: (atom? e), where e is
    ((lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))
     1 ())
A7: nil, then (list-to-action e).

Q8: (atom? (car e))
A8: nil, then the value of (expression-to-action e) is *application.

Q9: (*application e table), where e is
    ((lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))
     1 ()), table is ()
A9: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q10: (meaning (function-of e) table), e is
     ((lambda (x y)
        (lambda (u)
          (cond
           (u x)
           (t y))))
      1 ())
A10: (function-of e) is
     (lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))

    Go get (expression-to-action e) first, where e is
     (lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))

Q11: (atom? e)
A11: nil, then the value is (list-to-action e).

Q12: (atom? (car e)), where e is (lambda (x y) ...)
A12: t.

Q13: (eq? (car e) (quote quote))
A13: nil.

Q14: (eq? (car e) (quote lambda))
A14: t, so the value of (expression-to-action e) is *lambda.

Q15: (*lambda e table), where e is
     (lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y)))), and table is ()
A15: (non-primitive
      (()                                        <--------- the first closure
       (x y)
       (lambda (u)
         (cond
           (u x)
           (t y)))))

Q16: Let's go get the value of arguments.
A16: (evlis (arguments-of e) table), where (arguments-of e) is (1 ()).

Q17: (null? args)
A17: nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q18: (meaning e table), where e is 1
A18: ((expression-to-action e) e table), where e is 1.

Q19: (atom? e)
A19: t, then the value is (atom-to-action e).

Q20: (number? e), where e is 1
A20: t, so the value of (expression-to-action e) is *self-evaluating.

Q21: (*self-evaluating e table), where e is 1
A21: 1.

Q22: What next?
A22: We cons the 1 onto the (evlis (cdr args) table), where args is (1 ()).

Q23: (evlis args table), where args is (())
A23: (null? args), nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q24: (meaning e table), where e is ()
A24: ((expression-to-action e) e table), where e is ().

Q25: (atom? e)
A25: t, so the value is (atom-to-action e).

Q26: (atom? (car e))
A26: nil, so the value of (expression-to-action e) is *identifier.

Q27: (*identifier e table)
A27: (lookup-in-table e table initial-table), where e is (), table is ().

Q28: (null? table)
A28: t, go (table-f name), where table-f is initial-table, that is (initial-table name),

Q29: (eq? name (quote t))
A29: nil.

Q30: (eq? name (quote nil))
A30: nil, so the value of (meaning e table) is (primitive ()).

Q31: What next?
A31: We cons the (primitive ()) onto the (evlis (cdr args) table), where args is (()).

Q32: (evlis args table), where args is ().
A32: (null? args), t, so the value of (evlis '() table) is (),
then the value of (evlis (arguments-of e) table) is (1 (primitive ())).

Q33: (apply
       '(non-primitive
        (()
         (x y)
         (lambda (u)
           (cond
             (u x)
             (t y)))))
       '(1 (primitive ())))
A33: Let's step through it.

Q34: (primitive? fun)
A34: The first of the fun is non-primitive, so it is not a primitive function.

Q35: (non-primitive? fun)
A35: t, then we (apple-closure (second fun) vals), where the fun is (non-primitive ...), and the vals is (1 (primitive ())).

Q36: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is (() (x y) (lambda ...)), and the vals is (1 (primitive ())).

A36: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (lambda (u)
                (cond
                  (u x)
                  (t y))).

     The (formals-of closure) is the second part of closure,
     which is (x y).

     The (table-of closure) is the first part of closure,
     which is ().

     So, it equals to (meaning '(lambda ...) new-table),
     where new-table is (((x y) (1 (primitive ()))))

Q37: ((expression-to-action e) e table), where e is (lambda ...), and the table is (((x y) (1 (primitive ()))))
A37: (atom? e), of course not, then (list-to-action e).

Q38: (atom? (car e)), where e is (lambda ...)
A38: t.

Q39: (eq? (car e) (quote quote))
A39: nil.

Q40: (eq? (car e) (quote lambda))
A40: t, so the value of (expression-to-action e) is *lambda.

Q41: (*lambda e table), where e is
     (lambda (u)
       (cond
         (u x)
         (t y))),
     table is (((x y) (1 (primitive ()))))
A41: (non-primitive
      ((((x y) (1 (primitive ()))))              <--------- the second closure
       (u)
       (cond
         (u x)
         (t y))))

Q42: Let's go get the value of arguments.
A42: (evlis (arguments-of e) table), where (arguments-of e) is (nil).

Q43: (null? args)
A43: nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q44: (meaning e table), where e is nil
A44: ((expression-to-action e) e table), where e is nil.

Q45: (atom? e)
A45: t, so the value is (atom-to-action e).

Q46: (number? e), where e is nil
A46: nil, so the value of (expression-to-action e) is *identifier.

Q47: (*identifier e table), where e is nil, table is ()
A47: (lookup-in-table e table initial-table)

Q48: (null? table)
A48: t, (table-f name), that is (initial-table name), where name is nil.

Q49: (eq? name (quote t))
A49: nil.

Q50: (eq? name (quote nil))
A50: t, so the value of (meaning (car args) table), where args is (nil), is nil.

Q51: (evlis (cdr args) table), where (cdr args) is ()
A51: (null? args) is t, so the value of (evlis (cdr args) table) is ().

Q52: (cons (meaning (car args) table) (evlis (cdr args) table))
A52: (nil).

Q53: (apply
        '(non-primitive
         ((((x y) (1 (primitive ()))))
          (u)
          (cond
            (u x)
            (t y))))
        '(nil))

A53: Let's step through it.

Q54: (primitive? fun)
A54: nil.

Q55: (non-primitive? fun)
A55: t, then we (apple-closure (second fun) vals), where the fun is (non-primitive ...), and the vals is (nil).

Q56: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is ((((x y) (1 (primitive ())))) (u) (cond (u x) (t y))), and the vals is (nil).

A56: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (cond
                (u x)
                (t y))

     The (formals-of closure) is the second part of closure,
     which is (u).

     The (table-of closure) is the first part of closure,
     which is (((x y) (1 (primitive ()))))

     So, it equals to (meaning '(cond ...) new-table),
     where new-table is (((u) (nil)) ((x y) (1 (primitive ()))))

Q57: ((expression-to-action e) e table), where e is (cond ...), and the table is (((u) (nil)) ((x y) (1 (primitive ()))))
A57: (atom? e), of course not, then (list-to-action e).

Q58: (atom? (car e))
A58: t.

Q59: (eq? (car e) (quote quote))
A59: nil.

Q60: (eq? (car e) (quote lambda))
A60: nil.

Q61: (eq? (car e) (quote cond))
A61: t, so the value of (expression-to-action e) is *cond.

Q62: (*cond e table), where e is (cond ...)
A62: (evcon (cond-lines e) table), where (cond-lines e) is ((u x) (t y)).

Q63: (meaning (question-of (car lines)) table)
A63: (meaning e table), where e is u, table is (((u) (nil)) ((x y) (1 (primitive ())))).

Q64: (atom? e)
A64: t, so the value is (atom-to-action e).

Q65: (number? e)
A65: nil, so the value of (expression-to-action e) is *identifier.

Q66: (*identifier e table)
A66: (lookup-in-table e table initial-table).

Q67: (null? table)
A67: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is u.

Q68: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A68: name is u, (first entry) is (u), (second entry) is (nil), entry-f is (lambda ...).

Q69: (null? names)
A69: nil.

Q70: (eq? (car names) name)
A70: t, so the value of (*identifier e table) is (car values), that is nil.

Q71: (evcon (cdr lines) table), where (cdr lines) is ((t y))
A71: (meaning (question-of (car lines) table)).

Q72: (meaning e table), where e is t, table is (((u) (nil)) ((x y) (1 (primitive ()))))
A72: ((expression-to-action e) e table).

Q73: (atom? e)
A73: t, so the values is (atom-to-action e).

Q74: (number? e)
A74: nil, so the values of (expression-to-action e) is *identifier.

Q75: (*identifier e table)
A75: (lookup-in-table e table initial-table).

Q76: (null? table)
A76: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is t.

Q77: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A77: name is t, (first entry) is (u), (second entry) is (nil), entry-f is (lambda ...).

Q78: (null? names)
A78: nil.

Q79: (eq? (car names) name)
A79: ni.

Q80: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A80: name is t, (cdr names) is (), (cdr values) is (), entry-f is (lambda ...).

Q81: (null? names)
A81: t, go ((lambda (name)
             (lookup-in-table
               name
               (cdr table)
               table-f)) name)

Q82: (lookup-in-table name (cdr table) table-f)
A82: name is t, (cdr table) is (((x y) (1 (primitive ())))).

Q83: (null? table)
A83: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is t.

Q84: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A84: name is t, (first entry) is (x y), (second entry) is (1 (primitive ())), entry-f is (lambda ...).

Q85: (null? names)
A85: nil.

Q86: (eq? (car names) name)
A86: ni.

Q87: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A87: name is t, (cdr names) is (y), (cdr values) is ((primitive ())), entry-f is (lambda ...).

Q88: (null? names)
A88: nil.

Q89: (eq? (car names) name)
A89: ni.

Q90: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A90: name is t, (cdr names) is (), (cdr values) is (), entry-f is (lambda ...).

Q91: (null? names)
A91: t, go ((lambda (name)
             (lookup-in-table
               name
               (cdr table)
               table-f)) name)

Q92: (lookup-in-table name (cdr table) table-f)
A92: name is t, (cdr table) is ().

Q93: (null? table)
A93: t, go (table-f name), that is (initial-table name), name is t.

Q94: (eq? name (quote t))
A94: t, so the value of (*identifier e table) is t.

Q95: Let's go back to (evcon ...)
A95: Because the (meaning (question-of (car lines)) table) is t, so the value of
the whole expression is (meaning (answer-of (car lines)) table).

Q96: ((expression-to-action e) e table), where e is y, table is (((u) (nil)) ((x y) (1 (primitive ()))))
A96: (atom? e), t, go (atom-ato-action e).

Q97: (number? e)
A97: nil, so the value is (*identifier).

Q98: (*identifier e table)
A98: (lookup-in-table e table initial-table).

Q99: (null? table)
A99: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is y.

Q100: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A100: name is y, (first entry) is (u), (second entry) is (nil), entry-f is (lambda ...).

Q101: (null? names)
A101: nil.

Q102: (eq? (car names) name)
A102: ni.

Q103: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A103: name is y, (cdr names) is (), (cdr values) is (), entry-f is (lambda ...).

Q104: (null? names)
A104: t, go ((lambda (name)
             (lookup-in-table
               name
               (cdr table)
               table-f)) name)

Q105: (lookup-in-table name (cdr table) table-f)
A105: name is y, (cdr table) is (((x y) (1 (primitive ())))).

Q106: (null? table)
A106: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is y.

Q107: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A107: name is y, (first entry) is (x y), (second entry) is (1 (primitive ())), entry-f is (lambda ...).

Q108: (null? names)
A108: nil.

Q109: (eq? (car names) name)
A109: ni.

Q110: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A110: name is y, (cdr names) is (y), (cdr values) is ((primitive ())), entry-f is (lambda ...).

Q111: (null? names)
A111: nil.

Q112: (eq? (car names) name)
A112: t, so the value of the whole expression is (car values), that is (primitive ()).

Two closures are produced during the application.

```

### 10.4 Consider the expression *e3*. What do you expect to be the value of *e3*? Which of the three x's are "related"? Verify your answers by stepping through (value e3). Observe to which x we add one.

I expect the value of *e3* is 6. The inner two X's are "related".
```lisp
Q1: What is the value of e3?
A1: Let's step through it.

Q2: (meaning e (quote ()))
A2: ((expression-to-action e) e table).

Q3: (expression-to-action e)
A3: *application.

Q4: (*application e table), where e is e3, table is ()
A4: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q5: (meaning (function-of e) table)
A5: ((expression-to-action e) e table), where e is (lambda ...), table is ().

Q6: (expression-to-action e)
A6: *lambda.

Q7: (*lambda e table), where e is
    (lambda (x)
      ((lambda (x)
         (add1 x))
       (add1 4)))
A7: (non-primitive
     (()
      (x)
      ((lambda (x)
         (add1 x)
       (add1 4)))))

Q8: (evlis (arguments-of e) table)
A8: (6).

Q9: (apply '(non-primitive
             (()
              (x)
              ((lambda (x)
                 (add1 x))
               (add1 4))))
           '(6))
A9: Non-primitive function, go (apply-closure (second fun) vals)

Q10: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is (() (x) (cond ...)), and the vals is (6).

A10: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is ((lambda (x)
                 (add1 x))
               (add1 4))

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is ().

     So, it equals to (meaning '((lambda ...)) new-table),
     where new-table is (((x) (6)))

Q11: (expression-to-action e), where e is ((lambda ...))
A11: *application.

Q12: (*application e table), where e is ((lambda ...), table is (((x) (6)))
A12: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q13: (meaning (function-of e) table)
A13: ((expression-to-action e) e table), where e is (lambda ...), table is (((x) (6))).

Q14: (expression-to-action e)
A14: *lambda.

Q15: (*lambda e table), where e is
     (lambda (x)
       (add1 x))
A15: (non-primitive
     ((((x) (6)))
      (x)
      (add1 x)))

Q16: (evlis (arguments-of e) table)
A16: (5).

Q17: (apply '(non-primitive
             ((((x) (6)))
              (x)
              (add1 x)))
           '(5))
A17: Non-primitive function, go (apply-closure (second fun) vals)

Q18: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is ((((x) (6))) (x) (add1 x)), and the vals is (5).

A18: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (add1 x)

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is (((x) (6))).

     So, it equals to (meaning '(add1 x)) new-table),
     where new-table is (((x) (5)) ((x) (6))).

Q19: (expression-to-action e), where e is (add1 x)
A19: *application.

Q20: (*application e table), where e is (add1 x), table is (((x) (5)) ((x) (6)))
A20: We have to get the value of (meaning (function-of e) table), which means to get the value of the add1 part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q21: (meaning e table), where e is add1
A21: ((expression-to-action e) e table).

Q22: (*identifier e table)
A22: (primitive add1).

Q23: (evlis (arguments-of e) table)
A23: (5).

Q24: (apply '(primitive add1) '(5))
A24: (apply-primitive '(primitive add1) '(5)).

Q25: (add1 5)
A25: 6.

(add1 4) is the x we add one.

```

### 10.5 Design a representation for closures and primitives such that the tags (i.e., primitive and non-primitive) at the beginning of the lists become unnecessary. Rewrite the functions that are knowledgeable of the structures. Step through (value e3) with the new interpreter.

Notice the primitive is always atom, so use atom? to tell primitive or closure.
```lisp
(define initial-table
  (lambda (name)
    (cond
      ((eq? name (quote t)) t)
      ((eq? name (quote nil)) nil)
      (t name))))

(define *lambda
  (lambda (e table)
    (cons table (cdr e))))

(define primitive?
  (lambda (s)
    (atom? s)))

(define non-primitive?
  (lambda (s)
    (not (atom? s))))

(define apply
  (lambda (fun vals)
    (cond
      ((primitive? fun)
       (apply-primitive fun vals))
      ((non-primitive? fun)
       (apply-closure fun vals)))))

Q1: What is the value of e3?
A1: Let's step through it.

Q2: (meaning e (quote ()))
A2: ((expression-to-action e) e table).

Q3: (expression-to-action e)
A3: *application.

Q4: (*application e table), where e is e3, table is ()
A4: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q5: (meaning (function-of e) table)
A5: ((expression-to-action e) e table), where e is (lambda ...), table is ().

Q6: (expression-to-action e)
A6: *lambda.

Q7: (*lambda e table), where e is
    (lambda (x)
      ((lambda (x)
         (add1 x))
       (add1 4)))
A7: (()
     (x)
     ((lambda (x)
        (add1 x)
      (add1 4))))

Q8: (evlis (arguments-of e) table)
A8: (6).

Q9: (apply '(()
             (x)
             ((lambda (x)
                (add1 x))
              (add1 4)))
           '(6))
A9: Non-primitive function, go (apply-closure fun vals)

Q10: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is (() (x) ((lambda ...)), and the vals is (6).

A10: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is ((lambda (x)
                 (add1 x))
               (add1 4))

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is ().

     So, it equals to (meaning '((lambda ...)) new-table),
     where new-table is (((x) (6)))

Q11: (expression-to-action e), where e is ((lambda ...))
A11: *application.

Q12: (*application e table), where e is ((lambda ...), table is (((x) (6)))
A12: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q13: (meaning (function-of e) table)
A13: ((expression-to-action e) e table), where e is (lambda ...), table is (((x) (6))).

Q14: (expression-to-action e)
A14: *lambda.

Q15: (*lambda e table), where e is
     (lambda (x)
       (add1 x))
A15: ((((x) (6)))
      (x)
      (add1 x))

Q16: (evlis (arguments-of e) table)
A16: (5).

Q17: (apply '((((x) (6)))
              (x)
              (add1 x))
           '(5))
A17: Non-primitive function, go (apply-closure fun vals)

Q18: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is ((((x) (6))) (x) (add1 x)), and the vals is (5).

A18: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (add1 x)

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is (((x) (6))).

     So, it equals to (meaning '(add1 x)) new-table),
     where new-table is (((x) (5)) ((x) (6))).

Q19: (expression-to-action e), where e is (add1 x)
A19: *application.

Q20: (*application e table), where e is (add1 x), table is (((x) (5)) ((x) (6)))
A20: We have to get the value of (meaning (function-of e) table), which means to get the value of the add1 part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q21: (meaning e table), where e is add1
A21: ((expression-to-action e) e table).

Q22: (*identifier e table)
A22: add1.

Q23: (evlis (arguments-of e) table)
A23: (5).

Q24: (apply 'add1 '(5))
A24: (apply-primitive 'add1 '(5)).

Q25: (add1 5)
A25: 6.
```

### 10.6 Just as the table for predetermined identifiers, initial-table, all tables in our interpreter can be represented as functions. Then, the function extend-table is changed to:
```lisp
(define extend-table
  (lambda (entry table)
    (cond
      ((member? name (first entry))
       (pick (index name (first entry))))
      (t (table name)))))
```
(For pick see Chapter 4; for index see Exercise 4.5.) What else has to be changed to make the interpreter work?
Make the least number of changes. Make up an application of value to your favorite expression and step through it to make sure
you understand the new representation.
Hint: Look at all the places where tables are used to find out where changes have to be made.

```lisp
The value function changes to
(define value
  (lambda (e)
    (meaning e initial-table)))

The *identifier function changes to
(define *identifier
  (lambda (e table)
    (table e)))

These functions are unnecessary: lookup-in-entry-help, lookup-in-entry, lookup-in-table.

Step through (value e3) with new representation.

Q1: What is the value of e3?
A1: Let's step through it.

Q2: (meaning e initial-table)
A2: ((expression-to-action e) e table).

Q3: (expression-to-action e)
A3: *application.

Q4: (*application e table), where e is e3, table is
    (lambda (name)
      (cond
        ((eq? name (quote t)) t)
        ((eq? name (quote nil)) nil)
        (t (build
             (quote primitive)
             name))))
A4: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q5: (meaning (function-of e) table)
A5: ((expression-to-action e) e table), where e is (lambda ...), table is
    (lambda (name)
      (cond
        ((eq? name (quote t)) t)
        ((eq? name (quote nil)) nil)
        (t (build
             (quote primitive)
             name)))).

Q6: (expression-to-action e)
A6: *lambda.

Q7: (*lambda e table), where e is
    (lambda (x)
      ((lambda (x)
         (add1 x))
       (add1 4)))
A7: (non-primitive
     ((lambda (name)
        (cond
          ((eq? name (quote t)) t)
          ((eq? name (quote nil)) nil)
          (t (build
               (quote primitive)
               name))))
      (x)
      ((lambda (x)
         (add1 x))
       (add1 4)))).

Q8: (evlis (arguments-of e) table)
A8: (6).

Q9: (apply '(non-primitive
             ((lambda (name)
                (cond
                  ((eq? name (quote t)) t)
                  ((eq? name (quote nil)) nil)
                  (t (build
                       (quote primitive)
                       name))))
              (x)
              ((lambda (x)
                 (add1 x))
               (add1 4))))
           '(6))
A9: Non-primitive function, go (apply-closure fun vals).

Q10: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is ((lambda (name) ...) (x) ((lambda ...))), and the vals is (6).

A10: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is ((lambda (x)
                 (add1 x))
               (add1 4))

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is (lambda (name)
                (cond
                  ((eq? name (quote t)) t)
                  ((eq? name (quote nil)) nil)
                  (t (build
                       (quote primitive)
                       name))))

     So, it equals to (meaning '((lambda ...)) new-table),
     where new-table is (lambda (name)
                          (cond
                            ((member? name (first '((x) (6))))
                             (pick (index name (first '((x) (6))))
                                   (second '((x) (6)))))
                            (t ((lambda (name)
                                  (cond
                                    ((eq? name (quote t)) t)
                                    ((eq? name (quote nil)) nil)
                                    (t (build
                                         (quote primitive)
                                         name))))
                                name)))).

Q11: (expression-to-action e), where e is ((lambda ...))
A11: *application.

Q12: (*application e table), where e is ((lambda ...), table is
        (lambda (name)
          (cond
            ((member? name (first '((x) (6))))
             (pick (index name (first '((x) (6))))
                   (second '((x) (6)))))
            (t ((lambda (name)
                  (cond
                    ((eq? name (quote t)) t)
                    ((eq? name (quote nil)) nil)
                    (t (build
                         (quote primitive)
                         name))))
                name))))

A12: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q13: (meaning (function-of e) table)
A13: ((expression-to-action e) e table), where e is (lambda ...), table is
        (lambda (name)
          (cond
            ((member? name (first '((x) (6))))
             (pick (index name (first '((x) (6))))
                   (second '((x) (6)))))
            (t ((lambda (name)
                  (cond
                    ((eq? name (quote t)) t)
                    ((eq? name (quote nil)) nil)
                    (t (build
                         (quote primitive)
                         name))))
                name))))

Q14: (expression-to-action e)
A14: *lambda.

Q15: (*lambda e table), where e is
     (lambda (x)
       (add1 x))
A15: (non-primitive
      ((lambda (name)
         (cond
           ((member? name (first '((x) (6))))
            (pick (index name (first '((x) (6))))
                  (second '((x) (6)))))
           (t ((lambda (name)
                 (cond
                   ((eq? name (quote t)) t)
                   ((eq? name (quote nil)) nil)
                   (t (build
                        (quote primitive)
                        name))))
               name))))
     (x)
     (add1 x)))

Q16: (evlis (arguments-of e) table)
A16: (evlis '((add1 4)) table).

Q17: (null? args)
A17: nil.

Q18: (cons (meaning (car args) table)
       (evlis (cdr args) table))
A18: Go get (meaning '(add1 4) table) first.

Q19: ((expression-to-action e) e table).
A19: (*application e table).

Q20: (*application e table), where e is (add1 4)
A20: We have to get the value of (meaning (function-of e) table), which means to get the value of the add1
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q21: (meaning (function-of e) table)
A21: ((expression-to-action e) e table), where e is add1, table is
        (lambda (name)
          (cond
            ((member? name (first '((x) (6))))
             (pick (index name (first '((x) (6))))
                   (second '((x) (6)))))
            (t ((lambda (name)
                  (cond
                    ((eq? name (quote t)) t)
                    ((eq? name (quote nil)) nil)
                    (t (build
                         (quote primitive)
                         name))))
                name))))

Q22: (*identifier e table)
A22: (table e), where e is add1, table is
        (lambda (name)
          (cond
            ((member? name (first '((x) (6))))
             (pick (index name (first '((x) (6))))
                   (second '((x) (6)))))
            (t ((lambda (name)
                  (cond
                    ((eq? name (quote t)) t)
                    ((eq? name (quote nil)) nil)
                    (t (build
                         (quote primitive)
                         name))))
                name))))

Q23: (member? name '(x)), where name is add1
A23: nil.

Q24: ((lambda (name)
        (cond
          ((eq? name (quote t)) t)
          ((eq? name (quote nil)) nil)
          (t (build
               (quote primitive)
               name)))) 'add1)
A24: (primitive add1).

Q25: (evlis (arguments-of e) table), where e is (add1 4)
A25: (4).

Q26: (apply '(primitive add1) '(4))
A26: 5, so the (evlis (arguments-of e) table), where e is ((lambda (x) (add1 x)) (add1 4)) is (5).

Q27: (apply '(non-primitive
              ((lambda (name)
                 (cond
                   ((member? name (first '((x) (6))))
                    (pick (index name (first '((x) (6))))
                          (second '((x) (6)))))
                   (t ((lambda (name)
                         (cond
                           ((eq? name (quote t)) t)
                           ((eq? name (quote nil)) nil)
                           (t (build
                                (quote primitive)
                                name))))
                       name))))
               (x)
               (add1 x)))
            '(5))

A27: Non-primitive function, go (apply-closure fun vals).

Q28: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is ((lambda (name) ...) (x) (add1 x)), and the vals is (6).

A28: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (add1 x)

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is (lambda (name)
                 (cond
                   ((member? name (first '((x) (6))))
                    (pick (index name (first '((x) (6))))
                          (second '((x) (6)))))
                   (t ((lambda (name)
                         (cond
                           ((eq? name (quote t)) t)
                           ((eq? name (quote nil)) nil)
                           (t (build
                                (quote primitive)
                                name))))
                       name))))

     So, it equals to (meaning '((lambda ...)) new-table),
     where new-table is (lambda (name)
                          (cond
                            ((member? name (first '((x) (5))))
                             (pick (index name (first '((x) (5))))
                                   (second '((x) (5)))))
                            (t ((lambda (name)
                                  (cond
                                    ((member? name (first '((x) (6))))
                                     (pick (index name (first '((x) (6))))
                                           (second '((x) (6)))))
                                    (t ((lambda (name)
                                          (cond
                                            ((eq? name (quote t)) t)
                                            ((eq? name (quote nil)) nil)
                                            (t (build
                                                 (quote primitive)
                                                 name))))
                                        name))))
                                name)))).

Q29: (expression-to-action e), where e is (add1 x)
A29: *application.

Q30: (*application e table), where e is (add1 x), table is
      (lambda (name)
        (cond
          ((member? name (first '((x) (5))))
           (pick (index name (first '((x) (5))))
                 (second '((x) (5)))))
          (t ((lambda (name)
                (cond
                  ((member? name (first '((x) (6))))
                   (pick (index name (first '((x) (6))))
                         (second '((x) (6)))))
                  (t ((lambda (name)
                        (cond
                          ((eq? name (quote t)) t)
                          ((eq? name (quote nil)) nil)
                          (t (build
                               (quote primitive)
                               name))))
                      name))))
              name)))).

A30: We have to get the value of (meaning (function-of e) table), which means to get the value of the add1
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q31: (meaning (function-of e) table)
A31: (primitive add1).

Q32: (evlis (argument-of e) table)
A32: (evlis '(x) table).

Q33: (null? args)
A33: nil.

Q34: (cons (meaning (car args) table)
       (evlis (cdr args) table))
A34: Go get (meaning 'x table) first.

Q35: (*identifier 'x table), where table is
      (lambda (name)
        (cond
          ((member? name (first '((x) (5))))
           (pick (index name (first '((x) (5))))
                 (second '((x) (5)))))
          (t ((lambda (name)
                (cond
                  ((member? name (first '((x) (6))))
                   (pick (index name (first '((x) (6))))
                         (second '((x) (6)))))
                  (t ((lambda (name)
                        (cond
                          ((eq? name (quote t)) t)
                          ((eq? name (quote nil)) nil)
                          (t (build
                               (quote primitive)
                               name))))
                      name))))
              name)))).

A35: ((lambda (name)
         (cond
           ((member? name (first '((x) (5))))
            (pick (index name (first '((x) (5))))
                  (second '((x) (5)))))
           (t ((lambda (name)
                 (cond
                   ((member? name (first '((x) (6))))
                    (pick (index name (first '((x) (6))))
                          (second '((x) (6)))))
                   (t ((lambda (name)
                         (cond
                           ((eq? name (quote t)) t)
                           ((eq? name (quote nil)) nil)
                           (t (build
                                (quote primitive)
                                name))))
                       name))))
               name)))) 'x).

Q36: (member? name '(x)), where name is x
A36: t.

Q37: (pick (index name '(x)) '(5)), where name is x
A37: 5, so the (evlis (argument-of e) table) is (5).

Q38: (apply '(primitive add1) '(5))
A38: 6.

```

### 10.7 Write the function *lambda?, which checks whether an S-expression is really a representation of a lambda-function.
```lisp
Example: (*lambda? e5) is true,
         (*lambda? e6) is false,
         (*lambda? e2) is false.
```
Also write the function *quote? and *cond?, which do the same for quote- and cond- expressions.

```lisp
(define *lambda?
  (lambda (e)
    (cond
      ((atom? e) nil)
      ((null? e) nil)
      ((atom? (car e)) (*lambda?-help e))
      (t nil))))

(define *lambda?-help
  (lambda (e)
    (and
      (eq? (car e) (quote lambda))
      (cond
        ((null? (cdr e)) nil)
        (t (lat? (car (cdr e)))))
      (not (null? (cdr (cdr e)))))))

(define *quote?
  (lambda (e)
    (cond
      ((atom? e) nil)
      ((null? e) nil)
      ((atom? (car e))
         (and
           (eq? (car e) (quote quote))
           (not (null? (cdr e)))))
      (t nil))))

(define *cond?
  (lambda (e)
    (cond
      ((atom? e) nil)
      ((null? e) nil)
      ((atom? (car e))
         (and
           (eq? (car e) (quote cond))
           (not (null? (cdr e)))
           (*cond?-help (cdr e))))
      (t nil))))

(define *cond?-help
  (lambda (e)
    (cond
      ((null? e) t)
      ((atom? (car e)) nil)
      ((null? (car e)) nil)
      ((null? (cdr (car e))) nil)
      (t (*cond?-help (cdr e))))))

```

### 10.8 Non-primitive functions are represented by lists in our interpreter. An alternative is to use functions to represent functions. For this we change *lambda to:
```lisp
(define *lambda
  (lambda (e table)
    (build
      (quote non-primitive)
      (lambda (vals)
        (meaning (body-of e)
          (extend-table
            (new-entry (formals-of e) vals)
            table))))))
```
How do we have to change apply-closure to make this representation work? Do we need to change anything else?
Walk through the application (value e2) to become familiar with this new representation.

```lisp
We change the apply function from

(define apply
  (lambda (fun vals)
    (cond
      ((primitive? fun)
       (apply-primitive
         (second fun) vals))
      ((non-primitive? fun)
       (apply-closure
         (second fun) vals)))))

to

(define apply
  (lambda (fun vals)
    (cond
      ((primitive? fun)
       (apply-primitive
         (second fun) vals))
      ((non-primitive? fun)
       ((second fun) vals)))))

And of course, remove the table-of function and the apply-closure function.

Q1: What is the value of (value e), where e is
    (((lambda (x y)
        (lambda (u)
          (cond
            (u x)
            (t y))))
      1 ())
     nil)
A1: Let's step through it.

Q2: (meaning e (quote ()))
A2: We have to get the value of (expression-to-action e), where e is e2.
And apply its value as a function, with the arguments e and table.

Q3: (atom? e)
A3: nil, then (list-to-action e)

Q4: (atom? (car e)), where e is e2
A4: nil, then the value of (expression-to-action e) is *application.

Q5: (*application e table), where e is e2
A5: We have to get the value of (meaning (function-of e) table), which means to get the value of the ((lambda ...)) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q6: (meaning (function-of e) table), e is e2
A6: (function-of e) is
    ((lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))
     1 ())

    Go get (expression-to-action e) first, where e is
    ((lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))
     1 ())

Q7: (atom? e), where e is
    ((lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))
     1 ())
A7: nil, then (list-to-action e).

Q8: (atom? (car e))
A8: nil, then the value of (expression-to-action e) is *application.

Q9: (*application e table), where e is
    ((lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))
     1 ()), table is ()
A9: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q10: (meaning (function-of e) table), e is
     ((lambda (x y)
        (lambda (u)
          (cond
           (u x)
           (t y))))
      1 ())
A10: (function-of e) is
     (lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))

    Go get (expression-to-action e) first, where e is
     (lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y))))

Q11: (atom? e)
A11: nil, then the value is (list-to-action e).

Q12: (atom? (car e)), where e is (lambda (x y) ...)
A12: t.

Q13: (eq? (car e) (quote quote))
A13: nil.

Q14: (eq? (car e) (quote lambda))
A14: t, so the value of (expression-to-action e) is *lambda.

Q15: (*lambda e table), where e is
     (lambda (x y)
       (lambda (u)
         (cond
           (u x)
           (t y)))), and table is ()
A15: (non-primitive
      ((lambda (vals)
         (meaning (body-of (lambda (x y)
                              (lambda (u)
                                (cond
                                  (u x)
                                  (t y)))))
           (extend-table
             (new-entry (formals-of (lambda (x y)
                                       (lambda (u)
                                         (cond
                                           (u x)
                                           (t y)))))
                        vals)
             ())))))

Q16: Let's go get the value of arguments.
A16: (evlis (arguments-of e) table), where (arguments-of e) is (1 ()).

Q17: (null? args)
A17: nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q18: (meaning e table), where e is 1
A18: ((expression-to-action e) e table), where e is 1.

Q19: (atom? e)
A19: t, then the value is (atom-to-action e).

Q20: (number? e), where e is 1
A20: t, so the value of (expression-to-action e) is *self-evaluating.

Q21: (*self-evaluating e table), where e is 1
A21: 1.

Q22: What next?
A22: We cons the 1 onto the (evlis (cdr args) table), where args is (1 ()).

Q23: (evlis args table), where args is (())
A23: (null? args), nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q24: (meaning e table), where e is ()
A24: ((expression-to-action e) e table), where e is ().

Q25: (atom? e)
A25: t, so the value is (atom-to-action e).

Q26: (atom? (car e))
A26: nil, so the value of (expression-to-action e) is *identifier.

Q27: (*identifier e table)
A27: (lookup-in-table e table initial-table), where e is (), table is ().

Q28: (null? table)
A28: t, go (table-f name), where table-f is initial-table, that is (initial-table name),

Q29: (eq? name (quote t))
A29: nil.

Q30: (eq? name (quote nil))
A30: nil, so the value of (meaning e table) is (primitive ()).

Q31: What next?
A31: We cons the (primitive ()) onto the (evlis (cdr args) table), where args is (()).

Q32: (evlis args table), where args is ().
A32: (null? args), t, so the value of (evlis '() table) is (),
then the value of (evlis (arguments-of e) table) is (1 (primitive ())).

Q33: (apply
       '(non-primitive
         ((lambda (vals)
            (meaning (body-of (lambda (x y)
                                (lambda (u)
                                  (cond
                                    (u x)
                                    (t y)))))
             (extend-table
               (new-entry (formals-of (lambda (x y)
                                         (lambda (u)
                                           (cond
                                             (u x)
                                             (t y)))))
                          vals)
               ())))))
       '(1 (primitive ())))
A33: Let's step through it.

Q34: (primitive? fun)
A34: The first of the fun is non-primitive, so it is not a primitive function.

Q35: (non-primitive? fun)
A35: t, then we ((second fun) vals), where the fun is (non-primitive ...), and the vals is (1 (primitive ())).

Q36: (meaning (body-of (lambda (x y)
                         (lambda (u)
                           (cond
                             (u x)
                             (t y)))))
      (extend-table
        (new-entry (formals-of (lambda (x y)
                                  (lambda (u)
                                    (cond
                                      (u x)
                                      (t y)))))
                   vals)
        ())))))

A36: It equals to (meaning '(lambda ...) new-table),
     where new-table is (((x y) (1 (primitive ()))))

Q37: ((expression-to-action e) e table), where e is (lambda ...), and the table is (((x y) (1 (primitive ()))))
A37: (atom? e), of course not, then (list-to-action e).

Q38: (atom? (car e)), where e is (lambda ...)
A38: t.

Q39: (eq? (car e) (quote quote))
A39: nil.

Q40: (eq? (car e) (quote lambda))
A40: t, so the value of (expression-to-action e) is *lambda.

Q41: (*lambda e table), where e is
     (lambda (u)
       (cond
         (u x)
         (t y))),
     table is (((x y) (1 (primitive ()))))
A41: (non-primitive
      ((lambda (vals)
         (meaning (body-of (lambda (u)
                             (cond
                               (u x)
                               (t y))))
           (extend-table
             (new-entry (formals-of (lambda (u)
                                      (cond
                                        (u x)
                                        (t y))))
                        vals)
             (((x y) (1 (primitive ())))))))))

Q42: Let's go get the value of arguments.
A42: (evlis (arguments-of e) table), where (arguments-of e) is (nil).

Q43: (null? args)
A43: nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q44: (meaning e table), where e is nil
A44: ((expression-to-action e) e table), where e is nil.

Q45: (atom? e)
A45: t, so the value is (atom-to-action e).

Q46: (number? e), where e is nil
A46: nil, so the value of (expression-to-action e) is *identifier.

Q47: (*identifier e table), where e is nil, table is ()
A47: (lookup-in-table e table initial-table)

Q48: (null? table)
A48: t, (table-f name), that is (initial-table name), where name is nil.

Q49: (eq? name (quote t))
A49: nil.

Q50: (eq? name (quote nil))
A50: t, so the value of (meaning (car args) table), where args is (nil), is nil.

Q51: (evlis (cdr args) table), where (cdr args) is ()
A51: (null? args) is t, so the value of (evlis (cdr args) table) is ().

Q52: (cons (meaning (car args) table) (evlis (cdr args) table))
A52: (nil).

Q53: (apply
       '(non-primitive
         ((lambda (vals)
            (meaning (body-of (lambda (u)
                                (cond
                                  (u x)
                                  (t y))))
              (extend-table
                (new-entry (formals-of (lambda (u)
                                         (cond
                                           (u x)
                                           (t y))))
                           vals)
                (((x y) (1 (primitive ())))))))))
        '(nil))

A53: Let's step through it.

Q54: (primitive? fun)
A54: nil.

Q55: (non-primitive? fun)
A55: t, then we (apple-closure (second fun) vals), where the fun is (non-primitive ...), and the vals is (nil).

Q56: (meaning (body-of (lambda (u)
                         (cond
                           (u x)
                           (t y))))
       (extend-table
         (new-entry (formals-of (lambda (u)
                                  (cond
                                    (u x)
                                    (t y))))
                    vals)
         (((x y) (1 (primitive ()))))))

A56: It equals to (meaning '(cond ...) new-table),
     where new-table is (((u) (nil)) ((x y) (1 (primitive ()))))

Q57: ((expression-to-action e) e table), where e is (cond ...), and the table is (((u) (nil)) ((x y) (1 (primitive ()))))
A57: (atom? e), of course not, then (list-to-action e).

Q58: (atom? (car e))
A58: t.

Q59: (eq? (car e) (quote quote))
A59: nil.

Q60: (eq? (car e) (quote lambda))
A60: nil.

Q61: (eq? (car e) (quote cond))
A61: t, so the value of (expression-to-action e) is *cond.

Q62: (*cond e table), where e is (cond ...)
A62: (evcon (cond-lines e) table), where (cond-lines e) is ((u x) (t y)).

Q63: (meaning (question-of (car lines)) table)
A63: (meaning e table), where e is u, table is (((u) (nil)) ((x y) (1 (primitive ())))).

Q64: (atom? e)
A64: t, so the value is (atom-to-action e).

Q65: (number? e)
A65: nil, so the value of (expression-to-action e) is *identifier.

Q66: (*identifier e table)
A66: (lookup-in-table e table initial-table).

Q67: (null? table)
A67: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is u.

Q68: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A68: name is u, (first entry) is (u), (second entry) is (nil), entry-f is (lambda ...).

Q69: (null? names)
A69: nil.

Q70: (eq? (car names) name)
A70: t, so the value of (*identifier e table) is (car values), that is nil.

Q71: (evcon (cdr lines) table), where (cdr lines) is ((t y))
A71: (meaning (question-of (car lines) table)).

Q72: (meaning e table), where e is t, table is (((u) (nil)) ((x y) (1 (primitive ()))))
A72: ((expression-to-action e) e table).

Q73: (atom? e)
A73: t, so the values is (atom-to-action e).

Q74: (number? e)
A74: nil, so the values of (expression-to-action e) is *identifier.

Q75: (*identifier e table)
A75: (lookup-in-table e table initial-table).

Q76: (null? table)
A76: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is t.

Q77: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A77: name is t, (first entry) is (u), (second entry) is (nil), entry-f is (lambda ...).

Q78: (null? names)
A78: nil.

Q79: (eq? (car names) name)
A79: ni.

Q80: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A80: name is t, (cdr names) is (), (cdr values) is (), entry-f is (lambda ...).

Q81: (null? names)
A81: t, go ((lambda (name)
             (lookup-in-table
               name
               (cdr table)
               table-f)) name)

Q82: (lookup-in-table name (cdr table) table-f)
A82: name is t, (cdr table) is (((x y) (1 (primitive ())))).

Q83: (null? table)
A83: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is t.

Q84: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A84: name is t, (first entry) is (x y), (second entry) is (1 (primitive ())), entry-f is (lambda ...).

Q85: (null? names)
A85: nil.

Q86: (eq? (car names) name)
A86: ni.

Q87: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A87: name is t, (cdr names) is (y), (cdr values) is ((primitive ())), entry-f is (lambda ...).

Q88: (null? names)
A88: nil.

Q89: (eq? (car names) name)
A89: ni.

Q90: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A90: name is t, (cdr names) is (), (cdr values) is (), entry-f is (lambda ...).

Q91: (null? names)
A91: t, go ((lambda (name)
             (lookup-in-table
               name
               (cdr table)
               table-f)) name)

Q92: (lookup-in-table name (cdr table) table-f)
A92: name is t, (cdr table) is ().

Q93: (null? table)
A93: t, go (table-f name), that is (initial-table name), name is t.

Q94: (eq? name (quote t))
A94: t, so the value of (*identifier e table) is t.

Q95: Let's go back to (evcon ...)
A95: Because the (meaning (question-of (car lines)) table) is t, so the value of
the whole expression is (meaning (answer-of (car lines)) table).

Q96: ((expression-to-action e) e table), where e is y, table is (((u) (nil)) ((x y) (1 (primitive ()))))
A96: (atom? e), t, go (atom-ato-action e).

Q97: (number? e)
A97: nil, so the value is (*identifier).

Q98: (*identifier e table)
A98: (lookup-in-table e table initial-table).

Q99: (null? table)
A99: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is y.

Q100: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A100: name is y, (first entry) is (u), (second entry) is (nil), entry-f is (lambda ...).

Q101: (null? names)
A101: nil.

Q102: (eq? (car names) name)
A102: ni.

Q103: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A103: name is y, (cdr names) is (), (cdr values) is (), entry-f is (lambda ...).

Q104: (null? names)
A104: t, go ((lambda (name)
             (lookup-in-table
               name
               (cdr table)
               table-f)) name)

Q105: (lookup-in-table name (cdr table) table-f)
A105: name is y, (cdr table) is (((x y) (1 (primitive ())))).

Q106: (null? table)
A106: nil, go (lookup-in-entry name (car table) (lambda ...)), where name is y.

Q107: (lookup-in-entry-help name (first entry) (second entry) entry-f)
A107: name is y, (first entry) is (x y), (second entry) is (1 (primitive ())), entry-f is (lambda ...).

Q108: (null? names)
A108: nil.

Q109: (eq? (car names) name)
A109: ni.

Q110: (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
A110: name is y, (cdr names) is (y), (cdr values) is ((primitive ())), entry-f is (lambda ...).

Q111: (null? names)
A111: nil.

Q112: (eq? (car names) name)
A112: t, so the value of the whole expression is (car values), that is (primitive ()).
```

### 10.9 Primitive functions are built repeatedly while finding the value of an expression. To see this, step through the application (value e3) and count how often the primitive for add1 is built. However, consider the following table for predetermined identifiers:
```lisp
(define initial-table
  ((lambda (add1)
     (lambda (name)
       (cond
         ((eq? name (quote t)) t)
         ((eq? name (quote nil)) nil)
         ((eq? name (quote add1)) add1)
         (t (build (quote primitive)
name)))))
   (build (quote primitive) add1)))
```
Using this initial-table, how does the count change? Generalize this approach to include all primitives.

```lisp
Q1: What is the value of e3?
A1: Let's step through it.

Q2: (meaning e (quote ()))
A2: ((expression-to-action e) e table).

Q3: (expression-to-action e)
A3: *application.

Q4: (*application e table), where e is e3, table is ()
A4: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q5: (meaning (function-of e) table)
A5: ((expression-to-action e) e table), where e is (lambda ...), table is ().

Q6: (expression-to-action e)
A6: *lambda.

Q7: (*lambda e table), where e is
    (lambda (x)
      ((lambda (x)
         (add1 x))
       (add1 4)))
A7: (non-primitive
     (()
      (x)
      ((lambda (x)
         (add1 x)
       (add1 4)))))

Q8: (evlis (arguments-of e) table)
A8: (6).

Q9: (apply '(non-primitive
             (()
              (x)
              ((lambda (x)
                 (add1 x))
               (add1 4))))
           '(6))
A9: Non-primitive function, go (apply-closure (second fun) vals)

Q10: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is (() (x) (cond ...)), and the vals is (6).

A10: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is ((lambda (x)
                 (add1 x))
               (add1 4))

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is ().

     So, it equals to (meaning '((lambda ...)) new-table),
     where new-table is (((x) (6)))

Q11: (expression-to-action e), where e is ((lambda ...))
A11: *application.

Q12: (*application e table), where e is ((lambda ...), table is (((x) (6)))
A12: We have to get the value of (meaning (function-of e) table), which means to get the value of the (lambda ...) part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q13: (meaning (function-of e) table)
A13: ((expression-to-action e) e table), where e is (lambda ...), table is (((x) (6))).

Q14: (expression-to-action e)
A14: *lambda.

Q15: (*lambda e table), where e is
     (lambda (x)
       (add1 x))
A15: (non-primitive
     ((((x) (6)))
      (x)
      (add1 x)))

Q16: (evlis (arguments-of e) table), where (arguments-of e) is ((add1 4)), table is (((x) (6)))
A16: (null? args), where args is ((add1 4)). It is nil, so (cons (meaning (car args) table) (evlis (cdr args) table)).

Q17: (meaning '(add1 4) table), where table is (((x) (6)))
A17: ((expression-to-action e) e table).

Q18: (*application e table), where e is (add1 4), table is (((x) (6)))
A18: We have to get the value of (meaning (function-of e) table), which means to get the value of the add1 part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q19: (meaning e table), where e is add1
A19: ((expression-to-action e) e table).

Q20: (*identifier e table)
A20: (lookup-in-table e table initial-table).

Q21: Can't find inn table, go (table-f name)
A21: (initial-table name), where name is add1

Q22: (build (quote primitive) name), where name is add1.
A22: (primitive add1).

Q23: (evlis (arguments-of e) table)
A23: (4).

Q24: (apply '(primitive add1) '(4))
A24: (apply-primitive '(primitive add1) '(4)).

Q25: (add1 4)
A25: 5. So the value of (evlis (arguments-of e) table), where (arguments-of e) is ((add1 4)), is (5).

Q26: (apply '(non-primitive
             ((((x) (6)))
              (x)
              (add1 x)))
           '(5))
A26: Non-primitive function, go (apply-closure (second fun) vals)

Q27: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is ((((x) (6))) (x) (add1 x)), and the vals is (5).

A27: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (add1 x)

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is (((x) (6))).

     So, it equals to (meaning '(add1 x)) new-table),
     where new-table is (((x) (5)) ((x) (6))).

Q28: (expression-to-action e), where e is (add1 x)
A28: *application.

Q29: (*application e table), where e is (add1 x), table is (((x) (5)) ((x) (6)))
A29: We have to get the value of (meaning (function-of e) table), which means to get the value of the add1 part.
And the value of (evlis (arguments-of e) table), which means to get the list of values of every argument. Then pass them to the apply function.

Q30: (meaning e table), where e is add1
A30: ((expression-to-action e) e table).

Q31: (*identifier e table)
A31: (lookup-in-table e table initial-table).

Q32: Can't find inn table, go (table-f name)
A32: (initial-table name), where name is add1

Q33: (build (quote primitive) name), where name is add1.
A33: (primitive add1).

Q34: (evlis (arguments-of e) table)
A34: (5).

Q35: (apply '(primitive add1) '(5))
A35: (apply-primitive '(primitive add1) '(5)).

Q36: (add1 5)
A36: 6.

Two counts of primitive function for add1 are built.

With new initial-table, the count changes to 1.

Generalize:
(define initial-table
  ((lambda (car)
     ((lambda (cdr)
       ((lambda (cons)
         ((lambda (atom?)
           ((lambda (not)
             ((lambda (null?)
               ((lambda (number?)
                 ((lambda (zero?)
                   ((lambda (add1)
                     ((lambda (sub1)
                        (lambda (name)
                          (cond
                            ((eq? name (quote t)) #t)
                            ((eq? name (quote nil)) #f)
                            ((eq? name (quote car)) car)
                            ((eq? name (quote cdr)) cdr)
                            ((eq? name (quote cons)) cons)
                            ((eq? name (quote atom?)) atom?)
                            ((eq? name (quote not)) not)
                            ((eq? name (quote null?)) null?)
                            ((eq? name (quote number?)) number?)
                            ((eq? name (quote zero?)) zero?)
                            ((eq? name (quote add1)) add1)
                            ((eq? name (quote sub1)) sub1)
		            (t (build (quote primitive) name)))))
                      (build (quote primitive) sub1)))
                    (build (quote primitive) add1)))
                  (build (quote primitive) zero?)))
                (build (quote primitive) number?)))
              (build (quote primitive) null?)))
            (build (quote primitive) not)))
          (build (quote primitive) atom?)))
        (build (quote primitive) cons)))
      (build (quote primitive) cdr)))
    (build (quote primitive) car)))
```
