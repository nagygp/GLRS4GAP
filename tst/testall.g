#
# GLRS4GAP: GLRS interface for Linear Programming in GAP
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "GLRS4GAP" );

TestDirectory(DirectoriesPackageLibrary( "GLRS4GAP", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
