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
##  The implementation doesn't ship the glpk library and the glpsol command.
##  You need this installed on your computer. The implementation requires glpk
##  (at least) version 4.65 installed.
    local tmpdir, prob_file, solv_file, solfile, ret, rows, sol, var;
##  Setting up the temporary directory and the files
    tmpdir := DirectoryTemporary();
    prob_file := Filename( tmpdir, "gaplp.mps" );
    solv_file := Filename( tmpdir, "gaplp.sol" );
## 	Convert the problem to FreeMPS
    LRS_Export2FreeMPS( A, rhs, obj, prob_file );
##  Solving the problem with glpsol
    Exec( Concatenation( "glpsol --freemps --exact --max ", prob_file, " -w ",
                         solv_file, " 1> /dev/null" ) );
##  Reading in the solution
    solfile := InputTextFile( solv_file );
    ret := ReadAll( solfile );
    CloseStream( solfile );
##  Delete the temporary files
    Exec( Concatenation( "rm ", prob_file ) );
    Exec( Concatenation( "rm ", solv_file ) );
##  Interpreting and returning the solution
    rows := SplitString( ret, "\n" );
    if SplitString( rows[5], " " )[3] = "INFEASIBLE" then
        Info( InfoWarning, 1, "No feasible solution" );
		return [ fail, "No feasible solution" ];
    elif SplitString( rows[5], " " )[3] = "UNBOUNDED" then
		Info( InfoWarning, 1, "Unbounded solution" );
		return [ fail, "Unbounded solution" ];
    else
        sol := Rat( SplitString( First( rows, x -> StartsWith( x, "s" ) ),
                                 " ")[7] );
        var := List( Filtered( rows, row -> StartsWith( row, "j" ) ),
                     x -> Rat( SplitString( x, " ")[4] ) );
        return [ var, sol ];
    fi;
end );

InstallGlobalFunction( GLPK_LPSolveMax, function( A, rhs, obj )
	if LRS_Inputcheck( A, rhs, obj ) then
		return GLPK_LPSolveNC( A, rhs, obj );
	else
		Error( "wrong input" );
	fi;
end );

InstallGlobalFunction( GLPK_LPSolveMin, function( A, rhs, obj )
    local ret;
	if LRS_Inputcheck( A, rhs, obj ) then
		ret := GLPK_LPSolveNC( A, rhs, obj );
		return [ ret[1], -ret[2] ];
	else
		Error( "wrong input" );
	fi;
end );
