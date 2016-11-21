```lisp
For these exericse,
                 r1 is ((a b) (a a) (b b))
                 r2 is ((c c))
                 r3 is ((a c) (b c))
                 r4 is ((a b) (b a))
                 f1 is ((a 1) (b 2) (c 2) (d 1))
                 f2 is ()
                 f3 is ((a 2) (b 1))
                 f4 is ((1 $) (3 *))
                 d1 is (a b)
                 d2 is (c d)
                  x is a
```

###8.1 Write the function domset of *rel*, which makes a set of all the atoms in *rel*. This set is referred to as *domain of discourse* of the relation *rel*.###
```lisp
Example: (domset r1) is (a b),
         (domset r2) is (c),
         (domset r3) is (a b c).
```
Also write the function idrel of *s*, which makes a relation of all pairs of the form (d d) where
d is an atom of the set *s*. (idrel s) is called the *identity relation on s*.
```lisp
Example: (idrel d1) is ((a a) (b b)),
         (idrel d2) is ((c c) (d d)),
         (idrel f2) is ().
```
```lisp
(define build
  (lambda (s1 s2)
    (cons s1
      (cons s2 (quote ())))))

(define domset
  (lambda (rel)
    (cond
      ((null? rel) (quote ()))
      (t (union (makeset (car rel))
           (domset (cdr rel)))))))

(define idrel
  (lambda (dom)
    (cond
      ((null? dom) (quote ()))
      (t (cons (build (car dom) (car dom))
           (idrel (cdr dom)))))))
```

###8.2 Write the function reflexive? which tests whether a relation is *reflexive*. A relation is reflexive if it contains all pairs of the form (d d) where d is an element of its domain of discourse (see Exercise 8.1).###
```lisp
Example: (reflexive? r1) is true,
         (reflexive? r2) is true,
         (reflexive? r3) is false.
```
```lisp
(define subrel?
  (lambda (p rel)
    (cond
      ((null? rel) nil)
      ((equal? (car rel) p) t)
      (t (subrel? p (cdr rel))))))

(define reflexive-help
  (lambda (rel idr)
    (cond
      ((null? idr) t)
      (t (and (subrel? (car idr) rel)
           (reflexive-help rel (cdr idr)))))))

(define reflexive?
  (lambda (rel)
    (reflexive-help rel (idrel (domset rel)))))
```

###8.3 Write the function symmetric? which tests whether a relation is *symmetric*. A relation is symmetric if it is eqset? to its revrel.###
```lisp
Example: (symmetric? r1) is false,
         (symmetric? r2) is true,
         (symmetric? f2) is true.
```
Also write the function antisymmetric? which tests whether a relation is *antisymmetric*. A relation is antisymmetric if the intersection of the relation
with its revrel is a subset of the identity relation on its domain of discourse (see Exercise 8.1)
```lisp
Example: (antisymmetric? r1) is true,
         (antisymmetric? r2) is true,
         (antisymmetric? r4) is false.
```
And finally, this is the function asymmetric? which tests whether a relation is asymmetric.
```lisp
(define asymmetric?
  (lambda (rel)
    (null? (intersect rel (revrel rel)))))
```
Find out which of the sample relations is asymmetric. Characterize asymmetry in one sentence.

```lisp
(define symmetric?
  (lambda (rel)
    (eqset? rel (revrel rel))))

(define antisymmetric?
  (lambda (rel)
    (subset? (intersect rel (revrel rel))
      (idrel (domset rel)))))

(asymmetric? r3) is true,
(asymmetric? f1) is true,
(asymmetric? f2) is true,
(asymmetric? f3) is true,
(asymmetric? f4) is true.

A relation is asymmetric if the the intersect of the relation with its revrel is null.
```

###8.4 Write the function Fapply of *f* and *x*, which returns the value of *f* at place *x*. That is, it returns the second of the pair whose first is eq? to *x*.###
```lisp
Example: (Fapply f1 x) is 1,
        (Fapply f2 x) has no answer,
         (Fapply f3 x) is 2.
```
```lisp
(define first
  (lambda (p)
    (car p)))

(define second
  (lambda (p)
    (car (cdr p))))

(define Fapply
  (lambda (f x)
    (cond
      ((null? f) (quote ()))
      ((equal? (first (car f)) x)
       (second (car f)))
      (t (Fapply (cdr f) x)))))
```

