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
NotebookDataLength[    107860,       3331]
NotebookOptionsPosition[    102760,       3151]
NotebookOutlinePosition[    103297,       3172]
CellTagsIndexPosition[    103254,       3169]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["\<\
Reactive Online Incremental Statistics\
\>", "Title"],

Cell["Brian Beckman", "Author"],

Cell["\<\
Improved version of 13 April 2014\
\>", "Date",
 CellChangeTimes->{{3.606356646477336*^9, 3.606356653196603*^9}, {
  3.6063878192106047`*^9, 3.606387819345187*^9}}],

Cell[BoxData[
 RowBox[{"<<", "\"\<~/Dropbox/InterfacesAndPolymorphism004.m\>\""}]], "Input"],

Cell[CellGroupData[{

Cell["State Monad", "Section"],

Cell[TextData[{
 "A value in the state monad has type ",
 Cell[BoxData[
  FormBox[
   RowBox[{"s", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"v", ",", "s"}], "}"}]}], TraditionalForm]]],
 ", that is, function from ",
 Cell[BoxData[
  FormBox[
   StyleBox["state",
    FontSlant->"Italic"], TraditionalForm]]],
 " to pair of ",
 Cell[BoxData[
  FormBox[
   StyleBox["value",
    FontSlant->"Italic"], TraditionalForm]]],
 " and ",
 Cell[BoxData[
  FormBox[
   StyleBox["state",
    FontSlant->"Italic"], TraditionalForm]]],
 "; it's a ",
 StyleBox["fs2vs", "Input"],
 ". "
}], "Text"],

Cell[TextData[{
 Cell[BoxData[
  FormBox["StateReturn", TraditionalForm]],
  FontSlant->"Italic"],
 " is of type ",
 Cell[BoxData[
  FormBox[
   RowBox[{"v", "\[Rule]", 
    RowBox[{"(", 
     RowBox[{"s", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"v", ",", "s"}], "}"}]}], ")"}]}], TraditionalForm]]],
 ", that is, it's a ",
 StyleBox["fv2fs2vs", "Input"],
 ". Call ",
 Cell[BoxData[
  FormBox["StateReturn", TraditionalForm]],
  FontSlant->"Italic"],
 " with a value ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 ", and you get a ",
 StyleBox["fs2vs", "Input"],
 ", that is, a value in the state monad. Members of the state monad are \
functions of this form: ",
 StyleBox["fv2fs2vs", "Input"],
 " because they form a monoid under composition via \"bind\"."
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "StateReturn", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"StateReturn", "[", "value_", "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"state", "\[Function]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"\"\<value\>\"", "\[Rule]", "value"}], ",", 
     RowBox[{"\"\<state\>\"", "\[Rule]", "state"}]}], "}"}]}]}]}], "Input"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "StateBind", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"StateBind", "[", 
   RowBox[{"fs2vs_", ",", "fv2fs2vs_"}], "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"state", "\[Function]", "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"vs0", "=", 
       RowBox[{"fs2vs", "[", "state", "]"}]}], "}"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"With", "[", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"v0", "=", 
          RowBox[{"\"\<value\>\"", "/.", "vs0"}]}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"s0", "=", 
          RowBox[{"\"\<state\>\"", "/.", "vs0"}]}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"fv2fs2vs", "[", "v0", "]"}], "[", "s0", "]"}]}], "]"}]}], 
    "]"}]}]}]}], "Input"],

Cell[CellGroupData[{

Cell["Unit Tests", "Subsection"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{
    RowBox[{"\"\<value\>\"", "\[Rule]", "42"}], ",", 
    RowBox[{"\"\<state\>\"", "\[Rule]", "1036"}]}], "}"}], "===", 
  "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"StateBind", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"StateReturn", "[", "42", "]"}], ",", "\[IndentingNewLine]", 
     RowBox[{"value", "\[Function]", "\[IndentingNewLine]", 
      RowBox[{"state", "\[Function]", "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"r", "=", "1"}], "}"}], ",", "\[IndentingNewLine]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"\"\<value\>\"", "\[Rule]", "value"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"\"\<state\>\"", "\[Rule]", 
            RowBox[{"state", "+", "value", "+", "r"}]}]}], "}"}]}], 
        "]"}]}]}]}], "]"}], "[", "993", "]"}]}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.6049125905708847`*^9, 3.60631124847911*^9, 
  3.606312284523643*^9, 3.606346851141121*^9, 3.606356280884562*^9, 
  3.606383353651452*^9, 3.6063843628737297`*^9, 3.606386465320485*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Statistics Without Binding", "Section"],

Cell[TextData[{
 "The pattern is to ",
 StyleBox["Fold",
  FontSlant->"Italic"],
 " a state extractor over a sequence of monadic values. This is still pull \
model, requiring a sequence, either lazy or fully realized in memory."
}], "Text"],

Cell[TextData[{
 "The ",
 StyleBox["state extractor",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " is a function of a current state, ",
 Cell[BoxData[
  FormBox["s", TraditionalForm]]],
 ", and a monadic value, ",
 Cell[BoxData[
  FormBox["m", TraditionalForm]]],
 ". Our statistics constructors, namely ",
 StyleBox["bumper",
  FontSlant->"Italic"],
 ", ",
 StyleBox["summer",
  FontSlant->"Italic"],
 ", and ",
 StyleBox["welford",
  FontSlant->"Italic"],
 ",  construct monadic values from ordinary values. Each statistics \
constructor also contains code for some accumulation task on the state \
arguments: ",
 StyleBox["bumper",
  FontSlant->"Italic"],
 "'s monadic value bumps a count; ",
 StyleBox["summer",
  FontSlant->"Italic"],
 "'s monadic value sums the values into the state; ",
 StyleBox["welford",
  FontSlant->"Italic"],
 "'s monadic value applies Welford's algorithm to the current value and \
state. "
}], "Text"],

Cell[TextData[{
 "Pairs of state and value are packaged in ",
 StyleBox["objects",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 ", that is, ",
 StyleBox["Dispatch",
  FontSlant->"Italic"],
 " lists of replacement rules for the names of the object's members, namely \
",
 StyleBox["value",
  FontSlant->"Italic"],
 " and ",
 StyleBox["state",
  FontSlant->"Italic"],
 " as strings. Thus, our state extractor is:"
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "stateExtractor", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"stateExtractor", "[", 
    RowBox[{"currentState_", ",", "monadicValueProducingAPair_"}], "]"}], ":=",
    "\[IndentingNewLine]", 
   RowBox[{"\"\<state\>\"", "/.", 
    RowBox[{"monadicValueProducingAPair", "[", "currentState", "]"}]}]}], 
  ";"}]}], "Input"],

Cell[CellGroupData[{

Cell["Running Count", "Subsection"],

Cell["\<\
Let the state of a running-count calculation be the number of items seen in a \
collection. Here's some sample data:\
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$collection", "=", 
  RowBox[{"RandomInteger", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"-", "100"}], ",", "100"}], "}"}], ",", "42"}], 
   "]"}]}]], "Input",
 CellChangeTimes->{{3.606311508814749*^9, 3.606311538737681*^9}, 
   3.6063122712741003`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"9", ",", 
   RowBox[{"-", "57"}], ",", 
   RowBox[{"-", "71"}], ",", "4", ",", "20", ",", "99", ",", "0", ",", "56", 
   ",", 
   RowBox[{"-", "95"}], ",", 
   RowBox[{"-", "28"}], ",", "88", ",", "20", ",", "25", ",", "87", ",", "51",
    ",", "75", ",", "49", ",", 
   RowBox[{"-", "60"}], ",", 
   RowBox[{"-", "16"}], ",", 
   RowBox[{"-", "50"}], ",", "87", ",", "59", ",", "53", ",", 
   RowBox[{"-", "75"}], ",", "43", ",", 
   RowBox[{"-", "87"}], ",", "16", ",", "38", ",", "51", ",", 
   RowBox[{"-", "70"}], ",", "7", ",", 
   RowBox[{"-", "19"}], ",", 
   RowBox[{"-", "40"}], ",", 
   RowBox[{"-", "15"}], ",", "83", ",", "87", ",", 
   RowBox[{"-", "66"}], ",", "94", ",", 
   RowBox[{"-", "40"}], ",", 
   RowBox[{"-", "74"}], ",", "20", ",", "40"}], "}"}]], "Output",
 CellChangeTimes->{3.6063112485434847`*^9, 3.606311540207363*^9, 
  3.6063122845735607`*^9, 3.606346851189906*^9, 3.606356281031755*^9, 
  3.60638335377304*^9, 3.6063843629242496`*^9, 3.606386465392981*^9}]
}, Open  ]],

Cell["\<\
The following keeps a running aggregate without any global, mutated variables.\
\>", "Text"],

Cell[CellGroupData[{

Cell["Bumper", "Subsubsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "bumper", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"bumper", "=", "\[IndentingNewLine]", 
   RowBox[{"value", "\[Function]", "\[IndentingNewLine]", 
    RowBox[{"state", "\[Function]", "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"\"\<value\>\"", "\[Rule]", "value"}], ",", 
       RowBox[{"\"\<state\>\"", "\[Rule]", 
        RowBox[{"state", "+", "1"}]}]}], "}"}]}]}]}], ";"}]}], "Input"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Unit Test", "Subsubsection"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Fold", "[", 
  RowBox[{"stateExtractor", ",", "0", ",", 
   RowBox[{"bumper", "/@", "$collection"}]}], "]"}]], "Input",
 CellChangeTimes->{3.606312271324081*^9}],

Cell[BoxData["42"], "Output",
 CellChangeTimes->{3.606311248645254*^9, 3.606311550190054*^9, 
  3.606312284624176*^9, 3.606346851238701*^9, 3.6063562811310463`*^9, 
  3.606383353871743*^9, 3.606384362990981*^9, 3.606386465475644*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Running Sum", "Subsection"],

Cell["The following keeps a running sum:", "Text"],

Cell[CellGroupData[{

Cell["Summer", "Subsubsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "summer", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"summer", "=", "\[IndentingNewLine]", 
   RowBox[{"value", "\[Function]", "\[IndentingNewLine]", 
    RowBox[{"state", "\[Function]", "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"\"\<value\>\"", "\[Rule]", "value"}], ",", 
       RowBox[{"\"\<state\>\"", "\[Rule]", 
        RowBox[{"state", "+", "value"}]}]}], "}"}]}]}]}], ";"}]}], "Input"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Unit Test", "Subsubsection"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Fold", "[", 
  RowBox[{"stateExtractor", ",", "0", ",", 
   RowBox[{"summer", "/@", "$collection"}]}], "]"}]], "Input",
 CellChangeTimes->{3.606312271374537*^9}],

