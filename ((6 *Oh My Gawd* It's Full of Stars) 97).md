```lisp
For these exercise,
                l1 is ((fried potatoes) (baked (fried)) tomatoes)
                l2 is (((chili) chili (chili)))
                l3 is ()
              lat1 is (chili and hot)
              lat2 is (baked fried)
                 a is fried
```

###6.1 Write the function down* of l which puts every atom in l in a list by itself###
```lisp
Example: (down* l2) is ((((chili)) (chili) ((chili)))),
         (down* l3) is (),
       (down* lat1) is ((chili) (and) (hot))
```
```lisp
(define down*
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cons (cons (car l) (quote ()))
         (down* (cdr l))))
      (t (cons (down* (car l))
           (down* (cdr l)))))))
```

###6.2 Write the function occurN* of lat and l which counts all the atoms that are common to lat and l###
```lisp
Example: (occurN* lat1 l2) is 3,
         (occurN* lat2 l1) is 3,
         (occurN* lat1 l3) is 0
```
```lisp
(define occurN*
  (lambda (lat l)
    (cond
      ((null? l) 0)
      ((atom? (car l))
       (cond
         ((member? (car l) lat)
          (add1 (occurN* lat (cdr l))))
         (t (occurN* (cdr l) lat))))
      (t (+ (occurN* lat (car l))
           (occurN* lat (cdr l)))))))
```

###6.3 Write the function double* of a and l which doubles each occurrence of a in l###
```lisp
Example: (double* a l1) is ((fried fried potatoes) (baked (fried fried)) tomatoes),
         (double* a l2) is (((chili) chili (chili))),
       (double* a lat2) is (baked fried fried)
```
```lisp
(define double*
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((eq? (car l) a)
          (cons a
            (cons (car l)
              (double* a (cdr l)))))
         (t (cons (car l)
              (double* a (cdr l))))))
      (t (cons (double* a (car l))
           (double* a (cdr l)))))))
```
