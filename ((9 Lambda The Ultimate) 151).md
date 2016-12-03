###9.1 Look up the functions firsts and seconds in Chapter 3. They can be generalized to a function map of *f* and *l* that applies *f* to every element in *l* and builds a new list with the resulting values. Write the function map. Then write the function firsts and seconds using map.###
```lisp
(define map
  (lambda (f)
    (lambda (l)
      (cond
        ((null? l) (quote ()))
        (t (cons (f (car l))
             ((map f) (cdr l))))))))

(define first
  (lambda (p)
    (car p)))

(define second
  (lambda (p)
    (car (cdr p))))

(define firsts (map first))
(define seconds (map second))

```

###9.2 Write the function assq-sf of *a*, *l*, *sk*, and *fk*. The function searches through *l*, which is a list of pairs until it finds a pair whose first component is eq? to *a*. Then the function invokes the function *sk* with this pair. If the searche fails, (fk a) is invoked.###
```lisp
Example: When a is apple,
             b1 is (),
             b2 is ((apple 1) (plum 2)),
             b3 is ((peach 3)),
             sk is (lambda (p)
                     (build (first p) (add1 (second p)))),
             fk is (lambda (name)
                     (cons
                       name
                       (quote (not-in-list)))), then
(assq-sf a b1 sk fk) is (apple not-in-list),
(assq-sf a b2 sk fk) is (apple 2),
(assq-sf a b3 sk fk) is (apple not-in-list).
```
```lisp
(define assq-sf
  (lambda (a l sk fk)
    (cond
      ((null? l) (fk a))
      ((eq? (first (car l)) a)
       (sk (car l)))
      (t (assq-sf a (cdr l) sk fk)))))
```

###9.3 In the chapter we have derived a Y-combinator that allows us to write recursive functions of one argument without using define. Here is the Y-combinator for functions of two arguments.###
```lisp
(define Y2
  (lambda (M)
    ((lambda (future)
       (M (lambda (arg1 arg2)
            ((future future) arg1 arg2))))
     (lambda (future)
       (M (lambda (arg1 arg2)
            ((future future) arg1 arg2)))))))
```
Write the functions =, rempick, and pick from Chapter 4 using Y2.

Note: There is a version of (lambda ...) for defining a function of an arbitrary number of arguments, and an apply function for applying such a function to a list of arguments. With this you can write a single Y-combinator for all functions.

```lisp
(define =
  (Y2 (lambda (recfun)
        (lambda (n m)
          (cond
            ((zero? m) (zero? n))
            ((zero? n) nil)
            (t (recfun (sub1 n) (sub1 m))))))))

(define rempick
  (Y2 (lambda (recfun)
        (lambda (n lat)
          (cond
            ((null? lat) (quote ()))
            ((zero? (sub1 n)) (cdr lat))
            (t (cons (car lat)
                 (recfun
                   (sub1 n) (cdr lat)))))))))

(define pick
  (Y2 (lambda (recfun)
        (lambda (n lat)
          (cond
            ((null? lat) nil)
            ((zero? (sub1 n)) (car lat))
            (t (recfun (sub1 n) (cdr lat))))))))
```

###9.4 With the Y-combinator we can reduce the number of arguments on, which a function has to recur. For example member can be rewritten as:###
```lisp
(define member-Y
  (lambda (a l)
    ((Y (lambda (recfun)
          (lambda (l)
            (cond
              ((null? l) nil)
              (t (or
                   (eq? (car l) a)
                   (recfun (cdr l))))))))
     l)))
```
Step through the application (member-Y a l) where a is x and l is (y x). Rewrite the functions rember, insertR, and subst2 from Chapter 3 in a similar manner.

