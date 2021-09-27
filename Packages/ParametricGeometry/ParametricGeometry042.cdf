(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 8.0' *)

(*************************************************************************)
(*                                                                       *)
(*  The Mathematica License under which this file was created prohibits  *)
(*  restricting third parties in receipt of this file from republishing  *)
(*  or redistributing it by any means, including but not limited to      *)
(*  rights management or terms of use, without the express consent of    *)
(*  Wolfram Research, Inc.                                               *)
(*                                                                       *)
(*************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[       835,         17]
NotebookDataLength[     43228,       1280]
NotebookOptionsPosition[     41899,       1223]
NotebookOutlinePosition[     42434,       1246]
CellTagsIndexPosition[     42391,       1243]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["Colinear Point and Parameter", "Title"],

Cell["\<\
Brian Beckman
16 Jan 2012\
\>", "Text"],

Cell[TextData[{
 "colinearPointAndParameter is a fundamental function we need in our \
geospatial libraries (SignalsAndContext\\Main\\Monza\\Libraries\\VETS) in C# \
(and probably later in JavaScript) for doing geometrical calculations with \
line segments. Given a line segment (think \[OpenCurlyDoubleQuote]minimal \
piece of the digitized road network\[CloseCurlyDoubleQuote]) and a point that \
may be off the segment (think \[OpenCurlyDoubleQuote]GPS point\
\[CloseCurlyDoubleQuote]), find the ",
 StyleBox["CLOSEST POINT ON THE SEGMENT TO THE GIVEN POINT",
  FontWeight->"Bold"],
 ". We will, in practice, convert from lon-lat to metric coordinates -- more \
on that after the main presentation; there are a few reasonable ways to do \
it. "
}], "Text"],

Cell["More precisely:", "Text"],

Cell[TextData[{
 "colinearPointAndParameter[",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 ", ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 ", ",
 Cell[BoxData[
  FormBox["p", TraditionalForm]]],
 "], where ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 ", ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 ", and ",
 Cell[BoxData[
  FormBox["p", TraditionalForm]]],
 " are points in two- or three-dimensional space, returns a pair consisting \
of another point ",
 Cell[BoxData[
  FormBox["q", TraditionalForm]]],
 " and a real number, the parameter ",
 Cell[BoxData[
  FormBox["t", TraditionalForm]]],
 ". "
}], "Text"],

Cell[TextData[{
 "Think of ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 " -- the \[OpenCurlyDoubleQuote]start\[CloseCurlyDoubleQuote] point -- and ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 " -- the \[OpenCurlyDoubleQuote]end\[CloseCurlyDoubleQuote] point -- as \
definining a ",
 StyleBox["directed line segment",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " or ",
 StyleBox["rooted vector",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "v"}], TraditionalForm]]],
 " (unrooted vectors just define direction; rooted vectors define a direction \
from their beginning points). Now imagine the infinite continuation of the \
segment ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "v"}], TraditionalForm]]],
 " in both directions (see the following ",
 StyleBox["interactive ",
  FontSlant->"Italic"],
 "diagram -- drag the points ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 ", ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 ", and ",
 Cell[BoxData[
  FormBox["p", TraditionalForm]]],
 " around the diagram and watch the outputs):"
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{"Ignore", " ", "this", " ", "block", " ", "of", " ", 
    RowBox[{"code", ":", " ", 
     RowBox[{
     "it", " ", "just", " ", "produces", " ", "an", " ", "interactive", " ", 
      RowBox[{"diagram", "."}]}]}]}], " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"lowLim", "=", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"-", "1.8"}], ",", 
         RowBox[{"-", "1.8"}]}], "}"}]}], ",", 
      RowBox[{"hiLim", "=", 
       RowBox[{"{", 
        RowBox[{"1.8", ",", "1.8"}], "}"}]}]}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"Show", "[", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"ListLinePlot", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"u", "-", 
             RowBox[{"10", 
              RowBox[{"(", 
               RowBox[{"v", "-", "u"}], ")"}]}]}], ",", 
            RowBox[{"v", "+", 
             RowBox[{"10", 
              RowBox[{"(", 
               RowBox[{"v", "-", "u"}], ")"}]}]}]}], "}"}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{"PlotRange", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{
               RowBox[{"-", "2"}], ",", "2"}], "}"}], ",", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"-", "2"}], ",", "2"}], "}"}]}], "}"}]}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{"AspectRatio", "\[Rule]", "1"}]}], "]"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"Graphics", "[", 
         RowBox[{"{", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"Arrow", "[", 
            RowBox[{"{", 
             RowBox[{"u", ",", "v"}], "}"}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Text", "[", 
            RowBox[{"\"\<u\>\"", ",", 
             RowBox[{"u", "+", 
              RowBox[{"{", 
               RowBox[{"0", ",", "0.15"}], "}"}]}]}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Text", "[", 
            RowBox[{"\"\<p\>\"", ",", 
             RowBox[{"p", "+", 
              RowBox[{"{", 
               RowBox[{"0", ",", "0.15"}], "}"}]}]}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Text", "[", 
            RowBox[{"\"\<v\>\"", ",", 
             RowBox[{"v", "+", 
              RowBox[{"{", 
               RowBox[{"0", ",", "0.15"}], "}"}]}]}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Text", "[", 
            RowBox[{
             RowBox[{"\"\<vu slope: \>\"", "<>", 
              RowBox[{"If", "[", 
               RowBox[{
                RowBox[{
                 RowBox[{
                  RowBox[{
                  "v", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}],
                   "-", 
                  RowBox[{
                  "u", "\[LeftDoubleBracket]", "1", 
                   "\[RightDoubleBracket]"}]}], "\[Equal]", "0"}], ",", 
                "\[IndentingNewLine]", "\"\<Infinity\>\"", ",", 
                "\[IndentingNewLine]", 
                RowBox[{"ToString", "@", 
                 FractionBox[
                  RowBox[{
                   RowBox[{
                   "v", "\[LeftDoubleBracket]", "2", 
                    "\[RightDoubleBracket]"}], "-", 
                   RowBox[{
                   "u", "\[LeftDoubleBracket]", "2", 
                    "\[RightDoubleBracket]"}]}], 
                  RowBox[{
                   RowBox[{
                   "v", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}], "-", 
                   RowBox[{
                   "u", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}]}]]}]}], "]"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"-", "1.25"}], ",", "1.9"}], "}"}]}], "]"}]}], 
          "\[IndentingNewLine]", "}"}], "]"}]}], "]"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"u", ",", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"-", "1"}], ",", 
            RowBox[{"-", "0.5"}]}], "}"}]}], "}"}], ",", "lowLim", ",", 
        "hiLim", ",", "Locator"}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"v", ",", 
          RowBox[{"{", 
           RowBox[{"1", ",", "0.75"}], "}"}]}], "}"}], ",", "lowLim", ",", 
        "hiLim", ",", "Locator"}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"p", ",", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"-", "0.75"}], ",", "0.6"}], "}"}]}], "}"}], ",", 
        "lowLim", ",", "hiLim", ",", "Locator"}], "}"}]}], 
     "\[IndentingNewLine]", "]"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 FormBox[
  TagBox[
   FormBox[
    StyleBox[
     DynamicModuleBox[{$CellContext`p$$ = {-0.75, 
      0.6}, $CellContext`u$$ = {-1, -0.5}, $CellContext`v$$ = {1, 0.75}, 
      Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
      Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ =
       1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{{
         Hold[$CellContext`u$$], {-1, -0.5}}, {-1.8, -1.8}, {1.8, 1.8}}, {{
         Hold[$CellContext`v$$], {1, 0.75}}, {-1.8, -1.8}, {1.8, 1.8}}, {{
         Hold[$CellContext`p$$], {-0.75, 0.6}}, {-1.8, -1.8}, {1.8, 1.8}}}, 
      Typeset`size$$ = {540., {268., 277.}}, Typeset`update$$ = 0, 
      Typeset`initDone$$, Typeset`skipInitDone$$ = 
      True, $CellContext`u$751$$ = {0, 0}, $CellContext`v$752$$ = {0, 
      0}, $CellContext`p$753$$ = {0, 0}}, 
      DynamicBox[Manipulate`ManipulateBoxes[
       1, TraditionalForm, 
        "Variables" :> {$CellContext`p$$ = {-0.75, 
           0.6}, $CellContext`u$$ = {-1, -0.5}, $CellContext`v$$ = {1, 0.75}},
         "ControllerVariables" :> {
          Hold[$CellContext`u$$, $CellContext`u$751$$, {0, 0}], 
          Hold[$CellContext`v$$, $CellContext`v$752$$, {0, 0}], 
          Hold[$CellContext`p$$, $CellContext`p$753$$, {0, 0}]}, 
        "OtherVariables" :> {
         Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
          Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
          Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
          Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> Show[
          
          ListLinePlot[{$CellContext`u$$ - 
            10 ($CellContext`v$$ - $CellContext`u$$), $CellContext`v$$ + 
            10 ($CellContext`v$$ - $CellContext`u$$)}, 
           PlotRange -> {{-2, 2}, {-2, 2}}, AspectRatio -> 1], 
          Graphics[{
            Arrow[{$CellContext`u$$, $CellContext`v$$}], 
            Text["u", $CellContext`u$$ + {0, 0.15}], 
            Text["p", $CellContext`p$$ + {0, 0.15}], 
            Text["v", $CellContext`v$$ + {0, 0.15}], 
            Text[
             StringJoin["vu slope: ", 
              If[
              Part[$CellContext`v$$, 1] - Part[$CellContext`u$$, 1] == 0, 
               "Infinity", 
               
               ToString[(Part[$CellContext`v$$, 2] - 
                 Part[$CellContext`u$$, 2])/(Part[$CellContext`v$$, 1] - 
                Part[$CellContext`u$$, 1])]]], {-1.25, 1.9}]}]], 
        "Specifications" :> {{{$CellContext`u$$, {-1, -0.5}}, {-1.8, -1.8}, {
           1.8, 1.8}, ControlType -> 
           Locator}, {{$CellContext`v$$, {1, 0.75}}, {-1.8, -1.8}, {1.8, 1.8},
            ControlType -> 
           Locator}, {{$CellContext`p$$, {-0.75, 0.6}}, {-1.8, -1.8}, {1.8, 
           1.8}, ControlType -> Locator}}, "Options" :> {}, 
        "DefaultOptions" :> {}],
       ImageSizeCache->{620., {316., 325.}},
       SingleEvaluation->True],
      Deinitialization:>None,
      DynamicModuleValues:>{},
      SynchronousInitialization->True,
      UnsavedVariables:>{Typeset`initDone$$},
      UntrackedVariables:>{Typeset`size$$}], "Manipulate",
     Deployed->True,
     StripOnInput->False],
    TraditionalForm],
   Manipulate`InterpretManipulate[1]], TraditionalForm]], "Output"]
}, Open  ]],

