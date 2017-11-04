$ title Machines Problem
* Samuel Ryan
* ESE 504
* Homework 3, Question 1

Sets
         i   products   / p1, p2, p3, p4 /
         j   machines   / m1, m2 /

Parameters
       profit(i)  profit for good i
         /    p1     10
              p2     12
              p3     17
              p4     8 /

       space(i)   floor space that good i takes
         /    p1     0.1
              p2     0.15
              p3     0.5
              p4     0.05 /

       max(j)  max time in machine j
         /    m1     1995
              m2     1953  /

Scalar MAX_SPACE max time of labor  /50/ ;

Table  t(i,j)  time to produce good i on machine j
                m1      m2
    p1          10      27
    p2          12      19
    p3          13      33
    p4          8       23     ;

Variables
     x(i,j)  number of each good i to produce on machine j
     z       total profit ;

Positive Variables
         x;

Equations
     objective          maximize profit!
     timeCon(j)         cannot go over time limit for given machine
     spaceCon           can't exceed space limits (50)
     percentCon1        p3 relationship to p2
     percentCon2        p3 relationship to p2   part 2  ;

objective ..     z  =e=  sum((j), sum (i, profit(i) * x(i,j))) ;                   a

* Constraints
timeCon(j) ..    sum(i, (t(i,j) * x(i,j)))  =l=  max(j) ;
spaceCon ..      sum((j), sum (i, space(i) * x(i,j))) =l= MAX_SPACE ;

* See PDF writeup of my homework for more info on these!
percentCon1 ..   sum(j, (2*(x('p2',j) + 0.1*x('p2',j)))) - sum(j, (x('p3',j))) =g= 0 ;
percentCon2 ..   sum(j, (2*(x('p2',j) - 0.1*x('p2',j)))) - sum(j, (x('p3',j))) =l= 0 ;


* Solve using CPLEX!
Model bakery /all/ ;
option LP = cplex;
Solve bakery using LP maximizing z ;
