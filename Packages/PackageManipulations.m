(* ::Package:: *)

(*......................................................................*)



(* :Title:   PackageManipulations   *)

(* :Author:    Leonid B.Shifrin    *)

(* :Summary:

	The package provides tools to (dynamically) re-load, clear
	and/or remove the context  of any loaded package (optionally
	with sub-contexts) during interactive Mathematica session 
	or during execution of a stand-alone program. These operations
	are performed respecting the general package mechanics in 
	Mathematica. Additional functionality includes (optional) 
	automatic resolving of shadowing problems that may have occured 
	before or during re-loading, and tracking escaping symbols 
	(symbols present in the user's context without usage messages).
	The package can be used as a tool for rapid package development 
	and debugging.
	
*)


(* :Context:   PackageManipulations`     *)

(* :Package version:   1.0         *)

(* :Copyright:  Copyright 2009, Leonid B.Shifrin.

	Permission is granted to distribute verbatim copies of this 
	package together with any of your packages that use it, provided
	the following acknowledgement is printed in a standard place:
	"PackageOptionChecks.m is distributed with permission  by 
	Leonid B. Shifrin."
*)


(*  :History:    Version 1.0 January 2009      *)

(*  :Keywords:  package development, debugging, reloading, removing,
				 clearing, symbols, shadowing, contexts  *)

(*  :Mathematica version: 5.0   *)

(*  
	:Discussion: 

	Note that PackageReload uses internally PackageClearComplete with
	RemovePackage->False option. This is done for safety reasons: if 
	any symbol in other contexts does depend on some symbol (s) in the
	context of the package we want to reload,then it will become 
	Removed[thatsymbol] in all places where this symbol was present 
	before,should we remove it rather than clear it,during reloading of
	our package. This will most certainly cause trouble,and such bugs are
	hard to catch.

	The disadvantage of this approach is that in a new (reloaded) version
	of the package some symbols may be present without actually being 
	useful for anything. This happens if the symbol is simply not present 
	in the user's context in the new version of the package.It then still 
	remains in the symbol table from the times of the old package,but with
	all its global properties cleared by PackageClearComplete. Warning 
	messages are generated by PackageReload in such cases.

	The test <contextQ> that the context name is a legitimate one, is 
	very simplistic. Other tests are possible - for example that the 
	context is contained in $ContextPath or Contexts[]. But the former
	is generally incomplete, while the latter is time-consuming.

	I don't know whether or not it matters for anything, but I made 
	the package self-reloadable. That is, the command 
	PackageReload["PackageManipulations`"] does reload the package 
	all right.
	
*)



BeginPackage["PackageManipulations`"];


(********************************************************************)
(*                          Usage messages                          *)
(********************************************************************)



PackageReload::usage = 
"PackageReload[context_String] reloads the package <context>. \
PackageReload[context_String,KillShadowing-> True] can be used to \
automatically resolve possible shadowing problems occurring during \
package re-loading (or having occurred before). During the reloading \
process, all the names in the main context and all sub-contexts are \
completely cleared, but not removed. Then, the new version of the \
package is loaded. If some symbols in the user's context are no longer \
used in a new version, they will still remain in the symbol table \
(escaping symbols). In this case, warning messages will be generated. \
Apart from these messages, PackageReload does not take any action \
towards these symbols. They have to be taken care of by the user. ";

KillShadowing::usage = 
"KillShadowing is an option which, when set to True, enables the \
removal of symbols in other contexts which shadow some of the \
symbols of the context to be reloaded";

PackageRemove::usage = 
"PackageRemove[context_String] completely removes all the \
definitions of the package symbols from the system's namespace, \
and updates the relevant system variables ($Packages, $ContextPath)";

PackageClear::usage =
"PackageClear[context_String] clears the names and attributes of \
all symbols in the context <context>, but not in its sub-contexts"

PackageClearComplete::usage = 
"PackageClearComplete[context_String,opts___?OptionQ] clears \
(or removes, if the RemovePackage option is set True) the given \
package and all its sub-contexts";

RemovePackage::usage = 
"RemovePackage is an option for PackageClearComplete. If set to True, \
causes the package's main context and all sub-contexts to be Remove-d.";

RemoveQuiet::usage  = 
"RemoveQuiet is an option for PackageRemove. Can be used to switch \
off warnings"; 

ClearQuiet::usage = 
"ClearQuiet is an option for PackageClear. Can be used to switch \
off warnings"; 



(********************************************************************)
(*                        Warning messages                          *)
(********************************************************************)


PackageReload::"shdw" = 
"Some symbols in the package are shadowed in some other \
contexts. Use the KillShadowing\[Rule] True option setting if \
you wish to Remove those symbols";

PackageRemove::nopckg = 
"No names were found in this context to be removed";

PackageClear::nopckg = 
"No names were found in this context to be removed";

PackageReload::unusedold = 
"Warning: PackageReload discovered that the following  symbols: \
`1`  did not have usage messages (before reloading) ";

PackageReload::unusednew = 
"Warning: the following symbols: `1` no longer have usage messages ";

PackageReload::unused = 
"Warning: the following symbols: `1` still don't have usage messages, \
after the package has been reloaded";


(********************************************************************)
(*                          Error messages                          *)
(********************************************************************)


PackageRemove::badarg = PackageClear::badarg = 
PackageClearComplete::badarg = PackageReload::badarg  = 
	"The argument is supposed to be a String (context name), plus \
	possibly options";

PackageRemove::argnum = PackageClear::argnum = 
PackageClearComplete::argnum = PackageReload::argnum  = 
	"The function was called with `1` non-optional arguments. \
	Exactly 1 non-optional argument was expected";

PackageRemove::nocont = PackageClear::nocont = 
PackageClearComplete::nocont = PackageReload::nocont  = 
	"The name `1` is not a proper context name";


(********************************************************************)
(********************************************************************)
(**********        Implementation - Private part         ************)
(********************************************************************)
(********************************************************************)


Begin["`Private`"];


Options[PackageReload]={KillShadowing-> False};
Options[PackageRemove] = {RemoveQuiet -> False}; 
Options[PackageClearComplete]={RemovePackage -> False};
Options[PackageClear] = {ClearQuiet -> False};


UseOption[optname_Symbol,function_,opts___?OptionQ]:=
	optname/.Flatten[{opts}]/.Options[function];


$ContextSeparator = "`";


With[{separator = $ContextSeparator},
contextQ=Function[context,StringMatchQ[context,__~~separator]]];


JoinHeld[a___Hold]:=
	Hold@@Replace[Hold[a],Hold[x___]:>Sequence[x],{1}];


keepNameOnly[fullname_String]:=
	StringReplace[fullname,
		LongestMatch[__~~$ContextSeparator]~~x__ :> x];


shadowedNames[context_String]:=
	Flatten[Map[Outer[StringJoin,{#[[1]]},#[[2]]]&,
		With[{shortnames=Map[keepNameOnly,Names[#<>"*"]&[context]]},
			DeleteCases[
				Map[{#,Intersection[
							keepNameOnly/@Names[#<>"*"],shortnames]}&,
					DeleteCases[$ContextPath,context]],
				{_String,{}}]]]];


(* 
** This function is inspired by the <EscapingSymbols> package. The code is 
** a bit shorter than in the original due to the use of the Block trick 
*)

Attributes[noUsage] = {HoldFirst};
noUsage[name_]:=
	With[{messagePattern=
		Block[{MessageName},
			Verbatim[RuleDelayed][
				Verbatim[HoldPattern][
					HoldPattern[MessageName[name,"usage"]]],_]]},
		Cases[Messages[name],messagePattern]==={}];


messageGenerateIfUnused[held:Hold[__Symbol],mname_String]:=
	Message[MessageName[PackageReload,mname],
		Unevaluated@@(held/.Hold[syms__Symbol]:>Hold[{syms}])];


(* 
** Note the use of external <With>. It helps to make the package 
** self-reloadable (for whatever it's worth)  
*)

packageReload[context_String,opts___?OptionQ]:=
With[{killShdw = TrueQ[UseOption[KillShadowing,PackageReload,opts]],
		removeQ = TrueQ[UseOption[RemovePackage,PackageClearComplete,opts]],
		heldnames = JoinHeld@@ToExpression[
						Names[context<>"*"],InputForm,Hold]},
		With[{loadF = If[removeQ,Needs,Get],
			oldUnused = Select[heldnames, noUsage]},	
			messageGenerateIfUnused[oldUnused,"unusedold"];		
			If[killShdw,
				With[{shnames = shadowedNames[context]},
					Unprotect@@shnames;
					Remove@@shnames]];
			PackageClearComplete[context,
				ClearQuiet -> True,RemovePackage-> False];
			loadF[context];				
			With[{nolongerused =
					 Select[Complement[heldnames,oldUnused],noUsage],
				stillUnused = Select[oldUnused,noUsage]},
				messageGenerateIfUnused[stillUnused,"unused"];
				messageGenerateIfUnused[nolongerused,"unusednew"];				
			]]]; 


(********************************************************************)
(********************************************************************)
(*****************        Public interface         ******************)
(********************************************************************)
(********************************************************************)


With[{cQ = contextQ},
PackageRemove[context_String?cQ,opts___?OptionQ]:=
	With[{names=context<>"*"},
		With[{symbols = Names[names]},
			If[symbols=!={},
				Unprotect[names];
				Remove[names]
			];
			Unprotect[$Packages];
			$Packages = DeleteCases[$Packages,context];
			$ContextPath = DeleteCases[$ContextPath,context];
			Protect[$Packages];
			If[symbols==={}&&
				Not[TrueQ[UseOption[RemoveQuiet,PackageRemove,opts]]],
					Message[PackageRemove::nopckg]
			]]]];



(* Error cases *)

PackageRemove[c_String,___?OptionQ]:=
	"never happens"/;Message[PackageRemove::nocont, c];
PackageRemove[c_,___?OptionQ]/;Head[c]=!=String:=
	"never happens"/;Message[PackageRemove::badarg];
PackageRemove[x___/;!MemberQ[{x},_?OptionQ],
___?OptionQ]/;Length[{x}]=!=1:=
	"never happens"/;Message[PackageRemove::argnum,Length[{x}]];



(* 
** Note: can not use UseOption here, to make the package 
** self-reloadable 
*)

With[{cQ = contextQ},
PackageClear[context_String?cQ,opts___?OptionQ]:=
With[{names=context<>"*"},
	If[Names[names]==={},
			If[Not[TrueQ[
					ClearQuiet/.
						Flatten[{opts}]/.
							Options[PackageClear]]],
				Message[PackageClear::nopckg]
			];
			Return[]];
	Unprotect[names];
	ClearAll[names];];];


(* Error cases *)

PackageClear[c_String,___?OptionQ]:=
	"never happens"/;Message[PackageClear::nocont, c];
PackageClear[c_,___?OptionQ]/;Head[c]=!=String:=
	"never happens"/;Message[PackageClear::badarg];
PackageClear[x___/;!MemberQ[{x},_?OptionQ],
___?OptionQ]/;Length[{x}]=!=1:=
	"never happens"/;Message[PackageClear::argnum,Length[{x}]];



With[{cQ = contextQ},
PackageClearComplete[context_String?cQ,opts___?OptionQ]:=
With[{removeQ = 
		TrueQ[UseOption[RemovePackage,PackageClearComplete,opts]],
	subcontexts = 
		Select[Contexts[],StringMatchQ[#,context~~__]&]
	},
	With[{clearF = If[removeQ,PackageRemove,PackageClear]},
		Map[clearF[#,opts]&,Append[subcontexts,context]];
	]]];



(* Error cases *)

PackageClearComplete[c_String,___?OptionQ]:=
	"never happens"/;Message[PackageClearComplete::nocont, c];
PackageClearComplete[c_,___?OptionQ]/;Head[c]=!=String:=
	"never happens"/;Message[PackageClearComplete::badarg];
PackageClearComplete[x___/;!MemberQ[{x},_?OptionQ],
___?OptionQ]/;Length[{x}]=!=1:=
	"never happens"/;Message[PackageClearComplete::argnum,Length[{x}]];



With[{cQ = contextQ},
PackageReload[context_String?cQ,opts___?OptionQ]:=
	If[MemberQ[(packageReload[context,opts];$MessageList),
				Verbatim[MessageName][_,"shdw"],
				Infinity],
		Message[PackageReload::"shdw"]]];



(* Error cases *)

PackageReload[c_String,___?OptionQ]:=
	"never happens"/;Message[PackageReload::nocont, c];
PackageReload[c_,___?OptionQ]/;Head[c]=!=String:=
	"never happens"/;Message[PackageReload::badarg];
PackageReload[x___/;!MemberQ[{x},_?OptionQ],
___?OptionQ]/;Length[{x}]=!=1:=
	"never happens"/;Message[PackageReload::argnum,Length[{x}]];


End[];


Protect[PackageReload,PackageClearComplete,PackageClear,PackageRemove];


EndPackage[];
