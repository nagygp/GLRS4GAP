LoadPackage( "LRS4GAP" );

##  Wayne L. Winston: *Operations Research: Applications and Algorithms*. Duxbury
##  Press, 2003.
##  
##  Section 3.2, Example 2 *Dorian Auto*
##  
##  Dorian Auto manufactures luxury cars and trucks. The company believes that its
##  most likely customers are high-income women and men. To reach these groups,
##  Dorian Auto has embarked on an ambitious TV advertising campaign and has
##  decided to purchase 1-minute commercial spots on two types of programs: comedy
##  shows and football games.  Each comedy commercial is seen by 7 million
##  high-income women and 2 million high-income men. Each football commercial is
##  seen by 2 million high-income women and 12 million high-income men. A 1-minute
##  comedy ad costs $50,000, and a 1-minute football ad costs $100,000. Dorian
##  would like the commercials to be seen by at least 28 million high-income women
##  and 24 million high-income men. Use linear programming to determine how Dorian
##  Auto can meet its advertising requirements at minimum cost.
##  
##  LP: A * x >= rhs, obj * x -> MIN

A := [ [ 7,  2 ],      # high-income women
       [ 2, 12 ],      # high-income men
       [ 1,  0 ],      # sign
       [ 0,  1 ] ];    # sign

rhs := [ 28, 24, 0, 0 ];
obj := [ 50, 100 ];    # 320 ($320,000)

sol_lrs := LRS_LPSolveMin( A, rhs, obj );
sol_glpk := GLPK_LPSolveMin( A, rhs, obj );