```lisp
Q1: Try to expand the Y-combinator.

A1:
(((lambda (future)
    ((lambda (recfun)
       (lambda (l)
         (cond
           ((null? l) nil)
           (t (or
                (eq? (car l) 'x)
                (recfun (cdr l)))))))
     (lambda (x) ((future future) x))))
  (lambda (future)
    ((lambda (recfun)
       (lambda (l)
         (cond
           ((null? l) nil)
           (t (or
               (eq? (car l) 'x)
               (recfun (cdr l)))))))
     (lambda (x) ((future future) x)))))
 '(y x))

=>

(((lambda (recfun)
    (lambda (l)
       (cond
         ((null? l) nil)
         (t (or
              (eq? (car l) 'x)
              (recfun (cdr l)))))))
  (lambda (x)
    (((lambda (future)
        ((lambda (recfun)
           (lambda (l)
             (cond
               ((null? l) nil)
               (t (or
                   (eq? (car l) 'x)
                   (recfun (cdr l)))))))
         (lambda (x) ((future future) x))))
      (lambda (future)
        ((lambda (recfun)
           (lambda (l)
             (cond
               ((null? l) nil)
               (t (or
                   (eq? (car l) 'x)
                   (recfun (cdr l)))))))
         (lambda (x) ((future future) x)))))
    x)))
 '(y x))

=>

(((lambda (l)
    (cond
      ((null? l) nil)
      (t (or
           (eq? (car l) 'x)
           ((lambda (x)
              (((lambda (future)
                  ((lambda (recfun)
                     (lambda (l)
                       (cond
                         ((null? l) nil)
                         (t (or
                             (eq? (car l) 'x)
                             (recfun (cdr l)))))))
                   (lambda (x) ((future future) x))))
                (lambda (future)
                  ((lambda (recfun)
                     (lambda (l)
                       (cond
                         ((null? l) nil)
                         (t (or
                             (eq? (car l) 'x)
                             (recfun (cdr l)))))))
                   (lambda (x) ((future future) x)))))
              x))
            (cdr l)))))))
 '(y x))

Now, we got a function of the l argument. Let's apply it.

Q2: (null? l)
A2: nil.

Q3: (eq? (car l) 'x)
A3: nil.

Q4: Here, we need one more function of the l argument, and take (cdr l) where is (x).
A4:

(((lambda (l)
    (cond
      ((null? l) nil)
      (t (or
           (eq? (car l) 'x)
           ((lambda (x)                                  ------------>
              (((lambda (future)                                     |
                  ((lambda (recfun)                                  |
                     (lambda (l)                                     |
                       (cond                                         |
                         ((null? l) nil)                             |
                         (t (or                                      |
                             (eq? (car l) 'x)                        |
                             (recfun (cdr l)))))))                   |
                   (lambda (x) ((future future) x))))                >Expand this part
                (lambda (future)                                     |
                  ((lambda (recfun)                                  |
                     (lambda (l)                                     |
                       (cond                                         |
                         ((null? l) nil)                             |
                         (t (or                                      |
                             (eq? (car l) 'x)                        |
                             (recfun (cdr l)))))))                   |
                   (lambda (x) ((future future) x)))))               |
              x))                                       ------------->
            (cdr l)))))))
 '(y x))      |
              |--------> the argument, where is '(x)

=>

...
            (((lambda (future)
                ((lambda (recfun)
                   (lambda (l)
                     (cond
                       ((null? l) nil)
                       (t (or
                           (eq? (car l) 'x)
                           (recfun (cdr l)))))))
                 (lambda (x) ((future future) x))))
              (lambda (future)
                ((lambda (recfun)
                   (lambda (l)
                     (cond
                       ((null? l) nil)
                       (t (or
                           (eq? (car l) 'x)
                           (recfun (cdr l)))))))
                 (lambda (x) ((future future) x)))))
            '(x))
...

=>

...
            (((lambda (recfun)
                (lambda (l)
                  (cond
                    ((null? l) nil)
                    (t (or
                        (eq? (car l) 'x)
                        (recfun (cdr l)))))))
              (lambda (x) (((lambda (future)
                              ((lambda (recfun)
                                 (lambda (l)
                                   (cond
                                     ((null? l) nil)
                                     (t (or
                                         (eq? (car l) 'x)
                                         (recfun (cdr l)))))))
                               (lambda (x) ((future future) x))))
                            (lambda (future)
                              ((lambda (recfun)
                                 (lambda (l)
                                   (cond
                                     ((null? l) nil)
                                     (t (or
                                         (eq? (car l) 'x)
                                         (recfun (cdr l)))))))
                               (lambda (x) ((future future) x)))))
                           x)))
             '(x))
...

=>

...
            ((lambda (l)
               (cond
                 ((null? l) nil)
                 (t (or
                     (eq? (car l) 'x)
                     ((lambda (x)
                        (((lambda (future)
                            ((lambda (recfun)
                               (lambda (l)
                                 (cond
                                   ((null? l) nil)
                                   (t (or
                                       (eq? (car l) 'x)
                                       (recfun (cdr l)))))))
                             (lambda (x) ((future future) x))))
                          (lambda (future)
                            ((lambda (recfun)
                               (lambda (l)
                                 (cond
                                   ((null? l) nil)
                                   (t (or
                                       (eq? (car l) 'x)
                                       (recfun (cdr l)))))))
                          (lambda (x) ((future future) x)))))
                         x))
                      (cdr l))))))
             '(x))
...

Q5: (null? l)
A5: nil.

Q6: (eq? (car l) 'x), where l is (x).
A6: t, so the value of recursive function is t.

Q7: Are we finish?
A7: Yes, the value of (member-Y a l) is t.


(define rember
  (lambda (a lat)
    ((Y (lambda (recfun)
          (lambda (lat)
            (cond
              ((null? lat) (quote ()))
              ((eq? (car lat) a) (cdr lat))
              (t (cons (car lat)
                   (recfun (cdr lat))))))))
     lat)))

(define insertR
  (lambda (new old lat)
    ((Y (lambda (recfun)
          (lambda (lat)
            (cond
              ((null? lat) (quote ()))
              ((eq? (car lat) old)
               (cons old
                 (cons new (cdr lat))))
              (t (cons (car lat)
                   (recfun (cdr lat))))))))
     lat)))

(define subst2
  (lambda (new o1 o2 lat)
    ((Y (lambda (recfun)
          (lambda (lat)
            (cond
              ((null? lat) (quote ()))
              ((or (eq? (car lat) o1) (eq? (car lat) o2))
               (cons new (cdr lat)))
              (t (cons (car lat)
                   (recfun (cdr lat))))))))
     lat)))

```

