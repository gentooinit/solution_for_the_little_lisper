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
