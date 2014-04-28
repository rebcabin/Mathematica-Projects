(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 9.0' *)

(*************************************************************************)
(*                                                                       *)
(*  The Mathematica License under which this file was created prohibits  *)
(*  restricting third parties in receipt of this file from republishing  *)
(*  or redistributing it by any means, including but not limited to      *)
(*  rights management or terms of use, without the express consent of    *)
(*  Wolfram Research, Inc. For additional information concerning CDF     *)
(*  licensing and redistribution see:                                    *)
(*                                                                       *)
(*        www.wolfram.com/cdf/adopting-cdf/licensing-options.html        *)
(*                                                                       *)
(*************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1063,         20]
NotebookDataLength[    132118,       4202]
NotebookOptionsPosition[    116216,       3684]
NotebookOutlinePosition[    116748,       3705]
CellTagsIndexPosition[    116705,       3702]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["Polymorphism and Interfaces in Mathematica", "Title"],

Cell["\<\
Brian Beckman\[LineSeparator]Version of 26 December 2013\
\>", "Subtitle"],

Cell[CellGroupData[{

Cell["Introduction", "Section"],

Cell[TextData[{
 "Imagine the classic C# Enumerable API, leaving out ",
 StyleBox["Reset",
  FontSlant->"Italic"],
 ", and implement it for ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " Lists and ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " hash tables, which are lists of replacement rules subject to ",
 StyleBox["Dispatch",
  FontSlant->"Italic"],
 ". This serves as an illustration of a way to implement polymorphic \
interfaces, that is, interfaces implemented differently by different concrete \
providers."
}], "Text"],

Cell["\<\
Then step via the now-classic duality argument [1] to interfaces for \
Observable and Observer.\
\>", "Text"]
}, Open  ]],

Cell[CellGroupData[{

Cell["References", "Section"],

Cell[CellGroupData[{

Cell["\<\
Enumerable Dual to Observable: http://stanford.io/1kw535m\
\>", "ItemNumbered"],

Cell["\<\
IEnumerator Interface: http://bit.ly/1jxWqHe\
\>", "ItemNumbered"],

Cell["\<\
Pattern-Matching Bug: http://bit.ly/1bosOYv\
\>", "ItemNumbered"],

Cell["Standard Query Operators: http://bit.ly/IS29t3", "ItemNumbered"],

Cell["\<\
Possible Notebook Bug: http://bit.ly/1gUoJQD\
\>", "ItemNumbered"],

Cell["\<\
Clojure's hash-map API: http://clojure.org/data_structures\
\>", "ItemNumbered"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Object-Oriented Programming (OOP)", "Section"],

Cell[TextData[{
 "Represent oop's objects as explicit lists of rules that transform patterns \
into expressions. When an object goes out of scope, its list of rules is \
garbage-collected. This representation avoids stocking ",
 StyleBox["Mathematica'",
  FontSlant->"Italic"],
 "s global symbol table with rules, avoiding, in-the-offing, explicit memory \
management for those rules. "
}], "Text",
 CellChangeTimes->{{3.605116251000679*^9, 3.6051162533984003`*^9}}],

Cell["\<\
Every object-as-instance-of-a-class must have a rule for every class member. \
Likewise, an object-as-implementor-of-interfaces must have a rule for every \
member of every interface that the object implements. \
\>", "Text"],

Cell[TextData[{
 "We say that an object ",
 StyleBox["provides",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " implementations for its class's and interface's members, or that the \
object is a ",
 StyleBox["provider",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " of its class's and interface's members. In both cases, the object provides \
implementations by providing rewrite rules. "
}], "Text"],

Cell[CellGroupData[{

Cell["Type-Checking", "Subsection"],

Cell[TextData[{
 "We insist that an object must be a list of rewrite rules explicitly \
constructed in a ",
 StyleBox["Dispatch", "Input"],
 " table, i.e., an expression with Head ",
 StyleBox["Dispatch", "Input"],
 ". "
}], "Text"],

Cell[TextData[{
 "Since ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " rewrites dispatches back to lists at its own discretion, we cannot be sure \
that every object is a ",
 StyleBox["Dispatch", "Input"],
 " even if we insist that the user explicitly construct objects by invoking \
",
 StyleBox["Dispatch", "Input"],
 ". Instead, we can only check that an object is either a ",
 StyleBox["List", "Input"],
 " or a ",
 StyleBox["Dispatch", "Input"],
 ", and that's what the helper function ",
 StyleBox["ObjectQ", "Input"],
 " does. This helper is invoked as part of the pattern-matching at call sites \
of functions that require objects. This invocation at the call site \
implements run-time type checking."
}], "Text"],

Cell[CellGroupData[{

Cell["RuleQ, PatternQ, ObjectQ", "Subsubsection",
 CellChangeTimes->{{3.6051163057486887`*^9, 3.6051163120103407`*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"ClearAll", "[", 
    RowBox[{"RuleQ", ",", "PatternQ", ",", "ObjectQ"}], "]"}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"RuleQ", "[", "this_", "]"}], ":=", 
    RowBox[{"With", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"k", "=", 
        RowBox[{"Head", "@", "this"}]}], "}"}], ",", 
      RowBox[{
       RowBox[{"k", "===", "Rule"}], "||", 
       RowBox[{"k", "===", "RuleDelayed"}]}]}], "]"}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"PatternQ", "[", "pattern_", "]"}], ":=", "True"}], ";"}], 
  "\[IndentingNewLine]", 
  RowBox[{"(*", " ", 
   RowBox[{
    RowBox[{
    "Is", " ", "this", " ", "even", " ", "well", " ", "founded", " ", 
     "question"}], ",", " ", 
    RowBox[{
    "since", " ", "any", " ", "expression", " ", "may", " ", "appear", " ", 
     "in", " ", "a", " ", "pattern", " ", "position"}]}], " ", "*)"}], 
  "\[IndentingNewLine]", 
  RowBox[{"(*", " ", 
   RowBox[{
   "Perhaps", " ", "we", " ", "should", " ", "ask", " ", "if", " ", 
    "something", " ", "is", " ", "nothing", " ", "BUT", " ", "a", " ", 
    "pattern"}], " ", "*)"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"ObjectQ", "[", "this_", "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"Switch", "[", 
   RowBox[{
    RowBox[{"Head", "@", "this"}], ",", "\[IndentingNewLine]", "Dispatch", 
    ",", "True", ",", "\[IndentingNewLine]", "List", ",", 
    RowBox[{"(*", " ", 
     RowBox[{
     "Ensure", " ", "every", " ", "element", " ", "is", " ", "a", " ", 
      "rule"}], " ", "*)"}], 
    RowBox[{"this", "===", 
     RowBox[{"Select", "[", 
      RowBox[{"this", ",", "RuleQ"}], "]"}]}], ",", "\[IndentingNewLine]", 
    "_", ",", "False"}], "]"}]}]}], "Input",
 CellChangeTimes->{{3.60534628261515*^9, 3.6053463197283363`*^9}}],

Cell[TextData[{
 "To type-check that an object provides a certain class or interface, just \
check that its list-of-rules or its ",
 StyleBox["Dispatch", "Input"],
 " contains rules for each required member. "
}], "Text"],

Cell[TextData[{
 "Represent types -- i.e., either classes or interfaces -- as lists of the \
patterns -- i.e., left-hand-sides -- required for each rule -- i.e., member \
-- of some concrete representation -- i.e., object. For example, every \
provider of ",
 StyleBox["IEnumerator", "Input"],
 " must provide a rule with a pattern ",
 StyleBox["MoveNext[]", "Input"],
 " -- a void-to-Boolean method -- and a pattern for ",
 StyleBox["Current", "Input"],
 " -- a property producing a value. "
}], "Text"],

Cell[TextData[{
 "To check that an object provides such rules, extract the patterns on the \
left-hand sides of the rules of the object, then check that they are a \
superset of  the required patterns. A subtlety is that names must be stripped \
from parameters of patterns-with-parameters, leaving only the types of \
parameters. For example, we must convert ",
 StyleBox["MoveNext[i_Integer]", "Input"],
 " to ",
 StyleBox["MoveNext[_Integer]", "Input"],
 ". Accomplish this by rewriting ",
 StyleBox["Pattern", "Input"],
 " expressions to ",
 StyleBox["Blank", "Input"],
 " expressions (though see this known bug in the patterm-matcher\
\[NonBreakingSpace][3])."
}], "Text"],

Cell[TextData[{
 "TODO: recurse ",
 StyleBox["ProvidesTypeQ", "Input"],
 " on parameter types."
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"ClearAll", "[", 
    RowBox[{
    "ProvidesTypeQ", ",", "SubsetQ", ",", "GetRules", ",", "GetPatterns", ",",
      "GetReplacements", ",", "StripName"}], "]"}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"SubsetQ", "[", 
    RowBox[{"A_List", ",", "B_List"}], "]"}], ":=", 
   RowBox[{
    RowBox[{"Complement", "[", 
     RowBox[{"A", ",", "B"}], "]"}], "===", 
    RowBox[{"{", "}"}]}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"SubsetQ", "[", "else___", "]"}], ":=", 
   RowBox[{"Throw", "[", 
    RowBox[{"\"\<IllegalArgumentsException: \>\"", "<>", 
     RowBox[{"ToString", "@", 
      RowBox[{"{", "else", "}"}]}]}], "]"}]}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"StripName", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"Verbatim", "[", "Pattern", "]"}], "[", 
     RowBox[{"nym_", ",", 
      RowBox[{"typeSpec", ":", 
       RowBox[{
        RowBox[{"Verbatim", "[", "Blank", "]"}], "[", "type___", "]"}]}]}], 
     "]"}], "]"}], ":=", "typeSpec"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"StripName", "[", 
    RowBox[{"hd_", "[", "args___", "]"}], "]"}], ":=", 
   RowBox[{"hd", "@@", 
    RowBox[{"StripName", "/@", 
     RowBox[{"{", "args", "}"}]}]}]}], ";"}], "\n", 
 RowBox[{
  RowBox[{
   RowBox[{"StripName", "[", "else_", "]"}], ":=", "else"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"GetRules", "[", 
     RowBox[{"this_", "?", "ObjectQ"}], "]"}], ":=", "\[IndentingNewLine]", 
    RowBox[{"Sort", "@", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"h", "=", 
         RowBox[{"Head", "@", "this"}]}], "}"}], ",", "\[IndentingNewLine]", 
       RowBox[{"If", "[", 
        RowBox[{
         RowBox[{"h", "===", "Dispatch"}], ",", "\[IndentingNewLine]", 
         RowBox[{
         "this", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"If", "[", 
          RowBox[{
           RowBox[{"h", "===", "List"}], ",", "\[IndentingNewLine]", "this", 
           ",", "\[IndentingNewLine]", 
           RowBox[{"Throw", "[", "\"\<InvalidOperationException\>\"", "]"}]}],
           "]"}]}], "]"}]}], "]"}]}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"GetPatterns", "[", 
     RowBox[{"this_", "?", "ObjectQ"}], "]"}], ":=", "\[IndentingNewLine]", 
    RowBox[{"StripName", "/@", 
     RowBox[{"First", "/@", 
      RowBox[{"GetRules", "@", "this"}]}]}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"GetReplacements", "[", 
    RowBox[{"this_", "?", "ObjectQ"}], "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"#", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}], 
     "&"}], "/@", 
    RowBox[{"GetRules", "@", "this"}]}]}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"ProvidesTypeQ", "[", 
    RowBox[{
     RowBox[{"this_", "?", "ObjectQ"}], ",", "type_List"}], "]"}], ":=", 
   RowBox[{"SubsetQ", "[", 
    RowBox[{
     RowBox[{"StripName", "/@", "type"}], ",", 
     RowBox[{"GetPatterns", "[", "this", "]"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"ProvidesTypeQ", "[", "else___", "]"}], ":=", 
  RowBox[{"Throw", "[", 
   RowBox[{"\"\<IllegalArgumentsException: \>\"", "<>", 
    RowBox[{"ToString", "@", 
     RowBox[{"{", "else", "}"}]}]}], "]"}]}]}], "Input",
 CellChangeTimes->{{3.6052073278419933`*^9, 3.605207341359639*^9}}],

Cell["\<\
This does not handle generics, type-wildcards, subtyping, and co- and \
contra-variance. We leave those developments for another time and place. \
\>", "Text"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Unit Tests", "Subsubsection"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ProvidesTypeQ", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"f", "[", 
      RowBox[{"x_Integer", ",", "y_Real"}], "]"}], "\[RuleDelayed]", 
     RowBox[{"x", "+", "y"}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"f", "[", 
     RowBox[{"_Integer", ",", "_Real"}], "]"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233109435*^9, 3.60534795953388*^9, 
  3.606356896414814*^9, 3.606383656708667*^9, 3.607084161313457*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ProvidesTypeQ", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"f", "[", 
      RowBox[{"x_Integer", ",", "y_Real"}], "]"}], "\[RuleDelayed]", 
     RowBox[{"x", "+", "y"}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"f", "[", 
     RowBox[{"p_Integer", ",", "q_Real"}], "]"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.6051162331774797`*^9, 3.605347959567849*^9, 
  3.60635689644917*^9, 3.6063836567442713`*^9, 3.607084161353598*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ProvidesTypeQ", "[", 
  RowBox[{
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"f", "[", 
       RowBox[{"x_Integer", ",", "y_Real"}], "]"}], "\[RuleDelayed]", 
      RowBox[{"x", "+", "y"}]}], "}"}], "//", "Dispatch"}], ",", 
   RowBox[{"{", 
    RowBox[{"f", "[", 
     RowBox[{"_Integer", ",", "_Real"}], "]"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233226399*^9, 3.6053479596041927`*^9, 
  3.606356896494294*^9, 3.606383656797728*^9, 3.607084161382959*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"!", 
  RowBox[{"ProvidesTypeQ", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"f", "[", 
       RowBox[{"x_Integer", ",", "y_Real"}], "]"}], "\[RuleDelayed]", 
      RowBox[{"x", "+", "y"}]}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"f", "[", 
      RowBox[{"_Integer", ",", "_Integer"}], "]"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233259502*^9, 3.605347959651149*^9, 
  3.606356896548263*^9, 3.6063836568428097`*^9, 3.607084161431756*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ProvidesTypeQ", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      RowBox[{"f", "[", 
       RowBox[{"x_Integer", ",", "y_Real"}], "]"}], "\[RuleDelayed]", 
      RowBox[{"x", "+", "y"}]}], ",", 
     RowBox[{
      RowBox[{"g", "[", "s_String", "]"}], "\[RuleDelayed]", "s"}]}], "}"}], 
   ",", 
   RowBox[{"{", 
    RowBox[{"f", "[", 
     RowBox[{"_Integer", ",", "_Real"}], "]"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233311083*^9, 3.6053479597012787`*^9, 
  3.606356896582652*^9, 3.606383656892397*^9, 3.60708416146908*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"!", 
  RowBox[{"ProvidesTypeQ", "[", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       RowBox[{"f", "[", 
        RowBox[{"x_Integer", ",", "y_Real"}], "]"}], "\[RuleDelayed]", 
       RowBox[{"x", "+", "y"}]}], ",", 
      RowBox[{
       RowBox[{"g", "[", "s_String", "]"}], "\[RuleDelayed]", "s"}]}], "}"}], 
    ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"f", "[", 
       RowBox[{"_Integer", ",", "_Real"}], "]"}], ",", 
      RowBox[{"h", "[", "_String", "]"}]}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233339409*^9, 3.6053479597511263`*^9, 
  3.606356896615913*^9, 3.606383656947794*^9, 3.6070841615179567`*^9}]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"$obj", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"{", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{
        RowBox[{"h", "[", "s2_String", "]"}], "\[RuleDelayed]", "s2"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"f", "[", 
         RowBox[{"x_Integer", ",", "y_Real"}], "]"}], "\[RuleDelayed]", 
        RowBox[{"x", "+", "y"}]}], ",", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"g", "[", "s_String", "]"}], "\[RuleDelayed]", "s"}]}], "}"}],
      "//", "Sort"}], "//", "Dispatch"}]}], ";"}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ProvidesTypeQ", "[", 
  RowBox[{"$obj", ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"f", "[", 
      RowBox[{"_Integer", ",", "_Real"}], "]"}], ",", 
     RowBox[{"h", "[", "_String", "]"}]}], "}"}]}], "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.6051162334263487`*^9, 3.605347959837839*^9, 
  3.606356896681493*^9, 3.6063836570295*^9, 3.607084161601327*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ProvidesTypeQ", "[", 
  RowBox[{"$obj", ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"f", "[", 
      RowBox[{"q_Integer", ",", "p_Real"}], "]"}], ",", 
     RowBox[{"h", "[", "r_String", "]"}]}], "}"}]}], "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233456608*^9, 3.60534795988929*^9, 
  3.606356896716094*^9, 3.60638365706395*^9, 3.607084161635828*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ProvidesTypeQ", "[", 
  RowBox[{"$obj", ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"f", "[", 
      RowBox[{"_Integer", ",", "_Real"}], "]"}], ",", 
     RowBox[{"h", "[", "accidentalName_String", "]"}]}], "}"}]}], 
  "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.6051162335105877`*^9, 3.605347959938244*^9, 
  3.606356896766066*^9, 3.60638365711336*^9, 3.6070841617123938`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ProvidesTypeQ", "[", 
  RowBox[{"$obj", ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"g", "[", "_String", "]"}], ",", 
     RowBox[{"h", "[", "_String", "]"}], ",", 
     RowBox[{"f", "[", 
      RowBox[{"_Integer", ",", "_Real"}], "]"}]}], "}"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.6051167563287077`*^9, 3.605116805139415*^9}}],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116807312335*^9, 3.60534795997048*^9, 
  3.606356896815166*^9, 3.606383657146472*^9, 3.607084161751017*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Utility Functions on Types", "Subsection"],

