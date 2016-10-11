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

###3.2 Write the function dupla of a and l which makes a new lat containing as many a's as there are elements in l###
```lisp
Example: (dupla a2 l4) is (hot hot hot)
         (dupla a2 l2) is ()
         (dupla a1 l5) is (chili chili chili chili chili)
```
```lisp
(define dupla
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      (t (cons a (dupla a (cdr l)))))))
```

###3.3 Write the function double of a and l which is a converse to rember The function doubles the first a in l instead of removing it###
```lisp
Example: (double a2 l2) is ()
         (double a1 l3) is (cincinnati chili chili)
         (double a2 l4) is (texas hot hot chili)
```
```lisp
(define double
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((eq? a (car l)) (cons a l))
      (t (cons (car l) (double a (cdr l)))))))
```

###3.4 Write the function subst sauce of a and l which substitutes a for the first atom sauce in l###
```lisp
Example: (subst-sauce a1 l4) is (texas hot chili)
         (subst-sauce a1 l5) is (soy chili and tomato sauce)
         (subst-sauce a4 l2) is ()
```
```lisp
(define subst-sauce
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((eq? (quote sauce) (car l)) (cons a (cdr l)))
      (t (cons (car l) (subst-sauce a (cdr l)))))))
```
###3.5 Write the function subst3 of new, o1, o2, o3 and lat which -like subst2- replaces the first occurrence of either o1, o2, or o3 in lat by new###
```lisp
Example: (subst3 a5 a1 a2 a4 l5) is (soy soy and tomato sauce)
         (subst3 a4 a1 a2 a3 l4) is (texas sauce chili)
         (subst3 a3 a1 a2 a5 l2) is ()
```
```lisp
(define subst3
  (lambda (new o1 o2 o3 lat)
    (cond
      ((null? lat) (quote ()))
      ((or
        (eq? (car lat) o1)
        (eq? (car lat) o2)
        (eq? (car lat) o3))
           (cons new (cdr lat)))
      (t (cons (car lat)
           (subst3 new o1 o2 o3 (cdr lat)))))))
```

###3.6 Write the function substN of new, slat and lat which replaces the first atom in lat that also occurs in slat by the atom new###
```lisp
Example: (substN a2 l3 l4) is (texas hot hot)
         (substN a4 l3 l5) is (soy sauce and tomato sauce)
         (substN a4 l3 l2) is ()
```
```lisp
(define substN
  (lambda (new slat lat)
    (cond
      ((null? lat) (quote ()))
      ((member? (car lat) slat) (cons new (cdr lat)))
      (t (cons (car lat)
           (substN new slat (cdr lat)))))))
```

