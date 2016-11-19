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
