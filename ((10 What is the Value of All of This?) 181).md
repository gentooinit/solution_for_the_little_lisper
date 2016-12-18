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

###10.2 Make up some S-expressions, plug them into the ______ of *e1*, and step through the application of (value e1).###
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
A11: ((quote non-primitive)
      ((quote ())
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

Q21: (evlis () table)
A21: (null? ()), t. So, the value of (evlis () table) is ().
     So we got (evlis (arguments-of e) table) is (cookie).

Q22: (apply ((quote non-primitive)
             ((quote ())
              (x)
              (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never)))))
            (cookie))

A22: Let's step through it.

Q23: (primitive? fun)
A23: The first of fun is non-primitive, so it is not primitive function.

Q24: (non-primitive? fun)
A24: t, then we (apple-closure (second fun) vals), where the fun is ((quote non-primitive) ...), and the vals is (cookie).

Q25: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is ((quote ()) (x) (cond ...)), and the vals is (cookie).

A25: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never))).

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is (quote ()).

     So, it equals to (meaning (cond ...) new-table),
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

Q61: (evlis () table)
A61: (null? ()), t. So, the value of (evlis () table) is ().
     So we got (evlis (arguments-of e) table) is (cookie).

Q62: (apply ((quote primitive) atom?)
            (cookie))

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
A11: ((quote non-primitive)
      ((quote ())
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

Q21: (evlis () table)
A21: (null? ()), t. So, the value of (evlis () table) is ().
     So we got (evlis (arguments-of e) table) is (()).

Q22: (apply ((quote non-primitive)
             ((quote ())
              (x)
              (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never)))))
            (()))

A22: Let's step through it.

Q23: (primitive? fun)
A23: The first of fun is non-primitive, so it is not primitive function.

Q24: (non-primitive? fun)
A24: t, then we (apple-closure (second fun) vals), where the fun is ((quote non-primitive) ...), and the vals is (()).

Q25: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is ((quote ()) (x) (cond ...)), and the vals is (()).

A25: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never))).

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is (quote ()).

     So, it equals to (meaning (cond ...) new-table),
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

Q61: (evlis () table)
A61: (null? ()), t. So, the value of (evlis () table) is ().
     So we got (evlis (arguments-of e) table) is (()).

Q62: (apply ((quote primitive) atom?)
            (()))

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
A11: ((quote non-primitive)
      ((quote ())
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

Q21: (evlis () table)
A21: (null? ()), t. So, the value of (evlis () table) is ().
     So we got (evlis (arguments-of e) table) is ((banana)).

Q22: (apply ((quote non-primitive)
             ((quote ())
              (x)
              (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never)))))
            ((banana)))

A22: Let's step through it.

Q23: (primitive? fun)
A23: The first of fun is non-primitive, so it is not primitive function.

Q24: (non-primitive? fun)
A24: t, then we (apple-closure (second fun) vals), where the fun is ((quote non-primitive) ...), and the vals is ((banana)).

Q25: (meaning (body-of closure)
       (extend-table
         (new-entry
           (formals-of closure) vals)
         (table-of closure))),
     where closure is ((quote ()) (x) (cond ...)), and the vals is ((banana)).

A25: Let's clarify this:

     The (body-of closure) is the third part of closure,
     which is (cond
                ((atom? x) (quote done))
                ((null? x) (quote almost))
                (t (quote never))).

     The (formals-of closure) is the second part of closure,
     which is (x).

     The (table-of closure) is the first part of closure,
     which is (quote ()).

     So, it equals to (meaning (cond ...) new-table),
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

Q61: (evlis () table)
A61: (null? ()), t. So, the value of (evlis () table) is ().
     So we got (evlis (arguments-of e) table) is ((banana)).

Q62: (apply ((quote primitive) atom?)
            ((banana)))

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

Q99: (evlis () table)
A99: (null? ()), t. So, the value of (evlis () table) is ().
     So we got (evlis (arguments-of e) table) is ((banana)).

Q100: (apply ((quote primitive) null?)
            ((banana)))

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