###9.5 In Exercise 6.7 through 6.10 we saw how to use the accumulator technique. Instead of accumulators, continuation functions are sometimes used. These functions abstract what needs to be done to complete an application. For example, multisubst can be defined as:###
```lisp
(define multisubst-k
  (lambda (new old lat k)
    (cond
      ((null? lat) (k (quote ())))
      ((eq? (car lat) old)
       (multisubst-k new old (cdr lat)
         (lambda (d)
           (k (cons new d)))))
      (t (multisubst-k new old (cdr lat)
           (lambda (d)
             (k (cons (car lat) d))))))))
```
The initial continuation function k is always the function (lambda (x) x). Step through the application of

        (multisubst-k new old lat k),
where

        new is y,
        old is x, and
        lat is (u v x x y z x).

Compare the steps to the application of multisubst to the same arguments. Write down the things you have to do when you return from a recursive application, and, next to it, write down the corresponding continuation function.

```lisp
Q1: What is the value of (multisubst new old lat),
    where
       new is y,
       old is x, and
       lat is (u v x x y z x).
A1: Write the function multisubst again:
    (define multisubst
      (lambda (new old lat)
        (cond
          ((null? lat) (quote ()))
          ((eq? (car lat) old)
           (cons new
             (multisubst new old (cdr lat))))
          (t (cons (car lat)
               (multisubst new old (cdr lat)))))))

Q1: (null? lat)
A1: nil.

Q2: (eq? (car lat) old)
A2: nil.

Q3: (cons (car lat) (multisubst new old (cdr lat)))
A3: Cons 'u on the value of recursive function.
    We need to know what is the value of
    (multisubst new old (cdr lat)), where (cdr lat) is (v x x y z x).

Q4: (null? lat)
A4: nil.

Q5: (eq? (car lat) old)
A5: nil.

Q6: (cons (car lat) (multisubst new old (cdr lat)))
A6: Cons 'v on the value of recursive function.
    We need to know what is the value of
    (multisubst new old (cdr lat)), where (cdr lat) is (x x y z x).

Q7: (null? lat)
A7: nil.

Q8: (eq? (car lat) old)
A8: t, (car lat) is x, old is x.

Q6: (cons new (multisubst new old (cdr lat)))
A6: Cons 'y on the value of recursive function.
    We need to know what is the value of
    (multisubst new old (cdr lat)), where (cdr lat) is (x y z x).

Q7: (null? lat)
A7: nil.

Q8: (eq? (car lat) old)
A8: t, (car lat) is x, old is x.

Q9: (cons new (multisubst new old (cdr lat)))
A9: Cons 'y on the value of recursive function.
    We need to know what is the value of
    (multisubst new old (cdr lat)), where (cdr lat) is (y z x).

Q10: (null? lat)
A10: nil.

Q11: (eq? (car lat) old)
A11: nil.

Q12: (cons (car lat) (multisubst new old (cdr lat)))
A12: Cons 'y on the value of recursive function.
    We need to know what is the value of
    (multisubst new old (cdr lat)), where (cdr lat) is (z x).

Q13: (null? lat)
A13: nil.

Q14: (eq? (car lat) old)
A14: nil.

Q15: (cons (car lat) (multisubst new old (cdr lat)))
A15: Cons 'z on the value of recursive function.
    We need to know what is the value of
    (multisubst new old (cdr lat)), where (cdr lat) is (x).

Q16: (null? lat)
A16: nil.

Q17: (eq? (car lat) old)
A17: t, (car lat) is x, old is x.

Q19: (cons new (multisubst new old (cdr lat)))
A19: Cons 'y on the value of recursive function.
    We need to know what is the value of
    (multisubst new old (cdr lat)), where (cdr lat) is ().

Q20: (null? lat)
A20: t, so the value is ()

Q21: return ()
A21: (cons 'y '()), which is (y).

Q22: return (y)
A22: (cons 'z '(y)), which is (z y).

Q23: return (z y)
A23: (cons 'y '(z y)), which is (y z y).

Q24: return (y z y)
A24: (cons 'y '(y z y)), which is (y y z y).

Q25: return (y y z y)
A25: (cons 'y '(y y z y)), which is (y y y z y).

Q26: return (y y y z y)
A26: (cons 'v '(y y y z y)), which is (v y y y z y).

Q27: return (v y y y z y)
A27: (cons 'u '(v y y y z y)), which is (u v y y y z y).

Q28: Are we finish?
A28: Yes, we are escaped from the recursive application.


Q1: What is the value of (multisubst-k new old lat k),
    where
       new is y,
       old is x, and
       lat is (u v x x y z x).

A1: Let's step through it.

Q2: (null? lat)
A2: nil.

Q3: (eq? (car lat) old)
A3: nil.

Q4: (multisubst-k new old (cdr lat)
      (lambda (d)
        (k (cons (car lat) d))))

A4: Recur with the new k, which is
      (lambda (d)
        ((lambda (x) (x))
         (cons 'u d)))

Q5: (null? lat)
A5: nil.

Q6: (eq? (car lat) old)
A6: nil.

Q7: (multisubst-k new old (cdr lat)
      (lambda (d)
        (k (cons (car lat) d))))

A7: Recur with the new k, which is
      (lambda (d)
        ((lambda (d)
           ((lambda (x) (x))
            (cons 'u d)))
         (cons 'v d)))

Q8: (null? lat)
A8: nil.

Q9: (eq? (car lat) old)
A9: t, (car lat) is x, old is x.

Q10: (multisubst-k new old (cdr lat)
       (lambda (d)
         (k (cons new d))))

A10: Recur with the new k, which is
       (lambda (d)
         ((lambda (d)
            ((lambda (d)
               ((lambda (x) (x))
                (cons 'u d)))
             (cons 'v d)))
          (cons 'y d)))


Q11: (null? lat)
A11: nil.

Q12: (eq? (car lat) old)
A12: t, (car lat) is x, old is x.

Q13: (multisubst-k new old (cdr lat)
       (lambda (d)
         (k (cons new d))))

A13: Recur with the new k, which is
       (lambda (d)
         ((lambda (d)
            ((lambda (d)
               ((lambda (d)
                  ((lambda (x) (x))
                   (cons 'u d)))
                (cons 'v d)))
             (cons 'y d)))
          (cons 'y d)))

Q14: (null? lat)
A14: nil.

Q15: (eq? (car lat) old)
A15: nil.

Q16: (multisubst-k new old (cdr lat)
       (lambda (d)
         (k (cons (car lat) d))))

A16: Recur with the new k, which is
       (lambda (d)
         ((lambda (d)
            ((lambda (d)
               ((lambda (d)
                  ((lambda (d)
                     ((lambda (x) (x))
                      (cons 'u d)))
                   (cons 'v d)))
                (cons 'y d)))
             (cons 'y d)))
          (cons 'y d)))

Q17: (null? lat)
A17: nil.

Q18: (eq? (car lat) old)
A18: nil.

Q19: (multisubst-k new old (cdr lat)
       (lambda (d)
         (k (cons (car lat) d))))

A19: Recur with the new k, which is
       (lambda (d)
         ((lambda (d)
            ((lambda (d)
               ((lambda (d)
                  ((lambda (d)
                     ((lambda (d)
                        ((lambda (x) (x))
                         (cons 'u d)))
                       (cons 'v d)))
                   (cons 'y d)))
                (cons 'y d)))
             (cons 'y d)))
          (cons 'z d)))

Q20: (null? lat)
A20: nil.

Q21: (eq? (car lat) old)
A21: t, (car lat) is x, old is x.

Q22: (multisubst-k new old (cdr lat)
       (lambda (d)
         (k (cons new d))))

A22: Recur with the new k, which is
       (lambda (d)
         ((lambda (d)
            ((lambda (d)
               ((lambda (d)
                  ((lambda (d)
                     ((lambda (d)
                        ((lambda (d)
                           ((lambda (x) (x))
                            (cons 'u d)))
                         (cons 'v d)))
                      (cons 'y d)))
                   (cons 'y d)))
                (cons 'y d)))
             (cons 'z d)))
          (cons 'y d)))

Q23: (null? lat)
A23: t

Q24: (k (quote ()))
Q24: ((lambda (d)
         ((lambda (d)
            ((lambda (d)
               ((lambda (d)
                  ((lambda (d)
                     ((lambda (d)
                        ((lambda (d)
                           ((lambda (x) (x))
                            (cons 'u d)))
                         (cons 'v d)))
                      (cons 'y d)))
                   (cons 'y d)))
                (cons 'y d)))
             (cons 'z d)))
          (cons 'y d)))
      (quote ()))


Q25: Apply it?
A25: (cons 'u (cons 'v (cons 'y (cons 'y (cons 'y (cons 'z (cons 'y '()))))))), which is (u v y y y z y).

```

