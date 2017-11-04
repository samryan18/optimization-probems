$ title Bakery

* Samuel Ryan
* ESE 504, Optimization Theory
* Homework 2

Sets
       i   baked goods   / cake, donut, cookie /

Parameters
       p(i)  profit for good i
         /    cake     6
              donut    2
              cookie   12  /
       oven(i)  oven use for good i
         /    cake     4
              donut    1
              cookie   3  /
       labor(i)  labor  for good i
         /    cake     2
              donut    6
              cookie   3  /;

Scalar MAX_OVEN  max time in oven  /24/ ;
Scalar MAX_LABOR max time of labor  /30/ ;


Variables
     n(i)  number of each item to produce                s
     z     total profit ;

Positive variables n ;

Equations
     profit             define objective function
     ovenEQ             observe supply limit at plant i
     laborEQ            satisfy demand at market j ;

profit ..        z  =e=  sum(i, p(i) * n(i)) ;
laborEQ ..      sum(i, (n(i) * labor(i)))  =l=  MAX_LABOR ;
ovenEQ ..       sum(i, (n(i) * oven(i)))   =l=  MAX_OVEN ;

Model bakery /all/ ;
* option LP = xa;
option LP = cplex;
* switch this line to switch solvers!

Solve bakery using LP maximizing z ;
