LoadPackage( "LRS4GAP" );

##  Wayne L. Winston: *Operations Research: Applications and Algorithms*. Duxbury
##  Press, 2003.
##  
##  Section 3.1, Example 1
##  
##  Giapetto’s Woodcarving, Inc., manufactures two types of wooden toys: soldiers
##  and trains.  A soldier sells for $27 and uses $10 worth of raw materials. Each
##  soldier that is manufactured increases Giapetto’s variable labor and overhead
##  costs by $14. A train sells for $21 and uses $9 worth of raw materials. Each
##  train built increases Giapetto’s variable labor and overhead costs by $10. The
##  manufacture of wooden soldiers and trains requires two types of skilled labor:
##  carpentry and finishing. A soldier requires 2 hours of finishing labor and 1
##  hour of carpentry labor. A train requires 1 hour of finishing and 1 hour of
##  carpentry labor. Each week, Giapetto can obtain all the needed raw material but
##  only 100 finishing hours and 80 carpentry hours. Demand for trains is
##  unlimited, but at most 40 soldiers are bought each week. Giapetto wants to
##  maximize weekly profit (revenues - costs). Formulate a mathematical model of
##  Giapetto’s situation that can be used to maximize Giapetto’s weekly profit.
##  
##  LP: A * x >= rhs, obj * x -> MAX

A := [ [ -2, -1 ],      # finishing
       [ -1, -1 ],      # carpentry
       [ -1,  0 ],      # demand on soldiers
       [  1,  0 ],      # sign
       [  0,  1 ] ];    # sign

rhs := [ -100, -80, -40, 0, 0 ];
obj := [ 3, 2 ];        # $180

sol_lrs := LRS_LPSolveMax( A, rhs, obj );
sol_glpk := GLPK_LPSolveMax( A, rhs, obj );
