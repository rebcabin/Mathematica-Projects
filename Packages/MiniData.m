(* ::Package:: *)

(* :Name: MiniData` *)

(* :Title: Mini Data Library for associations, rules, and tables *)

(* :Author: Brian Beckman *)

(* :Summary:

 Provides functions for manipulating associative lists and arrays.
 IN PROGRESS: Dictionary ADT, simpler than Sal Mangano's.
 IN PROGRESS: Support for rule-based representations.
 IN PROGRESS: May grow into support for relational algebra.
 IN PROGRESS: Support for MongoDb

*)

(* :Context: MiniData` *)

(* :Package Version: 2.0 *)

(* :Copyright: Copyright 2010, 2012, Brian Beckman, Microsoft Corporation *)

(* :History:
 Version 2.0 by Brian Beckman, Feb 2012. 
*)

(* :Keywords:
Data
Structured Data
Unstructured Data
SQL
noSQL
Tables
Relational Data
Relational Database
Tabular Data
Records
Record Data
Unstructured Data
Document Stores
Key-Value Pairs
Key-Value Store
Key-Value Stores
Name-Value Pairs
Association Lists
Associative Lists
Associative Arrays
Association Arrays
Associative Vectors
Association Vectors
Associative Rules
Association Rules
Associative Memory
*)

(* :Source: *)

(* :Mathematica Version: 8.0 *)

(* :Limitation: *)

