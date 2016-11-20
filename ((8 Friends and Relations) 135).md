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
  (lambda (a1 a2)
    (cons a1
      (cons a2 (quote ())))))

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
      ((eq? (first (car f)) x)
       (second (car f)))
      (t (Fapply (cdr f) x)))))
```
