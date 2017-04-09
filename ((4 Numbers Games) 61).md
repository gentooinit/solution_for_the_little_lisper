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

### 4.1 Write the function duplicate of n and obj which builds a list containing n objects obj
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

### 4.2 Write the function multvec that builds a number by multiplying all the numbers in a vec
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

### 4.3 When building a value with ^, which value should you use for the terminal line?

1

### 4.4 Argue the correctness for the function ^ as we did for (x n m). Use 3 and 4 as data
```
3 ^ 4 = 3 ^ 3 * 3
3 ^ 3 = 3 ^ 2 * 3
3 ^ 2 = 3 ^ 1 * 3
3 ^ 1 = 3 ^ 0 * 3
3 ^ 0 = 1
3 ^ 4 = 1 * 3 * 3 * 3 * 3
      = 81
```

### 4.5 Write the function index of a and lat that returns the place of the atom a in lat. You may assume that a is a member of lat. Hint: Can lat be empty?
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

### 4.6 Write the function product of vec1 and vec2 that multiplies corresponding numbers in vec1 and vec2 and builds a new vec from the results. The vecs, vec1 and vec2, may differ in length
``lisp
Example: (product vec1 vec2) is (3 4 4),
         (product vec2 vec3) is (6 2 12),
         (product vec3 vec4) is (12 2 3)
```
```lisp
(define product
  (lambda (vec1 vec2)
    (cond
      ((null? vec1) vec2)
      ((null? vec2) vec1)
      (t (cons (* (car vec1) (car vec2))
           (product
	     (cdr vec1) (cdr vec2))))
```

### 4.7 Write the function dot product of vec1 and vec2 that multiplies corresponding numbers in vec1 and vec2 and builds a new number by summing the results. The vecs, vec1 and vec2, are the same length
```lisp
Example: (dot-product vec2 vec2) is 29,
         (dot-product vec2 vec4) is 26,
         (dot-product vec3 vec4) is 17
```
```lisp
(define dot-product
  (lambda (vec1 vec2)
    (cond
      ((null? vec1) 0)
      ((null? vec2) 0)
      (t (+ (* (car vec1) (car vec2))
            (dot-product (cdr vec1) (cdr vec2)))))))
```

### 4.8 Write the function / that divides nonnegative integers
```lisp
Example: (/ n m) is 1, when n is 7 and m is 5,
         (/ n m) is 4, when n is 8 and m is 2,
         (/ n m) is 0, when n is 2 and m is 3
Hint: A number is now defined as a rest (between 0 and m - 1) and a multiple addition of m.
The number of additions is the result.
```
```lisp
(define /
  (lambda (n m)
    (cond
      ((< n m) 0)
      (t (add1 (/ (- n m) m))))))
```

### 4.9 Here is the function remainder
```lisp
(define remainder
  (lambda (n m)
    (cond
      (t (- n (* m (/ n m)))))))

Make up examples for the application (remainder n m) and work through them
```
```lisp
Example: (remainder n m) is 2, when n is 7 and m is 5,
         (remainder n m) is 0, when n is 8 and m is 2,
         (remainder n m) is 2, when n is 2 and m is 3

When n is 7 and m is 5, (/ n m) is 1, and (* m (/ n m)) is 5, than the (- n (* m (/ n m))) is 2. So the value of (remainder n m) is 2.
When n is 8 and m is 2, (/ n m) is 4, and (* m (/ n m)) is 8, than the (- n (* m (/ n m))) is 0. So the value of (remainder n m) is 0.
When n is 2 and m is 3, (/ n m) is 0, and (* m (/ n m)) is 0, than the (- n (* m (/ n m))) is 2. So the value of (remainder n m) is 2.
```

### 4.10 Write the function <= which tests if two numbers are equal or if the first is less than the second
```lisp
Example: (<= zero one) is true,
         (<= one one) is true,
         (<= three one) is false
```
```lisp
(define <=
  (lambda (n m)
    (cond
      ((zero? n) t)
      ((zero? m) nil)
      (t (<= (sub1 n) (sub1 m))))))
```
