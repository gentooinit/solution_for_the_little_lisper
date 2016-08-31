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

###3.4 Write the function subst sauce of a and l which substitutes a for the first atom sauce in l###
```lisp
Example: (subst-sauce a1 l4) is (texas hot chili)
         (subst-sauce a1 l5) is (soy chili and tomato sauce)
         (subst-sauce a4 l2) is ()
```
```lisp
(define subst-sauce
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((eq? (quote sauce) (car l)) (cons a (cdr l)))
      (t (cons (car l) (subst-sauce a (cdr l)))))))
```
###3.5 Write the function subst3 of new, o1, o2, o3 and lat which -like subst2- replaces the first occurrence of either o1, o2, or o3 in lat by new###
```lisp
Example: (subst3 a5 a1 a2 a4 l5) is (soy soy and tomato sauce)
         (subst3 a4 a1 a2 a3 l4) is (texas sauce chili)
         (subst3 a3 a1 a2 a5 l2) is ()
```
```lisp
(define subst3
  (lambda (new o1 o2 o3 lat)
    (cond
      ((null? lat) (quote ()))
      ((or
        (eq? (car lat) o1)
        (eq? (car lat) o2)
        (eq? (car lat) o3))
       (cons new (cdr lat)))
      (t (cons (car lat) (subst3 new o1 o2 o3 (cdr lat)))))))
```

###3.6 Write the function substN of new, slat and lat which replaces the first atom in lat that also occurs in slat by the atom new###
```lisp
Example: (substN a2 l3 l4) is (texas hot hot)
         (substN a4 l3 l5) is (soy sauce and tomato sauce)
         (substN a4 l3 l2) is ()
```
```lisp
(define substN
  (lambda (new slat lat)
    (cond
      ((null? lat) (quote ()))
      ((member? (car lat) slat) (cons new (cdr lat)))
      (t (cons (car lat) (substN new slat (cdr lat)))))))
```