###9.6 In Chapter 4 and Exercise 4.2 you wrote addvec and multvec. Abstract the two functions into a single function accum. Write the functions length and occur using accum.###
```lisp
(define accum
  (lambda (op const)
    (lambda (vec)
      (cond
        ((null? vec) const)
        (t (op (car vec)
             ((accum op const)
              (cdr vec))))))))

(define length
  (accum
    (lambda (x y) (add1 y))
    0))

(define occur
  (lambda (a lat)
    ((accum
       (lambda (x y)
         (cond
           ((eq? x a) (add1 y))
           (t y)))
       0) lat)))
```

###9.7 In Exercise 7.3 you wrote the four functions count-op, count-+, count-*, and count-^. Abstract them into a single function count-op-f, which generates the corresponding functions if passed an appropriate help function.###
```lisp
(define count-op-f
  (lambda (logical?)
    (lambda (aexp)
      (cond
        ((atom? aexp) 0)
        ((logical? (operator aexp))
         (add1
           (+ ((count-op-f logical?)
               (1st-sub-exp aexp))
              ((count-op-f logical?)
               (2nd-sub-exp aexp)))))
        (t (+ ((count-op-f logical?)
               (1st-sub-exp aexp))
              ((count-op-f logical?)
               (2nd-sub-exp aexp))))))))

(define count-op
  (count-op-f
    (lambda (op) t)))

(define count-+
  (count-op-f
    (lambda (op) (eq? (quote +) op))))

(define count-*
  (count-op-f
    (lambda (op) (eq? (quote *) op))))

(define count-^
  (count-op-f
    (lambda (op) (eq? (quote ^) op))))
```

###9.8 Functions of no arguments are called *thunks*. If *f* is a thunk, it can be evaluated with (f), Consider the following version of or as a function.###
```lisp
(define or-func
  (lambda (or1 or2)
    (or (or1) (or2))))
```
Assuming that *or1* and *or2* are always thunks, convince yourself that (or ...) and or-func are equivalent. Consider as an example

    (or (null? l) (atom? (car l)))

 and the corresponding application

    (or-func
      (lambda () (null? l))
      (lambda () (atom? (car l)))),

 where
   l is ().

Write set-f? to take or-func and and-func. Write the functions intersect? and subset? with this set-f? function.

```lisp
(define set-f?
  (lambda (logical? const)
    (lambda (set1 set2)
      (cond
        ((null? set1) const)
        (t (logical?
             (lambda ()
               (member? (car set1) set2))
             (lambda ()
               ((set-f? logical? const) (cdr set1) set2))))))))

(define intersect? (set-f? or-func nil))
(define subset? (set-f? and-func t))
```
