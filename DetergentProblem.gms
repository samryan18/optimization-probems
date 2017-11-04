$ title NaturWash Problem

* Samuel Ryan
* ESE 504
* Homework 5, Question 1

Scalar MAX_DETERGENT max time of labor  / 120000 / ;
Scalar MAX_NPW max time of labor  / 10000 / ;

Variables
     NP  NPW purchased
     NS  NPW produced for sale
     ND  NPW produced for detergent
     DS  detergent sold
     z   total profit ;

Positive Variables
     NP, NS, ND, DS;

Equations
     objective          maximize profit!

     NPWCon             cant prodcue more than 10K units NPW
     DETERGGENTCon      cant produce more than 120K units detergent
     NPWCon2            must have enough NPW to produce detergent ;

objective ..     z  =e=  (0.7*DS - 0.6*DS) + 0.8*NS - 1.2*NP - 0.5*(NS+ND) ;

* Constraints
NPWCon ..           NS + ND  =l=  MAX_NPW           ;
DETERGGENTCon ..    DS       =l=  MAX_DETERGENT     ;
NPWCon2 ..          0.1 * DS =e=  (ND + NP)    ;

* Solve using CPLEX!
Model wash /all/ ;
option LP = cplex;
Solve wash using LP maximizing z ;
