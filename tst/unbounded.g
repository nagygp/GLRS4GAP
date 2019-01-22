LoadPackage( "LRS4GAP" );

##  Wayne L. Winston: *Operations Research: Applications and Algorithms*. Duxbury
##  Press, 2003.
##  
##  Section 3.3, Example 5 *Unbounded LP*
##  
##  LP: A * x >= rhs, obj * x -> MAX

A := [ [ -1, 1 ],
       [  2, 1 ],
       [  1, 0 ],   # sign
       [  0, 1 ] ]; # sign

rhs := [ -1, 6, 0, 0 ];
obj := [ 2, -1 ];   # UNBOUNDED

sol_lrs := LRS_LPSolveMax( A, rhs, obj );
sol_glpk := GLPK_LPSolveMax( A, rhs, obj );
