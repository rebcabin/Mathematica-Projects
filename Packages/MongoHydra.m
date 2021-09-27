(* ::Package:: *)

(* Mathematica Package *)

(* Created by the Wolfram Workbench Feb 3, 2012 *)

BeginPackage["MongoHydra`", {"JLink`", "MiniData`"}]
(* Exported symbols added here with SymbolName::usage *) 

kvpsFromMongoDoc::usage = "Produces a list of key-value pairs from a mongo document";
mongoDocFromKvps::usage = "Produces a mongo document from a list of key-value pairs";

SymbolQ::usage = "Tests whether its argument is a Symbol";
KvpQ::usage = "Tests whether its argument is a KVPair or KVP, that is, a list of two values, the first of which is a string or symbol Key.";
KvpsQ::usage = "Tests whether its argument is an association list: that is, a list of key-value pairs where no key appears more than once.";
TestJavaClassCanonicalName::usage = "TestJavaClassCanonicalName[javaObject, name] test whether the canonical name of the given java object matches the given string.";
BsonObjectIdQ::usage = "Tests whether its argument if a BSON (Binary JSON) Object Id"
BasicDBObjectQ::usage = "Test whether its argument is a java representative of a Mongo Basic DB object.";

RulesQ::usage = "Tests whether its argument is a list of Rules, which is the Import/Export preferred representation for key-value pairs (the analog 'lookup' for rules is just 'Replace.')";
RulessQ::usage = "Tests whether its argument is a list of list of Rules, which is the preferred representation for argument lists.";

Args::usage = "Counterpoint to built-in Head, produces all the arguments of a composite expression.";

rulesFromExpression::usage = "Converts an arbitrary expression into nested rules, primarily for dehydration.";
expressionFromRules::usage = "Converts a nested rule into an expression, primarily for rehydration.";

pickRuleValue::usage = "pickRuleValue[rules_, key_] is the same as key /. rules: it just fetches the right-hand side of some rule in the list of rules given a 'key,' that is, a value for the left-hand side.";
pickRule::usage = "pickRule[obj_, key_] fetches the entire rule given a key, that is, the value of the left-hand side of some rule in a list of rules.";

rulesFromMongoDoc::usage = "Produces a nested list of rules representing key-value pairs from a mongo document.";
mongoDocFromRules::usage = "Produces a mongo document from a nested list of rules representing key-value pairs.";

kvpsFromRules::usage = "Convert a nested list of rules into the equivalent list of Kvps.";

(* During Debugging, keep these symbols public. *)

pairsQ::usage = "Temporary.";
kvpFromHme::usage = "Temporary.";
kvpsFromHmes::usage = "Temporary.";
rulesFromHmes::usage = "Temporary.";
valueFromJavaObject::usage = "Temporary.";
hmesFromMongoDoc::usage = "Temporary.";

(* *)


Begin["`Private`"]
(* Implementation of the package *)



(* Something is a Kvp (key-value pair) if it matches the pattern 
   of a list of two items, the first of which is either a string
   or a symbol. *)
KvpQ[kvp_List] := MatchQ[kvp, {_Symbol, _} | {_String, _}];
KvpQ[___] = False;

(* Something is a list of pairs if it is a list and every element
   is a pair. *)
pairsQ[list_List] := And @@ (KvpQ /@ list);
pairsQ[___] = False;

(* To fetch the keys from a list, map a function that takes the 
   first part of every element over the list. Here, we don't need
   the presumably expensive check of ?pairsQ on the argument, just
   the cheap check of List, since this is an internal function. *)


keys[list_List] := #[[1]] & /@ list;

(* To check *)
keysUniqueQ[list_List] := Length@Union@keys@list === Length@keys@list;
keysUniqueQ[___] = False;



values[list_List] := #[[2]] & /@ list



KvpsQ[list_?pairsQ] := keysUniqueQ@list;
KvpsQ[___] = False;



