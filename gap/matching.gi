#
# LRS4GAP: Finding maximal/minimal weight matchings in complete bipartite graphs
#
# Implementations
#
InstallGlobalFunction( LRS_MaxWeightMatchingNC, function( mat )
    local n,i,j,row,col,A,rhs,obj,sol;
    n := Length( mat );
    A := IdentityMat( n^2 );
    rhs := 0*[ 1..n^2 ];
    for i in [ 0..n-1 ] do
        row := 0*[ 1..n^2 ];
        col := 0*[ 1..n^2 ];
        for j in [ 0..n-1 ] do
            row[ i*n+j+1 ] := 1;
            col[ j*n+i+1 ] := 1;
        od;
        Append( A, [ row, -row, col, -col ] );
        Append( rhs, [ 1, -1, 1, -1 ]);
    od;
    obj := Concatenation( mat );

    sol := LRS_LPSolveMax( A, rhs, obj );
    sol[ 1 ] := List( [ 0..n-1 ], i -> sol[ 1 ]{ [ i*n+1..(i+1)*n ] } );
    return sol;
end );

InstallGlobalFunction( LRS_MaxWeightMatching, function( mat )
    if not ( IsMatrix( mat ) and DefaultFieldOfMatrix( mat ) = Rationals and Size( mat ) = Size( mat[1] ) ) then 
        Error("argument must be a matrix"); 
    fi;
    return LRS_MaxWeightMatchingNC( mat );
end );

InstallGlobalFunction( LRS_MinWeightMatching, function( mat )
    local ret;
    if not ( IsMatrix( mat ) and DefaultFieldOfMatrix( mat ) = Rationals and Size( mat ) = Size( mat[1] ) ) then 
        Error("argument must be a matrix"); 
    fi;
    ret := LRS_MaxWeightMatchingNC( -mat );
    return [ ret[1], -ret[2] ];
end );
