##The Law of Car##
Car is defined only for non-null lists.

##The Law of Cdr##
Cdr is defined only for non-null lists.
The cdr of any non-null list is always another list.

##The Law of Cons##
Cons takes two arguments.
The second argument of cons must be a list. The result is a list.

##The Law of Null?##
Null? is defined only for lists.

##The Law of Eq?##
Eq? takes two arugments. Each must be an atom.

##The First Commandment##
Always ask null? as the first question in expressing any function.

##The Second Commandment##
Use cons to build lists.

##The Third Commandment##
When building a list, describe the first typical element,
and then cons it onto the natural recursion.

##The Fourth Commandment##
>(preliminary)

When recurring on a list of atoms, *lat*, or a vec, *vec*, ask
two questions about them, and use *(cdr lat)* or *(cdr vec)* for the natural recursion.

When recurring on a number, *n*, ask two questions, and use *(sub1 n)* for the natural recursion.

##The Fifth Commandment##
When building a value with +, always use 0 for the value of the terminating line, for adding 0 does not change the value of an addition.

When building a value with *, always use 1 for the value of the terminating line, for multiplying by 1 does not change the value of a multiplication.

When building a value with cons, always consider () for the value of the terminating line.

##The Sixth Commandment##
Always change at least one argument while recurring.
The Changing argument(s) should be tested in the termination condition(s) and it should be changed to be closer to termination. For example:
    When using cdr, test termination with null?
    When using sub1, test termination with zero?

##The Seventh Commandment##
Simplify only after the function is correct.

##The Eighth Commandment##
Recur on all the *subparts* that are of the same nature:
* On all the sublists of a list.
* On all the subexpressions of a representation of an arithmetic expression.

##The Ninth Commandment##
Use help functions to abstract from representations.

##The Tenth Commandment##
Abstract functions with common structures into a single function.
