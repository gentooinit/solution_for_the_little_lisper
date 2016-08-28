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