###3.7 Step through the application (rember a4 l5). Also step through (insertR a5 a2 l5) for the "bad" definitions of insertR###
```lisp
(define rember
   (lambda (a lat)
     (cond
       ((null? lat) (quote ()))
       ((eq? (car lat) a) (cdr lat))
       (t (cons (car lat)
            (rember a (cdr lat)))))))

What is the value of (rember a4 l5)
where a4 is sauce, and
      l5 is (soy sauce and tomato sauce)

Q1: What is the first question?
A1: (null? l5)

Q2: What do we do now?
A2: Move to the next line and ask the next question.

Q3: (eq? (car l5) a4)
A3: No, so we move to the next question.

Q4: t
A4: t

Q5: What is the meaning of
    (cons (car l5)
     (rember a4 (cdr l5)))
    where
      a4 is sauce,
    and
      l5 is (soy sauce and tomato sauce)
A5: It says to cons the car of l5 -soy- onto the value of
    (rember a4 (cdr l5))
But since we don't know the value of (rember a4 (cdr l5)) yet, we must find it
before we can cons (car l5) onto it.
   
Q6: What is the meaning of (rember a4 (cdr l5))
A6: This refers to the function with l5 replaced by (cdr l5) -(sauce and tomato sauce).

Q7: (null? l5)
A7: No, so we move to the next question.

Q8: (eq? (car l5) a4)
A8: Yes, so the value is (cdr l5). In this case, it is the list
    (and tomato sauce)

Q9: Are we finished?
A9: Certainly not! We know what (rember a4 l5) is when l5 is (sauce and tomato sauce),
but we don't yet know what it is when l5 is (soy sauce and tomato sauce).

Q10: We now have a value for (rember a4 (cdr l5))
     where a4 is sauce,
     and
       (cdr l5) is (sauce and tomato sauce)
This value is (and tomato sauce)
What next?
A10: Recall that we wanted to cons soy onto the value of (rember a4 (cdr l5))
where
  a4 was sauce and (cdr l5) was (sauce and tomato sauce).
Now that we have this value, which is (and tomato sauce), we can cons soy onto it.

Q11: What is the result when we cons soy onto (and tomato sauce)
A11: (soy and tomato sauce)

Q12: What does (soy and tomato sauce) represent?
A12: It represents the value of
     (cons (car l5)
       (rember a4 (cdr l5))),
     when
       l5 is (soy sauce and tomato sauce)
     and
       (rember a4 (cdr l5)) is (and tomato sauce)

Q13: Are we finished yet?
A13: Yes.

First bad definition of insertR:
(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (t (cond
           ((eq? (car lat) old) (cdr lat))
	   (t (cons (car lat)
	        (insertR
		  new old (cdr lat)))))))))

What is the value of (insertR a5 a2 l5) 
where a5 is soy, a2 is hot and
      l5 is (soy sauce and tomato sauce)

Q1: What is the first question?
A1: (null? l5)

Q2: What do we do now?
A2: Move to the next line and ask the next question.

Q3: t
A3: Of course.

Q4: What do we do now?
A4: We ask question by (cond ...)

Q5: (eq? (car l5) a2) 
A5: No, because (car l5) is soy, a2 is hot. So we move to the next question.

Q6: t
A6: t

Q7: What is the meaning of
    (cons (car l5)
      (insertR
         a5 a2 (cdr l5)))
where a5 is soy, a2 is hot and
      l5 is (soy sauce and tomato sauce)

A7: It says to cons the car of l5 -say- onto the value of
(insertR a5 a2 (cdr l5)).
But since we don't know the value of (insertR a5 a2 (cdr l5)) yet, we must find
it before we can cons onto (car l5).

Q8: What is the meaning of (insertR a5 a2 (cdr l5))?
A8: This refers to the function with l5 replaced by (cdr l5) -(sauce and tomato sauce)

Q9: (null? l5)
A9: No, so we move to the next question.

Q10: t
A10: t

Q11: (eq? (car l5) a2)
A11: No, bacause (car l5) is sauce, a2 is hot. So we move to the next question.

Q12: t
A12: t

Q13: What is meaning of
     (cons (car l5)
       (insertR
          a5 a2 (cdr l5)))
where a5 is soy, a2 is hot and
      l5 is (sauce and tomato sauce)

A13: It says to cons the car of l5 -sauce- onto the value of
(insertR a5 a2 (cdr l5)).
But since we don't know the value of (insertR a5 a2 (cdr l5)) yet, we must find
it before we can cons onto (car l5).

Q14: What is the meaning of (insertR a5 a2 (cdr l5))?
A14: This refers to the function with l5 replaced by (cdr l5) -(and tomato sauce)

Q15: (null? l5)
A15: No, so we move to the next question.

Q16: t
A16: t

Q17: (eq? (car l5) a2)
A17: No, because (car l5) is and, a2 is hot. So we move to the next question.

Q18: t
A18: t

Q19: What is meaning of
     (cons (car l5)
       (insertR
          a5 a2 (cdr l5)))
where a5 is soy, a2 is hot and
      l5 is (and tomato sauce)

A19: It says to cons the car of l5 -and- onto the value of
(insertR a5 a2 (cdr l5)).
But since we don't know the value of (insertR a5 a2 (cdr l5)) yet, we must find
it before we can cons onto (car l5).

Q20: What is the meaning of (insertR a5 a2 (cdr l5))?
A20: This refers to the function with l5 replaced by (cdr l5) -(tomato sauce)

Q21: (null? l5)
A21: No, so we move to the next question.

Q22: t
A22: t

Q23: (eq? (car l5) a2)
A23: No, because (car l5) is tomato, a2 is hot. So we move to the next question.

Q24: t
A24: t

Q25: What is the meaning of
     (cons (car l5)
       (insertR
          a5 a2 (cdr l5)))
where a5 is soy, a2 is hot and
      l5 is (tomato sauce)

A25: It says to cons the car of l5 -tomato- onto the value of
(insertR a5 a2 (cdr l5)).
But since we don't know the value of (insertR a5 a2 (cdr l5)) yet, we must find
it before we can cons onto (car l5).

Q26: What is the meaning of (insertR a5 a2 (cdr l5))?
A26: This refers to the function with l5 replaced by (cdr l5) -(sauce)

Q27: (null? l5)
A27: No, so we move the next question.

Q28: t
A28: t

Q29: (eq? (car l5) a2)
A29: No, because (car l5) is sauce, a2 is hot. So we move the next question.

Q30: t
A30: t

Q31: What is the meaning of
     (cons (car l5)
       (insertR
          a5 a2 (cdr l5)))
where a5 is soy, a2 is hot and
      l5 is (sauce)

A31: It says to cons the car of l5 -sauce- onto the value of
(insertR a5 a2 (cdr l5)).
But since we don't know the value of (insertR a5 a2 (cdr l5)) yet, we must find
it before we can cons onto (car l5).

Q32: What is the meaning of (insertR a5 a2 (cdr l5))?
A32: This refers to the function with l5 replaced by (cdr l5) -()

Q33: (null? l5)
A33: t, so the value of
	(insertR a5 a2 l5),
where a5 is soy, a2 is hot and
      l5 is ()
     is ().

Q34: Are we done yet?
A34: Certainly not. We know what (insertR a5 a2 l5) is when l5 is ().
But we don't yet know what it is when l5 is (sauce).

Q35: We now have a value of (insertR a5 a2 (cdr l5))
     where a5 is soy, a2 is hot and l5 is (sauce).
This value is (). What next?

A35: Recall that we wanted to cons sauce onto the value of (insertR a5 a2 (cdr l5))
where a5 is soy, a2 is hot and (cdr l5) was ().
Now that we have this value, which is (), we can cons sauce onto it.

Q36: What is the result when we cons sauce onto ()
A36: (sauce)

Q37: What does (sauce) represent?
A37: It represents the value of 
     (cons (car l5)
       (insertR
          a5 a2 (cdr l5))),
     when l5 is (sauce)
     and (insertR a5 a2 (cdr l5)) is ()

Q38: Are we finished?
A38: Not quite. We know what (insertR a5 a2 l5) is  when l5 is (sauce).
But we don't yet know what it is when l5 is (tomato sauce)

Q39: We now have a value of (insertR a5 a2 (cdr l5))
     where a5 is soy, a2 is hot and l5 is (





Second bad definition of insertR:
(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (t (cond
           ((eq? (car lat) old)
	    (cons new (cdr lat)))
	   (t (cons (car lat)
	        (insertR
		  new old (cdr lat)))))))))

What is the value of (insertR a5 a2 l5) 
where a5 is soy, a2 is hot and
      l5 is (soy sauce and tomato sauce)
```

