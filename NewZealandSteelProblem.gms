$ title New Zealand Steel Problem

* Samuel Ryan
* ESE 504
* Homework 4, Question 1

Sets
         i   resources   / pigiron1, pigiron2, fsilicon1, fsilicon2,
                           alloy1, alloy2, alloy3, carbide,
                           steel1, steel2, steel3, oxygen /

         j   metals      / carbon, chrome, manganese, silicon /

Parameters
       cost(i)  cost per lb for resource i
         /    pigiron1       0.03
              pigiron2       0.0645
              fsilicon1      0.065
              fsilicon2      0.061
              alloy1         0.1
              alloy2         0.13
              alloy3         0.119
              carbide        0.08
              steel1         0.021
              steel2         0.02
              steel3         0.0195
              oxygen         0.02     /

       available(i)  amount available  resource i
         /    pigiron1       INF
              pigiron2       INF
              fsilicon1      INF
              fsilicon2      INF
              alloy1         INF
              alloy2         INF
              alloy3         INF
              carbide        20
              steel1         200
              steel2         200
              steel3         200
              oxygen         INF     /

       requiredMIN(j)  no less than this much of resource j
         /    carbon         0.0300
              chrome         0.0030
              manganese      0.0135
              silicon        0.0270  /

       requiredMAX(j)  no more than this much of resource j
         /    carbon         0.0350
              chrome         0.0045
              manganese      0.0165
              silicon        0.0300  /

Scalar BATCH_SIZE  size of total batch in pounds  /2000/ ;

Table  makeup(i,j)  amount of metal j in product i
             carbon     chrome    manganese   silicon
pigiron1     0.04       0.00      0.009       0.0225
pigiron2     0.00       0.10      0.045       0.15
fsilicon1    0.00       0.00      0.000       0.45
fsilicon2    0.00       0.00      0.000       0.42
alloy1       0.00       0.00      0.600       0.18
alloy2       0.00       0.20      0.090       0.30
alloy3       0.00       0.08      0.330       0.25
carbide      0.15       0.00      0.000       0.30
steel1       0.04       0.00      0.009       0.00
steel2       0.01       0.00      0.003       0.00
steel3       0.01       0.00      0.003       0.00
oxygen       -0.375     0.00      0.00        0.00     ;

Variables
     x(i)  amount of each resource i to use
     z       total cost ;

Positive Variables
     x;

Equations
     objective            minimize profit!
     totalAmountCON       must produce correct batch size
     availableCON(i)      can't exceed max amounts available
     percentMIN_CON(j)
     percentMAX_CON(j)    p3 relationship to p2   part 2  ;

* Minimize cost per pound * number of pounds used for each item
objective ..     z  =e=  sum((i),cost(i)*x(i)) ;

* Constraints
totalAmountCON ..        sum(i,x(i))-x('oxygen') =e= BATCH_SIZE ;
availableCON(i) ..       x(i) =l= available(i) ;
percentMIN_CON(j) ..     sum(i,makeup(i,j)*x(i)) =g= requiredMIN(j) * BATCH_SIZE ;
percentMAX_CON(j) ..     sum(i,makeup(i,j)*x(i)) =l= requiredMAX(j) * BATCH_SIZE ;


* Solve using CPLEX!
Model steel /all/ ;
option LP = cplex;
Solve steel using LP minimizing z ;
