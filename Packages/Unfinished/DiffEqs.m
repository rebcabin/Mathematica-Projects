(* ::Package:: *)

(* :Title: Difference Equations *)

(* :Author: Gerald Teschl 
			http://www.mat.univie.ac.at/~gerald/
			Gerald.Teschl@univie.ac.at  *)

(* :Summary:
	This package provides a means for doing
	certain calculations with abstract sequences and
	difference operators. *)

(* :Context: DiscreteMath`DiffEqs` *)

(* :Package Version: 1.4 *)

(* :Copyright: Copyright 1998 - 2006, G. Teschl  *)

(* :History: 
	Version 1.0 - 1.4 by G. Teschl *)

(* :Keywords: Difference Equations, Sequences *)

(* :Source: None. *)

(* :Warning: None. *)

(* :Mathematica Version: 3.0 *)

(* :Limitation: *)

(* :Discussion: This package performs certain manipulations with
    algebraic expressions involving sequences (with index set the
    integers). Four basic operators (S, FDiff, BDiff, and Casoratian),
    symbolic sums (SymbSum) and symbolic products (SymbProduct)
    several functions for simplifying symbolic sums and products
    (ExpandSum and FactorSum, etc.) are provided.
    
    S[f[n],{n,j}] shifts the sequence f[n] by j (j an integer) places.
    A sequence not depending on n is assumed constant. E.g.,
    		S[f[n],{n,1}] -> f[n+1].
    		S[c,{n,1}] -> c.
    SymbSum and SymbProduct are defined such that
    		SymbSum[f[j],{j,m,n-1}] = SymbSum[f[j],{j,n,m-1}],
    		SymbProduct[f[j],{j,m,n-1}] = SymbProduct[f[j],{j,n,m-1}].
    *)

BeginPackage["DiscreteMath`DiffEqs`"]

S::usage =
	"S[f[n],{n,j}] shifts the sequence f[n] by j places."
FDiff::usage =
	"FDiff[f[n],n]=f[n+1]-f[n], forward difference operator."
BDiff::usage =
	"BDiff[f[n],n]=f[n-1]-f[n], backward difference operator."
SymbSum::usage =
	"SymbSum[f[j],{j,m,n}], sum for symbolic manipulations."
SymbProduct::usage =
	"SymbProduct[f[j],{j,m,n}], product for symbolic manipulations."
Casoratian::usage =
	"Casoratian[f1,..,fk,n], computes the Casoratian of a list of sequences at n."
ShiftIndex::usage =
	"ShiftIndex[exp,n] shift the index of sums and products by n."
SplitSum::usage =
	"SplitSum[expr, n] splits sums at n.
	SplitSum[expr] tries to split off extra terms."
ExpandSum::usage =
	"ExpandSum[expr] expands expressions containing sums."
FactorSum::usage =
	"FactorSum[expr] factors expressions containing sums."	
CauchyProduct::usage =
	"CauchyProduct[expr] applies the Cauchy product formula."	
SplitProduct::usage =
	"SplitProduct[expr, n] splits products at n.
	SplitProducts[expr] tries to split off extra terms."
SplitAll::usage =
	"Performs both SplitSum and SplitProduct."
ShiftIndex::usage =
	"ShiftIndex[expr,j] shift the index of all sums and products by j."
ShiftPowers::usage =
	"ShiftPowers[expr,z] shift the index of all sums and products
	according to powers of z."
TestDiff::usage =
	"TestDiff[f[n]==g[n],{n,m}], simple test
	for equality based on the fact that f=g if
	equality holds at one point m and FDiff[f[n]-f[n],n]=0."


Begin["`Private`"]


(* Shift operator S *)

S[f_,{n_,0}]:=f;
S[f_,{n_?AtomQ,j_}]:=f /. n -> n+j;
S[f_,{n_+i_?IntegerQ,j_}]:=S[f ,{n,j}];

(* forward and backward difference operator *)