(* :Discussion: 

This breaks code that depended on version 1.0.

The fundamental abstraction here is a [partial function].  A partial
function is a subset F of a Cartesian product of two sets, the domain
D and the codomain C, such that no element of D appear more than once
in F.  The function is called partial because not every element of D
need appear in the subset.

This abstraction appears in many, many guises in the world of
computing.  One guise is as a [record], in which the elements of D are
called [primary keys] and the rest of the columns in the record
constitute an element of C.  Another guise is as a collection of
[key-value pairs], in which the set K of keys is D and the set V of
values is C.  Another guise is as [dictionaries] in Java and C#.NET,
which are lookup structures usually implemented as hash tables or
search trees.

In this package, we call a partial function an [association], and we
abbreviate an association as A or a.  This package supports both
functions that operate on associations at a high level and functions
that operate on the representations of associations.  The
representations of associations are [association list], [association
vector], and [association rules].  The association-list representation
has the advantages of direct input and output and of displaying
beautifully in notebooks by exploiting MatrixForm, TableForm, and
TraditionalForm.  The association-vector representation has the
advantage of functional notation, as in assoc[key] ~~> value and the
advantage of superior performance.  The association-rule
representation has the advantage of mass application of lookups, as in
{key1, key2, ...}  /. assocRules ~~> {val1, val2, ...} and of
compatibility with Mathematica's representation of JSON objects.

In the present version, all keys must be strings.  Supplied keys will
be converted to strings on a best-effort basis.

The abstractions we support at a high level for associations are the
following:

adjoin[a, k, v] ~~> fresh copy of a, preserving representation, with
  {ToString@k, v} unconditionally added, that is, where v replaces any
  prior value that may have been associated with the key.

  EXAMPLES:
  with a as an association list:
    adjoin[{}, "a", 1] ~~> {{"a", 1}}
    adjoin[{{"a", 1}}, {{"a", 2}}] ~~> {{"a", 2}}
    adjoin[{{"a", 1}}, {{"b", 2}}] ~~> {{"a", 1}, {"b", 2}}
  likewise if the input is an association vector or association rules;
  the output will be of the same representation. 

conjoin[a, k, v] ~~> fresh copy of a with {ToString@k, v}
  conditionally added, that is, where any prior value associated with
  the key k is not replaced.

  EXAMPLES:
  with a as an association list:
    conjoin[{}, "a", 1] ~~> {{"a", 1}}
    conjoin[{{"a", 1}}, {{"a", 2}}] ~~> {{"a", 1}}
    conjoin[{{"a", 1}}, {{"b", 2}}] ~~> {{"a", 1}, {"b", 2}}
  likewise if the input is an association vector or association rules;
  the output will be of the same representation. 

[ad/con]join[a, {{k, v}, ...}] ~~> apply adjoin or conjoin for all the
  key-value pairs in the list {{k, v}, ...}, after applying ToString
  to every k, and produce the final result.

lookup[a, k] ~~> the value v corresponding to the key k if k is
  present explicitly in a, else the distinguished value Null.  Note
  that, logically, we may interpret Null as the value for every input
  key not explicitly supplied, so we may view a as a TOTAL function of
  the keys where most values are Null.  Whether to consider a as a
  partial function or as a total function is a matter of interpreting
  Null.

  EXAMPLES:
  lookup[{{"a", 1}}, "a"] ~~> 1
  lookup[{{"a", 1}}, "b"] ~~> Null

keys[a] ~~> List of keys in the association a.

getSchema[a] ~~> List of keys in the association a.

values[a] ~~> List of values in the association a.

getValues[a] ~~> List of value in the association a.

containsKey[a, k] ~~> True iff ToString@k has a non-Null value in a.

removeKey[a, k] ~~> fresh copy of a with any non-null value of
  ToString@k removed.  In other words, lookup[removeKey[a, k], k] ~~>
  Null

fetchAttribute[a, k] ~~> {ToString@k, v}, where v is lookup[a, k], and
  produces {ToString@k, Null} if ToString@k is not present in a.

An [association list] or [al] is a list of [attributes], that is,
[key]-[value] pairs, where the keys are always strings and the values
can be anything.  E.g., {{"foo", 1}, {"bar", 2}, {"baz", {{"a, 1},
{"b", 2}}.  No duplicate keys allowed, order is not significant.  This
representation produces beautiful displays in TraditionalForm,
TableForm, and MatrixForm because a list of key-value pairs may also
be viewed as a 2 x n matrix.

TODO: allow keys to be symbols or anything else, a-la hashmaps in 
Clojure. 

TODO: implement [key]-[(value, type)] to allow type assertions. 

*)


BeginPackage["MiniData`"];


IndexOfMaxs::usage = "IndexOfMaxs[<list>,<opt:transformFn>] ~~> <integerIndex>";
IndexOfMins::usage = "IndexOfMins[<list>,<opt:transformFn>] ~~> <integerIndex>";

IndexMaxs::usage = "IndexMaxs[<list>,<opt:transformFn>] ~~> {<integerIndex>,<MaxValue>}";
IndexMins::usage = "IndexMins[<list>,<opt:transformFn>] ~~> {<integerIndex>,<MinValue>}";

ArgIndexMaxs::usage = "ArgIndexMaxs[<list>,<opt:transformFn>] ~~> {<elementProducingMax>,<integerIndex>,<MaxValue>}";
ArgIndexMins::usage = "ArgIndexMins[<list>,<opt:transformFn>] ~~> {<elementProducingMin>,<integerIndex>,<MinValue>}";

isPairList::usage = "isPairList[<object>] ~~> <bool>, True if input is a list of pairs, regardless if there are duplicated keys.";
alFromPairList::usage = "alFromPairList[<listOfPairs>] ~~> <aList>; keeps only the last pair of pairs that have the same keys.";
alFromPairsList::usage = "alFromPairsList[<listOfPairs>] ~~> <aList>; keeps only the last pair of pairs that have the same keys.";

isAl::usage = "isAl[<object>] ~~> <bool>, True if input is an association list";
isAv::usage = "isAv[<object>] ~~> <bool>, True if input is an association vector";
isAs::usage = "isAs[<object>] ~~> <bool>, True if input is an asociation";

al2Av::usage = "al2Av[<aList>] ~~> <aVec>";
av2Al::usage = "av2Al[<aVec>] ~~> <aList>";
as2Al::usage = "as2Al[<aList|aVec>] ~~> <aList>";

avFromAl::usage = "avFromAl[<aList>] ~~> <aVec>";
alFromAv::usage = "alFromAv[<aVec>] ~~> <aList>";
alFromAs::usage = "alFromAs[<aList|aVec>] ~~> <aList>";

lookup::usage = "lookup[<assoc>,<key>] ~~> <value>, <aVec>[<key>] ~~> <value>";
lookupWithDefault::usage = "lookupWithDefault[<assoc>,<key>,<default>] ~~> <value> or <default>";

containsKey::usage = "containsKey[<assoc>,<key>] ~~> <bool>";
removeKey::usage = "removeKey[<assoc>,<key>] ~~> <assoc>";

fetchAttribute::usage = "fetchAttribute[<assoc>,<key> ~~> {<key>,<value>}; value is Null if key is absent from the assoc.";
fetchRule::usage = "fetchRule[<assoc>,<key>] ~~> <key> -> <value>; value is Null if key is absent from the assoc";

adjoin::usage = "adjoin[<assoc>,<key>,<value>] ~~> <assoc>; adjoin[<assoc1>, <assoc>] ~~> <assoc2>; Adjoin overwrites values.";
conjoin::usage = "conjoin[<assoc>,<key>,<value>] ~~> <assoc>; conjoin[<assoc1>, <assoc>] ~~> <assoc2>; Conjoin does not overwrite values";

getSchema::usage = "getSchema[<assoc>] ~~> {<key>, ...}";
keys::usage = "keys[<assoc>] ~~> {<key>, ...}";

getValues::usage = "getValues[<assoc>] ~~> {<value>, ...}";
values::usage = "values[<assoc>] ~~> {<value>, ...}";

alFromSchemaAndRecord::usage = "alFromSchemaAndRecord[<schema>,<record>] ~~> <aList>";
avFromSchemaAndRecord::usage = "avFromSchemaAndRecord[<schema>,<record>] ~~> <aVec>";

schemaAndRecord2Al::usage = "schemaAndRecord2Al[<schema>,<record>] ~~> <aList>";
schemaAndRecord2Av::usage = "schemaAndRecord2Av[<schema>,<record>] ~~> <aVec>";

equalAvs::usage = "equalAvs[<aVec>,<aVec>] ~~> bool";

copyAv::usage = "copyAv[<aVec>] ~~> <aVec>";

sieve::usage = "sieve[<assoc>,<keyList>] ~~> {<assoc(matchingKeys)>,<assoc(notMatchingKeys)>}";


Begin["`Private`"];


(* inspects every element, thus only works for finite lists *)

IndexOfMaxs[{xs___},vf_:(#&)]:=indexOfMaxsHelper[{xs},vf,-Infinity,0,1];
indexOfMaxsHelper[{},vf_,cm_,i_,j_]:=i;
indexOfMaxsHelper[{x_,xs___},vf_,cm_,i_,j_]:=indexOfMaxsHelper[{xs},vf,vf@x,j,j+1]/;(vf@x)>=cm;
indexOfMaxsHelper[{x_,xs___},vf_,cm_,i_,j_]:=
indexOfMaxsHelper[{xs},vf,cm,i,j+1];


IndexOfMins[{xs___},vf_:(#&)]:=indexOfMinsHelper[{xs},vf,Infinity,0,1];
indexOfMinsHelper[{},vf_,cm_,i_,j_]:=i;
indexOfMinsHelper[{x_,xs___},vf_,cm_,i_,j_]:=indexOfMinsHelper[{xs},vf,vf@x,j,j+1]/;(vf@x)<=cm;
indexOfMinsHelper[{x_,xs___},vf_,cm_,i_,j_]:=
indexOfMinsHelper[{xs},vf,cm,i,j+1];


IndexMaxs[{xs___},vf_:(#&)]:=indexMaxsHelper[{xs},vf,-Infinity,0,1];
indexMaxsHelper[{},vf_,cm_,i_,j_]:={i,cm};
indexMaxsHelper[{x_,xs___},vf_,cm_,i_,j_]:=indexMaxsHelper[{xs},vf,vf@x,j,j+1]/;(vf@x)>=cm;
indexMaxsHelper[{x_,xs___},vf_,cm_,i_,j_]:=
indexMaxsHelper[{xs},vf,cm,i,j+1];


IndexMins[{xs___},vf_:(#&)]:=indexMinsHelper[{xs},vf,Infinity,0,1];
indexMinsHelper[{},vf_,cm_,i_,j_]:={i,cm};
indexMinsHelper[{x_,xs___},vf_,cm_,i_,j_]:=indexMinsHelper[{xs},vf,vf@x,j,j+1]/;(vf@x)<=cm;
indexMinsHelper[{x_,xs___},vf_,cm_,i_,j_]:=
indexMinsHelper[{xs},vf,cm,i,j+1];


ArgIndexMaxs[{xs___},vf_:(#&)]:=argIndexMaxsHelper[{xs},{xs},vf,-Infinity,0,1];
argIndexMaxsHelper[orig_,{},vf_,cm_,i_,j_]:={orig[[i]],i,cm};
argIndexMaxsHelper[orig_,{x_,xs___},vf_,cm_,i_,j_]:=With[{t=vf@x},
    If[t>=cm,
        argIndexMaxsHelper[orig,{xs},vf,t, j,j+1],
        argIndexMaxsHelper[orig,{xs},vf,cm,i,j+1]]]


ArgIndexMins[{xs___},vf_:(#&)]:=argIndexMinsHelper[{xs},{xs},vf,Infinity,0,1];
argIndexMinsHelper[orig_,{},vf_,cm_,i_,j_]:={orig[[i]],i,cm};
argIndexMinsHelper[orig_,{x_,xs___},vf_,cm_,i_,j_]:=With[{t=vf@x},
    If[t<=cm,
        argIndexMinsHelper[orig,{xs},vf,t, j,j+1],
        argIndexMinsHelper[orig,{xs},vf,cm,i,j+1]]]

isPairList[xs_] := MatchQ[xs, {{_, _}...}];
isPairsList = isPairList;

alFromPairList[xs_?isPairList] := av2Al@al2Av@xs;
alFromPairsList[xs_?isPairList] := av2Al@al2Av@xs;


isAl[{}] := True;
isAl[xs_] := 
     isPairList[xs] \[And]
     (* Note this calls keys! -- don't let keys call this! *)
     Length@keys[xs] === Length[xs] \[And]
     Length[Cases[xs, {_String, _}]] === Length[xs];
isAl[___] := False;

(* An Av must be a symbol; it can either have no downvalues, that is, 
   be empty, or it can have downvalues.  Any symbol with downvalues
   must be considered an av, but not all avs can be converted to als *)
isAv[d_Symbol] := With[{dv = DownValues[d]},
    If[dv === {}, True, True]]; 
    (* Seems a bit vapid, but this code just records the fact that 
       we've considered both possibilities. *)
isAv[___] := False; 

(* Convert into aV from an aL *)
avFromAl[x_] := al2Av[x]; (* directional synonym *)
al2Av[{}] := Unique[]; (* return a fresh symbol *)
(* This one will be a little forgiving and admit pairlists that
   may have duplicate keys.  The reason is to exploit it to remove
   duplicate keys from pairList inputs.  This is unlikely to 
   cause nasty surprises, but it is an implementation choice. *)
al2Av[xs_List] := Module[{d}, (* make fresh symbol *)
    With[{
        n = #[[1]],
        v = al2Av[#[[2]]]}, (* recurse *)
       d[n] = v] & /@ xs; d] /;
    isPairList[xs];
(* pass through all other values for recursion. *)
al2Av[xs___] := xs;

(* Convert into aL From aV *)
alFromAv[x_] := av2Al[x];
(* Produces {} when aVec is empty. *)
av2Al[d_Symbol] := 
  With[{al = Sort @ Union @ 
	({#[[1, 1, 1]], #[[2]]} & /@ DownValues[d])},
   av2Alaa /@ al]; 
(* Default to Id when input is not a symbol. *)
av2Al[xs___] := xs;
(* Helpers: Convert nested aVecs. *)
av2Alaa[l_List] := {#[[1]], av2Albb[#[[2]]]} &@l /; Length[l] == 2;
(* recurse *)
av2Albb[d_Symbol] := av2Al[d] /; DownValues[d] =!= {};
av2Albb[d_Symbol] := d /; DownValues[d] === {};
av2Albb[value_] := av2Al[value]; 

(* generic abstraction *)
isAs[x_] := (isAv[x] || isAl[x]);
isAs[___] := False;

alFromAs[x_] := as2Al[x] /; isAs[x];
as2Al[a_] := If[isAv[a], av2Al@a, a] /; isAs[a];
as2Av[a_] := If[isAv[a], a, al2Av@a] /; isAs[a];

(* Schema always returns a list *)
keys[a_] := getSchema[a];
getSchema[al_List] := Sort @ Union @ (First /@ al);
getSchema[av_Symbol] := Sort @ (#[[1, 1, 1]] & /@ DownValues[av]);

values[a_] := getValues[a];
(* get the values in the canonical sort order that the keys come out *)
getValues[al_List] := (#[[2]]&) /@ (lookup[#, al]& /@ keys[al]);
getValues[av_Symbol] := getValues@av2Al@av;

alFromSchemaAndRecord[schema_List, record_List] := schemaAndRecord2Al[schema, record];
avFromSchemaAndRecord[schema_List, record_List] := schemaAndRecord2Av[schema, record];

schemaAndRecord2Al[schema_List, record_List] :=
  alFromPairsList@ MapThread[List, {schema, record}];
schemaAndRecord2Av[schema_List, record_List] := al2Av@schemaAndRecord2Al[schema, record];


copyAv[av_] := al2Av[av2Al[av]];


equalAvs[av1_, av2_] := SameQ[av2Al[av1], av2Al[av2]];


(* Overwrites key if it's already there. *)
adjoin[l_List,   k_, v_] := Sort@ With[{sk = ToString@k}, Prepend[removeKey[l, sk], {sk, v}]]
adjoin[d_Symbol, k_, v_] := Module[{d2 = copyAv[d]}, d2[ToString@k] = v; d2];
adjoin[d1_Symbol, d2_Symbol] := adjoin[d1, av2Al@d2]; (* recurse *)

(* Next works for all kinds of associations *)
adjoin[a_, {pairs__}] := Fold[adjoin[#1, ToString[#2[[1]]], #2[[2]]]&, a, {pairs}] /; isAl[{pairs}];
adjoin[l_List, ___] := l;

(* Will not overwrite key if it's already there. *)
conjoin[l_List,   k_, v_] := Sort@ With[{sk = ToString@k}, If[MemberQ[l, {sk, _}], l, Prepend[l, {sk, v}]]];
conjoin[d_Symbol, k_, v_] := If[containsKey[d, k], d, adjoin[d, k, v]];
conjoin[d1_Symbol, d2_Symbol] := conjoin[d1, av2Al@d2]; (* recurse *)

(* Next works for all kinds of associations *)
conjoin[a_, {pairs__}] := Fold[conjoin[#1, ToString[#2[[1]]], #2[[2]] ]&, a, {pairs}] /; isAl[{pairs}];
conjoin[l_List, ___] := l;


containsKey[l_List,   k_] := MemberQ[l, {ToString@k, _}]; 
containsKey[d_Symbol, k_] := 
    (* Implementation via ValueQ a bit problematic.  The following straightforward approach *)
    (* doesn't work well: *)
    (*   ValueQ[d[ToString@k]]; *)
    (* The culprit seems to be symbols returned by Unique[] and then assigned *)
    (* to other symbols appear to reduce. *)
    (* For reasons not entirely clear, the following also do not work: *)
    (*   ValueQ[(Evaluate[d])[ToString@k]] *)
    (*   With[{y = Evaluate@d}, ValueQ[y[ToString@k]]] *)
    (* Instead, we are left with the followin straightforward approach: *)
    Head[d[ToString@k]] =!= d;
    (* meaning fails to non-reduce *)


removeKey[l_List,   k_] := With[{sk = ToString@k}, Select[l, #[[1]] =!= sk&]];
removeKey[d_Symbol, k_] := al2Av[removeKey[av2Al[d], k]];


fetchAttribute[l_List, k_] := 
  Module[{sk = ToString@k, z},
    z = Select[l, #[[1]] === sk &];
    If[z =!= {}, z[[1]], {k, Null}]]; (* keep only first of multiples *)

fetchAttribute[v_Symbol, k_] := With[{sk = ToString@k}, 
    If[containsKey[v, k], {k, v[sk]}, {k, Null}]];

fetchRule[a_, k_] := Rule@@fetchAttribute[a, k];


lookup[l_List, k_]:=
  With[{a = fetchAttribute[l, k]},
    If[a =!= Null, a[[2]], Null]];

lookup[v_Symbol, k_] := 
  With[{sk = ToString@k}, 
    If[containsKey[v, sk], v[sk], Null]];

lookupWithDefault[d_, k_, default_]:=
  With[{c = lookup[d,k]},
    If[c === Null, default, c]];


sieve[alist_?isAl, keys_List] := 
	Sort /@
	Reverse @ 
	GatherBy[alist, MatchQ[#, 
	    Alternatives @@ Map[{#, _}&, keys]] &]


(* TODO: Add a variant that sieves association vectors (since this appears 
AFTER the definition that matches lists, it will only be matched when 
that one isn't). This isn't efficient: it puts everything into list 
form, does the computation there, then puts everything back into 
vectorform. *)

sieve[avector_Symbol, keys_List] := al2Av /@ sieve[av2Al[avector], keys];


End[];(* Private *)


EndPackage[];
