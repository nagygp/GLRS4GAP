LoadPackage( "LRS4GAP" );

##  Wayne L. Winston: *Operations Research: Applications and Algorithms*. Duxbury
##  Press, 2003.
##  
##  Section 3.4, Example 6 *Diet Problem*
##  
##  My diet requires that all the food I eat come from one of the four “basic food
##  groups” (chocolate cake, ice cream, soda, and cheesecake). At present, the
##  following four foods are available for consumption: brownies, chocolate ice
##  cream, cola, and pineapple cheesecake. Each brownie costs 50c, each scoop of
##  chocolate ice cream costs 20c, each bottle of cola costs 30c, and each piece of
##  pineapple cheesecake costs 80c. Each day, I must ingest at least 500 calories,
##  6 oz of chocolate, 10 oz of sugar, and 8 oz of fat.  The nutritional content
##  per unit of each food is shown in Table 2. Formulate a linear programming model
##  that can be used to satisfy my daily nutritional requirements at minimum cost.
##  
##  Type of Food    Calories    Chocolate (Ounces)  Sugar (Ounces)  Fat (Ounces)
##  -----------------------------------------------------------------------------
##  Brownie         400         3                   2               2
##  
##  Chocolate ice
##  cream (1 scoop) 200         2                   2               4
##  
##  Cola (1 bottle) 150         0                   4               1
##  
##  Pa. cheesecake
##  (1 piece)       500         0                   4               5
##  
##  LP: A * x >= rhs, obj * x -> MIN

A := [ [ 400,   200,    150,    500 ],      # calorie
       [ 3,     2,      0,      0   ],      # chocolate
       [ 2,     2,      4,      4   ],      # sugar
       [ 2,     4,      1,      5   ] ];    # fat
Append( A, IdentityMat( 4 ) );              # sign

rhs := [ 500, 6, 10, 8, 0, 0, 0, 0 ];
obj := [ 50, 20, 30, 80 ];                  # 90

sol_lrs := LRS_LPSolveMin( A, rhs, obj );
sol_glpk := GLPK_LPSolveMin( A, rhs, obj );