Cell[TextData[{
 "We need a way to destructively add a rule to a given object, and it's \
useful to have a method to check for existence of a single rule pattern; ",
 StyleBox["ProvidesTypeQ", "Input"],
 " above checks for the existence of multiple rule patterns."
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"ClearAll", "[", 
    RowBox[{
    "HasPattern", ",", "IsPattern", ",", "WriteRule", ",", "RemoveRule"}], 
    "]"}], ";"}], "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"HasPattern", "[", 
    RowBox[{
     RowBox[{"this_", "?", "ObjectQ"}], ",", 
     RowBox[{"pattern_", "?", "RuleQ"}]}], "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{"SubsetQ", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"StripName", "@", 
       RowBox[{"First", "@", "pattern"}]}], "}"}], ",", 
     RowBox[{"GetPatterns", "@", "this"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"HasPattern", "[", 
     RowBox[{
      RowBox[{"this_", "?", "ObjectQ"}], ",", 
      RowBox[{"pattern_", "?", "PatternQ"}]}], "]"}], ":=", 
    "\[IndentingNewLine]", 
    RowBox[{"SubsetQ", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"StripName", "@", "pattern"}], "}"}], ",", 
      RowBox[{"GetPatterns", "@", "this"}]}], "]"}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"IsPattern", "[", 
    RowBox[{"this_", ",", 
     RowBox[{"that_", "?", "RuleQ"}]}], "]"}], ":=", 
   RowBox[{
    RowBox[{"StripName", "@", 
     RowBox[{"First", "@", "this"}]}], "===", 
    RowBox[{"StripName", "@", 
     RowBox[{"First", "@", "that"}]}]}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"IsPattern", "[", 
     RowBox[{"this_", ",", 
      RowBox[{"that_", "?", "PatternQ"}]}], "]"}], ":=", 
    RowBox[{
     RowBox[{"StripName", "@", 
      RowBox[{"First", "@", "this"}]}], "===", 
     RowBox[{"StripName", "@", "that"}]}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"RemoveRule", "[", 
     RowBox[{
      RowBox[{"this_", "?", "ObjectQ"}], ",", "ruleOrPattern_"}], "]"}], ":=",
     "\[IndentingNewLine]", 
    RowBox[{"Sort", "@", 
     RowBox[{"Select", "[", 
      RowBox[{
       RowBox[{"GetRules", "@", "this"}], ",", 
       RowBox[{
        RowBox[{"!", 
         RowBox[{"IsPattern", "[", 
          RowBox[{"#", ",", "ruleOrPattern"}], "]"}]}], "&"}]}], "]"}]}]}], 
   ";"}], "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"WriteRule", "[", 
    RowBox[{
     RowBox[{"this_", "?", "ObjectQ"}], ",", 
     RowBox[{"rule_", "?", "RuleQ"}]}], "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"Append", "[", 
      RowBox[{
       RowBox[{"RemoveRule", "[", 
        RowBox[{"this", ",", "rule"}], "]"}], ",", "rule"}], "]"}], "//", 
     "Sort"}], "//", "Dispatch"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"WriteRule", "[", "else___", "]"}], ":=", 
  RowBox[{"Throw", "[", 
   RowBox[{"\"\<IllegalArgumentsException: \>\"", "<>", 
    RowBox[{"ToString", "@", 
     RowBox[{"{", "else", "}"}]}]}], "]"}]}]}], "Input"],

