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

###6.7 Consider the following function g* of lvec and acc###
```lisp
(define g*
  (lambda (lvec acc)
    (cond
      ((null? lvec) acc)
      ((atom? (car lvec))
       (g* (cdr lvec) (+ (car lvec) acc)))
      (t (g* (car lvec) (g* (cdr lvec) acc))))))
The function is always applied to a (general) list of numbers and 0. Make up examples and find
out what the function does.
```
```lisp
Example: When l1 is ((1 2) 3 (((4)))),
          and l2 is ((4) (3 2 1 0)), then
       (g* l1 0) is 10
       (g* l2 0) is 10

The function g* adds up acc and all the numbers in a general list(assume all the atoms are numbers).
```

###6.8 Consider the following function f* of l and acc###
```lisp
(define f*
  (lambda (l acc)
    (cond
      ((null? l) acc)
      ((atom? (car l))
       (cond
         ((member? (car l) acc) (f* (cdr l) acc))
         (t (f* (cdr l) (cons (car l) acc)))))
      (t (f* (car l) (f* (cdr l) acc))))))
The function is always applied to a list and the empty list. Make up examples for l and step
through the applications. Generalize in one sentence what f* does
```
```lisp
Example: When l1 is (lisp scheme lisp erlang erlang),
          and l2 is ((lisp scheme) lisp ((lisp))), then
     (f* l1 '()) is (erlang scheme lisp)
     (f* l2 '()) is (scheme lisp)

Q1: (f* l1 '())
A1: We will go through it.

Q2: (null? l1)
A2: nil

Q3: (atom? (car l1))
A3: t

Q4: (member? (car l1) acc)
A4: nil, acc is ()

Q5: (f* (cdr l1) (cons (car l1) acc))
A5: Recur with l1 replaced by (cdr l1), which is (scheme lisp erlang erlang),
    acc replaced by (cons (car l1) acc), which is (lisp)

Q6: (null? l1)
A6: nil

Q7: (atom? (car l1))
A7: t

Q8: (member? (car l1) acc)
A8: nil, acc is (lisp), (car l1) is scheme

Q9: (f* (cdr l1) (cons (car l1) acc))
A9: Recur with l1 replaced by (cdr l1), which is (lisp erlang erlang),
    acc replaced by (cons (car l1) acc), which is (scheme lisp)

Q10: (null? l1)
A10: nil

Q11: (atom? (car l1))
A11: t

Q12: (member? (car l1) acc)
A12: t, acc is (scheme lisp), (car l1) is lisp, lisp is a member of (scheme lisp).

Q13: (f* (cdr l1) acc)
A13: Recur with l1 replaced by (cdr l1), which is (erlang erlang).

Q14: (null? l1)
A14: nil

Q15: (atom? (car l1))
A15: t

Q16: (member? (car l1) acc)
A16: nil, acc is (scheme lisp), (car l1) is erlang, erlang is not in (scheme lisp).

Q17: (f* (cdr l1) (cons (car l1) acc))
A17: Recur with l1 replaced by (cdr l1), which is (erlang),
     acc replaced by (cons (car l1) acc), which is (erlang scheme lisp)

Q18: (null? l1)
A18: nil

Q19: (atom? (car l1))
A19: t

Q20: (member? (car l1) acc)
A20: t, acc is (erlang scheme lisp), (car l1) is erlang, erlang is a member of (erlang scheme lisp).

Q21: (f* (cdr l1) acc)
A21: Recur with l1 replaced by (cdr l1), which is ()

Q22: (null? l1)
A22: t, so the value is (erlang scheme lisp)

Q23: Are we finished?
A23: Yes, of course.



Q1: (f* l2 '())
A1: We will go through it.

Q2: (null? l2)
A2: nil

Q3: (atom? (car l2))
A3: nil, (car l2) is (lisp scheme)

Q4: (f* (car l2) (f* (cdr l2) acc))
A4: We recur with l2 replaced by (car l2), which is (lisp scheme),
    and acc is (f* (cdr l2) acc). Seems we have to recur the second function first.

Q5: Recur (f* (cdr l2) acc), (cdr l2) is (lisp ((lisp))), acc is ()
A5: Let's do it.

Q6: (null? l2)
A6: nil

Q7: (atom? (car l2))
A7: t

Q8: (member? (car l2) acc)
A8: nil, (car l2) is lisp, acc is ()

Q9: (f* (cdr l2) (cons (car l2) acc))
A9: Recur with l2 replaced by (cdr l2), which is (((lisp))), and acc is (lisp).

Q10: (null? l2)
A10: nil

Q11: (atom? (car l2))
A11: nil

Q12: (f* (car l2) (f* (cdr l2) acc))
A12: We recur with l2 replaced by (car l2), which is ((lisp))
     and acc is (f* (cdr l2) acc). Seems we have to recur the second function first.

Q13: (f* (cdr l2) acc)
A13: (cdr l2) is (), so the value is acc, which is (lisp). Go back to the previous question.

Q14: (f* (car l2) (f* (cdr l2) acc))
A14: We recur with l2 replaced by (car l2), which is ((lisp))
     and acc is (f* (cdr l2) acc), which is (lisp).

Q15: (null? l2)
A15: nil

Q16: (atom? (car l2))
A16: nil

Q17: (f* (car l2) (f* (cdr l2) acc))
A17: We recur with l2 replaced by (car l2), which is (lisp)
     and acc is (f* (cdr l2) acc), and the (cdr l2) is (), so the acc is (lisp).

Q18: (null? l2)
A18: nil

Q19: (atom? (car l2))
A19: t

Q20: (member? (car l2) acc)
A20: t, (car l2) is lisp, acc is (lisp).

Q21: (f* (cdr l2) acc)
A21: Recur with l2 replaced by (cdr l2), which is ().

Q22: (null? l2)
A22: t, so the value is (lisp). Go back to the Q4 question.

Q23: (f* (car l2) (f* (cdr l2) acc))
A23: We recur with l2 replaced by (car l2), which is (lisp scheme),
    and acc is (f* (cdr l2) acc), which is (lisp).

Q24: (null? l2)
A24: nil

Q25: (atom? (car l2))
A25: t

Q26: (member? (car l2) acc)
A26: t, (car l2) is lisp, acc is (lisp).

Q27: (f* (cdr l2) acc)
A27: Recur with l2 replaced by (cdr l2), which is (scheme).

Q28: (null? l2)
A28: nil

Q29: (atom? (car l2))
A29: t

Q30: (member? (car l2) acc)
A30: nil, (car l2) is scheme, acc is (lisp). scheme is not in (lisp).

Q31: (f* (cdr l2) (cons (car l2) acc))
A31: Recur with l2 replaced by (cdr l2), which is (),
     and acc is (cons (car l2) acc), which is (scheme lisp)

Q32: (null? l2)
A32: t, so the value is (scheme lisp).

Q33: Are we finished?
A33: Yes, of course.

The function f* takes individual atoms from a list to build a lat in reverse order.

```

###6.9 The functions in Exercise 6.7 and 6.8 employ the *accumulator technique*. This means that they pass along an argument that represents the result that has been computed so far. When these functions reach the bottom (null?, zero?), they just return the result contained in the accumulator. The original argument for the accumulator is the element that used to be the answer for the null?-case. Write the function occur (see Chapter 5) of a and lat using the accumulator technique. What is the original value for acc?###
```lisp
(define occur
  (lambda (a lat acc)
    (cond
      ((null? lat) acc)
      ((eq? (car lat) a)
       (occur a (cdr lat) (add1 acc)))
      (t (occur a (cdr lat) acc)))))

The original value of acc is 0.
```
