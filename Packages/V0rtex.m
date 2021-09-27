(* ::Package:: *)

(* ::Section:: *)
(*Natural, Mutual Representations of Mathematica and JSON*)


(* ::Text:: *)
(*Recursively convert key-value pairs in the Java HashMapEntries into key-value pairs in lists (i.e., association lists)*)


(* ::Subsection:: *)
(*DEFINITION: KVPair*)


(* ::Text:: *)
(*KVPair or KVP is a list of two values, the first of which is a string or symbol Key. *)


(* ::Subsection:: *)
(*DEFINITION: Association List*)


(* ::Text:: *)
(*Association List or AList is a SET, represented as a list, of KVPairs such that all the keys are unique at the top level. In other words, an Association List is a partial function from string or symbol keys to values. *)


(* ::Subsection:: *)
(*REMARK:*)


(* ::Text:: *)
(*We emphasize the fact that we somewhat clumsily represent Sets, in which order is not significant and duplicate entries are not allowed, as lists, where order IS significant and duplicates ARE allowed. Association Lists can be accidentally ordered. This is a big topic deserving exploration at length, but let's leave that for another time and place.*)


(* ::Subsection:: *)
(*NOTATION:*)


(* ::Text:: *)
(*Consider a variable named t denoting a value of type T. We conventionally use a "synthetic plural" variable named ts to denote a homogeneous list of values of type T. Similarly, we would denote a list of list of Ts with a variable named tss. Extend this to collections, so if we have just a collection of instances of type T, we also use a variable named ts for such a thing. For a function from type T to type S, we might use a variable named sFromT or t2s, and write the type of this variable as T->S, exactly as in Haskell.*)


(* ::Subsection:: *)
(*EXAMPLE:*)


(* ::Text:: *)
(*We might denote a a list of key-value pairs (as opposed to a proper association list) with a variable named kvps. We might denote a hashMap, represented as a list representing a set of hash map entries, with a variable named hmes.*)


(* ::Section:: *)
(*Expressions*)


(* ::Subsection:: *)
(*Basal Syntax*)


(* ::Code:: *)
(*Expr ::= Atom (* atomic expression *)*)
(*       | Expr "[" "]" (* two kinds of composite expressions *)*)
(*       | Expr "[" Exprs "]"*)
(**)
(*Exprs ::= Expr*)
(*        | Expr "," Exprs*)
(**)
(*Atom ::= String*)
(*       | Symbol*)
(*       | Integer*)
(*       | Rational*)
(*       | Real*)
(*       | Complex*)


(* ::Subsection:: *)
(*Structural Rules*)


(* ::Text:: *)
(*For analyzing expressions, we have three distinguished heads: "Head", "Args", and "List". Head produces the 'types' of atoms and the leading term of composite expressions. Args produces a List: an empty list for any atom and for composite expressions with no arguments, and a list of all the arguments for composite expressions with non-empty argument lists.*)


(* ::Text:: *)
(*Args is defined in MongoHydra.mt.*)


(* ::Code:: *)
(*Head[Atom] ~~> String | Symbol | Integer | Rational | Real | Complex*)
(*Head[Expr "[" "]"] ~~> Expr*)
(*Head[Expr "[" Exprs "]"] ~~> Expr*)
(**)
(*Args[Atom] ~~> List[]*)
(*Args[Expr "[" "]"] ~~> List[]*)
(*Args[Expr "[" Exprs "]"] ~~> List[Exprs]*)


(* Mathematica Package *)

(* Created by the Wolfram Workbench Feb 3, 2012 *)

BeginPackage["V0rtex`", {"JLink`", "MiniData`"}]
(* Exported symbols added here with SymbolName::usage *) 

SymbolQ::usage = "Tests whether its argument is a Symbol";

KvpQ::usage = "Tests whether its argument is a KVPair or KVP, that is, a list of two values, the first of which is a string or symbol Key.";
KvpsQ::usage = "Tests whether its argument is an association list: that is, a list of key-value pairs where no key appears more than once.";

RulesQ::usage = "Tests whether its argument is a list of Rules, which is the Import/Export preferred representation for key-value pairs (the analog to 'lookup' for rules is just 'Replace.')";
RulessQ::usage = "Tests whether its argument is a list of list of Rules, which is the preferred representation for argument lists.";

Args::usage = "Produces all the arguments of a composite expression; counterpoint to built-in Head.";

rulesFromExpression::usage = "Converts an arbitrary expression into nested rules.";
expressionFromRules::usage = "Converts a nested rule into an expression.";

pickRuleValue::usage = "pickRuleValue[rules_, key_] is the same as key /. rules: it just fetches the right-hand side of some rule in the list of rules given a 'key,' that is, a value for the left-hand side.";
pickRule::usage = "pickRule[obj_, key_] fetches the entire rule given a key, that is, the value of the left-hand side of some rule in a list of rules.";

kvpsFromRules::usage = "Convert a nested list of rules into the equivalent list of Kvps.";

(* During Debugging, keep these symbols public. *)

pairsQ::usage = "Temporary.";
keys::usage = "Temporary.";
values::usage = "Temporary.";


Begin["`Private`"]
(* Implementation of the package *)



(* ::Text:: *)
(*Something is a Kvp (key-value pair) if it matches the pattern of a list of two items, the first of which is either a string or a symbol.*)


KvpQ[kvp_List] := MatchQ[kvp, {_Symbol, _} | {_String, _}];
KvpQ[___] = False;


(* ::Text:: *)
(*Something is a list of pairs if it is a list and every element is a pair.*)


pairsQ[list_List] := And @@ (KvpQ /@ list);
pairsQ[___] = False;


(* ::Text:: *)
(*To fetch the keys from a list, map a function that takes the first part of every element over the list. Here, we don't need the presumably expensive check of ?pairsQ on the argument, just the cheap check of List, since this is an internal function.*)


keys[list_List] := #[[1]] & /@ list;


keysUniqueQ[list_List] := Length@Union@keys@list === Length@keys@list;
keysUniqueQ[___] = False;


(* ::Text:: *)
(*To fetch the values, map a function that picks the second element from each internal kvp.*)


values[list_List] := #[[2]] & /@ list


KvpsQ[list_?pairsQ] := keysUniqueQ@list;
KvpsQ[___] = False;


SymbolQ[x_Symbol] = True;
SymbolQ[___] = False;


flat1 = Flatten[#, 1] &;
SelectMany[list_, func_] := Map[func, list] // flat1;


RulesQ[vs_List] := And @@ (MatchQ[#, Rule[_, _]] & /@ vs);
RulesQ[___] = False;


RulessQ[vss_List] := And @@ (RulesQ /@ vss);
RulessQ[___] = False;


Args[e_] := Level[e, 1];


rulesFromExpression[expr_] :=
 If[AtomQ[expr],
  {"AtomicHead" -> Head[expr],
   "Value" -> expr},
  {"Head" -> Head[expr],
   "Args" -> rulesFromExpression /@ Args[expr]}];


expressionFromRules[rule_] :=
 If[("AtomicHead" /. rule) =!= "AtomicHead",
  ToExpression["Value" /. rule],
  Apply[
   ToExpression["Head" /. rule],
   expressionFromRules /@ ("Args" /. rule)]]


pickRuleValue[rule_, key_] := key /. rule; 
pickRule[obj_, key_] := obj /. {___, x : Rule[key, _], ___} -> x;


kvpsFromRules[{}] := {{}};


End[]


EndPackage[]