Cell[BoxData["398"], "Output",
 CellChangeTimes->{3.606311248710157*^9, 3.606311580617134*^9, 
  3.606312284673883*^9, 3.6063468512903833`*^9, 3.606356281197496*^9, 
  3.6063833539513597`*^9, 3.606384363040213*^9, 3.606386465559848*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Welford's Sum Of Squared Residuals (SSR)\
\>", "Subsection",
 CellChangeTimes->{{3.606384167150811*^9, 3.606384168437985*^9}}],

Cell["\<\
This method avoids catastrophic cancellation and underflow when calculating \
variance and standard deviation.\
\>", "Text"],

Cell[TextData[{
 "Suppose we have the SSR of the first ",
 Cell[BoxData[
  FormBox[
   StyleBox[
    RowBox[{"n", "-", "1"}], "InlineFormula"], TraditionalForm]]],
 " data: "
}], "Text",
 CellChangeTimes->{{3.6063841891869173`*^9, 3.606384189650531*^9}}],

Cell[BoxData[
 RowBox[{
  SubscriptBox["S", 
   RowBox[{"n", "-", "1"}]], "=", 
  RowBox[{
   RowBox[{
    UnderoverscriptBox["\[Sum]", 
     RowBox[{"i", "=", "1"}], 
     RowBox[{"n", "-", "1"}]], 
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       SubscriptBox["x", "i"], "-", 
       RowBox[{
        FractionBox["1", 
         RowBox[{"n", "-", "1"}]], 
        RowBox[{
         UnderoverscriptBox["\[Sum]", 
          RowBox[{"i", "=", "1"}], 
          RowBox[{"n", "-", "1"}]], 
         SubscriptBox["x", "i"]}]}]}], ")"}], "2"]}], "=", 
   RowBox[{
    UnderoverscriptBox["\[Sum]", 
     RowBox[{"i", "=", "1"}], 
     RowBox[{"n", "-", "1"}]], 
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       SubscriptBox["x", "i"], "-", 
       OverscriptBox[
        SubscriptBox["x", 
         RowBox[{"n", "-", "1"}]], "_"]}], ")"}], 
     "2"]}]}]}]], "DisplayFormula"],

Cell[TextData[{
 "defining ",
 Cell[BoxData[
  FormBox[
   OverscriptBox[
    SubscriptBox["x", 
     RowBox[{"n", "-", "1"}]], "_"], TraditionalForm]]],
 " as the mean of the first ",
 Cell[BoxData[
  FormBox[
   RowBox[{"n", "-", "1"}], TraditionalForm]]],
 " data. We now write the same for the SSR of the first ",
 Cell[BoxData[
  FormBox[
   RowBox[{"n", Cell[""]}], TraditionalForm]]],
 "data, then solve for a recurrence."
}], "Text",
 CellChangeTimes->{{3.606384196817873*^9, 3.6063841972815104`*^9}}],

Cell[BoxData[{
 RowBox[{
  SubscriptBox["S", "n"], "=", 
  RowBox[{
   RowBox[{
    UnderoverscriptBox["\[Sum]", 
     RowBox[{"i", "=", "1"}], "n"], 
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       SubscriptBox["x", "i"], "-", 
       OverscriptBox[
        SubscriptBox["x", "n"], "_"]}], ")"}], "2"]}], "=", 
   RowBox[{
    RowBox[{
     UnderoverscriptBox["\[Sum]", 
      RowBox[{"i", "=", "1"}], 
      RowBox[{"n", "-", "1"}]], 
     SuperscriptBox[
      RowBox[{"(", 
       RowBox[{
        SubscriptBox["x", "i"], "-", 
        OverscriptBox[
         SubscriptBox["x", "n"], "_"]}], ")"}], "2"]}], "+", 
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       SubscriptBox["x", "n"], "-", 
       OverscriptBox[
        SubscriptBox["x", "n"], "_"]}], ")"}], 
     "2"]}]}]}], "\[IndentingNewLine]", 
 RowBox[{"=", 
  RowBox[{
   RowBox[{
    UnderoverscriptBox["\[Sum]", 
     RowBox[{"i", "=", "1"}], 
     RowBox[{"n", "-", "1"}]], 
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       SubscriptBox["x", "i"], "-", 
       OverscriptBox[
        SubscriptBox["x", 
         RowBox[{"n", "-", "1"}]], "_"], "+", "\[Gamma]"}], ")"}], "2"]}], 
   "+", 
   SuperscriptBox[
    RowBox[{"(", 
     RowBox[{
      SubscriptBox["x", "n"], "-", 
      OverscriptBox[
       SubscriptBox["x", "n"], "_"]}], ")"}], "2"]}]}]}], "DisplayFormula"],

Cell[TextData[{
 "defining ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Gamma]", "=", 
    RowBox[{
     OverscriptBox[
      SubscriptBox["x", "n"], "_"], "-", 
     OverscriptBox[
      SubscriptBox["x", 
       RowBox[{"n", "-", "1"}]], "_"]}]}], TraditionalForm]]],
 ", a correction term. Expanding the square reveals ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubscriptBox["S", 
     RowBox[{"n", "-", "1"}]], " ", "and", " ", "some", " ", "more", " ", 
    "correction", " ", 
    RowBox[{"terms", ":"}]}], TraditionalForm]]]
}], "Text"],

Cell[BoxData[{
 RowBox[{
  SubscriptBox["S", "n"], "=", 
  RowBox[{
   RowBox[{
    UnderoverscriptBox["\[Sum]", 
     RowBox[{"i", "=", "1"}], 
     RowBox[{"n", "-", "1"}]], 
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       SubscriptBox["x", "i"], "-", 
       OverscriptBox[
        SubscriptBox["x", 
         RowBox[{"n", "-", "1"}]], "_"]}], ")"}], "2"]}], "+", 
   RowBox[{"2", 
    RowBox[{
     UnderoverscriptBox["\[Sum]", 
      RowBox[{"i", "=", "1"}], 
      RowBox[{"n", "-", "1"}]], 
     RowBox[{
      RowBox[{"(", 
       RowBox[{
        SubscriptBox["x", "i"], "-", 
        OverscriptBox[
         SubscriptBox["x", 
          RowBox[{"n", "-", "1"}]], "_"]}], ")"}], "\[Gamma]"}]}]}], "+", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"n", "-", "1"}], ")"}], 
    SuperscriptBox["\[Gamma]", "2"]}], "+", 
   SuperscriptBox[
    RowBox[{"(", 
     RowBox[{
      SubscriptBox["x", "n"], "-", 
      OverscriptBox[
       SubscriptBox["x", "n"], "_"]}], ")"}], "2"]}]}], "\[IndentingNewLine]", 
 RowBox[{"=", 
  RowBox[{
   SubscriptBox["S", 
    RowBox[{"n", "-", "1"}]], "+", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"n", "-", "1"}], ")"}], 
    SuperscriptBox["\[Gamma]", "2"]}], "+", 
   SuperscriptBox[
    RowBox[{"(", 
     RowBox[{
      SubscriptBox["x", "n"], "-", 
      OverscriptBox[
       SubscriptBox["x", "n"], "_"]}], ")"}], "2"]}]}]}], "DisplayFormula"],

Cell["\<\
The middle term vanishes because the sum of residuals about the old mean \
vanishes. A bit of play reveals an easy-to-remember formula:\
\>", "Text"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   SubscriptBox["x", "n"], "-", 
   OverscriptBox[
    SubscriptBox["x", "n"], "_"]}], "=", 
  RowBox[{
   RowBox[{
    RowBox[{"n", 
     OverscriptBox[
      SubscriptBox["x", "n"], "_"]}], "-", 
    RowBox[{
     RowBox[{"(", 
      RowBox[{"n", "-", "1"}], ")"}], 
     OverscriptBox[
      SubscriptBox["x", 
       RowBox[{"n", "-", "1"}]], "_"]}], "-", 
    OverscriptBox[
     SubscriptBox["x", "n"], "_"]}], "=", 
   RowBox[{
    RowBox[{
     RowBox[{"(", 
      RowBox[{"n", "-", "1"}], ")"}], 
     RowBox[{"(", 
      RowBox[{
       OverscriptBox[
        SubscriptBox["x", "n"], "_"], "-", 
       OverscriptBox[
        SubscriptBox["x", 
         RowBox[{"n", "-", "1"}]], "_"]}], ")"}]}], "=", 
    RowBox[{
     RowBox[{"(", 
      RowBox[{"n", "-", "1"}], ")"}], "\[Gamma]"}]}]}]}]], "DisplayFormula"],

Cell[BoxData[{
 RowBox[{
  SubscriptBox["S", "n"], "=", 
  RowBox[{
   SubscriptBox["S", 
    RowBox[{"n", "-", "1"}]], "+", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"n", "-", "1"}], ")"}], 
    SuperscriptBox["\[Gamma]", "2"]}], "+", 
   RowBox[{
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{"n", "-", "1"}], ")"}], "2"], 
    SuperscriptBox["\[Gamma]", "2"]}]}]}], "\[IndentingNewLine]", 
 RowBox[{"=", 
  RowBox[{
   SubscriptBox["S", 
    RowBox[{"n", "-", "1"}]], "+", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{
      SuperscriptBox["n", "2"], "-", "n"}], ")"}], 
    SuperscriptBox["\[Gamma]", "2"]}]}]}], "\[IndentingNewLine]", 
 RowBox[{"=", 
  RowBox[{
   SubscriptBox["S", 
    RowBox[{"n", "-", "1"}]], "+", 
   RowBox[{"n", " ", "\[Gamma]", 
    RowBox[{"(", 
     RowBox[{"n", "-", "1"}], ")"}], 
    "\[Gamma]"}]}]}], "\[IndentingNewLine]", 
 RowBox[{"=", 
  RowBox[{
   SubscriptBox["S", 
    RowBox[{"n", "-", "1"}]], "+", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{
      SubscriptBox["x", "n"], "-", 
      OverscriptBox[
       SubscriptBox["x", "n"], "_"]}], ")"}], 
    RowBox[{"(", 
     RowBox[{
      SubscriptBox["x", "n"], "-", 
      OverscriptBox[
       SubscriptBox["x", 
        RowBox[{"n", "-", "1"}]], "_"]}], ")"}]}]}]}]}], "DisplayFormula"],

Cell["because", "Text"],

Cell[BoxData[
 RowBox[{
  RowBox[{"n", " ", "\[Gamma]"}], "=", 
  RowBox[{
   RowBox[{
    RowBox[{"n", " ", 
     OverscriptBox[
      SubscriptBox["x", "n"], "_"]}], "-", 
    RowBox[{"n", 
     OverscriptBox[
      SubscriptBox["x", 
       RowBox[{"n", "-", "1"}]], "_"]}]}], "=", 
   RowBox[{
    SubscriptBox["x", "n"], "-", 
    OverscriptBox[
     SubscriptBox["x", 
      RowBox[{"n", "-", "1"}]], "_"]}]}]}]], "DisplayFormula"],

