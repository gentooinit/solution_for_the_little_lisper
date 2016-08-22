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
###2.3 What is the value of (member? a1 l1), and (member? a2 l2)? Step through the application for each case.###
```lisp

The value of (member? a1 l1) is false, where a1 is coffee, l1 is (german chocolate cake).
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) nil)
      (t (or
           (eq? (car lat) a)
           (member? a (cdr lat)))))))

Q1: What is the first question asked by
     (member? a lat)
A1: (null? lat)

Q2: What is the meaning of the line
     ((null? lat) nil)
    where
     lat is (german chocolate cake)
A2: (null? lat) asks if lat is the null list. If it is, then the value is nil,
since the atom coffee was not found in lat. If not, then we ask the next question.
In this case, it is not null, so we ask the next question.

Q3: What is the next question?
A3: t

Q4: Why is t the next question?
A4: Because we do not need to ask any more questions.

Q5: Is t really a question?
A5: Yes, t is a question whose value is always true.

Q6: What is the meaning of the line
     (t (or
          (eq? (car lat) a)
	  (member? a (cdr lat))))
A6: Now that we know that lat is not null?, we have to find out whether the car
of lat is the same atom as a, or whether a is somewhere in the rest of the lat.
The question
    (or
      (eq? (car lat) a)
      (member? a (cdr lat)))
    does this.

Q7: What is the second question for (or  )
A7: (member? a (cdr lat)). This refers to the function with the argument lat
replaced by (cdr lat).

Q8: Now what are the arguments for member?
A8: a is coffee, and lat is now (cdr lat), specifically (chocolate cake)

Q9: What is the next question?
A9: (null? lat)

Q10: Is (null? lat) true or false, where
     lat is (chocolate cake)
A10: nil, namely false.

Q11: What do we do now?
A11: Ask the next question.

Q12: What is the next question?
A12: t.

Q13: What is t?
A13: t, namely true.

Q14: What is the meaning of
      (or
        (eq? (car lat) a)
	(member? a (cdr lat)))
A14: (or (eq? (car lat) a) (member? a (cdr lat))) finds out if a is eq? to the
car of lat or if a is a member of the cdr of lat by referring to the funciton.

Q15: Is a eq? to the car of lat?
A15: No, because a is coffee and the car of lat is chocolate.

Q16: Now, what are the arguments of member?
A16: a is coffee, and lat is (cake).

Q17: What is the next question?
A17: (null? lat)

Q18: What do we do now?
A18: Ask the next question, since (null? lat) is false.

Q19: What is the next question?
A19: t

Q20: What is the value of
      (or
        (eq? (car lat) a)
	(member? a (cdr lat)))
A20: The value of (member? a (cdr lat))

Q21: Why?
A21: Because (eq? (car lat) a) is false.

Q22: What do we do now?
A22: Recur - refer to the function with new arguments.

Q23: What are the new arguments?
A23: a is coffee, and lat is ()

Q24: What is the next question?
A24: (null? lat)

Q25: Is (null? lat) true or false
     where
       lat is ()
A25: true. So the value of ((null? lat) nil) is nil - namely false.

Q26: What is the value of (member? a lat)
     where a is coffee, and lat is ()
A26: false

Q27: What is the value of
     (or
       (eq? (car lat) a)
       (member? a (cdr lat)))
     where a is coffee, and lat is (cake)
A27: false

Q28: What is the value of (member? a lat)
     where a is coffee, and lat is (cake)
A28: false

Q29: What is the value of
     (or
       (eq? (car lat) a)
       (member? a (cdr lat)))
     where a is coffee, and lat is (chocolate cake)
A29: false

Q30: What is the value of (member? a lat)
     where a is coffee, and lat is (chocolate cake)
A30: false

Q31: What is the value of
     (or
       (eq? (car lat) a)
       (member? a (cdr lat)))
     where a is coffee, and lat is (german chocolate cake)
A31: false

Q32: What is the value of (member? a lat)
     where a is coffee, and lat is (german chocolate cake)
A32: false



The value of (member? a2 l2) is true, where a2 is seed, l2 is (poppy seed cake).

Q1: What is the first question?
A1: (null? lat)

Q2: What is the meaning of the line
    ((null? lat) nil)
A2: (null? lat) asks if lat is null list. If it is, the value is nil. If it is
not, we ask the next question. In this case, it is not null, so we ask the next
question.

Q3: What is the next question?
A3: t

Q4: t
A4: t

Q5: What is the value of the line
    (or
      (eq? (car lat) a)
      (member? a (cdr lat)))
A5: The value is (member? a (cdr lat)). Because (car lat) is poppy, and a is 
seed. So we ask the second question for (or  ) with new arguments.

Q6: What is the value of (null? lat)
    where lat is (seed cake)
A6: false. So we ask the next question.

Q7: t
A7: t

Q8: What is the value of the line
    (or
      (eq? (car lat) a)
      (member? a (cdr lat)))
    where a is seed, lat is (seed cake)
A8: The value is t. Because (car lat) eq? to seed.

Q9: What is the value of (member? a lat)
    where a is seed, lat is (seed cake)
A9: t

Q10: What is the value of the line
     (or
       (eq? (car lat) a)
       (member? a (cdr lat)))
     where a is seed, lat is (poppy seed cake)
A10: t

Q11: What is the value of (member? a lat)
     where a is seed, lat is (poppy seed cake)
A11: t - namely true.
   
```
###2.4 Most Lisp dialects have an (if     ) form. In general an (if     ) form looks like this###
              (if aexp bexp cexp)
        when aexp is true, (if aexp bexp cexp) is bexp; when it is false, (if aexp bexp cexp) is cexp
        example,
          (cond
            ((null? l) nil)
            (t (or
                 (eq? (car l) a)
                 (member? a (cdr l)))))
        in member? can be replaced by:
          (if (null? l)
              nil
              (or
                (eq? (car l) a)
                (member? a (cdr l))))
        Rewrite all the functions in the chapter using (if     ) instead of (cond     )
