$ title hw1p2
$ ontext
Sam Ryan
ESE 504
Problem 2, HWK1
$ offtext

Sets
         t   time / 1 * 60 /

Scalar RATE monthly interest /.0025/ ;

Free Variables
         z total payback;

Positive Variables
         x(t) interest paid at month t
         y(t) principal paid back at month t
         p    monthly rate
         r(t) amount remaining at time t;

Equations
         EQOBJ           obj fun
         EQMonthly(t)    x(t) + y(t) = p
         EQTotal         must pay back 5000
         EQR0(t)         r0 =5000
         EQRemaning(t)   amount remaining at end of month
         EQInterest(t)   interestRate must match monthly;



* Objective Function
EQOBJ            .. z  =e= (60*p);

* Constraints
EQTotal                          .. sum(t, y(t))           =e= 5000   ;
EQMonthly(t)                     .. x(t) + y(t)            =e= p      ;
EQR0(t) $ (ord(t) eq 1)          .. r(t)                   =e= 5000   ;
EQRemaning(t) $ (ord(t) gt 1)    .. r(t-1) - y(t-1)        =e= r(t)   ;
EQInterest(t)                    .. RATE * r(t)            =e= x(t)   ;

Model myModel /all/ ;
option LP = CPLEX;
Solve myModel using LP minimizing z ;
