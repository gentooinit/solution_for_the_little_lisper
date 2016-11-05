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

###5.4 Write the function occurN of alat and lat which counts how many times an atom also occurs in lat###
```lisp
Example: (occurN lat1 l4) is 0,
         (occurN lat1 lat2) is 1,
         (occurN lat1 lat3) is 2
```
```lisp
(define occurN
  (lambda (alat lat)
    (cond
      ((null? lat) 0)
      ((member? (car lat) alat)
       (add1 (occurN alat (cdr lat))))
      (t (occurN alat (cdr lat))))))
```

###5.5 The function I of lat1 and lat2 returns the first atom in lat2 that is in both lat1 atom. Write the functions I and multiI. multiI returns a list of atoms common to lat1 and lat2###
```lisp
Example: (I lat1 l4) is (),
       (I lat1 lat2) is bananas,
       (I lat1 lat3) is kiwis;
    (multiI lat1 l4) is (),
  (multiI lat1 lat2) is (bananas),
  (multiI lat1 lat3) is (kiwis bananas)
```
```lisp
(define I
  (lambda (lat1 lat2)
    (cond
      ((null? lat2) (quote ()))
      ((member? (car lat2) lat1) (car lat2))
      (t (I lat1 (cdr lat2))))))

(define multiI
  (lambda (lat1 lat2)
    (cond
      ((null? lat2) (quote ()))
      ((member? (car lat2) lat1)
       (cons (car lat2)
         (multiI lat1 (cdr lat2))))
      (t (multiI lat1 (cdr lat2))))))
```

###5.6 Consider the following alternative definition of one?###
```lisp
(define one?
  (lambda (n)
    (cond
      ((zero? (sub1 n)) t)
      (t nil))))
Which Laws and/or Commandments does it violate?
```

The First Commandment

###5.7 Consider the following definition of =###
```lisp
(define =
  (lambda (n m)
    (cond
      ((zero? n) (zero? m))
      (t (= n (sub1 m))))))
This definition violates The Six Commandment. Why?
```
Because the argument n is tested in the termination condition, but it doesn't change while recurring.

###5.8 The function count0 of vec counts the number of zero elements in vec. What is wrong with the following definition? Can you fix it?###
```lisp
(define count0
  (lambda (vec)
    (cond
      ((null? vec) 1)
      (t (cond
           ((zero? (car vec))
            (cons 0 (count0 (cdr vec))))
           (t (count0 (cdr vec))))))))
```
```lisp
The function count0 uses cons to build number, that is wrong.
And when vec is null, there is no zero element in it, so the value of terminating line should be 0.

Fixed:
(define count0
  (lambda (vec)
    (cond
      ((null? vec) 0)
      (t (cond
           ((zero? (car vec))
            (add1 (count0 (cdr vec))))
           (t (count0 (cdr vec))))))))
```

###5.9 Write the function multiup of l which replaces every lat of length one in l by the atom in that list, and which also removes every empty list###
```lisp
Example: (multiup l4) is (),
         (multiup l1) is (curry chicken),
         (multiup l2) is (peaches (and cream))
```
```lisp
(define multiup
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (t (cond
           ((null? (car l))
            (multiup (cdr l)))
           ((atom? (car l))
            (cons (car l)
              (multiup (cdr l))))
           ((and (atom? (car (car l)))
              (null? (cdr (car l))))
            (cons (car (car l))
              (multiup (cdr l))))
           (t (cons (car l)
                (multiup (cdr l)))))))))
```

###5.10 Review all the Laws and Commandments. Check the functions in Chapter 4 and 5 to see if they obey the Commandments. When did we not obey them literally? Did we act according to their spirit?###

In Chapter 4:
The function +, -, *, >, =, ^, eqan? are obey The First Commandment.

In Chpater 5:
The function one? is obey The First Commandment.

When we recurring at lat, we do not obey them literally.
When we the recurring at number or the length of what we processing at is cetainty, we act according to their spirit.