Cell[TextData[{
 "The point ",
 StyleBox["q",
  FontSlant->"Italic"],
 " that we seek lies on the infinite extension of the line segment ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "v"}], TraditionalForm]]],
 " and is as close as possible to the line segment in the metric of the \
geometry (the Euclidean metric, which measures Pythagorean distances, or the \
Haversin metric, which measures distances on great circles). Let us call ",
 Cell[BoxData[
  FormBox["q", TraditionalForm]]],
 " the \[OpenCurlyDoubleQuote]colinear point;\[CloseCurlyDoubleQuote] we \
could call it the \[OpenCurlyDoubleQuote]closest \
point\[CloseCurlyDoubleQuote] or any number of other suitable names. "
}], "Text"],

Cell[TextData[{
 "Our definition of the parameter ",
 Cell[BoxData[
  FormBox["t", TraditionalForm]]],
 " is such that ",
 Cell[BoxData[
  FormBox["t", TraditionalForm]]],
 " lies between 0 and 1 if and only if ",
 Cell[BoxData[
  FormBox["q", TraditionalForm]]],
 " lies geometrically between ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 " and ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 "; ",
 Cell[BoxData[
  FormBox[
   RowBox[{"t", "=", "0"}], TraditionalForm]]],
 " exactly when ",
 Cell[BoxData[
  FormBox[
   RowBox[{"q", "=", "u"}], TraditionalForm]]],
 ", that is, the colinear point coincides with the start point ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 " of the segment ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "v"}], TraditionalForm]]],
 "; ",
 Cell[BoxData[
  FormBox[
   RowBox[{"t", "=", "1"}], TraditionalForm]]],
 " exactly when ",
 Cell[BoxData[
  FormBox[
   RowBox[{"q", "=", "v"}], TraditionalForm]]],
 ", that is, the colinear point coincides with the end point ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 " of the segment ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "v"}], TraditionalForm]]],
 "; ",
 Cell[BoxData[
  FormBox[
   RowBox[{"t", "<", "0"}], TraditionalForm]]],
 " when ",
 Cell[BoxData[
  FormBox["q", TraditionalForm]]],
 " lies on the infinite extension of ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "v"}], TraditionalForm]]],
 " on the ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 " side, that is, metrically closer to ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 " than to ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 "; ",
 Cell[BoxData[
  FormBox[
   RowBox[{"t", ">", "1"}], TraditionalForm]]],
 " when ",
 Cell[BoxData[
  FormBox["q", TraditionalForm]]],
 " lies on the infinite extension of ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "v"}], TraditionalForm]]],
 " on the ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 " side, that is, metrically closer to ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 " than to ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 ". "
}], "Text"],

