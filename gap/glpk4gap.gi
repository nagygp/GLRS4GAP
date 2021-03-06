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
    local tmpdir, prob_file, solv_file, solfile, ret, rows, solutionline,
          primalst, dualst, sol, var;
##  Setting up the temporary directory and the files
    tmpdir := DirectoryTemporary();
    prob_file := Filename( tmpdir, "gaplp.mps" );
    solv_file := Filename( tmpdir, "gaplp.sol" );
## 	Convert the problem to FreeMPS
    GLPK_Export2FreeMPS( A, rhs, obj, prob_file );
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
    solutionline := First( rows, row -> StartsWith( row, "s" ) );
    primalst := SplitString( solutionline, " " )[5];
    dualst := SplitString( solutionline, " " )[6];
    if primalst = "u" then
        Info( InfoWarning, 1, "Undefined solution" );
		return [ fail, "Undefined solution" ];
    elif primalst = "i" then
        Info( InfoWarning, 1, "Infeasible solution" );
		return [ fail, "Infeasible solution" ];
    elif primalst = "n" then
        Info( InfoWarning, 1, "No feasible solution" );
		return [ fail, "No feasible solution" ];
    elif primalst = "f" and dualst <> "f" then
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
		ret := GLPK_LPSolveNC( A, rhs, -obj );
		return [ ret[1], -ret[2] ];
	else
		Error( "wrong input" );
	fi;
end );

InstallGlobalFunction( GLPK_Export2FreeMPS, function(A,rhs,obj,filename)
    local nrows, ncols, n_nonzeros, out, i, j;
	if not LRS_Inputcheck(A,rhs,obj) then
	       return Error("wrong input");
	fi;
	nrows:=Size(A);
	ncols:=Size(A[1]);
	n_nonzeros:=Number(Flat(A),x->x<>0);
##  Convert all numbers to floats
    A := Float( A );
    rhs := Float( rhs );
    obj := Float( obj );
	# HEADER
	out:=OutputTextFile(filename,false);
	SetPrintFormattingStatus(out,false);
	AppendTo(out, "* Problem: Generated by LRS4GAP\n" );
	AppendTo(out, "* Class: LP\n" );
	AppendTo(out, "* Rows: ", nrows, "\n" );
	AppendTo(out, "* Columns: ", ncols, "\n" );
	AppendTo(out, "* Non-zeros: ", n_nonzeros, "\n" );
	AppendTo(out, "* Format: Free MPS\n", "*\nNAME\n" );
	# ROWS
	AppendTo(out, "ROWS\n N  R0\n" );
	for i in [1..nrows] do
		AppendTo(out, " G  R", i, "\n");
	od;
	# COLUMNS
	AppendTo(out, "COLUMNS\n" );
	for i in [1..ncols] do
		AppendTo(out, " C", i, " R0 ", obj[i], "\n");
		for j in [1..nrows] do
			AppendTo(out, " C", i, " R", j, " ", A[j][i], "\n");
		od;
	od;
	# RIGHT HAND SIDE
	AppendTo(out, "RHS\n");
	for i in [1..nrows] do
		AppendTo(out, " RHS1 R", i, " ", rhs[i], "\n");
	od;
	# BOUNDS (making the variables free)
	AppendTo(out, "BOUNDS\n");
	for i in [1..ncols] do
		AppendTo(out, " FR BND1 C", i, "\n");
	od;
	# closing the file
	AppendTo(out, "ENDATA\n");
	CloseStream(out);
	return 0;
end );