Cell[CellGroupData[{

Cell["\<\
Digression: Consider Clojure hash-maps\
\>", "Subsubsection"],

Cell["\<\
Clojure has an exceptionally well conceived hash-map data structure and \
collection of functions. We may, in a future version of this document, \
emulate that structure and its API. Quoting from [6]\
\>", "Text"],

Cell["\<\
Maps (IPersistentMap)
A Map is a collection that maps keys to values.Two different map types are \
provided - hashed and sorted.Hash maps require keys that correctly support \
hashCode and equals.Sorted maps require keys that implement Comparable, or an \
instance of Comparator.Hash maps provide faster access (log32N hops) vs (logN \
hops), but sorted maps are, well, sorted.count is O (1).conj expects another \
(possibly single entry) map as the item, and returns a new map which is the \
old map plus the entries from the new, which may overwrite entries of the \
old.conj also accepts a MapEntry or a vector of two items (key and value).seq \
returns a sequence of map entries, which are key/value pairs.Sorted map also \
supports rseq, which returns the entries in reverse order.Maps implement IFn, \
for invoke () of one argument (a key) with an optional second argument (a \
default value), i.e.maps are functions of their keys.nil keys and values are \
ok.Related functions
Create a new map : hash - map sorted - map sorted - map - by
' change' a map : assoc dissoc select - keys merge merge - with zipmap
Examine a map : get contains?find keys vals map?Examine a map entry : key val
\
\>", "Text"]
}, Open  ]],

Cell[CellGroupData[{

Cell["UnitTests", "Subsubsection"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"id", "\[Rule]", 
   RowBox[{"Unique", "[", "]"}]}], "}"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"id", "\[Rule]", "$3"}], "}"}]], "Output",
 CellChangeTimes->{3.605116233577999*^9, 3.605347960037339*^9, 
  3.606356896897984*^9, 3.60638365722899*^9, 3.607084161833851*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{"id", "\[Rule]", 
    RowBox[{"Unique", "[", "]"}]}], "}"}], ".", "id"}]], "Input"],

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{"id", "\[Rule]", "$4"}], "}"}], ".", "id"}]], "Output",
 CellChangeTimes->{3.605116233610106*^9, 3.6053479600712976`*^9, 
  3.606356896933425*^9, 3.606383657275669*^9, 3.607084161885968*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"HasPattern", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"id", "\[Rule]", 
     RowBox[{"Unique", "[", "]"}]}], "}"}], ",", "jd"}], "]"}]], "Input"],

Cell[BoxData["False"], "Output",
 CellChangeTimes->{3.60511623363981*^9, 3.6053479601053867`*^9, 
  3.6063568969818172`*^9, 3.606383657313097*^9, 3.607084161936026*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"HasPattern", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"id", "\[Rule]", 
     RowBox[{"Unique", "[", "]"}]}], "}"}], ",", "id"}], "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233677103*^9, 3.605347960155428*^9, 
  3.606356897032456*^9, 3.60638365734652*^9, 3.6070841619813623`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"HasPattern", "[", 
  RowBox[{"$obj", ",", "\[IndentingNewLine]", 
   RowBox[{"h", "[", "accidentalName_String", "]"}]}], "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.6051162337068253`*^9, 3.605347960205165*^9, 
  3.606356897077138*^9, 3.606383657379315*^9, 3.607084162035336*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"IsPattern", "[", 
     RowBox[{"#", ",", 
      RowBox[{"f", "[", 
       RowBox[{"x_Integer", ",", "y_Real"}], "]"}]}], "]"}], "&"}], "/@", 
   RowBox[{"GetRules", "@", "$obj"}]}], "===", 
  RowBox[{"{", 
   RowBox[{"True", ",", "False", ",", "False"}], "}"}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233759904*^9, 3.6053479602551394`*^9, 
  3.606356897115828*^9, 3.606383657412902*^9, 3.607084162084735*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"RemoveRule", "[", 
   RowBox[{"$obj", ",", "\[IndentingNewLine]", 
    RowBox[{"f", "[", 
     RowBox[{"x_Integer", ",", "y_Real"}], "]"}]}], "\[IndentingNewLine]", 
   "]"}], "===", 
  RowBox[{"Sort", "@", 
   RowBox[{"{", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
      RowBox[{"h", "[", "s2_String", "]"}], "\[RuleDelayed]", "s2"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"g", "[", "s_String", "]"}], "\[RuleDelayed]", "s"}]}], 
    "}"}]}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233793751*^9, 3.605347960305484*^9, 
  3.606356897166705*^9, 3.60638365744666*^9, 3.6070841621350603`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"RemoveRule", "[", 
   RowBox[{"$obj", ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"f", "[", 
      RowBox[{"x_Integer", ",", "y_Real"}], "]"}], "\[RuleDelayed]", 
     RowBox[{"x", "+", "y"}]}]}], "\[IndentingNewLine]", "]"}], "===", 
  RowBox[{"Sort", "@", 
   RowBox[{"{", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
      RowBox[{"h", "[", "s2_String", "]"}], "\[RuleDelayed]", "s2"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"g", "[", "s_String", "]"}], "\[RuleDelayed]", "s"}]}], 
    "}"}]}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.6051162338271637`*^9, 3.605347960355257*^9, 
  3.60635689721587*^9, 3.606383657497508*^9, 3.6070841621844254`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"RemoveRule", "[", 
   RowBox[{"$obj", ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"f", "[", 
      RowBox[{"z_Integer", ",", "q_Real"}], "]"}], "\[RuleDelayed]", 
     RowBox[{"x", "+", "y"}]}]}], "\[IndentingNewLine]", "]"}], "===", 
  RowBox[{"Sort", "@", 
   RowBox[{"{", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
      RowBox[{"h", "[", "s2_String", "]"}], "\[RuleDelayed]", "s2"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"g", "[", "s_String", "]"}], "\[RuleDelayed]", "s"}]}], 
    "}"}]}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.60511623386051*^9, 3.6053479604053183`*^9, 
  3.6063568972662077`*^9, 3.606383657545988*^9, 3.607084162349966*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"RemoveRule", "[", 
   RowBox[{"$obj", ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"f", "[", 
      RowBox[{"z_Integer", ",", "q_Real"}], "]"}], "\[RuleDelayed]", 
     RowBox[{"z", "+", "q"}]}]}], "\[IndentingNewLine]", "]"}], "===", 
  RowBox[{"Sort", "@", 
   RowBox[{"{", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
      RowBox[{"h", "[", "s2_String", "]"}], "\[RuleDelayed]", "s2"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"g", "[", "s_String", "]"}], "\[RuleDelayed]", "s"}]}], 
    "}"}]}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233911119*^9, 3.6053479604533243`*^9, 
  3.606356897311083*^9, 3.6063836575978127`*^9, 3.6070841623882227`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"RemoveRule", "[", 
   RowBox[{"$obj", ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"j", "[", "l_List", "]"}], "\[RuleDelayed]", 
     RowBox[{"Length", "@", "l"}]}]}], "]"}], "===", "$obj"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116233964963*^9, 3.605347960567224*^9, 
  3.606356897365555*^9, 3.606383657646433*^9, 3.607084162434011*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"WriteRule", "[", 
   RowBox[{"$obj", ",", 
    RowBox[{
     RowBox[{"j", "[", "l_List", "]"}], "\[RuleDelayed]", 
     RowBox[{"Length", "@", "l"}]}]}], "]"}], "===", 
  RowBox[{"Append", "[", 
   RowBox[{"$obj", ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"j", "[", "l_List", "]"}], "\[RuleDelayed]", 
     RowBox[{"Length", "@", "l"}]}]}], "]"}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116234071854*^9, 3.605347960604787*^9, 
  3.606356897449829*^9, 3.606383657730105*^9, 3.6070841624864597`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"WriteRule", "[", 
  RowBox[{"$obj", ",", 
   RowBox[{
    RowBox[{"f", "[", 
     RowBox[{"q_Integer", ",", "z_Real"}], "]"}], "\[RuleDelayed]", 
    RowBox[{
     SuperscriptBox["q", "2"], "+", 
     SuperscriptBox["z", "2"]}]}]}], "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{
    RowBox[{"f", "[", 
     RowBox[{"q_Integer", ",", "z_Real"}], "]"}], "\[RuleDelayed]", 
    RowBox[{
     SuperscriptBox["q", "2"], "+", 
     SuperscriptBox["z", "2"]}]}], ",", 
   RowBox[{
    RowBox[{"g", "[", "s_String", "]"}], "\[RuleDelayed]", "s"}], ",", 
   RowBox[{
    RowBox[{"h", "[", "s2_String", "]"}], "\[RuleDelayed]", "s2"}]}], 
  "}"}]], "Output",
 CellChangeTimes->{3.6051162341443663`*^9, 3.6053479606505737`*^9, 
  3.606356897482955*^9, 3.606383657763534*^9, 3.607084162534029*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"WriteRule", "[", 
   RowBox[{"$obj", ",", 
    RowBox[{
     RowBox[{"f", "[", 
      RowBox[{"q_Integer", ",", "z_Real"}], "]"}], "\[RuleDelayed]", 
     RowBox[{
      SuperscriptBox["q", "2"], "+", 
      SuperscriptBox["z", "2"]}]}]}], "]"}], "===", 
  RowBox[{"Sort", "@", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      RowBox[{"h", "[", "s2_String", "]"}], "\[RuleDelayed]", "s2"}], ",", 
     RowBox[{
      RowBox[{"g", "[", "s_String", "]"}], "\[RuleDelayed]", "s"}], ",", 
     RowBox[{
      RowBox[{"f", "[", 
       RowBox[{"q_Integer", ",", "z_Real"}], "]"}], "\[RuleDelayed]", 
      RowBox[{
       SuperscriptBox["q", "2"], "+", 
       SuperscriptBox["z", "2"]}]}]}], "}"}]}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.605116234211008*^9, 3.605347960699991*^9, 
  3.6063568975322027`*^9, 3.606383657808782*^9, 3.607084162564232*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Inheritance and Its Style of Polymorphism", "Subsection"],

Cell["\<\
Particular rules could simulate inheritance and its style of polymorphism \
either by chasing prototype chains (upward inheritance) or dispatching at run \
time (downward inheritance). We don't need to take a cosmic position on this; \
each class and interface can do it in its own way. \
\>", "Text"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Using Objects", "Subsection"],

Cell["\<\
To produce application-level results, apply objects' rules to other, \
arbitrarily rich work-expressions. This is \"rewrite at run time.\" Contrast \
with the more familiar \"rewrite at compile time,\" which is how standard oop \
systems transform work-expressions into actionable, application-level \
work-code. In a future version of this document, we might exhibit a \
compile-time option.\
\>", "Text"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Overload Resolution; Member Lookup", "Subsection"],

Cell["\<\
In the current design, member lookup (overload-resolution) is done at run \
time. Later, we might include lookup at compile time. \
\>", "Text"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["IEnumerator and IEnumerable", "Section"],

Cell[BoxData[
 RowBox[{
  RowBox[{"ClearAll", "[", "\[IndentingNewLine]", 
   RowBox[{
   "IEnumerable", ",", "\[IndentingNewLine]", "IEnumerator", ",", 
    "\[IndentingNewLine]", "IEnumerableType", ",", "\[IndentingNewLine]", 
    "IEnumeratorType", ",", "\[IndentingNewLine]", "GetEnumerator", ",", 
    "\[IndentingNewLine]", "MoveNext", ",", "\[IndentingNewLine]", 
    "Current"}], "]"}], ";"}]], "Input"],

Cell[CellGroupData[{

Cell["Abstract Types", "Subsection"],

Cell[TextData[{
 "Here are the abstract specifications of the types ",
 StyleBox["IEnumerable", "Input"],
 " and ",
 StyleBox["IEnumerator", "Input"],
 ". This is not a full type system, but it is a start in the right direction. \
You can check these types by calling ",
 StyleBox["ProvidesTypeQ[obj,type]", "Input"],
 ". "
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "IEnumerableType", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"IEnumerableType", "=", 
   RowBox[{"{", 
    RowBox[{"GetEnumerator", "[", "]"}], "}"}]}], ";"}]}], "Input"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "IEnumeratorType", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"IEnumeratorType", "=", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"MoveNext", "[", "]"}], ",", "Current"}], "}"}]}], 
  ";"}]}], "Input"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Contracts", "Subsection"],

Cell[TextData[{
 "Unlike C#, where interfaces are abstract, our ",
 StyleBox["IEnumerator", "Input"],
 " provide an implementation that ",
 StyleBox["enforces",
  FontSlant->"Italic"],
 " its contract by requiring every provider object to implement the private \
protocol of type ",
 StyleBox["MoveNext[_Integer]", "Input"],
 " and ",
 StyleBox["Current[_Integer]", "Input"],
 ". Enforcing is better than simply hoping. The private contract for the \
private protocol is documented in the comments of the code below."
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "privateProtocolType", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"privateProtocolType", "=", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"MoveNext", "[", "_Integer", "]"}], ",", 
     RowBox[{"Current", "[", "_Integer", "]"}]}], "}"}]}], ";"}]}], "Input"],

Cell[TextData[{
 "To get the ",
 StyleBox["IEnumerator", "Input"],
 " interface for an object named ",
 StyleBox["this", "Input"],
 ", \"call\" the following \"function\" on an object (i.e., dispatch list of \
rewrite rules) to get a new object that implements (provides rules for) the \
enumerator's state machine. The new object will call the private protocol of \
the old object by imposing the old object's rewrite rules on expressions of \
the form ",
 StyleBox["MoveNext[i_Integer]", "Input"],
 " and ",
 StyleBox["Current[i_Integer]", "Input"],
 " that must be provided by the old object."
}], "Text"],

Cell[TextData[{
 StyleBox["SIDEBAR",
  FontWeight->"Bold"],
 ": The quotes on \"call\" and \"function\" are to remind you that what \
you're really doing is rewriting the expression ",
 StyleBox["IEnumerator[this_]", "Input"],
 ", after substituting an actiual object for the variable ",
 StyleBox["this_", "Input"],
 ", into the right-hand-side of the ",
 StyleBox[":=", "Input"],
 " assignment symbol. The rewrite rule for ",
 StyleBox["IEnumerator", "Input"],
 " is permanently installed into the global symbol table because ",
 StyleBox["IEnumerator", "Input"],
 " is a permanent part of our programming environment. ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " implements function-calling with expression-rewriting, as can be observed \
by evaluating the following two expressions.  ",
 StyleBox["Trace[x+x/.{x->42}]", "Input"],
 ", which rewrites first and substitutes second, i.e., rewrites ",
 StyleBox["x+x", "Input"],
 " into ",
 StyleBox["2x", "Input"],
 " first, then substitutes ",
 StyleBox["42", "Input"],
 " for ",
 StyleBox["x", "Input"],
 ";  and ",
 StyleBox["Trace[Function[x,x+x][42]]", "Input"],
 ", which substitues first and rewrites second, i.e., substitutes ",
 StyleBox["42", "Input"],
 " for ",
 StyleBox["x", "Input"],
 " and ",
 StyleBox["x+x", "Input"],
 " for ",
 StyleBox["Function[x,x+x][42]", "Input"],
 " in one step, and then rewrites ",
 StyleBox["42+42", "Input"],
 " into ",
 StyleBox["84", "Input"],
 " after the substitutions. "
}], "Item"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"ClearAll", "[", "IEnumerator", "]"}], ";"}], 
  "\[IndentingNewLine]", 
  RowBox[{"(*", " ", 
   RowBox[{
   "Checks", " ", "that", " ", "the", " ", "argument", " ", "provides", " ", 
    "the", " ", 
    RowBox[{"privateProtocol", "."}]}], " ", 
   "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"IEnumerator", "[", 
   RowBox[{"this_", "?", 
    RowBox[{"(", 
     RowBox[{
      RowBox[{"ProvidesTypeQ", "[", 
       RowBox[{"#", ",", "privateProtocolType"}], "]"}], "&"}], ")"}]}], 
   "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"Module", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"(*", " ", 
        RowBox[{
         RowBox[{"Variables", " ", "for", " ", "the", " ", "state"}], "-", 
         RowBox[{"machine", "."}]}], " ", "*)"}], "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"i", "=", "0"}], ",", "\[IndentingNewLine]", 
        RowBox[{"iPlus", "=", "Undefined"}]}], "}"}], ",", 
      RowBox[{"{", "\[IndentingNewLine]", 
       RowBox[{"(*", " ", 
        RowBox[{
         RowBox[{"MoveNext", " ", "is"}], ",", " ", "syntactically", ",", " ", 
         RowBox[{"a", " ", 
          RowBox[{"method", "."}]}]}], " ", "*)"}], "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{
         RowBox[{"MoveNext", "[", "]"}], "\[RuleDelayed]", 
         RowBox[{"(", "\[IndentingNewLine]", 
          RowBox[{"(*", " ", 
           RowBox[{
           "Access", " ", "the", " ", "private", " ", "implementation", " ", 
            "of", " ", 
            RowBox[{"MoveNext", "[", "i", "]"}]}], " ", "*)"}], 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"iPlus", "=", 
            RowBox[{
             RowBox[{"MoveNext", "[", "i", "]"}], "/.", "this"}]}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{"(*", " ", 
            RowBox[{
            "The", " ", "private", " ", "protocol", " ", "returns", " ", 
             "integer", " ", "indices", " ", "only", " ", "when", " ", 
             "MoveNext", " ", 
             RowBox[{"stays", " ", "'"}], 
             RowBox[{"inside", "'"}], " ", "the", " ", 
             RowBox[{"sequence", "."}]}], " ", "*)"}], "\[IndentingNewLine]", 
           
           RowBox[{"With", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{"result", "=", 
               RowBox[{"(", 
                RowBox[{"Integer", "===", 
                 RowBox[{"Head", "[", "iPlus", "]"}]}], ")"}]}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"If", "[", 
               RowBox[{"result", ",", 
                RowBox[{"i", "=", "iPlus"}]}], "]"}], ";", 
              "\[IndentingNewLine]", 
              RowBox[{"(*", " ", 
               RowBox[{"The", " ", "public", " ", "protocol", " ", "for", " ", 
                RowBox[{"IEnumerator", "'"}], "s", " ", "MoveNext", " ", 
                "produces", " ", "a", " ", 
                RowBox[{"Boolean", "."}]}], " ", "*)"}], 
              "\[IndentingNewLine]", "result"}]}], "]"}]}], ")"}]}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"(*", " ", 
         RowBox[{
          RowBox[{"Current", " ", "is"}], ",", " ", "syntactically", ",", " ", 
          RowBox[{"a", " ", 
           RowBox[{"property", "."}]}]}], " ", "*)"}], "\[IndentingNewLine]", 
        
        RowBox[{"Current", "\[RuleDelayed]", "\[IndentingNewLine]", 
         RowBox[{"(*", " ", 
          RowBox[{
           RowBox[{
           "The", " ", "following", " ", "effects", " ", "the", " ", 
            "public"}], ",", " ", 
           RowBox[{
           "documented", " ", "protocol", " ", "in", " ", "terms", " ", "of", 
            " ", "a", " ", "private", " ", "protocol", " ", "member"}], ",", 
           " ", 
           RowBox[{"namely", " ", 
            RowBox[{
             RowBox[{"Current", "[", "i", "]"}], "."}]}]}], " ", "*)"}], 
         "\[IndentingNewLine]", 
         RowBox[{"If", "[", 
          RowBox[{
           RowBox[{"Not", "[", 
            RowBox[{"Integer", "===", 
             RowBox[{"Head", "[", "iPlus", "]"}]}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Throw", "[", "\"\<InvalidOperationException\>\"", "]"}], 
           ",", "\[IndentingNewLine]", 
           RowBox[{"If", "[", 
            RowBox[{
             RowBox[{"i", "===", "0"}], ",", "\[IndentingNewLine]", 
             "Undefined", ",", "\[IndentingNewLine]", 
             RowBox[{"(*", " ", 
              RowBox[{"Access", " ", 
               RowBox[{"this", "'"}], "s", " ", "private", " ", 
               "implementation", " ", "of", " ", 
               RowBox[{"Current", "[", "i", "]"}]}], " ", "*)"}], 
             "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"Current", "[", "i", "]"}], "/.", "this"}]}], "]"}]}], 
          "]"}]}]}], "\[IndentingNewLine]", "}"}]}], "]"}], "//", "Sort"}], "//",
    "Dispatch"}]}]}], "Input"],

Cell[TextData[{
 "To get the ",
 StyleBox["IEnumerable", "Input"],
 " interface for an object, call the following function, which returns a new \
object implementing the interface, i.e., providing rewrite rules for the \
interface's members."
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "IEnumerable", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"IEnumerable", "[", 
   RowBox[{"this_", "?", "ObjectQ"}], "]"}], ":=", 
  RowBox[{
   RowBox[{"{", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"GetEnumerator", "[", "]"}], "\[RuleDelayed]", 
     RowBox[{"IEnumerator", "[", "this", "]"}]}], "\[IndentingNewLine]", 
    "}"}], "//", "Dispatch"}]}]}], "Input"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["List: a Provider of IEnumerable", "Section"],

Cell[TextData[{
 StyleBox["list", "Input"],
 " is a provider of ",
 StyleBox["IEnumerable", "Input"],
 ". Its type is ",
 StyleBox["list", "Input"],
 "; its constructor is ",
 StyleBox["list`list", "Input"],
 ", using the class ",
 StyleBox["list", "Input"],
 " as a namespace. It must implement the private protocol ",
 StyleBox["MoveNext[_Integer]", "Input"],
 " and ",
 StyleBox["Current[_Integer]", "Input"],
 ". "
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "list`list", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"list`list", "[", "data_List", "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"len", "=", 
      RowBox[{"Length", "[", "data", "]"}]}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"IEnumerable", "[", 
     RowBox[{
      RowBox[{
       RowBox[{"{", 
        RowBox[{"(*", " ", 
         RowBox[{
         "what", " ", "follows", " ", "is", " ", "the", " ", "required", " ", 
          "private", " ", 
          RowBox[{"protocol", "."}]}], " ", "*)"}], "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{
          RowBox[{"MoveNext", "[", "i_Integer", "]"}], "\[RuleDelayed]", 
          "\[IndentingNewLine]", 
          RowBox[{"With", "[", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"iPlus", "=", 
              RowBox[{"i", "+", "1"}]}], "}"}], ",", "\[IndentingNewLine]", 
            RowBox[{"(*", " ", 
             RowBox[{
              RowBox[{
              "Required", " ", "to", " ", "produce", " ", "an", " ", 
               "integer", " ", "iff", " ", "the", " ", "new", " ", "index", 
               " ", "is", " ", "in"}], "-", 
              RowBox[{"range", "."}]}], " ", "*)"}], "\[IndentingNewLine]", 
            RowBox[{"If", "[", 
             RowBox[{
              RowBox[{
               RowBox[{"iPlus", ">", "0"}], "&&", 
               RowBox[{"iPlus", "\[LessEqual]", "len"}]}], ",", "iPlus", ",", 
              "False"}], "]"}]}], "]"}]}], ",", "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{"Current", "[", "i_Integer", "]"}], "\[RuleDelayed]", 
          "\[IndentingNewLine]", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{
             RowBox[{"i", ">", "0"}], "&&", 
             RowBox[{"i", "\[LessEqual]", "len"}]}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"data", "[", 
             RowBox[{"[", "i", "]"}], "]"}], ",", "\[IndentingNewLine]", 
            RowBox[{"Throw", "[", "\"\<IndexOutOfRangeException\>\"", "]"}]}],
            "]"}]}]}], "\[IndentingNewLine]", "}"}], "//", "Sort"}], "//", 
      "Dispatch"}], "\[IndentingNewLine]", "]"}]}], "]"}]}]}], "Input"]
}, Open  ]],

Cell[CellGroupData[{

Cell["ForEach", "Section"],

Cell[TextData[{
 "Here is a straightforward implementation of ",
 StyleBox["forEach", "Input"],
 ", which applies a function to every element of an ",
 StyleBox["IEnumerable", "Input"],
 " for side-effect. It corresponds to ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 "'s ",
 StyleBox["Scan", "Input"],
 ". It's a prototype for the entire suite of LINQ-ish ",
 StyleBox["Standard Query Operators",
  FontSlant->"Italic"],
 " [4]. "
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "forEach", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"forEach", "[", 
   RowBox[{
    RowBox[{"enumerable_", "?", 
     RowBox[{"(", 
      RowBox[{
       RowBox[{"ProvidesTypeQ", "[", 
        RowBox[{"#", ",", "IEnumerableType"}], "]"}], "&"}], ")"}]}], ",", 
    "someFunction_"}], "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"With", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"enumerator", "=", 
      RowBox[{
       RowBox[{"GetEnumerator", "[", "]"}], "/.", "enumerable"}]}], "}"}], 
    ",", "\[IndentingNewLine]", 
    RowBox[{"While", "[", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{
       RowBox[{"MoveNext", "[", "]"}], "/.", "enumerator"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"someFunction", "[", 
       RowBox[{"Current", "/.", "enumerator"}], "]"}]}], 
     "\[IndentingNewLine]", "]"}]}], "]"}]}]}], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"forEach", "[", 
  RowBox[{
   RowBox[{"list`list", "[", 
    RowBox[{"{", 
     RowBox[{
     "\"\<John Smith\>\"", ",", "\"\<Jim Johnson\>\"", ",", 
      "\"\<Sue Rabon\>\""}], "}"}], "]"}], ",", "Print"}], "]"}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData["\<\"John Smith\"\>"], "Print",
 CellChangeTimes->{3.60511623450604*^9, 3.6053479609663887`*^9, 
  3.6063568977778683`*^9, 3.606383658108676*^9, 3.607084162869863*^9}],

