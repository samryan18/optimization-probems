$ title XYZ

* Samuel Ryan
* ESE 504
* HW 7 Q1
* XYZ Corporation
* November 2, 2017

Sets
       i   product   / product1, product2, product3 /


Parameters
       labor(i)  labor hours for product i
         /    product1     4
              product2     10
              product3     7  /
       machine(i)  machine hours for product i
         /    product1     3
              product2     4
              product3     6  /
       cost(i)  machine hours for product i
         /    product1     5
              product2     12
              product3     9  /;

Scalar MAX_MACHINE       max time for machines  /150/ ;
Scalar MAX_LABOR         max time of labor      /280/ ;


Variables
     p(i)  price of item i
     x(i)  number of item i sold
     z     total profit ;

Positive variables price, x ;

Equations
     profit             define objective function
     laborEQ            cannot exceed labor max
     machineEQ          cannot exceed machine max
     Sales1Con          determining sales amounts
     Sales2Con
     Sales3Con;

profit ..        z  =e=  sum(i, ((p(i)-cost(i)) * x(i))) ;

laborEQ ..       sum(i, (x(i) * labor(i)))                  =l=  MAX_LABOR   ;
machineEQ ..     sum(i, (x(i) * machine(i)))                =l=  MAX_MACHINE ;
Sales1Con ..     18 - p('product1')                         =e= x('product1');
Sales2Con ..     9 + (1/3)*p('product1') - p('product2')    =e= x('product2');
Sales3Con ..     13 - p('product3')                         =e= x('product3');

Model XYZ /all/ ;
option NLP = CONOPT;
* option LP = cplex;
Solve XYZ using NLP maximizing z ;
