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

###4.2 Write the function multvec that builds a number by multiplying all the numbers in a vec###
```lisp
Example: (multvec vec2) is 24,
         (multvec vec3) is 6,
            (multvec l) is 1
```
```lisp
(define multvec
  (lambda (vec)
    (cond
      ((null? vec) 1)
      (t (* (car vec) (multvec (cdr vec)))))))
```

###4.3 When building a value with ^, which value should you use for the terminal line?###

1

###4.4 Argue the correctness for the function ^ as we did for (x n m). Use 3 and 4 as data###
```
3 ^ 4 = 3 ^ 3 * 3
3 ^ 3 = 3 ^ 2 * 3
3 ^ 2 = 3 ^ 1 * 3
3 ^ 1 = 3 ^ 0 * 3
3 ^ 0 = 1
3 ^ 4 = 1 * 3 * 3 * 3 * 3
      = 81
```

###4.5 Write the function index of a and lat that returns the place of the atom a in lat. You may assume that a is a member of lat. Hint: Can lat be empty?###
```lisp
Example: When a is car,
           lat1 is (cons cdr car null? eq?),
              b is motor, and
           lat2 is (car engine auto motor),
we have (index a lat1) is 3,
        (index a lat2) is 1,
        (index b lat2) is 4
```
```lisp
(define index
  (lambda (a lat)
    (cond
      ((null? lat) 0)
;;    ((not (member? a lat)) 0)
      ((eq? a (car lat)) 1)
      (t (add1 (index a (cdr lat)))))))
```
