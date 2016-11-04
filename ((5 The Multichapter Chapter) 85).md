```lisp
For these exercises,
                   x is comma
                   y is dot
                   a is kiwis
                   b is plums
                lat1 is (bananas kiwis)
                lat2 is (peaches apples bananas)
                lat3 is (kiwis pears plums bananas cherries)
                lat4 is (kiwis mangoes kiwis guavas kiwis)
                  l1 is ((curry) () (chicken) ())
                  l2 is ((peaches) (and cream))
                  l3 is ((plums) and (ice) and cream)
                  l4 is ()
```

###5.1 For Exercise 3.4 you wrote the function subst cake. Write the function multis###
```lisp
Example: (multisubst-kiwis b lat1) is (bananas plums),
         (multisubst-kiwis y lat2) is (peaches apples bananas),
         (multisubst-kiwis y lat4) is (dot mangoes dot guavas dot),
           (multisubst-kiwis y l4) is ()
```
```lisp
(define multisubst-kiwis
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      (t (cond
           ((eq? (car lat) (quote kiwis))
            (cons a
              (multisubst-kiwis a (cdr lat))))
           (t (cons (car lat)
                (multisubst-kiwis a (cdr lat)))))))))
```

###5.2 Write the function multisubst2. You can find subst2 at the end of Chapter 3###
```lisp
Example: (multisubst2 x a b lat1) is (bananas comma),
         (multisubst2 y a b lat3) is (dot pears dot bananas cherries),
         (multisubst2 a x y lat1) is (bananas kiwis).
        *(multisubst2 x a b lat4) is (comma mangoes comma guavas comma)
```
```lisp
(define multisubst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) (quote ()))
      ((or (eq? (car lat) o1) (eq? (car lat) o2))
         (cons new (multisubst2 new o1 o2 (cdr lat))))
      (t (cons (car lat)
           (multisubst2 new o1 o2 (cdr lat)))))))
```

###5.3 Write the function multidown of lat which replaces every atom in lat by list the atom###
```lisp
Example: (multidown lat1) is ((bananas) (kiwis)),
         (multidown lat2) is ((peaches) (apples) (bananas)),
           (multidown l4) is ()
```
```lisp
(define multidown
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((atom? (car lat))
       (cons
         (cons (car lat) (quote ()))
         (multidown (cdr lat))))
      (t (cons (car lat)
           (multidown (cdr lat)))))))
```