TestJavaClassCanonicalName[javaObject_?JavaObjectQ, name_String] :=
  javaObject@getClass[]@getCanonicalName[] === name;
TestJavaClassCanonicalName[___] = False;



BsonObjectIdQ[value_] := 
  TestJavaClassCanonicalName[value, "org.bson.types.ObjectId"];
  


BasicDBObjectQ[value_] := 
  TestJavaClassCanonicalName[value, "com.mongodb.BasicDBObject"] ||
   TestJavaClassCanonicalName[value, "com.mongodb.CommandResult"];



(* ::Subsection:: *)
(* kvpsFromMongoDoc[mongoDoc_] *)


SymbolQ[x_Symbol] = True;
SymbolQ[___] = False;


hmesFromMongoDoc[mongoDoc_?BasicDBObjectQ] := 
  mongoDoc@toMap[]@entrySet[]@toArray[];

(* Pass in the recurser to every rule because this guy gets
   called from both kvpsFromMongoDoc and rulesFromMongoDoc. 
   The recurser only gets used in one rule. *)
   
(* from a BsonObjectId *)
valueFromJavaObject[jobj_?BsonObjectIdQ, recurser_] :=
  (
   Print["BsonObjectId: "<>jobj@toStringMongod[]]; 
   jobj@toStringMongod[]); (* method on org.bson.types.ObjectId *)

(* recursive,nested case *)
valueFromJavaObject[jobj_?BasicDBObjectQ, recurser_] :=
  (
   Print["Recurse: "];
   recurser@hmesFromMongoDoc@jobj);