Cell[TextData[{
 "We solve this by noting that the ",
 StyleBox["inner product",
  FontSlant->"Italic"],
 " (",
 "http://en.wikipedia.org/wiki/Inner_product_space) ",
 "in the metric space gives the ",
 StyleBox["scaled orthogonal projection",
  FontSlant->"Italic"],
 " of the rooted vector ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "p"}], TraditionalForm]]],
 " on the rooted vector ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "v"}], TraditionalForm]]],
 ". Let\[CloseCurlyQuote]s compute that."
}], "Text"],

Cell[TextData[{
 "The components of the rooted vector ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "\[Rule]", "v"}], TraditionalForm]]],
 " are just the elementwise difference (the vector difference) of the \
coordinates of the points ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 " and ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 ", namely ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"u", "-", "v"}], "=", 
    RowBox[{"def", "=", 
     RowBox[{"(", 
      RowBox[{
       RowBox[{
        SubscriptBox["u", "1"], "-", 
        SubscriptBox["v", "1"]}], ",", " ", 
       RowBox[{
        SubscriptBox["u", "2"], "-", 
        SubscriptBox["v", "2"]}]}], ")"}]}]}], TraditionalForm]]],
 " in two dimensions, and ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"(", 
     RowBox[{
      RowBox[{
       SubscriptBox["u", "1"], "-", 
       SubscriptBox["v", "1"]}], ",", " ", 
      RowBox[{
       SubscriptBox["u", "2"], "-", 
       SubscriptBox["v", "2"]}], ",", " ", 
      RowBox[{
       SubscriptBox["u", "3"], "-", 
       SubscriptBox["v", "3"]}]}], ")"}], Cell[""]}], TraditionalForm]]],
 "in three dimensions. In the Mathematica code below, we can just write this \
as ",
 Cell[BoxData[
  FormBox[
   RowBox[{"u", "-", "v"}], TraditionalForm]]],
 "; in C#, we must write Vector classes to do this (I think VETS already has \
support for it. Exercise: check)."
}], "Text"],

Cell[TextData[{
 "The scaled orthogonal projection of rooted vector ",
 Cell[BoxData[
  FormBox[
   RowBox[{"p", "-", "u"}], TraditionalForm]]],
 " on rooted vector ",
 Cell[BoxData[
  FormBox[
   RowBox[{"v", "-", "u"}], TraditionalForm]]],
 " is"
}], "Text"],

Cell[TextData[Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"(", 
    RowBox[{"p", "-", "u"}], ")"}], "\[CenterDot]", 
   RowBox[{"(", 
    RowBox[{"v", "-", "u"}], ")"}]}], TraditionalForm]]]], "Text"],

Cell["\<\
where the \[OpenCurlyDoubleQuote]dot product\[CloseCurlyDoubleQuote] is the \
usual Euclidean inner product (later, we generalize this to the Haversin \
metric):\
\>", "Text"],