###8.5 Write the function Fcomp of *f* and *g*, which composes two functions. If *g* contains an element (x y) and f contains an element (y z), then the composed function (Fcomp f g) will contain (x z).###
```lisp
Example: (Fcomp f1 f4) is (),
         (Fcomp f1 f3) is (),
         (Fcomp f4 f1) is ((a $) (d $)),
         (Fcomp f4 f3) is ((b $)).
```
Hint: The function Fapply from Exercise 8.4 may be useful.

```lisp
(define Fcomp
  (lambda (f g)
    (cond
      ((null? g) (quote ()))
      ((equal? (Fapply f (second (car g))) (quote ()))
       (Fcomp f (cdr g)))
      (t (cons
           (build (first (car g))
             (Fapply f (second (car g))))
           (Fcomp f (cdr g)))))))
```

###8.6 Write the function Rapply of *rel* and *x*, which returns the *value set* of *rel* at place *x*. The value set is the set of second components of all the pairs whose first component is eq? to *x*.###
```lisp
Example: (Rapply f1 x) is (1),
         (Rapply r1 x) is (b a),
         (Rapply f2 x) is ().
```
```lisp
(define Rapply
  (lambda (rel x)
    (cond
      ((null? rel) (quote ()))
      ((equal? (first (car rel)) x)
       (cons (second (car rel))
         (Rapply (cdr rel) x)))
      (t (Rapply (cdr rel) x)))))
```

###8.7 Write the function Rin of *x* and *set*, which produces a relation of pairs (x d) where d is an element of *set*.###
```lisp
Example: (Rin x d1) is ((a b) (a b)),
         (Rin x d2) is ((a c) (a d)),
         (Rin x f2) is ().
```
```lisp
(define Rin
  (lambda (x set)
    (cond
      ((null? set) (quote ()))
      (t (cons
           (build x (car set))
           (Rin x (cdr set)))))))
```

###8.8 Relations can be composed with the following function:###
```lisp
(define Rcomp
  (lambda (rel1 rel2)
    (cond
      ((null? rel1) (quote ()))
      (t (union
           (Rin
             (first (car rel1))
             (Rapply rel2 (second (car rel1))))
           (Rcomp (cdr rel1) rel2))))))
```
See Exercises 8.6 and 8.7.

Find the values of (Rcomp r1 r3), (Rcomp r1 f1), and (Rcomp r1 r1).

```lisp
(Rcomp r1 r3) is ((a c) (b c)),
(Rcomp r1 f1) is ((a 2) (a 1) (b 2)),
(Rcomp r1 r1) is ((a b) (a a) (b b)).
```

###8.9 Write the function transitive?, which tests whether a relation is transitive. A relation *rel* is *transitive* if the composition of *rel* with *rel* is a subset of *rel* (see Exercise 8.8).###
```lisp
Example: (transitive? r1) is true,
         (transitive? r3) is true,
         (transitive? f1) is true.
```
Find a relation for which transitive? yields false.
```lisp
(define transitive?
  (lambda (rel)
    (subset? (Rcomp rel rel) rel)))

(transitive? '((a b) (b c))) is false.
```

###8.10 Write the functions quasi-order?, partial-order?, and equivalence?, which test whether a relation is a *quasi-order*, a *partial-order*, or an *equivalence relation*, respectively.###
A relation is a
 * quasi-order if it is reflexive and transitive,
 * partial-order if it is a quasi-order and antisymmetric,
 * equivalence relation if it is a quasi-order and symmetric.

See Exercise 8.2, 8.3, and 8.9
```lisp
(define quasi-order?
  (lambda (rel)
    (and (reflexive? rel) (transitive? rel))))

(define partial-order?
  (lambda (rel)
    (and (quasi-order? rel) (antisymmetric? rel))))

(define equivalence?
  (lambda (rel)
    (and (quasi-order? rel) (symmetric? rel))))
```
