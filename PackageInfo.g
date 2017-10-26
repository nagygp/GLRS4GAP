#
# LRS4GAP: LRS interface for Linear Programming in GAP
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "LRS4GAP",
Subtitle := "LRS interface for Linear Programming in GAP",
Version := "0.20",
Date := "26/10/2017", # dd/mm/yyyy format

##  Optional: if the package manual uses GAPDoc, you may duplicate the
##  version and the release date as shown below to read them while building
##  the manual using GAPDoc facilities to distibute documents across files.
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "0.20">
##  <!ENTITY RELEASEDATE "26 October 2017">
##  <#/GAPDoc>

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Gábor Péter",
    LastName := "Nagy",
    WWWHome := "http://www.math.u-szeged.hu/~nagyg",
    Email := "nagyg@math.u-szeged.hu",
    PostalAddress := "H-6720 Szeged (Hungary), Aradi vertanuk tere 1",
    Place := "Szeged",
    Institution := "University of Szeged",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/nagygp/", ~.PackageName ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
#SupportEmail   := "TODO",
PackageWWWHome  := "https://nagygp.github.io/LRS4GAP/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "LRS4GAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "LRS interface for Linear Programming in GAP",
),

Dependencies := rec(
  GAP := ">= 4.8",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

#AvailabilityTest := ReturnTrue,
AvailabilityTest := function()
  return Filename( DirectoriesPackagePrograms( "LRS4GAP" ), "lrs" )<>fail;
end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));