Cell[BoxData["\<\"Jim Johnson\"\>"], "Print",
 CellChangeTimes->{3.60511623450604*^9, 3.6053479609663887`*^9, 
  3.6063568977778683`*^9, 3.606383658108676*^9, 3.607084162871422*^9}],

Cell[BoxData["\<\"Sue Rabon\"\>"], "Print",
 CellChangeTimes->{3.60511623450604*^9, 3.6053479609663887`*^9, 
  3.6063568977778683`*^9, 3.606383658108676*^9, 3.607084162873136*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Dot: Syntactic Sugar", "Subsection",
 CellChangeTimes->{{3.606648755151909*^9, 3.606648768906515*^9}}],

Cell[TextData[{
 "Leo Bushkin and I figured out how to overload ",
 StyleBox["Dot",
  FontSlant->"Italic"],
 " -- normally vector inner product -- so we can use more natural OOP \
notation."
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "Flip", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"Flip", "[", "fn_", "]"}], ":=", 
   RowBox[{"Function", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"x", ",", "y"}], "}"}], ",", 
     RowBox[{"fn", "[", 
      RowBox[{"y", ",", "x"}], "]"}]}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"Unprotect", "[", "Dot", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"SetAttributes", "[", 
   RowBox[{"Dot", ",", "HoldRest"}], "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"Dot", "[", 
    RowBox[{"rules_", ",", "member_"}], "]"}], ":=", 
   RowBox[{"member", "/.", "rules"}]}], 
  RowBox[{"(*", "\[IndentingNewLine]", 
   RowBox[{"Fold", "[", 
    RowBox[{
     RowBox[{"Flip", "@", "ReplaceAll"}], ",", " ", 
     RowBox[{"List", " ", "@@", " ", "rules"}], ",", 
     RowBox[{"{", 
      RowBox[{"Unevaluated", "[", "member", "]"}], "}"}]}], "]"}], "*)"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"Dot", "[", 
    RowBox[{"rules_", ",", "member_", ",", "members__"}], "]"}], " ", ":=", 
   RowBox[{"(", 
    RowBox[{"(*", 
     RowBox[{
      RowBox[{"Print", "@", "rules"}], ";", 
      RowBox[{"Print", "@", "member"}], ";", 
      RowBox[{"Print", "@", "members"}], ";"}], "*)"}], " ", 
    RowBox[{"Fold", "[", 
     RowBox[{
      RowBox[{"Flip", "@", "ReplaceAll"}], ",", " ", 
      RowBox[{"List", " ", "@@", " ", "rules"}], ",", 
      RowBox[{"Unevaluated", "@", 
       RowBox[{"{", 
        RowBox[{"member", ",", "members"}], "}"}]}]}], "]"}], ")"}]}], 
  ";"}], "\n", 
 RowBox[{
  RowBox[{"Protect", "[", "Dot", "]"}], ";"}]}], "Input",
 CellChangeTimes->{{3.607084090481943*^9, 3.607084092375984*^9}, {
  3.607084705829748*^9, 3.6070847181528*^9}, {3.607084865564412*^9, 
  3.607084880736907*^9}}],

