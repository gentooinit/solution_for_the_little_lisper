###1.1 Think of ten different atoms and write them down.###
```lisp
cat, dog, neko, 007, MP3, x-ray, 7days, #3.14, @address, ?mark?
```
###1.2 Using the atoms of Exercise 1.1, make up twenty different lists.###
```lsip
(cat), (cat dog), ((cat) dog), (neko (007)), ((x-ray)), (MP3 ((x-ray)), ((7days) (#3.14)), 
((7days #3.14) @address),((7days #3.14) (?mark?)), (((7days) #3.14) (?mark?)), (((cat))), 
(neko neko), ((cat) ((cat))), ((cat neko (dog))), (dog (cat) ((neko))), (((dog) cat) neko), 
((((007)))), ((((007)) MP3)), ((((007) MP3))), ((MP3) (#3.14 (neko (cat) dog)))
```

###1.3 The list (all these problems) can be constructed by (cons a (cons b (cons c d)))###

                                       a is all,
                                       b is these,
                                       c is problems, and
                                       d is ()
                                       
Write down how you would construct the following lists:

                                  (all (these problems))
                                  (all (these) problems)
                                  ((all these) problems)
                                  ((all these problems))
                                  
```lisp
(all (these problems)) can be constructed by (cons a (cons (cons b (cons c d)) d))
(all (these) problems) can be constructed by (cons a (cons (cons b d) (cons c d)))
((all these) problems) can be constructed by (cons (cons a (cons b d)) (cons c d))
((all these problems)) can be constructed by (cons (cons a (cons b (cons c d))) d)
```

###1.4 What is (car (cons a l)), where a is french, and l is (fries), and what is (cdr (cons a l)), where a is oranges, and l is (apples and peaches)?###

```lisp
(car (cons a l)) is french which is a, where a is french, and l is (fries).
(cdr (cons a l)) is (apples and peaches) which is l, where a is oranges, and l is (apples and peaches).
```

###1.5 Find an atom x that makes (eq? x y) true, where y is lisp. Are there any?###

```lisp
x is lisp
```

###1.6 If a is atom, is there a list l that make (null? (cons a l)) true?###

```lisp
No, because (cons a l) is a list which contains at least an atom a.
```

###1.7###
 Determine the value of  
                            (cons s l), where s is x, and l is y  
                            (cons s l), where s is (), and l is ()  
                               (car s), where s is ()  
                               (cdr l), where l is (())

```lisp
1. No answer, l is an atom
2. (())
3. No answer. You can not ask for the car of null list.
4. ()
```
                               
True or false,  
                            (atom? (car l)), where l is ((meatballs) and spaghetti)  
                            (null? (cdr l)), where l is ((meatballs))  
                (eq? (car l) (car (cdr l))), where l is (two meatballs)  
                       (atom? (cons a l)), where l is (ball) and a is meat
```lisp
1. False. Because (car l) is (meatballs), so (meatballs) is a list.
2. True. Because (cdr l) is (), (null? ()) is True
3. False. Because (car l) is two, (cdr l) is (meatballs), (car (cdr l)) is meatballs, so two is not equals to meatballs.
4. False. Because (cons a l) is (meat ball) that is a list.
```
What is

    (car (cdr (cdr (car l)))) where l is ((kiwis mangoes lemons) and (more))
    (car (cdr (car (cdr l)))) where l is (() (eggs and (bacon)) (for) (breakfast)) 
    (car (cdr (cdr (cdr l)))) where l is (() () () (and (coffee)) please)
```lisp
1. lemons
2. and
3. (and (coffee))
```
    
To get the atom and in (peanut butter and jelly on toast) we can write (car (cdr (cdr (peanut butter and jelly on toast))))  
What would you write to get.

            Harry in l, where l is (apples in (Harry has a backyard))
                        where l is (apples and Harry)
                        where l is (((apples) and ((Harry))) in his backyard)
                        
```lisp
1. (car (car (cdr (cdr l))))
2. (car (cdr (cdr l)))
3. (car (car (car (cdr (cdr (car l))))))
```
          