FDiff[f_Equal,n_]:= FDiff[#,n]& /@ f;
FDiff[f_,n_]:= S[f,{n,1}] -f;
BDiff[f_Equal,n_]:= BDiff[#,n]& /@ f;
BDiff[f_,n_]:= S[f,{n,-1}] -f;

(* Casoratin *)

(* *)
Casoratian[n_]=1;
Casoratian[f__,n_]:=Det[Table[S[{f}[[i]],{n,j-1}],
           {i,1,Length[{f}]},{j,1,Length[{f}]}]];
(* *)

(* Control displaying of Symbolic Sum and Product *)

SymbSum /: MakeBoxes[SymbSum[f_, {j_,m_, n_}], StandardForm] :=
 RowBox[{
      UnderoverscriptBox[
        SuperscriptBox["\[Sum]", "\[Star]"], 
        RowBox[{ MakeBoxes[j, StandardForm], "=",  
            MakeBoxes[m, StandardForm]}],  MakeBoxes[n, StandardForm] ], 
      MakeBoxes[f, StandardForm]
		}];
MakeExpression[ RowBox[{
      UnderoverscriptBox[
        SuperscriptBox["\[Sum]", "\[Star]"], 
        RowBox[{ j_, "=",  m_}],  n_ ], 
      f__ }], StandardForm] :=
  MakeExpression[RowBox[
    {"SymbSum", "[", f, ",","{", j, ",",m,",", n,"}", "]"}],
    StandardForm];

SymbProduct /: MakeBoxes[SymbProduct[f_, {j_,m_, n_}], StandardForm] :=
 RowBox[{
      UnderoverscriptBox[
        SuperscriptBox["\[Product]", "\[Star]"], 
        RowBox[{ MakeBoxes[j, StandardForm], "=",  
            MakeBoxes[m, StandardForm]}],  MakeBoxes[n, StandardForm] ], 
      MakeBoxes[f, StandardForm]
		}];
MakeExpression[ RowBox[{
      UnderoverscriptBox[
        SuperscriptBox["\[Product\]", "\[Star]"], 
        RowBox[{ j_, "=",  m_}],  n_ ], 
      f__ }], StandardForm] :=
  MakeExpression[RowBox[
    {"SymbProduct", "[", f, ",","{", j, ",",m,",", n,"}", "]"}],
    StandardForm];

(* Evaluate Symbolic Sum and Product if the range is known *)

SymbSum[f_,{j_,m_,n_}]:= If[Negative[n-m+1],
	-Sum[f,{j,n+1,m-1}],Sum[f,{j,m,n}]] /;
    NumberQ[n-m];

SymbProduct[f_,{j_,m_,n_}]:= If[Negative[n-m+1],
	Product[1/f,{j,n+1,m-1}],Product[f,{j,m,n}]] /;
	NumberQ[n-m];
	
(* Make Symbolic Sum behave correct w.r.t differentation and integration *)

D[SymbSum[f_,g_],x__]^:=SymbSum[D[f,x],g];
Integrate[SymbSum[f_,g_],x__]^:=SymbSum[Integrate[f,x],g];

(* ShiftIndex will shift the index of sums/products *)

ShiftIndex[expr_,j_]:= (( expr
       /. SymbSum[f_,{i_,m_,n_}]:> SymbSum[(f /. i->i+j),{i,m-j,n-j}] )
       /. SymbProduct[f_,{i_,m_,n_}]:> SymbProduct[(f /. i->i+j),{i,m-j,n-j}] );

(* ShiftPowers will shift the index of sums/products according to powers of the second argument *)

ShiftPowers[expr_,z_Symbol]:= ((( expr
         /. SymbSum[f_?(!FreeQ[#,SymbSum]&),ii_]:>
          SymbSum[FactorSum[f],ii] )
         /. SymbSum[f_ z^(i_+j_?IntegerQ),{i_,m_,n_}]:>
          SymbSum[(f/.i->i-j) z^i,{i,m+j,n+j}] )
         /. SymbProduct[f_ z^(i_+j_?IntegerQ),{i_,m_,n_}]:>
          SymbProduct[(f/.i->i-j)z^i,{i,m+j,n+j}] );

(* SplitSum will help to simplify sums *)

SplitSum[p_, j_] := p /. SymbSum[f_,{i_,m_,n_}] :>
		SymbSum[f,{i,m,j-1}]+SymbSum[f,{i,j,n}];

SplitSum[p_] := p /. SymbSum[f_?((Head[#]=!= SymbSum)&), {j_,m_,n_}] :>
		With[{ff = Expand[f]}, 
		     	If[Head[ff]===Plus,
				Map[PullOutSum[#,{j,m,n}]&,ff],
				PullOutSum[ff,{j,m,n}]
				]
			];
PullOutSum[f_,{j_,m_,n_}]:= Module[{f1=1,f2=f,m1=0,m2=m,n1=0,n2=n},
		If[Head[f]===Times,
			f1=Select[f,FreeQ[#,j]&];
			f2=Select[f,!FreeQ[#,j]&]
			];
		If[Head[n]===Plus,
			n1=Select[n,IntegerQ];
			n2=Select[n,!IntegerQ[#]&]
			];
		If[Head[m]===Plus,
			m1=Select[m,IntegerQ];
			m2=Select[m,!IntegerQ[#]&]
			];
		f1 SymbSum[f2,{j,m2,n2}] +
			If[n1==0,0,SymbSum[f,{j,n2+1,n2+n1}]] +
			If[m1==0,0,SymbSum[f,{j,m2+m1,m2-1}]]
	];

(* SplitProduct will help to simplify products *)

SplitProduct[p_, j_] := p /. SymbProduct[f_,{i_,m_,n_}] :>
		SymbProduct[f,{i,m,j-1}] * SymbProduct[f,{i,j,n}];

SplitProduct[p_] := p /. SymbProduct[f_?((Head[#]=!= SymbProduct)&), {j_,m_,n_}] :>
	     Module[{f1=1,f2=Factor[f]},
			If[Head[f2]===Times,
				f1=Select[f2,FreeQ[#,j]&]^(n-m+1);
				f2=Select[f2,!FreeQ[#,j]&]
				];
			If[Head[f2]===Power && FreeQ[f2[[2]],j],
				f1 Power[ PullOutProduct[f2[[1]],{j,m,n}],f2[[2]] ],
				f1 PullOutProduct[f2,{j,m,n}]
				]
			];
PullOutProduct[f_,{j_,m_,n_}]:= Module[{m1=0,m2=m,n1=0,n2=n},
		If[Head[n]===Plus,
			n1=Select[n,IntegerQ];
			n2=Select[n,!IntegerQ[#]&]
			];
		If[Head[m]===Plus,
			m1=Select[m,IntegerQ];
			m2=Select[m,!IntegerQ[#]&]
			];
		SymbProduct[f,{j,m2,n2}]*
			If[n1==0,1,SymbProduct[f,{j,n2+1,n2+n1}]]*
			If[m1==0,1,SymbProduct[f,{j,m2+m1,m2-1}]]
	];

(* combine SplitSum and SplitProduct in one command *)

SplitAll[f_]:=Module[{fnew=f,fold=Expand[f]},
	Label[again];
	fnew=SplitSum[fold];
	fnew=SplitProduct[fnew];
	If[fnew===fold,Simplify[fnew],fold=fnew; Goto[again]]
	];

(* Cauchy Product *)

CauchyProduct[expr_]:= (( expr 
	/. SymbSum[f_,{i_,i0_,Infinity}]SymbSum[g_,{j_,j0_,Infinity}]:>
          Block[{ff,gg,n=Unique["n"],m=Unique["m"]},
          	ff=f /. i -> (m-i0);
            gg=g /. j -> (n-m-j0);
            SymbSum[SymbSum[ff gg,{m,0,n}],{n,0,Infinity}]] )
	 /. Power[SymbSum[f_,{i_,i0_,Infinity}],k_Integer]:>
          Block[{ff,gg,n=Unique["n"],m=Unique["m"]},
          	ff=f /. i -> (m-i0);
          	gg=f /. i -> (n-m-i0);
          	SymbSum[SymbSum[ff gg,{m,0,n}],{n,0,Infinity}] *
          	SymbSum[f,{i,0,Infinity}]^(k-2)] /;k>0 );

(* ExpandSum expands expressions containing sums *)

ExpandSum[c_ SymbSum[f_,{j_,m_,n_}]]:= Block[{c1=c,c2=1},
		If[FreeQ[c,j],c2=c;c1=1,
			If[Head[c]==Times,
				c1=Select[c,!FreeQ[#,j]&];
				c2=Select[c,FreeQ[#,j]&] ] ];
		If[c2 === 1,
			ExpandSum[c1] ExpandSum[ SymbSum[f,{j,m,n}]],
			ExpandSum[c1 SymbSum[c2 f,{j,m,n}]]]
		];
ExpandSum[SymbSum[f_,{j_,m_,n_}]]:=Block[{ff},
		If[!FreeQ[f,SymbSum],ff=ExpandSum[f],ff=Expand[f]];
		If[Head[ff]=!=Plus,SymbSum[ff,{j,m,n}],
			SymbSum[#,{j,m,n}]& /@ ff]
		];
ExpandSum[f_]:= ExpandSum/@ Expand[f];

(* FactorSum factors expressions containing sums *)

FactorSum[SymbSum[Times[c_,f__],{j_,m_,n_}]]:= 
		FactorSum[c SymbSum[Times[f],{j,m,n}]] /; FreeQ[c,j];
FactorSum[Plus[(c_:1) SymbSum[f_,{j_,m_,n_}],
	(d_:1) SymbSum[g_,{k_,m_,n_}],h___]]:=Block[{nn,ff=f,gg=g},
		Which[j===k && FreeQ[c,j] && FreeQ[d,j],nn=j,
			FreeQ[d,j] && FreeQ[g,j], nn=j; gg=g /. k->j,
			FreeQ[c,k] && FreeQ[f,k], nn=k; ff=f /. j->k,
			True, nn=Unique["n"]; ff=f /. j->nn; gg=g /. k->nn];
			FactorSum[Plus[SymbSum[c ff + d gg,{nn,m,n}],h]]
		];
FactorSum[SymbSum[f_,{j_,m_,n_}]]:=Block[{ff},
		ff=f;
		If[!FreeQ[f,SymbSum],ff=FactorSum[f],ff=Factor[f]];
		If[f===ff,
			SymbSum[ff,{j,m,n}],
			FactorSum[SymbSum[ff,{j,m,n}]]
			]
		];
FactorSum[f_]:= Factor[FactorSum/@ f];
		
(* Test if two sequences are equal *)

TestDiff[eqn_Equal,{n_,m_}]:=
		Module[{eq},
			eq= FDiff[#,n]& /@ eqn;
			eq= SplitAll /@ eq;
			Simplify[eq] && Simplify[eqn /. n->m]
		];
End[]


Protect[{S,FDiff,BDiff,Casoratian,SymbSum,SymbProduct,
	ShiftIndex,ShiftPowers,SplitSum,SplitProduct,SplitAll,
	ExpandSum,FactorSum,CauchyProduct,TestDiff}];

EndPackage[]
