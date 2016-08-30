```lisp
For these exercises,
  l1 is ((paella spanish) (wine red) (and beans))
  l2 is ()
  l3 is (cincinnati chili)
  l4 is (texas hot chili)
  l5 is (soy sauce and tomato sauce)
  l6 is ((spanish) () (paella))
  l7 is ((and hot) (but dogs))
  a1 is chili
  a2 is hot
  a3 is spicy
  a4 is sauce
  a5 is soy
```

###3.1 Write the function seconds which takes a list of lats and makes a new lat consisting of the second atom from each lat in the list###
```lisp
Example: (seconds l1) is (spanish red beans)
         (seconds l2) is ()
         (seconds l7) is (hot dogs)
```
```lisp
(define seconds
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (t (cons
           (car (cdr (car l)))
           (seconds (cdr l)))))))
```

###3.2 Write the function dupla of a and l which makes a new lat containing as many a's as there are elements in l###
```lisp
Example: (dupla a2 l4) is (hot hot hot)
         (dupla a2 l2) is ()
         (dupla a1 l5) is (chili chili chili chili chili)
```
```lisp
(define dupla
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      (t (cons a (dupla a (cdr l)))))))
```

###3.3 Write the function double of a and l which is a converse to rember The function doubles the first a in l instead of removing it###
```lisp
Example: (double a2 l2) is ()
         (double a1 l3) is (cincinnati chili chili)
         (double a2 l4) is (texas hot hot chili)
```
```lisp
(define double
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((eq? a (car l)) (cons a l))
      (t (cons (car l) (double a (cdr l)))))))
```
