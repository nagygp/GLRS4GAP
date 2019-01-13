##  
##  LRS4GAP: LRS interface for Linear Programming in GAP
##  
##  GLPK interface for GAP
##  
##  IMPLEMENTATIONS
##  
##  LP: A * x >= rhs, obj * x -> MAX
##  
##  !CAVEAT!: Non checking
InstallGlobalFunction( GLPK_LPSolveNC, function( A, rhs, obj )
end );

InstallGlobalFunction( GLPK_LPSolveMax, function( A, rhs, obj )
end );

InstallGlobalFunction( GLPK_LPSolveMin, function( A, rhs, obj )
end );
