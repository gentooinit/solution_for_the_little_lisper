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
