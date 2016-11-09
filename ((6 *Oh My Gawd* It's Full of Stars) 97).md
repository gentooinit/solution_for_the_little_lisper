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

###6.4 Consider the function lat? from Chapter 2. Argue why lat? has to ask three questions (and not two like the other functions in Chapter 2). Why does lat? not have to recur on the car?###
```lisp
This is the function lat?
(define lat?
  (lambda (l)
    (cond
      ((null? l) t)
      ((atom? (car l)) (lat? (cdr l)))
      (t nil))))
```
The function lat? has to ask three questions.
Because the argument of function lat? are either
* empty,
* an atom consed onto a list, or
* a list consed onto a list

And lat? asks if each S-expression in l is an atom,
if it is, the value is t, if not, the value is nil. It has to ask the three questions in turn until it runs out of S-expressions.
The function lat? does not have to recur on the car, because knowing one S-expression is not an atom is enough to determine the value.

###6.5 Make sure that (member* a l), where###
```lisp
    a is chips and
    l is ((potato) (chips ((with) fish) (chips))),
really discovers the first chips. Can you change member* so that it finds the last chips first?
```
```lisp
(define member*
  (lambda (a l)
    (cond
      ((null? l) nil)
      ((atom? (car l))
       (or
         (member* a (cdr l))
         (eq? (car l) a)))
      (t (or
           (member* a (cdr l))
           (member* a (car l)))))))
```

###6.6 Write the function list+ which adds up all the numbers in a general list of numbers###
```lisp
Example: When l1 is ((1 (6 6 ()))),
          and l2 is ((1 2 (3 6)) 1), then
      (list+ l1) is 13
      (list+ l2) is 13
      (list+ l3) is 0
```
```lisp
(define list+
  (lambda (l)
    (cond
      ((null? l) 0)
      ((number? (car l))
       (+ (car l) (list+ (cdr l))))
      ((atom? (car l))
       (list+ (cdr l)))
      (t (+ (list+ (car l))
           (list+ (cdr l)))))))
```