```lisp
Function lat?:
(define lat?
  (lambda (l)
    (if (null? l)
        t
        (if (atom? (car l))
            (lat? (cdr l))
            nil))))
        
Function member?:
(define member?
  (lambda (a lat)
    (if (null? lat)
        nil
        (or
          (eq? (car lat) a)
          (member? a (cdr lat))))))
```
###2.5 Write the function nonlat? which determines whether a list is the empty list or does not contain atomic S-expressions###
    Example: (nonlat? l1) is false,
             (nonlat? l2) is false,
             (nonlat? l3) is false,
             (nonlat? l4) is true
```lisp
(define nonlat?
  (lambda (l)
    (cond
      ((null? l) t)
      ((atom? (car l)) nil)
      (t (nonlat? (cdr l))))))
```

###2.6 Write a function member-cake? which determines whether a lat contains the  atom cake###
    Example: (member-cake? l1) is true,
             (member-cake? l2) is true,
	     (member-cake? l5) is false.
```lisp
(define member-cake?
  (lambda (l)
    (cond
      ((null? l) nil)
      (t (or
           (eq? cake (car l))
	   (member-cake? (cdr l)))))))
```

###2.7 Consider the following new definition of member?###
```lisp
(define member2?
  (lambda (a lat))
    (cond
      ((null? lat) nil)
      (t (or
           (member2? a (cdr lat))
	   (eq? a (car lat))))))
Do (member2? a l) and (member? a l) give the same answer when we use the same arguments?
Consider the examples a1 and l1, a1 and l2, and a2 and l2
```
```lisp
(member2? a1 l1) is false
(member2? a1 l2) is false
(member2? a2 l2) is true

(member? a1 l1) is false
(member? a1 l2) is false
(member? a2 l2) is true

Yes, (member2 a l) and (member? a l) give the same answer when  we use the same arguments.
```

##2.8 Step through the applications (member? a3 l2) and (member2? a3 l2). Compare the steps of the two applications###

