LoadPackage( "LRS4GAP" );

##  Wayne L. Winston: *Operations Research: Applications and Algorithms*. Duxbury
##  Press, 2003.
##  
##  Section 3.3, Example 3 *Alternative Optimal Solutions*
##  
##  An auto company manufactures cars and trucks. Each vehicle must be processed in
##  the paint shop and body assembly shop. If the paint shop were only painting
##  trucks, then 40 per day could be painted. If the paint shop were only painting
##  cars, then 60 per day could be painted. If the body shop were only producing
##  cars, then it could process 50 per day.  If the body shop were only producing
##  trucks, then it could process 50 per day. Each truck contributes $300 to
##  profit, and each car contributes $200 to profit. Use linear programming to
##  determine a daily production schedule that will maximize the company’s profits.
##  
##  LP: A * x >= rhs, obj * x -> MAX

A := [ [ -1/40, -1/60 ],    # paint shop
       [ -1/50, -1/50 ],    # body shop
       [  1,  0 ],          # sign
       [  0,  1 ] ];        # sign

rhs := [ -1, -1, 0, 0 ];
obj := [ 3, 2 ];            # 200 ($20.000)

sol_lrs := LRS_LPSolveMax( A, rhs, obj );
sol_glpk := GLPK_LPSolveMax( A, rhs, obj );
