1.1 Think of ten different atoms and write them down.

A: cat, dog, neko, 007, MP3, x-ray, 7days, #3.14, @address, ?mark?

1.2 Using the atoms of Exercise 1.1, make up twenty different lists.

A: (cat), (cat dog), ((cat) dog), (neko (007)), ((x-ray)), (MP3 ((x-ray)), ((7days) (#3.14)), ((7days #3.14) @address),
((7days #3.14) (?mark?)), (((7days) #3.14) (?mark?)), (((cat))), (neko neko), ((cat) ((cat))), ((cat neko (dog))), (dog (cat) ((neko))), (((dog) cat) neko), ((((007)))), ((((007)) MP3)), ((((007) MP3))), ((MP3) (#3.14 (neko (cat) dog)))

1.3 The list (all these problems) can be constructed by (cons a (cons b (cons c d)))
                                       a is all,
                                       b is these,
                                       c is problems, and
                                       d is ()
                                       
Write down how you would construct the following lists:
                                  (all (these problems))
                                  (all (these) problems)
                                  ((all these) problems)
                                  ((all these problems))
                                  
A:
(all (these problems)) can be constructed by (cons a (cons (cons b (cons c d)) d))
(all (these) problems) can be constructed by (cons a (cons (cons b d) (cons c d)))
((all these) problems) can be constructed by (cons (cons a (cons b d)) (cons c d))
((all these problems)) can be constructed by (cons (cons a (cons b (cons c d))) d)