Cell[CellGroupData[{

Cell["Naive SSR", "Subsubsection",
 CellChangeTimes->{{3.606387856134111*^9, 3.6063878580987883`*^9}}],

Cell["\<\
We shall also include the naive SSR:\
\>", "Text",
 CellChangeTimes->{{3.606387488351636*^9, 3.606387502428151*^9}}],

Cell[BoxData[
 RowBox[{
  SubscriptBox["NS", "n"], "=", 
  RowBox[{
   RowBox[{
    OverscriptBox[
     UnderscriptBox["\[Sum]", 
      RowBox[{"i", "=", "1"}]], "n"], 
    SuperscriptBox[
     SubscriptBox["x", "i"], "2"]}], "-", 
   RowBox[{"n", 
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       OverscriptBox[
        UnderscriptBox["\[Sum]", 
         RowBox[{"i", "=", "1"}]], "n"], 
       SubscriptBox["x", "i"]}], ")"}], "2"]}]}]}]], "DisplayFormula",
 CellChangeTimes->{{3.606387532914587*^9, 3.6063876083904676`*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["Welford", "Subsubsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "welford", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"welford", "=", "\[IndentingNewLine]", 
   RowBox[{"value", "\[Function]", "\[IndentingNewLine]", 
    RowBox[{"state", "\[Function]", "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"\"\<value\>\"", "\[Rule]", "value"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"\"\<state\>\"", "\[Rule]", "\[IndentingNewLine]", 
        RowBox[{"With", "[", "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"count", "=", 
             RowBox[{"1", "+", 
              RowBox[{"state", ".", "\"\<count\>\""}]}]}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"sum", "=", 
             RowBox[{"value", "+", 
              RowBox[{"state", ".", "\"\<sum\>\""}]}]}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"sum2", "=", 
             RowBox[{
              SuperscriptBox["value", "2"], "+", 
              RowBox[{"state", ".", "\"\<sum2\>\""}]}]}]}], "}"}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{"With", "[", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{
              RowBox[{"mean", "=", 
               RowBox[{"sum", "/", "count"}]}], ",", "\[IndentingNewLine]", 
              RowBox[{"oldMean", "=", 
               RowBox[{"state", ".", "\"\<mean\>\""}]}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"oldSsr", "=", 
               RowBox[{"state", ".", "\"\<ssr\>\""}]}]}], "}"}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"\"\<count\>\"", "\[Rule]", "count"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"\"\<sum\>\"", "\[Rule]", "sum"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"\"\<sum2\>\"", "\[Rule]", "sum2"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"\"\<mean\>\"", "\[Rule]", "mean"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"\"\<ssr\>\"", "\[Rule]", 
               RowBox[{
                RowBox[{
                 RowBox[{"(", 
                  RowBox[{"value", "-", "oldMean"}], ")"}], 
                 RowBox[{"(", 
                  RowBox[{"value", "-", "mean"}], ")"}]}], "+", "oldSsr"}]}], 
              ",", "\[IndentingNewLine]", 
              RowBox[{"\"\<nssr\>\"", "\[Rule]", 
               RowBox[{"sum2", "-", 
                RowBox[{"count", "*", 
                 SuperscriptBox["mean", "2"]}]}]}]}], "}"}]}], "]"}]}], 
         "]"}]}]}], "}"}]}]}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.606384277262018*^9, 3.6063842917730494`*^9}, {
  3.606387627313225*^9, 3.606387677593904*^9}, {3.606387768020073*^9, 
  3.606387788752748*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "welfordZero", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"welfordZero", "=", 
   RowBox[{"{", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"\"\<count\>\"", "\[Rule]", "0"}], ",", "\[IndentingNewLine]", 
     RowBox[{"\"\<sum\>\"", "\[Rule]", "0"}], ",", "\[IndentingNewLine]", 
     RowBox[{"\"\<sum2\>\"", "\[Rule]", "0"}], ",", "\[IndentingNewLine]", 
     RowBox[{"\"\<mean\>\"", "\[Rule]", "0"}], ",", "\[IndentingNewLine]", 
     RowBox[{"\"\<ssr\>\"", "\[Rule]", "0"}], ",", "\[IndentingNewLine]", 
     RowBox[{"\"\<nssr\>\"", "\[Rule]", "0"}]}], "}"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.606384293915917*^9, 3.6063842943051357`*^9}, {
  3.606387689021654*^9, 3.6063877000177298`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Fold", "[", 
  RowBox[{
  "stateExtractor", ",", "\[IndentingNewLine]", "welfordZero", ",", 
   "\[IndentingNewLine]", 
   RowBox[{"welford", "/@", "$collection"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.6063120342947483`*^9, 3.606312062381846*^9}, 
   3.6063122714254713`*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"\<\"count\"\>", "\[Rule]", "42"}], ",", 
   RowBox[{"\<\"sum\"\>", "\[Rule]", "398"}], ",", 
   RowBox[{"\<\"sum2\"\>", "\[Rule]", "141918"}], ",", 
   RowBox[{"\<\"mean\"\>", "\[Rule]", 
    FractionBox["199", "21"]}], ",", 
   RowBox[{"\<\"ssr\"\>", "\[Rule]", 
    FractionBox["2901076", "21"]}], ",", 
   RowBox[{"\<\"nssr\"\>", "\[Rule]", 
    FractionBox["2901076", "21"]}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.606384363107196*^9, 3.6063864656613703`*^9, 3.6063877128499117`*^9, {
   3.606387777717318*^9, 3.606387791367751*^9}, 3.606387884537012*^9}]
}, Open  ]],

Cell[TextData[{
 StyleBox["Mathematica\[CloseCurlyQuote]",
  FontSlant->"Italic"],
 "s ",
 StyleBox["Variance", "Input"],
 " computes the unbiased estimate, so should be ",
 Cell[BoxData[
  FormBox[
   RowBox[{"1", "/", 
    RowBox[{"(", 
     RowBox[{"N", "-", "1"}], ")"}]}], TraditionalForm]]],
 " times the sum of square residuals. "
}], "Text",
 CellChangeTimes->{{3.6063121579655457`*^9, 3.6063122567472277`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{
    RowBox[{"Length", "@", "$collection"}], "-", "1"}], ")"}], "*", 
  RowBox[{"Variance", "@", "$collection"}]}]], "Input",
 CellChangeTimes->{{3.606312040210367*^9, 3.606312079331744*^9}, {
  3.606312271139804*^9, 3.606312271168811*^9}, {3.606388600517372*^9, 
  3.606388604299713*^9}}],

Cell[BoxData[
 FractionBox["2901076", "21"]], "Output",
 CellChangeTimes->{{3.60631204841608*^9, 3.606312080092153*^9}, 
   3.60631228479148*^9, 3.606346851406537*^9, 3.606356281370537*^9, 
   3.60638335414013*^9, 3.606384363140814*^9, 3.606386465692031*^9, 
   3.606387887885647*^9, 3.606388604918751*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Sidebar: Combining Stats", "Subsection",
 CellChangeTimes->{{3.606312481117977*^9, 3.606312499887519*^9}}],

Cell["\<\
To combine to stats objects, sum their counts and sum their sums. To combine \
means, some obvious arithmetic is needed. Let us define some notation to \
present the arithmetic concisely. Let \
\>", "Text",
 CellChangeTimes->{{3.606312597009924*^9, 3.6063126588182507`*^9}, {
  3.606313150662985*^9, 3.606313186580411*^9}, {3.606314723030949*^9, 
  3.606314725492732*^9}}],

Cell[BoxData[
 RowBox[{"xs", "=", 
  RowBox[{
   RowBox[{"(", 
    RowBox[{
     RowBox[{
      RowBox[{
       SubscriptBox["x", "i"], "|", "i"}], "=", "1"}], ",", "2", ",", 
     "\[Ellipsis]", ",", 
     SubscriptBox["n", "x"]}], ")"}], 
   OverscriptBox["=", "def"], 
   RowBox[{"(", 
    RowBox[{
     SubscriptBox["x", "1"], ",", 
     SubscriptBox["x", "2"], ",", "\[Ellipsis]", ",", 
     SubscriptBox["x", 
      SubscriptBox["n", "x"]]}], ")"}]}]}]], "DisplayFormula",
 CellChangeTimes->{{3.606313205031556*^9, 3.606313319885929*^9}, {
  3.6063140540178127`*^9, 3.606314100172641*^9}}],

Cell[TextData[{
 "be a sequence (not a set) of data. As a side note, statistics do not depend \
on the order of the data -- any permutation of ",
 Cell[BoxData[
  FormBox["xs", TraditionalForm]]],
 " would yield the same statistics; the ordering is only for convenience of \
labeling the data points. Let"
}], "Text",
 CellChangeTimes->{{3.6063133056342373`*^9, 3.606313314058536*^9}, {
  3.606314039259735*^9, 3.6063140419400454`*^9}, {3.606314437823662*^9, 
  3.606314517160417*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   SuperscriptBox["S", 
    RowBox[{"(", "k", ")"}]], "[", "xs", "]"}], "=", 
  RowBox[{
   RowBox[{
    OverscriptBox[
     UnderscriptBox["\[Sum]", 
      RowBox[{"i", "=", "1"}]], 
     SubscriptBox["n", "x"]], 
    SuperscriptBox[
     SubscriptBox["x", "i"], "k"]}], "    ", 
   OverscriptBox["=", "def"], "    ", 
   SuperscriptBox[
    SubscriptBox["S", "x"], 
    RowBox[{"(", "k", ")"}]]}]}]], "DisplayFormula",
 CellChangeTimes->{{3.6063133001467457`*^9, 3.606313406400362*^9}, {
  3.606313498102758*^9, 3.606313501110314*^9}, {3.6063161568969193`*^9, 
  3.606316195461857*^9}}],

Cell[TextData[{
 "be the sum of the ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["k", "th"], TraditionalForm]]],
 " powers of the data. Obviously, ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     SuperscriptBox["S", 
      RowBox[{"(", "0", ")"}]], "[", "xs", "]"}], "=", 
    RowBox[{"count", "[", "xs", "]"}]}], TraditionalForm]]],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     RowBox[{
      SuperscriptBox["S", 
       RowBox[{"(", "1", ")"}]], "[", "xs", "]"}], "/", 
     RowBox[{
      SuperscriptBox["S", 
       RowBox[{"(", "0", ")"}]], "[", "xs", "]"}]}], "=", 
    RowBox[{"mean", "[", "xs", "]"}]}], TraditionalForm]]],
 ". To combine means, consider that"
}], "Text",
 CellChangeTimes->{{3.6063134173601093`*^9, 3.606313540228231*^9}, {
  3.606313805740882*^9, 3.606313832326898*^9}, {3.606314758435144*^9, 
  3.606314758923621*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   SuperscriptBox["S", 
    RowBox[{"(", "k", ")"}]], "[", "zs", "]"}], "=", 
  RowBox[{
   RowBox[{
    SuperscriptBox["S", 
     RowBox[{"(", "k", ")"}]], "[", "xs", "]"}], "+", 
   RowBox[{
    SuperscriptBox["S", 
     RowBox[{"(", "k", ")"}]], "[", "ys", "]"}]}]}]], "DisplayFormula",
 CellChangeTimes->{{3.606313859646101*^9, 3.606313924316427*^9}, {
  3.60631474179172*^9, 3.606314747625634*^9}}],

Cell["or", "Text",
 CellChangeTimes->{{3.6063162451268177`*^9, 3.60631624521144*^9}}],

Cell[BoxData[
 RowBox[{
  SuperscriptBox[
   SubscriptBox["S", "z"], 
   RowBox[{"(", "k", ")"}]], "=", 
  RowBox[{
   SuperscriptBox[
    SubscriptBox["S", "x"], 
    RowBox[{"(", "k", ")"}]], "+", 
   SuperscriptBox[
    SubscriptBox["S", "y"], 
    RowBox[{"(", "k", ")"}]]}]}]], "DisplayFormula",
 CellChangeTimes->{{3.606313859646101*^9, 3.606313924316427*^9}, {
  3.60631474179172*^9, 3.606314747625634*^9}, {3.6063162177805223`*^9, 
  3.6063162379023438`*^9}}],

Cell["when", "Text",
 CellChangeTimes->{{3.606313929795517*^9, 3.6063139380125217`*^9}}],

Cell[BoxData[
 RowBox[{"zs", "=", 
  RowBox[{"xs", "\[SquareUnion]", "ys"}]}]], "DisplayFormula",
 CellChangeTimes->{{3.606313949517466*^9, 3.6063140215049677`*^9}, 
   3.606314106314682*^9, {3.606314303704645*^9, 3.606314318900815*^9}}],

Cell["\<\
and the square-union operator produces (any permutation of) the concatenation \
of its two arguments. Then, obviously\
\>", "Text",
 CellChangeTimes->{{3.606314330457687*^9, 3.60631434019641*^9}, {
  3.6063145284808483`*^9, 3.606314581223546*^9}}],

Cell[BoxData[
 RowBox[{
  FractionBox[
   SuperscriptBox[
    SubscriptBox["S", "z"], 
    RowBox[{"(", "1", ")"}]], 
   SuperscriptBox[
    SubscriptBox["S", "z"], 
    RowBox[{"(", "0", ")"}]]], "=", 
  RowBox[{
   FractionBox[
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "x"], 
      RowBox[{"(", "1", ")"}]], "+", 
     SuperscriptBox[
      SubscriptBox["S", "y"], 
      RowBox[{"(", "1", ")"}]]}], 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "x"], 
      RowBox[{"(", "0", ")"}]], "+", 
     SuperscriptBox[
      SubscriptBox["S", "y"], 
      RowBox[{"(", "0", ")"}]]}]], "=", 
   FractionBox[
    RowBox[{
     RowBox[{
      RowBox[{"count", "[", "xs", "]"}], 
      RowBox[{"mean", "[", "xs", "]"}]}], "+", 
     RowBox[{
      RowBox[{"count", "[", "ys", "]"}], 
      RowBox[{"mean", "[", "ys", "]"}]}]}], 
    RowBox[{
     RowBox[{"count", "[", "xs", "]"}], "+", 
     RowBox[{"count", "[", "ys", "]"}]}]]}]}]], "DisplayFormula",
 CellChangeTimes->{{3.60631460622863*^9, 3.6063146545955687`*^9}, 
   3.606314771868513*^9, {3.6063148080671597`*^9, 3.606314914395389*^9}, {
   3.606316252292666*^9, 3.6063163182657413`*^9}, {3.6063235118333263`*^9, 
   3.606323518444319*^9}}],

Cell["\<\
The SSR is a bit more complex. Observe that\
\>", "Text",
 CellChangeTimes->{{3.6063149277213287`*^9, 3.60631496490105*^9}, {
  3.6063842033044558`*^9, 3.606384203728602*^9}}],

