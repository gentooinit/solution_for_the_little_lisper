```lisp
For these exercises,
  l1 is (german chocolate cake)
  l2 is (poppy seed cake)
  l3 is ((linzer) (torte) ())
  l4 is ((bleu cheese) (and) (red) (wine))
  l5 is (() ())
  a1 is coffee
  a2 is seed
  a3 is poppy
```

###2.1 What are the values of (lat? l1), (lat? l2), and (lat? l3)?###
```lisp
(lat? l1) is true, (lat? l2) is true, (lat? l3) is false.
```

###2.2 For each case in Exercise 2.1, step through the apphcation as we did in the chapter###
```lisp
This is the function lat? again:
(define lat?
  (lambda (l)
    (cond
      ((null? l) t)
      ((atom? (car l)) (lat? (cdr l)))
      (t nil))))

What is the value of (lat? l1)
where l1 is now (german chocolate cake)

Q1: What is the first question asked by (lat? l1)
A1: (null? l1).
Note:
  (cond ...) asks questions;
  (lambda ...) creates a function; and
  (define ...) gives it a name.
  
Q2: What is the meaning of the line
     ((null? l1) t)
    where
      l1 is (german chocolate cake)
A2: (null? l1) asks if the argument l1 is the null list. If it is, the value is 
t. If l is not null, move to the next question. In this case, it is not null, 
so we ask the next question.

Q3: What is the next question?
A3: (atom? (car l1)).

Q4: What is the meaning of the line
     ((atom? (car l1)) (lat? (cdr l1)))
    Where
     l1 is (german chocolate cake)
A4: (atom? (car l1)) asks if (car l1) is an atom. If it is, the value is 
(lat? (cdr l1)). If it is not, we ask the next question. In this case, (car l1)
is an atom, so we want to check if the rest of the list l1 is composed only of
atoms.

Q5: What is the meaning of
     (lat? (cdr l1))
A5: (lat? (cdr l1)) checks to see if the rest of the list l1 is composed only of
atoms, by referring to lat? with l1 replaced by (cdr l1).

Q6: What is the meaning of the line
     ((null? l1) t)
    where
     l1 is now (chocolate cake)
A6: (null? l1) asks if the argument l1 is the null list. If it is null, the 
value is t. If it is not null, we ask the next question. In this case, l1 is 
not null, so move to the next questioin.

Q7: What is the next question?
A7: (atom? (car l1)).

Q8: What is the meaning of the line
     ((atom? (car l1)) (lat? (cdr l1)))
    where
     l1 is now (chocolate cake)
A8: (atom? (car l1)) asks if (car l1) is an atom. If it is, the value is
(lat? (cdr l1)). If it is not, we move to the next question. In this case, 
(car l1) is an atom, so we want to check if the rest of the list l1 is composed
only of atoms.

Q9: What is the meaning of
     (lat? (cdr l1))
A9: (lat? (cdr l1)) finds out if the rest of the list l1 is composed only of
atoms, by referring to the function with a new argument.

Q10: What is the meaning of the line
      ((null? l1) t)
     where
      l1 is now (cake)
A10: (null? l1) asks if the argument l1 is the null list. If it is null, the 
value is t. If it is not null, we ask the next question. In this case, l1 is 
not null, so move to the next question.

Q11: What is the next question?
A11: (atom? (car l1)).

Q12: What is the meanning of the line
      ((atom? (car l1)) (lat? (cdr l1)))
     where
      l1 is now (cake)
A12: (atom? (car l1) asks if the (car l1) is an atom. If it is, the value is
(lat? (cdr l1)). If it is not, we move to the next question. In this case,
(car l1) is an atom, so we want to check if the rest of the list l1 is composed
only of atoms.

Q13: What is the meaning of
      (lat? (cdr l1))
A13: (lat? (cdr l1)) finds out if the rest of the list l1 is composed only of
atoms, by referring to the function with a new argument.

Q14: Now, what is the argument for lat?
A14: ().

Q15: What is the meaning of the line
      ((null? l1) t)
     where
      l1 is now ()
A15: (null? l1) asks if the argument l1 is the null list. If it is null, the 
value is t. If it is not null, we ask the next question. In this case, () is 
null list. So the value of the application (lat? l1)
where
 l1 is the (german chocolate cake), is t-true.


What is the value of (lat? l2)
where l2 is now (poppy seed cake)

Q1: What is the first question?
A1: (null? l2).

Q2: What is the meaning of the line
     ((null? l2) t)
    where
     l2 is (poppy seed cake)
A2: ((null? l2) t) asks if the argument l2 is the null list. If it is, the 
value is t. If it is not null, we ask the next question. In this case, it is 
not null. So we ask the next question.

Q3: What is the next question?
A3: (atom? (car l2)).

Q4: What is the meaning of the line
     ((atom? (car l2)) (lat? (cdr l2)))
    where
     l2 is (poppy seed cake)
A4: (atom? (car l2)) asks if (car l2) is an atom. If it is, the value is
(lat? (cdr l2)). If it is not, we ask the next question. In this case, (car l2)
is an atom, so we want to check if the rest of the list l2 is composed only of 
atoms.

Q5: What is the meaning of
     (lat? (cdr l2))
A5: (lat? (cdr l2)) checks to see if the rest of the list l2 is composed only 
of atoms, by referring to lat? with l2 replaced by (cdr l2).

Q6: What is the meaning of the line
     ((null? l2) t)
    where
     l2 is now (seed cake)
A6: ((null? l2) t) asks if the argument l2 is the null list. If it is, the value is t.
If it is not, we ask the next question. In this case, it is not null. So we 
ask the next question.

Q7: What is the meaning of the line
     ((atom? (car l2)) (lat? (cdr l2)))
    where
     l2 is now (seed cake)
A7: (atom? (car l2)) asks if (car l2) is an atom. If it is, the value is 
(lat? (cdr l2)). If it is not, we ask the next question. In this case, (car l2)
is an atom, so we want to check if the rest of the list l2 is composed only of 
atoms.

Q8: What is the meaning of 
     (lat? (cdr l2))
A8: (lat? (cdr l2)) checks to see if the rest of the list l2 is composed only 
of atoms, by referring to lat? with l2 replaced by (cdr l2).

Q9: What is the meaning of the line
     ((null? l2) t)
    where
     l2 is now (cake)
A9: (null? l2) asks if the argument l2 is the null list. If it is, the value is t. If 
it is not, we ask the next question. In this case, it is not null. So we ask
the next question.

Q10: What is the meaning of the line
      ((atom? (car l2)) (lat? (cdr l2)))
     where
      l2 is now (cake)
A10: (atom? (car l2)) asks if (car l2) is an atom. If it is, the value is 
(lat? (cdr l2)). If it is not, we ask the next question. In this case, (car l2)
is an atom, so we want to check if the rest of the list l2 is composed only of 
atoms.

Q11: What is the meaning of
      (lat? (cdr l2))
A11: (lat? (cdr l2)) checks to see if the rest of the list l2 is composed only 
of atoms, by referring to lat? with l2 replaced by (cdr l2).

Q12: Now, what is the argument for lat?
A12: ().

Q13: What s the meaning of the line
      ((null? l2) t)
     where
      l2 is now ()
A13: (null? l2) asks if the argument l2 is the null list. If it is, the value 
is t. If it is not, we ask the next question. In this case, () is null list. 
So the value of the application of (lat? l2) where l2 is (poppy seed cake), is 
t-true.


What is the value of (lat? l3)
where l3 is now ((linzer) (torte) ())

Q1: What is the first question asked by (lat? l3)
A1: (null? l3).

Q2: What is the meaning of the line
     ((null? l3) t)
    where
     l3 is ((linzer) (torte) ())
A2: (null? l3) asks if the argument l3 is the null list. If it is, the value is 
t. If it is not, we ask the next question. In this case, it is not null. So we
ask the next question.

Q3: What is the next question?
A3: (atom? (car l3)).

Q4: What is the meaning of the line
     ((atom? (car l3)) (lat? (cdr l3)))
    where
     l3 is ((linzer) (torte) ())
A4: (atom? (car l3)) asks if (car l3) is an atom. If it is, the value is 
(lat? (cdr l3)). If it is not, we ask the next question. In this case, (car l3)
is not an atom. So we ask the next question.

Q5: What is the next question?
A5: t.

Q6: What is the meaning of the question t
A6: t asks if t is true.

Q7: Is t true?
A7: Yes, because the question t is always true!

Q8: t
Q8: t

Q9: Why is t the last question?
A9: Because we do not need to ask any more questions.

Q10: Why do we not need to ask any more questions
A10: Because a list can be empty, can have an atom in the first position. or can
have a list in the first position.

Q11: What is the meaning of the line
      (t nil)
A11: t asks if t is true. If t is true -as it always is- then the
answer is nil -false.

Q12: What is
      )))
A12: There are the closing or matching parentheses of (cond ..., (lambda ...,
and (define ..., which appear at the beginning of a function definition.

```