Cell[TextData[{
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"a", "\[CenterDot]", "b"}], "=", 
    RowBox[{"def", "=", 
     RowBox[{
      RowBox[{"(", 
       RowBox[{
        SubscriptBox["a", "1"], "\[Times]", 
        SubscriptBox["b", "1"]}], ")"}], "+", 
      RowBox[{"(", 
       RowBox[{
        SubscriptBox["a", "2"], "\[Times]", 
        SubscriptBox["b", "2"]}], ")"}]}]}]}], TraditionalForm]]],
 " in two dimensions, or ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"(", 
     RowBox[{
      SubscriptBox["a", "1"], "\[Times]", 
      SubscriptBox["b", "1"]}], ")"}], "+", 
    RowBox[{"(", 
     RowBox[{
      SubscriptBox["a", "2"], "\[Times]", 
      SubscriptBox["b", "2"]}], ")"}], "+", 
    RowBox[{"(", 
     RowBox[{
      SubscriptBox["a", "3"], "\[Times]", 
      SubscriptBox["b", "3"]}], ")"}]}], TraditionalForm]]],
 " in three dimensions. "
}], "Text"],

Cell["\<\
Considering our points in three dimensions, then, we can have Mathematica \
calculate this for us prettily:\
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"With", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"p", "=", 
      RowBox[{"{", 
       RowBox[{"p1", ",", "p2", ",", "p3"}], "}"}]}], ",", 
     RowBox[{"u", "=", 
      RowBox[{"{", 
       RowBox[{"u1", ",", "u2", ",", "u3"}], "}"}]}], ",", 
     RowBox[{"v", "=", 
      RowBox[{"{", 
       RowBox[{"v1", ",", "v2", ",", "v3"}], "}"}]}]}], "}"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"p", "-", "u"}], ")"}], ".", 
    RowBox[{"(", 
     RowBox[{"v", "-", "u"}], ")"}]}]}], "]"}]], "Input"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{
    RowBox[{"(", 
     RowBox[{"p1", "-", "u1"}], ")"}], " ", 
    RowBox[{"(", 
     RowBox[{"v1", "-", "u1"}], ")"}]}], "+", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"p2", "-", "u2"}], ")"}], " ", 
    RowBox[{"(", 
     RowBox[{"v2", "-", "u2"}], ")"}]}], "+", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"p3", "-", "u3"}], ")"}], " ", 
    RowBox[{"(", 
     RowBox[{"v3", "-", "u3"}], ")"}]}]}], TraditionalForm]], "Output"]
}, Open  ]],

Cell["\<\
A Euclidean inner product like this is an essential part of vector classes in \
C# (not sure if our VETS library has this. Exercise: check and put it in \
otherwise.\
\>", "Text"],

Cell["In Euclidean space, ", "Text"],

Cell[TextData[Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{
    RowBox[{"(", 
     RowBox[{"p", "-", "u"}], ")"}], "\[CenterDot]", 
    RowBox[{"(", 
     RowBox[{"v", "-", "u"}], ")"}]}], "=", 
   RowBox[{"||", 
    RowBox[{"p", "-", "u"}], "||", 
    RowBox[{"\[Times]", 
     RowBox[{"||", 
      RowBox[{"v", "-", "u"}], "||", 
      RowBox[{"cos", "(", 
       RowBox[{"\[Theta]", "=", 
        RowBox[{"def", "=", 
         RowBox[{"angle", " ", "between", " ", 
          RowBox[{"(", 
           RowBox[{"p", "-", "u"}], ")"}], " ", "and", " ", 
          RowBox[{"(", 
           RowBox[{"v", "-", "u"}], ")"}]}]}]}], ")"}]}]}]}]}], 
  TraditionalForm]]]], "Text"],

Cell[TextData[{
 "that is, the orthogonal projection of ",
 Cell[BoxData[
  FormBox[
   RowBox[{"p", "-", "u"}], TraditionalForm]]],
 " on ",
 Cell[BoxData[
  FormBox[
   RowBox[{"v", "-", "u"}], TraditionalForm]]],
 " times the lengths of the two vectors. But the value of the parameter ",
 Cell[BoxData[
  FormBox["t", TraditionalForm]]],
 " that we want is the length of that orthogonal project as a fraction of the \
length of ",
 Cell[BoxData[
  FormBox[
   RowBox[{"v", "-", "u"}], TraditionalForm]]],
 ". In other words, we want"
}], "Text"],

Cell[TextData[Cell[BoxData[
 FormBox[
  RowBox[{"t", "=", 
   RowBox[{
    FractionBox[
     RowBox[{"||", 
      RowBox[{"p", "-", "u"}], "||"}], 
     RowBox[{"||", 
      RowBox[{"v", "-", "u"}], "||"}]], 
    RowBox[{"cos", "(", "\[Theta]", ")"}]}]}], TraditionalForm]]]], "Text"],

Cell["we immediately write", "Text"],

Cell[TextData[Cell[BoxData[
 FormBox[
  RowBox[{"t", "=", 
   RowBox[{
    RowBox[{
     FractionBox[
      RowBox[{"||", 
       RowBox[{"p", "-", "u"}], "||"}], 
      RowBox[{"||", 
       RowBox[{"v", "-", "u"}], "||"}]], 
     RowBox[{"cos", "(", "\[Theta]", ")"}]}], "=", 
    RowBox[{
     RowBox[{
      FractionBox[
       RowBox[{"||", 
        RowBox[{"p", "-", "u"}], "||", 
        RowBox[{"\[Times]", 
         RowBox[{"||", 
          RowBox[{"v", "-", "u"}], "||"}]}]}], 
       RowBox[{"||", 
        RowBox[{"v", "-", "u"}], "||", 
        RowBox[{"\[Times]", 
         RowBox[{"||", 
          RowBox[{"v", "-", "u"}], "||"}]}]}]], 
      RowBox[{"cos", "(", "\[Theta]", ")"}], " ", "when"}], " ", "||", 
     RowBox[{"v", "-", "u"}], "||", 
     RowBox[{"\[NotEqual]", " ", "0"}]}]}]}], TraditionalForm]]]], "Text"],

