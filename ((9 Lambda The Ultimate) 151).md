###9.1 Look up the functions firsts and seconds in Chapter 3. They can be generalized to a function map of *f* and *l* that applies *f* to every element in *l* and builds a new list with the resulting values. Write the function map. Then write the function firsts and seconds using map.###
```lisp
(define map
  (lambda (f)
    (lambda (l)
      (cond
        ((null? l) (quote ()))
        (t (cons (f (car l))
             ((map f) (cdr l))))))))

(define first
  (lambda (p)
    (car p)))

(define second
  (lambda (p)
    (car (cdr p))))

(define firsts (map first))
(define seconds (map second))

```
