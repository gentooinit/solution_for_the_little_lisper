```lisp
For these exercises,
                   vec1 is (1 2)
		   vec2 is (3 2 4)
		   vec3 is (2 1 3)
		   vec4 is (6 2 1)
		   l is ()
		   zero is 0
		   one is 1
		   three is 3
		   obj is (x y)
```

###4.1 Write the functioin duplicate of n and obj which builds a list containing n objects obj###
```lisp
Example: (duplicate three obj) is ((x y) (x y) (x y)),
         (duplicate zero obj) is (),
         (duplicate one vec1) is ((1 2))
```
```lisp
(define duplicate
  (lambda (n obj)
    (cond
      ((zero? n) (quote ()))
      (t (cons obj (duplicate (sub1 n) obj))))))
```