Cell[CellGroupData[{

Cell["Unit Test", "Subsubsection"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"TraceScan", "[", 
  RowBox[{"Print", ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"a", "\[Rule]", "1"}], "}"}], ".", "a"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.607084622868824*^9, 3.607084641194338*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 TagBox[
  RowBox[{
   RowBox[{"{", 
    RowBox[{"a", "\[Rule]", "1"}], "}"}], ".", "a"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884922718*^9}],

Cell[BoxData[
 TagBox["Dot",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.6070848849242764`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"a", "\[Rule]", "1"}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.6070848849258966`*^9}],

Cell[BoxData[
 TagBox["List",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.6070848849273987`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"a", "\[Rule]", "1"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884928895*^9}],

Cell[BoxData[
 TagBox["Rule",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884930385*^9}],

Cell[BoxData[
 TagBox["a",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884931848*^9}],

Cell[BoxData[
 TagBox["1",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.6070848849332933`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"a", "\[Rule]", "1"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.6070848849347773`*^9}],

Cell[BoxData[
 TagBox["Rule",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884936205*^9}],

Cell[BoxData[
 TagBox["a",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884937636*^9}],

Cell[BoxData[
 TagBox["1",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.6070848849390717`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"a", "\[Rule]", "1"}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.6070848849405003`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{
   RowBox[{"{", 
    RowBox[{"a", "\[Rule]", "1"}], "}"}], ".", "a"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884941971*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"a", "/.", "\[VeryThinSpace]", 
   RowBox[{"{", 
    RowBox[{"a", "\[Rule]", "1"}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884943468*^9}],

Cell[BoxData[
 TagBox["ReplaceAll",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884945055*^9}],

Cell[BoxData[
 TagBox["a",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884946608*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"a", "\[Rule]", "1"}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884948206*^9}],

Cell[BoxData[
 TagBox["1",
  HoldForm]], "Print",
 CellChangeTimes->{3.607084641637596*^9, 3.607084884949772*^9}]
}, Open  ]],

Cell[BoxData["1"], "Output",
 CellChangeTimes->{{3.607084634207862*^9, 3.607084641729403*^9}, 
   3.607084884952115*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{"m", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"n", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}], ".", "m", ".",
   "n", ".", "p"}]], "Input"],

Cell[BoxData["42"], "Output",
 CellChangeTimes->{3.60511623460966*^9, 3.605347961039236*^9, 
  3.6063568978477583`*^9, 3.606383658213222*^9, 3.607084162951804*^9, 
  3.607084890494916*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"TraceScan", "[", 
  RowBox[{"Print", ",", " ", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"m", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"n", "\[Rule]", 
        RowBox[{"{", 
         RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}], ".", "m", 
    ".", "n", ".", "p"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.607084166456747*^9, 3.607084185330326*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 TagBox[
  RowBox[{
   RowBox[{"{", 
    RowBox[{"m", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"n", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}], ".", "m", 
   ".", "n", ".", "p"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896023678*^9}],

Cell[BoxData[
 TagBox["Dot",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896024929*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"m", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"n", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896026256*^9}],

Cell[BoxData[
 TagBox["List",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.60708489602759*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"m", "\[Rule]", 
   RowBox[{"{", 
    RowBox[{"n", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960289307`*^9}],

Cell[BoxData[
 TagBox["Rule",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896030205*^9}],

Cell[BoxData[
 TagBox["m",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896031474*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"n", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960329437`*^9}],

Cell[BoxData[
 TagBox["List",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896034404*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"n", "\[Rule]", 
   RowBox[{"{", 
    RowBox[{"p", "\[Rule]", "42"}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.60708489603585*^9}],

Cell[BoxData[
 TagBox["Rule",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896037292*^9}],

Cell[BoxData[
 TagBox["n",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896038682*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"p", "\[Rule]", "42"}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896040053*^9}],

Cell[BoxData[
 TagBox["List",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896041449*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"p", "\[Rule]", "42"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896042802*^9}],

Cell[BoxData[
 TagBox["Rule",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960442343`*^9}],

Cell[BoxData[
 TagBox["p",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896045624*^9}],

Cell[BoxData[
 TagBox["42",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960470467`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"p", "\[Rule]", "42"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960484753`*^9}],

Cell[BoxData[
 TagBox["Rule",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.60708489604992*^9}],

Cell[BoxData[
 TagBox["p",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896051371*^9}],

Cell[BoxData[
 TagBox["42",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896052668*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"p", "\[Rule]", "42"}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960539713`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"n", "\[Rule]", 
   RowBox[{"{", 
    RowBox[{"p", "\[Rule]", "42"}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960552807`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"n", "\[Rule]", 
   RowBox[{"{", 
    RowBox[{"p", "\[Rule]", "42"}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896056548*^9}],

Cell[BoxData[
 TagBox["Rule",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896057856*^9}],

Cell[BoxData[
 TagBox["n",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896059119*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"p", "\[Rule]", "42"}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896060389*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"n", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960616703`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"m", "\[Rule]", 
   RowBox[{"{", 
    RowBox[{"n", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896062999*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"m", "\[Rule]", 
   RowBox[{"{", 
    RowBox[{"n", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896064287*^9}],

Cell[BoxData[
 TagBox["Rule",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896065538*^9}],

Cell[BoxData[
 TagBox["m",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896066841*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"n", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896068182*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"m", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"n", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.60708489606953*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{
   RowBox[{"{", 
    RowBox[{"m", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"n", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}], ".", "m", 
   ".", "n", ".", "p"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.60708489607091*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"Fold", "[", 
   RowBox[{
    RowBox[{"Flip", "[", "ReplaceAll", "]"}], ",", 
    RowBox[{"List", "@@", 
     RowBox[{"{", 
      RowBox[{"m", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{"n", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}]}], ",", 
    RowBox[{"Unevaluated", "[", 
     RowBox[{"{", 
      RowBox[{"m", ",", "n", ",", "p"}], "}"}], "]"}]}], "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896072282*^9}],

Cell[BoxData[
 TagBox["Fold",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960736427`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"Flip", "[", "ReplaceAll", "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896074994*^9}],

Cell[BoxData[
 TagBox["Flip",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896076288*^9}],

Cell[BoxData[
 TagBox["ReplaceAll",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896077593*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"Function", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"x$", ",", "y$"}], "}"}], ",", 
    RowBox[{"y$", "/.", "\[VeryThinSpace]", "x$"}]}], "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896078912*^9}],

Cell[BoxData[
 TagBox["Function",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960802794`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"List", "@@", 
   RowBox[{"{", 
    RowBox[{"m", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"n", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960816317`*^9}],

Cell[BoxData[
 TagBox["Apply",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896082982*^9}],

Cell[BoxData[
 TagBox["List",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.60708489608428*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"m", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"n", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.60708489608563*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"m", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"n", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896086975*^9}],

Cell[BoxData[
 TagBox["List",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896088311*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"m", "\[Rule]", 
   RowBox[{"{", 
    RowBox[{"n", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896089624*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"Fold", "[", 
   RowBox[{
    RowBox[{"Function", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"x$", ",", "y$"}], "}"}], ",", 
      RowBox[{"y$", "/.", "\[VeryThinSpace]", "x$"}]}], "]"}], ",", 
    RowBox[{"{", 
     RowBox[{"m", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"n", "\[Rule]", 
        RowBox[{"{", 
         RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"m", ",", "n", ",", "p"}], "}"}]}], "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896091033*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{
   RowBox[{"Function", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"x$", ",", "y$"}], "}"}], ",", 
     RowBox[{"y$", "/.", "\[VeryThinSpace]", "x$"}]}], "]"}], "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"m", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"n", "\[Rule]", 
        RowBox[{"{", 
         RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}], ",", "m"}], 
   "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896092452*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"Function", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"x$", ",", "y$"}], "}"}], ",", 
    RowBox[{"y$", "/.", "\[VeryThinSpace]", "x$"}]}], "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896093831*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"m", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"n", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960951853`*^9}],

Cell[BoxData[
 TagBox["m",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896096466*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"m", "/.", "\[VeryThinSpace]", 
   RowBox[{"{", 
    RowBox[{"m", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"n", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896097767*^9}],

Cell[BoxData[
 TagBox["ReplaceAll",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848960991173`*^9}],

Cell[BoxData[
 TagBox["m",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896100436*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"m", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"n", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848961018143`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"n", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896103158*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{
   RowBox[{"Function", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"x$", ",", "y$"}], "}"}], ",", 
     RowBox[{"y$", "/.", "\[VeryThinSpace]", "x$"}]}], "]"}], "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"n", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}], ",", "n"}], "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896104538*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"Function", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"x$", ",", "y$"}], "}"}], ",", 
    RowBox[{"y$", "/.", "\[VeryThinSpace]", "x$"}]}], "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896105959*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"n", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.60708489610732*^9}],

Cell[BoxData[
 TagBox["n",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848961086884`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"n", "/.", "\[VeryThinSpace]", 
   RowBox[{"{", 
    RowBox[{"n", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848961100483`*^9}],

Cell[BoxData[
 TagBox["ReplaceAll",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896111388*^9}],

Cell[BoxData[
 TagBox["n",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896112718*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"n", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"p", "\[Rule]", "42"}], "}"}]}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896114047*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"p", "\[Rule]", "42"}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848961154118`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{
   RowBox[{"Function", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"x$", ",", "y$"}], "}"}], ",", 
     RowBox[{"y$", "/.", "\[VeryThinSpace]", "x$"}]}], "]"}], "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"p", "\[Rule]", "42"}], "}"}], ",", "p"}], "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896116818*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"Function", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"x$", ",", "y$"}], "}"}], ",", 
    RowBox[{"y$", "/.", "\[VeryThinSpace]", "x$"}]}], "]"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848961182203`*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"p", "\[Rule]", "42"}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896119609*^9}],

Cell[BoxData[
 TagBox["p",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896120969*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"p", "/.", "\[VeryThinSpace]", 
   RowBox[{"{", 
    RowBox[{"p", "\[Rule]", "42"}], "}"}]}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.6070848961222887`*^9}],

Cell[BoxData[
 TagBox["ReplaceAll",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896123637*^9}],

Cell[BoxData[
 TagBox["p",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.60708489612498*^9}],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{"p", "\[Rule]", "42"}], "}"}],
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896126299*^9}],

Cell[BoxData[
 TagBox["42",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896127657*^9}],

Cell[BoxData[
 TagBox["42",
  HoldForm]], "Print",
 CellChangeTimes->{3.6070841863766813`*^9, 3.607084896129018*^9}]
}, Open  ]],

Cell[BoxData["42"], "Output",
 CellChangeTimes->{{3.607084182247941*^9, 3.6070841865306053`*^9}, 
   3.607084896130351*^9}]
}, Open  ]],

Cell["\<\
Here is the more natural notation in action:\
\>", "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "forEach", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"forEach", "[", 
   RowBox[{
    RowBox[{"enumerable_", "?", 
     RowBox[{"(", 
      RowBox[{
       RowBox[{"ProvidesTypeQ", "[", 
        RowBox[{"#", ",", "IEnumerableType"}], "]"}], "&"}], ")"}]}], ",", 
    "someFunction_"}], "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"With", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"enumerator", "=", 
      RowBox[{"enumerable", ".", 
       RowBox[{"GetEnumerator", "[", "]"}]}]}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"While", "[", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"enumerator", ".", 
       RowBox[{"MoveNext", "[", "]"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"someFunction", "[", 
       RowBox[{"enumerator", ".", "Current"}], "]"}]}], "\[IndentingNewLine]",
      "]"}]}], "]"}]}]}], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"forEach", "[", 
  RowBox[{
   RowBox[{"list`list", "[", 
    RowBox[{"{", 
     RowBox[{
     "\"\<John Smith\>\"", ",", "\"\<Jim Johnson\>\"", ",", 
      "\"\<Sue Rabon\>\""}], "}"}], "]"}], ",", "Print"}], "]"}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData["\<\"John Smith\"\>"], "Print",
 CellChangeTimes->{3.6051162346930113`*^9, 3.605347961119298*^9, 
  3.606356897914959*^9, 3.606383658280074*^9, 3.6070841630308123`*^9}],

Cell[BoxData["\<\"Jim Johnson\"\>"], "Print",
 CellChangeTimes->{3.6051162346930113`*^9, 3.605347961119298*^9, 
  3.606356897914959*^9, 3.606383658280074*^9, 3.607084163032679*^9}],

Cell[BoxData["\<\"Sue Rabon\"\>"], "Print",
 CellChangeTimes->{3.6051162346930113`*^9, 3.605347961119298*^9, 
  3.606356897914959*^9, 3.606383658280074*^9, 3.607084163034918*^9}]
}, Open  ]]
}, Open  ]],

Cell["Should behave well for empty lists.", "Text"],

Cell[BoxData[
 RowBox[{"forEach", "[", 
  RowBox[{
   RowBox[{"list`list", "[", 
    RowBox[{"{", "}"}], "]"}], ",", "Print"}], "]"}]], "Input"],

Cell[TextData[{
 "Should throw for things that don't provide the ",
 StyleBox["IEnumerable", "Input"],
 " type. "
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Catch", "[", 
  RowBox[{"forEach", "[", 
   RowBox[{"foobar", ",", "Print"}], "]"}], "]"}]], "Input"],

Cell[BoxData["\<\"IllegalArgumentsException: {foobar, \
{GetEnumerator[]}}\"\>"], "Output",
 CellChangeTimes->{3.605116234777083*^9, 3.605347961203722*^9, 
  3.60635689798204*^9, 3.606383658345587*^9, 3.607084163117304*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["HashMap: a Provider of IEnumerable", "Section"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"aHashMap", "=", 
  RowBox[{
   RowBox[{"RandomSample", "@", 
    RowBox[{"MapThread", "[", 
     RowBox[{"Rule", ",", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"CharacterRange", "[", 
         RowBox[{"\"\<a\>\"", ",", "\"\<z\>\""}], "]"}], ",", 
        RowBox[{"Range", "[", "26", "]"}]}], "}"}]}], "]"}]}], "//", 
   "Dispatch"}]}]], "Input"],

Cell[BoxData[
 TagBox[
  RowBox[{"Dispatch", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"\<\"w\"\>", "\[Rule]", "23"}], ",", 
      RowBox[{"\<\"u\"\>", "\[Rule]", "21"}], ",", 
      RowBox[{"\<\"e\"\>", "\[Rule]", "5"}], ",", 
      RowBox[{"\<\"z\"\>", "\[Rule]", "26"}], ",", 
      RowBox[{"\<\"b\"\>", "\[Rule]", "2"}], ",", 
      RowBox[{"\<\"x\"\>", "\[Rule]", "24"}], ",", 
      RowBox[{"\<\"t\"\>", "\[Rule]", "20"}], ",", 
      RowBox[{"\<\"s\"\>", "\[Rule]", "19"}], ",", 
      RowBox[{"\<\"m\"\>", "\[Rule]", "13"}], ",", 
      RowBox[{"\<\"y\"\>", "\[Rule]", "25"}], ",", 
      RowBox[{"\<\"k\"\>", "\[Rule]", "11"}], ",", 
      RowBox[{"\<\"n\"\>", "\[Rule]", "14"}], ",", 
      RowBox[{"\<\"i\"\>", "\[Rule]", "9"}], ",", 
      RowBox[{"\<\"q\"\>", "\[Rule]", "17"}], ",", 
      RowBox[{"\<\"p\"\>", "\[Rule]", "16"}], ",", 
      RowBox[{"\<\"o\"\>", "\[Rule]", "15"}], ",", 
      RowBox[{"\<\"c\"\>", "\[Rule]", "3"}], ",", 
      RowBox[{"\<\"h\"\>", "\[Rule]", "8"}], ",", 
      RowBox[{"\<\"l\"\>", "\[Rule]", "12"}], ",", 
      RowBox[{"\<\"g\"\>", "\[Rule]", "7"}], ",", 
      RowBox[{"\<\"a\"\>", "\[Rule]", "1"}], ",", 
      RowBox[{"\<\"d\"\>", "\[Rule]", "4"}], ",", 
      RowBox[{"\<\"f\"\>", "\[Rule]", "6"}], ",", 
      RowBox[{"\<\"r\"\>", "\[Rule]", "18"}], ",", 
      RowBox[{"\<\"v\"\>", "\[Rule]", "22"}], ",", 
      RowBox[{"\<\"j\"\>", "\[Rule]", "10"}]}], "}"}], ",", 
    TagBox[
     InterpretationBox[
      RowBox[{"-", "DispatchTables", "-"}],
      1],
     DisplayForm]}], "]"}],
  Function[BoxForm`arg, 
   ReplacePart[
    HoldComplete[
     Dispatch[BoxForm`e]], 
    HoldComplete[BoxForm`arg], {1, 1}, {1, 1}], {HoldAllComplete}]]], "Output",\

 CellChangeTimes->{3.605116234824959*^9, 3.605347961238056*^9, 
  3.6063568980158987`*^9, 3.606383658381527*^9, 3.607084163168408*^9}]
}, Open  ]],

Cell["\<\
My impl of hashMap cheats by just using the impl of list`list.\
\>", "Text"],

Cell[BoxData[
 RowBox[{
  RowBox[{"hashMap`hashMap", "[", "kvs_Dispatch", "]"}], ":=", 
  RowBox[{"list`list", "[", 
   RowBox[{
    RowBox[{
     RowBox[{
      RowBox[{"List", "@@", "#"}], "&"}], "/@", 
     RowBox[{"kvs", "[", 
      RowBox[{"[", "1", "]"}], "]"}]}], "//", "Sort"}], "]"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"forEach", "[", 
  RowBox[{
   RowBox[{"hashMap`hashMap", "[", "aHashMap", "]"}], ",", "Print"}], 
  "]"}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"a\"\>", ",", "1"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633570538`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"b\"\>", ",", "2"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163358199*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"c\"\>", ",", "3"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163360115*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"d\"\>", ",", "4"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163361895*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"e\"\>", ",", "5"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163363809*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"f\"\>", ",", "6"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163365652*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"g\"\>", ",", "7"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633676357`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"h\"\>", ",", "8"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633694677`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"i\"\>", ",", "9"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633713017`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"j\"\>", ",", "10"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163373053*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"k\"\>", ",", "11"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633748198`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"l\"\>", ",", "12"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163376624*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"m\"\>", ",", "13"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633784513`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"n\"\>", ",", "14"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163380241*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"o\"\>", ",", "15"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163382018*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"p\"\>", ",", "16"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.60708416338377*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"q\"\>", ",", "17"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163385563*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"r\"\>", ",", "18"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163387328*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"s\"\>", ",", "19"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633891697`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"t\"\>", ",", "20"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163390963*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"u\"\>", ",", "21"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633927727`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"v\"\>", ",", "22"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.607084163394562*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"w\"\>", ",", "23"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633963413`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"x\"\>", ",", "24"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.60708416339817*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"y\"\>", ",", "25"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841633999977`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"z\"\>", ",", "26"}], "}"}]], "Print",
 CellChangeTimes->{3.605116234912815*^9, 3.6053479613186483`*^9, 
  3.6063568980987988`*^9, 3.606383658450218*^9, 3.6070841634018593`*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["IObserver and IObservable", "Section"],

Cell[BoxData[
 RowBox[{
  RowBox[{"ClearAll", "[", "\[IndentingNewLine]", 
   RowBox[{
   "IObservable", ",", "\[IndentingNewLine]", "ISubject", ",", 
    "\[IndentingNewLine]", "IObserver", ",", "\[IndentingNewLine]", 
    "IObservableType", ",", "\[IndentingNewLine]", "IObserverType", ",", 
    "\[IndentingNewLine]", "Subscribe", ",", "\[IndentingNewLine]", "OnNext", 
    ",", " ", "\[IndentingNewLine]", "OnError", ",", "\[IndentingNewLine]", 
    "OnCompleted", ",", "\[IndentingNewLine]", "Current"}], "]"}], 
  ";"}]], "Input"],

Cell[CellGroupData[{

Cell["Delay and Force", "Subsection"],

Cell[TextData[{
 "Due to a possible bug in the Notebook interface [5], we must abstract \
definitions of ",
 StyleBox["Delay",
  FontSlant->"Italic"],
 " and ",
 StyleBox["Force",
  FontSlant->"Italic"],
 ". It's natural to express ",
 StyleBox["Delay",
  FontSlant->"Italic"],
 " by wrapping a delayed expression in a thunk -- function of no arguments -- \
and then ",
 StyleBox["Force",
  FontSlant->"Italic"],
 " evaluation by calling the thunk. This is so natural that it hardly merits \
calling out, and I would not have done but for the fact that it sometimes \
does not work in the ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " Notebook interface, though it does work in the command-line version of ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 ". The solution is to abstract the operations into explicit calls of ",
 StyleBox["Delay",
  FontSlant->"Italic"],
 " and ",
 StyleBox["Force",
  FontSlant->"Italic"],
 " and use ",
 StyleBox["Hold",
  FontSlant->"Italic"],
 " and ",
 StyleBox["ReleaseHold",
  FontSlant->"Italic"],
 ", which work in the Notebook and in the command-line version of ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 ". "
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{"Delay", ",", "Force"}], "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"Delay", "=", "Hold"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"Force", "=", "ReleaseHold"}], ";"}]}], "Input"],

Cell[CellGroupData[{

Cell["Unit Tests", "Subsubsection"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"Remove", "[", 
   RowBox[{"foo$", ",", "bar$"}], "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"foo$", "=", 
   RowBox[{"Delay", "[", 
    RowBox[{"bar$", "=", "42"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"Print", "[", 
   RowBox[{"foo$", "===", 
    RowBox[{"Hold", "[", 
     RowBox[{"bar$", "=", "42"}], "]"}]}], "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"Print", "[", 
   RowBox[{"!", 
    RowBox[{"ValueQ", "@", "bar$"}]}], "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"Force", "[", "foo$", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"Print", "[", 
   RowBox[{"ValueQ", "@", "bar$"}], "]"}], ";"}]}], "Input"],

Cell[CellGroupData[{

Cell[BoxData["True"], "Print",
 CellChangeTimes->{3.605116235094727*^9, 3.60534796145014*^9, 
  3.606356898243513*^9, 3.606383658580152*^9, 3.607084163499703*^9}],

Cell[BoxData["True"], "Print",
 CellChangeTimes->{3.605116235094727*^9, 3.60534796145014*^9, 
  3.606356898243513*^9, 3.606383658580152*^9, 3.607084163500882*^9}],

Cell[BoxData["True"], "Print",
 CellChangeTimes->{3.605116235094727*^9, 3.60534796145014*^9, 
  3.606356898243513*^9, 3.606383658580152*^9, 3.607084163502734*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Abstract Types", "Subsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "IObservableType", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"IObservableType", "=", 
   RowBox[{"{", 
    RowBox[{"Subscribe", "[", "_", "]"}], "}"}]}], ";"}]}], "Input"],

Cell[TextData[{
 "TODO: Should be ",
 StyleBox["Subscribe[_IObserverType]", "Input"],
 ". Also should have a type for exceptions."
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "IObserverType", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"IObserverType", "=", 
   RowBox[{"{", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"OnNext", "[", "observation_", "]"}], ",", "\[IndentingNewLine]", 
     RowBox[{"OnError", "[", "exception_", "]"}], ",", "\[IndentingNewLine]", 
     
     RowBox[{"OnCompleted", "[", "]"}]}], "}"}]}], ";"}]}], "Input"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Contracts", "Subsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "ISubject", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"ISubject", "[", 
   RowBox[{"this_", "?", "ObjectQ"}], "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"Module", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"subscriptions", "=", 
        RowBox[{"{", "}"}]}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{
         RowBox[{"DebugReport", "[", "]"}], "\[RuleDelayed]", 
         "subscriptions"}], ",", "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"OnNext", "[", "obn_", "]"}], "\[RuleDelayed]", 
         "\[IndentingNewLine]", 
         RowBox[{"Scan", "[", 
          RowBox[{
           RowBox[{
            RowBox[{"#", ".", 
             RowBox[{"OnNext", "[", "obn", "]"}]}], "&"}], ",", 
           RowBox[{"GetReplacements", "@", "subscriptions"}]}], "]"}]}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"OnError", "[", "exc_", "]"}], "\[RuleDelayed]", 
         RowBox[{"(", 
          RowBox[{
           RowBox[{"Scan", "[", 
            RowBox[{
             RowBox[{
              RowBox[{"#", ".", 
               RowBox[{"OnError", "[", "exc", "]"}]}], "&"}], ",", 
             RowBox[{"GetReplacements", "@", "subscriptions"}]}], "]"}], ";", 
           
           RowBox[{"subscriptions", "=", "Null"}]}], ")"}]}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
         RowBox[{"(", 
          RowBox[{
           RowBox[{"Scan", "[", 
            RowBox[{
             RowBox[{
              RowBox[{"#", ".", 
               RowBox[{"OnCompleted", "[", "]"}]}], "&"}], ",", 
             RowBox[{"GetReplacements", "@", "subscriptions"}]}], "]"}], ";", 
           
           RowBox[{"subscriptions", "=", "Null"}]}], ")"}]}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"Subscribe", "[", 
          RowBox[{"that_", "?", 
           RowBox[{"(", 
            RowBox[{
             RowBox[{"ProvidesTypeQ", "[", 
              RowBox[{"#", ",", "IObserverType"}], "]"}], "&"}], ")"}]}], 
          "]"}], "\[RuleDelayed]", "\[IndentingNewLine]", 
         RowBox[{"Module", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"id", ",", "subscription"}], "}"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"id", "=", 
             RowBox[{"If", "[", 
              RowBox[{
               RowBox[{"HasPattern", "[", 
                RowBox[{"that", ",", "SubscriptionId"}], "]"}], ",", 
               "\[IndentingNewLine]", 
               RowBox[{"that", ".", "SubscriptionId"}], ",", 
               "\[IndentingNewLine]", 
               RowBox[{"Unique", "[", "]"}]}], "]"}]}], ";", 
            "\[IndentingNewLine]", 
            RowBox[{"subscription", "=", 
             RowBox[{"(", 
              RowBox[{"id", "\[Rule]", "that"}], ")"}]}], ";", 
            "\[IndentingNewLine]", 
            RowBox[{"AppendTo", "[", 
             RowBox[{"subscriptions", ",", "subscription"}], "]"}], ";", 
            "\[IndentingNewLine]", 
            RowBox[{"With", "[", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"unsubscribe", "=", 
                RowBox[{"Delay", "[", 
                 RowBox[{"subscriptions", "=", 
                  RowBox[{"RemoveRule", "[", 
                   RowBox[{"subscriptions", ",", "id"}], "]"}]}], "]"}]}], 
               "}"}], ",", "\[IndentingNewLine]", "unsubscribe"}], "]"}]}]}], 
          "]"}]}]}], "\[IndentingNewLine]", "}"}]}], "]"}], "//", "Sort"}], "//",
    "Dispatch"}]}]}], "Input"],

Cell[BoxData[
 RowBox[{
  RowBox[{"$myObl", "=", 
   RowBox[{"ISubject", "[", 
    RowBox[{"{", "}"}], "]"}]}], ";"}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"DebugReport", "[", "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", "}"}]], "Output",
 CellChangeTimes->{3.6051162352553463`*^9, 3.6053479617002974`*^9, 
  3.60635689839328*^9, 3.606383658792482*^9, 3.607084163664132*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell["User-Supplied Subscription Ids", "Subsubsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "$obr", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"$obr", "[", "subscriptionId_", "]"}], ":=", 
  RowBox[{
   RowBox[{
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"SubscriptionId", "\[RuleDelayed]", "subscriptionId"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"OnNext", "[", "msg_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "@", "subscriptionId"}], "<>", 
         "\"\<: Observer OnNext: \>\"", "<>", " ", 
         RowBox[{"ToString", "@", "msg"}]}], "]"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"OnError", "[", "exc_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "@", "subscriptionId"}], "<>", 
         "\"\<: Observer OnError: \>\"", "<>", " ", 
         RowBox[{"ToString", "@", "exc"}]}], "]"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "@", "subscriptionId"}], "<>", 
         "\"\<: Observer OnCompleted!\>\""}], "]"}]}]}], "}"}], "//", 
    "Sort"}], "//", "Dispatch"}]}]}], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"unsubscribeFirstObserver", "=", 
  RowBox[{"$myObl", ".", 
   RowBox[{"Subscribe", "[", 
    RowBox[{"$obr", "[", 
     RowBox[{"Unique", "[", "]"}], "]"}], "]"}]}]}]], "Input"],

Cell[BoxData[
 RowBox[{"Hold", "[", 
  RowBox[{"subscriptions$291", "=", 
   RowBox[{"RemoveRule", "[", 
    RowBox[{"subscriptions$291", ",", "id$292"}], "]"}]}], "]"}]], "Output",
 CellChangeTimes->{3.605116235326968*^9, 3.6053479617714663`*^9, 
  3.6063568985608463`*^9, 3.606383658862294*^9, 3.607084163732986*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"DebugReport", "[", "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"$7", "\[Rule]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"SubscriptionId", "\[RuleDelayed]", "$7"}], ",", 
     RowBox[{
      RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
      RowBox[{"Print", "[", 
       RowBox[{
        RowBox[{"ToString", "[", "$7", "]"}], 
        "<>", "\<\": Observer OnCompleted!\"\>"}], "]"}]}], ",", 
     RowBox[{
      RowBox[{"OnError", "[", "exc$_", "]"}], "\[RuleDelayed]", 
      RowBox[{"Print", "[", 
       RowBox[{
        RowBox[{"ToString", "[", "$7", "]"}], 
        "<>", "\<\": Observer OnError: \"\>", "<>", 
        RowBox[{"ToString", "[", "exc$", "]"}]}], "]"}]}], ",", 
     RowBox[{
      RowBox[{"OnNext", "[", "msg$_", "]"}], "\[RuleDelayed]", 
      RowBox[{"Print", "[", 
       RowBox[{
        RowBox[{"ToString", "[", "$7", "]"}], 
        "<>", "\<\": Observer OnNext: \"\>", "<>", 
        RowBox[{"ToString", "[", "msg$", "]"}]}], "]"}]}]}], "}"}]}], 
  "}"}]], "Output",
 CellChangeTimes->{3.605116235373437*^9, 3.605347961805833*^9, 
  3.606356898594244*^9, 3.606383658893261*^9, 3.607084163785668*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"OnNext", "[", "42", "]"}]}]], "Input"],

Cell[BoxData["\<\"$7: Observer OnNext: 42\"\>"], "Print",
 CellChangeTimes->{3.60511623542758*^9, 3.6053479618552628`*^9, 
  3.6063568986489153`*^9, 3.606383658946611*^9, 3.607084163837637*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"unsubscribeSecondObserver", "=", 
  RowBox[{"$myObl", ".", 
   RowBox[{"Subscribe", "[", 
    RowBox[{"$obr", "[", 
     RowBox[{"Unique", "[", "]"}], "]"}], "]"}]}]}]], "Input"],

Cell[BoxData[
 RowBox[{"Hold", "[", 
  RowBox[{"subscriptions$291", "=", 
   RowBox[{"RemoveRule", "[", 
    RowBox[{"subscriptions$291", ",", "id$293"}], "]"}]}], "]"}]], "Output",
 CellChangeTimes->{3.605116235460361*^9, 3.605347961905396*^9, 
  3.606356898694158*^9, 3.606383659012507*^9, 3.60708416388568*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"DebugReport", "[", "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"$7", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"SubscriptionId", "\[RuleDelayed]", "$7"}], ",", 
      RowBox[{
       RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$7", "]"}], 
         "<>", "\<\": Observer OnCompleted!\"\>"}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnError", "[", "exc$_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$7", "]"}], 
         "<>", "\<\": Observer OnError: \"\>", "<>", 
         RowBox[{"ToString", "[", "exc$", "]"}]}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnNext", "[", "msg$_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$7", "]"}], 
         "<>", "\<\": Observer OnNext: \"\>", "<>", 
         RowBox[{"ToString", "[", "msg$", "]"}]}], "]"}]}]}], "}"}]}], ",", 
   RowBox[{"$8", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"SubscriptionId", "\[RuleDelayed]", "$8"}], ",", 
      RowBox[{
       RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$8", "]"}], 
         "<>", "\<\": Observer OnCompleted!\"\>"}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnError", "[", "exc$_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$8", "]"}], 
         "<>", "\<\": Observer OnError: \"\>", "<>", 
         RowBox[{"ToString", "[", "exc$", "]"}]}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnNext", "[", "msg$_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$8", "]"}], 
         "<>", "\<\": Observer OnNext: \"\>", "<>", 
         RowBox[{"ToString", "[", "msg$", "]"}]}], "]"}]}]}], "}"}]}]}], 
  "}"}]], "Output",
 CellChangeTimes->{3.605116235490778*^9, 3.605347961956365*^9, 
  3.606356898744793*^9, 3.606383659094413*^9, 3.6070841639364567`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"OnNext", "[", "42", "]"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData["\<\"$7: Observer OnNext: 42\"\>"], "Print",
 CellChangeTimes->{3.605116235528264*^9, 3.605347962004987*^9, 
  3.606356898793797*^9, 3.606383659262635*^9, 3.6070841639862967`*^9}],

Cell[BoxData["\<\"$8: Observer OnNext: 42\"\>"], "Print",
 CellChangeTimes->{3.605116235528264*^9, 3.605347962004987*^9, 
  3.606356898793797*^9, 3.606383659262635*^9, 3.607084163987364*^9}]
}, Open  ]]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"Force", "[", "unsubscribeFirstObserver", "]"}], ";"}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"OnNext", "[", "42", "]"}]}]], "Input"],

Cell[BoxData["\<\"$8: Observer OnNext: 42\"\>"], "Print",
 CellChangeTimes->{3.605116235610071*^9, 3.605347962088552*^9, 
  3.606356898882208*^9, 3.606383659542163*^9, 3.607084164067849*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["System-Supplied Subscription Ids", "Subsubsection"],

Cell[BoxData[
 RowBox[{
  RowBox[{"$obr", "[", "]"}], ":=", 
  RowBox[{
   RowBox[{
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{
       RowBox[{"OnNext", "[", "msg_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{"\"\<Observer OnNext: \>\"", "<>", " ", 
         RowBox[{"ToString", "@", "msg"}]}], "]"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"OnError", "[", "exc_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{"\"\<Observer OnError: \>\"", "<>", " ", 
         RowBox[{"ToString", "@", "exc"}]}], "]"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", "\"\<Observer OnCompleted!\>\"", "]"}]}]}], 
     "}"}], "//", "Sort"}], "//", "Dispatch"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"unsubscribeThirdObserver", "=", 
  RowBox[{"$myObl", ".", 
   RowBox[{"Subscribe", "[", 
    RowBox[{"$obr", "[", "]"}], "]"}]}]}]], "Input"],

Cell[BoxData[
 RowBox[{"Hold", "[", 
  RowBox[{"subscriptions$291", "=", 
   RowBox[{"RemoveRule", "[", 
    RowBox[{"subscriptions$291", ",", "id$294"}], "]"}]}], "]"}]], "Output",
 CellChangeTimes->{3.605116235692624*^9, 3.6053479621667624`*^9, 
  3.606356898963463*^9, 3.60638365961257*^9, 3.6070841641362886`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"DebugReport", "[", "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"$8", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"SubscriptionId", "\[RuleDelayed]", "$8"}], ",", 
      RowBox[{
       RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$8", "]"}], 
         "<>", "\<\": Observer OnCompleted!\"\>"}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnError", "[", "exc$_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$8", "]"}], 
         "<>", "\<\": Observer OnError: \"\>", "<>", 
         RowBox[{"ToString", "[", "exc$", "]"}]}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnNext", "[", "msg$_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$8", "]"}], 
         "<>", "\<\": Observer OnNext: \"\>", "<>", 
         RowBox[{"ToString", "[", "msg$", "]"}]}], "]"}]}]}], "}"}]}], ",", 
   RowBox[{"$9", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", "\<\"Observer OnCompleted!\"\>", "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnError", "[", "exc_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{"\<\"Observer OnError: \"\>", "<>", 
         RowBox[{"ToString", "[", "exc", "]"}]}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnNext", "[", "msg_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{"\<\"Observer OnNext: \"\>", "<>", 
         RowBox[{"ToString", "[", "msg", "]"}]}], "]"}]}]}], "}"}]}]}], 
  "}"}]], "Output",
 CellChangeTimes->{3.605116235744104*^9, 3.605347962221294*^9, 
  3.606356899012088*^9, 3.606383659665313*^9, 3.60708416418681*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"unsubscribeFourthObserver", "=", 
  RowBox[{"$myObl", ".", 
   RowBox[{"Subscribe", "[", 
    RowBox[{"$obr", "[", "]"}], "]"}]}]}]], "Input"],

Cell[BoxData[
 RowBox[{"Hold", "[", 
  RowBox[{"subscriptions$291", "=", 
   RowBox[{"RemoveRule", "[", 
    RowBox[{"subscriptions$291", ",", "id$295"}], "]"}]}], "]"}]], "Output",
 CellChangeTimes->{3.605116235776526*^9, 3.605347962253598*^9, 
  3.606356899066195*^9, 3.60638365969643*^9, 3.607084164235379*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"OnNext", "[", "42", "]"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData["\<\"Observer OnNext: 42\"\>"], "Print",
 CellChangeTimes->{3.605116235827997*^9, 3.605347962306779*^9, 
  3.606356899111717*^9, 3.6063836598305073`*^9, 3.6070841644365892`*^9}],

Cell[BoxData["\<\"$8: Observer OnNext: 42\"\>"], "Print",
 CellChangeTimes->{3.605116235827997*^9, 3.605347962306779*^9, 
  3.606356899111717*^9, 3.6063836598305073`*^9, 3.607084164437669*^9}],

Cell[BoxData["\<\"Observer OnNext: 42\"\>"], "Print",
 CellChangeTimes->{3.605116235827997*^9, 3.605347962306779*^9, 
  3.606356899111717*^9, 3.6063836598305073`*^9, 3.607084164439658*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Force", "[", "unsubscribeThirdObserver", "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"$10", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", "\<\"Observer OnCompleted!\"\>", "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnError", "[", "exc_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{"\<\"Observer OnError: \"\>", "<>", 
         RowBox[{"ToString", "[", "exc", "]"}]}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnNext", "[", "msg_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{"\<\"Observer OnNext: \"\>", "<>", 
         RowBox[{"ToString", "[", "msg", "]"}]}], "]"}]}]}], "}"}]}], ",", 
   RowBox[{"$8", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"SubscriptionId", "\[RuleDelayed]", "$8"}], ",", 
      RowBox[{
       RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$8", "]"}], 
         "<>", "\<\": Observer OnCompleted!\"\>"}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnError", "[", "exc$_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$8", "]"}], 
         "<>", "\<\": Observer OnError: \"\>", "<>", 
         RowBox[{"ToString", "[", "exc$", "]"}]}], "]"}]}], ",", 
      RowBox[{
       RowBox[{"OnNext", "[", "msg$_", "]"}], "\[RuleDelayed]", 
       RowBox[{"Print", "[", 
        RowBox[{
         RowBox[{"ToString", "[", "$8", "]"}], 
         "<>", "\<\": Observer OnNext: \"\>", "<>", 
         RowBox[{"ToString", "[", "msg$", "]"}]}], "]"}]}]}], "}"}]}]}], 
  "}"}]], "Output",
 CellChangeTimes->{3.605116235861405*^9, 3.605347962340055*^9, 
  3.6063568991495657`*^9, 3.606383659876916*^9, 3.607084164486292*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"OnNext", "[", "42", "]"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData["\<\"Observer OnNext: 42\"\>"], "Print",
 CellChangeTimes->{3.6051162358936853`*^9, 3.60534796238914*^9, 
  3.606356899199523*^9, 3.606383659913533*^9, 3.6070841645343*^9}],

Cell[BoxData["\<\"$8: Observer OnNext: 42\"\>"], "Print",
 CellChangeTimes->{3.6051162358936853`*^9, 3.60534796238914*^9, 
  3.606356899199523*^9, 3.606383659913533*^9, 3.607084164535328*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"OnCompleted", "[", "]"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData["\<\"Observer OnCompleted!\"\>"], "Print",
 CellChangeTimes->{3.605116235928196*^9, 3.6053479624218063`*^9, 
  3.6063568992488327`*^9, 3.606383659959124*^9, 3.607084164584179*^9}],

Cell[BoxData["\<\"$8: Observer OnCompleted!\"\>"], "Print",
 CellChangeTimes->{3.605116235928196*^9, 3.6053479624218063`*^9, 
  3.6063568992488327`*^9, 3.606383659959124*^9, 3.607084164585229*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$myObl", ".", 
  RowBox[{"OnNext", "[", "42", "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{
  StyleBox[
   RowBox[{"ReplaceAll", "::", "reps"}], "MessageName"], 
  RowBox[{
  ":", " "}], "\<\"\[NoBreak]\\!\\({Null}\\)\[NoBreak] is neither a list of \
replacement rules nor a valid dispatch table, and so cannot be used for \
replacing. \\!\\(\\*ButtonBox[\\\"\[RightSkeleton]\\\", ButtonStyle->\\\"Link\
\\\", ButtonFrame->None, ButtonData:>\\\"paclet:ref/message/ReplaceAll/reps\\\
\", ButtonNote -> \\\"ReplaceAll::reps\\\"]\\)\"\>"}]], "Message", "MSG",
 CellChangeTimes->{3.605116236023488*^9, 3.605347962473043*^9, 
  3.606356899354738*^9, 3.6063836600762157`*^9, 3.607084164695353*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["GenerateWithTime", "Subsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "$foobr", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"$foobr", "[", "subscriptionId_", "]"}], ":=", 
  RowBox[{
   RowBox[{
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"SubscriptionId", "\[RuleDelayed]", "subscriptionId"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"OnNext", "[", "msg_", "]"}], "\[RuleDelayed]", 
       RowBox[{"(", 
        RowBox[{"$foo", "=", 
         RowBox[{
          RowBox[{"ToString", "@", "subscriptionId"}], "<>", 
          "\"\<: Observer OnNext: \>\"", "<>", " ", 
          RowBox[{"ToString", "@", "msg"}]}]}], ")"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"OnError", "[", "exc_", "]"}], "\[RuleDelayed]", 
       RowBox[{"(", 
        RowBox[{"$foo", "=", 
         RowBox[{
          RowBox[{"ToString", "@", "subscriptionId"}], "<>", 
          "\"\<: Observer OnError: \>\"", "<>", " ", 
          RowBox[{"ToString", "@", "exc"}]}]}], ")"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
       RowBox[{"(", 
        RowBox[{"$foo", "=", 
         RowBox[{
          RowBox[{"ToString", "@", "subscriptionId"}], "<>", 
          "\"\<: Observer OnCompleted!\>\""}]}], ")"}]}]}], "}"}], "//", 
    "Sort"}], "//", "Dispatch"}]}]}], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Dynamic", "[", "$foo", "]"}]], "Input"],

Cell[BoxData[
 DynamicBox[ToBoxes[$CellContext`$foo, StandardForm],
  ImageSizeCache->{39., {2., 11.}}]], "Output",
 CellChangeTimes->{3.605116236223238*^9, 3.6053479626845512`*^9, 
  3.60635689943158*^9, 3.6063836601640387`*^9, 3.607084164766884*^9}]
}, Open  ]],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "GenerateWithTime", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"GenerateWithTime", "[", "\[IndentingNewLine]", 
    RowBox[{"initialState_", ",", "\[IndentingNewLine]", "condition_", ",", 
     RowBox[{"(*", " ", 
      RowBox[{"State", " ", "\[Rule]", " ", "Bool"}], " ", "*)"}], 
     "\[IndentingNewLine]", "resultSelector_", ",", " ", 
     RowBox[{"(*", " ", 
      RowBox[{"State", " ", "\[Rule]", " ", "Result"}], " ", "*)"}], 
     "\[IndentingNewLine]", "timeSelector_", ",", " ", 
     RowBox[{"(*", " ", 
      RowBox[{"State", " ", "\[Rule]", " ", "Real"}], " ", "*)"}], 
     "\[IndentingNewLine]", "iterate_"}], " ", 
    RowBox[{"(*", " ", 
     RowBox[{"State", " ", "\[Rule]", " ", "State"}], " ", "*)"}], "]"}], ":=",
    "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"Subscribe", "[", 
        RowBox[{"obr_", "?", 
         RowBox[{"(", 
          RowBox[{
           RowBox[{"ProvidesTypeQ", "[", 
            RowBox[{"#", ",", "IObserverType"}], "]"}], "&"}], ")"}]}], "]"}],
        "\[RuleDelayed]", "\[IndentingNewLine]", 
       RowBox[{"Module", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
          "task", ",", "getTask", ",", "\[IndentingNewLine]", 
           "createCleanUpTask", ",", "cleanUpTask", ",", "getCleanUpTask", 
           ",", "\[IndentingNewLine]", 
           RowBox[{"state", "=", "initialState"}]}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"(*", " ", 
          RowBox[{"TODO", ":", " ", 
           RowBox[{
           "catch", " ", "exceptions", " ", "and", " ", "call", " ", 
            "OnError"}]}], " ", "*)"}], "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{
           RowBox[{"getTask", "[", "]"}], ":=", "task"}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"getCleanUpTask", "[", "]"}], ":=", "cleanUpTask"}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"createCleanUpTask", "[", "]"}], ":=", 
           RowBox[{"cleanUpTask", "=", 
            RowBox[{"CreateScheduledTask", "[", "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{
               RowBox[{"RemoveScheduledTask", "@", 
                RowBox[{"getTask", "[", "]"}]}], ";", "\[IndentingNewLine]", 
               RowBox[{"obr", ".", 
                RowBox[{"OnCompleted", "[", "]"}]}], ";", 
               "\[IndentingNewLine]", 
               RowBox[{"RemoveScheduledTask", "@", 
                RowBox[{"getCleanUpTask", "[", "]"}]}]}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"{", 
               RowBox[{"timeSelector", "@", "state"}], "}"}]}], "]"}]}]}], 
          ";", "\[IndentingNewLine]", 
          RowBox[{"task", "=", 
           RowBox[{"RunScheduledTask", "[", "\[IndentingNewLine]", 
            RowBox[{
             RowBox[{
              RowBox[{"obr", ".", 
               RowBox[{"OnNext", "[", 
                RowBox[{"resultSelector", "@", "state"}], "]"}]}], ";", 
              "\[IndentingNewLine]", 
              RowBox[{"state", "=", 
               RowBox[{"iterate", "@", "state"}]}], ";", 
              "\[IndentingNewLine]", 
              RowBox[{"If", "[", 
               RowBox[{
                RowBox[{"condition", "@", "state"}], ",", 
                "\[IndentingNewLine]", 
                RowBox[{"StartScheduledTask", "@", 
                 RowBox[{"getTask", "[", "]"}]}], ",", "\[IndentingNewLine]", 
                
                RowBox[{"StartScheduledTask", "@", 
                 RowBox[{"createCleanUpTask", "[", "]"}]}]}], "]"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"{", 
              RowBox[{"timeSelector", "@", "state"}], "}"}]}], "]"}]}], 
          ";"}]}], "\[IndentingNewLine]", "]"}]}], "}"}], "//", "Sort"}], "//",
     "Dispatch"}]}], ";"}], "\n", 
 RowBox[{
  RowBox[{"$foo", "=", 
   RowBox[{"-", "1"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"RemoveScheduledTask", "@", 
   RowBox[{"ScheduledTasks", "[", "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"Force", "[", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"GenerateWithTime", "[", 
     RowBox[{"0", ",", 
      RowBox[{
       RowBox[{"#", "<", "5"}], "&"}], ",", 
      RowBox[{"#", "&"}], ",", 
      RowBox[{
       RowBox[{"(", "0.25", ")"}], "&"}], ",", 
      RowBox[{
       RowBox[{"#", "+", "1"}], "&"}]}], "]"}], ".", 
    RowBox[{"Subscribe", "[", 
     RowBox[{"$foobr", "[", 
      RowBox[{"Unique", "[", "]"}], "]"}], "]"}]}], "]"}], ";"}]}], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ScheduledTasks", "[", "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"ScheduledTaskObject", "[", 
   RowBox[{"4", ",", 
    TagBox[
     RowBox[{
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"SubscriptionId", "\[RuleDelayed]", "$11"}], ",", 
         RowBox[{
          RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
          RowBox[{"(", 
           RowBox[{"$foo", "=", 
            RowBox[{
             RowBox[{"ToString", "[", "$11", "]"}], 
             "<>", "\<\": Observer OnCompleted!\"\>"}]}], ")"}]}], ",", 
         RowBox[{
          RowBox[{"OnError", "[", "exc$_", "]"}], "\[RuleDelayed]", 
          RowBox[{"(", 
           RowBox[{"$foo", "=", 
            RowBox[{
             RowBox[{"ToString", "[", "$11", "]"}], 
             "<>", "\<\": Observer OnError: \"\>", "<>", 
             RowBox[{"ToString", "[", "exc$", "]"}]}]}], ")"}]}], ",", 
         RowBox[{
          RowBox[{"OnNext", "[", "msg$_", "]"}], "\[RuleDelayed]", 
          RowBox[{"(", 
           RowBox[{"$foo", "=", 
            RowBox[{
             RowBox[{"ToString", "[", "$11", "]"}], 
             "<>", "\<\": Observer OnNext: \"\>", "<>", 
             RowBox[{"ToString", "[", "msg$", "]"}]}]}], ")"}]}]}], "}"}], 
       ".", 
       RowBox[{"OnNext", "[", 
        RowBox[{
         RowBox[{"(", 
          RowBox[{"#1", "&"}], ")"}], "[", "state$474", "]"}], "]"}]}], ";", 
      RowBox[{"state$474", "=", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{
          RowBox[{"#1", "+", "1"}], "&"}], ")"}], "[", "state$474", "]"}]}], 
      ";", 
      RowBox[{"If", "[", 
       RowBox[{
        RowBox[{
         RowBox[{"(", 
          RowBox[{
           RowBox[{"#1", "<", "5"}], "&"}], ")"}], "[", "state$474", "]"}], 
        ",", 
        RowBox[{"StartScheduledTask", "[", 
         RowBox[{"getTask$474", "[", "]"}], "]"}], ",", 
        RowBox[{"StartScheduledTask", "[", 
         RowBox[{"createCleanUpTask$474", "[", "]"}], "]"}]}], "]"}]}],
     HoldForm], ",", 
    RowBox[{"{", 
     RowBox[{"0.25`", ",", "1"}], "}"}], ",", "Automatic", ",", "True"}], 
   "]"}], "}"}]], "Output",
 CellChangeTimes->{3.605116236293816*^9, 3.6053479627510357`*^9, 
  3.606356899594057*^9, 3.606383660230521*^9, 3.607084164835696*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]]
},
WindowSize->{960, 1032},
WindowMargins->{{Automatic, 0}, {Automatic, 0}},
PrintingCopies->1,
PrintingPageRange->{1, Automatic},
ShowSelection->True,
Magnification:>1.25 Inherited,
FrontEndVersion->"9.0 for Mac OS X x86 (32-bit, 64-bit Kernel) (January 25, \
2013)",
StyleDefinitions->FrontEnd`FileName[{"Report"}, "StandardReport.nb", 
  CharacterEncoding -> "UTF-8"]
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1485, 35, 59, 0, 112, "Title"],
Cell[1547, 37, 84, 2, 74, "Subtitle"],
Cell[CellGroupData[{
Cell[1656, 43, 31, 0, 103, "Section"],
Cell[1690, 45, 544, 16, 85, "Text"],
Cell[2237, 63, 119, 3, 37, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[2393, 71, 29, 0, 103, "Section"],
Cell[CellGroupData[{
Cell[2447, 75, 89, 2, 31, "ItemNumbered"],
Cell[2539, 79, 76, 2, 31, "ItemNumbered"],
Cell[2618, 83, 75, 2, 31, "ItemNumbered"],
Cell[2696, 87, 70, 0, 31, "ItemNumbered"],
Cell[2769, 89, 76, 2, 31, "ItemNumbered"],
Cell[2848, 93, 90, 2, 31, "ItemNumbered"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[2987, 101, 52, 0, 103, "Section"],
Cell[3042, 103, 466, 9, 85, "Text"],
Cell[3511, 114, 235, 4, 61, "Text"],
Cell[3749, 120, 405, 12, 61, "Text"],
Cell[CellGroupData[{
Cell[4179, 136, 35, 0, 39, "Subsection"],
Cell[4217, 138, 232, 7, 37, "Text"],
Cell[4452, 147, 730, 19, 109, "Text"],
Cell[CellGroupData[{
Cell[5207, 170, 119, 1, 38, "Subsubsection"],
Cell[5329, 173, 1947, 53, 300, "Input"],
Cell[7279, 228, 221, 5, 61, "Text"],
Cell[7503, 235, 504, 11, 85, "Text"],
Cell[8010, 248, 677, 15, 109, "Text"],
Cell[8690, 265, 107, 4, 37, "Text"],
Cell[8800, 271, 3726, 104, 573, "Input"],
Cell[12529, 377, 169, 3, 37, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[12735, 385, 35, 0, 38, "Subsubsection"],
Cell[CellGroupData[{
Cell[12795, 389, 339, 10, 48, "Input"],
Cell[13137, 401, 163, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[13337, 408, 341, 10, 48, "Input"],
Cell[13681, 420, 167, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[13885, 427, 376, 11, 48, "Input"],
Cell[14264, 440, 166, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[14467, 447, 369, 11, 48, "Input"],
Cell[14839, 460, 166, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[15042, 467, 473, 14, 69, "Input"],
Cell[15518, 483, 165, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[15720, 490, 570, 17, 69, "Input"],
Cell[16293, 509, 168, 2, 47, "Output"]
}, Open  ]],
Cell[16476, 514, 590, 16, 111, "Input"],
Cell[CellGroupData[{
Cell[17091, 534, 270, 7, 69, "Input"],
Cell[17364, 543, 164, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[17565, 550, 273, 7, 69, "Input"],
Cell[17841, 559, 162, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[18040, 566, 264, 8, 48, "Input"],
Cell[18307, 576, 167, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[18511, 583, 362, 9, 48, "Input"],
Cell[18876, 594, 163, 2, 47, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[19100, 603, 48, 0, 39, "Subsection"],
Cell[19151, 605, 276, 5, 61, "Text"],
Cell[19430, 612, 2955, 89, 363, "Input"],
Cell[CellGroupData[{
Cell[22410, 705, 71, 2, 38, "Subsubsection"],
Cell[22484, 709, 223, 4, 61, "Text"],
Cell[22710, 715, 1218, 19, 299, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[23965, 739, 34, 0, 38, "Subsubsection"],
Cell[CellGroupData[{
Cell[24024, 743, 108, 3, 47, "Input"],
Cell[24135, 748, 213, 4, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[24385, 757, 134, 4, 47, "Input"],
Cell[24522, 763, 241, 5, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[24800, 773, 174, 5, 48, "Input"],
Cell[24977, 780, 168, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[25182, 787, 174, 5, 47, "Input"],
Cell[25359, 794, 165, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[25561, 801, 161, 3, 69, "Input"],
Cell[25725, 806, 166, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[25928, 813, 333, 10, 48, "Input"],
Cell[26264, 825, 166, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[26467, 832, 524, 15, 132, "Input"],
Cell[26994, 849, 165, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[27196, 856, 586, 16, 132, "Input"],
Cell[27785, 874, 167, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[27989, 881, 586, 16, 132, "Input"],
Cell[28578, 899, 167, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[28782, 906, 586, 16, 132, "Input"],
Cell[29371, 924, 170, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[29578, 931, 246, 6, 69, "Input"],
Cell[29827, 939, 164, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[30028, 946, 407, 11, 69, "Input"],
Cell[30438, 959, 166, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[30641, 966, 273, 8, 54, "Input"],
Cell[30917, 976, 558, 15, 54, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[31512, 996, 745, 22, 82, "Input"],
Cell[32260, 1020, 166, 2, 47, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[32487, 1029, 63, 0, 39, "Subsection"],
Cell[32553, 1031, 311, 5, 61, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[32901, 1041, 35, 0, 39, "Subsection"],
Cell[32939, 1043, 416, 7, 85, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[33392, 1055, 56, 0, 39, "Subsection"],
Cell[33451, 1057, 154, 3, 37, "Text"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[33654, 1066, 46, 0, 103, "Section"],
Cell[33703, 1068, 411, 8, 195, "Input"],
Cell[CellGroupData[{
Cell[34139, 1080, 36, 0, 39, "Subsection"],
Cell[34178, 1082, 335, 9, 61, "Text"],
Cell[34516, 1093, 241, 7, 69, "Input"],
Cell[34760, 1102, 271, 9, 69, "Input"]
}, Open  ]],
Cell[CellGroupData[{
Cell[35068, 1116, 31, 0, 39, "Subsection"],
Cell[35102, 1118, 529, 13, 85, "Text"],
Cell[35634, 1133, 326, 9, 69, "Input"],
Cell[35963, 1144, 608, 14, 109, "Text"],
Cell[36574, 1160, 1492, 43, 158, "Item"],
Cell[38069, 1205, 5015, 122, 636, "Input"],
Cell[43087, 1329, 254, 6, 61, "Text"],
Cell[43344, 1337, 440, 11, 111, "Input"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[43833, 1354, 50, 0, 103, "Section"],
Cell[43886, 1356, 430, 15, 61, "Text"],
Cell[44319, 1373, 2300, 55, 321, "Input"]
}, Open  ]],
Cell[CellGroupData[{
Cell[46656, 1433, 26, 0, 103, "Section"],
Cell[46685, 1435, 452, 14, 85, "Text"],
Cell[47140, 1451, 928, 26, 174, "Input"],
Cell[CellGroupData[{
Cell[48093, 1481, 249, 7, 47, "Input"],
Cell[CellGroupData[{
Cell[48367, 1492, 180, 2, 26, "Print"],
Cell[48550, 1496, 181, 2, 26, "Print"],
Cell[48734, 1500, 179, 2, 26, "Print"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[48962, 1508, 108, 1, 39, "Subsection"],
Cell[49073, 1511, 202, 6, 61, "Text"],
Cell[49278, 1519, 1875, 52, 237, "Input"],
Cell[CellGroupData[{
Cell[51178, 1575, 34, 0, 38, "Subsubsection"],
Cell[CellGroupData[{
Cell[51237, 1579, 236, 6, 47, "Input"],
Cell[CellGroupData[{
Cell[51498, 1589, 191, 6, 26, "Print"],
Cell[51692, 1597, 117, 3, 26, "Print"],
Cell[51812, 1602, 168, 5, 26, "Print"],
Cell[51983, 1609, 118, 3, 26, "Print"],
Cell[52104, 1614, 142, 4, 26, "Print"],
Cell[52249, 1620, 116, 3, 26, "Print"],
Cell[52368, 1625, 113, 3, 26, "Print"],
Cell[52484, 1630, 115, 3, 26, "Print"],
Cell[52602, 1635, 144, 4, 26, "Print"],
Cell[52749, 1641, 116, 3, 26, "Print"],
Cell[52868, 1646, 113, 3, 26, "Print"],
Cell[52984, 1651, 115, 3, 26, "Print"],
Cell[53102, 1656, 168, 5, 26, "Print"],
Cell[53273, 1663, 191, 6, 26, "Print"],
Cell[53467, 1671, 212, 6, 26, "Print"],
Cell[53682, 1679, 122, 3, 26, "Print"],
Cell[53807, 1684, 113, 3, 26, "Print"],
Cell[53923, 1689, 166, 5, 26, "Print"],
Cell[54092, 1696, 113, 3, 26, "Print"]
}, Open  ]],
Cell[54220, 1702, 120, 2, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[54377, 1709, 244, 8, 47, "Input"],
Cell[54624, 1719, 188, 3, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[54849, 1727, 393, 11, 47, "Input"],
Cell[CellGroupData[{
Cell[55267, 1742, 340, 11, 26, "Print"],
Cell[55610, 1755, 117, 3, 26, "Print"],
Cell[55730, 1760, 287, 9, 26, "Print"],
Cell[56020, 1771, 117, 3, 26, "Print"],
Cell[56140, 1776, 261, 8, 26, "Print"],
Cell[56404, 1786, 118, 3, 26, "Print"],
Cell[56525, 1791, 115, 3, 26, "Print"],
Cell[56643, 1796, 228, 7, 26, "Print"],
Cell[56874, 1805, 118, 3, 26, "Print"],
Cell[56995, 1810, 199, 6, 26, "Print"],
Cell[57197, 1818, 118, 3, 26, "Print"],
Cell[57318, 1823, 115, 3, 26, "Print"],
Cell[57436, 1828, 169, 5, 26, "Print"],
Cell[57608, 1835, 118, 3, 26, "Print"],
Cell[57729, 1840, 145, 4, 26, "Print"],
Cell[57877, 1846, 120, 3, 26, "Print"],
Cell[58000, 1851, 115, 3, 26, "Print"],
Cell[58118, 1856, 118, 3, 26, "Print"],
Cell[58239, 1861, 147, 4, 26, "Print"],
Cell[58389, 1867, 117, 3, 26, "Print"],
Cell[58509, 1872, 115, 3, 26, "Print"],
Cell[58627, 1877, 116, 3, 26, "Print"],
Cell[58746, 1882, 171, 5, 26, "Print"],
Cell[58920, 1889, 202, 6, 26, "Print"],
Cell[59125, 1897, 200, 6, 26, "Print"],
Cell[59328, 1905, 118, 3, 26, "Print"],
Cell[59449, 1910, 115, 3, 26, "Print"],
Cell[59567, 1915, 169, 5, 26, "Print"],
Cell[59739, 1922, 228, 7, 26, "Print"],
Cell[59970, 1931, 259, 8, 26, "Print"],
Cell[60232, 1941, 259, 8, 26, "Print"],
Cell[60494, 1951, 118, 3, 26, "Print"],
Cell[60615, 1956, 115, 3, 26, "Print"],
Cell[60733, 1961, 226, 7, 26, "Print"],
Cell[60962, 1970, 286, 9, 26, "Print"],
Cell[61251, 1981, 339, 11, 26, "Print"],
Cell[61593, 1994, 544, 16, 26, "Print"],
Cell[62140, 2012, 120, 3, 26, "Print"],
Cell[62263, 2017, 155, 4, 26, "Print"],
Cell[62421, 2023, 118, 3, 26, "Print"],
Cell[62542, 2028, 124, 3, 26, "Print"],
Cell[62669, 2033, 275, 8, 26, "Print"],
Cell[62947, 2043, 124, 3, 26, "Print"],
Cell[63074, 2048, 322, 10, 26, "Print"],
Cell[63399, 2060, 119, 3, 26, "Print"],
Cell[63521, 2065, 117, 3, 26, "Print"],
Cell[63641, 2070, 286, 9, 26, "Print"],
Cell[63930, 2081, 287, 9, 26, "Print"],
Cell[64220, 2092, 118, 3, 26, "Print"],
Cell[64341, 2097, 259, 8, 26, "Print"],
Cell[64603, 2107, 595, 18, 26, "Print"],
Cell[65201, 2127, 520, 17, 26, "Print"],
Cell[65724, 2146, 275, 8, 26, "Print"],
Cell[66002, 2156, 289, 9, 26, "Print"],
Cell[66294, 2167, 115, 3, 26, "Print"],
Cell[66412, 2172, 337, 10, 26, "Print"],
Cell[66752, 2184, 126, 3, 26, "Print"],
Cell[66881, 2189, 115, 3, 26, "Print"],
Cell[66999, 2194, 289, 9, 26, "Print"],
Cell[67291, 2205, 226, 7, 26, "Print"],
Cell[67520, 2214, 451, 14, 26, "Print"],
Cell[67974, 2230, 275, 8, 26, "Print"],
Cell[68252, 2240, 225, 7, 26, "Print"],
Cell[68480, 2249, 117, 3, 26, "Print"],
Cell[68600, 2254, 276, 8, 26, "Print"],
Cell[68879, 2264, 124, 3, 26, "Print"],
Cell[69006, 2269, 115, 3, 26, "Print"],
Cell[69124, 2274, 226, 7, 26, "Print"],
Cell[69353, 2283, 171, 5, 26, "Print"],
Cell[69527, 2290, 390, 12, 26, "Print"],
Cell[69920, 2304, 277, 8, 26, "Print"],
Cell[70200, 2314, 169, 5, 26, "Print"],
Cell[70372, 2321, 115, 3, 26, "Print"],
Cell[70490, 2326, 217, 6, 26, "Print"],
Cell[70710, 2334, 124, 3, 26, "Print"],
Cell[70837, 2339, 114, 3, 26, "Print"],
Cell[70954, 2344, 169, 5, 26, "Print"],
Cell[71126, 2351, 116, 3, 26, "Print"],
Cell[71245, 2356, 116, 3, 26, "Print"]
}, Open  ]],
Cell[71376, 2362, 123, 2, 81, "Output"]
}, Open  ]],
Cell[71514, 2367, 68, 2, 37, "Text"],
Cell[71585, 2371, 918, 25, 174, "Input"],
Cell[CellGroupData[{
Cell[72528, 2400, 249, 7, 47, "Input"],
Cell[CellGroupData[{
Cell[72802, 2411, 181, 2, 26, "Print"],
Cell[72986, 2415, 180, 2, 26, "Print"],
Cell[73169, 2419, 178, 2, 26, "Print"]
}, Open  ]]
}, Open  ]],
Cell[73374, 2425, 51, 0, 37, "Text"],
Cell[73428, 2427, 144, 4, 47, "Input"],
Cell[73575, 2433, 125, 4, 37, "Text"],
Cell[CellGroupData[{
Cell[73725, 2441, 125, 3, 47, "Input"],
Cell[73853, 2446, 223, 3, 48, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[74149, 2457, 53, 0, 103, "Section"],
Cell[CellGroupData[{
Cell[74227, 2461, 380, 11, 69, "Input"],
Cell[74610, 2474, 1868, 44, 90, "Output"]
}, Open  ]],
Cell[76493, 2521, 86, 2, 37, "Text"],
Cell[76582, 2525, 305, 9, 48, "Input"],
Cell[CellGroupData[{
Cell[76912, 2538, 140, 4, 47, "Input"],
Cell[CellGroupData[{
Cell[77077, 2546, 219, 4, 26, "Print"],
Cell[77299, 2552, 217, 4, 26, "Print"],
Cell[77519, 2558, 217, 4, 26, "Print"],
Cell[77739, 2564, 217, 4, 26, "Print"],
Cell[77959, 2570, 217, 4, 26, "Print"],
Cell[78179, 2576, 217, 4, 26, "Print"],
Cell[78399, 2582, 219, 4, 26, "Print"],
Cell[78621, 2588, 219, 4, 26, "Print"],
Cell[78843, 2594, 219, 4, 26, "Print"],
Cell[79065, 2600, 218, 4, 26, "Print"],
Cell[79286, 2606, 220, 4, 26, "Print"],
Cell[79509, 2612, 218, 4, 26, "Print"],
Cell[79730, 2618, 220, 4, 26, "Print"],
Cell[79953, 2624, 218, 4, 26, "Print"],
Cell[80174, 2630, 218, 4, 26, "Print"],
Cell[80395, 2636, 217, 4, 26, "Print"],
Cell[80615, 2642, 218, 4, 26, "Print"],
Cell[80836, 2648, 218, 4, 26, "Print"],
Cell[81057, 2654, 220, 4, 26, "Print"],
Cell[81280, 2660, 218, 4, 26, "Print"],
Cell[81501, 2666, 220, 4, 26, "Print"],
Cell[81724, 2672, 218, 4, 26, "Print"],
Cell[81945, 2678, 220, 4, 26, "Print"],
Cell[82168, 2684, 217, 4, 26, "Print"],
Cell[82388, 2690, 220, 4, 26, "Print"],
Cell[82611, 2696, 220, 4, 26, "Print"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[82892, 2707, 44, 0, 103, "Section"],
Cell[82939, 2709, 536, 10, 258, "Input"],
Cell[CellGroupData[{
Cell[83500, 2723, 37, 0, 75, "Subsection"],
Cell[83540, 2725, 1186, 39, 132, "Text"],
Cell[84729, 2766, 270, 7, 90, "Input"],
Cell[CellGroupData[{
Cell[85024, 2777, 35, 0, 38, "Subsubsection"],
Cell[CellGroupData[{
Cell[85084, 2781, 732, 22, 153, "Input"],
Cell[CellGroupData[{
Cell[85841, 2807, 162, 2, 26, "Print"],
Cell[86006, 2811, 162, 2, 26, "Print"],
Cell[86171, 2815, 162, 2, 26, "Print"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[86406, 2825, 36, 0, 39, "Subsection"],
Cell[86445, 2827, 242, 7, 69, "Input"],
Cell[86690, 2836, 142, 4, 37, "Text"],
Cell[86835, 2842, 439, 11, 132, "Input"]
}, Open  ]],
Cell[CellGroupData[{
Cell[87311, 2858, 31, 0, 39, "Subsection"],
Cell[87345, 2860, 3739, 95, 405, "Input"],
Cell[91087, 2957, 128, 4, 48, "Input"],
Cell[CellGroupData[{
Cell[91240, 2965, 87, 2, 48, "Input"],
Cell[91330, 2969, 181, 3, 47, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[91548, 2977, 55, 0, 38, "Subsubsection"],
Cell[91606, 2979, 1309, 33, 153, "Input"],
Cell[CellGroupData[{
Cell[92940, 3016, 201, 5, 48, "Input"],
Cell[93144, 3023, 318, 6, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[93499, 3034, 87, 2, 48, "Input"],
Cell[93589, 3038, 1116, 28, 90, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[94742, 3071, 88, 2, 48, "Input"],
Cell[94833, 3075, 193, 2, 26, "Print"]
}, Open  ]],
Cell[CellGroupData[{
Cell[95063, 3082, 202, 5, 48, "Input"],
Cell[95268, 3089, 313, 6, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[95618, 3100, 87, 2, 48, "Input"],
Cell[95708, 3104, 2119, 53, 153, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[97864, 3162, 88, 2, 48, "Input"],
Cell[CellGroupData[{
Cell[97977, 3168, 192, 2, 26, "Print"],
Cell[98172, 3172, 190, 2, 26, "Print"]
}, Open  ]]
}, Open  ]],
Cell[98389, 3178, 99, 2, 47, "Input"],
Cell[CellGroupData[{
Cell[98513, 3184, 88, 2, 48, "Input"],
Cell[98604, 3188, 190, 2, 26, "Print"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[98843, 3196, 57, 0, 38, "Subsubsection"],
Cell[98903, 3198, 862, 22, 111, "Input"],
Cell[CellGroupData[{
Cell[99790, 3224, 165, 4, 48, "Input"],
Cell[99958, 3230, 317, 6, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[100312, 3241, 87, 2, 48, "Input"],
Cell[100402, 3245, 1831, 45, 132, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[102270, 3295, 166, 4, 48, "Input"],
Cell[102439, 3301, 313, 6, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[102789, 3312, 88, 2, 48, "Input"],
Cell[CellGroupData[{
Cell[102902, 3318, 190, 2, 26, "Print"],
Cell[103095, 3322, 192, 2, 26, "Print"],
Cell[103290, 3326, 188, 2, 26, "Print"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[103527, 3334, 81, 1, 47, "Input"],
Cell[103611, 3337, 1835, 45, 132, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[105483, 3387, 88, 2, 48, "Input"],
Cell[CellGroupData[{
Cell[105596, 3393, 185, 2, 26, "Print"],
Cell[105784, 3397, 191, 2, 26, "Print"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[106024, 3405, 87, 2, 48, "Input"],
Cell[CellGroupData[{
Cell[106136, 3411, 192, 2, 26, "Print"],
Cell[106331, 3415, 196, 2, 26, "Print"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[106576, 3423, 88, 2, 48, "Input"],
Cell[106667, 3427, 623, 11, 29, "Message"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[107351, 3445, 38, 0, 39, "Subsection"],
Cell[107392, 3447, 1393, 36, 153, "Input"],
Cell[CellGroupData[{
Cell[108810, 3487, 63, 1, 48, "Input"],
Cell[108876, 3490, 251, 4, 47, "Output"]
}, Open  ]],
Cell[109142, 3497, 4684, 114, 678, "Input"],
Cell[CellGroupData[{
Cell[113851, 3615, 62, 1, 47, "Input"],
Cell[113916, 3618, 2248, 60, 132, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature JwTGn39@8825YAwb4zdpM82K *)
