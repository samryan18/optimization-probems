# GAMS
Optimization code

```GAMS
$ title Cargo Problem

* Samuel Ryan
* ESE 504
* Homework 3, Question 2

Sets
         i   compartments   / front, center, rear /
         j   cargoes   / c1, c2, c3, c4 /

Parameters
       weight(i)  weight capacity for compartment i
         /    front     10
              center    16
              rear      8  /
       volume(i)  volume capacity for compartment i
         /    front     6800
              center    8700
              rear      5300  /
       ratios(i)  ratio of total weight necessary in compartment i
         /    front     0.2941176
              center    0.4705882
              rear      0.2352941  /

       profit(j)  profit per tonne for cargo j (pounds per tonne)
         /    c1     310
              c2     380
              c3     350
              c4     285 /
       availableWeight(j)  available weight of cargo j
         /    c1     18
              c2     15
              c3     23
              c4     12 /
       volumePerUnit(j)  volume per tonne for cargo j (m^3 per tonne)
         /    c1     480
              c2     650
              c3     580
              c4     390 /


Variables
     x(i,j)  amount of cargo j in location i
     z       total profit ;

Positive Variables
     x
     total;

Equations
      objective              maximize profit!
      weightCapacityCon(i)   cant exceed weight cap
      volumeCapacityCon(i)   cant exceed volume cap
      totalWeightCon         calculating total Weight
      availabilityCon(j)     cant take more than available weight for each cargo
      ratioCon1(i)            must have appropriate ratios
      ratioCon2(i)            must have appropriate ratios;

objective ..     z  =e=  sum((i,j), (profit(j) * x(i,j))) ;

* Constraints
weightCapacityCon(i) ..  sum(j, x(i,j)) =l= weight(i);
volumeCapacityCon(i) ..  sum(j, volumePerUnit(j) * x(i,j)) =l= volume(i);
availabilityCon(j)   ..  sum(i, x(i,j)) =l= availableWeight(j);
totalWeightCon       ..  sum((i,j), x(i,j)) =e= total;
ratioCon1(i)         ..  (sum(j, x(i,j))) - (ratios(i) * total) =g= -0.00001;
ratioCon2(i)         ..  (sum(j, x(i,j))) - (ratios(i) * total) =l= 0.00001;

* Solve using CPLEX!
Model cargo /all/ ;
option LP = cplex;
Solve cargo using LP maximizing z ;
```
