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