Cell[BoxData[GridBox[{
   {
    RowBox[{
     RowBox[{
      SuperscriptBox["R", "2"], "[", "xs", "]"}], "=", 
     SuperscriptBox[
      SubscriptBox["R", "x"], "2"]}], 
    OverscriptBox["=", "def"], 
    RowBox[{
     UnderoverscriptBox["\[Sum]", 
      RowBox[{"i", "=", "1"}], "n"], 
     SuperscriptBox[
      RowBox[{"(", 
       RowBox[{
        SubscriptBox["x", "i"], "-", 
        OverscriptBox[
         SubscriptBox["x", "n"], "_"]}], ")"}], "2"]}]},
   {" ", "=", 
    RowBox[{
     RowBox[{
      UnderoverscriptBox["\[Sum]", 
       RowBox[{"i", "=", "1"}], "n"], 
      SuperscriptBox[
       SubscriptBox["x", "i"], "2"]}], "-", 
     RowBox[{"2", 
      OverscriptBox[
       SubscriptBox["x", "n"], "_"], 
      RowBox[{
       UnderoverscriptBox["\[Sum]", 
        RowBox[{"i", "=", "1"}], "n"], 
       SubscriptBox["x", "i"]}]}], "+", 
     RowBox[{
      UnderoverscriptBox["\[Sum]", 
       RowBox[{"i", "=", "1"}], "n"], 
      SuperscriptBox[
       OverscriptBox[
        SubscriptBox["x", "n"], "_"], "2"]}]}]},
   {" ", "=", 
    RowBox[{
     RowBox[{
      UnderoverscriptBox["\[Sum]", 
       RowBox[{"i", "=", "1"}], "n"], 
      SuperscriptBox[
       SubscriptBox["x", "i"], "2"]}], "-", 
     RowBox[{"n", " ", 
      SuperscriptBox[
       OverscriptBox[
        SubscriptBox["x", "n"], "_"], "2"]}]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "x"], 
      RowBox[{"(", "2", ")"}]], "-", 
     RowBox[{
      SuperscriptBox[
       SubscriptBox["S", "x"], 
       RowBox[{"(", "0", ")"}]], 
      SuperscriptBox[
       RowBox[{"(", 
        FractionBox[
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "1", ")"}]], 
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "0", ")"}]]], ")"}], "2"]}]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "x"], 
      RowBox[{"(", "2", ")"}]], "-", 
     FractionBox[
      SuperscriptBox[
       RowBox[{"(", 
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "1", ")"}]], ")"}], "2"], 
      SuperscriptBox[
       SubscriptBox["S", "x"], 
       RowBox[{"(", "0", ")"}]]]}]}
  }]], "DisplayFormula",
 CellChangeTimes->{{3.60631587937693*^9, 3.606315978587636*^9}, {
  3.606316331008379*^9, 3.606316405424941*^9}, {3.6063176944945993`*^9, 
  3.60631769817673*^9}}],

Cell[BoxData[GridBox[{
   {
    SuperscriptBox[
     SubscriptBox["R", "z"], "2"], "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "z"], 
      RowBox[{"(", "2", ")"}]], "-", 
     RowBox[{
      SuperscriptBox[
       RowBox[{"(", 
        SuperscriptBox[
         SubscriptBox["S", "z"], 
         RowBox[{"(", "1", ")"}]], ")"}], "2"], "/", 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]}]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "x"], 
      RowBox[{"(", "2", ")"}]], "+", 
     SuperscriptBox[
      SubscriptBox["S", "y"], 
      RowBox[{"(", "2", ")"}]], "-", 
     RowBox[{
      SuperscriptBox[
       RowBox[{"(", 
        RowBox[{
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "1", ")"}]], "+", 
         SuperscriptBox[
          SubscriptBox["S", "y"], 
          RowBox[{"(", "1", ")"}]]}], ")"}], "2"], "/", 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]}]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "x"], 
      RowBox[{"(", "2", ")"}]], "+", 
     SuperscriptBox[
      SubscriptBox["S", "y"], 
      RowBox[{"(", "2", ")"}]], "-", 
     RowBox[{
      RowBox[{"[", 
       RowBox[{
        SuperscriptBox[
         RowBox[{"(", 
          SuperscriptBox[
           SubscriptBox["S", "x"], 
           RowBox[{"(", "1", ")"}]], ")"}], "2"], "+", 
        RowBox[{"2", 
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "1", ")"}]], 
         SuperscriptBox[
          SubscriptBox["S", "y"], 
          RowBox[{"(", "1", ")"}]]}], "+", 
        SuperscriptBox[
         RowBox[{"(", 
          SuperscriptBox[
           SubscriptBox["S", "y"], 
           RowBox[{"(", "1", ")"}]], ")"}], "2"]}], "]"}], "/", 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]}]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "x"], 
      RowBox[{"(", "2", ")"}]], "+", 
     SuperscriptBox[
      SubscriptBox["S", "y"], 
      RowBox[{"(", "2", ")"}]], "-", 
     FractionBox[
      SuperscriptBox[
       RowBox[{"(", 
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "1", ")"}]], ")"}], "2"], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]], "-", 
     FractionBox[
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]], "-", 
     FractionBox[
      SuperscriptBox[
       RowBox[{"(", 
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "1", ")"}]], ")"}], "2"], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "x"], 
      RowBox[{"(", "2", ")"}]], "-", 
     FractionBox[
      SuperscriptBox[
       RowBox[{"(", 
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "1", ")"}]], ")"}], "2"], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]], "+", 
     SuperscriptBox[
      SubscriptBox["S", "y"], 
      RowBox[{"(", "2", ")"}]], "-", 
     FractionBox[
      SuperscriptBox[
       RowBox[{"(", 
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "1", ")"}]], ")"}], "2"], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]], "-", 
     FractionBox[
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["S", "x"], 
      RowBox[{"(", "2", ")"}]], "-", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      FractionBox[
       SuperscriptBox[
        RowBox[{"(", 
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "1", ")"}]], ")"}], "2"], 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]]]}], "+", 
     SuperscriptBox[
      SubscriptBox["S", "y"], 
      RowBox[{"(", "2", ")"}]], "-", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      FractionBox[
       SuperscriptBox[
        RowBox[{"(", 
         SuperscriptBox[
          SubscriptBox["S", "y"], 
          RowBox[{"(", "1", ")"}]], ")"}], "2"], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]]]}], "-", 
     FractionBox[
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]]}]},
   {" ", "=", 
    RowBox[{
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["S", "x"], 
       RowBox[{"(", "2", ")"}]]}], "+", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["S", "x"], "2"]}], "-", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      FractionBox[
       SuperscriptBox[
        RowBox[{"(", 
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "1", ")"}]], ")"}], "2"], 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]]]}], "+", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["S", "y"], 
       RowBox[{"(", "2", ")"}]]}], "+", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["S", "y"], "2"]}], "-", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      FractionBox[
       SuperscriptBox[
        RowBox[{"(", 
         SuperscriptBox[
          SubscriptBox["S", "y"], 
          RowBox[{"(", "1", ")"}]], ")"}], "2"], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]]]}], "-", 
     FractionBox[
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]]}]},
   {" ", "=", 
    RowBox[{
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      RowBox[{"(", 
       RowBox[{
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "2", ")"}]], "-", 
        FractionBox[
         SuperscriptBox[
          RowBox[{"(", 
           SuperscriptBox[
            SubscriptBox["S", "x"], 
            RowBox[{"(", "1", ")"}]], ")"}], "2"], 
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "0", ")"}]]]}], ")"}]}], "+", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["S", "x"], "2"]}], "+", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["S", "y"], 
       RowBox[{"(", "2", ")"}]]}], "+", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      RowBox[{"(", 
       RowBox[{
        SuperscriptBox[
         SubscriptBox["S", "y"], "2"], "-", 
        FractionBox[
         SuperscriptBox[
          RowBox[{"(", 
           SuperscriptBox[
            SubscriptBox["S", "y"], 
            RowBox[{"(", "1", ")"}]], ")"}], "2"], 
         SuperscriptBox[
          SubscriptBox["S", "y"], 
          RowBox[{"(", "0", ")"}]]]}], ")"}]}], "-", 
     FractionBox[
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]]}]},
   {" ", "=", 
    RowBox[{
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["R", "x"], "2"]}], "+", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["S", "x"], "2"]}], "+", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["S", "y"], 
       RowBox[{"(", "2", ")"}]]}], "+", 
     RowBox[{
      FractionBox[
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], 
      SuperscriptBox[
       SubscriptBox["R", "y"], "2"]}], "-", 
     FractionBox[
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}], 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]]}]},
   {" ", "=", 
    RowBox[{
     FractionBox["1", 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]], "[", 
     RowBox[{
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       RowBox[{"(", 
        RowBox[{
         SuperscriptBox[
          SubscriptBox["R", "x"], "2"], "+", 
         SuperscriptBox[
          SubscriptBox["S", "y"], 
          RowBox[{"(", "2", ")"}]]}], ")"}]}], "+", 
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       RowBox[{"(", 
        RowBox[{
         SuperscriptBox[
          SubscriptBox["R", "y"], "2"], "+", 
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "2", ")"}]]}], ")"}]}], "-", 
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}]}], "]"}]},
   {" ", "=", 
    RowBox[{
     FractionBox["1", 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]], "[", 
     RowBox[{
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       RowBox[{"(", 
        RowBox[{
         SuperscriptBox[
          SubscriptBox["R", "x"], "2"], "+", 
         SuperscriptBox[
          SubscriptBox["R", "y"], "2"], "+", 
         RowBox[{"(", 
          FractionBox[
           SuperscriptBox[
            RowBox[{"(", 
             SuperscriptBox[
              SubscriptBox["S", "y"], 
              RowBox[{"(", "1", ")"}]], ")"}], "2"], 
           SuperscriptBox[
            SubscriptBox["S", "y"], 
            RowBox[{"(", "0", ")"}]]], ")"}]}], ")"}]}], "+", 
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       RowBox[{"(", 
        RowBox[{
         SuperscriptBox[
          SubscriptBox["R", "y"], "2"], "+", 
         SuperscriptBox[
          SubscriptBox["R", "x"], "2"], "+", 
         RowBox[{"(", 
          FractionBox[
           SuperscriptBox[
            RowBox[{"(", 
             SuperscriptBox[
              SubscriptBox["S", "x"], 
              RowBox[{"(", "1", ")"}]], ")"}], "2"], 
           SuperscriptBox[
            SubscriptBox["S", "x"], 
            RowBox[{"(", "0", ")"}]]], ")"}]}], ")"}]}], "-", 
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}]}], "]"}]},
   {" ", "=", 
    RowBox[{
     FractionBox["1", 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]], "[", 
     RowBox[{
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["R", "x"], "2"]}], "+", 
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["R", "y"], "2"]}], "+", 
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       FractionBox[
        SuperscriptBox[
         RowBox[{"(", 
          SuperscriptBox[
           SubscriptBox["S", "y"], 
           RowBox[{"(", "1", ")"}]], ")"}], "2"], 
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "0", ")"}]]]}], "+", 
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["R", "y"], "2"]}], "+", 
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       SuperscriptBox[
        SubscriptBox["R", "x"], "2"]}], "+", 
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       FractionBox[
        SuperscriptBox[
         RowBox[{"(", 
          SuperscriptBox[
           SubscriptBox["S", "x"], 
           RowBox[{"(", "1", ")"}]], ")"}], "2"], 
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "0", ")"}]]]}], "-", 
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}]}], "]"}]},
   {" ", "=", 
    RowBox[{
     FractionBox["1", 
      SuperscriptBox[
       SubscriptBox["S", "z"], 
       RowBox[{"(", "0", ")"}]]], "[", 
     RowBox[{
      RowBox[{
       RowBox[{"(", 
        RowBox[{
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "0", ")"}]], "+", 
         SuperscriptBox[
          SubscriptBox["S", "y"], 
          RowBox[{"(", "0", ")"}]]}], ")"}], 
       SuperscriptBox[
        SubscriptBox["R", "x"], "2"]}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "0", ")"}]], "+", 
         SuperscriptBox[
          SubscriptBox["S", "y"], 
          RowBox[{"(", "0", ")"}]]}], ")"}], 
       SuperscriptBox[
        SubscriptBox["R", "y"], "2"]}], "+", 
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "0", ")"}]], 
       FractionBox[
        SuperscriptBox[
         RowBox[{"(", 
          SuperscriptBox[
           SubscriptBox["S", "y"], 
           RowBox[{"(", "1", ")"}]], ")"}], "2"], 
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "0", ")"}]]]}], "+", 
      RowBox[{
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "0", ")"}]], 
       FractionBox[
        SuperscriptBox[
         RowBox[{"(", 
          SuperscriptBox[
           SubscriptBox["S", "x"], 
           RowBox[{"(", "1", ")"}]], ")"}], "2"], 
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "0", ")"}]]]}], "-", 
      RowBox[{"2", 
       SuperscriptBox[
        SubscriptBox["S", "x"], 
        RowBox[{"(", "1", ")"}]], 
       SuperscriptBox[
        SubscriptBox["S", "y"], 
        RowBox[{"(", "1", ")"}]]}]}], "]"}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["R", "x"], "2"], "+", 
     SuperscriptBox[
      SubscriptBox["R", "y"], "2"], "+", 
     RowBox[{
      FractionBox["1", 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], "[", 
      RowBox[{
       RowBox[{
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "0", ")"}]], 
        FractionBox[
         SuperscriptBox[
          RowBox[{"(", 
           SuperscriptBox[
            SubscriptBox["S", "y"], 
            RowBox[{"(", "1", ")"}]], ")"}], "2"], 
         SuperscriptBox[
          SubscriptBox["S", "y"], 
          RowBox[{"(", "0", ")"}]]]}], "+", 
       RowBox[{
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "0", ")"}]], 
        FractionBox[
         SuperscriptBox[
          RowBox[{"(", 
           SuperscriptBox[
            SubscriptBox["S", "x"], 
            RowBox[{"(", "1", ")"}]], ")"}], "2"], 
         SuperscriptBox[
          SubscriptBox["S", "x"], 
          RowBox[{"(", "0", ")"}]]]}], "-", 
       RowBox[{"2", 
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "1", ")"}]], 
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "1", ")"}]]}]}], "]"}]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["R", "x"], "2"], "+", 
     SuperscriptBox[
      SubscriptBox["R", "y"], "2"], "+", 
     RowBox[{
      FractionBox["1", 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], "[", 
      RowBox[{
       RowBox[{
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "0", ")"}]], 
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "0", ")"}]], 
        SuperscriptBox[
         RowBox[{"(", 
          FractionBox[
           SuperscriptBox[
            SubscriptBox["S", "y"], 
            RowBox[{"(", "1", ")"}]], 
           SuperscriptBox[
            SubscriptBox["S", "y"], 
            RowBox[{"(", "0", ")"}]]], ")"}], "2"]}], "+", 
       RowBox[{
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "0", ")"}]], 
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "0", ")"}]], 
        SuperscriptBox[
         RowBox[{"(", 
          FractionBox[
           SuperscriptBox[
            SubscriptBox["S", "x"], 
            RowBox[{"(", "1", ")"}]], 
           SuperscriptBox[
            SubscriptBox["S", "x"], 
            RowBox[{"(", "0", ")"}]]], ")"}], "2"]}], "-", 
       RowBox[{"2", 
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "0", ")"}]], 
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "0", ")"}]], 
        FractionBox[
         RowBox[{
          SuperscriptBox[
           SubscriptBox["S", "x"], 
           RowBox[{"(", "1", ")"}]], 
          SuperscriptBox[
           SubscriptBox["S", "y"], 
           RowBox[{"(", "1", ")"}]]}], 
         RowBox[{
          SuperscriptBox[
           SubscriptBox["S", "y"], 
           RowBox[{"(", "0", ")"}]], 
          SuperscriptBox[
           SubscriptBox["S", "x"], 
           RowBox[{"(", "0", ")"}]]}]]}]}], "]"}]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["R", "x"], "2"], "+", 
     SuperscriptBox[
      SubscriptBox["R", "y"], "2"], "+", 
     RowBox[{
      FractionBox[
       RowBox[{
        SuperscriptBox[
         SubscriptBox["S", "x"], 
         RowBox[{"(", "0", ")"}]], 
        SuperscriptBox[
         SubscriptBox["S", "y"], 
         RowBox[{"(", "0", ")"}]]}], 
       SuperscriptBox[
        SubscriptBox["S", "z"], 
        RowBox[{"(", "0", ")"}]]], "[", 
      RowBox[{
       SuperscriptBox[
        RowBox[{"(", 
         FractionBox[
          SuperscriptBox[
           SubscriptBox["S", "y"], 
           RowBox[{"(", "1", ")"}]], 
          SuperscriptBox[
           SubscriptBox["S", "y"], 
           RowBox[{"(", "0", ")"}]]], ")"}], "2"], "+", 
       SuperscriptBox[
        RowBox[{"(", 
         FractionBox[
          SuperscriptBox[
           SubscriptBox["S", "x"], 
           RowBox[{"(", "1", ")"}]], 
          SuperscriptBox[
           SubscriptBox["S", "x"], 
           RowBox[{"(", "0", ")"}]]], ")"}], "2"], "-", 
       RowBox[{"2", 
        FractionBox[
         RowBox[{
          SuperscriptBox[
           SubscriptBox["S", "x"], 
           RowBox[{"(", "1", ")"}]], 
          SuperscriptBox[
           SubscriptBox["S", "y"], 
           RowBox[{"(", "1", ")"}]]}], 
         RowBox[{
          SuperscriptBox[
           SubscriptBox["S", "y"], 
           RowBox[{"(", "0", ")"}]], 
          SuperscriptBox[
           SubscriptBox["S", "x"], 
           RowBox[{"(", "0", ")"}]]}]]}]}], "]"}]}]},
   {" ", "=", 
    RowBox[{
     SuperscriptBox[
      SubscriptBox["R", "x"], "2"], "+", 
     SuperscriptBox[
      SubscriptBox["R", "y"], "2"], "+", 
     RowBox[{
      FractionBox[
       RowBox[{
        RowBox[{"count", "[", "xs", "]"}], 
        RowBox[{"count", "[", "ys", "]"}]}], 
       RowBox[{"count", "[", "zs", "]"}]], 
      SuperscriptBox[
       RowBox[{"(", 
        RowBox[{
         RowBox[{"mean", "[", "xs", "]"}], "-", 
         RowBox[{"mean", "[", "ys", "]"}]}], ")"}], "2"]}]}]}
  }]], "DisplayFormula",
 CellChangeTimes->{{3.606315999028516*^9, 3.606316137987031*^9}, {
  3.606316414261796*^9, 3.606316491063691*^9}, {3.606316546647389*^9, 
  3.606316601644534*^9}, {3.606317371904087*^9, 3.606317446836132*^9}, {
  3.606317917913069*^9, 3.606317992304668*^9}, {3.606318030759885*^9, 
  3.606318348362549*^9}, {3.6063224372448387`*^9, 3.606322615713242*^9}, {
  3.606322651861421*^9, 3.6063226735242558`*^9}, {3.606322759805213*^9, 
  3.606323119873806*^9}, {3.6063231734707747`*^9, 3.6063232693899612`*^9}, {
  3.606323309221568*^9, 3.606323435423595*^9}, {3.6063437001071777`*^9, 
  3.60634372041045*^9}, {3.606343865787335*^9, 3.6063440815514717`*^9}, {
  3.6063442809832067`*^9, 3.6063442900933104`*^9}, {3.6063443237674217`*^9, 
  3.606344336597886*^9}, {3.6063443737799797`*^9, 3.606344525988353*^9}, {
  3.606344565771495*^9, 3.606344706068886*^9}, {3.606344737841035*^9, 
  3.606344769224822*^9}}],

Cell[TextData[{
 "Check special case where ",
 Cell[BoxData[
  FormBox["ys", TraditionalForm]]],
 " is singleton; should degenerate to the original Welford\[CloseCurlyQuote]s \
formula."
}], "Text",
 CellChangeTimes->{{3.606344981925789*^9, 3.606345038426996*^9}}],

Cell[BoxData[{
 RowBox[{
  SuperscriptBox[
   SubscriptBox["R", "x"], "2"], "+", 
  RowBox[{
   FractionBox[
    RowBox[{"count", "[", "xs", "]"}], 
    RowBox[{
     RowBox[{"count", "[", "xs", "]"}], "+", "1"}]], 
   RowBox[{"(", 
    RowBox[{"y", "-", 
     RowBox[{"mean", "[", "xs", "]"}]}], ")"}], 
   RowBox[{"(", 
    RowBox[{"y", "-", 
     RowBox[{"mean", "[", "xs", "]"}]}], ")"}]}]}], "\[IndentingNewLine]", 
 RowBox[{"=", 
  RowBox[{
   SuperscriptBox[
    SubscriptBox["R", "x"], "2"], "+", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{
      RowBox[{
       FractionBox[
        RowBox[{"count", "[", "xs", "]"}], 
        RowBox[{
         RowBox[{"count", "[", "xs", "]"}], "+", "1"}]], "y"}], "-", 
      RowBox[{
       FractionBox[
        RowBox[{"count", "[", "xs", "]"}], 
        RowBox[{
         RowBox[{"count", "[", "xs", "]"}], "+", "1"}]], 
       RowBox[{"mean", "[", "xs", "]"}]}]}], ")"}], 
    RowBox[{"(", 
     RowBox[{"y", "-", 
      RowBox[{"mean", "[", "xs", "]"}]}], 
     ")"}]}]}]}], "\[IndentingNewLine]", 
 RowBox[{"=", 
  RowBox[{
   SuperscriptBox[
    SubscriptBox["R", "x"], "2"], "+", 
   RowBox[{
    RowBox[{"(", 
     FractionBox[
      RowBox[{
       RowBox[{"y", " ", 
        RowBox[{"(", 
         RowBox[{
          RowBox[{"count", "[", "xs", "]"}], "+", "1"}], ")"}]}], "-", 
       RowBox[{"sum", "[", "xs", "]"}], "-", "y"}], 
      RowBox[{
       RowBox[{"count", "[", "xs", "]"}], "+", "1"}]], ")"}], 
    RowBox[{"(", 
     RowBox[{"y", "-", 
      RowBox[{"mean", "[", "xs", "]"}]}], 
     ")"}]}]}]}], "\[IndentingNewLine]", 
 RowBox[{"=", 
  RowBox[{
   SuperscriptBox[
    SubscriptBox["R", "x"], "2"], "+", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"y", "-", 
      FractionBox[
       RowBox[{"sum", "[", 
        RowBox[{"xs", "\[SquareUnion]", 
         RowBox[{"(", "y", ")"}]}], "]"}], 
       RowBox[{
        RowBox[{"count", "[", "xs", "]"}], "+", "1"}]]}], ")"}], 
    RowBox[{"(", 
     RowBox[{"y", "-", 
      RowBox[{"mean", "[", "xs", "]"}]}], ")"}]}]}]}]}], "DisplayFormula",
 CellChangeTimes->{{3.606345395812305*^9, 3.606345485473586*^9}, {
  3.606345578782301*^9, 3.6063456306853743`*^9}, {3.606345668002817*^9, 
  3.6063456884079113`*^9}, {3.60634575762181*^9, 3.606345861594802*^9}, {
  3.606346620075479*^9, 3.606346623017585*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"addStats", "[", 
    RowBox[{"stats1_", ",", "stats2_"}], "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{"With", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"count3", "=", 
        RowBox[{
         RowBox[{"stats1", ".", "\"\<count\>\""}], "+", 
         RowBox[{"stats2", ".", "\"\<count\>\""}]}]}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"sum3", "=", 
        RowBox[{
         RowBox[{"stats1", ".", "\"\<sum\>\""}], "+", 
         RowBox[{"stats2", ".", "\"\<sum\>\""}]}]}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"sum23", "=", 
        RowBox[{
         RowBox[{"stats1", ".", "\"\<sum2\>\""}], "+", 
         RowBox[{"stats2", ".", "\"\<sum2\>\""}]}]}]}], "}"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"mean3", "=", 
         RowBox[{"sum3", "/", "count3"}]}], "}"}], ",", "\[IndentingNewLine]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"\"\<count\>\"", "\[Rule]", "count3"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"\"\<sum\>\"", "\[Rule]", "sum3"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"\"\<sum2\>\"", "\[Rule]", "sum23"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"\"\<mean\>\"", "\[Rule]", "mean3"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"\"\<ssr\>\"", "\[Rule]", 
          RowBox[{
           RowBox[{"stats1", ".", "\"\<ssr\>\""}], "+", 
           RowBox[{"stats2", ".", "\"\<ssr\>\""}], "+", 
           RowBox[{
            FractionBox[
             RowBox[{
              RowBox[{"stats1", ".", "\"\<count\>\""}], "*", 
              RowBox[{"stats2", ".", "\"\<count\>\""}]}], "count3"], 
            SuperscriptBox[
             RowBox[{"(", 
              RowBox[{
               RowBox[{"stats1", ".", "\"\<mean\>\""}], "-", 
               RowBox[{"stats2", ".", "\"\<mean\>\""}]}], ")"}], "2"]}]}]}], 
         ",", "\[IndentingNewLine]", 
         RowBox[{"\"\<nssr\>\"", "\[Rule]", 
          RowBox[{"sum23", "-", 
           RowBox[{"count3", "*", 
            SuperscriptBox["mean3", "2"]}]}]}]}], "\[IndentingNewLine]", 
        "}"}]}], "]"}]}], "]"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.606312565666243*^9, 3.6063125843931103`*^9}, {
  3.6063450508668747`*^9, 3.606345342798588*^9}, {3.6063843033718157`*^9, 
  3.6063843073847923`*^9}, {3.6063879412189302`*^9, 3.606388137216008*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"$collection2", "=", 
  RowBox[{"RandomInteger", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"-", "100"}], ",", "100"}], "}"}], ",", "27"}], 
   "]"}]}]], "Input",
 CellChangeTimes->{{3.606346738202129*^9, 3.6063467679512043`*^9}}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"58", ",", 
   RowBox[{"-", "87"}], ",", "35", ",", "94", ",", 
   RowBox[{"-", "90"}], ",", 
   RowBox[{"-", "4"}], ",", "70", ",", "88", ",", "76", ",", 
   RowBox[{"-", "87"}], ",", 
   RowBox[{"-", "16"}], ",", 
   RowBox[{"-", "71"}], ",", "59", ",", 
   RowBox[{"-", "69"}], ",", 
   RowBox[{"-", "23"}], ",", 
   RowBox[{"-", "16"}], ",", "13", ",", "17", ",", 
   RowBox[{"-", "76"}], ",", "60", ",", 
   RowBox[{"-", "83"}], ",", 
   RowBox[{"-", "50"}], ",", "26", ",", "69", ",", "51", ",", "63", ",", 
   "95"}], "}"}]], "Output",
 CellChangeTimes->{3.606346770288169*^9, 3.606346851474835*^9, 
  3.606356281533476*^9, 3.606383354307623*^9, 3.6063843631896667`*^9, 
  3.6063864657589293`*^9, 3.6063881389596453`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"addStats", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"Fold", "[", 
    RowBox[{
    "stateExtractor", ",", "\[IndentingNewLine]", "welfordZero", ",", 
     "\[IndentingNewLine]", 
     RowBox[{"welford", "/@", "$collection"}]}], "]"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"Fold", "[", 
    RowBox[{
    "stateExtractor", ",", "\[IndentingNewLine]", "welfordZero", ",", 
     "\[IndentingNewLine]", 
     RowBox[{"welford", "/@", "$collection2"}]}], "]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.606346792220725*^9, 3.60634684361101*^9}}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"\<\"count\"\>", "\[Rule]", "69"}], ",", 
   RowBox[{"\<\"sum\"\>", "\[Rule]", "600"}], ",", 
   RowBox[{"\<\"sum2\"\>", "\[Rule]", "251596"}], ",", 
   RowBox[{"\<\"mean\"\>", "\[Rule]", 
    FractionBox["200", "23"]}], ",", 
   RowBox[{"\<\"ssr\"\>", "\[Rule]", 
    FractionBox["5666708", "23"]}], ",", 
   RowBox[{"\<\"nssr\"\>", "\[Rule]", 
    FractionBox["5666708", "23"]}]}], "}"}]], "Output",
 CellChangeTimes->{3.60634685150808*^9, 3.6063562815716267`*^9, 
  3.606383354340073*^9, 3.606384363207637*^9, 3.60638646579309*^9, 
  3.6063881436273127`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Fold", "[", 
  RowBox[{
  "stateExtractor", ",", "\[IndentingNewLine]", "welfordZero", ",", 
   "\[IndentingNewLine]", 
   RowBox[{"welford", "/@", 
    RowBox[{"Join", "[", 
     RowBox[{"$collection", ",", "$collection2"}], "]"}]}]}], "]"}]], "Input",\

 CellChangeTimes->{{3.606346822238667*^9, 3.6063468762501583`*^9}}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"\<\"count\"\>", "\[Rule]", "69"}], ",", 
   RowBox[{"\<\"sum\"\>", "\[Rule]", "600"}], ",", 
   RowBox[{"\<\"sum2\"\>", "\[Rule]", "251596"}], ",", 
   RowBox[{"\<\"mean\"\>", "\[Rule]", 
    FractionBox["200", "23"]}], ",", 
   RowBox[{"\<\"ssr\"\>", "\[Rule]", 
    FractionBox["5666708", "23"]}], ",", 
   RowBox[{"\<\"nssr\"\>", "\[Rule]", 
    FractionBox["5666708", "23"]}]}], "}"}]], "Output",
 CellChangeTimes->{{3.6063468585604753`*^9, 3.606346877224379*^9}, 
   3.6063562816221733`*^9, 3.606383354372644*^9, 3.606384363240797*^9, 
   3.606386465842877*^9, 3.606388147991706*^9}]
}, Open  ]]
}, Closed]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Iterating Instead of Folding", "Section"],

Cell[CellGroupData[{

Cell["Fearing Not the Mutable", "Subsection"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Module", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"count", "=", "0"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"v", "\[Function]", 
      RowBox[{"count", "++"}]}], ")"}], "/@", "$collection"}]}], 
  "]"}]], "Input",
 CellChangeTimes->{3.606312271204584*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
  "0", ",", "1", ",", "2", ",", "3", ",", "4", ",", "5", ",", "6", ",", "7", 
   ",", "8", ",", "9", ",", "10", ",", "11", ",", "12", ",", "13", ",", "14", 
   ",", "15", ",", "16", ",", "17", ",", "18", ",", "19", ",", "20", ",", 
   "21", ",", "22", ",", "23", ",", "24", ",", "25", ",", "26", ",", "27", 
   ",", "28", ",", "29", ",", "30", ",", "31", ",", "32", ",", "33", ",", 
   "34", ",", "35", ",", "36", ",", "37", ",", "38", ",", "39", ",", "40", 
   ",", "41"}], "}"}]], "Output",
 CellChangeTimes->{3.606311248844324*^9, 3.606312284824367*^9, 
  3.606346851623784*^9, 3.606356281672475*^9, 3.606383354406088*^9, 
  3.6063843632579947`*^9, 3.606386465893997*^9, 3.606388166359612*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Module", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"sum", "=", "0"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"v", "\[Function]", 
      RowBox[{"sum", "+=", "v"}]}], ")"}], "/@", "$collection"}]}], 
  "]"}]], "Input",
 CellChangeTimes->{3.606312271220915*^9}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"9", ",", 
   RowBox[{"-", "48"}], ",", 
   RowBox[{"-", "119"}], ",", 
   RowBox[{"-", "115"}], ",", 
   RowBox[{"-", "95"}], ",", "4", ",", "4", ",", "60", ",", 
   RowBox[{"-", "35"}], ",", 
   RowBox[{"-", "63"}], ",", "25", ",", "45", ",", "70", ",", "157", ",", 
   "208", ",", "283", ",", "332", ",", "272", ",", "256", ",", "206", ",", 
   "293", ",", "352", ",", "405", ",", "330", ",", "373", ",", "286", ",", 
   "302", ",", "340", ",", "391", ",", "321", ",", "328", ",", "309", ",", 
   "269", ",", "254", ",", "337", ",", "424", ",", "358", ",", "452", ",", 
   "412", ",", "338", ",", "358", ",", "398"}], "}"}]], "Output",
 CellChangeTimes->{3.606311248877245*^9, 3.606312284857252*^9, 
  3.6063468516759663`*^9, 3.606356281785406*^9, 3.606383354442007*^9, 
  3.60638436329046*^9, 3.606386465942371*^9, 3.606388167692848*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"welfordState", "=", "welfordZero"}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"(", 
      RowBox[{"v", "\[Function]", "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"o", "=", "welfordState"}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"With", "[", 
          RowBox[{
           RowBox[{"{", "\[IndentingNewLine]", 
            RowBox[{
             RowBox[{"count", "=", 
              RowBox[{"1", "+", 
               RowBox[{"o", ".", "\"\<count\>\""}]}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"sum", "=", 
              RowBox[{"v", "+", 
               RowBox[{"o", ".", "\"\<sum\>\""}]}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"sum2", "=", 
              RowBox[{
               SuperscriptBox["v", "2"], "+", 
               RowBox[{"o", ".", "\"\<sum2\>\""}]}]}]}], "}"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"With", "[", 
            RowBox[{
             RowBox[{"{", "\[IndentingNewLine]", 
              RowBox[{
               RowBox[{"mean", "=", 
                RowBox[{"sum", "/", "count"}]}], ",", "\[IndentingNewLine]", 
               RowBox[{"oldMean", "=", 
                RowBox[{"o", ".", "\"\<mean\>\""}]}], ",", 
               "\[IndentingNewLine]", 
               RowBox[{"oldSsr", "=", 
                RowBox[{"o", ".", "\"\<ssr\>\""}]}]}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"welfordState", "=", 
              RowBox[{"{", "\[IndentingNewLine]", 
               RowBox[{
                RowBox[{"\"\<count\>\"", "\[Rule]", "count"}], ",", 
                "\[IndentingNewLine]", 
                RowBox[{"\"\<sum\>\"", "\[Rule]", "sum"}], ",", 
                "\[IndentingNewLine]", 
                RowBox[{"\"\<sum2\>\"", "\[Rule]", "sum2"}], ",", 
                "\[IndentingNewLine]", 
                RowBox[{"\"\<mean\>\"", "\[Rule]", "mean"}], ",", 
                "\[IndentingNewLine]", 
                RowBox[{"\"\<ssr\>\"", "\[Rule]", 
                 RowBox[{
                  RowBox[{
                   RowBox[{"(", 
                    RowBox[{"v", "-", "oldMean"}], ")"}], 
                   RowBox[{"(", 
                    RowBox[{"v", "-", "mean"}], ")"}]}], "+", "oldSsr"}]}], 
                ",", "\[IndentingNewLine]", 
                RowBox[{"\"\<nssr\>\"", "\[Rule]", 
                 RowBox[{"sum2", "-", 
                  RowBox[{"count", "*", 
                   SuperscriptBox["mean", "2"]}]}]}]}], "}"}]}]}], "]"}]}], 
          "]"}]}], "]"}]}], ")"}], "/@", "\[IndentingNewLine]", 
     "$collection"}]}], "]"}], "//", "TableForm"}]], "Input",
 CellChangeTimes->{
  3.606312271239231*^9, {3.6063125329376163`*^9, 3.606312536187418*^9}, {
   3.6063843147755537`*^9, 3.606384321441012*^9}, {3.6063881969432297`*^9, 
   3.606388274909554*^9}}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "1"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "9"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "81"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", "9"}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", "0"}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", "0"}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "2"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", 
      RowBox[{"-", "48"}]}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "3330"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      RowBox[{"-", "24"}]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", "2178"}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", "2178"}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "3"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", 
      RowBox[{"-", "119"}]}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "8371"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      RowBox[{"-", 
       FractionBox["119", "3"]}]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["10952", "3"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["10952", "3"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "4"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", 
      RowBox[{"-", "115"}]}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "8387"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      RowBox[{"-", 
       FractionBox["115", "4"]}]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["20323", "4"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["20323", "4"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "5"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", 
      RowBox[{"-", "95"}]}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "8787"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      RowBox[{"-", "19"}]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", "6982"}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", "6982"}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "6"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "4"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "18588"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["2", "3"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["55756", "3"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["55756", "3"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "7"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "4"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "18588"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["4", "7"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["130100", "7"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["130100", "7"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "8"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "60"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "21724"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["15", "2"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", "21274"}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", "21274"}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "9"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", 
      RowBox[{"-", "35"}]}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "30749"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      RowBox[{"-", 
       FractionBox["35", "9"]}]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["275516", "9"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["275516", "9"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "10"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", 
      RowBox[{"-", "63"}]}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "31533"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      RowBox[{"-", 
       FractionBox["63", "10"]}]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["311361", "10"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["311361", "10"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "11"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "25"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "39277"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["25", "11"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["431422", "11"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["431422", "11"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "12"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "45"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "39677"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["15", "4"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["158033", "4"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["158033", "4"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "13"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "70"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "40302"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["70", "13"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["519026", "13"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["519026", "13"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "14"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "157"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "47871"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["157", "14"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["645545", "14"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["645545", "14"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "15"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "208"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "50472"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["208", "15"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["713816", "15"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["713816", "15"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "16"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "283"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "56097"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["283", "16"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["817463", "16"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["817463", "16"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "17"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "332"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "58498"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["332", "17"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["884242", "17"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["884242", "17"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "18"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "272"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "62098"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["136", "9"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["521890", "9"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["521890", "9"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "19"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "256"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "62354"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["256", "19"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["1119190", "19"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["1119190", "19"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "20"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "206"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "64854"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["103", "10"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["313661", "5"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["313661", "5"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "21"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "293"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "72423"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["293", "21"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["1435034", "21"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["1435034", "21"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "22"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "352"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "75904"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", "16"}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", "70272"}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", "70272"}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "23"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "405"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "78713"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["405", "23"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["1646374", "23"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["1646374", "23"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "24"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "330"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "84338"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["55", "4"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["159601", "2"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["159601", "2"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "25"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "373"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "86187"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["373", "25"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["2015546", "25"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["2015546", "25"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "26"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "286"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "93756"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", "11"}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", "90610"}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", "90610"}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "27"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "302"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "94012"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["302", "27"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["2447120", "27"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["2447120", "27"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "28"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "340"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "95456"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["85", "7"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["639292", "7"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["639292", "7"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "29"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "391"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "98057"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["391", "29"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["2690772", "29"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["2690772", "29"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "30"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "321"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "102957"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["107", "10"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["995223", "10"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["995223", "10"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "31"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "328"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "103006"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["328", "31"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["3085602", "31"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["3085602", "31"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "32"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "309"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "103367"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["309", "32"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["3212263", "32"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["3212263", "32"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "33"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "269"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "104967"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["269", "33"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["3391550", "33"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["3391550", "33"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "34"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "254"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "105192"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["127", "17"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["1756006", "17"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["1756006", "17"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "35"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "337"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "112081"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["337", "35"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["3809266", "35"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["3809266", "35"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "36"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "424"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "119650"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["106", "9"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["1031906", "9"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["1031906", "9"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "37"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "358"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "124006"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["358", "37"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["4460058", "37"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["4460058", "37"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "38"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "452"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "132842"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["226", "19"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["2421846", "19"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["2421846", "19"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "39"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "412"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "134442"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["412", "39"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["5073494", "39"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["5073494", "39"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "40"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "338"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "139918"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["169", "20"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["1370619", "10"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["1370619", "10"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "41"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "358"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "140318"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["358", "41"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["5624874", "41"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["5624874", "41"]}]},
    {
     RowBox[{"\<\"count\"\>", "\[Rule]", "42"}], 
     RowBox[{"\<\"sum\"\>", "\[Rule]", "398"}], 
     RowBox[{"\<\"sum2\"\>", "\[Rule]", "141918"}], 
     RowBox[{"\<\"mean\"\>", "\[Rule]", 
      FractionBox["199", "21"]}], 
     RowBox[{"\<\"ssr\"\>", "\[Rule]", 
      FractionBox["2901076", "21"]}], 
     RowBox[{"\<\"nssr\"\>", "\[Rule]", 
      FractionBox["2901076", "21"]}]}
   },
   GridBoxAlignment->{
    "Columns" -> {{Left}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
     "RowsIndexed" -> {}},
   GridBoxSpacings->{"Columns" -> {
       Offset[0.27999999999999997`], {
        Offset[2.0999999999999996`]}, 
       Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
       Offset[0.2], {
        Offset[0.4]}, 
       Offset[0.2]}, "RowsIndexed" -> {}}],
  Function[BoxForm`e$, 
   TableForm[BoxForm`e$]]]], "Output",
 CellChangeTimes->{3.606311248915677*^9, 3.606312284892311*^9, 
  3.60631253743664*^9, 3.606346851709659*^9, 3.6063562818260803`*^9, 
  3.606383354475725*^9, 3.606384363308083*^9, 3.606386465991035*^9, 
  3.606388276334526*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Observing Instead of Iterating", "Section"],

Cell[BoxData[
 RowBox[{
  RowBox[{"$observer", "[", "subscriptionId_", "]"}], ":=", 
  "\[IndentingNewLine]", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"welfordState", "=", "welfordZero"}], "}"}], ",", 
    RowBox[{
     RowBox[{
      RowBox[{"{", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"SubscriptionId", "\[RuleDelayed]", "subscriptionId"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"OnNext", "[", "v_", "]"}], "\[RuleDelayed]", 
         RowBox[{"(", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"With", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{"o", "=", "welfordState"}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"With", "[", 
              RowBox[{
               RowBox[{"{", "\[IndentingNewLine]", 
                RowBox[{
                 RowBox[{"count", "=", 
                  RowBox[{"1", "+", 
                   RowBox[{"o", ".", "\"\<count\>\""}]}]}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"sum", "=", 
                  RowBox[{"v", "+", 
                   RowBox[{"o", ".", "\"\<sum\>\""}]}]}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"sum2", "=", 
                  RowBox[{
                   SuperscriptBox["v", "2"], "+", 
                   RowBox[{"o", ".", "\"\<sum2\>\""}]}]}]}], "}"}], ",", 
               "\[IndentingNewLine]", 
               RowBox[{"With", "[", 
                RowBox[{
                 RowBox[{"{", "\[IndentingNewLine]", 
                  RowBox[{
                   RowBox[{"mean", "=", 
                    RowBox[{"sum", "/", "count"}]}], ",", 
                   "\[IndentingNewLine]", 
                   RowBox[{"oldMean", "=", 
                    RowBox[{"o", ".", "\"\<mean\>\""}]}], ",", 
                   "\[IndentingNewLine]", 
                   RowBox[{"oldSsr", "=", 
                    RowBox[{"o", ".", "\"\<ssr\>\""}]}]}], "}"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"welfordState", "=", 
                  RowBox[{"{", "\[IndentingNewLine]", 
                   RowBox[{
                    RowBox[{"\"\<count\>\"", "\[Rule]", "count"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"\"\<sum\>\"", "\[Rule]", "sum"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"\"\<sum2\>\"", "\[Rule]", "sum2"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"\"\<mean\>\"", "\[Rule]", "mean"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"\"\<ssr\>\"", "\[Rule]", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{"v", "-", "oldMean"}], ")"}], 
                    RowBox[{"(", 
                    RowBox[{"v", "-", "mean"}], ")"}]}], "+", "oldSsr"}]}], 
                    ",", "\[IndentingNewLine]", 
                    RowBox[{"\"\<nssr\>\"", "\[Rule]", 
                    RowBox[{"sum2", "-", 
                    RowBox[{"count", "*", "mean", "*", "mean"}]}]}]}], 
                   "}"}]}]}], "]"}]}], "]"}]}], "]"}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{"$currentStats", "=", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"\"\<subId\>\"", "\[Rule]", "subscriptionId"}], ",", 
              RowBox[{"\"\<OnNext\>\"", "\[Rule]", "welfordState"}]}], 
             "}"}]}]}], ")"}]}], ",", "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"OnError", "[", "exc_", "]"}], "\[RuleDelayed]", 
         "\[IndentingNewLine]", 
         RowBox[{"(", 
          RowBox[{"$currentStats", "=", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"\"\<subId\>\"", "\[Rule]", "subscriptionId"}], ",", 
             RowBox[{"\"\<exception\>\"", "\[Rule]", "exc"}], ",", 
             RowBox[{"\"\<OnErrr\>\"", "\[Rule]", "welfordState"}]}], "}"}]}],
           ")"}]}], ",", "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"OnCompleted", "[", "]"}], "\[RuleDelayed]", 
         RowBox[{"(", "\[IndentingNewLine]", 
          RowBox[{"$currentStats", "=", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"\"\<subId\>\"", "\[Rule]", "subscriptionId"}], ",", 
             RowBox[{"\"\<OnCmpl\>\"", "\[Rule]", "welfordState"}]}], "}"}]}],
           ")"}]}]}], "}"}], "//", "Sort"}], "//", "Dispatch"}]}], 
   "]"}]}]], "Input",
 CellChangeTimes->{
  3.6063476329743557`*^9, {3.606356348668491*^9, 3.606356451804823*^9}, {
   3.606356485506364*^9, 3.60635651778413*^9}, {3.6063565534774103`*^9, 
   3.606356621624118*^9}, {3.606384331418848*^9, 3.6063843413196297`*^9}, {
   3.606384703907774*^9, 3.606384739096819*^9}, {3.606386140930601*^9, 
   3.606386213429819*^9}, {3.6063862933794317`*^9, 3.606386300299724*^9}, {
   3.606386356787373*^9, 3.606386420271299*^9}, {3.6063882952217207`*^9, 
   3.6063883089691153`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Dynamic", "[", "$currentStats", "]"}]], "Input"],

Cell[BoxData[
 DynamicBox[ToBoxes[$CellContext`$currentStats, StandardForm],
  ImageSizeCache->{127., {2., 11.}}]], "Output",
 CellChangeTimes->{
  3.606311249011302*^9, 3.606312284956952*^9, 3.606346851791815*^9, 
   3.606356281933481*^9, 3.6063833546367073`*^9, 3.6063843633569202`*^9, {
   3.606386445721622*^9, 3.606386466060419*^9}, 3.6063883189635687`*^9}]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"GenerateWithTime", "[", "\[IndentingNewLine]", 
   RowBox[{"1", ",", 
    RowBox[{"(*", " ", 
     RowBox[{"initial", " ", "state"}], " ", "*)"}], "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"#", "\[LessEqual]", 
      RowBox[{"Length", "[", "$collection", "]"}]}], "&"}], ",", 
    RowBox[{"(*", " ", 
     RowBox[{"condition", " ", "for", " ", "continuing"}], " ", "*)"}], 
    "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
     "$collection", "\[LeftDoubleBracket]", "#", "\[RightDoubleBracket]"}], 
     "&"}], ",", 
    RowBox[{"(*", " ", 
     RowBox[{"value", " ", "sent", " ", "to", " ", "OnNext"}], " ", "*)"}], 
    "\[IndentingNewLine]", 
    RowBox[{"0.0625", "&"}], ",", 
    RowBox[{"(*", " ", 
     RowBox[{"time", " ", "to", " ", "wait", " ", "between", " ", "values"}], 
     " ", "*)"}], "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"#", "+", "1"}], "&"}]}], " ", 
   RowBox[{"(*", " ", 
    RowBox[{"function", " ", "to", " ", "increment", " ", "state"}], " ", 
    "*)"}], "\[IndentingNewLine]", "]"}], ".", 
  RowBox[{"Subscribe", "[", 
   RowBox[{"$observer", "[", 
    RowBox[{"Unique", "[", "]"}], "]"}], "]"}]}]], "Input",
 CellChangeTimes->{{3.6063473034765882`*^9, 3.6063473524883137`*^9}, {
  3.606347476123852*^9, 3.606347535421357*^9}, {3.606347656612976*^9, 
  3.606347669331388*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Catastrophic Cancellation in Naive Computation of Variance\
\>", "Section",
 CellChangeTimes->{{3.606383528941193*^9, 3.606383546903323*^9}, {
  3.60638739609264*^9, 3.606387412872902*^9}}],

Cell[TextData[{
 "We may also compute SSR by the naive method, ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SuperscriptBox["S", 
     RowBox[{"(", "2", ")"}]], " ", "-", " ", 
    RowBox[{
     SuperscriptBox[
      RowBox[{"(", 
       SuperscriptBox["S", 
        RowBox[{"(", "1", ")"}]], ")"}], "2"], "/", 
     SuperscriptBox["S", 
      RowBox[{"(", "0", ")"}]]}]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
 " and investigate the conditions under which it diverges."
}], "Text",
 CellChangeTimes->{{3.606383561030511*^9, 3.606383564565537*^9}, {
   3.606383918577754*^9, 3.606384144972783*^9}, 3.606384213126958*^9}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Dynamic", "[", "$currentStats", "]"}]], "Input"],

Cell[BoxData[
 DynamicBox[ToBoxes[$CellContext`$currentStats, StandardForm],
  ImageSizeCache->{127., {2., 11.}}]], "Output",
 CellChangeTimes->{3.606386624108976*^9}]
}, Open  ]],

Cell[BoxData[
 RowBox[{"With", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"collection", "=", 
     RowBox[{"RandomReal", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"1*^10", ",", 
         RowBox[{"1*^10", "+", "100"}]}], "}"}], ",", "50"}], "]"}]}], "}"}], 
   ",", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"GenerateWithTime", "[", "\[IndentingNewLine]", 
     RowBox[{"1", ",", 
      RowBox[{"(*", " ", 
       RowBox[{"initial", " ", "state"}], " ", "*)"}], "\[IndentingNewLine]", 
      
      RowBox[{
       RowBox[{"#", "\[LessEqual]", 
        RowBox[{"Length", "[", "collection", "]"}]}], "&"}], ",", 
      RowBox[{"(*", " ", 
       RowBox[{"condition", " ", "for", " ", "continuing"}], " ", "*)"}], 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{
       "collection", "\[LeftDoubleBracket]", "#", "\[RightDoubleBracket]"}], 
       "&"}], ",", 
      RowBox[{"(*", " ", 
       RowBox[{"value", " ", "sent", " ", "to", " ", "OnNext"}], " ", "*)"}], 
      "\[IndentingNewLine]", 
      RowBox[{"0.0625", "&"}], ",", 
      RowBox[{"(*", " ", 
       RowBox[{
       "time", " ", "to", " ", "wait", " ", "between", " ", "values"}], " ", 
       "*)"}], "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"#", "+", "1"}], "&"}]}], " ", 
     RowBox[{"(*", " ", 
      RowBox[{"function", " ", "to", " ", "increment", " ", "state"}], " ", 
      "*)"}], "\[IndentingNewLine]", "]"}], ".", 
    RowBox[{"Subscribe", "[", 
     RowBox[{"$observer", "[", 
      RowBox[{"Unique", "[", "]"}], "]"}], "]"}]}]}], "]"}]], "Input",
 CellChangeTimes->{{3.6063473034765882`*^9, 3.6063473524883137`*^9}, {
  3.606347476123852*^9, 3.606347535421357*^9}, {3.606347656612976*^9, 
  3.606347669331388*^9}, {3.6063865510215178`*^9, 3.606386594654163*^9}, {
  3.606386638930468*^9, 3.606386655548324*^9}, {3.606386732610677*^9, 
  3.606386784060117*^9}, {3.606386863297669*^9, 3.6063869951918173`*^9}, {
  3.6063871458596153`*^9, 3.6063871676779633`*^9}, {3.606387321250999*^9, 
  3.60638735481209*^9}, {3.6063884223921413`*^9, 3.6063884533997087`*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"$collF", "=", 
   RowBox[{"RandomReal", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"1*^9", ",", 
       RowBox[{"1*^9", "+", "100"}]}], "}"}], ",", "5000"}], "]"}]}], 
  ";"}]], "Input",
 CellChangeTimes->{{3.6063885376342154`*^9, 3.6063885652647953`*^9}, {
  3.60638864408766*^9, 3.606388704645702*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Fold", "[", 
  RowBox[{
  "stateExtractor", ",", "\[IndentingNewLine]", "welfordZero", ",", 
   "\[IndentingNewLine]", 
   RowBox[{"welford", "/@", "$collF"}]}], "]"}]], "Input",
 CellChangeTimes->{
  3.606388405849674*^9, {3.606388466719886*^9, 3.606388517791995*^9}, {
   3.6063885742397757`*^9, 3.6063885770874567`*^9}}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"\<\"count\"\>", "\[Rule]", "5000"}], ",", 
   RowBox[{"\<\"sum\"\>", "\[Rule]", "5.000000250447427`*^12"}], ",", 
   RowBox[{"\<\"sum2\"\>", "\[Rule]", "5.000000500894846`*^21"}], ",", 
   RowBox[{"\<\"mean\"\>", "\[Rule]", "1.0000000500894854`*^9"}], ",", 
   RowBox[{"\<\"ssr\"\>", "\[Rule]", "4.213912390161818`*^6"}], ",", 
   RowBox[{"\<\"nssr\"\>", "\[Rule]", 
    RowBox[{"-", "1.9922944`*^7"}]}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.606388406748008*^9, {3.606388471515533*^9, 3.606388518383697*^9}, 
   3.6063885782038593`*^9, {3.606388646179302*^9, 3.6063886582016373`*^9}, {
   3.606388688930891*^9, 3.6063887062088823`*^9}}]
}, Open  ]],

Cell["\<\
Compare against built-in Variance:\
\>", "Text",
 CellChangeTimes->{{3.606388669441486*^9, 3.606388676784431*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{
    RowBox[{"Length", "@", "$collF"}], "-", "1"}], ")"}], "*", 
  RowBox[{"Variance", "[", "$collF", "]"}]}]], "Input",
 CellChangeTimes->{{3.6063885842856417`*^9, 3.606388629534028*^9}}],

Cell[BoxData["4.213912384883859`*^6"], "Output",
 CellChangeTimes->{{3.60638863072138*^9, 3.606388660769471*^9}, {
  3.606388691420396*^9, 3.606388711453444*^9}}]
}, Open  ]]
}, Open  ]]
}, Open  ]]
},
WindowSize->{1280, 1392},
WindowMargins->{{170, Automatic}, {Automatic, 296}},
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
Cell[1485, 35, 63, 2, 112, "Title"],
Cell[1551, 39, 31, 0, 50, "Author"],
Cell[1585, 41, 174, 4, 52, "Date"],
Cell[1762, 47, 92, 1, 48, "Input"],
Cell[CellGroupData[{
Cell[1879, 52, 30, 0, 103, "Section"],
Cell[1912, 54, 584, 25, 37, "Text"],
Cell[2499, 81, 784, 27, 61, "Text"],
Cell[3286, 110, 390, 9, 90, "Input"],
Cell[3679, 121, 918, 25, 195, "Input"],
Cell[CellGroupData[{
Cell[4622, 150, 32, 0, 39, "Subsection"],
Cell[CellGroupData[{
Cell[4679, 154, 930, 23, 195, "Input"],
Cell[5612, 179, 236, 3, 47, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[5909, 189, 45, 0, 103, "Section"],
Cell[5957, 191, 240, 6, 61, "Text"],
Cell[6200, 199, 937, 33, 109, "Text"],
Cell[7140, 234, 425, 16, 61, "Text"],
Cell[7568, 252, 404, 11, 90, "Input"],
Cell[CellGroupData[{
Cell[7997, 267, 35, 0, 39, "Subsection"],
Cell[8035, 269, 140, 3, 37, "Text"],
Cell[CellGroupData[{
Cell[8200, 276, 299, 9, 48, "Input"],
Cell[8502, 287, 1030, 23, 69, "Output"]
}, Open  ]],
Cell[9547, 313, 102, 2, 37, "Text"],
Cell[CellGroupData[{
Cell[9674, 319, 31, 0, 38, "Subsubsection"],
Cell[9708, 321, 487, 11, 132, "Input"]
}, Open  ]],
Cell[CellGroupData[{
Cell[10232, 337, 34, 0, 38, "Subsubsection"],
Cell[CellGroupData[{
Cell[10291, 341, 185, 4, 47, "Input"],
Cell[10479, 347, 233, 3, 47, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[10773, 357, 33, 0, 39, "Subsection"],
Cell[10809, 359, 50, 0, 37, "Text"],
Cell[CellGroupData[{
Cell[10884, 363, 31, 0, 38, "Subsubsection"],
Cell[10918, 365, 491, 11, 132, "Input"]
}, Open  ]],
Cell[CellGroupData[{
Cell[11446, 381, 34, 0, 38, "Subsubsection"],
Cell[CellGroupData[{
Cell[11505, 385, 185, 4, 47, "Input"],
Cell[11693, 391, 236, 3, 47, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[11990, 401, 136, 3, 39, "Subsection"],
Cell[12129, 406, 134, 3, 37, "Text"],
Cell[12266, 411, 254, 8, 37, "Text"],
Cell[12523, 421, 893, 32, 68, "DisplayFormula"],
Cell[13419, 455, 509, 17, 40, "Text"],
Cell[13931, 474, 1375, 50, 134, "DisplayFormula"],
Cell[15309, 526, 543, 19, 39, "Text"],
Cell[15855, 547, 1406, 50, 97, "DisplayFormula"],
Cell[17264, 599, 159, 3, 37, "Text"],
Cell[17426, 604, 856, 32, 29, "DisplayFormula"],
Cell[18285, 638, 1290, 47, 107, "DisplayFormula"],
Cell[19578, 687, 23, 0, 37, "Text"],
Cell[19604, 689, 437, 16, 29, "DisplayFormula"],
Cell[CellGroupData[{
Cell[20066, 709, 102, 1, 38, "Subsubsection"],
Cell[20171, 712, 126, 3, 37, "Text"],
Cell[20300, 717, 539, 18, 67, "DisplayFormula"]
}, Open  ]],
Cell[CellGroupData[{
Cell[20876, 740, 32, 0, 38, "Subsubsection"],
Cell[20911, 742, 2875, 66, 484, "Input"],
Cell[23789, 810, 772, 14, 195, "Input"],
Cell[CellGroupData[{
Cell[24586, 828, 303, 7, 90, "Input"],
Cell[24892, 837, 617, 14, 68, "Output"]
}, Open  ]],
Cell[25524, 854, 419, 13, 37, "Text"],
Cell[CellGroupData[{
Cell[25968, 871, 340, 8, 48, "Input"],
Cell[26311, 881, 306, 5, 68, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[26678, 893, 112, 1, 39, "Subsection"],
Cell[26793, 896, 382, 7, 76, "Text"],
Cell[27178, 905, 595, 18, 46, "DisplayFormula"],
Cell[27776, 925, 485, 10, 76, "Text"],
Cell[28264, 937, 623, 19, 82, "DisplayFormula"],
Cell[28890, 958, 879, 29, 53, "Text"],
Cell[29772, 989, 438, 13, 40, "DisplayFormula"],
Cell[30213, 1004, 85, 1, 46, "Text"],
Cell[30301, 1007, 467, 14, 42, "DisplayFormula"],
Cell[30771, 1023, 88, 1, 46, "Text"],
Cell[30862, 1026, 237, 4, 36, "DisplayFormula"],
Cell[31102, 1032, 257, 5, 46, "Text"],
Cell[31362, 1039, 1219, 39, 77, "DisplayFormula"],
Cell[32584, 1080, 185, 4, 46, "Text"],
Cell[32772, 1086, 2402, 83, 230, "DisplayFormula"],
Cell[35177, 1171, 24412, 826, 997, "DisplayFormula"],
Cell[59592, 1999, 264, 7, 48, "Text"],
Cell[59859, 2008, 2325, 75, 248, "DisplayFormula"],
Cell[62187, 2085, 2504, 61, 480, "Input"],
Cell[CellGroupData[{
Cell[64716, 2150, 274, 8, 60, "Input"],
Cell[64993, 2160, 767, 18, 58, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[65797, 2183, 580, 14, 217, "Input"],
Cell[66380, 2199, 612, 14, 86, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[67029, 2218, 347, 9, 112, "Input"],
Cell[67379, 2229, 640, 14, 86, "Output"]
}, Open  ]]
}, Closed]]
}, Open  ]],
Cell[CellGroupData[{
Cell[68080, 2250, 47, 0, 103, "Section"],
Cell[CellGroupData[{
Cell[68152, 2254, 45, 0, 39, "Subsection"],
Cell[CellGroupData[{
Cell[68222, 2258, 326, 10, 69, "Input"],
Cell[68551, 2270, 736, 12, 69, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[69324, 2287, 327, 10, 69, "Input"],
Cell[69654, 2299, 880, 16, 69, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[70571, 2320, 3038, 72, 473, "Input"],
Cell[73612, 2394, 16874, 433, 1306, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[90547, 2834, 49, 0, 103, "Section"],
Cell[90599, 2836, 5046, 111, 593, "Input"],
Cell[CellGroupData[{
Cell[95670, 2951, 72, 1, 48, "Input"],
Cell[95745, 2954, 362, 6, 47, "Output"]
}, Open  ]],
Cell[96122, 2963, 1366, 33, 174, "Input"]
}, Open  ]],
Cell[CellGroupData[{
Cell[97525, 3001, 199, 4, 103, "Section"],
Cell[97727, 3007, 635, 18, 44, "Text"],
Cell[CellGroupData[{
Cell[98387, 3029, 72, 1, 48, "Input"],
Cell[98462, 3032, 167, 3, 47, "Output"]
}, Open  ]],
Cell[98644, 3038, 2087, 49, 195, "Input"],
Cell[100734, 3089, 348, 10, 47, "Input"],
Cell[CellGroupData[{
Cell[101107, 3103, 347, 8, 90, "Input"],
Cell[101457, 3113, 695, 13, 54, "Output"]
}, Open  ]],
Cell[102167, 3129, 124, 3, 37, "Text"],
Cell[CellGroupData[{
Cell[102316, 3136, 239, 6, 48, "Input"],
Cell[102558, 3144, 162, 2, 50, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature Lv0GkCbpDMH4JAwOUzbyi#BT *)
