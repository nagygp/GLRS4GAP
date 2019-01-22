LoadPackage( "LRS4GAP" );

##  Wayne L. Winston: *Operations Research: Applications and Algorithms*. Duxbury
##  Press, 2003.
##  
##  Section 3.3, Example 4 *Infeasible LP*
##  
##  Suppose that auto dealers require that the auto company in Example 3 produce at
##  least 30 trucks and 20 cars. Find the optimal solution to the new LP.
##  
##  LP: A * x >= rhs, obj * x -> MAX

A := [ [ -1/40, -1/60 ],    # paint shop
       [ -1/50, -1/50 ],    # body shop
       [  1,  0 ],          # sign
       [  0,  1 ] ];        # sign

rhs := [ -1, -1, 30, 20 ];
obj := [ 3, 2 ];            # INFEASIBLE 

sol_lrs := LRS_LPSolveMax( A, rhs, obj );
sol_glpk := GLPK_LPSolveMax( A, rhs, obj );