(* from a general java object *)
valueFromJavaObject[jobj_?JavaObjectQ, recurser_] :=
  (
   Print["General: "<>ToString[
     With[{result=JavaObjectToExpression@jobj},
       If[ListQ[result],
         valueFromJavaObject[#, recurser]& /@result,
         result]],InputForm]];
   With[{result = JavaObjectToExpression@jobj},
     If[ListQ[result],
       valueFromJavaObject[#, recurser]& /@ result,
       result]]);

(* from a java object that hasn't been cycled through Mongo yet *)
(* If you make a JavaObject from an Array (List), then put it in 
   a document, then get the HMEs from the document, then do 
   getValue[], you will get a LIST and not a general Java 
   Object that you convert to a list via JavaObjectToExpression.
   Example:  
    $foo = JavaNew["com.mongodb.BasicDBObject"];
	$foo@put["bar",
	   MakeJavaObject[
	    MakeJavaObject /@
	     {"baz", "qux"}]];
	((hmesFromMongoDoc@$foo)[[1]])@getValue[]
	~~> {"baz", "qux"}
	Apparently the PUT transforms the list from a Java Object
	representing a list back into a MMA list.
   *)
valueFromJavaObject[jobj_?ListQ, recurser_] :=
  (
   Print["List: "<>ToString[
       valueFromJavaObject[#, recurser]& /@ jobj,
       InputForm]];
   valueFromJavaObject[#, recurser]& /@ jobj);

(*from a string*)
valueFromJavaObject[jobj_String, recurser_] :=
 (Quiet[With[{attempt = ToExpression@jobj},
    If[attempt === $Failed,
     (
        Print["String: FAILED: "<>
          ToString[jobj,InputForm]];
      jobj),
	    If[SymbolQ@attempt,
	    (
	      Print["String: SYMBOL: "<>
	        ToString[jobj,InputForm]];
	      jobj),
	    (
	      Print["String: NOTSYM: "<>
	        ToString[attempt,InputForm]];
	      attempt)]]]])

(*catch-all case-- preventing exceptions*)
valueFromJavaObject[obj_, recurser_] :=
 (
  Print["CatchAll: "<>ToString[obj,InputForm]];
  obj)

kvpFromHme[
  hme_?JavaObjectQ] := {hme@getKey[],
      valueFromJavaObject[hme@getValue[], kvpsFromHmes]}

kvpsFromHmes[hmes_] := kvpFromHme /@ hmes

kvpsFromMongoDoc[mongoDoc_] := kvpsFromHmes@hmesFromMongoDoc@mongoDoc



(* ::Subsection:: *)
(*mongoDocFromKvps[kvps_]*)


flat1 = Flatten[#, 1] &;
SelectMany[list_, func_] := Map[func, list] // flat1;

(* Symbol keys are translated to strings when they go into a 
   mongo doc. *)
(* Why?  Mongo doc does not have a native representation for 
   symbols.  There is a minor fault when round-tripping.  We
   admit symbols going in, because they're very convenient in
   MMA; but we only get string keys on the way back out. *)

(* First, the recursive case where the value is a Kvps *)
putHmeInDocFromKvp[doc_?BasicDBObjectQ, {k_, v_?KvpsQ}] :=
  (doc@put[ToString[k], mongoDocFromKvps@v]);
  
(* Next, the general case for any value. *)
putHmeInDocFromKvp[doc_?BasicDBObjectQ, {k_, v_}] :=
  (doc@put[ToString[k],
     Quiet[(* Expect a message on the MakeJavaObject call. *)
      (* Quiet absorbs all messages; TODO: overkill? *)
      With[{attempt = MakeJavaObject[v]},
       If[$Failed === attempt,
        MakeJavaObject[ToString[v, InputForm]],
        attempt]]]]);

mongoDocFromKvps[kvps_] :=
 With[
  {doc = JavaNew["com.mongodb.BasicDBObject"]},
  putHmeInDocFromKvp[doc, #] & /@ kvps;
  doc]



(* ::Subsection:: *)
(*rulesFromMongoDoc[mongoDoc_]*)


ruleFromHme[hme_?JavaObjectQ] :=
  (* first element of the returned kvp *)
  hme@getKey[] ->
  (* second element of the returned kvp *)
  valueFromJavaObject[hme@getValue[], rulesFromHmes] 
  
rulesFromHmes[hmes_] := ruleFromHme /@ hmes

rulesFromMongoDoc[mongoDoc_] := 
 rulesFromHmes@hmesFromMongoDoc@mongoDoc
 


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


(* First,the recursive case where the value is a list of rules *)
putHmeInDocFromRule[doc_?BasicDBObjectQ, 
   Rule[k_, vs_?RulesQ]] := 
     ((*Print[InputForm["RECURSE: " <>
      "k: " <> ToString[k, InputForm] <> ", v: " <>
      ToString[
       rulesFromMongoDoc@
        mongoDocFromRules@vs,
       InputForm]]];*) 
     (doc@put[ToString[k], mongoDocFromRules@vs])
     );

(*  *)

(* Next,the general case for any value. *)
putHmeInDocFromRule[doc_?BasicDBObjectQ, 
   Rule[k_, v_]] := (
     doc@put[ToString[k],
     (* Expect message on the MakeJavaObject call. *)
     (* Quiet absorbs all messages; TODO: overkill? *)
     Quiet[
      With[{attempt = MakeJavaObject[v]},
       
       If[$Failed === attempt,
        
        ((*Print[InputForm["BASE FAILED: " <>
            "k: " <> ToString[k, InputForm] <>
            ", v: " <> ToString[v, InputForm]]];*)
         
         MakeJavaObject[ToString[v, InputForm]]
         ),
        
        ((*Print[InputForm["BASE SUCCESS: " <>
            "k: " <> ToString[k, InputForm] <>
            ", v: " <> ToString[v, InputForm]]];*)
         
         attempt
         
        )
       ]]]]);



(* ::Subsection:: *)
(*mongoDocFromRules[rules_]*)


mongoDocFromRules[rules_] := 
  With[{doc = JavaNew["com.mongodb.BasicDBObject"]}, 
   putHmeInDocFromRule[doc, #] & /@ rules;
   doc];
  
  

End[]

EndPackage[]

