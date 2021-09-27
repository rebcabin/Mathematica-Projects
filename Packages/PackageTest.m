(* ::Package:: *)

(* Mathematica Package *)

(* Created by the Wolfram Workbench Feb 3, 2012 *)

BeginPackage["PackageTest`", {"JLink`", "MiniData`"}]
(* Exported symbols added here with SymbolName::usage *) 

test1::usage = "foo";
test2::usage = "bar";

Begin["`Private`"]
(* Implementation of the package *)

test1 = "test1";
test2 = "test2";
test3 = "test3";

End[]

EndPackage[]