```lisp
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) nil)
      (t (or
           (eq? (car lat) a)
	   (member? a (cdr lat)))))))
What is the value of (member? a3 l2)
where
  a3 is poppy, and
  l2 is (poppy seed cake)

Q1: What is the first question asked by
     (member? a3 l2)
A1: (null? l2)

Q2: What is the meaning of the line
     ((null? l2) nil)
    where
     l2 is (poppy seed cake)
A2: (null? l2) asks if l2 is the null list. If it is, then the value is nil,
since the atom poppy was not found in l2. If not, then we ask the next question.
In this case, it is not null, so we ask the next question.

Q3: What is the next question?
A3: t

Q4: What is the meaing of the line
    (t (or
         (eq? (car l2)  a3)
	 (member? a3 (cdr l2))))
A4: Now that we know that l2 is not null?, we have to find out whether the car
of l2 is the same atom as a3, or whether a3 is somewhere in the rest of the l2.
The question
    (or
      (eq? (car l2) a3)
      (member? a3 (cdr l2)))
does this.

Q5: Is
      (or
        (eq? (car l2) a3)
	(member? a3 (cdr l2)))
true or false, where
   a3 is poppy, and
   l2 is (poppy seed cake)
A5: We will find out by looking at each question in turn.

Q6: Is (eq? (car l2) a3) true or false
where a3 is poppy
and
  l2 is (poppy seed cake)
A6: True,
      because poppy is eq? to poppy, the car of
      (poppy seed cake). Therefore, (or  ..) answers with t.

Q7: What is the value of the applicaton
     (member? a3 (cdr l2))
    where
      a3 is poppy, and
      l2 is (poppy seed cake)
A7: t,
      because we have found that poppy is a member of (poppy seed cake).

(define member2?
  (lambda (a lat)
    (cond
      ((null? lat) nil)
      (t (or
           (member2? a (cdr lat))
	   (eq? a (car lat)))))))
What is the value of (member2? a3 l2)
where
  a3 is poppy, and
  l2 is (poppy seed cake)

Q1: What is first question asked by
     (member2? a3 l2)
A1: (null? l2)

Q2: What is the meaning of the line
     ((null? l2) nil)
    where
     l2 is (poppy seed cake)
A2: (null? l2) asks if l2 is the null list. If it is, then the value is nil,
since the atom poppy was not found in l2. If not, then we ask the next question.
In this case, it is not null, so we ask the next question.

Q3: What is the next question?
A3: t

Q4: What is the meaing of the line
    (t (or
	 (member2? a3 (cdr l2))))
         (eq? a3 (car l2))
A4: Now that we know that l2 is not null?, we have to find out whether a3 is
somewhere in the rest of the l2, or whether the car of l2 is the same atom as a3.
The question
    (or
      (member2? a3 (cdr l2)))
      (eq? a3 (car l2))
does this.

Q5: Is
      (or
	(member2? a3 (cdr l2)))
        (eq? a3 (car l2))
true or false, where
   a3 is poppy, and
   l2 is (poppy seed cake)
A5: We will find out by looking at each question in turn.

Q6: Is (member2? a3 (cdr l2)) true or false,
where
  a3 is poppy, and
  l2 is (poppy seed cake)
A6: We will find out by referring to the function with the argument l2 replaced
by (cdr l2).

Q7: Now what are the arguments for member2?
A7: a3 is poppy, and l2 is now (cdr l2), specifically (seed cake).

Q8: What is the next question?
A8: (null? l2)

Q9: Is (null? l2) true or false, where
    l2 is (seed cake)
A9: nil, namely false.

Q10: What do we do now?
A10: Ask the next question.

Q11: What is the next question?
A11: t

Q12: What is t?
A12: t, namely true

Q13: What is the meaning of
      (or
        (member2? a3 (cdr l2))
	(eq? a3 (car l2)))
A13: (or (member2? a3 (cdr l2)) (eq? a3 (car l2))) finds out if a3 is a member
of the cdr of l2 by referring to the function

Q14: What next?
A14: Recur with a3 and (cdr l2), where a3 is poppy and (cdr l2) is (cake)

Q15: (null? l2)
A15: NO. Move to the next line.

Q16: t
A16: Yes. Recur with a3 and (cdr l2), where a3 is poppy, and (cdr l2) is ()

Q17: (null? l2)
A17: Yes, therefore (member2? a3 (cdr l2)) where a3 is poppy, 
and (cdr l2) is () answers nil, namely false.

Q18: What next?
A18: (member2? a3 (cdr l2)) where a3 is poppy, and (cdr l2) is () answers false,
so we ask the next question, (eq? a3 (car l2)).

Q19: What is the value of the line
      (eq? a3 (car l2))
     where
      a3 is poppy, and
      l2 is cake
A19: nil

Q20: What next?
A20: (member2? a3 (cdr l2)) where a3 is poppy, and (cdr l2) is (cake) answers false,
so we ask the next question, (eq? a3 (car l2)).

Q21: What is the value of the line
      (eq? a3 (car l2))
     where
      a3 is poppy, and
      l2 is (seed cake)
A21: nil

Q22: What next?
A22: (member2? a3 (cdr l2)) where a3 is poppy, and (cdr l2) is (seed cake) answers false,
so we ask the next question, (eq? a3 (car l2)).

Q23: What is the value of the line
      (eq? a3 (car l2))
     where
      a3 is poppy, and
      l2 is (poppy seed cake)
A23: t

Q24: What next?
Q24: Now, we return to the original question, (member2? a3 l2) answers true.

```

###2.9 What happens when you step throught (member? a2 l3)? Fix this problem by having member? ignore list###

```lisp
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) nil)
      (t (or
           (eq? (car lat) a)
	   (member? a (cdr lat)))))))

What is the value of the line
 (member? a2 l3)
where
 a2 is seed, and
 l3 is ((linzer) (torte) ())

Q1: What is the first question asked by
     (member? a2 l3)
A1: (null? l3)

Q2: What is the meaning of the line
     ((null? l3) nil)
    where l3 is ((linzer) (torte) ())
A2: (null? l3) asks if l3 is the null list. If it is, then the value is nil, 
since the atom seed was not found in l3. If it is not, we ask the next question.
In this case, l3 is not null list, so we ask the next question.

Q3: What is the next question?
A3: t

Q4: t
A4: t

Q5: What is the meaning of the line
     (or
       (eq? (car l3) a2)
       (member? a2 (cdr l3)))
    where a2 is seed, and l3 is ((linzer) (torte) ())
A5: It finds out whether a2 is eq? to (car l3), or whether a2 is somewhere in the
rest of l3.

Q6: (eq? (car l3) a2), where (car l3) is (linzer), and a2 is seed.
A6: Oops, (linzer) is list, and a2 is atom. Refer to The Law of Eq?, each argument
must be an atom, so it is no answer.

Fix:
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) nil)
      (atom? (car lat) (eq? (car lat) a))
      (t (member? a (cdr lat))))))
                         
```

###2.10 The function member? tells whether some atom appears at least once in a lat. Write a function member-twice? which tells whether some atom appears at least twice in a list###

```lisp
(define member-twice?
  (lambda (a lat)
    (cond
      ((null? lat) nil)
      ((member? a lat) (member? a (cdr lat)))
      (t nil))))
```
