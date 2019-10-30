# jkiss

jkiss is a PRNG based on the work of David Jones. I was introduced to it through [this paper](http://www0.cs.ucl.ac.uk/staff/d.jones/GoodPracticeRNG.pdf). jkiss is great because it passes a whole battery of statistical tests for randomness, it's extremely fast, and it can be implemented in languages that have a hard time with unsigned ints (like Fortran), plus it can be implemented without any multiplication.

this scheme implementation is still in progress, but it is stateless and makes use of some great features of lisp, namely streams. 