Cell[TextData[{
 "Noting that ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"||", 
     RowBox[{"v", "-", "u"}], "||", 
     RowBox[{"\[Times]", 
      RowBox[{"||", 
       RowBox[{"v", "-", "u"}], "||"}]}]}], "=", 
    RowBox[{
     RowBox[{"(", 
      RowBox[{"v", "-", "u"}], ")"}], "\[CenterDot]", 
     RowBox[{"(", 
      RowBox[{"v", "-", "u"}], ")"}]}]}], TraditionalForm]]],
 ", another application of inner product, and that ",
 Cell[BoxData[
  FormBox[
   RowBox[{"||", 
    RowBox[{"v", "-", "u"}], "||", 
    RowBox[{"\[NotEqual]", 
     RowBox[{"0", " ", "iff", " ", "v"}], "\[NotEqual]", "u"}]}], 
   TraditionalForm]]],
 ", we conclude that"
}], "Text"],

Cell[TextData[Cell[BoxData[
 FormBox[
  RowBox[{"t", "=", 
   RowBox[{
    RowBox[{
     FractionBox[
      RowBox[{
       RowBox[{"(", 
        RowBox[{"p", "-", "u"}], ")"}], "\[CenterDot]", 
       RowBox[{"(", 
        RowBox[{"v", "-", "u"}], ")"}]}], 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"v", "-", "u"}], ")"}], "\[CenterDot]", 
       RowBox[{"(", 
        RowBox[{"v", "-", "u"}], ")"}]}]], "when", " ", "v"}], "\[NotEqual]", 
    "u"}]}], TraditionalForm]]]], "Text"],

Cell[TextData[{
 "To find ",
 Cell[BoxData[
  FormBox[
   RowBox[{"q", Cell[""]}], TraditionalForm]]],
 ", we note that the rooted vector ",
 Cell[BoxData[
  FormBox[
   RowBox[{"q", "-", "u"}], TraditionalForm]]],
 " is colinear with the rooted vector ",
 Cell[BoxData[
  FormBox[
   RowBox[{"v", "-", "u"}], TraditionalForm]]],
 " and that its length is exactly ",
 Cell[BoxData[
  FormBox["t", TraditionalForm]]],
 " times the length of ",
 Cell[BoxData[
  FormBox[
   RowBox[{"v", "-", "u"}], TraditionalForm]]],
 ". This is standard LERP (",
 "http://en.wikipedia.org/wiki/Linear_interpolation)"
}], "Text"],

Cell[TextData[Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"q", "-", "u"}], "=", 
   RowBox[{
    RowBox[{"t", "\[Times]", 
     RowBox[{"(", 
      RowBox[{"v", "-", "u"}], ")"}]}], "\[DoubleLeftRightArrow]"}]}], 
  TraditionalForm]]]], "Text"],

Cell[TextData[{
 "In the degenerate case when ",
 Cell[BoxData[
  FormBox[
   RowBox[{"v", "=", "u"}], TraditionalForm]]],
 ", let\[CloseCurlyQuote]s define the answers to be ",
 Cell[BoxData[
  FormBox[
   RowBox[{"q", "=", "u"}], TraditionalForm]]],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{"t", "=", "0"}], TraditionalForm]]],
 " so they smoothly connect to the non-degenerate cases. "
}], "Text"],

Cell["In two dimensions, then, we may write", "Text"],

Cell[BoxData[
 RowBox[{
  RowBox[{"colinearPointAndParameter", "[", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"u", ":", 
     RowBox[{"{", 
      RowBox[{"u1_", ",", "u2_"}], "}"}]}], ",", "\[IndentingNewLine]", 
    RowBox[{"v", ":", 
     RowBox[{"{", 
      RowBox[{"v1_", ",", "v2_"}], "}"}]}], ",", "\[IndentingNewLine]", 
    RowBox[{"p", ":", 
     RowBox[{"{", 
      RowBox[{"p1_", ",", "p2_"}], "}"}]}]}], "]"}], ":=", 
  "\[IndentingNewLine]", 
  RowBox[{"If", "[", 
   RowBox[{
    RowBox[{"v", "\[NotEqual]", "u"}], ",", "\[IndentingNewLine]", 
    RowBox[{"With", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"t", "=", 
        FractionBox[
         RowBox[{
          RowBox[{"(", 
           RowBox[{"p", "-", "u"}], ")"}], ".", 
          RowBox[{"(", 
           RowBox[{"v", "-", "u"}], ")"}]}], 
         RowBox[{
          RowBox[{"(", 
           RowBox[{"v", "-", "u"}], ")"}], ".", 
          RowBox[{"(", 
           RowBox[{"v", "-", "u"}], ")"}]}]]}], "}"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"u", "+", 
         RowBox[{"t", 
          RowBox[{"(", 
           RowBox[{"v", "-", "u"}], ")"}]}]}], ",", "t"}], "}"}]}], "]"}], 
    ",", "\[IndentingNewLine]", 
    RowBox[{"(*", "else", "*)"}], "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{"u", ",", "0"}], "}"}]}], "]"}]}]], "Input"],

Cell[TextData[{
 "and the translations to C# and Javascript should be obvious. Next, we \
produce an interactive visualization that enables us to check this code (see \
the following interactive diagram below the code -- drag the points ",
 Cell[BoxData[
  FormBox["u", TraditionalForm]]],
 ", ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 ", and ",
 Cell[BoxData[
  FormBox["p", TraditionalForm]]],
 " around the diagram and watch the outputs)"
}], "Text"],

