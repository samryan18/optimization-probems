$ title Detroit Car Problem

* Samuel Ryan
* ESE 504
* Project 1
* Detroit Car Problem
* Determining how many cars to produce

Sets
         i   cars   / seeker, cruiser /

Parameters
       alternate_profit(i)  profit for car i
         /    seeker     2800
              cruiser    5400    /

       alternate_labor_hours(i) number of labor hours required to produce car i
         /    seeker     7.5
              cruiser    10.5    /

       demand(i) demand for car i
         /    seeker     INF
              cruiser    3500    /

       additional_demand(i) extra demand for car i from campaign
         /    seeker     0
              cruiser    700    /

       num_doors(i) number of doors on car i
         /    seeker     4
              cruiser    2    /;

Scalar AVAILABLE_LABOR max amount of monthly labor  / 48000 / ;
Scalar ADDITIONAL_LABOR max amount of monthly labor  / 12000 / ;
Scalar CAMPAIGN_PRICE price of campaign  / 500000 / ;
Scalar OVERTIME_PRICE additional price of overtime labor  / 1600000 / ;
Scalar AVAILABLE_DOORS number of doors available / 20000 / ;

Variables
     x(i)       number of car i to produce
     campaign   whether to pursue the advertising campaign
     overtime   whether to pursue overtime labor
     z          total profit ;

Positive Variables
     x;

Binary Variables
     campaign
     overtime;

Equations
     objective          maximize profit!
     demandCon(i)       cannot go over time limit for given machine
     laborCon           cannot exceed total labor hours
     doorsCon           cannot exceed total available number of doors ;

* Objective Function
objective
.. z  =e=  sum(i, x(i) * alternate_profit(i))
         - (campaign * CAMPAIGN_PRICE)
         - (overtime * OVERTIME_PRICE);

* Constraints
demandCon(i)
..       x(i)  =l=
         demand(i) + (campaign * additional_demand(i));
laborCon
..       sum(i, alternate_labor_hours(i) * x(i)) =l=
         AVAILABLE_LABOR + (overtime * ADDITIONAL_LABOR) ;
doorsCon
..       sum(i, num_doors(i)   * x(i)) =l= AVAILABLE_DOORS;

* Solve using CPLEX!
Model cars /all/ ;
option MIP = cplex;
Solve cars using MIP maximizing z ;