Cell[CellGroupData[{

Cell["Interactive Visualization Colinear Point and Parameter", "Section"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{"Ignore", " ", "this", " ", "block", " ", "of", " ", 
    RowBox[{"code", ":", " ", 
     RowBox[{
     "it", " ", "just", " ", "produces", " ", "an", " ", "interactive", " ", 
      RowBox[{"diagram", "."}]}]}]}], " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{"With", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"lowLim", "=", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"-", "1.8"}], ",", 
         RowBox[{"-", "1.8"}]}], "}"}]}], ",", 
      RowBox[{"hiLim", "=", 
       RowBox[{"{", 
        RowBox[{"1.8", ",", "1.8"}], "}"}]}]}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"Module", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"q", ",", "t", ",", "\[IndentingNewLine]", 
          RowBox[{"cpp", "=", 
           RowBox[{"Function", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{"uz", ",", "vz", ",", "pz"}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"If", "[", 
              RowBox[{
               RowBox[{"vz", "\[NotEqual]", "uz"}], ",", 
               "\[IndentingNewLine]", 
               RowBox[{"With", "[", 
                RowBox[{
                 RowBox[{"{", 
                  RowBox[{"tz", "=", 
                   FractionBox[
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{"pz", "-", "uz"}], ")"}], ".", 
                    RowBox[{"(", 
                    RowBox[{"vz", "-", "uz"}], ")"}]}], 
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{"vz", "-", "uz"}], ")"}], ".", 
                    RowBox[{"(", 
                    RowBox[{"vz", "-", "uz"}], ")"}]}]]}], "}"}], ",", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"uz", "+", 
                    RowBox[{"tz", 
                    RowBox[{"(", 
                    RowBox[{"vz", "-", "uz"}], ")"}]}]}], ",", "tz"}], 
                  "}"}]}], "]"}], ",", "\[IndentingNewLine]", 
               RowBox[{"(*", "else", "*)"}], "\[IndentingNewLine]", 
               RowBox[{"{", 
                RowBox[{"uz", ",", "0"}], "}"}]}], "]"}]}], "]"}]}]}], "}"}], 
        ",", "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{
          RowBox[{"{", 
           RowBox[{"q", ",", "t"}], "}"}], "=", 
          RowBox[{"cpp", "[", 
           RowBox[{"u", ",", "v", ",", "p"}], "]"}]}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Show", "[", 
          RowBox[{
           RowBox[{"ListLinePlot", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{
               RowBox[{"u", "-", 
                RowBox[{"10", 
                 RowBox[{"(", 
                  RowBox[{"v", "-", "u"}], ")"}]}]}], ",", 
               RowBox[{"v", "+", 
                RowBox[{"10", 
                 RowBox[{"(", 
                  RowBox[{"v", "-", "u"}], ")"}]}]}]}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"PlotRange", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{
                RowBox[{"{", 
                 RowBox[{
                  RowBox[{"-", "2"}], ",", "2"}], "}"}], ",", 
                RowBox[{"{", 
                 RowBox[{
                  RowBox[{"-", "2"}], ",", "2"}], "}"}]}], "}"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"AspectRatio", "\[Rule]", "1"}]}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"ListLinePlot", "[", 
            RowBox[{"{", 
             RowBox[{"q", ",", "p"}], "}"}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Graphics", "[", 
            RowBox[{"{", "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"Arrow", "[", 
               RowBox[{"{", 
                RowBox[{"u", ",", "v"}], "}"}], "]"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"Text", "[", 
               RowBox[{"\"\<u\>\"", ",", 
                RowBox[{"u", "+", 
                 RowBox[{"{", 
                  RowBox[{"0", ",", "0.15"}], "}"}]}]}], "]"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"Text", "[", 
               RowBox[{"\"\<p\>\"", ",", 
                RowBox[{"p", "+", 
                 RowBox[{"{", 
                  RowBox[{"0", ",", "0.15"}], "}"}]}]}], "]"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"Text", "[", 
               RowBox[{"\"\<v\>\"", ",", 
                RowBox[{"v", "+", 
                 RowBox[{"{", 
                  RowBox[{"0", ",", "0.15"}], "}"}]}]}], "]"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"Text", "[", 
               RowBox[{"\"\<q\>\"", ",", 
                RowBox[{"q", "+", 
                 RowBox[{"{", 
                  RowBox[{"0", ",", "0.15"}], "}"}]}]}], "]"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"Text", "[", 
               RowBox[{
                RowBox[{"\"\<vu slope: \>\"", "<>", 
                 RowBox[{"If", "[", 
                  RowBox[{
                   RowBox[{
                    RowBox[{
                    RowBox[{
                    "v", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}], "-", 
                    RowBox[{
                    "u", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}]}], "\[Equal]", "0"}], ",", 
                   "\[IndentingNewLine]", "\"\<Infinity\>\"", ",", 
                   "\[IndentingNewLine]", 
                   RowBox[{"ToString", "@", 
                    FractionBox[
                    RowBox[{
                    RowBox[{
                    "v", "\[LeftDoubleBracket]", "2", 
                    "\[RightDoubleBracket]"}], "-", 
                    RowBox[{
                    "u", "\[LeftDoubleBracket]", "2", 
                    "\[RightDoubleBracket]"}]}], 
                    RowBox[{
                    RowBox[{
                    "v", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}], "-", 
                    RowBox[{
                    "u", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}]}]]}]}], "]"}]}], ",", 
                "\[IndentingNewLine]", 
                RowBox[{"{", 
                 RowBox[{
                  RowBox[{"-", "1.25"}], ",", "1.9"}], "}"}]}], "]"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"Text", "[", 
               RowBox[{
                RowBox[{"\"\<qu slope: \>\"", "<>", 
                 RowBox[{"If", "[", 
                  RowBox[{
                   RowBox[{
                    RowBox[{
                    RowBox[{
                    "q", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}], "-", 
                    RowBox[{
                    "u", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}]}], "\[Equal]", "0"}], ",", 
                   "\[IndentingNewLine]", "\"\<Infinity\>\"", ",", 
                   "\[IndentingNewLine]", 
                   RowBox[{"ToString", "@", 
                    FractionBox[
                    RowBox[{
                    RowBox[{
                    "q", "\[LeftDoubleBracket]", "2", 
                    "\[RightDoubleBracket]"}], "-", 
                    RowBox[{
                    "u", "\[LeftDoubleBracket]", "2", 
                    "\[RightDoubleBracket]"}]}], 
                    RowBox[{
                    RowBox[{
                    "q", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}], "-", 
                    RowBox[{
                    "u", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}]}]]}]}], "]"}]}], ",", 
                "\[IndentingNewLine]", 
                RowBox[{"{", 
                 RowBox[{
                  RowBox[{"-", "1.25"}], ",", "1.8"}], "}"}]}], "]"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"Text", "[", 
               RowBox[{
                RowBox[{"\"\<t: \>\"", "<>", 
                 RowBox[{"ToString", "@", "t"}]}], ",", "\[IndentingNewLine]", 
                RowBox[{"{", 
                 RowBox[{
                  RowBox[{"-", "1.25"}], ",", "1.7"}], "}"}]}], "]"}], ",", 
              "\[IndentingNewLine]", "Red", ",", "\[IndentingNewLine]", 
              RowBox[{"Disk", "[", 
               RowBox[{"q", ",", "0.06"}], "]"}], ",", "\[IndentingNewLine]", 
              RowBox[{"Arrow", "[", 
               RowBox[{"{", 
                RowBox[{"u", ",", "q"}], "}"}], "]"}], ",", 
              "\[IndentingNewLine]", "Blue", ",", "\[IndentingNewLine]", 
              RowBox[{"Arrow", "[", 
               RowBox[{"{", 
                RowBox[{"u", ",", "p"}], "}"}], "]"}]}], 
             "\[IndentingNewLine]", "}"}], "]"}]}], "]"}]}]}], "]"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"u", ",", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"-", "1"}], ",", 
            RowBox[{"-", "0.5"}]}], "}"}]}], "}"}], ",", "lowLim", ",", 
        "hiLim", ",", "Locator"}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"v", ",", 
          RowBox[{"{", 
           RowBox[{"1", ",", "0.75"}], "}"}]}], "}"}], ",", "lowLim", ",", 
        "hiLim", ",", "Locator"}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"p", ",", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"-", "0.75"}], ",", "0.6"}], "}"}]}], "}"}], ",", 
        "lowLim", ",", "hiLim", ",", "Locator"}], "}"}]}], 
     "\[IndentingNewLine]", "]"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 FormBox[
  TagBox[
   FormBox[
    StyleBox[
     DynamicModuleBox[{$CellContext`p$$ = {-0.93, 
      0.55}, $CellContext`u$$ = {-1.218, -0.31000000000000005`}, \
$CellContext`v$$ = {1, 0.75}, Typeset`show$$ = True, 
      Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
      Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
      "\"untitled\"", Typeset`specs$$ = {{{
         Hold[$CellContext`u$$], {-1, -0.5}}, {-1.8, -1.8}, {1.8, 1.8}}, {{
         Hold[$CellContext`v$$], {1, 0.75}}, {-1.8, -1.8}, {1.8, 1.8}}, {{
         Hold[$CellContext`p$$], {-0.75, 0.6}}, {-1.8, -1.8}, {1.8, 1.8}}}, 
      Typeset`size$$ = {540., {268., 277.}}, Typeset`update$$ = 0, 
      Typeset`initDone$$, Typeset`skipInitDone$$ = 
      True, $CellContext`u$813$$ = {0, 0}, $CellContext`v$814$$ = {0, 
      0}, $CellContext`p$815$$ = {0, 0}}, 
      DynamicBox[Manipulate`ManipulateBoxes[
       1, TraditionalForm, 
        "Variables" :> {$CellContext`p$$ = {-0.75, 
           0.6}, $CellContext`u$$ = {-1, -0.5}, $CellContext`v$$ = {1, 0.75}},
         "ControllerVariables" :> {
          Hold[$CellContext`u$$, $CellContext`u$813$$, {0, 0}], 
          Hold[$CellContext`v$$, $CellContext`v$814$$, {0, 0}], 
          Hold[$CellContext`p$$, $CellContext`p$815$$, {0, 0}]}, 
        "OtherVariables" :> {
         Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
          Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
          Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
          Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> 
        Module[{$CellContext`q$, $CellContext`t$, $CellContext`cpp$ = 
           Function[{$CellContext`uz, $CellContext`vz, $CellContext`pz}, 
             If[$CellContext`vz != $CellContext`uz, 
              
              With[{$CellContext`tz = 
                Dot[$CellContext`pz - $CellContext`uz, $CellContext`vz - \
$CellContext`uz]/
                 Dot[$CellContext`vz - $CellContext`uz, $CellContext`vz - \
$CellContext`uz]}, {$CellContext`uz + $CellContext`tz ($CellContext`vz - \
$CellContext`uz), $CellContext`tz}], {$CellContext`uz, 
               0}]]}, {$CellContext`q$, $CellContext`t$} = \
$CellContext`cpp$[$CellContext`u$$, $CellContext`v$$, $CellContext`p$$]; Show[
            
            ListLinePlot[{$CellContext`u$$ - 
              10 ($CellContext`v$$ - $CellContext`u$$), $CellContext`v$$ + 
              10 ($CellContext`v$$ - $CellContext`u$$)}, 
             PlotRange -> {{-2, 2}, {-2, 2}}, AspectRatio -> 1], 
            ListLinePlot[{$CellContext`q$, $CellContext`p$$}], 
            Graphics[{
              Arrow[{$CellContext`u$$, $CellContext`v$$}], 
              Text["u", $CellContext`u$$ + {0, 0.15}], 
              Text["p", $CellContext`p$$ + {0, 0.15}], 
              Text["v", $CellContext`v$$ + {0, 0.15}], 
              Text["q", $CellContext`q$ + {0, 0.15}], 
              Text[
               StringJoin["vu slope: ", 
                If[
                Part[$CellContext`v$$, 1] - Part[$CellContext`u$$, 1] == 0, 
                 "Infinity", 
                 
                 ToString[(Part[$CellContext`v$$, 2] - 
                   Part[$CellContext`u$$, 2])/(Part[$CellContext`v$$, 1] - 
                  Part[$CellContext`u$$, 1])]]], {-1.25, 1.9}], 
              Text[
               StringJoin["qu slope: ", 
                If[
                Part[$CellContext`q$, 1] - Part[$CellContext`u$$, 1] == 0, 
                 "Infinity", 
                 
                 ToString[(Part[$CellContext`q$, 2] - 
                   Part[$CellContext`u$$, 2])/(Part[$CellContext`q$, 1] - 
                  Part[$CellContext`u$$, 1])]]], {-1.25, 1.8}], 
              Text[
               StringJoin["t: ", 
                ToString[$CellContext`t$]], {-1.25, 1.7}], Red, 
              Disk[$CellContext`q$, 0.06], 
              Arrow[{$CellContext`u$$, $CellContext`q$}], Blue, 
              Arrow[{$CellContext`u$$, $CellContext`p$$}]}]]], 
        "Specifications" :> {{{$CellContext`u$$, {-1, -0.5}}, {-1.8, -1.8}, {
           1.8, 1.8}, ControlType -> 
           Locator}, {{$CellContext`v$$, {1, 0.75}}, {-1.8, -1.8}, {1.8, 1.8},
            ControlType -> 
           Locator}, {{$CellContext`p$$, {-0.75, 0.6}}, {-1.8, -1.8}, {1.8, 
           1.8}, ControlType -> Locator}}, "Options" :> {}, 
        "DefaultOptions" :> {}],
       ImageSizeCache->{620., {316., 325.}},
       SingleEvaluation->True],
      Deinitialization:>None,
      DynamicModuleValues:>{},
      SynchronousInitialization->True,
      UnsavedVariables:>{Typeset`initDone$$},
      UntrackedVariables:>{Typeset`size$$}], "Manipulate",
     Deployed->True,
     StripOnInput->False],
    TraditionalForm],
   Manipulate`InterpretManipulate[1]], TraditionalForm]], "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
},
WindowSize->{942, 935},
PrintingCopies->1,
PrintingPageRange->{32000, 32000},
PrintingOptions->{"Magnification"->1.,
"PaperOrientation"->"Portrait",
"PaperSize"->{612, 792}},
ShowCellBracket->False,
Deployed->True,
CellContext->Notebook,
TrackCellChangeTimes->False,
FrontEndVersion->"8.0 for Microsoft Windows (64-bit) (October 6, 2011)",
StyleDefinitions->"Default.nb"
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
Cell[1257, 32, 45, 0, 123, "Title"],
Cell[1305, 34, 49, 3, 66, "Text"],
Cell[1357, 39, 759, 13, 164, "Text"],
Cell[2119, 54, 31, 0, 41, "Text"],
Cell[2153, 56, 647, 27, 66, "Text"],
Cell[2803, 85, 1149, 39, 117, "Text"],
Cell[CellGroupData[{
Cell[3977, 128, 5060, 136, 730, "Input"],
Cell[9040, 266, 3280, 66, 665, "Output"]
}, Open  ]],
Cell[12335, 335, 707, 16, 115, "Text"],
Cell[13045, 353, 2166, 87, 139, "Text"],
Cell[15214, 442, 535, 18, 90, "Text"],
Cell[15752, 462, 1415, 48, 115, "Text"],
Cell[17170, 512, 260, 10, 41, "Text"],
Cell[17433, 524, 202, 6, 41, "Text"],
Cell[17638, 532, 185, 4, 41, "Text"],
Cell[17826, 538, 894, 32, 41, "Text"],
Cell[18723, 572, 131, 3, 41, "Text"],
Cell[CellGroupData[{
Cell[18879, 579, 574, 19, 71, "Input"],
Cell[19456, 600, 479, 17, 42, "Output"]
}, Open  ]],
Cell[19950, 620, 189, 4, 66, "Text"],
Cell[20142, 626, 36, 0, 41, "Text"],
Cell[20181, 628, 674, 21, 41, "Text"],
Cell[20858, 651, 548, 18, 90, "Text"],
Cell[21409, 671, 284, 9, 56, "Text"],
Cell[21696, 682, 36, 0, 41, "Text"],
Cell[21735, 684, 835, 26, 56, "Text"],
Cell[22573, 712, 677, 24, 66, "Text"],
Cell[23253, 738, 493, 16, 57, "Text"],
Cell[23749, 756, 612, 22, 66, "Text"],
Cell[24364, 780, 246, 8, 41, "Text"],
Cell[24613, 790, 406, 14, 66, "Text"],
Cell[25022, 806, 53, 0, 41, "Text"],
Cell[25078, 808, 1390, 42, 323, "Input"],
Cell[26471, 852, 465, 13, 90, "Text"],
Cell[CellGroupData[{
Cell[26961, 869, 73, 0, 105, "Section"],
Cell[CellGroupData[{
Cell[27059, 873, 9960, 247, 1372, "Input"],
Cell[37022, 1122, 4837, 96, 665, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature xuT50OAaIPMtsDgFaRFNkiWx *)
