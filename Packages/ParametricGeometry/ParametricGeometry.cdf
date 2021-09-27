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
NotebookDataLength[    315168,       6313]
NotebookOptionsPosition[    310283,       6152]
NotebookOutlinePosition[    311026,       6179]
CellTagsIndexPosition[    310946,       6174]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["Colinear Point and Parameter", "Title",
 CellChangeTimes->{{3.5357225299617205`*^9, 3.5357225345140843`*^9}}],

Cell["An Executable Specification", "Subtitle",
 CellChangeTimes->{{3.535815107557084*^9, 3.5358151127850842`*^9}}],

Cell["\<\
Brian Beckman
Draft of 22 Jan 2012\
\>", "Subsubtitle",
 CellChangeTimes->{{3.535723074058739*^9, 3.5357230806827793`*^9}, {
  3.536270689345377*^9, 3.5362706895193944`*^9}, {3.5362710205614953`*^9, 
  3.536271023040743*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.535722545707987*^9, 3.535722672592108*^9}, {
  3.5357227832214527`*^9, 3.5357228301677294`*^9}, {3.5357230839565325`*^9, 
  3.5357231448988867`*^9}, {3.5357256426758575`*^9, 3.535725687172307*^9}}],

Cell["More precisely:", "Text",
 CellChangeTimes->{{3.535722545707987*^9, 3.535722672592108*^9}, {
  3.5357227832214527`*^9, 3.535722824967301*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.5357204182241993`*^9, 3.5357206804781914`*^9}, 
   3.5357223179881363`*^9, {3.5357226896984816`*^9, 3.535722700969864*^9}, {
   3.5357227423261895`*^9, 3.535722750614857*^9}, 3.5357228444668574`*^9, {
   3.5357232128438244`*^9, 3.5357232135688753`*^9}}],

Cell["\<\
(As an aside, we note that this is a primitive in the Gram-Schmidt \
orthonormalization process http://en.wikipedia.org/wiki/Gram-Schmidt_process)\
\>", "Text",
 CellChangeTimes->{{3.536270789676409*^9, 3.536270809981439*^9}, {
  3.536270971766616*^9, 3.5362710022096605`*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.5357204182241993`*^9, 3.5357206804781914`*^9}, 
   3.5357223179881363`*^9, {3.5357226896984816`*^9, 3.535722700969864*^9}, {
   3.5357227423261895`*^9, 3.535722750614857*^9}, 3.5357228444668574`*^9, {
   3.535723752128996*^9, 3.5357238073339176`*^9}, {3.5357241509894466`*^9, 
   3.535724161259773*^9}, {3.5357310492713456`*^9, 3.5357311046382675`*^9}}],

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
      RowBox[{"Show", "[", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"ListLinePlot", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"u", "-", 
             RowBox[{"100", 
              RowBox[{"(", 
               RowBox[{"v", "-", "u"}], ")"}]}]}], ",", 
            RowBox[{"v", "+", 
             RowBox[{"100", 
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
     "\[IndentingNewLine]", "]"}]}], "]"}]}]], "Input",
 CellChangeTimes->{{3.5357223542140875`*^9, 3.5357224769579296`*^9}, {
  3.535722703796095*^9, 3.535722737012769*^9}, {3.53572318420303*^9, 
  3.535723195735459*^9}, {3.5357310123134017`*^9, 3.535731015216631*^9}, {
  3.5358142155823526`*^9, 3.535814216117406*^9}, {3.536270737522194*^9, 
  3.536270738874329*^9}}],

Cell[BoxData[
 FormBox[
  TagBox[
   FormBox[
    StyleBox[
     DynamicModuleBox[{$CellContext`p$$ = {-0.75, 
      0.6}, $CellContext`u$$ = {-1, -0.5}, $CellContext`v$$ = {
      0.5679999999999998, 0.3600000000000001}, Typeset`show$$ = True, 
      Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
      Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
      "\"untitled\"", Typeset`specs$$ = {{{
         Hold[$CellContext`u$$], {-1, -0.5}}, {-1.8, -1.8}, {1.8, 1.8}}, {{
         Hold[$CellContext`v$$], {1, 0.75}}, {-1.8, -1.8}, {1.8, 1.8}}, {{
         Hold[$CellContext`p$$], {-0.75, 0.6}}, {-1.8, -1.8}, {1.8, 1.8}}}, 
      Typeset`size$$ = {540., {268., 277.}}, Typeset`update$$ = 0, 
      Typeset`initDone$$, Typeset`skipInitDone$$ = 
      True, $CellContext`u$972$$ = {0, 0}, $CellContext`v$973$$ = {0, 
      0}, $CellContext`p$974$$ = {0, 0}}, 
      DynamicBox[Manipulate`ManipulateBoxes[
       1, TraditionalForm, 
        "Variables" :> {$CellContext`p$$ = {-0.75, 
           0.6}, $CellContext`u$$ = {-1, -0.5}, $CellContext`v$$ = {1, 0.75}},
         "ControllerVariables" :> {
          Hold[$CellContext`u$$, $CellContext`u$972$$, {0, 0}], 
          Hold[$CellContext`v$$, $CellContext`v$973$$, {0, 0}], 
          Hold[$CellContext`p$$, $CellContext`p$974$$, {0, 0}]}, 
        "OtherVariables" :> {
         Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
          Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
          Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
          Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> Show[
          
          ListLinePlot[{$CellContext`u$$ - 
            100 ($CellContext`v$$ - $CellContext`u$$), $CellContext`v$$ + 
            100 ($CellContext`v$$ - $CellContext`u$$)}, 
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
   Manipulate`InterpretManipulate[1]], TraditionalForm]], "Output",
 CellChangeTimes->{{3.5357224010233355`*^9, 3.5357224291425962`*^9}, {
   3.5357224779519987`*^9, 3.535722488068821*^9}, 3.5357227617072296`*^9, 
   3.5357231977086143`*^9, 3.535723242849722*^9, {3.5357291084059315`*^9, 
   3.5357291164185658`*^9}, 3.535730112343793*^9, 3.535730434641094*^9, 
   3.535730896339591*^9, 3.5357309657541466`*^9, 3.5357313523346534`*^9, 
   3.5357313840991926`*^9, 3.53573151550669*^9, 3.53573206957353*^9, 
   3.535732304832054*^9, 3.5357332179753113`*^9, 3.5357333516990304`*^9, 
   3.535733876310527*^9, 3.5357339440064545`*^9, 3.5357341009665155`*^9, 
   3.5357341438114433`*^9, 3.535734411996972*^9, 3.5358140970885043`*^9, {
   3.535814311148908*^9, 3.535814339847778*^9}, 3.535814442298022*^9, 
   3.535814926563084*^9, 3.535826475417286*^9, 3.535827673584569*^9, 
   3.5358395391840305`*^9, 3.5359990650635824`*^9, 3.53599918835091*^9, 
   3.5360142327320023`*^9, 3.536014878531337*^9, 3.5360254419068613`*^9, {
   3.536028948675437*^9, 3.536028955269814*^9}, {3.5362707295743995`*^9, 
   3.536270740253467*^9}}]
}, {2}]],

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
}], "Text",
 CellChangeTimes->{{3.5357204182241993`*^9, 3.535720608442927*^9}, {
  3.535722771005476*^9, 3.5357227777180247`*^9}, {3.535722864650974*^9, 
  3.5357229541731377`*^9}, {3.5357230092230406`*^9, 3.5357230557052402`*^9}, {
  3.5357233074293947`*^9, 3.535723396048482*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.5357204182241993`*^9, 3.535720608442927*^9}, {
  3.535722771005476*^9, 3.5357227777180247`*^9}, {3.535722864650974*^9, 
  3.5357229541731377`*^9}, {3.5357230092230406`*^9, 3.5357230557052402`*^9}, {
  3.5357233074293947`*^9, 3.535723570352924*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.5357235942418528`*^9, 3.535723738763425*^9}, {
  3.5357238284396095`*^9, 3.535723891956688*^9}, {3.5357239515824327`*^9, 
  3.53572408663978*^9}, {3.5357263403736205`*^9, 3.535726342076791*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.5357235942418528`*^9, 3.535723738763425*^9}, {
   3.5357238284396095`*^9, 3.535723891956688*^9}, {3.5357239515824327`*^9, 
   3.535724132137412*^9}, 3.535724183739562*^9, {3.5357255846390543`*^9, 
   3.535725595136104*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.5357235942418528`*^9, 3.535723738763425*^9}, {
  3.5357238284396095`*^9, 3.535723891956688*^9}, {3.5357239515824327`*^9, 
  3.535724132137412*^9}, {3.535724183739562*^9, 3.535724230566326*^9}}],

Cell[TextData[Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"(", 
    RowBox[{"p", "-", "u"}], ")"}], "\[CenterDot]", 
   RowBox[{"(", 
    RowBox[{"v", "-", "u"}], ")"}]}], TraditionalForm]]]], "Text",
 CellChangeTimes->{{3.5357235942418528`*^9, 3.535723738763425*^9}, {
  3.5357238284396095`*^9, 3.535723891956688*^9}, {3.5357239515824327`*^9, 
  3.535724132137412*^9}, {3.535724183739562*^9, 3.535724250503415*^9}, {
  3.5357248545974755`*^9, 3.5357248570776625`*^9}}],

Cell["\<\
where the \[OpenCurlyDoubleQuote]dot product\[CloseCurlyDoubleQuote] is the \
usual Euclidean inner product (later, we generalize this to the Haversin \
metric):\
\>", "Text",
 CellChangeTimes->{{3.5357248626961036`*^9, 3.5357248930415816`*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.5357249002396717`*^9, 3.5357250283088846`*^9}, 
   3.5357254548000717`*^9}],

Cell["\<\
Considering our points in three dimensions, then, we can have Mathematica \
calculate this for us prettily:\
\>", "Text",
 CellChangeTimes->{{3.5357249002396717`*^9, 3.5357250283088846`*^9}, {
  3.5357254548000717`*^9, 3.53572548488908*^9}}],

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
     RowBox[{"v", "-", "u"}], ")"}]}]}], "]"}]], "Input",
 CellChangeTimes->{{3.5357254871023016`*^9, 3.5357255352531166`*^9}, 
   3.535725766105199*^9}],

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
     RowBox[{"v3", "-", "u3"}], ")"}]}]}], TraditionalForm]], "Output",
 CellChangeTimes->{
  3.5357255362382145`*^9, 3.5357257681154003`*^9, {3.5357291085209365`*^9, 
   3.535729116531577*^9}, 3.535730112473806*^9, 3.5357304347531056`*^9, 
   3.535730896447095*^9, 3.535730965871651*^9, 3.5357313524466586`*^9, 
   3.535731384254199*^9, 3.5357315156217017`*^9, 3.535732069708544*^9, 
   3.5357323049490657`*^9, 3.5357332180853224`*^9, 3.5357333517970357`*^9, 
   3.535733876415531*^9, 3.5357339441139593`*^9, 3.535734101079527*^9, 
   3.5357341439234543`*^9, 3.5357344121009827`*^9, 3.535814097432539*^9, {
   3.535814311438937*^9, 3.535814340123805*^9}, 3.5358144425770493`*^9, 
   3.535814926852084*^9, 3.5358264755922956`*^9, 3.5358276736985755`*^9, 
   3.53583953930103*^9, 3.5359990651595917`*^9, 3.535999188432918*^9, 
   3.536014233007018*^9, 3.5360148789223595`*^9, 3.536025442178877*^9, {
   3.536028948887449*^9, 3.536028955515828*^9}, 3.536270729727415*^9}]
}, Open  ]],

Cell["\<\
A Euclidean inner product like this is an essential part of vector classes in \
C# (not sure if our VETS library has this. Exercise: check and put it in \
otherwise.\
\>", "Text",
 CellChangeTimes->{{3.53572554938853*^9, 3.535725617127303*^9}}],

Cell["In Euclidean space, ", "Text",
 CellChangeTimes->{{3.5357258416837564`*^9, 3.5357258467552633`*^9}}],

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
  TraditionalForm]]]], "Text",
 CellChangeTimes->{{3.535726407326315*^9, 3.5357264713267145`*^9}, {
  3.535726677889368*^9, 3.5357266809696765`*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.535726510797661*^9, 3.53572664150173*^9}}],

Cell[TextData[Cell[BoxData[
 FormBox[
  RowBox[{"t", "=", 
   RowBox[{
    FractionBox[
     RowBox[{"||", 
      RowBox[{"p", "-", "u"}], "||"}], 
     RowBox[{"||", 
      RowBox[{"v", "-", "u"}], "||"}]], 
    RowBox[{"cos", "(", "\[Theta]", ")"}]}]}], TraditionalForm]]]], "Text",
 CellChangeTimes->{{3.5357266521857986`*^9, 3.53572669110569*^9}, {
  3.535726836658244*^9, 3.53572683792137*^9}}],

Cell["we immediately write", "Text",
 CellChangeTimes->{{3.535726510797661*^9, 3.5357266333629165`*^9}, {
  3.5357267600895877`*^9, 3.5357267698415627`*^9}}],

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
     RowBox[{"\[NotEqual]", " ", "0"}]}]}]}], TraditionalForm]]]], "Text",
 CellChangeTimes->{{3.535726510797661*^9, 3.5357266333629165`*^9}, {
  3.5357267600895877`*^9, 3.535726886447222*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.535726510797661*^9, 3.5357266333629165`*^9}, {
  3.5357267600895877`*^9, 3.535726933419919*^9}, {3.535726991925769*^9, 
  3.5357270258791637`*^9}}],

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
    "u"}]}], TraditionalForm]]]], "Text",
 CellChangeTimes->{{3.5357269449130683`*^9, 3.535726985321109*^9}}],

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
}], "Text",
 CellChangeTimes->{{3.535727478372114*^9, 3.535727515037546*^9}, {
  3.5357278317949467`*^9, 3.535727864816079*^9}, {3.535727900350422*^9, 
  3.5357279032311673`*^9}}],

Cell[TextData[Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"q", "-", "u"}], "=", 
   RowBox[{
    RowBox[{"t", "\[Times]", 
     RowBox[{"(", 
      RowBox[{"v", "-", "u"}], ")"}]}], "\[DoubleLeftRightArrow]"}]}], 
  TraditionalForm]]]], "Text",
 CellChangeTimes->{{3.535727907792032*^9, 3.535727968373404*^9}, 
   3.5357286393285065`*^9}],

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
}], "Text",
 CellChangeTimes->{{3.5357271503666115`*^9, 3.535727157413316*^9}, {
   3.535727275810887*^9, 3.535727345069435*^9}, 3.535727471412569*^9}],

Cell["In two dimensions, then, we may write", "Text",
 CellChangeTimes->{{3.5357271503666115`*^9, 3.535727157413316*^9}, {
   3.535727275810887*^9, 3.535727345069435*^9}, 3.535727471412569*^9}],

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
     RowBox[{"u", ",", "0"}], "}"}]}], "]"}]}]], "Input",
 CellChangeTimes->{{3.533415563780443*^9, 3.533415588843443*^9}, {
   3.535720343656701*^9, 3.535720393861253*^9}, {3.5357270478283587`*^9, 
   3.5357271188254576`*^9}, 3.5357272968015876`*^9}],

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
}], "Text",
 CellChangeTimes->{{3.535727350933399*^9, 3.535727389810532*^9}, {
  3.535731118055834*^9, 3.53573112956226*^9}}],

Cell[CellGroupData[{

Cell["Interactive Visualization: Colinear Point and Parameter", "Section",
 CellChangeTimes->{{3.533419728421443*^9, 3.5334197395504427`*^9}, {
   3.535731134293131*^9, 3.535731141803734*^9}, 3.5358143774675393`*^9}],

Cell[TextData[{
 "Just as with the prior interactive diagram -- drag the points ",
 Cell[BoxData[
  FormBox[
   FormBox["u",
    TraditionalForm], TraditionalForm]],
  FormatType->"TraditionalForm"],
 ", ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]],
  FormatType->"TraditionalForm"],
 ", and ",
 Cell[BoxData[
  FormBox[
   FormBox["p",
    TraditionalForm], TraditionalForm]],
  FormatType->"TraditionalForm"],
 " around the diagram and watch the changes:"
}], "Text",
 CellChangeTimes->{{3.5360273321799784`*^9, 3.536027482225561*^9}, {
  3.5360275225538673`*^9, 3.5360275268471127`*^9}}],

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
         RowBox[{"q", ",", "t"}], "}"}], ",", "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{
          RowBox[{"{", 
           RowBox[{"q", ",", "t"}], "}"}], "=", 
          RowBox[{"colinearPointAndParameter", "[", 
           RowBox[{"u", ",", "v", ",", "p"}], "]"}]}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Show", "[", 
          RowBox[{
           RowBox[{"ListLinePlot", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{
               RowBox[{"u", "-", 
                RowBox[{"100", 
                 RowBox[{"(", 
                  RowBox[{"v", "-", "u"}], ")"}]}]}], ",", 
               RowBox[{"v", "+", 
                RowBox[{"100", 
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
        "lowLim", ",", "hiLim", ",", "Locator"}], "}"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"SaveDefinitions", "\[Rule]", "True"}]}], "\[IndentingNewLine]",
      "]"}]}], "]"}]}]], "Input",
 CellChangeTimes->{{3.533415647146443*^9, 3.533415673545443*^9}, 
   3.533415767720443*^9, {3.5357207143144016`*^9, 3.5357207266909018`*^9}, {
   3.5357222305046587`*^9, 3.5357222681661596`*^9}, {3.5357232609341936`*^9, 
   3.535723276696947*^9}, 3.5357274310028667`*^9, {3.5357296869291987`*^9, 
   3.535729687422248*^9}, {3.5357301788216033`*^9, 3.535730212223269*^9}, {
   3.53573024824116*^9, 3.53573029020156*^9}, 3.535730333774029*^9, 
   3.5357304311238174`*^9, {3.5357307702239933`*^9, 3.53573082208716*^9}, {
   3.535730940693618*^9, 3.535730959403617*^9}, {3.5357309934998875`*^9, 
   3.535730999429858*^9}, {3.5357312995613794`*^9, 3.5357313374329023`*^9}, {
   3.5357313778272*^9, 3.5357313781397123`*^9}, {3.5357314847392254`*^9, 
   3.5357315076660585`*^9}, {3.535731769425067*^9, 3.535731772625826*^9}, {
   3.535732160295602*^9, 3.5357321982874002`*^9}, {3.5357323524848185`*^9, 
   3.535732374934064*^9}, {3.535732591663378*^9, 3.5357326013673477`*^9}, {
   3.535732826899372*^9, 3.5357328432936754`*^9}, {3.535733197332158*^9, 
   3.535733197810193*^9}, {3.535733274998351*^9, 3.5357333026070614`*^9}, {
   3.535733333993623*^9, 3.535733341077183*^9}, {3.535733750277928*^9, 
   3.5357338586085577`*^9}, {3.5357339325520267`*^9, 
   3.5357339389335423`*^9}, {3.5357339864223433`*^9, 
   3.5357339938464327`*^9}, {3.535734025097915*^9, 3.5357340849747534`*^9}, {
   3.535734136483864*^9, 3.53573416316601*^9}, 3.5357342971107554`*^9, {
   3.535734328678274*^9, 3.535734407361552*^9}, {3.5358140681766133`*^9, 
   3.5358140904388394`*^9}, {3.535814255193313*^9, 3.5358143005568495`*^9}, {
   3.5358143309748907`*^9, 3.5358143376145544`*^9}, {3.5362710389263315`*^9, 
   3.5362710418846273`*^9}}],

Cell[BoxData[
 FormBox[
  TagBox[
   FormBox[
    StyleBox[
     DynamicModuleBox[{$CellContext`p$$ = {-0.75, 
      0.6}, $CellContext`u$$ = {-1, -0.5}, $CellContext`v$$ = {0.978, 0.845}, 
      Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
      Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ =
       1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{{
         Hold[$CellContext`u$$], {-1, -0.5}}, {-1.8, -1.8}, {1.8, 1.8}}, {{
         Hold[$CellContext`v$$], {1, 0.75}}, {-1.8, -1.8}, {1.8, 1.8}}, {{
         Hold[$CellContext`p$$], {-0.75, 0.6}}, {-1.8, -1.8}, {1.8, 1.8}}}, 
      Typeset`size$$ = {540., {268., 277.}}, Typeset`update$$ = 0, 
      Typeset`initDone$$, Typeset`skipInitDone$$ = 
      False, $CellContext`u$1606$$ = {0, 0}, $CellContext`v$1607$$ = {0, 
      0}, $CellContext`p$1608$$ = {0, 0}}, 
      DynamicBox[Manipulate`ManipulateBoxes[
       1, TraditionalForm, 
        "Variables" :> {$CellContext`p$$ = {-0.75, 
           0.6}, $CellContext`u$$ = {-1, -0.5}, $CellContext`v$$ = {1, 0.75}},
         "ControllerVariables" :> {
          Hold[$CellContext`u$$, $CellContext`u$1606$$, {0, 0}], 
          Hold[$CellContext`v$$, $CellContext`v$1607$$, {0, 0}], 
          Hold[$CellContext`p$$, $CellContext`p$1608$$, {0, 0}]}, 
        "OtherVariables" :> {
         Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
          Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
          Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
          Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> 
        Module[{$CellContext`q$, $CellContext`t$}, {$CellContext`q$, \
$CellContext`t$} = $CellContext`colinearPointAndParameter[$CellContext`u$$, \
$CellContext`v$$, $CellContext`p$$]; Show[
            
            ListLinePlot[{$CellContext`u$$ - 
              100 ($CellContext`v$$ - $CellContext`u$$), $CellContext`v$$ + 
              100 ($CellContext`v$$ - $CellContext`u$$)}, 
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
      Initialization:>({$CellContext`q[{
            Pattern[$CellContext`lon1, 
             Blank[]], 
            Pattern[$CellContext`lat1, 
             Blank[]]}, {
            Pattern[$CellContext`lon2, 
             Blank[]], 
            Pattern[$CellContext`lat2, 
             
             Blank[]]}] := $CellContext`h[$CellContext`lat2 - \
$CellContext`lat1] + (Cos[($CellContext`lat1 Pi)/180.] 
            Cos[($CellContext`lat2 Pi)/
              180.]) $CellContext`h[$CellContext`lon2 - $CellContext`lon1], \
$CellContext`h[
           Pattern[$CellContext`angleDegrees, 
            Blank[]]] := 
         Sin[($CellContext`angleDegrees Pi)/(180. 
            2)]^2, $CellContext`colinearPointAndParameter[
           Pattern[$CellContext`u, {
             Pattern[$CellContext`u1, 
              Blank[]], 
             Pattern[$CellContext`u2, 
              Blank[]]}], 
           Pattern[$CellContext`v, {
             Pattern[$CellContext`v1, 
              Blank[]], 
             Pattern[$CellContext`v2, 
              Blank[]]}], 
           Pattern[$CellContext`p, {
             Pattern[$CellContext`p1, 
              Blank[]], 
             Pattern[$CellContext`p2, 
              Blank[]]}]] := If[$CellContext`v != $CellContext`u, 
           
           With[{$CellContext`t = 
             Dot[$CellContext`p - $CellContext`u, $CellContext`v - \
$CellContext`u]/
              Dot[$CellContext`v - $CellContext`u, $CellContext`v - \
$CellContext`u]}, {$CellContext`u + $CellContext`t ($CellContext`v - \
$CellContext`u), $CellContext`t}], {$CellContext`u, 0}]}; 
       Typeset`initDone$$ = True),
      SynchronousInitialization->True,
      UnsavedVariables:>{Typeset`initDone$$},
      UntrackedVariables:>{Typeset`size$$}], "Manipulate",
     Deployed->True,
     StripOnInput->False],
    TraditionalForm],
   Manipulate`InterpretManipulate[1]], TraditionalForm]], "Output",
 CellChangeTimes->{
  3.5357321997095428`*^9, 3.53573230499107*^9, 3.535732604071618*^9, 
   3.5357328448763027`*^9, 3.5357332181643305`*^9, {3.5357333423542943`*^9, 
   3.5357333518330393`*^9}, {3.535733731351903*^9, 3.535733774712372*^9}, 
   3.5357338283756466`*^9, {3.5357338603697033`*^9, 3.535733876450533*^9}, 
   3.535733944193962*^9, 3.5357340419902678`*^9, {3.5357340868693933`*^9, 
   3.5357341011235313`*^9}, {3.535734143963458*^9, 3.535734172314741*^9}, 
   3.535734373326825*^9, 3.5357344121429873`*^9, {3.5358140919339886`*^9, 
   3.5358140976265583`*^9}, {3.5358143115719504`*^9, 3.5358143402178144`*^9}, 
   3.5358144426730595`*^9, 3.535814926971084*^9, 3.5358264756933017`*^9, 
   3.5358276737615795`*^9, 3.5358395393560305`*^9, 3.5359990652085967`*^9, 
   3.535999188479923*^9, 3.536014233088023*^9, 3.5360148790333652`*^9, 
   3.5360254422988834`*^9, {3.536028949027457*^9, 3.536028955633835*^9}, 
   3.536270729765418*^9, 3.536271042723711*^9}]
}, {2}]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Converting Lon and Lat to Metrical Coordinates", "Section",
 CellChangeTimes->{{3.535806094514991*^9, 3.535806106884517*^9}}],

Cell[TextData[{
 "Most of our data is stored and transferred in the form of \
longitude-latitude pairs in decimal degrees, written ",
 Cell[BoxData[
  FormBox[
   RowBox[{"{", 
    RowBox[{"lon", ",", "lat"}], "}"}], TraditionalForm]]],
 " in ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " (curly braces enclose sequences a.k.a. lists a.k.a. arrays -- ordered \
collections with duplicates allowed -- in ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 "). The reason to place longitude first is that it naturally maps to the ",
 Cell[BoxData[
  FormBox["x", TraditionalForm]]],
 " coordinate in displays, and display coordinates are almost always written \
in the order ",
 Cell[BoxData[
  FormBox[
   RowBox[{"{", 
    RowBox[{"x", ",", "y"}], "}"}], TraditionalForm]]],
 ". "
}], "Text",
 CellChangeTimes->{{3.535806432413909*^9, 3.5358065793802967`*^9}, 
   3.5358068879981503`*^9, {3.5358086420657578`*^9, 3.535808657592758*^9}}],

Cell["\<\
Lon-lat pairs are suitable for display, so our storage forms and transfer \
syntaxes. Most mapping displays use them (e.g. http://www.bing.com/maps/). \
However, they are not directly suitable for distance and heading \
calculations, in particular, not for colinearPointAndParameter. It can be \
tempting to try to calculate the distance between a pair of lon-lat points as \
follows:\
\>", "Text",
 CellChangeTimes->{{3.535806432413909*^9, 3.5358065793802967`*^9}, {
  3.5358068879981503`*^9, 3.5358069074761505`*^9}, {3.53580708276315*^9, 
  3.5358071025221505`*^9}, {3.5358072577231503`*^9, 3.5358073116801505`*^9}, {
  3.5358073646471505`*^9, 3.53580738949415*^9}, {3.5358086736317577`*^9, 
  3.5358086898077583`*^9}, {3.535810761852233*^9, 3.535810804225233*^9}, {
  3.5358266752154484`*^9, 3.5358266755483484`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"EuclideanDistance", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     SubscriptBox["lon", "1"], ",", 
     SubscriptBox["lat", "1"]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     SubscriptBox["lon", "2"], ",", 
     SubscriptBox["lat", "2"]}], "}"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.53580731994715*^9, 3.5358073495121503`*^9}, {
  3.5358073946461506`*^9, 3.5358074064701505`*^9}}],

Cell[BoxData[
 FormBox[
  SqrtBox[
   RowBox[{
    SuperscriptBox[
     TemplateBox[{RowBox[{
         SubscriptBox["lat", "1"], "-", 
         SubscriptBox["lat", "2"]}]},
      "Abs"], "2"], "+", 
    SuperscriptBox[
     TemplateBox[{RowBox[{
         SubscriptBox["lon", "1"], "-", 
         SubscriptBox["lon", "2"]}]},
      "Abs"], "2"]}]], TraditionalForm]], "Output",
 CellChangeTimes->{
  3.5358073505381503`*^9, 3.5358074084181504`*^9, 3.5358140978015757`*^9, {
   3.5358143118219757`*^9, 3.535814340382831*^9}, 3.535814442812073*^9, 
   3.5358149271310844`*^9, 3.5358264757933073`*^9, 3.5358276738355837`*^9, 
   3.53583953941603*^9, 3.535999065269603*^9, 3.53599918855293*^9, 
   3.5360142332400317`*^9, 3.5360148791603727`*^9, 3.5360254424178905`*^9, {
   3.5360289491404634`*^9, 3.536028955747841*^9}, 3.5362707298244247`*^9}]
}, Open  ]],

Cell["\<\
But, of course, this is basically meaningless because lon and lat are not \
coordinates in a Euclidean geometry! It\[CloseCurlyQuote]s merely an accident \
that lon-lats happen to be represented as pairs of floating-point numbers, \
just like Euclidean coordinates in 2-D space. Do not be fooled!\
\>", "Text",
 CellChangeTimes->{{3.5358074242341504`*^9, 3.5358074489851503`*^9}, {
  3.535810809153233*^9, 3.5358108593742332`*^9}, {3.53581121092942*^9, 
  3.5358112322965565`*^9}, {3.5358266844656725`*^9, 3.535826687655715*^9}}],

Cell["\<\
To do metrical (distance and heading) calculations, we have several choices: \
\>", "Text",
 CellChangeTimes->{{3.5358074894631505`*^9, 3.5358076629911504`*^9}, {
   3.5358265684326057`*^9, 3.535826605304428*^9}, 3.5358282280787134`*^9}],

Cell[CellGroupData[{

Cell["\<\
on the spheroid, that is, distances along curves on the Earth' s surface\
\>", "ItemNumbered",
 CellChangeTimes->{{3.5358310843864717`*^9, 3.5358310878368163`*^9}, {
  3.535831984865446*^9, 3.5358319857934465`*^9}},
 CellTags->"MetricalOptions"],

Cell["in Euclidean (flat) 3-dimensional space", "ItemNumbered",
 CellChangeTimes->{{3.5358074894631505`*^9, 3.5358076629911504`*^9}, {
  3.5358265684326057`*^9, 3.535826605304428*^9}, {3.5358282280787134`*^9, 
  3.5358282367529755`*^9}, {3.5358282976220026`*^9, 3.5358282987344465`*^9}, {
  3.5358297526673126`*^9, 3.535829755569603*^9}, {3.5358319874824467`*^9, 
  3.535831988337446*^9}},
 CellTags->"MetricalOptions"],

Cell["in the tangent plane at each point on the spheroid", "ItemNumbered",
 CellChangeTimes->{{3.5358074894631505`*^9, 3.5358076629911504`*^9}, {
  3.5358265684326057`*^9, 3.535826605304428*^9}, {3.5358282280787134`*^9, 
  3.535828263266398*^9}, {3.535828302285056*^9, 3.535828308763468*^9}, {
  3.5358319900734463`*^9, 3.5358319907374463`*^9}},
 CellTags->"MetricalOptions"]
}, Open  ]],

Cell["\<\
Calculations on the spheroid are based on spherical trigonometry, a special \
case of non-Euclidean geometry on curved spaces. Calculations in 3-D space \
are Euclidean and correspond to familiar vector analysis from physics and \
most engineering disciplines. Calculations\
\>", "Text",
 CellChangeTimes->{{3.5358074894631505`*^9, 3.5358076629911504`*^9}, {
  3.5358265684326057`*^9, 3.535826605304428*^9}, {3.5358282280787134`*^9, 
  3.5358282428008275`*^9}, {3.535828276506588*^9, 3.5358282851578197`*^9}}],

Cell[CellGroupData[{

Cell["Distances and Headings on the Spheroid", "Subsection",
 CellChangeTimes->{{3.535811118099138*^9, 3.5358111246117887`*^9}}],

Cell[CellGroupData[{

Cell["Distances", "Subsubsection",
 CellChangeTimes->{{3.535815146408084*^9, 3.535815147823084*^9}}],

Cell["\<\
First, define a pair of auxilliary functions:\
\>", "Text",
 CellChangeTimes->{{3.535814860755084*^9, 3.535814870705084*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"h", "[", "angleDegrees_", "]"}], ":=", 
  SuperscriptBox[
   RowBox[{"Sin", "[", 
    RowBox[{
     FractionBox[
      RowBox[{"angleDegrees", " ", "\[Pi]"}], "180.0"], "/", "2"}], "]"}], 
   "2"]}]], "Input",
 CellChangeTimes->{{3.5358148406190844`*^9, 3.5358148541200843`*^9}, {
  3.535814992279084*^9, 3.535814992516084*^9}}],

Cell["\<\
All angles are in decimal degrees, but sins and cosines require angles in \
radians. Just convert them in-line:\
\>", "Text",
 CellChangeTimes->{{3.535814978517084*^9, 3.535814985472084*^9}, {
  3.535815157417084*^9, 3.535815182657657*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"q", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"lon1_", ",", "lat1_"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"lon2_", ",", "lat2_"}], "}"}]}], "]"}], ":=", 
  "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"h", "[", 
    RowBox[{"lat2", "-", "lat1"}], "]"}], "+", 
   RowBox[{
    RowBox[{"Cos", "[", 
     FractionBox[
      RowBox[{"lat1", " ", "\[Pi]"}], "180.0"], "]"}], " ", 
    RowBox[{"Cos", "[", 
     FractionBox[
      RowBox[{"lat2", " ", "\[Pi]"}], "180.0"], "]"}], " ", 
    RowBox[{"h", "[", 
     RowBox[{"lon2", "-", "lon1"}], "]"}]}]}]}]], "Input",
 CellChangeTimes->{{3.535815000306084*^9, 3.5358150179800844`*^9}}],

Cell["\<\
Represent the Earth\[CloseCurlyQuote]s radius as a number times a symbolic \
unit (this is an example of a generic capability of Mathematica -- to \
simulate type-safe units and dimensions via mixed symbolic and numeric \
computations; of course, this is not available in ordinary programming \
languages like C# and JavaScript, but it is extremely useful in executable \
specifications like this one):\
\>", "Text",
 CellChangeTimes->{{3.5358148762190843`*^9, 3.535814900486084*^9}, {
  3.535815027062084*^9, 3.535815095380084*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"earthRadius", "=", 
   RowBox[{"6367500.0", " ", "meter"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.533327886759735*^9, 3.533327918993958*^9}, {
  3.535815022288084*^9, 3.5358150225110846`*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"EarthHaversinDistance", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"lon1_", ",", "lat1_"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"lon2_", ",", "lat2_"}], "}"}]}], "]"}], ":=", 
   "\[IndentingNewLine]", 
   RowBox[{"earthRadius", " ", "*", "\[IndentingNewLine]", "2", "*", 
    RowBox[{"ArcSin", "[", 
     SqrtBox[
      RowBox[{"q", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"lon1", ",", "lat1"}], "}"}], ",", 
        RowBox[{"{", 
         RowBox[{"lon2", ",", "lat2"}], "}"}]}], "]"}]], "]"}]}]}], 
  ";"}]], "Input",
 CellChangeTimes->{{3.533325108259617*^9, 3.533325157353526*^9}, {
  3.533325357607549*^9, 3.5333253621760063`*^9}, {3.533325434098198*^9, 
  3.5333254486786556`*^9}, {3.53332792361442*^9, 3.5333279316212206`*^9}, {
  3.5334106711994667`*^9, 3.5334106729884667`*^9}, {3.535814916194084*^9, 
  3.535814923662084*^9}}],

Cell["\<\
From the following plot, we can see that the distance for a given delta \
longitude in degrees is maximum at the equator and decreases with latitude \
because the lines of constant longitude -- the meridians -- squeeze together, \
that is, have less metrical distance between them, as we approach the poles. \
Notice that the symbolic constant \[OpenCurlyDoubleQuote]anyLon\
\[CloseCurlyDoubleQuote] just cancels out of the computation, constituting a \
proof that the numerical results do not depend on longitude.\
\>", "Text",
 CellChangeTimes->{{3.5358145423980308`*^9, 3.5358146193607264`*^9}, {
  3.535815193377729*^9, 3.5358151939827895`*^9}, {3.5359991688429594`*^9, 
  3.5359992217082453`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Plot3D", "[", 
  RowBox[{
   RowBox[{
    RowBox[{"EarthHaversinDistance", "[", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"anyLon", "+", "n"}], ",", "lat"}], "}"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{"anyLon", ",", "lat"}], "}"}]}], "]"}], "/", "meter"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{"n", ",", 
     RowBox[{"1", "/", "3600000."}], ",", 
     RowBox[{"1", "/", "3600."}]}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{"lat", ",", 
     RowBox[{"-", "85.0"}], ",", "85.0"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"AxesLabel", "\[Rule]", 
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
     "\"\<Delta-Lon (degrees)\>\"", ",", "\[IndentingNewLine]", 
      "\"\<Latitude (degrees)\>\"", ",", "\[IndentingNewLine]", 
      "\"\<Distance (meters)\>\""}], "}"}]}], ",", "\[IndentingNewLine]", 
   RowBox[{
   "PlotLabel", "\[Rule]", 
    "\"\<EarthHaversinDistance[{anyLon, lat},{anyLon+deltaLon, lat}]\>\""}]}],
   "]"}]], "Input",
 CellChangeTimes->{{3.535813841168915*^9, 3.5358139008018775`*^9}, {
  3.535814413727165*^9, 3.5358144168014727`*^9}, {3.5358144508738794`*^9, 
  3.5358145235861497`*^9}, {3.5358152028786793`*^9, 3.5358152620055914`*^9}}],

Cell[BoxData[
 FormBox[
  Graphics3DBox[GraphicsComplex3DBox[CompressedData["
1:eJx1nHk4Vd37xo9QQpmHZOaYyXRyDDkrRUkTlZQGaZI0qTRIExre3lJkaFbR
XJRGJYvmgYpmDdIcmqmU+r6/7OfZP4vz/vNe1+fa1+lxn+fc+1n3XmubhE8L
Gt9GIBAQeYFA9r//P/RXO7csK9n7/lG1kj+SIdToZMyCF4oTJKu/DdIP0ahD
Luw52Dag+rKk4XZJR5X3chLg/YNDw0WF9yX2h2aoRAepIH/cc1l6eEKVJPec
4orICk3kPx4/ibPZ+0bSJ3eEwuYOesh9Y9zGfS55L3mx+dCKEokR8qttewtH
zvssKey5OOGP2BT5ncBZukWr6iTKnnt76paZI7fdnKkk3PpdMsypTM5psiXy
ky+v/16R+1Oyy/LneX85G+QhDj8+1RT/lnwxME8M32KH/Hd+cvSedwJCNPv5
xnbtgrz7E6uohzPbED/5022uvnZE/lZQOF65UZZMXnwjPNjVmeemQ0Z7L5Mn
oHOAvYpPRdcgOr5COeXbjqWoM3DtK11ur1d7iToDV81p/7J/zVfUGfiXuT9H
lw/4gzoD/5wZU7v/gRwBnYFfTfhgM1VJkYDOwJ9MjIhw7KZCQGfgf7I+Bs1z
UyegM/B4rYMzht/UJKAz8IjESWs9J+kQ0Bl4xldhjn4bPQI6AxeMrSpp3KiP
OgP/9+bWmicuRqgz8PVbD8qHvTJGnYGPuq2UetPZFHWOC+g0dUpof7r6tEze
ydo1qDPwgnTtbQtjP6HOwK+ljn21doQMAZ2B93rqGRf+sz0BnYF31FRU1Oun
hjoDVxTH3Fm6WQt1Bh4XWpVZXd0JdQbuv7B/1GBPQ9QZuPXAx5tG+ZqgzsBp
WIqMxhQz1Bn4w+n+Ey+tF6LOwCcv/nM99owl6gx8bNIxZ8cX1qgz8KNbJme8
ULJDnYH332/yO8PFAXUe56UZYu7fmxpvrE7Vrl6POgNPTQ7p/j77G+oM3Pq0
nabugnaoM/C+aXfjNyeroc7Ac0vTGu0m6qDOwHe1HTqnwNMAdQauuG3Vd4sV
Jqgz8Kj8yaJp0eaoM/CpdwKiT4ywRJ2By3y0zfnjZ4M6A9dVVK7p5WSPOgMv
V4vRvNzBEXUG3t/wlXPNUifUGfgsm+BA1e/OqDNw0vXiNNcproxv+NBTj4ll
7rQNjG/40HfkTN6col+Mb/hQ+cIpgzLWKJPmvuFDMw8tnOAxSos09w0fuiDO
b6fVbH3GN3yorEW76UoXTRjf8KFaHSavWRooZHzDh778UnrgxyMrxjd8aORD
52vTI+wY3/Ch22na29dfujC+4UPdBzXG5xQ6Mb7hQz/4dtGYnOjC+MZ/ny8e
s8MiQMT4hg/dZZPiVKXqxviGD92sf4FuuStm+llMf7dNK3h9czPTz2J6ZNK6
ftf9BaR5P4tpZnn5+J92qkw/i+mAz0+yVEW6TD+L6RSFuk/JhsZMP4vplvT5
67aYmjP9LKaHLQROeyysmH7+7989lnjziI0d089i6rpD/uQoHUemn8U0ftLl
duM6OTP9LKbHHVcNndTZlelnMS391m/3VIOuTD+L6fmzqt9mGomZfhbTDYnl
fvNMPJh+FlO/vmlpC828UOexf7kV/R5a9FH+zVbUGXid35mOfnNlUGfg6YnX
FEYNU0OdgR94LVbcUN8JdQZeYV4u/87fBHVGfmflsuUZQtQZ+J1lpJ3wtTXq
DLzI7dvyYpED6gw86GuwnKOPE+oM/GzfI+cXTnJBnYEbZ3dILFkrQp2BxzVG
+OqfdEOdgd8acl5+8lN31Bm4ziGji6faeqHOwIe0jV2m4OCNOgv+/vfRa6Zg
zjndLdtQZ+DZ656aZj7hdQa+S09fUbaQ1xn43KjLbY6v0UOdgQtH58e55vA6
A1dZodrQQccCdQbekDsh5vVCG9QZ+IsHZz7TV7zOwCcsWenWbzevM/BHqUfr
3Ct4nYEP3Pc0z0KlK+oM/MJZxWiNHmLUGbhnuchRMMcDdQZ+6HXY+5p9vM7A
jX+tOvDgCa/zxCb9yTemn4Gz/Qw8jeln4PuZfgb+kOln4Gw/Ay9n+hl4IdPP
wAOZfgZewPQzcCOmn4EvYPoZ+A2mn4FrMf0MfDDTzxOa/ISw/gyc9WfgrD8D
Z/0ZOOvPwFl/Bs76M/67jD8DZ/0ZOOvPwFl/Bs76M3DWn4Gz/gyc9ee+TfdH
ws4bwNl5Azg7bwBn5w3g7LwBnJ03gLPzBnB23gDOzhvA2XkDODtvAGfnDfx8
Zt4Azs4bwNl5Y3zTvEeMmPkZeAozPwO3YuZn4H2Y+Rl4DjM/A89m5mfgCsz8
DDySmZ+BRzHzM3ABMz8D12bmZ+BlzPwMvC8zPwOfyczPwCXM/Lywaf1C2PUg
cHY9CJxdDwJn14PA2fUgcHY9CJxdDwJn14PA2fUgcHY9CJxdDwJn14PA2fUg
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
N/JtrcxPt0e/mOtFxLz1fiD7V3V0sTZwZH+PZJpVY6S7XYvfIzn+qtH4Vn17
9vdFpPy+SL+BGqK+QS1+X6R23Y/dXr6OrF8R1aUWjzz31LN+RWYMmaT1bF5b
1q/IlaOjDctuqLJ+RYSt+xXRqfjsIZzRwq8IHXVZLs2jhV8RtaotpW3lurB+
Tn6f2GZ5ZvJn1s/JQUcTi0bfNuz7u0iHxGixfrASux4ni2rGZBu4qLP+Txxa
93+iGuand/B4C/8nmXkPnxxtsGDX4+R222k7z3i3WI+TrGGyEeeX2rL3O3Ij
t3uIh0M1+/43smD35F4J9Q2YLwGX8ww9XGcjx+Yq5NV2gWTvQ0U2VyGmcoMm
OFxQZfpnAJFyPyXDTl2Jcks2ZHMVoiUq3aBQZ8zmKsR2tVtcXWaLXIW8eJEZ
VtW3Ra5Cunkp9rzxXci+V5BEtp6zEe9nZ9c/jv3I5mxkcvGwaSV7vrM5G0kM
bMh6EtkiZyPzinolBy9pkbORP46pi0rTFdj5hFTDfNI8ZyPb3v6yNN/TImcj
1dt2GobltcjZSNGQPlqbz7bI2Yi20iel+1d02ZyNVBWmt9G8o8fmbER7lveP
AZX6OHfBHHWDOa8N18Nz5/8BP/6DqQ==
    "], {{
      {EdgeForm[None], GraphicsGroup3DBox[{Polygon3DBox[CompressedData["
1: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
A1tS72s09zal3hNpTv6Sel+jGnFjtEZJtCZS77lUg/ak3oPMg7en3ltpTv6Y
+N6OSXzveoYd2f0fzN7B8GhNczRxjeq/rodXqq5KCqh+Je4vT7w9WleF6O/c
n43JF6l1xVH0r0qthaSJNMYaa+1//uXvesRaxA9Sz5/t2dw7kM0/5Te9N82v
tan3HcdG/86ebC7sy96d3u3G1NqmoGpQlrdVg45kOV81Yn1qLVRAz5LledXi
DdIg8HFwQbg13JTf3ZXlfNW1w1nOV23aDTfLua49EL0vPV71J/Vzqa79m+X/
spk26Q534ztTnqtTznXzEP0X5lxzy6Tuv0C6LqsXqnH7s/qi2ncgy+eq6VtT
1wXVx4ej98PFlTOy+qLaPSF6DyxdtC97LtXZGJzPpUmOCq4L0mYhuC6oRm9L
XWtU6/PBdUF6qaFyXM56r2JwzZKWm5vlhznEysH7Smm/8sG1TLquhnRYzvqw
bHCtlPZ7NfWe65XU73ZHtsan8Pdq4meJ8/2X8KfwIT5bPlubh2lLNKeC1+Lv
WT7YyfUXEN+kv3RwfZe+PSG4rklPvkW7NLXemxW9n5HGkwZ8hGseUL0N3k9p
X9Vc9Sln3Vsy+J1Ko0obqv8Ori8aXNOlUY8LrpXS0lOj9w/SqwXpvzxnXX1i
sA6RniwcXIulORvknZcvV70iNs25jnyX2ntR3VyYWvNLZ76bWvNL/7yXel+g
mjgmOM9fy/eMgj+Hr4YHBu+XL4aHBu/NpQ/XRe9jVdPfT52vpJ2GBO/lpRWH
Be+ppT8H67dz1pPvpN6XSW8vSr2XUb3+KMsDWuMDgvfyF3H9/NSejGp0/2D/
ob3eCTxJaxC+HZ4HXwg/BK+Ar4IXpN7TSePNS+3hqKa/nXo/KJ3/ZmqvRnV/
bHDt685n30jtz0gnjKZ9AV9Df5dgz6EZPCjYZ7gEHh7sG0h7X8VnR8J3JZ47
d8GD4C7wcHgg3Bt+DB4L3wg/Co+Cb4LHw6Ph6+CH4ZFwT3gsPAK+LHVdGAz3
gMfA98PXpvaF7oW7w6Ph++DLU+87hsLd4HvhIfCV8Ah4eGJd9h38FTwy2BvR
vJI3IY9Ce5Dvo7Wj9NuD9H9G/5XR+k68mM+OCPZbtNe4L9jz0d7kCq65Hx4m
HRXs/2gPon2G3teSxPsPjfOyxHsOzcOlcNdgj6t59L5tNjyd/sXRY6R9WaVg
b+Fjafhgz2ERsVSwz7CYWCTY0/iAWCzY9/iQWDzYx/iIWCHYu1hGrBX8vlYS
ywX7J0uJpwVrpy+IVYK9i+XE04Pf9SpimWDvZQmxbbA3qH3x3tR+43yNX2rf
QFrxk9SehrTfp6l9DOnJFam9CGnFz+FaOevJmsFa7nPit6n9UunhL1N7Vqqn
X6f2XaUVl6f2SaQPV6f2SKUb16X2XaWrv0rtQ0o3Vgv2cz4hVqfdoRxLPDVY
T64gfh3tB0nD3xz8Xs6L1vVa729yD32CfcUL6L8l2FdsBy9O7VdI5/cO9g/P
1zyBn4bPid5zix/XXA32MFvQf1GwH9gEXhHti2kv3z44JzfWXE3tLWtf0CvY
52yr+QK/CLeSRk7tIb9F399wN/ht+FjajfC7xELB+v99YoFgH+w95eBgf7Ul
33Mwtbe8gL4k2P95h3h9sNfahmuOCfbWFhJ7Bvu0relfmtojks5fktrP0T6o
eN6+rZ6ldvCa/YrYNDgPfEdsF+wTbiFeFuwd7SSeH+ybbSZ2D/Yhfyf2UL6D
9xAvD/bxdhO7BXtNu4jPRfstmv+Ng3PIOuJNwb7lPmK94Py2llg3OIesITYJ
zkXfEs8KXu+rifVpD8DfEBsF5yjVyhuD/dK9xM606fAvxN8zrSOtsj3TW9JO
2sOq5mtPtyza69wOb4neA0uLbsg0qDSn9Ll09NmM5cfROXdHsF6UbpSW+C7a
S/1LOSPYg/2D2CnYr9P1HYM9Ov1WP9pi+ECw9tB+YpY0WrA3u5V4QbAf+5Pm
QrD3+5vWQbQ3qjG5Ldi/3U/sEOxt/kxsFpzzv9f8ivbclHPmR+/Z9N4nRftv
mpMLouuKrn8i2gdTfpsc7YMpp02J9qOUD5+M9qyU9x6P9u40n+VF6znqMFZr
oj1r3dtX0V6k3vuX0R6l3tc30X73n/DKaB9Tc2xttPet8bkn2HPQ2K6O9so1
tncH67SDxGuC/fNfiROjz3W07sZHn5doHT0afWajtflI9JmQ1lqr4Bq6kdhG
zwNvIrYO9sx/VM6I9gmVh8dFnz9pvbcM9sk3KN9E+4SqEY9FnxVpnZ4TXJd/
ILYIrsvriZuj9yfaB42NPn9SPr8z2FfRmIyOPt+SthwTfXalPdclwV7uNs3D
aN9f4zAz2k9X7Xgh2hdV7q2Q99mGcsXz0b6oas20aC9U9e79THPo2cvnfU6j
/LY8+vxAa2pGtNevWrYoWk9ors6L9gW0ZkvkfW6kvHpS3udJ0ldvRvsIygM/
RXtM2meVzPs8SVrog2j9oZzzXrS20Pi/FH1+oHqxMFqLaMyr5H32o3pRNe+z
H+X/anmfx6hGnJz3eYxqxzvR2kXjXz3vsyXpvZ+jPTjt6bZFe3Pau30e7Ztr
Xr0SfZ6hel0p7/Mh1YJ3M12i+bM12r/T/q5i3mdFytsvR3tAqrMfRestrevX
o88tlANXRfv7yqufRJ9bKA8vjdZzWtdN8vY+pKvnRp/HyAeumfdZlDTk+mjP
XT7Ap9HnQMrJp+Z9jiUd3jhvb0X69rPosx/l8E3R3r321D9Ge/rajzfK26OR
TmuWt+cind80b89FmnZj9LmdfInmefs4/2ng6HMd5e1T8j7Dk/Z+O1qDal2U
yfv8T/X6i+hzGuW6D6M1qGrT7OjzHvkYpfI+d5SWWxKtfbUWXos+H1IdmRN9
dqV6Vy7vs0nV2Rp5nx1qX/BDtGchf6Ns3meW0gb/B5yQxcI=
          "]], Polygon3DBox[CompressedData["
1:eJwtmgf8T9Ubx++55xghCWVlC5mRSqhUkuy0VUIaaGgohbRQlIyopKGojJaQ
yp5JSztS0t7/9tb/8+5zXy/Xve97vuN+7z3P83yez/nVHXhJn4vzLMsu0X9J
+1tilm3X/iHxYSWybIL4ffEccTvxdeK14pnibXrDzeJt4gfFbTU+WLxAfIP4
dY2PEa8R3y1+T3yT+G3xveI2ev2N4rfEs8QHiUeInxNPEb+j1/cSTxEPFq8X
jxO/K75ffIheP0PnBoYsG6Jze2qsm7bbdDxI42s1dqJ4uvgi8QviO7Wdo9cP
1bmyGrtE21P8bo2/qbGLxavE48X76/O7iCeIB4hXafw08UzxpeLN4j7iO8QX
ijeJe4unioeIN4hPEE8TDxVvFF8kXikeJ26gzz9dfI/4MvGLGj9ePFE8ULxa
3Fc8S3y5eIu4q/hW8TniNeLx4vfED4gP1eddKn5aPFH8tsYvF28Q3ypupPFV
2tcRf657sEPj52t8mXgM50v4HjyrsdWZ781V2l7Q8e0ab6LxseJ3xPeJDxZf
IH5WfJ24rvg88TPia8W1xVeKN4kniQ8QDxMvEk8Qv6XvulC8QjxWXF/jQ8XL
xTeJ64mHizeKbxM3Fg8SLxWPFtcSz9N+l/grbU/qeJm2Kjreqd/wvj7/cfEX
4i+1PZH7N/HbbtZxQ73/SG0LdFxT51Zqf43Gt+h4mo6baewWfcZR+qwuOveF
zk0QHy0+ns8UTxQfI+7KNYg7i+fpeHbw/ThW/CjPJ/j+Hi1+gHgQ1xQfI36Y
+xn8ezqJH2F+B9+/m8UddXwcz0yfP0nXt1PHj+r4CI0frvG7xJP1mqriruIn
GA+ev8dzD8SPBM+3LuLHxA8H3++O4vvEd4priI8S3y++S7yf+Ajx3cSjuJr4
Nn3/h3yevv9w8a3iD/g8cQdxC71+kPgsvX4PcXPiTXymuLS4GfEqPkNcSpyS
n1cZ8Yc6nkqM6bi/zmXM7eBnTI56Sv9N1/gAnbtAXJrYE/cXny8uRewTQ+IT
xD/o9bcTk+JTxb+JbxAfJG4n3iYeJ24nPlq8S7yHuJGO6+jcJzoura2huLb4
Yx3fqK2Njtvr3Ha9vmRyPFXVuY90XEJbbXEV8U4dn5ycT5aJD+R+ibvouLfO
/U/vLytuqeNGOveZjstoayFuKP6UfKmtrY47Mqf1+rHiw8RHiT8Sn5ScT57R
uZb6/BOT42mpuIW4T3I8LRE3F7cT3878F+8jbi+eTP4T7yvur3v4oPgaffYr
GuscPb/OFlfU+KHiW8S9xXsxP6I/71RxhSJfMl/6iyuJWyfnZnL0nuK2ye+/
Pnj8EPF14qvFe/P51BTySfD3XavPe5X5mfv+jRK/LJ6e+/dRLzYz/8VNxS31
/nPF/fT+MuLRGn9FPCP3/Tlb/KR4RO74oz69xnwXtyIfRN+P03JfT7/oeLoq
dzyMFL8kviP3/TxQ33ce90ffV7aE6wPxPyx3vHRL/r55wfmmd3K+fCr4ejtQ
k8iv4iriU5Pz9Yrgekj9I19ckPv59IiO1/PElcWnJOczcjbX3zM6fs/P/Xx7
JOfLx4PzZ3fxEvFjwfWgV3L+fzI4v58cnX8QBVxPG41fTb0Lft6nRucz9AL5
plVy7BGD5cRnRueX4RqvLp4o3iGeK24vPis6H12ZO9/0TK4XTwTXh6s1/rx4
qsbfTX5es5kf4pfFb1P3xbuLeByg8YfEI3X+VXKrtqEau0znamisibYLdXyM
xh/VWFPxReJO4nnixtFa4GjxI+LZ1CS9/3Kdq0ktE48N1hQdiA1quPgKcoK4
QXQu6qj3z02+Rp41z5xrJ4bmB2sMYquZtot1fKxePz/5M68Vn5z7u9qLR4tP
Ei8Vv6ZtYXBNH0g+pA7rONf++uTfvCC4pnIv0BAPiudn1hZohoeCNRlaYp22
S3U8WOfu01hzNJC4sz5vgfhd6rQ4aH+d+B3qLrlY+zF8FhpJ7x2uU3X13hNy
xzIxTW5YrPEbgjXTYcSaeJT4RnFrtJZ4tPgm8UHRv/GmYE3Db/9D2+s6fjFY
Xy4h5wZronbMreRcQc5oSWyKR4pvELcSd4w+7qvrek5ji7Rdq/GxOtdGYw+L
h4mvEu9PriJfBM+JvaPvCffmAm33UgvJX8H3rBraSjxGPE58sPgfbet1vFzn
Wmv+ziQfBD/jSuRO6mHwHNxLPEd8ifhKcX20H/ET/Az2ic4/1/PsdP3PojWi
79WZ4uVokeh7eYb4+eQaSa1rnLt2rtB2W7AmPSb6HkwI1tDcG94zMVij8lnU
SGpftdy1c6W2ScGauVN0jaLWVM1du6iRB4nLFLWTGtRavEdRm9DIaAVqALWA
a741WAPzW9Cs04I1L1oWjTwzOMbRzmh8tBE5j9z3e26tVVf7ycmaeGqwBkcr
o6nvCa5ZaO0/cmuxetpPSdb892p8TuZegJ7gjmBNTa+AZp8VnEPQ8r9r26rj
zcH9CjW3lbh07lqMZmjKbS+0BHN8JO/NPfeZ4+SG7rnnPnOOZ90z91xkzhM7
PXLHQssiHo/PPbeZw+Sebrnn9oHRuayr+PFkzXM6c73QQsTEKH5b7lhhzlDL
qWHMJeYoc71X7rmLRjpNfGBu7bQ1uRZRk9Dy9DRoV2oYtQyN00zHKbf2YU4w
9/vlniv0eIuCezZ6PzQx2qpioZXRxGilSoVWRsO2FVfIrW3R1IcRe7m1Njn4
Mn3eNZlzM/3NizqerfHtyfqX5/OYuGMJ56dDxf8Weu0r7mnwuc809hq6Qce/
Ffrsldx669dCn32prUVwTflUY29pO1jH/+jcruQ51Cf4njO3mBPMDTQD2uFr
nlHwb+K3kbPIXVwjvfKm3Hry+0Lf/qDtcB0fq3M/a+w78aGFvvs+d7yhDato
/73GftL+RGoZY8kaEa3Ib/qQ92vrSe7Q/luNfaN9D3Fl7b9J/sxe4n2L7+Lc
wXr/EZlfy3e0LfQk381voNfYK/dv4xpPEu+X+9rpKZ8P9gDoNWO0vm+q8b80
lqL1fzPx3+IS0XqsufifYv6hF1qK/xXn0f1AE/GfzAd99t/MH21rdG5jbv39
nc5/kNyz/sl8ydzLUhOJ7VG5ayXxRG3oIi6v+VEyWp+1EO/W+L/any1uqP3v
4r+0P5NcrP0vyZ7DmmBNibZkDjIXj8qtX8m3/bVrJP5Dr/1H+7PEDbT/Vfyr
9qeIa2n/k/gX7U8W19T+R/Fu7ftRe7T/LbknoTeprf3PyTFI7b4+d2wyJ5kr
e+aeqzzzI8Ulc88F5jy9CjWaWEAT0asw59BK67Xtw7NG02hsrbiS+CtqmniL
eD/movhq8RviBuK/xKPFL+XujX8hJskX4nrEgngk8S+uL/5TPEq8TlxZ/DUa
jPwrrib+gZpHbIhriH8Sj0jWZJcH51C0GjnumuAaSO7bv9BYaCtqN/FUlbmK
BknWUMODNRPaCg1zZbCmQtug8a4IzpFov816f3Ud/4gGSPYgngv2qPAmyPfE
YiliIXkOMhe/1GuGiZeImQY7xOdz/8WdxOW0/yI5xulluUaulRxDL1gnc+6h
JqNFzspdq+nx6PXISTuKGD4k+Bl/V1xD4+AaxLXxGmK3RO73kuM6i8vnzn2L
c/t47+s951EPxHuId4mHErvisuJP0Dzi37WvFvxMebZP5/9N8Wy7zp2b3HPr
X7ZNPIh7JSgj/hhNI14qLin+AM2U7L+UFn8kHpKcc+mN62bOxcu1lSPXopE0
toK4IlejgcgH2ipkjnFinRyPh7Mzc+4vl5z7uCfcm5e0zdHxQp07A71e1Dd6
fnr/JYU+oudGv/zIMxBX135Scg8zudAr9DbPauubOeeT+5cV9faEYP0xLzrX
k/PRw/RI9G70yPROU6Pnf1bc/xnR879ccf/XaZuOttS57hqbHj1XyhT36w7x
vuJU3M9p0fGbF/PtGV13KXK/eLA4aLyP+ACdn5bcc04p9BH1+zltAzJ7KuhD
eshbCj2IvqJHvLnQC/SO5NjSwZ4MuZceHX2PnkfPLdbWLbPnRT1/Olpv4YlR
7+nZ6d3pB/7zDqLjvUIx3z7WZ7YRl9V+vPgxjXfI7KmgL5YWvwcPBz06P1of
tAruR56Mfn54NujPx6NrFzUMfbYgWn+0Du6PFkbrDzwf9NoT0XoXDwW9uiha
X+LxoT/ujM4P5Yv5PTk6/qlJzP8NuZ/Ptxq/QnxfdL6sUeS7B6P7s3pFfmHj
mJ6K3DMrOtaqFfnkfnIc9bXIzw9E5/I6RX47I7kWUZPwd5+P7jfpt9FvXxf1
As2Gdhte1INGRf65Nzo/Vy/yPTHC3Lsid+x8E90b0jPSO66I7ofxa/DWv42O
LXpIesnZ0b+lbpHPH4rWw/WLfM65ukU9Ivf3T/ZfNgX7gwOS/ZwXgv3Dgcla
Ck2Fn3l2sr+zMRR+QbIfuz54PaJfsv+yIXg94u7o+lWxyCdTouvb7sz5a2Z0
/apc5Je54ubU36KePRo9H5sW9e7N3M/jb2pIsidcXjw/t1f8cHS/c0BR/6jx
RwZrJmr/nGi93KCop49E90tNivr4XbQXgEeAV0BOIbeQs+h18KxLBudQcin3
iHvFPcJ7fYOYC/ZIhkTPwZrB18zcxDNZG6yZ8VK4p9zbrUX+xKPCq0KD1UO/
4SEFa6KK0fece88zw7vJ8YSCNUuFaM1DLiWnUijwtPgt/Ca8dTw3vDc0V51o
DxovGj+EtRU8Z7xnPCC8fzT91uA1DLQ+HjVeNZ4bayXLND5OPEl8ePQzaRb8
zHhWVciX2mYl9+vkxFLBMUquxGPC28YTw3si53cNzjHUAjxqvGo0aq1ojxqv
ehAxKU54XsGar3K0Z413jeatHq3hOgdr7N1FDj49OOeSmxehyTKvUfwZfY14
C8MyX/vt2r7NvEZB4b5H/An1kTkY7akR68Q8Ogi/4TMdf873Rc9J5ibv+Uu8
hX6J56KtEXMteu2CNQT6LdYkyBXkDLQmHij99uzMfhUeIF4g/SBrP3iU9If0
d+jhID4pWPOWj/Yc8R7XZO6HiHFinRhnbQDN3zNYE9MLIJ5ODNbcZaI9XLxq
PGy8XTxVvGo8bLxW9DHXXyd3PUeDk5vIUWhzcgK5gZzA2iUav1ewpkb702P0
LuKL3gMPGS9+dWZvGU8Y7xyPHq+YnqVHsGanlyHHkGvISayF0uN0D+6J6H3w
UPFS8VhZa2MNh7UcPFTWqvBc8V7xOFnLYk2HtR08VNbK6EGOC+756E3wmFl7
eSCz90xPcWxwj0evwRoSa0n056zd4ZnineLhstbGmurK4DU31lrpaToF94T0
OtSQNUV+IN5Yw1sVvMbH2h49b63gnoteGE8LbwtP+pxkTxpvmjU51m5Zg10d
XKNYmyXnkfuoCVuKnoa5xzPkWZYoYS1CfBC3b0b7W3iE+CX7Jf9WYorYqpF8
7dwD7gU9Hf4cngm93lvRehpPET+lZnIsck+5t29H+xV4gPgv9ZKfLXOSucma
xYjgnpG1jAOScyExT+w3SJ5LzCHmEjWUWkoNp5d6R+8Zn9kTxF+pnzzXmYPM
xe3RuQsPGX93W7SXjOeJ90lOGyM+JXeuWy4enHmNC3+HeB6R2bOk/0Fzoj3x
N+j31kf7Q3iUeJUbov0jPHC88LXRuQaPEa/x9Wh/lB6LXuuNaD8RDxW/6YNo
rw6PEK9wR7RXiIeIl7iP9l9nzjfknZ3RXiGeI/1Mk+RcyTPmWX+k8RmZPUX8
on+jcx2aHm3/frQWRZPiXX0Y7V3iGeIdMkeYK21z53hqOLWcmk/v8G60N4zn
jP+GH41/RD+JN4fmRHui6eh9KiTfO+4h/gYatH2wpkSbltQ19Q32JKoS38m5
jhpILVyIpgt+Zi2iNQfaA41Lb4NmRDui+emV9kdzZc555L6GybmPHEourU4+
yRyjxCo9AL0A+pv6T89A70CPQC9HD0AvQI9BL0qPQa+B5qH3Q/OgfdCs9HLl
k/0sPC78g9OSY5ccQa44PTlXkAPIBY2Taz2aAG1AD0IvQg9Cr9c3OVcQ88Q+
mhhtjB9Dr7hvcj+Mx4VfVCXZvzgi2P+onNxfo9fxnvZK9t7w7Ohf9yYmMntU
eFXvRa8NsAaAv1kxuf+lR6ZXrprc/6LB0GLVkrUYOYfcUym5l8Zjw/8ihvAS
Xixq5dZor4E1BfxXNDnavG7m3n9NtDePp4+3/4N4ceY1GfwmNCBakP6c/rlu
cm2ghlBL6K/pVelZ6X/rJPt51BBqyY/RtZUai98zpNDbN+bWev+LXvthjYe1
ni+ivWo8b7xv1ii5dn4Dfu9P0doQTxZvFj+N/rtOZr/ss+haT83Ha2dNj7U9
PC7Wb36OruXUdP4WhPy/MLfmQHt8pW1uZk8db/3LaP8NDx0vnR6NXo0embWk
XzW+LrNniHfImuCM4DVM1grR3GhvNDLeE2ua44PXlFnrRDOjndHceE38Tcbi
4DVt/lbjt+haRk3Du/sl2pvE08Hb+Tx6bYA1BtYavo9eK2NNjrW5T6LXAliT
YG1iV3TvTA/NWsar0V4SHhNe0wvRfj5rYKyFvVbkbzwnvKdXor0oPCe8p83R
/jtrPqz9bIr2/1lDZC2Rv3GZG7xmyt++0EPSS9bP7KW1KPL3cblzz8rotST+
hom/ZVoVvXbFGhNrTauj155Y02Jta2P0egRrmqxtvhztheG54b19HL0Ww5oK
ayufRveHrJGwVvJSdC4lp+LN0+PR69Hj4uXhSXcIjnm8ajzcbsFzHG8XT6x5
cA7CK+PvOfB2/vN4iEHiPPP8uid3z07vTs/PWmetZG1Ez0HvQQ4hlxDzeKvd
i/p6bm5vhb9BWxfcM/K3afTU9NYNMnuh9Hz0fvRoeJv/B4MX0hQ=
          "]], Polygon3DBox[CompressedData["
1:eJwt13m8VeMaAOBz9t6neU6lCc23EZUkFc1KA42aaSKNNBkqNBBNKBURKnQv
4aJCA1dJaKBZUea5zGOq+7y/df54f9/3Putde5+91vre9Z1Kg8Z0HZ3Kyso6
LHJE8XRWVjHxr0xW1gUOPGhsIq41X5ydlbVMTSfHS4oSoqZjjRx7yPi/dDLP
+KAzzEuJraIpy8/OMj871+N4Ledc6NhS4/fyG80X+I6HfUcf+TviUnYNG86q
yxuqvYLdzmaxxqwDu4utY5vYKLZNNGcFfW9l8yqikjhHnJdJjq0wvi2/xLyQ
uqrm1UR93oLd4PNu9nk12VuiGSuQk3xGpdzPjM8+P5N8xkrjxeI68yXOfdS5
nR1/Na4na8+6smz5a/FbWConud5x3S907kA2X91ide3YZnERy6PuTPOycT3V
xU1bpu5JdT2jhg1ji9gDYrP8IO/Kxsknq2sib8lvYqvYc2wA+0B0Y+PZFHax
fKdozYay0ayO/DLnzmRr2AY2gu0VHdkoNoE1kB8RfdlkNoO1lH8s+rOp7E7W
Wv61GMHmsIWsq/wbMZLNjd/Busm/Ezew+9lS1lu+T3Rio9lE1lD+lbiezWYL
2JXyb8UoNo8tYt3lrfyOKWw1W8OGsg9Fb3YLm8Yule+OZ4uNYOPY+XFNnDuV
PcvWsiHsI9GH3cqmsxby90Rbdi0by+rJd4k2bBgbw+rK3xft2fXsRnaefL/o
zMawSeyC+Czfezt7nr3MrmV7xOVsJBvP6stfTyfrNp2TrM9Yp+2deydbq26j
upHxLLMx7FH2FOsRfxu7jT3H1rFh7IDowsaym1gjeVFRRNTIJM/wEuOX8uHm
96i7X90V8sb8anYvW8Laso2xvlJJsylgXlBUFBVEvUzSKx43boh1Zd7VuX2U
58999mMN1ImeFH97Jukn0VfOzSTrc7nxlViX5q2ce7lz/zZ/hD8sameS9bTM
eEhdd/MJ6qaqayovL8qJurGWHXvMeFjew3yiutvUNZO/HD2AtWQd2F/mm1gD
Y3ZOcn3iOn0iBrDb1N2lro18ffQgdiXrzfJF3/Q9V7FZbD5rzj4V17BpbDZr
Lz8q+rEpbCZrFf3LuRPYE2yl2C7/nA9mM+Rz1V0u/0wMYtPZHNYheqTasfE7
2SrWK3oum8ieZKtZP7Y9egcbzEayWvGcqevF7oo1Hc+lfEesLzZEPkpdbXkL
Pok9xZ5l/dkXYgibyeaxjvJ26mawl9iLYo+8i5jPXpO/pW6iujfSyXsjx3Uu
bV5GrBPnsBbq2qv7M5V83vRUck3i2lRWX1hdoejzmeQ5XGRcEGvY8WyRx7lr
o9dET5Cfzn0vronnmB1iJ+SmWS/GvXb+UZYT54oP5Wlx3PwsUTHWpjy/OG1+
rmjk3P3xnmQ/yM8W1dlWlo+dktcTF7B9rB973PhG9HXR2B90Jbs/lVynuF51
2H3+qMPmJ53ncNZLjg8yWWU8yI+yuWoGsifYvvh72T3sbFaTdYg1I/6WL45n
xrywKKhufax19rm8qCjENrABalca92Yn+4i71TwY91hePM5nG+NaxzMdnyUK
sFdj38C+lJcURdimWKvRt7PjRWmfYNjMrvYdTxr3s4/Y7Fgb7Cl2gB1hc9jC
eP/I0yIvW+f4A7EO5fkj2Cvs4XjXyE/JS4o3WF6fd5LVjesZPUGeI36P+xP3
RN2ueBezP+Q14n6ynalkLfQ0Too+KYrFfoKdywbKh6nL4zursHpxzdjQeLZy
r30t1if6Qby75JVEnbj38sHxvMXzHf2L9WWDWCp6H6vBerGB7LR5BVbN2IP1
ZyfNy0avNHZhPdnv5uVZVWN31o+dMC/Hqhi7sb7sH/OKrLqxJxvATpmXYRWN
nVh39qv5mewsY2fWg/1mXppVMHZk3dgv5v3ZCuMedojN8jtKsfKp5NmLZ3Ce
vJDIyy6UX6LuqHlxdoaxNevIjpmXYKWMbVgn9n0q2Q8NTSV9KfrTGe5Hin1l
XibWnLrXU0nvHJ9K9kyxdyqXk6zpj83zxTMkhsd3ijLRU+RdnPuDeUlW2tiW
dWbHzQvEMxPPA2vGjpgXZHmMjVhz9pF5EVbY2Iy1Zp+bF2VFjM1ZG/aFeTFW
NP5O1pZ9aV44ro2xKbs4fl8m6RHL2W75+7EOM0mPWJBKekb0joOxdxb3stfl
23zeJNd+pfg1rlH0K7bd8V/YNOMK9gy7Xv6E+E1eOnob2+H4apYxVot1wz6M
c9gv8hKiAnuX/cbuMT4dvZ3dEN8p7mb/YS+wsfKfxR3xHmdPs+Hyn8Tk6AvR
x9lg+Q/iFraUrWDXyH8Xs9kz0RPZjfLj4uboM2w5uzqdXL+CqWSNx1r/Wv4Y
/zF6miirbpvjP7Jbo1ewlWyQ/PH4e6JXxbPC3o73JPsrclGF7Y7n2GfOMr7M
XmOj1RwT49hC9gjrm7v/iX1Q9Uyyd1gco7gslfSR6CfPyLekkz1P3pxkfxL7
lNNiNXtHze6spOkvTSf3Ju7R046dkP87XlbmlVhN04PxLmZ/y8uLqmxP3BuW
MlZhtdmhuJYsbawaPZEdNl/FTsS9FdXY3riHLNtYmdViH8Q9jPsZvTC+h73D
3kwn+6p8OcmeL/Z+a2JfF2tWXUt1P8UegJU0NmRN2XfRH/2+R4272AE2U01v
toztZPvZjNirxbuLvcV2simsV+z/2Ha2l01jV7FH2A62j02P/SBbxLayHWwy
68YeiL+dbWe3sq5sIdvC3mW3sM5sHtvEtrIJrG88W+y9WH/sTtaRzWEb2BY2
nnVic9lG9iYbl06eg3bsuuhB8czlJPvXxqnkPRHvi/i/cK3asqyJvJVzf04l
vy9+59K4h2JwXCf2nZqUKOXYFv4cy2+sxRqwT82fZfmMNVl99on58/GcGmuz
huwz8xdZCWOD6EPsW/MXWHFjfdaEfZNK9kPHcntp9NQj8r/UPeTYevlmdXfI
/xD3xWew9ezm3PdCuVTS56Lf/RjPAP/ePBO9SN2bqeTd/U92st+Kfden8j9j
H+LYq9H/1N0u/68oxs5nF7Gv472mdolxG9vFpqqpzOrGu4oNiaXF/g8HLe5G

          "]]}]}, {}, {}, {}, {}}, {
      {GrayLevel[0], Line3DBox[CompressedData["
1:eJwt0jkvBVEYgOGxr9cS0RINUVCKglIUVCIKOqKgIBEFpULodPwCWiL0Ejr7
vm8REVtj33lOonjnOZl7MvOde29Ra3dDV1wURYN6UVg/6ELT8VGUwzkWcpXl
PGE171nPL7YwMyGKYuq0LmU/KznMWo6xiRNs5yx7ucAfXvFNm3rSnRYNtMUl
bnOZO1zhbpiJe1zjPte5oYPwHB5yi0fc5jF3eMJdnnKPZ5x0jmu+61zP4Ywa
MdsGBzjPHs6wjeNs5ChrOMQK9rGExeqwTmMzP7yjjres4hHLwrlYEL5L+y75
qmw9hr3KN2MW8xhjLjPDHmYwxnRmMC28j6lMZpJSrBOYHH7jcI+/StR3+Eyf
MkY05XLz/3/4A+rvSxM=
        "]]}, {
       Line3DBox[{690, 1018, 473, 689, 1124, 912, 691, 1125, 913, 692, 1126, 
        914, 693, 1127, 915, 694, 1128, 916, 695, 1129, 1025, 1244, 696, 1130,
         917, 697, 1131, 918, 698, 1132, 919, 699, 1133, 920, 700, 1134, 921, 
        701, 1135, 922, 702, 1343, 1019, 923, 1020}], 
       Line3DBox[{704, 1026, 1245, 703, 488, 705, 1136, 924, 706, 1137, 925, 
        707, 1138, 926, 708, 1139, 927, 709, 1140, 1027, 1246, 710, 1028, 
        1247, 711, 1141, 928, 712, 1142, 929, 713, 1143, 930, 714, 1144, 931, 
        715, 1145, 932, 716, 1146, 933, 717}], 
       Line3DBox[{719, 1029, 1248, 718, 1030, 1249, 720, 504, 721, 1147, 934, 
        722, 1148, 935, 723, 1149, 936, 724, 1150, 1031, 1250, 725, 1032, 
        1251, 726, 1033, 1252, 727, 1151, 937, 728, 1152, 938, 729, 1153, 939,
         730, 1154, 940, 731, 1155, 941, 732}], 
       Line3DBox[{734, 1034, 1253, 733, 1035, 1254, 735, 1036, 1255, 736, 
        1156, 942, 737, 1157, 943, 738, 1158, 944, 739, 1159, 1037, 1256, 740,
         1038, 1257, 741, 1039, 1258, 742, 1040, 1259, 743, 1160, 945, 744, 
        1161, 946, 745, 1162, 947, 746, 1163, 948, 747}], 
       Line3DBox[{749, 1041, 1260, 748, 1042, 1261, 750, 1043, 1262, 751, 
        1044, 1263, 752, 1164, 949, 753, 1165, 950, 754, 1166, 1045, 1264, 
        755, 1046, 1265, 756, 1047, 1266, 757, 1048, 1267, 758, 1049, 1268, 
        759, 1167, 951, 760, 1168, 952, 761, 1169, 953, 762}], 
       Line3DBox[{764, 1050, 1269, 763, 1051, 1270, 765, 1052, 1271, 766, 
        1053, 1272, 767, 1054, 1273, 768, 1170, 954, 769, 1171, 1055, 1274, 
        770, 1056, 1275, 771, 1057, 1276, 772, 1058, 1277, 773, 1059, 1278, 
        774, 1060, 1279, 775, 1172, 955, 776, 1173, 956, 777}], 
       Line3DBox[{781, 1174, 957, 779, 1175, 958, 783, 1176, 959, 785, 1177, 
        960, 787, 1178, 961, 789, 1179, 962, 791, 1181, 1182, 963, 793, 1183, 
        964, 795, 1184, 965, 797, 1185, 966, 799, 1186, 967, 801, 1187, 968, 
        803, 1188, 969, 805, 1190, 971, 807}], 
       Line3DBox[{806, 970, 1189, 804, 1292, 1073, 802, 1291, 1072, 800, 1290,
         1071, 798, 1289, 1070, 796, 1288, 1069, 794, 1287, 1068, 792, 1286, 
        1067, 1180, 790, 1285, 1066, 788, 1284, 1065, 786, 1283, 1064, 784, 
        1282, 1063, 782, 1281, 1062, 778, 1280, 1061, 780}], 
       Line3DBox[{809, 1074, 1293, 808, 1191, 972, 810, 1192, 973, 811, 1193, 
        974, 812, 1194, 975, 813, 1195, 976, 814, 1196, 1075, 1294, 815, 1197,
         977, 816, 1198, 978, 817, 1199, 979, 818, 1200, 980, 819, 1201, 981, 
        820, 1202, 982, 821, 1203, 983, 822}], 
       Line3DBox[{824, 1076, 1295, 823, 593, 825, 1204, 984, 826, 1205, 985, 
        827, 1206, 986, 828, 1207, 987, 829, 1208, 1077, 1296, 830, 1078, 
        1297, 831, 1209, 988, 832, 1210, 989, 833, 1211, 990, 834, 1212, 991, 
        835, 1213, 992, 836, 1214, 993, 837}], 
       Line3DBox[{839, 1079, 1298, 838, 1080, 1299, 840, 1215, 994, 841, 1216,
         995, 842, 1217, 996, 843, 1218, 997, 844, 1219, 1081, 1300, 845, 
        1082, 1301, 846, 1083, 1302, 847, 1220, 998, 848, 1221, 999, 849, 
        1222, 1000, 850, 1223, 1001, 851, 1224, 1002, 852}], 
       Line3DBox[{854, 1084, 1303, 853, 1085, 1304, 855, 1086, 1305, 856, 
        1225, 1003, 857, 1226, 1004, 858, 1227, 1005, 859, 1228, 1087, 1306, 
        860, 1088, 1307, 861, 1089, 1308, 862, 1090, 1309, 863, 1229, 1006, 
        864, 1230, 1007, 865, 1231, 1008, 866, 1232, 1009, 867}], 
       Line3DBox[{869, 1091, 1310, 868, 1092, 1311, 870, 1093, 1312, 871, 
        1094, 1313, 872, 1233, 1010, 873, 1234, 1011, 874, 1235, 1095, 1314, 
        875, 1096, 1315, 876, 1097, 1316, 877, 1098, 1317, 878, 1099, 1318, 
        879, 1236, 1012, 880, 1237, 1013, 881, 1238, 1014, 882}], 
       Line3DBox[{884, 1100, 1319, 883, 1101, 1320, 885, 1102, 1321, 886, 
        1103, 1322, 887, 1104, 1323, 888, 1239, 1015, 889, 1240, 1105, 1324, 
        890, 1106, 1325, 891, 1107, 1326, 892, 1108, 1327, 893, 1109, 1328, 
        894, 1110, 1329, 895, 1241, 1016, 896, 1242, 1017, 897}], 
       Line3DBox[{911, 1024, 1023, 1344, 910, 1342, 1122, 909, 1341, 1121, 
        908, 1340, 1120, 907, 1339, 1119, 906, 1338, 1118, 905, 1337, 1117, 
        904, 1336, 1116, 1243, 903, 1335, 1115, 902, 1334, 1114, 901, 1333, 
        1113, 900, 1332, 1112, 899, 1331, 1111, 898, 1123, 1330, 1021, 
        1022}]}, {
       Line3DBox[{251, 474, 1124, 252, 488, 280, 1249, 503, 295, 1254, 518, 
        310, 1261, 533, 325, 1270, 548, 340, 1281, 563, 1175, 355, 578, 1191, 
        370, 593, 385, 1299, 608, 400, 1304, 623, 415, 1311, 638, 430, 1320, 
        653, 445, 1331, 668, 460}], 
       Line3DBox[{253, 475, 1125, 254, 489, 1136, 281, 504, 296, 1255, 519, 
        311, 1262, 534, 326, 1271, 549, 341, 1282, 564, 1176, 356, 579, 1192, 
        371, 594, 1204, 386, 609, 1215, 401, 1305, 624, 416, 1312, 639, 431, 
        1321, 654, 446, 1332, 669, 461}], 
       Line3DBox[{255, 476, 1126, 256, 490, 1137, 282, 505, 1147, 297, 520, 
        1156, 312, 1263, 535, 327, 1272, 550, 342, 1283, 565, 1177, 357, 580, 
        1193, 372, 595, 1205, 387, 610, 1216, 402, 625, 1225, 417, 1313, 640, 
        432, 1322, 655, 447, 1333, 670, 462}], 
       Line3DBox[{257, 477, 1127, 258, 491, 1138, 283, 506, 1148, 298, 521, 
        1157, 313, 536, 1164, 328, 1273, 551, 343, 1284, 566, 1178, 358, 581, 
        1194, 373, 596, 1206, 388, 611, 1217, 403, 626, 1226, 418, 641, 1233, 
        433, 1323, 656, 448, 1334, 671, 463}], 
       Line3DBox[{259, 478, 1128, 260, 492, 1139, 284, 507, 1149, 299, 522, 
        1158, 314, 537, 1165, 329, 552, 1170, 344, 1285, 567, 1179, 359, 582, 
        1195, 374, 597, 1207, 389, 612, 1218, 404, 627, 1227, 419, 642, 1234, 
        434, 657, 1239, 449, 1335, 672, 464}], 
       Line3DBox[{261, 479, 1129, 263, 493, 1140, 285, 508, 1150, 300, 523, 
        1159, 315, 538, 1166, 330, 553, 1171, 345, 568, 1180, 1181, 360, 583, 
        1196, 375, 598, 1208, 390, 613, 1219, 405, 628, 1228, 420, 643, 1235, 
        435, 658, 1240, 450, 673, 1243, 465}], 
       Line3DBox[{265, 481, 1130, 266, 1247, 495, 287, 1251, 510, 302, 1257, 
        525, 317, 1265, 540, 332, 1275, 555, 347, 1287, 570, 1183, 362, 585, 
        1197, 377, 1297, 600, 392, 1301, 615, 407, 1307, 630, 422, 1315, 645, 
        437, 1325, 660, 452, 1337, 675, 467}], 
       Line3DBox[{267, 482, 1131, 268, 496, 1141, 288, 1252, 511, 303, 1258, 
        526, 318, 1266, 541, 333, 1276, 556, 348, 1288, 571, 1184, 363, 586, 
        1198, 378, 601, 1209, 393, 1302, 616, 408, 1308, 631, 423, 1316, 646, 
        438, 1326, 661, 453, 1338, 676, 468}], 
       Line3DBox[{269, 483, 1132, 270, 497, 1142, 289, 512, 1151, 304, 1259, 
        527, 319, 1267, 542, 334, 1277, 557, 349, 1289, 572, 1185, 364, 587, 
        1199, 379, 602, 1210, 394, 617, 1220, 409, 1309, 632, 424, 1317, 647, 
        439, 1327, 662, 454, 1339, 677, 469}], 
       Line3DBox[{271, 484, 1133, 272, 498, 1143, 290, 513, 1152, 305, 528, 
        1160, 320, 1268, 543, 335, 1278, 558, 350, 1290, 573, 1186, 365, 588, 
        1200, 380, 603, 1211, 395, 618, 1221, 410, 633, 1229, 425, 1318, 648, 
        440, 1328, 663, 455, 1340, 678, 470}], 
       Line3DBox[{273, 485, 1134, 274, 499, 1144, 291, 514, 1153, 306, 529, 
        1161, 321, 544, 1167, 336, 1279, 559, 351, 1291, 574, 1187, 366, 589, 
        1201, 381, 604, 1212, 396, 619, 1222, 411, 634, 1230, 426, 649, 1236, 
        441, 1329, 664, 456, 1341, 679, 471}], 
       Line3DBox[{275, 486, 1135, 276, 500, 1145, 292, 515, 1154, 307, 530, 
        1162, 322, 545, 1168, 337, 560, 1172, 352, 1292, 575, 1188, 367, 590, 
        1202, 382, 605, 1213, 397, 620, 1223, 412, 635, 1231, 427, 650, 1237, 
        442, 665, 1241, 457, 1342, 680, 472}], 
       Line3DBox[{277, 682, 1343, 683, 278, 501, 1146, 293, 516, 1155, 308, 
        531, 1163, 323, 546, 1169, 338, 561, 1173, 353, 576, 1189, 1190, 368, 
        591, 1203, 383, 606, 1214, 398, 621, 1224, 413, 636, 1232, 428, 651, 
        1238, 443, 666, 1242, 458, 685, 1344, 686, 687}], 
       Line3DBox[{459, 667, 684, 1330, 444, 652, 1319, 429, 637, 1310, 414, 
        622, 1303, 399, 607, 1298, 384, 592, 1295, 369, 577, 1293, 354, 1174, 
        562, 1280, 339, 547, 1269, 324, 532, 1260, 309, 517, 1253, 294, 502, 
        1248, 279, 487, 1245, 250, 473, 681, 688}], 
       Line3DBox[{466, 674, 1336, 451, 659, 1324, 436, 644, 1314, 421, 629, 
        1306, 406, 614, 1300, 391, 599, 1296, 376, 584, 1294, 361, 1182, 569, 
        1286, 346, 554, 1274, 331, 539, 1264, 316, 524, 1256, 301, 509, 1250, 
        286, 494, 1246, 264, 480, 1244, 262}]}, {}, {}}},
    VertexNormals->CompressedData["
1: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
rRen4dcSEP+I+IebAlVUzr8+hkOJr2hG+KG8LR98fezwEcJ/E/9w1d0fy6+Z
3MAdxE8+R/i33ye9Y27fw1Y6wPOJrzj/JPfClx1u+DQC3k98xSM1q856bPTA
QiuBcxF+xvZyyq3Ax1iX+J8NxG9cSfxzbuKfexG/sX+xzfll0c+wpDLwBbOA
73Ec2xzR9ALvOk58bFngp0Ulp8+e+BLb6RJffQbwmU1Ja5+vDsQSxsD5iQ/Z
s0h5teTxYCx6CjgP8SGLVkgZu/uG4swtwN9LAF87Pni0k2U4Pr35r/45l4bf
X31grpaAv/PNz//OFf7uP/8rj3/xd74o/u/8X/xqrizbv/N/8eG5qsL/b3n+
W/y/5XMjDTizn3c7Hf2zn1EYaz8/qHqm+NTHDkVu4dzPs998kHI0uUHVF879
HCaS/pnaz+iRJud+lniua0PtZ9Spx7mf49dqKXpu9EBDJpz72c1NZebtwMfo
4nbO/fyW+OdH13Hu58w5jYuWRz9DWgs49/OKhx2TI5teIPZ+zneMNKf2M9q3
kHM/O/zYUkvtZ1SqzrmfBVaFCkkdD0aKhpz7OY0rrpfaz+izMOd+Vof9jJj9
zNTnr7czyqj6jNj1efLXRqHn510Quz63u3kjqj4jdn0+c9pnFlWfEbs+89Up
xlH1GbHrc5D/8B6qPiN2fZbn7h+i6jNi12cRln/O1Of0nMJbVH1G7Pqc+HT/
Tqo+I3Z93nZFS9EYxSN2fd5VNPcnVZ8Ruz7XLXmXSNVnxK7PDVNT1Kj6jNj1
WWbJ0vlUfUZMfWb0xukHHn/0BmLrDQO3t56U3kBsvSE+vIa/ydMPsfWGdWjo
K0pvILbe0Ai+pUTpDcTWG49urrtP6Q3E1hun700covQGYuuN9yz/nNEbm1sa
iim9gdh6I3KHLC+lNxBbb1RFNStRegOx9cZS0BuIrTc6QW8gtt5w7PiVQOkN
xNYbjq+8Oim9gRi9wehnD+EOM0o/o9D7nPpZHzv0UvoZ6bpy6ufGveenUvoZ
xV/g1M9rI26qUPoZsfXzgW4vM0o/I7Z+tjRXTKX0M7qixKmf60VWFlH6GUUO
cvrnSSz/nNHPi9/19VD6Gd1O5dTPxiMrflP6GS1J5tTP6wxFxlP6GbH1843F
Kfco/YzY+rlyysJHlH5Gjbs59fM5rdM+lH5G836nc+hnw+igl5R+Rox+ZvrB
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
+IyDZ2b2+SRjYXvglzSBC5T/8o38mIKjamaC/0B8LQ3wtbA5P6dfx037dasS
mfk6LuKbOW//maVsMg5nCvzN36tMYN6jjyTXX6CqXTzL0w53//X6+okbyHv0
hiS+2Dpr1BjjG3j68Ka/xjPzdfmLyXyao4L+2Zv38JO+v8Wb/xMvTeJHVVo+
ONjmhitr/3M842feJn5m41/zN088SOYDNy0CnircOlPv5WN8Qvpv62P5j//J
+HJqi8ffeGLvi6++2/SXeOtE5j367vnAPRpjRolFPcMWi/52fet/ru8wDzjf
ks2Kro0v8Omqv31e638+bx+ZD9Td/k1HcMJLzDP7b5/3v+JXkLlBvMxZ9Kp6
IH4z6j/nw/ir+sRfDeL9W/zZf+K3kbnBwx8qx599EooN+/+2Pmf/WR9mP6sT
n5bZz8y+dXPjPrfUZBwqJPuW2Z+ji/QV5TztUMovuD6zD82Wl40XNL6B+si+
YvZbFOw3xOw3Zl9VaR7fYNXmhh6RdWD2zwixkKUmGzwQs3+YfaKyp8OW2ico
+jtch9kPi4lPy+wH5nt3ge8d7SLfO/P9hnkb21PfL4qNgHjme1zj9us39T0i
5ntkvq/fXx/mUd8X2hgD8cz3sha+FxRIvhdm/XfD+iNm/Zn6PNbca+WOM1dQ
C6s+p1oI91L1GTmy6rPC4j31VH1G5vs467NO38SFkcc8kZUFZ33eBfUZseuz
ze5YK6o+o3x9zvr87evAZao+I3Z99uESPE/VZ/RtHWd9/jL9+x6qPiN2fY7m
V/1M1WfErs/XJPquUfUZveDmrM9+Zi9lj02IR+z67OR29j5Vn9HJnzM56vPt
9o7lVH1G41j1+fiWk7FUfUaRpD4zeuPuE2s7Sm8gtt4oVfXQo/QG2sjSG/pN
N9ZTegN5svTG4VHhVpTeQGy9YfyzYTKlN9Bplt7Y6LPmJKU3kABLb2zQ991F
6Q3E1huJlU1LKb2B2HrDyUloCqU30EWW3tg3sGSEpG0q2sHSGzN0T/ZRegOx
9cayeVGNlN5AbL3RCXoDGbL0xg//J7mU3kDnWXrjSq9+KKU3UAfRG4x+3lB9
6Seln9EYC079jM0SjSn9jNpZ+nnum0XvKP2M/C049XNY3+EKSj+jIpZ+nrDk
2ypKP6NdLP28O3jDH/2MPFn6ecZgkDCln5HFFE79fGWceQaln1H4XE79/Pn5
+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
     "]],
   AutomaticImageSize->True,
   Axes->True,
   AxesLabel->{
     FormBox["\"Delta-Lon (degrees)\"", TraditionalForm], 
     FormBox["\"Latitude (degrees)\"", TraditionalForm], 
     FormBox["\"Distance (meters)\"", TraditionalForm]},
   BoxRatios->{1, 1, 0.4},
   ImageSize->{393.5856684689411, 223.35693873873504`},
   Method->{"RotationControl" -> "Globe"},
   PlotLabel->FormBox[
    "\"EarthHaversinDistance[{anyLon, lat},{anyLon+deltaLon, lat}]\"", 
     TraditionalForm],
   PlotRange->{{2.7777777777777776`*^-7, 0.0002777777777777778}, {-85., 
    85.}, {0., 30.87050894181823}},
   PlotRangePadding->{
     Scaled[0.02], 
     Scaled[0.02], 
     Scaled[0.02]},
   ViewPoint->{1.4172478428794102`, -2.668792097537105, 1.522812297027171},
   ViewVertical->{0., 0., 1.}], TraditionalForm]], "Output",
 CellChangeTimes->{{3.535813893164114*^9, 3.5358139044782453`*^9}, 
   3.5358140983206277`*^9, {3.535814312285022*^9, 3.535814340841877*^9}, 
   3.5358144433381257`*^9, 3.535814524926284*^9, 3.535814927460084*^9, 
   3.5358152644448347`*^9, 3.5358264759333153`*^9, 3.5358276740315943`*^9, 
   3.5358395395330305`*^9, 3.5359990654426203`*^9, 3.535999188704945*^9, 
   3.536014233578051*^9, 3.5360148795373945`*^9, 3.5360254427409086`*^9, {
   3.5360289494174795`*^9, 3.5360289560198565`*^9}, 3.53627072998244*^9}]
}, Open  ]],

Cell["\<\
The following interactive plot is another demonstration of the same \
phenomenon:\
\>", "Text",
 CellChangeTimes->{{3.5358152931387043`*^9, 3.5358153158969793`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"Plot", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
      RowBox[{"EarthHaversinDistance", "[", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"anyLon", "+", "n"}], ",", "lat"}], "}"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"{", 
         RowBox[{"anyLon", ",", "lat"}], "}"}]}], "]"}], "/", "meter"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{"n", ",", 
       RowBox[{"1", "/", "3600000."}], ",", 
       RowBox[{"1", "/", "3600."}]}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"PlotRange", "\[Rule]", "Full"}], ",", "\[IndentingNewLine]", 
     RowBox[{"AxesLabel", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{
       "\"\<Delta-Lon (degrees)\>\"", ",", "\"\<Distance (meters)\>\""}], 
       "}"}]}], ",", "\[IndentingNewLine]", 
     RowBox[{
     "PlotLabel", "\[Rule]", 
      "\"\<Distance versus delta-lon for multiple latitudes\>\""}]}], "]"}], 
   ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"lat", ",", "0", ",", "\"\<Latitude (degrees)\>\""}], "}"}], 
     ",", 
     RowBox[{"-", "85"}], ",", "85"}], "}"}], ",", 
   RowBox[{"SaveDefinitions", "\[Rule]", "True"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.5358115309654207`*^9, 3.5358116859252295`*^9}, {
  3.5358117179092293`*^9, 3.5358118717392297`*^9}, {3.5358130864917*^9, 
  3.5358131250922318`*^9}, {3.5358131641158347`*^9, 3.535813167063013*^9}, {
  3.5358132323851314`*^9, 3.5358132668589153`*^9}, {3.5358137235851574`*^9, 
  3.535813755085307*^9}, {3.5358138030371017`*^9, 3.5358138264624443`*^9}, {
  3.5358146814579353`*^9, 3.535814697137503*^9}}],

Cell[BoxData[
 FormBox[
  TagBox[
   FormBox[
    StyleBox[
     DynamicModuleBox[{$CellContext`lat$$ = 0, Typeset`show$$ = True, 
      Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
      Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
      "\"untitled\"", Typeset`specs$$ = {{{
         Hold[$CellContext`lat$$], 0, "Latitude (degrees)"}, -85, 85}}, 
      Typeset`size$$ = {540., {137., 146.}}, Typeset`update$$ = 0, 
      Typeset`initDone$$, Typeset`skipInitDone$$ = 
      False, $CellContext`lat$474$$ = 0}, 
      DynamicBox[Manipulate`ManipulateBoxes[
       1, TraditionalForm, "Variables" :> {$CellContext`lat$$ = 0}, 
        "ControllerVariables" :> {
          Hold[$CellContext`lat$$, $CellContext`lat$474$$, 0]}, 
        "OtherVariables" :> {
         Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
          Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
          Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
          Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> 
        Plot[$CellContext`EarthHaversinDistance[{$CellContext`anyLon + \
$CellContext`n, $CellContext`lat$$}, {$CellContext`anyLon, \
$CellContext`lat$$}]/$CellContext`meter, {$CellContext`n, 1/3.6*^6, 1/3600.}, 
          PlotRange -> Full, 
          AxesLabel -> {"Delta-Lon (degrees)", "Distance (meters)"}, 
          PlotLabel -> "Distance versus delta-lon for multiple latitudes"], 
        "Specifications" :> {{{$CellContext`lat$$, 0, 
            "Latitude (degrees)"}, -85, 85}}, "Options" :> {}, 
        "DefaultOptions" :> {}],
       ImageSizeCache->{610., {208., 217.}},
       SingleEvaluation->True],
      Deinitialization:>None,
      DynamicModuleValues:>{},
      Initialization:>({$CellContext`EarthHaversinDistance[{
            Pattern[$CellContext`lon1, 
             Blank[]], 
            Pattern[$CellContext`lat1, 
             Blank[]]}, {
            Pattern[$CellContext`lon2, 
             Blank[]], 
            Pattern[$CellContext`lat2, 
             Blank[]]}] := $CellContext`earthRadius 2 ArcSin[
            Sqrt[
             $CellContext`q[{$CellContext`lon1, $CellContext`lat1}, \
{$CellContext`lon2, $CellContext`lat2}]]], $CellContext`earthRadius = 
         6.3675*^6 $CellContext`meter, $CellContext`q[{
            Pattern[$CellContext`lon1, 
             Blank[]], 
            Pattern[$CellContext`lat1, 
             Blank[]]}, {
            Pattern[$CellContext`lon2, 
             Blank[]], 
            Pattern[$CellContext`lat2, 
             
             Blank[]]}] := $CellContext`h[$CellContext`lat2 - \
$CellContext`lat1] + 
          Cos[($CellContext`lat1 Pi)/180.] 
           Cos[($CellContext`lat2 Pi)/
             180.] $CellContext`h[$CellContext`lon2 - $CellContext`lon1], \
$CellContext`h[
           Pattern[$CellContext`angleDegrees, 
            Blank[]]] := Sin[($CellContext`angleDegrees Pi) 180.^(-1)/2]^2}; 
       Typeset`initDone$$ = True),
      SynchronousInitialization->True,
      UnsavedVariables:>{Typeset`initDone$$},
      UntrackedVariables:>{Typeset`size$$}], "Manipulate",
     Deployed->True,
     StripOnInput->False],
    TraditionalForm],
   Manipulate`InterpretManipulate[1]], TraditionalForm]], "Output",
 CellChangeTimes->{
  3.5358116380282297`*^9, 3.53581168708523*^9, {3.53581172313723*^9, 
   3.53581174250023*^9}, {3.5358117728392296`*^9, 3.53581178985423*^9}, {
   3.5358118527422295`*^9, 3.5358118726092296`*^9}, 3.5358130956767*^9, 
   3.535813125827525*^9, {3.5358132382074594`*^9, 3.535813267918339*^9}, 
   3.535813756764475*^9, {3.535813807246523*^9, 3.5358138276015587`*^9}, 
   3.535814097978593*^9, {3.53581431196799*^9, 3.5358143405258455`*^9}, 
   3.535814443015094*^9, 3.535814698856675*^9, 3.535814927654084*^9, 
   3.535826475980318*^9, 3.535827674071597*^9, 3.53583953956403*^9, 
   3.5359990654766235`*^9, 3.535999188788954*^9, 3.5360142336560555`*^9, 
   3.5360148796063986`*^9, 3.536025442810913*^9, {3.536028949477483*^9, 
   3.5360289561678658`*^9}, 3.5362707300104427`*^9}]
}, {2}]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Headings", "Subsubsection",
 CellChangeTimes->{{3.535815353192709*^9, 3.535815354089799*^9}}],

Cell["\<\
The normal convention for headings is 0: North, 90: East, 180: South, and \
270: West. The following formula (given without derivation) produces headings \
given lon-lat pairs in decimal degrees:\
\>", "Text",
 CellChangeTimes->{{3.5358156634257293`*^9, 3.5358156748278694`*^9}, {
  3.535816861506525*^9, 3.535816914878862*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"HaversinHeading", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"xlon1_", ",", "xlat1_"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"xlon2_", ",", "xlat2_"}], "}"}]}], "]"}], ":=", 
   "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"degree", "=", 
       RowBox[{"\[Pi]", "/", "180.0"}]}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"With", "[", 
       RowBox[{
        RowBox[{"{", "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{"lat1", "=", 
           RowBox[{"degree", " ", "xlat1"}]}], ",", "\[IndentingNewLine]", 
          RowBox[{"lon1", "=", 
           RowBox[{"degree", " ", "xlon1"}]}], ",", "\[IndentingNewLine]", 
          RowBox[{"lat2", "=", 
           RowBox[{"degree", " ", "xlat2"}]}], ",", "\[IndentingNewLine]", 
          RowBox[{"lon2", "=", 
           RowBox[{"degree", " ", "xlon2"}]}]}], "}"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"Mod", "[", "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{"ArcTan", "[", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{
             RowBox[{
              RowBox[{"Cos", "[", "lat1", "]"}], " ", 
              RowBox[{"Sin", "[", "lat2", "]"}]}], "-", 
             RowBox[{
              RowBox[{"Sin", "[", "lat1", "]"}], " ", 
              RowBox[{"Cos", "[", "lat2", "]"}], " ", 
              RowBox[{"Cos", "[", 
               RowBox[{"lon2", "-", "lon1"}], "]"}]}]}], ",", 
            RowBox[{
             RowBox[{"Sin", "[", 
              RowBox[{"lon2", "-", "lon1"}], "]"}], " ", 
             RowBox[{"Cos", "[", "lat2", "]"}]}]}], "]"}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{"2.0", " ", "\[Pi]"}]}], "]"}]}], "]"}], "/", "degree"}]}], 
    "]"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.5358154111485043`*^9, 3.5358154111525044`*^9}, {
   3.535815467443133*^9, 3.535815545195907*^9}, 3.5358169200883827`*^9, {
   3.5360289002076645`*^9, 3.5360289391408916`*^9}}],

Cell["\<\
At any fixed latitude, we expect the heading to be 270 for negative delta \
longitudes and 90 for positive delta longitudes. The following plot tests and \
confirms our function:\
\>", "Text",
 CellChangeTimes->{{3.5358175576464753`*^9, 3.5358175886454754`*^9}, {
  3.5358176293814754`*^9, 3.5358176307354755`*^9}, {3.535817736441475*^9, 
  3.5358177595184755`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"With", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"lat", "=", 
     RowBox[{"90.0", "-", 
      RowBox[{"180.0", "*", 
       RowBox[{"RandomReal", "[", "]"}]}]}]}], "}"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"Plot", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"HaversinHeading", "[", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"0.0", ",", "lat"}], "}"}], ",", 
       RowBox[{"{", 
        RowBox[{"\[CapitalDelta]lon", ",", "lat"}], "}"}]}], "]"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{"\[CapitalDelta]lon", ",", 
       RowBox[{"-", "1.0"}], ",", "1.0"}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"PlotRange", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"-", "1.0"}], ",", "1.0"}], "}"}], ",", 
        RowBox[{"{", 
         RowBox[{"0.0", ",", " ", "360.0"}], "}"}]}], "}"}]}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"AxesLabel", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{
       "\"\<\[CapitalDelta]Lon (degrees)\>\"", ",", 
        "\"\<Heading (degrees)\>\""}], "}"}]}]}], "]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.5358174430962577`*^9, 3.535817534319475*^9}, {
  3.535817599227475*^9, 3.535817712722475*^9}}],

Cell[BoxData[
 FormBox[
  GraphicsBox[{{{}, {}, 
     {Hue[0.67, 0.6, 0.6], LineBox[CompressedData["
1:eJwVz2lMkwccx3EOxYOmyIKFCnKDpWuQIisBJC1SDjGOUnXRkaJFSAlq2iGI
iQcEuolsoCgimww1hQUQqwOUwYb/Me0ESguIlkoVSrEcHfSZ4gHEiP/nxS/f
fF7+fNKlwkw7GxubSBzZYC7NsrJCgFovj2BOynjSJb+SpWUCOC8SO4PQd1vZ
gQvvCIgzUqJIhzJ2p0/9R4DYUrmdgQ53lo/2jxCQ71DPDUTzJl/3/XyHgI8i
VZwvWnhOc2vbQQIenncQbkLnD8iPSR5YIUNbmr0e/fSpo6VbPA/R7U3WaZOM
t/lvqUu4xxyM24/8+Rh978ij1U4vLeBe2sVsQB/6if3/86JZKHzzYO579OKl
UyXAnYHc8N4PmWgFdYxePTEFNC9iXyy6JomdM3zeDLo12n0+6KKj4pNBO19B
v7yl1hZ9yr4pP2feBApKa+T4hIwnLhzw1zVMgDKr3QvQV7rM1TXZRijkf/fb
dXTnOIPS7DsGBXEJhWfQfht4O/bWGmBE4qkQoVuYJdmmST2s7namR6HHVb97
czg6MPl0hNDRZtaVULg/DNqwgxVLRhnP+WwjJ9h2CNyoPnEjaBaHYNUv9AM/
0RjTji7mzw92nHwMabOdFZXojXuVFw+4/gMP/40vzkG3vFc59fh3Apem7RKi
6w3mslm5EsY00l0h6NHTtOu/blNCRnRf31Y01TPhborpNuia/ZNInzjU8KSD
exusPz5PDEbHm7NdS5dvgSwpNp6FnrESN5iyRkjrpcUw0Ey75dYjqXXgouni
eKPTFEyV1/o6KI92u++FvsRP1Q3/oYAAZc5XpJd/+GsxiqYAwYUtYZ5otWNB
NGXoJhhTKtgeaD1zbfmBslqg6TNYbmhRikeb4XAlXJh29N2Anlt4F5H36DI0
ucwrnNCnqwaAGnAZ6DHaANI1hiJ1zFQFqH+5GERFt6mfqJKHyqFn90Y2BX3n
7VG/mVE5LLZ58taitRHeW91riiHMuNK9Bm09Oxz5tagI+NSJWNL7v8ity4IC
yJMoEhzQe6Kodra9eXDNnZG8ivynyqVLdh2HTwnrhuzRg8mGEI1GBufyLULS
13oEEFovgczB5m/s0G4vN1s/NaaD+GOZ3hb95eSziCpRKtzcIv2WdCBFdjVY
kgJjAsELG/S6G0tZO6b5sMdVICf9GSzS4EU=
       "]], LineBox[CompressedData["
1:eJwV0X0w1AkYB/A9MkSEGc2pwdlrFY24O3E49/yqzaiTl00/7pCXQ7I676y4
lZAcE3fYoYSGVU5n04m2NrHO4c5N3mK95PLa2tr9Ufa85OUefzzznc/M96/v
YxocxQpVodFox/G280JEyCx3hgnPXNWojTSSGFq8UqG74gImKc+zt73gfuBd
VCwJGdpe+R/QKYXOf7FtAuFAr4S3it7kJt+ssAqF+Vz/8mX05Yh7kQMWEfCQ
OcVXots/ycm+pRsLMv6bxkV0Jo8ebXc9Hvb7R4sotPMukU+fVhIs7FS2y9Fd
ywpzNfVU+Cxqs38eff68RVjT5hXQPKq3OIl2oSd9l+GUCTn/Fa/8iz74st3N
IzUL8mv20ibQMpa/nWw1G6x37d89io78ukDDWJkH5mO2lv1ooWbKC3FCIfDi
/C6I0ZWWBgMCehHUP9Z3bkVf9RD0lj0vAs6ObnoL2os3/XeiOQ+2io6MC7f3
MHUVW7wsgfUmHfcGtJm9keAXZjn0LLXaVKK7fw9gNuRUg30wg8ZFH5n6yDjd
RwAVQ3KePfrThSerDmIhSB2+lwq5JHGyauQfNx8xeK1+edUKfeK0vqryYSf4
ZLT/eudHksgPGL5s3dwDokbL9wfRnW5G2h76fcCZWciuSCUJuakBt//GAMzY
/kyYoBPiDwXl7xkCPnMy7XYKSQyP67LCuiQwqkzXMkQHJn/1Wt11DAZzNx6X
XsL/HLL7qV1tAhqGxU270WY7RdJql1cwnhU0dD2ZJIxE7BNq1yZBvnU3VRdN
W1OpjZ2aArU6q6hsDkksez4918GYAVZ0fpY6eswmYB8jcxb0HjCkqUkkEe2t
q0cfn4PgIN++pUSSMCya8dlhJAU7G/ZEArret/LOe848jBZU271NIAlvpzSX
rqcyULo8amSjG85dpDusv4HMEfYjeTxJrGgeVxWelYMhw1EjFM3qc7Q1KlGA
pOd1ymwcSWg6arWJbimgnxl4bBrdVj36jV+VAsqEEo1JtDUnOehmvQL4pd3F
42gdk+Y8ww4FKL+oEwyguyM/nzZ4p4CY3ovTbWhCw7xAx5WCffyFU+XolZiV
vfWeFDCaw/XK0IKxTv5pbwpWO14Nl6KNBWFP8oIpkI30hhSj189Wz2kmU7Ax
ep+bh26uMnFSr6Gg9mj0g0voH7Spzpo67JtIORy0WVILy7mBgom1AEhEF53y
D88SUfChxr0nBh27eKNQdYACVcnhuXC0hW+EcZWEgo/Lau6FoSf/sK89NkEB
5WccF4L2KJG0pM9TcH9QmxaI1lC5e9KUouC33Kw//dHP2EmDrUsUeMJGni86
8YVzQOAaBU1U/Jlv0Ydhj2xri4KhsreG3uj/AYPZCW4=
       "]]}, {}}, {{}, {}, {}}},
   AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
   Axes->True,
   AxesLabel->{
     FormBox["\"\[CapitalDelta]Lon (degrees)\"", TraditionalForm], 
     FormBox["\"Heading (degrees)\"", TraditionalForm]},
   AxesOrigin->{0, 0},
   PlotRange->{{-1., 1.}, {0., 360.}},
   PlotRangeClipping->True,
   PlotRangePadding->{Automatic, Automatic}], TraditionalForm]], "Output",
 CellChangeTimes->{
  3.535817478321735*^9, {3.5358175275018167`*^9, 3.5358175352714753`*^9}, 
   3.5358176222914753`*^9, {3.535817716425475*^9, 3.5358177301314754`*^9}, 
   3.5358264760953245`*^9, 3.535827674179603*^9, 3.53583953964903*^9, 
   3.535999065561632*^9, 3.535999188872962*^9, 3.536014233826065*^9, 
   3.5360148798414116`*^9, 3.536025442971922*^9, {3.536028949640492*^9, 
   3.536028956234869*^9}, 3.53627073008545*^9}]
}, {2}]],

Cell["\<\
Likewise, for a fixed longitude, we expect negative delta latitudes to \
produce a heading of 180 and positive delta latitudes to produce a heading of \
0 or 360:\
\>", "Text",
 CellChangeTimes->{{3.535817796033475*^9, 3.535817845661475*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"With", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"lon", "=", 
     RowBox[{"180.0", "-", 
      RowBox[{"360.0", "*", 
       RowBox[{"RandomReal", "[", "]"}]}]}]}], "}"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"Plot", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"HaversinHeading", "[", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"lon", ",", "0"}], "}"}], ",", 
       RowBox[{"{", 
        RowBox[{"lon", ",", "\[CapitalDelta]lat"}], "}"}]}], "]"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{"\[CapitalDelta]lat", ",", 
       RowBox[{"-", "1.0"}], ",", "1.0"}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"PlotRange", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"-", "1.0"}], ",", "1.0"}], "}"}], ",", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"-", "90.0"}], ",", " ", "360.0"}], "}"}]}], "}"}]}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"AxesLabel", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{
       "\"\<\[CapitalDelta]Lat (degrees)\>\"", ",", 
        "\"\<Heading (degrees)\>\""}], "}"}]}]}], "]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.5358174430962577`*^9, 3.535817534319475*^9}, {
  3.535817599227475*^9, 3.535817712722475*^9}, {3.5358178541204753`*^9, 
  3.5358179887194753`*^9}}],

Cell[BoxData[
 FormBox[
  GraphicsBox[{{}, {}, 
    {Hue[0.67, 0.6, 0.6], LineBox[CompressedData["
1:eJxF1H1QC2AcB/Apu1LUOHFh0Qo1eQvrQupIVyRrF0WyLafcNmKnti6Xyahc
6JRuR17uthBuu7x11Sot3UJdZZMyRaulxlryls55u3Pf53f33O8+f32f3++5
e7yT0zj7HSgUCu/v+deXhc6y/v5tr6f8K1lKGCe39c4qLrGkTX4wtW4ENhpd
rQ18G0x/nDYzaN5H+KHwCdW9xwrzClaOducMw+MXsvLqQ4dgpVuvp6JvEC7d
slJsyLfAOSK+1D9qAM5yvC0R28wwX9bm23mrD75Ya1GUCt7B1W/9pt5l9MI+
tLCNcVdN8D1mnsDc3wW/bapYwGJ1wpaAi4H1jwzw9Oxy1rJJHXAAyx5Q9rkF
Phlua6+S6mGPOHXhrtk6kvetyb3ZtxouM1nODsvVMNNh4r4wUQUnxc57YNpX
DGu+iHyGXsthmdHPOLcxhNzHvUdAXeobSvlfnZ9yrtHGI+HR7YvH0sQ74ayi
iGfC1Tz4V3bm5WvL98MywV2RgSmAGxfk516hiWF5CeNw0LmjcMRUbUKHqwRu
/j7iT3U6BqemMlMe/cqBIxmS3SdD5LBfT2MM+9gp2MpJCrL+yIVFGwqdvb4W
wFUuWS916UXw9aUeBg2jGD7N1rSXthHHlfQ/z/AvIfvwjtYxexTwomC65kL4
VfjpfW54Rb4KXmOe5HUiQQP7jNb8WKurgqOU3a0xCTp487YZjl8f6uHz3Fey
FZUtsD6GPo09owO2eXtkv7hkgNOPLuGfn9UJv3pD46Q0d8G8zPXvnaJN5H2W
BJ1ppPaSeaZoh1SR72C6VriZmtcHUyYcysVmM/w9tnZv08IB2LSaO3eh3AIf
jqdNZ7wZhD2LBxIm04dgdeL1m5+lw3B8yPHI5lorXLH3IGPtzw/wuMsmx6od
NpjTsY5FV4zALutcG7RXiBtUr7fuURKvkGbyL6uJ3eZXFng2ET8VBfZ7jBGH
OfsXukXbSf6R8TnqWGKNSV+2LZ7YS5NSU5BM/HOHatAlk7hSOT/E6QbxoWl2
/Y07xIskdZyICuLiLUkHTmmJxZ8uFTkaiJmJAi9lF3Hfk+Dyjb3EbEVX3Ylh
YmeHW1HeduJ6ocT4+AtxxssILm+C+P9/D/8BGN6qpA==
      "]]}},
   AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
   Axes->True,
   AxesLabel->{
     FormBox["\"\[CapitalDelta]Lat (degrees)\"", TraditionalForm], 
     FormBox["\"Heading (degrees)\"", TraditionalForm]},
   AxesOrigin->{0, 0},
   PlotRange->{{-1., 1.}, {-90., 360.}},
   PlotRangeClipping->True,
   PlotRangePadding->{Automatic, Automatic}], TraditionalForm]], "Output",
 CellChangeTimes->{{3.5358178976464753`*^9, 3.5358179900724754`*^9}, 
   3.535826476134327*^9, 3.5358276742096047`*^9, 3.53583953967503*^9, 
   3.535999065587635*^9, 3.535999188894964*^9, 3.536014233890069*^9, 
   3.536014879898415*^9, 3.536025443039926*^9, {3.5360289496844945`*^9, 
   3.5360289562768717`*^9}, 3.536270730107453*^9}]
}, {2}]],

Cell["\<\
Intermediate cases, where lon and lat both vary, produce smooth results \
except where the delta longitude crosses through 0 and the heading jumps from \
0 to 360, as illustrated in the following 3-D visualization:\
\>", "Text",
 CellChangeTimes->{{3.535818051477475*^9, 3.535818114613475*^9}, {
  3.5358181556454754`*^9, 3.5358182011194754`*^9}, {3.535999458784861*^9, 
  3.5359994606878614`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"Plot3D", "[", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"HaversinHeading", "[", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"0.0", ",", "0.0"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"\[CapitalDelta]lon", ",", "\[CapitalDelta]lat"}], "}"}]}], 
     "]"}], ",", "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{"\[CapitalDelta]lon", ",", 
      RowBox[{"-", "1.0"}], ",", "1.0"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"\[CapitalDelta]lat", ",", 
      RowBox[{"-", "1.0"}], ",", "1.0"}], "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{"AxesLabel", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{
      "\"\<\[CapitalDelta]lon (degrees)\>\"", ",", 
       "\"\<\[CapitalDelta]lat (degrees)\>\"", ",", 
       "\"\<Heading (degrees)\>\""}], "}"}]}], ",", "\[IndentingNewLine]", 
    RowBox[{
    "PlotLabel", "\[Rule]", 
     "\"\<Haversin Headings as a function of delta lon and delta lat\>\""}]}],
    "]"}], "\[IndentingNewLine]"}]], "Input",
 CellChangeTimes->{{3.535816950628436*^9, 3.535816960241398*^9}, {
  3.5358169958819613`*^9, 3.535817165712474*^9}, {3.5358172523283367`*^9, 
  3.535817366497918*^9}, {3.535818211481475*^9, 3.535818217339475*^9}}],

Cell[BoxData[
 FormBox[
  Graphics3DBox[GraphicsComplex3DBox[CompressedData["
1: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
IfdGb+6+Lim5Lf9e6IbHCXnVjlu7Zgy+7I05rMulzsl1EzfwYfTuNHXd4uKH
Pjkz/fSS3rATrunPtF0mYH6ecul9biOOq1mZ89dXDJgtYFwln3QNxfoL2T4D
7z1eIIXnd7xPEaVpovl+I9EN1tlSClujDtkSDutjx8d6qgx2JRzWtRy271nT
35PwfH49apLifL1d3oSH8etI2knnbGf8cV1Y/xm/YMtTBV/C8XrRwgXPRJwI
h3WeHz+tb65xJxzWbc6FTe3p5EX4HH4d5pR7eJAr97x6yW3do83FM5eNrxy5
NCyWnfp5S22Ary2ON/pZbLvYMCwWaUqfN//RczTmHd0299yn8ghl3X4ULKfS
D/PMMofx6/zuoJ1iNhnf3KQZmAc3vr07d+Sa58ig5Hr/HQNFcbzhs8o3Pu/+
G6Q18trBeP12PL+sGxLTorfrBer2sK4s5WQ3BuY7sP8BN/XveupIYQ55ce2w
zPzbGyUwB/s/zKTJ33DowvMm2NUZ3fbwJ2098DgFjR5D3XOy0AhLxdahMa14
PNOSh7yW08tFo6Oy+nfb0Yznu7KZeuvf3atHY944ru28+gm3F3kTsKVbRy3S
OD8+we5hEb7uV1jXnT1bx1WHcLC30TNf9jFx+4njhA9p17VEWwvQwB2PxSOb
SFx0Zb++6G3PT2i9nGxuREM97gfsM+n7s8OZNV/xeJR1vB5oHypBrNHgR0oD
SbzU/+bSU/K6ZSgs0vRdO/sZ9zOKt+f7S9qaDIqr8Hgqbg/MDx1TiabfsDR8
lkDiohfDSu84Fn5GGTIaZ3RmlOF+YD12Yv7BgxaNZfi6kbI3Gz7crkF74opj
NeRLMN+9bdurO261qO75gI9oQDHuB96XWJvzQpXwYhw31o29XWVf/B51Tx/Y
0CP2Gx6nvMkAlSTbPNTP/uYXJZ/vuB94jxQsbZ7M6mrE173V6iPZ2b0EZYrl
fG0trUGtfD8Zx6KnjV9WhN45+PVQL6zD/cB7l6/4Ue28QS22B2erwRM0jlag
lBjlpfELK3D/wV2LdVzzy5DYnp/jHWSIzn78eyrZNutio2Ilvq+JL24tOqxY
g7bez+po3VqC70vdrsg60aEK7X95aeiz1FLczyz+ve68e+BNq1wpmlDe5+Gv
uAvmZVGZOxeNQwTMknkR9YqheJ2H7W/4xqXnMQFjeEVPdmIoXhdiVaSFnbu5
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
iyc936Hno66If2r0pOc1JHmw7kmPaSr0vIYuFHrPm1a0gJ7XUEzvhKReFur0
vIa+JiQen7VHk57XkFTMm0li13ToeQ0lv1sahQauoOc1dDnimtCsVo+Oo1Cq
6YuVUxpp+ylBAaWNwXdmedJxFJo8rzW6LdiTjqPQbblIYf8GTzqOQhstdnvU
unrR8RJap1C3IT5iAh0voaRhelERnF1R8RJa0pTmGLaNoeMlZN1aVx3IvadU
vIQipkx5LR+rQcdLaHjZhtj12tp0vITKBka4HxDo0vE5umRjWGxt4EnH58it
I0p/8SlPOj5H8Y0SM13rPen4HKVlxYn1We1Fx+fIxP6Db+gTLzo+R2OkWmIn
LPem43MU02ua7d03Y+n4HDV9dPnqNXkGHZ+jBQ5zPZ7umk/H5+iTvf37m7aL
6Pgc6VueM9+1Q52Oz9HWwUV+teM06Picuy+17/kmWnS+jC7c81dedMmTzovR
zr6sukWdJ53/okma946vYLzoPBfN615v3RnhReezKDSoh3VaL286b0XXn/XS
bfT3pvNT9HnjG4fmEDk6D0WzbLajDBUVOt9Er3Mvsfe2z6bzSrTiQ/9bMnIL
6fwRnXygunhfxyI6T0S5p3q9/75fnc4H0cfpwy80P15Grz8gYeVCzehaT3qd
AVX7PlKaMcOLXk9AKw886jIP9KLXDdCUcnPPLfle9PoAylWb/NZ8DtEHePhb
JVWZTbJ0/o4Udier/GhVpvN0dG76pJfd/WbS+Tgafr3bc2nfeXTejT5PrBQV
qUZ0fo2uz2m6JRAspvNo1PRI/EFOiDrWB/46udgdKBtN8mX+HCyb29LsLLGN
rLdc/31uln2z6XW90guyrgLn8DeM+nSlWIzkyx9+n39m69ZNER0zmeTLjb/X
yVnPZ4WDDbVJvhxmF+VRy41nie7VAxZ/rHvAeIwvlMw9tIPkyzCeR7mh7vbX
Sb4M45lR629c0EDyZf48NvtKIX3Ubj2yLgHjuSv2U3tmKllnkPh9rpudc+uT
1y0tC6zbo9/nlln5SekrmoREN/gbmhf9qGY0WWdo+H2emV0qt9bjuSVZZ+jN
f6eQLggtsNlLdOPP2bILbDexH08Q3fj9Hbale49DxWFEt9iVtQHXufEMeNf0
UvjHOsN7GE9Sz2AZJaIbjEcWLdh0YDbRDcbzeEDeDR8nohuMR+JEUe9lQrLO
AOPZUuP4ZfoMopv+7/PDbJKDmx2TRNYZevw+T86+Pfsh0yeIrDPw+2vs2D2m
EleKiW7wd/zzxI8No8k6w3L+O44HVjf6O88h6wz8OWd207QTyaITyTqD/+91
eDbs/ROjLW1EN/58O/vuQVKbYzvJl/n9ETZj7f0zPWPJOgP2E0/MQ3qEk3UG
GM91bcMz5x6SdQYYT824x0eeSBHdYDztWgceHttJ1mfCfp/fZq+MHz8rYiDR
LfT3OX8249PqC4oWZJ0h9fd+EHvOJe7migyyPvPbngvZn3q2StGSZJ0B/027
UNw8mqwz8OfM2W2b+9RFfye6Pfy9D8L+WCgbKHaErM8c5cfjtezcvd07iG5p
/HiuCvyKXzSQdQYYj5i/Y9nCFLLOAOM5mNf6ULyIrDPAePYbKTqcmk3WZ2A8
a7YcuZtpR9Zn8n+fn2ffVgZNMTpB1mdk+fPGO+pO5XaZkXUGWD8X9PEbO6eI
rM/48+d7Lw/ZWDFiLllngHMs9t0iA8XWkXUG+GsY4/SyldMTdIN1cvObjwsG
BJD1mVH8eKZMr5324xJZZ1jOj8fJN3zL8YdknQHGs9z71pZgzk5ANzwe89Hy
ch7mWDc4h7ztWN2NISvMsG4wnkszFi3Q8ibrM3N/f9fAbrEw+q6ZaYJ10+bP
yZeoPZt7fr4bFaelsz+vjHq4R5Lk0X34c+xj7KUUos+7Yt3s+P16gUj7h/Z6
F6xbOn+OfZf8i2l2n5yxPnr8dS8Ouzbr6EOyznCNv25U1+S7w7j7BX0k+Ou2
RFd4qnH3BfcLz+FzVqVK5WSyriLkz40P6u/W6v7MGN9vEX9OfODaq8opmfS6
SiRrHTNCdXwSuV8X/hy69S5L37GnybpBE79PpBuhtPiuK1kfEIv63X/kLd8Z
NS8N8fg9+X5eG1+zKT5jiMfvzO+vlb2oUSvjOIx/Er9vsP2cv3TVEbLuocBf
R27C6GV+1u5UXpaM5jTO63/PluT1F/nvuZak17yfx7WHccLfN+McE3/9bifo
v4Hv5+bzLS6dn/Tx+CP5fqb27c5MmLca2+dn/tzLzF+/f/vAANunKf/d2SGZ
vcUH3Nbg+y3k98tCf/2+7uc15Hnx5+vVDa/caFpI1jEe8t+RPRY9vcXkG7lf
OA9wr2nui00SJA99xH9fVpS8Nd5fkaxLPOD7OS764Y7GnjnE//N/o3vGFDdz
OsD9PuT7kdmr8uRcwHJ8v5b8+ZxXIj/vtXD6wP324L+DU89S0NResgrf70X+
fELRJT+RsfPIusQy/nu6A40KlTvqVuP7nc1/f2RuuHZBlifJK3vx+91Vuvp6
qyLI/cJ4z0YnO+58S9YlLvPngt7l7RbfI0vyyk38924XkwzZtCCSd6vy1w0P
d9259BLJu3vy1231m1y46zPC+sBfi+txqjWcbqAPXPdSjz09pUx0sD5+/HUv
rP0Q7lq2AuujzZ+XeDW4aZnbQ32sz3D+e73eH2df70oh6xJ5/PdT3++d0xla
QfSBffxj5ta1M4aT/OgS/11V+rVBd1+uJ3kljDfdMWCDWCzR5yv/PV23B6oe
Z0eRvBu+28o33CtmNkoJ6/OAv27Cj2JxBc6uQBe4bletUuLx3EVYH/gbPCB0
VwGnG+gD3/F9QhHRYfO0sT6P+HMg25KePZg3eTnW5wj/PeDMrXpHzuwg6xKh
/HdhBoMGnXqlSfIgOEfUeWHZhowgoo8V/71Yc0jJU6tnRB8d/pzY2nGT9PTl
SB4E4z1cOvVZ0H6iD3yPFqTtNXC5vALWB85FnMle+OpbAcmv4bov9j36MFJ/
AdYHrtt88N7CO8WLsT7w9+SEUp8nnG6gjyx/vmWXnM/kC7u0sD5i/PeMuls9
UEFvsi6hx3/vZqI6Z6ZcBNEHvmtjv6v6hL8j+ozmv4ProftVbOwYkif24s/L
We5xXDffh+gD3zMeOHvmfnoB0Qe+s5MTzXMe8Zzk0XDe49mwCb59L5E8Gq5b
MTejrTZ9DtYHrjvs1HKX40oM1geuOyTQ8JnSviVYH/irZ3a8501ON9DnIf89
5p5Y6flvJMj6A3zfejrfNSm/jOgD5+uMu/uPOzmG5NHv+e9eBVJWh1JtiT6p
/LnBcJ+F12sTiT4x/PeYG2qeJd4ZSvLo3vx1pyycnLzoGcmj4bqKx78sD4ye
hPWB63qwHjLi9qpYH7iuSOPPFf0U1bA+8B3osspF7CUVss4A55EMKwsSJouQ
dQb4e+veedUQTjfKD7Aexgmjh9dZ4/39OXx8NbPxeuznMLLvP4KPA7NfSr0S
N7Sn/S37su8qvWGO1vQ8xR7Yat37h4sV1u0G/x2ixHaRAXslyT7Fej6u0K0K
u6hh6IbjUic+rlhrg2Z3cfEYNb+zq1QDj3STM6Hnd/ZNYweb99gI6/mNj3PG
878nCbya5wo8h+dewccD8DuTwJspTo0f3RnqaJRo607fL/ru31Xvfcudvi+0
ZvkGaxFND3xfzXxcYcD/XgcVdyGV6NUnR1kY0PE5CnM55rbs4Szaj7GGyZ+n
FCywof0Y26/X252o3Yr2/2yodUPrSysret5krxjVth/wtsT2APt9YhkjjPOd
7ek4hF238KjGr/oIcL/w9/Ijh8SOP/IOPq5gVUTsxzUtc8b9w7nZZd3cPXur
0fvvQlZ0y/iWqjZnrA/Lx+fRQQt3rbI3w8/Xlu+nnP8dSOBWPIffh4T36zHf
T1B957tvEevpuIhduaJl/+YcY2o8caz2zlfB3omulD5x7HKbi/3d3jtT695x
rIPq7aLROmbUuncc6/Td8svgQ8bUunccO1W4111jlhG17k1+HxXGCe/XQJmb
jjWHDek4lr26uvvXNbHrsN9z5u2qOkzEf8gkeh8tDv1QKzt7VJPeR/uv/QPf
H2v54cgBd1oftD5Fev6vfTdKH2T8ctLPJ1n0vlscmnw0fOFD++W0Puhon4hB
NW6r6DwL3Re5cPT1CB08/t58HBu2emGp2Xcyfgs+7oXfjQRuT3G4L4iHA660
yOpFEM7bCbpy7tB5g/cetD2jz1t1andy8Spl/0j57POxv34/HzjEjar3dVkd
OS86H0fZ13w60/28qH2lDKTcZ88pnaIFuD3EV2tmpLhVJHrR6yFIK863o6KB
cIg3bJTN9ESlvel1J7Rre5Vw9EJvev0EJZ1os9mRMJVej0K+UgbqzNwJuB+Y
lyT1dVwOr/Om1wNR2+IVnls9SP/wuwqHp99+FHloLG4P89pla4U1R3d40+ux
yPprttu2E970eTYUlDlx7+2zpH/4XQW5TCVVZC1H7cdlsMPfF1R9Md1A7cdl
sBcCsz+s/GFK7cf9128Ar03Zrv5ywXps5/T++9/7U3FsYePhrWvlDan9xwy0
uV5upWd/D2r/8b/2CdxOTnVjdooHdd4mA/WtrfVqdvGk/Soy3aqxrO28F33O
BD0wbkuXaCDt4buMxFr/uHHLvenzPCjx3Mb7PyK8cHv4XmN/6aLvY895U/2X
oAcqGiMlennj9vAdR16oWY/lrwmH7zjYw9PuhdQTDt9xREvdYHx6+NDvBZvc
eXB/c6olPV+gzodOohJCD8r/CNHxA4sTUlo86XkNBQz/ljWotzelWwEaPSww
qt7fm2pfgj4e/KkrlexN6VaBhBvTDTyKCYd9H8briq5dG7FPY94/X2O4eICL
Z6B9Nr/OE/52zIydum6Ye/Dtr3zKfPkrLqLWbZDZr99RnG5A94/WsGdPdXH5
PtU/sp1U+MLP053uH00aIC3zKz4Bzv9Fy0590/z1O4TAo/g4R4T1F/zye8C1
+PWBNxJrT2nLETvh18HQo7w9mx77Ef6IX98oWKmWUdZAOD+/o2Nvzp4vS/Si
41IUpZD3VkSa6BzA5+n9TQvKZBd60/EtSmqbV7PZg3B4708xTzUOrCM8hPd7
63VVdx7ZQTi/PoyOvFBm/E/80Q+fXyszAdFqdwmHPNrS+lFoczTh/P4Can9q
OvYSS7gq+Ima2wHxGYRDXuwhbDdlPxIOeeihihPtnW8J5/d9UOXH+m/+ZYTz
+ylodKtMwO4vhENeefFd9KgPPwmHPG6/eXLgqG9/6Mz71U03Ztw/0kE4v8+F
DqqnHtAVJe8pxFHbbw5s3MvFk9Q6HrtvVvmRX79DCPwmH8+ItX8LH+JhTtsh
6/VsuMuv3y2h7JDtFtRzxvdlznQ/qLnX8BfZXJxArd8ip/N642I6FtPjRD8W
3ZuRzeWn4E9ofw6cXw/Ev+8HvPMfHNYP4ff9qPaYwzxVwfO1fF5AvV+s6efV
zxyQI/1+sQH6dX299zrQfo+9VfjetTrCkeKRbOr+R8W/4ti/47FI1r/CX+1X
XPq3P0xG565Upn//Y36BvLvpoiSL+vpgDnmu+KSMupW9fOh+WPaaisfgSCfK
nyezi1dnHqjh5mVqnOjs3NH9f8WT1DjRTpntqX/Gh3w+xV7jfy+O0pO9ynPq
uqg5Tvh05R5N+tw7mlMp2yQhScYP+63f7N/10xbY0u8F++30qsYlu2zp94ud
7vYx/vx+W/o9ZZVmjJjUmmhLv+/sZfVhbxSEtrTfYBUXLRULE7Wj/Q97IFqz
qHwg4bwfYw/cM1/mu5lwOJe+ddh1wdRg0j+ujznAc+2IFFtK/xJ2aYmkoKC3
HfUcC9jUNx2Jcn98L8D7c1bLZLf9rNP2tD9nc0we3p8lSfabrm2bfLC5q55d
FxaWYnraBtcTAT07hp9L1JV0wvVHgB/V1eve9xSpEwrc/9aYwRF2pO4qcOn0
52VzLpK6q8CDWGbbgTRSdxV49SwT7+pUUncVuPD2vKXuV0idUOALdR8nHVxL
6oQCH/osau8QNVJ3FfgWht3qMZ/UXQX+ea7qiCdGpO4q8B0rCmssj5O6q8BF
y801bjeQOqHAHW/HdjRa4zqYeN9/+nDZsLDTRE/g88+MvasyntQJBd636Z2B
WTPRE3httY2b9mRSdxX4vpMhsuHzSd1V4AfXLJC6PorUCQU+t8tCYlQB0RP4
E5EzTcUKRE/gHleFtauKSZ1Q4N42zqWCNFJ3FfigIScP3c0idVeBN0mMjznf
m+gJ/FV5qaOjFdET+N7UxKNnbptjPSF+b+3WrdSHccZ6Aj9RUa0fKiR64vx7
2uOAB2dI3VXghkOTUj++JXoCf7j+wquabKIn8JcXZOeUniB6Aj8b8mS3sxyp
Ewp8g/Mc35BPpE4o8BnrS5/I2hI9gTMX1k8brEz0BH65aqma/CSiJ/DQV/OC
FlmQuqvAJdo75kptxfVqMX89faLZOz9cVxTv+9cNXze+sI3oic87N1YqvnMj
dVeBdzkqBbbakLqrwNfuWC4tEUnq2AJfaGciXhpB6tgC/3yxrFNSndRdBV6o
mZq0azfRE5+3SlBbusmX6Alc2mhEt4ZkUncVuPB41A9ZS1LHFviVzXGVTaak
ji1w0QnXO/rMxPZGrvt85e0l4qSOLfDuw1Vil48yxXpCvqgk5fDSPdMF6wm8
Y8+CvAsqpO4qcImphzIG6blgPYF/2W0YmnGW1LEFbqTbNyzuEqljC/zBgeE/
ni5wxHoCn+Ly3tJ3Kqm7CjzryLiI3a9J3VXgiz3KxWcLLbCewC/dbnRcbkjq
2AJX/Lrind1DM6wn8OrzxXb5FlgfzK8VKNvIWuB6tZiL1+1YGX8G12nF65m1
PVYuy7vnivUEPqvPk7WjRUidUOBnRuZHqBuTOrbA7URHDZHPInVsgbd0fzf1
m6gL1hP4gV1BOr63SZ0dvF6SqbZpELFbfK7ASSV115dkS6wncN+ZSw7UmpI6
tsCTst+Yq4iTOrb4vma//VFpZYL1BJ6eppfmo0Pq2AIf32TquXI/rleL+cS8
0gtBXbhOK47nP+UV3du5nq67euI+xNugM7T3Mb48bZKLG1W/lbQH/aH9wrJy
6cuL6PqtpD08F2i/7O3TGQEj6LqupD08L2ivNrOh+HUyqZ/7v/vPwu31vTSk
x2WR+rnAx5eu1foVD8NzxHG07JX4X/EwPEfgG4a5Z95db4KfI47vpr8drsXp
D88RuP3XsO6PQo3wc8Txu6vdafMWQ6oOLD/+P+rAQvsg/lzH3/VhSXt47tB+
4jGzuXoahlTd2P/0z0I8COdD4PkC3xu97tXblaRuLF5HHDG8ct0WXOcInw/x
sytJPb9xFdYB+PDlYzObnFfj+wX+4/Bxq3M9DfB9Ad9qvr1yqAup0wo83/58
emwibs9CntE7IM9kcCkZP/Dn3+dcKWLJ+IGrNAy69VEK123B5zrmDO8zpfil
Jr4v4KUS1uzT/ivwfQHP7qk2Uf2CPr4v4GrzY+cH3yH1UoF/kIjcf8MT10XF
PHeC7PoAEVyvFq+TVDdry2gYeuD7Ah403yLsuiKp7wncz27OcJ8TpF4q8N73
V88a/pXUrwH+9l3L3fFOpF4qcLl7HjtGjCH1mIC7uL8dmrpZFesGvGOWw4ex
PxZj3fD67rRp+s/PaGLdgMePtlw+Zasu1g34lPtqU/TU9LBuwNcqZJ8sPYPr
n2LeOnDzDS0LrDM+p7HHI/vLACHRDfi2nn2dQncT3YB303Zku/cjdTyBZy94
59nqQuqiAi/KeLNZsoHoBnzftQPbfkaQujzAoS4P6An857LhuapqKlhP4Mtm
j/uxUW4h1hN4yzn3Mfs3qmM9gZsNnGUxicujQU/grTejxaqP62A9gbOOJuG+
9cuxnsC7Ms6etU7F+uPzG6Jbtx5MG+2J9QR+e//edfGFRE/g2rYjH51zI3oC
z26SHzUwl+gJfHTWdem9a0gdT+Dh1xusDjYSPYG31bzx2XGL6AlcbOIm//ye
E7GewJ3Hlz+UeTIH64nvy/XIvJurF2E9gVsZfZbcqLcU64nv9/HgHy1+mlhP
4NW9xPYXdMP1TzG3OBmzZHkfXOcX79dUfmu4e9ed6Am8RMUlunISqeMJvLVH
aM7rNKIn8OA+L58YK5E6nsCT4uLdZ0QSPYHPXVPsc0WF1HUC7vGmzm3YW6In
8MONo+OLbo3DegJ3v1Z9xO77TKwncJPssLKnHxZgPYHHxxx/pHR3MdYTuMpr
29Wb3i3FegJ/Yuemv8oD1z/FvNb3YLbwhDbWE85dBH67GfUukegJPN4ov3OT
B9ET+GLFeu9bEqQuKvDG0ycPlDoRPYGjc5/QvY9ET+D7ylY+7mNG9ARede1u
hF8N0RO4rFrM6sHHSZ1Z4AYJxVdXjyZ1ZoEPbu/R3UmB1JkFvkFaObT0BKkz
C/zb4136XpGkzizw747bSqbPJXVmga+avqC3ipMmA+tisI4RuSU3+aO/IwPr
X8Cn+wdNtE5xYODcOfCP8ulL7xfaM3CuGvisxTNEa4vsGDg3DNy7s3bN7ae2
DJzXBP5s0LpT69ZbM3CuEfhznWP9vA2tGFj3B74kIqnou6clA+v1wM+IHZt2
8IYFA+vswJXiBtc39rBgYP0U+Puem7L2+Wxg4HsDWH9w2/9BbpaZI8P/vhLm
G9e7jjvh5cDAeXHgzwz2Gseb2+P6GsCN+1+8WCZvx+8zZuL1Dfj+As5rAo+1
TlJ262HFwDlF4F05PifuSFgycD4PuO/10+sPzLNg4Fwa8LXPbub/3L+BgXNR
wGfEqi3rbDHneSFex/CPGt2kPs2RgfPlwG8+kQvP7unA8Pv9mCephqasPGPH
wL4LcMtpjyw277FgYL8EuEXQ3NNrrm9gYJ8Df8+30Ktvcps5A+vXwHc+rL+4
tNiMuQZ1Vfm8O3V7pUndZwcGzpEDr89+LtumZ8/AuUDgXiKPOmo6zRk4Dwd8
V8mqQdqXzBg4BwZ8Xun5b3tPmzJwHh3y04t3/BYc2eDAwPk54MFxsnv7DTRl
4Lwa8CuvNiw2HWfCwP465GXTGjZVi2w0Zmz/kX/F/CNvqv9HfiT4Rx70lfdX
NG/g/RXNa3h/BVyUzxe+8P4KeDeeW/P+iua1vL+i+RUq3wFu84+8Bva9IK+B
8+1y/8hr+PMNOE95xOcp8D0P3qd1czr14rw7A9+rALe+P1DmwUd3Br7HAH7q
/vZ7PXQ9GPgOAfiN9hCZeOTJwHlxvA+mhcZXmeozcE4auISTv4Li2lUMnA+m
8yM4F0vnR3AelM6P4BwknR/Bd0qQXzxtKh/YXdODge9wgN9+FX9l5CUPBr4z
AR7TsW5wAndf8H0F8Pk7957dvMSLgXPewBfK97I6K7GcgfPNwOfOOK5TyukA
53rx945J7Vuq96xk4Dwr8E6ZeS2jOH3AXwEvGTcna1LNKga+F4L4f+LMgHzB
Ik/sr4Cf+yx/Hn30ZGB/Dn/ftkHP/7bQC/sr4K7f/C2mKulgfwW8WNz/3eV1
K7C/At40s/996RX62F8B/yEWu2/vuJUMfIcDcfWKeW8nbuF0A78EfIHQ1KJu
pDb2S/hcatGltOYcXeyXgKt0olGNNSuw/8HnXLS7ndbx0mLg3Crw1WMPjbzz
Sgf7H4ijZBb73hrYpcnA+Ut8Pouvh978Dw7n3sC/fcq7Z1/FzWtw7g24fYRZ
/YA9tsCxPzxueX5A/UbcD+ZjJiw7NvSjNePI7wvic0avXszpFmvFwLlY8APP
dv3c31TpAhz7B9dvkhVDVUzA7/3Hz0D8AO0f+Bg+zYkygvcdv0dH+zXIVGXq
M3BOFOzwLF+P0pu/L/w9RW7Vd8lAOaZTPfTiEacYPH9lBsinj6wk9ceBl/Zd
0JB3g3BaZzhXB+0TZHMG6qyxZuBcHbQfz9clt6c4Xa8cdF6wzm1aoYINA/vu
wEsenfkp4OINfr7DvDz/SC/TfaSOOTwXqLsB/QOflHv6tY+vNQPn84Bv6jME
/ehpCRz3s/t79UPxFlKvHJ6L4T6jyCZRUm8R+Nqt33QP2Tjg6+J91G39brud
tGTgnB/0f6vZfOUHbt6H83nAz8vWmm1MNGHgHB5eZ451sg7fTeqV/+91xThs
V2K8XdX9w95s/jE/QrwK45ddeHz2WjEj8P94ftmVWX5gSCCpMw5cRi2a+XqB
1BkHHv7izjKpUlJnHHje0g+etWtxvV1s5w9bQ239JiE8fuAXPh9U0b6gD/4f
2//Y3BjRsWWLwJ+TeWHSCKOKMfh8NeZwDtOCP2eA18f4uqX8d1PYP3t+ebr9
xk6y7gTtL/tXPDsltxCPH3jUCpnNWmoqDJxHx+tOve8e3BzjzcC5ZPCfUAfc
6h8czq8Dh/rg1f/gafz4wd8axti57ZnjDe8X5iYHq/dEO+B+sD934OuJf6O4
B8/B30I/d6Q3MnO464K/xd9hH3sfajTdB/tb/PtAvsa9T9kPYq7z/hZ/XzVi
4nnZ3XL4fYR54fn9gMoATjc4Nw/ct2/H+pJtcgz/HRrOcw2UY0L83+N609hf
1a7P/Co/xhpz2i/h363m/UxP3dmvTdJI/Wh4H0evP1Q9FO/fxeH3sevX/z6R
ut7/+73LwPZsP1kQnEXWb7EdvnzZ1NFiSNZFgU/xbhr26/d54D3Cdn7yfPqv
c56Q7wNXPWGxpDmC1PUGfui6hrdEA2kP9llSwRZFq5A63cBFL46wmxJJ+qHt
Ezg8x+brtr5H9In++PxLlW7y0J+muD3osHre2xs9HpC625g/3GU05wCpuw3j
H+q4wm6+P6mvjec75URp1yzC6fcCOIzTfdeZn47DSJ1QsKvrp8c+S51AONhV
jF3wcqTqw3ymnnsn/9ybKD8MeQqc74T7+nRURvHXeUU4nwT3BfW4K/7B+fkd
36/OLf09P9q8GTgniuPGwmktDmt8GDgnCvovzn5xq4vLQ5v+YbfyVWs9uzRC
8POa+5UJirS3gX5IfKI8Y4UIF/98pu5XnL/f7vw5VLhfDb4+I5xDxd9LRQoO
dmydBfeL/edhPp6Bc4HQHs6dwrlA4CvjE9v9uDjWRO53PzAexb/mwcj/jBM4
9OM4fZ31Cs5v2/9jXhjNjwfHt/z5zJn899LAZXutV3Ox8WHgu2iwK6gTbfoP
DucIgUP96M5/8DO8DmCfC95erVEc68Mc5e0BuGmE/ZQAZx8mgLcH4Lk2wq4j
Gj4MnN+F53vRyb3lOxcXwflC4Od6vn8RKuKM8xfge6WKlIPvOkM/mBuHHuzZ
pwXiosj/vC9wPhjb1TcdQT4XF8H5YODV79Hl2jAzeO74eXkvnzd8Ajfv/13f
md6fzcDPvTv/3EFnvA/O13fupLgfz+G8JvA9fN3nTorv4rndP8bTQK1jwHgs
/zFOOAcJOmhcvnOiOoLUZQZ+W8Z7xq/41vIf1wU//7/nqf+OB+IE0Dmpub/D
/HJSlxm400GDgl/nP+EcLfCDw+1m6HXXxvE8cBXtbTcVcnWxPcD4l1fsfRG8
m9RZBp64Tsf21+83Aod+5M9nWV7F+01xON+Zvr/1s2zcOMzB/7vwcQtweE8v
Wpnldxs3HHN4v15lSyf0yxyCnzvwB3y9406KV1B1kOH9GpYTHTEpVgreO8xP
DH45SmR2X6re8X+eF77fM/vXj/t1HlXA2wM+F/eaHSfJ5bP87yPg9c+E81LP
3TnO58t4HRLqBVf8g9dRfvg474eBg871R1YnaHP6AAedFai6wKDzuStBRfJT
+zDvI/+eF+Sour3AZ1Acf6/D18mtoK4rS10XnkvWX88lBHNDqh4rPJd1/ZON
HO90Z27w7YF3bv5dj3VK1N98O1+n9RXfHvQx4OurSkb9zS/8VXc1Du87XJlS
ax04hNQJhed7MT3R2XcK4fB8RzYKJSesJPx/P8c4vO6RevnQqzEFtoyHjUYv
F50QzHv1ORiqmiNgsvj5An8fwNcP7RP1N2/ieQnlz9v/8ifEf27i/Wcd1T9d
nxTaQ11OmDeBQ51NU4rv4TnYM3CZv9YBIvH9HjqdtMZvCvj5EBznQx1MsAfg
7lZLr+58Y8P7gf+2t5H7W4dmXgfxtavzRPRD8PM1m+xyU+OCgKn/os7pH4mf
b9D39mny2QKmKOrl/gKXGPx8E91vBHyVtmX68vrDexHUoTApo8mbqZ+5bX6W
XyDeJ0qunPNJykXAJAw66a/uh+tcsLNe3zsh5ihgarw8kHLhNpzvPAk6Wq9n
IWCMHJXUp3AcrtuDyc48ayvAdQHgvQvh65Xojhvta/cokOybqxnJaHr6MCY8
h3Fe/ukR/gH5MHmLjroX3gvE/jw9IVD9a5cNo/TszEblw4FYN+cn32xTOd3c
H1+UQfsC8Xx0M33duDJuPoI6FND/wLRxTlq7+uM6Mvh7UL6u0HW+7g/+/SG+
fhDUXwA7gfoLUNcM7mvYXfVTZ0dX4XoW4DeU+boh1vz9gh9Y82HJjGofH8aY
53hd97JmyhMHH8Yla5brr3p/8LyUk6JCHI8ImOAN1q+COA7PS9JkhLRVmIBZ
G6Eq2MFxeC5Tc/aphZ4QMANG1Dvs5jg8x9efPpl8PUPqA8L9ruLrcoJuMM6U
qYLZ/g2kXgmM8+axzY0GDU2o6VLXyr4Zgfh9yd4y6MjuqwJm0P/VdeZxOW1r
HFdKhFuiwaFjyNSAep26vEq7VEqGTElpEDl0G9T7lo4QGUqm6Mh0cNGgDKVj
qnQi1alcU4oQOm6oFEKZovPez+f9Pc/t9fHvt93az1p7vWvvvfZa38dwmuZh
2fXCdfzlZESb89fFlCcC7Yk8EXvXmQ34X54FlGNg5JYyxnWx8Cjo07RA2fVD
OxRlhMxavNxPgC8P7bBR0yugMD9AGOryVjxEdt8H76rrtj4kxE+ARw/tU1my
UO2kJFCAJw48b2an51oPA4Rk+XMjuJNXk/k22XmRxx080/VWjWbzQgE+PrTz
5vbtf7aJgwT45sDNPhieXiV77oVPDTx+2dw9kWqBAjwy4AekKXPaZM/V8Ayi
fSKVq+yLtIIFeOvAI/apefVIDRLgZQMfq+xt0aAdJKTJvWPg+y29q5wnBwrw
44Db3LK3jRIvEOCFAXdd8inzmjJ7zMDh44JnENf3tVb/pYktwQI8euDtPQ6s
1DgejHlL4pqeq63D7IIxz0l8/96ryc2n0J73iMeXXK56XhCI7+DfrPPE/hnF
9aLYJ6O4zhP7YRTXc2JfnOK6R/k+4W/WHybK+yfGmSkrD4ovPcT+9+fE4XGC
fwr81ba941pl77not+RnHbPHZa5TKPVb8liYxPhOXB+K+UP6nT5bdWB/4igj
zE8SN02ufLFJxZr6LcaB6xHHLg5ODaV+C37kQsX68vpQ6rfg+sKy9hxrCeYh
aTyRpro+q5LFj/4M3lPjoCT7qI0ATyXN+73OXTrjQyj1Z/LLauhfeTlBQv0Z
3Oxy/+vpiRIBHj3w03tqMq1U8F2vlMbnGyf3Nm59Y0r9HDzCqktpkoWlAA8R
vadvXX2zd5Et9WeM5z1Mtu+IksWD/gx+vHZuwMqNEurP4Lmu1086PJRQfwZv
9x8/5b69VFCX92fwuaKH2hcKpPTdATy1xcd/suw64rsAuE3KzIqsLxYC9vOD
X3ywwvhykrWAffvkVTILXVcVMVHAPjSM84HrLOvtIyUCvJa0bmde3PuPBRIB
3kbw6cpX9SbpSgV4CcEPT/N8/ekXqQDvHvjToVc3ihulmHel+4vD88de5puH
CPBegWf12td3idoYAb4n8Dods1FPWsQCPEfgJa+7pce3CAL8PuCxn+a9Cn87
UYCnBr9fFYsJO3vLxp9F31lvgH1oOP5O0oCEd7LxB/uNwWedu3RP58h8lE/8
fcK6B1Vp7gL2A4PHNzss+hDujnUO38z3wrND39/1dUJbjoXg+zvxr7U1FuEN
IfheT/zXkcvObVhC+/rpuQV+FXgiwN2czlm/+dWL+g94ufhBSvhvntR/6Dvm
7d2Tug6cj/VUVK+gy6cDRTHzsK7jm/UM8MVgfBs+KfeuflCoAF8MuOvOpu2W
T0MFeAxxHQf3LkorDwoTjOX1BDeU+xlefGe+olHOFdevjpbHjXIU9iNTvbC/
uPE739GWKMzD4Dri+YP81sssQ5N2sGcY/Kz+x/vTX7JnGFyw63Vb/BP7csGP
C9cS2n3Zl0vrzYbp3TdYuYT2q9J6sH4f68RR7MUlT63zf+es3steXPCUP1SD
pKXsxQVPmrRup58m+4TB2/y1oioD2YsLfq9+gkc/WbuhvmgP75KNhjuXsx8Y
/FCNTv2ILK4v+TiXb8tNvcb1BS+vU9+bX8b1VVyHhvqCJxfltmobcX3Bh3v8
ON/eyVfBL/o8337B/rDDG9lnC67tnKbRp4Z9tuAPPhR4z5vpQ/VCvcNyQhpK
Z7C/F7y/xWBHu3nsKQIvfqSnlvbTUooT3MOxt1unNPbuUj+KmFDds4b9seAr
YsUNUeM4Tnq+3bSgPtrbm+JBvE8uFsYY63D+HfDGvLs9VcuW0nnBddr7ZGvr
8nnB7VTXxKY3edF5wX++OXTdnCZPKp98V6nukdPS/akc8tzP9ar4bMweV3Cl
aCsV0dT5xFHe8TcvRqWtdVfIk8K/0455Uph3zJPCvGOeFOYd86Qw75j3hMeB
jnlPmHfMe8LjZMe8J8xRX8X1Yx3zofDxqC99f9c/+S55BfuawPvEWzfWJrLv
iL6zNCUUzbvCviZwUXSA72d19saAG8Y8+111Qyi1A/jY91PDtSo4vwn4aQ2T
tQtVZlE70H6cbaYNvhmc3wS8Mrq9dfSQ2VRf8I8+Lcb5EbOpXhgPkmx/N4ic
wD4c8Cb17EsH4tiHQ9/3R3Y1e/CZ46d5DGeRe7rrFIof3NZR9mpxdzrFDx7p
89vs3TozKH4ajzeMuenXwPlHwGP84pv2xMykOHF+g/7HZgwxYz8n+NoM+3Dl
TAnFAz5OVGHUL3UyxQOuolWldnzfVIoH/ITSbj3N0ukUD7jGj52u3sp2ofPi
PFmPtKyfjJJS+eCqd2b9teqCE5VP+zhKUha9tphC5YN7uOwS7x7FHlSUN7pU
zc90EHsswc/nxlw0cHBmD7b8/4LnvOuUdcGRPAD43eeJii18Ze/pdB+S/w7m
a1utMTnFvghwr5YSJV1nPp58Zi8HvYqdwf528KlvbPpOKQmg43HdtGcnX0/u
zt5y2s+bZdj34lb2loNHt8yOGPAygPob5a/IG7q68CF7+Gldgcaap3XVXD64
/6WhXexC2e9N7+MqrZfTn7EXHXxbj7NlxYbswQNX8d7cqFLD/m3wHcv+7bCj
0Pu77/sd/cw38q+ISsL/c4U95OB/FPStE4VxvjNwS9Np6c7d2adN8wBaN283
h7FPG7x255bE9F2BdN+n51j58y3qBZ5xZmBhwCv2+9F+VeNa5eVGnlQv2g+r
fm1b40fOR0bzA25fykZ78X0E/GxN/pfuTnwfAT9tsCWnypjvI+AvOjvX6Cnx
fQR8/+dh47v5B1O9wI/133dDp48n1Qu8rGvWpiZjzjsGPuLMdJ2fe3LeMXpP
Eb5mJnhw3jHyIYWfKd/dwJ5txXkMcFpP25bj7F/DPmrFeQzyFcvjXeOjsXbK
LPYV037AXbotX+PYYwmefdC/aVyaQOWgfj9IS33m5HI54DOUBh7x/8xeaNq/
FhVXHecsofJp/HmVFzTCRcy+WTmPfas14JSbLZ0X7Rfs65ZTo8s+WHArO/2W
/PnsywW3thzwsksm+4TBRyZ1M1nTR0rxgJu0Fo91TDaneMBrM3vZDC6bQNcX
/FZ9cdrwSRMpTvKpr/wrw2Qpxwkel1yhpp7JcYIfybyW49KZvbXgCSM1Th1Z
xN5a+i72xPOzeiXHD77DYW5J2xwRxQ8+LU9SbRUopvjBI6M9ko6WsL8XfPWg
fimOj7heGO8bpYdO9szkeoGvNt+U39DK9QK/ddSmVOTI9aL9QY+V/5mTxPUC
j05uNsrv8X8+Qzk30k10KVzDvjXKM6PgAwTfGhB92KpgNOc1kHM3Vf+Dbbqc
Dwi8bVDcnjuHragdwCvCa/9lnc2eXvDdl5tLdjjYUTyon+Tm8UaXbPbxon75
z4b4va3kPCDgE/s+2NfDiL27qEep6iUlJ9nvgtZZyuvx0ny44f4MEft75e19
Kk96frwWe2LBq5Wjq/pcYR8s4jz01DzomhFzxOO+wM3TxZH9e6jHiWbRnndh
7KnD8y3WR+F4ep4xPTFqxCL2E6K9b7z54fziSva/gSv6Bml/pZJNQNwgvu44
vuyDrXmzvwlxGl+Hnom1qx5GHNfta9Q/Ni3oy/m28PfzxVd9ymXPjTiv4vpS
xAl+oVfQuUWV7PPE/01q//Nxq/lCOv478xjfzIeAK65HAkf8nRtVxkbXcTvg
71vk8yEd8z/ye01H7xm/H9H9Rl6evYIPkN7P6uL1Ek+zPwr9aqbtZsfCJubo
V1tHz+6d4cD+KJx/e7VBgkXlUuFv6G7luw==
    "], {{
      {EdgeForm[None], GraphicsGroup3DBox[{Polygon3DBox[CompressedData["
1:eJw1m3fg19P3x9+vcV83e28qMkvZI5tkhiJbyCjKiLKJrMyKUmmgklGhQSRK
2ZmViFChyI5KJfwez+/z/v44n/N83dd4v153nHPuOc/P1uddfuJlea1WG1zW
agX6Uf5k6G9p3B2wPjKE47ZVrbYB+GD04egDMh/fyX3Pcr4r953OcVNkLeQG
2q+mfQj6VO5Zk7aloVY7p/L5i9DXce4qrjmOe2/i+EDaz0cfgT4I2QwZzvHD
6GHo85CNwc3RzTNfr+PGHF/Cc+bz/E145lDwlTxzCO0bcb4ZeiiyCfhI9C5c
M4lr7uOaBuDR4JvBt4IfAw9C34TcDu6PPp171ubef3j+LRw/SPsA9Lm0r0d7
B3Rbzl1P+y/oP3nWBeCD0F247lvwSegVHF8KPgLdm+PVuPdq9N8cX077UehG
tK2euV+WF/6u5uiVyGXgI6W5R4N0KXpnfrsjh/P43Zy2ueD2+h5wicwHP4M+
AVkXOQvZL/N7X8P9XTjfgmfW4Xgd5FqOz+D4TvTJnJ+HtKB9JHoUEsCd0X1K
v+e16H14hxv1HZE5RNs87r1I9/NObdDrcf4U8Nng/bjmMJ7foeZnan7tlubY
MdH41uAx0Fh0Q29K257Iqxxvgd4LeU/9y/Uncv429G8c76PvQ99L2zT0Peh9
OXcM+hX0hpzfA3mOc6OCn3ds9NzcV/3B8TCuvQM9Dv040hv8Inp46XeciH6i
9DMmo2cjR3Hv0+iR6GORbzj3K/rkdNwh8zVf0N4KfTQyB3wK+piEh5b+/efQ
i+ifk8C7og/lPY8Hb0Mf3lJ5XVygMUefiOyAtK+87s5G71p5TH/gvq941uXq
K/Sd6DuQFZw7kXNnqL/49msqv0Mn9APoK5C/Ofc59xwCfkp9gL4l89jfp7mJ
1EP6aC4gFfId98TMc3H3ymv/R37nbtruSnNxq8zjp7HbrfIcX8Q1c0t/y7Na
K8iV4PfRO2Wel5qTNY67o86kT67l3uNovxK9p+wI7T/znB84dyJ4F/RipC34
APS6lb9X3z2X4+bgBuivkcPVt+g3kB3BddDryAbxe//QP4v5nSnIdUgD/S7X
HMJz3uO6XcHroD9DDtTcRM9GDgJviR6BrAlegS2dBt4FvDZ6JLIW+G/aXwfv
oL5DP4bIFi/gz5DC9vh78NDif59fWwR+QmsVvBj8JHg18J/gp8Crg5eCnwWv
pzkAfg68vsYC/DR4DfBf4GfUL+CF4GFgPqn2E/hdcBPwWug3kZ3Aq6HnI6dq
bNHfIKeB90B/K7sP3hP9KS+5GHx26T5pAd4RPQs5Brw9+m1kf/Cm6HeQA8Cb
Ff5d9eHm6O8Kj9de6I+QPcEboA8OfuZZPP+rNNZN0DOQfcAboz9G9gJviJ6O
7A3eCP0Q96zBGF6P3gZ5lPYraP8SaQVuLL+nzkeWy07wW4dwWJcxn8O5luCd
0fOQUzR/0U+WtiGvy1ZwXMn+c/8Y8IayAeAtOdcf3JG2rcAPgy/R+IDvBZ8L
3gLcD9wBvDm4L/hijQ/4HvA5Gn/wjfIj4LXBd4HbaK6C71afa95VtleynwXt
N2jO074RuBf4AvCHpe38zegNuP4c2k/l+ibgc8GngX/mfEv5SuRi9bXsJPoi
5Mua7em7pe1Ee3TjzDZU9mvnzP2s9X9Zsjefa2y47gH0hbzDaGQDrVn6Jy/t
N1vRdnHwGtdkn8hxPeB/XPM8eBPwEvAL4E3By8CvgrcGZ+ipyPbgCj0F2Q4c
0OOQjcF/cP0r4Pp6PnoSso2GGz0e2Qy8nGuy0vakJW0vajzAK2m/v7SPORO9
VrJFZ2ktgrupD7WGFDeAW2vdVJ6fzfmm1eWjwKdrvYJvVT+De4CXag6gd6w8
Dw/n+l0yxxvyQy9pfqBX5R6Tg5MfeZPrO4G7V45FFJN0lb2v7F8eQt9T2ZY+
il4SHbscCL6zsl/ogz49OK74Fj2LtpnIIOTuKvlT9PHce61sP7gr1/XU+qVt
WXTMdCjt7ZBVtDdCL6K9mdYb+Ffwa3zDcvDHyP18x1eKyyrHJM+iByM9wG+g
xyCjZf+R0eDn0C8odtM93Dsb/RPP/E9rCP0zsga/tSH6F2Qy7X9V9pHylbei
L0bqce+8yv2zRLZI38V97WTPuaeX3hW8tWLJzNd8hkzj+Bd0ffk02v8Ef6o5
XdgvNyzcz/KBe6D/oO13zZOkFycs/6k+/Ba8FdfNko1FX1jZh7dE90WuAd+L
Pph3+5hrBsn2lI7pDgV3zXyN4rqHK8ctbdCnplhDY6Dx1XtuV3kcDta7yJ8j
08GDFVeAZ4AfAb9f2NZthf4h8/d+kuys7O1OtN9eeT3fkd754DT33lVcVXo+
fIRsDa6LnoZsCt4M/TGyLbgeegayPXhr9GdIE/D26E+QRuAG6FnIzuBt0Z8i
jcHbod9DNgNvjp6JNJQtR7+P1AVvgf4QqQ/eCj0g2uYG7SGibXEJ7h9tcwvw
o+BRfN+f4EHgnWiP4IHgHcEVeDz4fPBh6F7R63wl62AweC9wHa75AFwPvCU6
w0FPkb2mfTrH24Hro99G1gdvHD3WiseeQk/leJVsudYK8rvig2h7rvj4jMr7
Iu13bkYfVjmWPRO9bZpzGpft0rhfUnl+aw7fhp7Cs/6Q30C/g2zAO2yCfh35
R34G/QZSKR5Hv6y1pNgFPRE5kva90G8pVgZvhJ6gtad4Av0S8pPiD/SLyI+y
c+g3kSg/o3WJdAQ3Q09CWpTeC7yAtJUN0Vhz37G88w7ohYX3DvugT6hsexUD
a+6Mk48r3K9jwd0Kz68xWmeF587L4LsKz6kJ4O6F58gI8HXg55Pf6ofeAXle
fVV4Tr2kNQT+OrMtGo40rLyn+Sp4fo0C31A4ltD+9yZwU/lFcF/wfmkP0g88
knteAR/JN+5L+zvghxSbgN8C9wYPDn6O9tOvld6naE+uuT+R9rsLrxU9557C
6+wZ8I2KYUrviR5Fn1TZv/wR7Nfl39Xn8ivyL5rD63HPHvJBXP+k5jr3PoH+
UX2c2Rb8jDTIbOOaBcc/GqO6sh3yZbIr0f5wnPZ0XHOCxo7n7E/b++D+GrvC
/vQq2obKtqW9wzLZ4Mzv17qyf/wz2KedlPY1rSrvl7+h/eTK+/Elwb6xSfKP
2p+rXfvPo6P3Yf+hT0uxkPbsp1S+VvmHYdx3P1Jfv106zmyD3gd5G9xH8Sb4
dfADsvGV+0Jx4BeFv7GR1gyyu/qTaw9CPgIPLGxD1X/NaTsu9ekWWrscfwge
wPkPUh+qL19LY6ExmZyeqWcfwPUfyMYX9m99wO0K+z3tzbVHf0T9k3mNf194
f71vYX+q2E124Hb0Dcmf3SZ/mHxYw+S/tM/pkjk3sFDPLb3HOVxzs/K+p4d8
ZdrnLeDcG6X344+on9BjU5/Krgzm/GUpLlLMeT74pdIxzcOavzzrWfBzle3l
SK65Xn0AngrupT4ATwH3BM/n2jGan8iutE+m/X7ad9M6AfcobGMUk5xX2Bc9
Ar68sD3rAW4L3qtyv+2HfqV0nmFg6dhYe4FOhW3zIPClKQ4frnlb2Oc8Du5S
2KcNA3cubAsfArcvHBMqbr8IPCdz3PJ4im8U53SWfQ4eX80H7WuaKa5Af4Ic
LX+Nvp5z52XOccmfy68rn9Ai4f+PsaQ7pWtOTu3aryunoHyCfMUFmfNjR1TW
yp89XXk/vZTf6lI53xDqOJbX3l/xfce0BleCR2Uee437mNIxvnIVB1TOISkH
dkjlXGDbNE9OS3PlFcVu6Vg5hlbp3RT76Xn7p3naMsW0S9Dj0vEz/MbFWoOl
x6tt5tyL4lK9513oaaVjq8+SzdT3KiezoHAeaG/Z8NJr5J3SOYaO6btaprjr
0srf2jHZnO9K5yfmyE9XXhOPoe/h3GOZcyCKfTqkd1Y/qj+PL+zzlRdSfkix
Z/vMOcxHMufjFLdNzpyP05rTXkz5kw+05hQnKT5hLBZljocVb05JWjGnYjB9
70nB/ds5jcuz6XkL09rU72pPqpj5e9o2rZyvVR9qnCaUto3KbynvqfznXeDx
XDdA87bymhPeXO+ZfKDysIrP+2fOo85I63JgsgHaN9RFjuJb7uN53yhm43ha
5nveVuyeOc6fX3quaU95dfpe2aVrUl/NBz+YsObBdMVTmfvowcr5w/6VY2rF
1jrW/bemvlIuQnhW6THTNYq9laPqljlP9UlprNxs/WTD9P6vls71Ked3cxo/
vcPL6ZtfQv+d2TZ+msZec0DjqN/pnd5Hz9f7NeP8C6V9kPKL+1bOgSsXLtt4
duYco/KybTKvK+Xzzsh83VvIEOShzLm3wZl9qGy6bLv2KW+n6/pm3jdJK++t
vpcd6pc5J67c+B2l55DmktaQ4vpemffqLaLXSl7H364xUO6udfCauivtj3qm
35dPkm+6nXtmlI6RPlJcppgMXMjfcc9/mkfopehf0hrqktbCuukdZTOVr38N
eTOdfzfzt+l71Pfz0pzTnPwqzcu5mWO14altbsJTNdfSuH6BfJl+R+cU16ke
oDyi8raysQPTszXnF/ANdEXtt9z3j01z4+F0/yapTx9P7/x5+j3FFz/Jv+he
9CKkAfhX9PfyN+BfSv/OmPRbsnfjUp98k9nnPZG+9ZuEX5TPyLw2tTf+IPOa
eif1Ud/0vI8zr1vNhU/TvPkk895+UDo/PV0zNp0blO5/K80xPXda+j712Zz0
nfrN99L52Zp36fkrkN8z7x3XrLx3nFL5m/XtP6D/Sed1TntR7Ul/Lt1H6qsf
S7/v7PTMaWnM9Lu/pH5bWPrb9fuyQ8NTbuf33GP4fGZ/qLkzOc0fvdeqzHva
9yrjHmmvrzzfrNSu9aw9/uIU/ygOWpm5XWu8H7+xB9JOv4/eC7k4s33+LbMN
0+8vS++gnPyh+t7KY7s0je9fmXPKsh3PcG4E+jX0Z/KhPHO1yu+lPOSstH60
jk4pvX60jpQ3UH/+m/r0/hSnKV6T7/gzsz1VHm9Jml8/pL5QP0xAv5o5LvmC
e3bjt25Az0FuyP3OV1ReG8q1T0SPT2tlkuZiZj8vLR8v//5SOqd2rTnFhVo3
8k2vpbG4LvWX+lPrZGq6ZlS6X/d25/dvRA7LbBsmpPdUv/6a+rYb53fIHVP0
QO+U24c/hN4FOTdzPud6dM/K+R89TzXHnpxvlNu2duS4Web6XR/aGue2v5tx
PLPmsXgeeTlz/NYvOo+ZV445ZD/lXwZUjot+wka+nnycfF0HzZHc49AR/WFu
27cd+r3cebrJisnQM9GTkKfAM9CvIk+Cp6PbcO3k3OvwF8Wv4Imyw+iPcvdL
W/SbuW3Hr5xrD56KbqraQ24/0Ux1hdxjebTqAbnXSSv02Nxre1zlmG0s+ija
Hs/9/c3Rh+ce8wvR6+Weaz/Lh4EnVPaPyh8KT6ft0txro7Xytrnt1zl6r9z2
umvl9aScxlyNUe7f/Vr7FvDV6LroO3KvJX3HfulbvuFcr9zjOwl9Vm57sQ16
UO768ET06bntytbogblr19vnnkOaP9qPyI6pP79EtqX9MvQj6ENyr90dc88z
zbFulde98oqKq8/PvHZ6c3793P55KPqI3HO6Ye45p/k2DH1k7jmtXKj2usrj
Pqrvy20/VI9TPK9vn0Dbablt9PGq5eT2hS+mNaf1orzRLcy9kwvncrrJVii3
UBlfFJz7uRJ8NPqm6NrYglQva6s4vHB8tRx8IbplcE1HOZ9eHP8FvgC9YeW9
vGpuD2qfDb5EezuOO4PP5b7LS9egT0DvnTlvo7jhQ37jMHQ99EzkKPC2sm2Z
c+DK9fQsnRc4r/QcHZlsTqfSNeVW6CtKx4aq+44uHZtcWTo+V5ynGK8F/TQq
tw16S7kY2jbRt2fe5yjuVH1Bda410S8jjcFroCcofwRevXAdQbWn9bUfrLx3
2yTYD8kfrSy9J9PeTPGDamqqWfybO6dYF/xPbk6Fam3fgTtwz9fg40rnYJVn
eLBw3vFJ8LWFc4ovKE7TnrRyrKo6/4jSMVq70jkK5axuLxxvi8/wDO92bOWa
lOrbyl8+oZi6cI5L+9mrC+cPh4B7cc3RlfcsjwTnZlTfVWw5hXc9O3c8tYhr
1slto66QHcrt8+drHef2SV+hr8ztkzppLeb2Y+9zz4+ZbdG+tM3IbZfr8XuN
+N0VtG8aXK9Rf+fBfaW+FDFlZm5/OTLZSdnLzrTNzV2vm8Xxmug/KvMQVIcS
36Qxz2mq/q+891cdWXWl5tGchXvQR0TXA+9FLy3Ne9FYaXxle2WDFyNdZLsq
x7F5wu3Q83J/W7vg9aU8at3g+bOSa3YInj/a62ueqg6uuaucr3K/X3O+X+W9
hbDGVu2qlym3r+vlU65K47IlMrDyXkP7eOX9NGbaq+r8vema/ml/NJd7tw6e
5++m+d89rQHZwq7JHo5Ifkf+p37wWvgbvH1wbmoV+FNkba5fgl4/eJ5rDa0b
PM+XVba7Nyfbux7tW9G+lPYCvE7NOfYBnL8pt999Q746d5zbnmuuqDkHfnWq
Ayqn8gnnL9f4cs1g9C25+UG7ovvmtr/HKD9Yc85Z9TbV3WTb9iucX5TtahFc
v1a++qjgGq7y1U1T3kw2ZzTPOyF3TL23rtP+Df0t731i7tizSe44QzFGg9zv
pPf5nmvWyO2vf0DWyu3Hx6NPzh13j0Qfmzvu2Tu3z9DYjpAvyh0n7Zw7FlEc
ohqeYgT5I8Wf7ZLPPDDaFt4aXa89t+Z6wf7RduV69BXB9l95uAOi7XE31SuC
7XAOvjzYdyg/3wl8c835/6aVc6ziPd1E+/011yxuDM6nqXZwVXA+TbWA/cFH
ankpzxztE25A7xds5wN47+B8VwE+MJgPEMHngM+vuTZxfDCvQHWHXYP5AOIR
7BLME9CGrEkwf+A/3m3P4DxqplpJcO2gjmpHwTb/X645IDi3VtH+YHQtdpW+
NTg/qfxfn+g6+n+03YAM0DMVPwbX61XYvy64jq9rLg2u3a9AXxJco1+u/gi2
scod3hVsz1Vvuhv8VM11qO7BNlm1p8eSj3y7NGdCtcI/0B2Da/p/KdddOZf8
I+/YLZgTpfjzluC8pd7/8Mp7UPHdOgRzA5aprovcV3Ot6sr0vZoPfYP9i2pb
DwX7EfmHfuDxNde/jqq8xxVv7pjK+1Rx8B6L3tvLDsh3iJulmoW4ZOKDiRf2
eLBfk48aF1xnlK+7Npjn8C/6muB8qdb4cPAbNdfRugTXsjVGPVNNRDWW1Svn
2n/g9zsHcwn+Drbpsu2qL/xbmFMnbp24heIhiPfRNHqNi4OmmopqK5NKc8MU
d4inpj5UDuOv6G9XjmR5dM5auevxpflpL6OXRn+zvr176fqs4hPFKcsKxyDi
/R1d2pYrpmqR/L78f+eUkxLHSbk55ehUs1ZsI/7cTL1HYU5V69J1asVUiq3O
ieZDvBE8LsrbrYiuuSg/obybeHHiX4iHpRipNe1flLYb4lyJeyUun+IW8fvE
1ZTf7Fu61je7Ztun2phqZGN1LfcsqrmOLzsjXqJ4l0uK2v8cpziJqj+pDvUW
+u7SXC9x8DqmWFExo2oGqh1MLW1nxFn4M9pGibcm/prywsprqr5/djSH43W+
t000t2aqclHRPJIpwXZ5XG47Lb6ochvKZa5Wx/v5dyvbzd1z21HVvJTzUB5P
uUT5xd6VY/s9Ob+gsp9VTDkIfXWqdc7ht64D/1aYa3pZNMdopmxCNPdohuZ2
qp9+qXUXzTn7DNwl1UY/l09PNdMvwJ2jOX+zFT9H85k+ka2N5vHItqyZ4ijF
U/Oi64u76NnRdccmqvEivxb2+1+nWmNj9JfRtcZG6PnRY6Na5FfRda+do3Pd
yruoLrM4eu6KH9gzmnskW6c8g/zwO5X3uR9of4d+IJrXovWonMZBiosq76/r
gxdWzidoX6n9ZZ06zpGNqhzLKu4RR7FTNH9uFs+5MboO/h34vGguztvgi6O5
eh+CL4jm9Lyr/Uo0r26SfEg09+5V8AnRvLrn5f+jOXCvgFtF8+rGgy+M5hJN
A7eP5hK9Dz4zmj/3mnxsNPfoTXC7aP7Qe+Azovl2k+XHovk674Aviub2fQBu
G80xeksxTjTv8FPFING8vYng1tHcvgnyI9Fc4d9ky6P5wYvls6K5xd9rLKK5
U/IRd0fbPtV8u0dzhX+X7Y/mM8kXnBzNF3wZfEc0t/hX8O3Rtka85ZOieWwv
KYaK5gW+qBghep2LU9oympv4ArhjNK/xY/nBaE7kdHCHaO7gR8H8MMWb4pFq
3YhLJk6Z+GOqy6g+01TfX/Ma2THFCYqZdw/OxWk+bFm5lqqa6ubBHD+N0WbB
Mbb2DlsE8/3U52XhPcWpPL9e5Rquarnyp8qriYMjvo7qKOKRqpat2q7q2PsG
8281Ro2QI2pejzsF80W1xncL5sYoPmkYzCmVHTixMm9VdmPLYF6i5qr8l3JK
yi2dH8zl0/ieF8zT01hcEMwf09jJZ4lz92o071RcIvFxDonmiz0fzVNV7l+c
pa303jX3+YVI15rnzJnB3HKto22D864aowbBPFWN3eGF7bl8zTbBcZf2C9rP
a1+v+dYG6QReqGcU5k2Jf35EcA5B8bb4x6pbXFWZK3Ztsqvi9l+YmQ8j+6Q6
pfjFmyefIt+iep/qc3PTHu3WmrkM2qPdVjNHQLGl+ADiBYj7Ig6MuGeqJT2q
PXjpvYzyzVUd56CVbxYPTTlW5Vplcxak/Z32eeLGiSOnOp7qfAtr5pJpv6mc
dKzjmohyGKqBiJulGtUDlXk54ueIU6daauv07arhKr4QUVe1yEtSjKca0Fkp
lngTuSj5So2p+BXiWTwSndfWflb11tOT/xWfQXGI6kWqvZ6dsOo34vKJ6626
0png6ypz9tQfRR3X+87JUuxS+HvFsxZfQntP7UHFBdRz9DzVcbqmOET7oPbq
82ARll87IXgOyCeOTfGeYrwxwXX8Pbnvv9L8Sdnb0cE1/T1kL4Pr+LvJrpTe
72vf/VxwTX932peV5jDLboucLA6k7PkawTxPxT9l8D5UuYLVg9e74oRM9qJm
X7BmML9adnvtYD6z/MhawXxv2eR1kIY12+0QzBGVPf+rNHdatu7f0hxR2Wpx
LZSzEn9TuSft7cVdl40Sp+a36FyNOP/6/wBxx5RDUy5NXCfluJTrUs1X9TJx
i5aX5sTKH/WO5vgqThb/UHUIxTD/lOa+yoavKs2Jlb+QfRMf5/fonJRyU7Lh
xxaOqfQ/JuJTKRcnHuuK0vxk2faNg+sv8mVVMJ9W/q5OcO1GsVb/YN6UuHmP
BteLdwAPCOZviKf3MPjpmvl4Q4M5Wg3l34L5V4pDHgvmaO0oXxfMs1LsMTCY
TyWO372FOU6Kq48O/j8axUtHylbWHCMNCuY+iTd4nOxdzXHUhsEce8UDGwTn
PZSj2CiYqy//HoN5v4obn0RerDkuGhLMJdsJ/EBwnVR8xR7B+yztQZ4O5pUp
1ro/mGciruOIYI6W4jHl4JSL2zX6f6K0f7mNe4cF77O0J3owmEMiTuB9wZwZ
8RX7BO8ftRe7I3h/pL1k72D+iTiTtwdzTsSBvBc8sGbe4z3B3BXxD28LrsmK
e/ldNPdIa03+Q35EfKenonkn2iOPjub0a4/8eDRHX/mrIdH5UOVwno3mvmuP
vyqaPyc7MzQ6f6r8z8Jo3qrW+IJoXpTW8r/R9k7/a/NMNHdfeYCV0fsl/e/G
sOhcrfKBz0X/v4HyBnOiuUGaSyOjufja74+K5u4rjzEimjuo/MAT0blm5awe
iubQa//eN5pzr33999FcWNmop6P/P0H5hG+jeVcau+HR/5+gPNjY6P9JUG7h
82jukebwF9FcJc2ZMdH/C6GcxuxorpLWyJPR+W7lIf8PMYEdxQ==
          "]], Polygon3DBox[CompressedData["
1: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
99V73iF6mr2N3cZ3L8y/K1pV/GzRW+LvFe1Z2OfF16VtJ/FzRO+Jf0G0t/gn
RB/kbuOMnMH5Kn12dlHfXNGH6nsl99l6RPR27jOGjtqytM5GdzXTnH8kfoCe
f476hmjsY6IFua/ZRe2fqf8Enic4NilFX+aOURbpHl+I9hbtI3pa99it9DON
krwfZxsfA99Q9Lj4VqK7xL8vaiB+fdEI8T1EG4k/X9SSdxPV4rsW1ifolYV6
3nMlN0v6ZRPxF4ja5I4hfg+Oo6brGXZmfdTXQnS7+h4W3SJ+a9Ykt0/eS+MO
1vhPRDvpwn3V95To49xz2FW/8R++g/oe1/12Zy0Lv8sbPAN6Evso2pFYTeM3
ww9X+6P4L4VjJmIlfPKDxb8k2k78t7RFt8E/Jb5v4RgA3/8hUUtiwcJn687c
sd/1ovtzx4C3F95D7J2nWDPx14nuwwaL2oh/kGcQfw9+V+EYj9hunqg1Y3km
8XeL3iwcQxA74ON/q2e6u/DYB8TfW3hPshfx2R8ovOfYa8SAgwv79Pjy3POZ
ws/Aby/kGZN9xf4erP3xZOFn4Lc/Eq2g31igvu00l49o7AfqG13Y1/lKtDX2
XP2f6x73os/Ud4woF/3B++n69vq/Djqu9l49UPRN7j27la4fous/QwewV9U3
i5gp9xytRQyKr6Tff6D23pleeC3YQ9uJv4kzIn62qI/4G0WP5o7Z1tb1v+Mr
6voHa++1GYXHsucYO1X0QO5r/tC4Cl1e2p6urL6j0rssUfu/6m+k/zeXtl/s
zWGF54o9ekPwudlf9FjwvmP/fY+NxG8tHLMSM/ROcQTxRGPRyejewmeQe/TJ
fVaHF14rziy6a0DhvYUO+0nX/MU+Q3+I74XPnxtjAGu4H/8u2L9dE92ia09i
f2PDNW6B2k5Af0heRfxtGjtA7f9I7q3nnR4cJw5hv4JbaOxhou8k/yq6Pvis
ny/6IDj2XE3UK3cMytk6VLQ49xm7Qfw2hbGSR9A5wddOF30ufkbw3OzNXhZ/
Ffolt4+HrzczWO+Aj8wWf4bu1Ui0leS+uXXPpoVjZZ7rdPENRVuK3za3rt6n
sK5DZ59aWKdxTzAIbBq2DZ+hSeVYvqOof+6Y/gg9z5r6P0m//R+2XP+nZfZH
HxV/dPB744/eLX5/7s0elfyZ6G+1raz+G/Qb17Hfdb8uap+s9r8lN9RvdlD/
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
          "]], Polygon3DBox[CompressedData["
1:eJwt13m8z1Uex/Gfu/wurjX7Tkn2uNnXUhEVWbI1M4UpRZYmkp2SEBJtohkx
lKVFGVlaqLGWpSZNTcuMpoYUWcoWmefn8fXH+/7O+/V9f873fJdzvudW6z+s
29CMVCr1CWVTRk4q9WVmKlWPbuEbg93TqVTtfKnUk1mp1IN0vczNWDWsuFxv
rCKfD/+Cr0td1DZSWw4/qF0MaydXkD+Kn+U70DDH/sivx9cZSE/6WL8b+H9Q
UX4H/Q97l/+YCvPb6TvsHf4jyuW30bfY21Grz4/0X4qaOkdt/j1azR+RK4Xl
589HFqse48HqYScpn7Hego3BBvGf0Md8aWqG1eFPUYZcV2wsNpjflE7GGmNu
Qy/zq+gHuZ+ykmORyaVr+aN0ANvMv0BPad+lvyn4dXFt+vyAL0oNnaM63xqf
5Phz1EC+L38c/01mXlbyrOKZPU5zjKE0HVE7h98rt1OuCDXALuO34SfU7JPb
Re/z19BD+lpIeY7dxnelmtpzsXtjfJ53zxi/fh5UN4oy9XtSboPf3HgX4tk7
R1r2G/4q6oW1wnrGmLXv0ceN1FymXjphg/ibqSX2X7kLWH3Hemv3oXZU3Vhm
ydxGbeUuobR2P+eYJT9cJltNpRgv9hw2HcuPNcYewdZiS7GZ2Jfa+/FvqHP0
FderPUruRceelrs73j/nnepaq9A9fBZVlBssN19umty1dLncbPwOulp/OXK1
Yg7JvST3jEyDmDdyw/Au1EruOLZU5qj+H6B9fB5lyt0n043ayBWnC3J9qZhj
LWUGUXHtaeqq0mC+IWVgw+NdpdbqTmObMpP5G/P4Jr4X1dd+VmYcNeU/obH6
yabmjg3kb415Y/x3y3SiZvpbgs93fKL+pgXnx9Fm7WVxTsfG8yXiPvD95Wbr
Y5i+auOntT/C98Zzl9mIveWc5egVtW+lk+cez7+w40fVj/N7IuaX9nm5SvrI
zE7WhFgbjujrIK2IZyT7n5hDdKtcS7kica/5jnQfdjv2s+zrmcl7HO/zp+Gp
nfZS2qjfN/hnaKr2Z/pfTh319Qu2Xl1BqqO/4hf7K3LxOcbzXCR3ONYOmR7x
Xsr143vI1dHfU9gYai+3OM6D/Un2EewGPhvfz+dRT7Ut1GbiFRwfhD2LPYr9
GOsYPwLP0Ucjmf3YT5nJfIs5FnPtGv314x/PSt7XeG+LYufiPtFEuYFYMex8
nJMmYXdhZS+u7aNjPaUy6WSNjjUu1rpDtDLundoB2nOohmPXxZixr/RVn7rq
o0l8E2S38WWpBVYZayF3U1ayHsSYY834VW67TDlqiVXFzmBb+TLUHKuCNVXb
Ud2dWcn71S3WcNorU5KaYLX4Y9EnfwMNx+6MdSneff7y4FhdrJT+CulrIPYk
NhJ7QG6Ka69BnVzbqHTCbo33j/bgX8f8o9IxFrVz1U6Ob0zM1VgfsJnYWOxK
52iBPYPtwFbE2KgA1ht7GLufLy9XDhuBLcGmYI2wq7Hnsb3YaqwMVgIbii3E
xmGjnXdNnCMrWcua8SPTyfxejL0a/fI3qt2ivZUaO7ZK7Zd0WF8bHLtFuyt9
Ee8bth7rrN2F8rTbqFuA73beV2O9xupi0yKLPYcdjDnCD81K1sFYDy+Tq8M/
iq+Te1bmUqw2NhV7E5uPfUbfx3cs5hLWIdZTuVZy87EPsZdjHY7vCjY9xo0t
wB6iedrr8Q2xXslUoxraD8m97tg8mYZY6/jWYruwV7CrsLbxbcT2YK/FPgcr
i92PLcYexr6K74fn3z3WXtob66tcc7mn5bbLLZerheXFHMQ2YS9g79Ir/EH1
l8TeLPYW9Cp2CCuBpeO7GPNV7R/wGTEX+bdpBX9GrnAq2dj9jV7ADmDiqVP+
rMEWYd/Fdxs7GXMs1kW/vwemx3ed30yv8T/KlcRy+D2uZQS/ny64tl2xR3Qd
V8U8l90st1iuDtYEm4dtwV6M9ZlW8r+qLYLl49+i5dgprBB2Qc1abDH2fUay
Nz0d64f+6vudgW/EFjpwBdYAm4W9g/0Fq4c1w57CtmEvxXqFlcSGYc9jE7DS
sW/AhmALsPFYVexybDK2GpuL1cWaYk9iW7Fl2AZ6kT9hfAWx845vxF7CfsFy
sd+wmmob+p2Nv4stknmTlvA/yLl1qTOOr8eWYcewAtg5bB32V+wwppvU2VjL
Yv2MfUB8A7F7Y7/h4OCsZG8We7ReWAWsMj9abrncY9iWeBdijxbfVqwQXy2d
7A9r4+3li/LfZiff2E366Kt9G/2d1mA/qy0rn8t/F+sn1or6Y7/jx8aeQ2ZG
7D2NpT3fA39C+2v9b6eb9PtP7N/qLovzqm3OH6HT/PU0BOvPl5TNzUr2xbE/
XqS/HfHOxEsb+xc/JaOvqOc/j7Uj9jFy52g3VoWukashs5XW8qeNrzxWmL8+
nYz1ebXvxDeYz++838o1pj5ybeS20zr+nNqKWFE+J/aoWCPqjbWOeal+H18j
9hexd40XWO5T/grqxF6JHaATfBu6E7sjO9n/FdL/SDphLH9WNxSrzs+lKbFP
4M/KZjveQ+0EtUP59/CBMgPovNyH6WQ9jnW5UE6ydo/yuy3eQe2zchXUFom9
QXxH41nEeowNCE9ZztEdG48N4Semk/1cAbV5NIHvTJdileNeyVeJl5qKad+O
PcaOUbsv1m2+IrXF8mItlmujtqC+GtFkviN+AxU01h9kR/o9FfuLzOR/ydh3
xP7jw7hmPh33FSvP/ys7qVkXewftm+lzOhTfjpyk3+i/onaVeNb4CrUzsHNx
TqwPNgUbwVeSq4qNxVZiM7E+6eR/r/gfbEL878JXjm9I7J3lVsnNkquCVccm
Ya9hT8S3PPbBGcm+Ka4j/kfeQcfk+tJhbCe/J+arugJUG6vE74z1nc9Hl2Kl
+PfpDf547MGwghevOa49Nyf5Nj8Q7x7/ddTF/JJrlp18H+M72dJ5Z8YeU+5G
rFOMMye5ZyP8fhDrtnZGzFf50vzuWBP4/FQLqxjjNe7D7stuY5mVkXzzdsUY
ZXKoplyFuKfxP3FcU4zFeYvwHZxneqzttNOxlXL/B6gTAic=
          "]], 
         Polygon3DBox[{{1361, 1360, 1845, 1095, 1096, 
          1846}}]}]}, {}, {}, {}, {}}, {
      {GrayLevel[0], 
       Line3DBox[{739, 1, 1269, 15, 1283, 29, 1297, 43, 1311, 57, 1325, 71, 
        1339, 85, 1354, 1355, 99, 1375, 113, 1383, 127, 1392, 141, 1405, 155, 
        1419, 169, 1433, 183, 1447, 197, 915, 198, 916, 199, 917, 200, 918, 
        201, 919, 202, 1163, 285, 203, 1252, 418, 287, 413, 665}], 
       Line3DBox[{741, 2, 739}], Line3DBox[{743, 3, 741}], 
       Line3DBox[{745, 4, 743}], Line3DBox[{747, 5, 745}], 
       Line3DBox[{749, 6, 747}], Line3DBox[{751, 7, 749}], 
       Line3DBox[{753, 8, 1267, 629}], Line3DBox[{755, 9, 753}], 
       Line3DBox[{757, 10, 755}], Line3DBox[{759, 11, 757}], 
       Line3DBox[{761, 12, 759}], Line3DBox[{763, 13, 761}], 
       Line3DBox[{1281, 14, 763}], Line3DBox[{1295, 28, 1281}], 
       Line3DBox[{1309, 42, 1295}], Line3DBox[{1323, 56, 1309}], 
       Line3DBox[{1337, 70, 1323}], Line3DBox[{1351, 84, 1337}], 
       Line3DBox[{1372, 98, 1351}], Line3DBox[{1381, 112, 1373, 1372}], 
       Line3DBox[{1390, 126, 1381}], Line3DBox[{1403, 140, 1390}], 
       Line3DBox[{1417, 154, 1403}], Line3DBox[{1431, 168, 1417}], 
       Line3DBox[{1445, 182, 1431}], 
       Line3DBox[{920, 204, 921, 205, 922, 206, 923, 207, 924, 208, 925, 209, 
        926, 210, 1459, 196, 1445}], Line3DBox[{419, 288, 920}], 
       Line3DBox[{419, 473, 603}], Line3DBox[{610, 483, 751}]}, {}, {
       Line3DBox[{1269, 927, 1268, 1871, 1460, 1270, 1872, 1461, 1271, 1873, 
        1462, 1272, 1874, 1463, 1273, 1875, 1464, 1274, 1254, 1725, 1745, 
        1767}], Line3DBox[{1281, 1470, 1881, 1280, 1469, 1880, 1279, 1468, 
        1879, 1278, 1467, 1878, 1277, 1466, 1877, 1276, 1465, 1876, 1275, 
        1950, 1778, 1749}], 
       Line3DBox[{1283, 1779, 1951, 1282, 941, 1284, 1882, 1471, 1285, 1883, 
        1472, 1286, 1884, 1473, 1287, 1885, 1474, 1288, 2054, 1706, 1726, 
        1746, 1768}], 
       Line3DBox[{1295, 1480, 1891, 1294, 1479, 1890, 1293, 1478, 1889, 1292, 
        1477, 1888, 1291, 1476, 1887, 1290, 1475, 1886, 1289, 1952, 1780, 
        1750}], Line3DBox[{1297, 1781, 1953, 1296, 1782, 1954, 1298, 955, 
        1299, 1892, 1481, 1300, 1893, 1482, 1301, 1894, 1483, 1302, 2055, 
        1707, 1727, 1747, 1769}], 
       Line3DBox[{1309, 1487, 1898, 1308, 1486, 1897, 1307, 1485, 1896, 1306, 
        1484, 1895, 1305, 961, 1304, 2030, 1784, 1612, 1562, 1303, 2029, 1783,
         1560, 1559, 1752}], 
       Line3DBox[{1311, 1785, 1955, 1310, 1786, 1956, 1312, 1787, 1957, 1313, 
        969, 1314, 1899, 1488, 1315, 1900, 1489, 1316, 2056, 1708, 1728, 1709,
         1770}], 
       Line3DBox[{1323, 1492, 1903, 1322, 1491, 1902, 1321, 1490, 1901, 1320, 
        975, 1319, 1958, 1788, 1318, 2031, 1564, 1613, 1563, 1317, 2024, 1546,
         1561, 1545, 1751}], 
       Line3DBox[{1325, 1789, 1959, 1324, 1790, 1960, 1326, 1791, 1961, 1327, 
        1792, 1962, 1328, 983, 1329, 1904, 1493, 1330, 2025, 1547, 1729, 1548,
         1740, 1730, 1774}], 
       Line3DBox[{1337, 1495, 1906, 1336, 1494, 1905, 1335, 1965, 1795, 1334, 
        1964, 1794, 1333, 1963, 1793, 1332, 2032, 1567, 1614, 1566, 1331, 
        2026, 1550, 1565, 1549, 1742, 1741, 1743, 1777}], 
       Line3DBox[{1339, 1796, 1966, 1338, 1797, 1967, 1340, 1798, 1968, 1341, 
        1799, 1969, 1342, 1800, 1970, 1343, 1116, 1571, 1344, 2057, 1737, 
        1738, 1568, 1739, 1678, 1734, 1677, 1736, 1776}], 
       Line3DBox[{1351, 1496, 1907, 1350, 1000, 1349, 1577, 1974, 1858, 1348, 
        1576, 1973, 1857, 1347, 1856, 1972, 1575, 1346, 1855, 1971, 1615, 
        1570, 1345, 2045, 1551, 1569, 1680, 1679, 1762}], 
       Line3DBox[{1355, 1908, 1497, 1353, 1909, 1498, 1357, 1910, 1499, 1359, 
        1911, 1500, 1361, 1846, 1912, 1501, 1578, 1869, 2052, 1681, 1675, 
        1686, 1704, 1502, 1687, 1865, 2047, 1645, 1616, 1637, 1671, 1733, 
        1744, 1757}], 
       Line3DBox[{1372, 1509, 1917, 1370, 1984, 1805, 1368, 1582, 1983, 1859, 
        1367, 1555, 1982, 1850, 1366, 1849, 1981, 1553, 1365, 1848, 1980, 
        1628, 1673, 1672, 1364, 1868, 2050, 1694, 1667, 1574, 1647, 1685, 
        1646, 1756}], 
       Line3DBox[{1375, 1806, 1985, 1374, 1919, 1511, 1376, 1583, 1920, 1512, 
        1584, 1852, 1921, 1513, 1585, 1853, 1922, 1514, 1586, 1854, 1923, 
        1629, 1689, 1515, 1690, 2053, 1652, 1653, 1630, 1639, 1748, 1755}], 
       Line3DBox[{1381, 1521, 1928, 1380, 1520, 1927, 1379, 1519, 1926, 1378, 
        1518, 1925, 1377, 1517, 1924, 1556, 1588, 1516, 2042, 1618, 1692, 
        1691, 1705, 1013, 1695, 1674, 1587, 1650, 1656, 1649, 1715, 1714, 
        1759}], Line3DBox[{1383, 1807, 1986, 1382, 1808, 1987, 1384, 1590, 
        1929, 1522, 1619, 1861, 1930, 1523, 1620, 1862, 1931, 1524, 1621, 
        2043, 1591, 1623, 1525, 1622, 2044, 1657, 1592, 1631, 1640, 1641, 
        1760}], Line3DBox[{1390, 1530, 1936, 1389, 1529, 1935, 1388, 1528, 
        1934, 1387, 1527, 1933, 1386, 1526, 1932, 1385, 1024, 1589, 1594, 
        2027, 1809, 1595, 1557, 1710, 1651, 1716, 1753}], 
       Line3DBox[{1392, 1810, 1988, 1391, 1811, 1989, 1393, 1032, 1394, 1937, 
        1531, 1395, 1938, 1532, 1396, 2035, 1593, 1625, 1533, 1624, 1208, 
        1596, 1632, 1642, 1643, 1766}], 
       Line3DBox[{1403, 1537, 1942, 1402, 1536, 1941, 1401, 1535, 1940, 1400, 
        1534, 1939, 1399, 1037, 1398, 1990, 1813, 1397, 2028, 1812, 1696, 
        1558, 1711, 1724, 1723, 1773}], 
       Line3DBox[{1405, 1814, 1991, 1404, 1815, 1992, 1406, 1816, 1993, 1407, 
        1045, 1408, 1943, 1538, 1409, 2036, 1597, 1626, 1598, 1410, 1866, 
        2037, 1599, 1633, 1600, 1761}], 
       Line3DBox[{1417, 1541, 1946, 1416, 1540, 1945, 1415, 1539, 1944, 1414, 
        1050, 1413, 1995, 1818, 1412, 1994, 1817, 1411, 2039, 1604, 1697, 
        1603, 1712, 1717, 1771}], 
       Line3DBox[{1419, 1819, 1996, 1418, 1820, 1997, 1420, 1821, 1998, 1421, 
        1822, 1999, 1422, 1058, 1423, 2038, 1601, 1627, 1602, 1424, 2048, 
        1658, 1605, 1634, 1606, 1659, 1754}], 
       Line3DBox[{1431, 1543, 1948, 1430, 1542, 1947, 1429, 1063, 1428, 2002, 
        1825, 1427, 2001, 1824, 1426, 2000, 1823, 1425, 2040, 1608, 1698, 
        1607, 1713, 460, 1763}], 
       Line3DBox[{1433, 1826, 2003, 1432, 1827, 2004, 1434, 1828, 2005, 1435, 
        1829, 2006, 1436, 1830, 2007, 1437, 1158, 1609, 1438, 2049, 1660, 
        1661, 1635, 1663, 1662, 663}], 
       Line3DBox[{1445, 1544, 1949, 1444, 1076, 1443, 2011, 1834, 1442, 2010, 
        1833, 1441, 2009, 1832, 1440, 2008, 1831, 1439, 2041, 1610, 1699, 
        1701, 1718, 1700, 1719, 1764}], 
       Line3DBox[{1447, 1835, 2012, 1446, 1836, 2013, 1448, 1837, 2014, 1449, 
        1838, 2015, 1450, 1839, 2016, 1451, 1863, 2017, 1611, 1452, 1867, 
        2046, 1664, 1636, 1666, 1665, 1765}], 
       Line3DBox[{1459, 1089, 1458, 2023, 1844, 1457, 2022, 1843, 1456, 2021, 
        1842, 1455, 2020, 1841, 1454, 2019, 1840, 1453, 1864, 2018, 1702, 
        1703, 1720, 1722, 1721, 1772}], 
       Line3DBox[{1758, 1654, 1655, 1648, 1579, 1638, 2034, 1503, 1688, 1682, 
        1683, 1676, 1870, 2051, 1504, 1580, 1554, 1913, 1505, 1581, 1851, 
        1914, 1506, 1617, 1860, 1915, 1507, 1369, 1916, 1508, 1371, 1918, 
        1510, 1373}], 
       Line3DBox[{1775, 1731, 1735, 1732, 1693, 1644, 1573, 1670, 1684, 1226, 
        1363, 1668, 1669, 1572, 2033, 1847, 1362, 1552, 1979, 1845, 1360, 
        1978, 1804, 1358, 1977, 1803, 1356, 1976, 1802, 1352, 1975, 1801, 
        1354}]}, {
       Line3DBox[{739, 927, 740, 1951, 940, 765, 1953, 953, 778, 1955, 966, 
        791, 1959, 979, 804, 1966, 992, 817, 1975, 1002, 1908, 829, 1985, 
        1010, 841, 1986, 1020, 853, 1988, 1030, 865, 1991, 1042, 877, 1996, 
        1054, 889, 2003, 1066, 902, 2012, 1078, 915}], 
       Line3DBox[{741, 928, 1871, 742, 941, 766, 1954, 954, 779, 1956, 967, 
        792, 1960, 980, 805, 1967, 993, 818, 1976, 1003, 1909, 830, 1011, 
        1919, 842, 1987, 1021, 854, 1989, 1031, 866, 1992, 1043, 878, 1997, 
        1055, 890, 2004, 1067, 903, 2013, 1079, 916}], 
       Line3DBox[{743, 929, 1872, 744, 942, 1882, 767, 955, 780, 1957, 968, 
        793, 1961, 981, 806, 1968, 994, 819, 1977, 1004, 1910, 831, 1133, 
        1134, 1012, 1920, 843, 1142, 1171, 1022, 1929, 855, 1032, 867, 1993, 
        1044, 879, 1998, 1056, 891, 2005, 1068, 904, 2014, 1080, 917}], 
       Line3DBox[{745, 930, 1873, 746, 943, 1883, 768, 956, 1892, 781, 969, 
        794, 1962, 982, 807, 1969, 995, 820, 1978, 1005, 1911, 832, 1102, 
        1135, 1103, 1921, 844, 1143, 1172, 1144, 1930, 856, 1033, 1937, 868, 
        1045, 880, 1999, 1057, 892, 2006, 1069, 905, 2015, 1081, 918}], 
       Line3DBox[{747, 931, 1874, 748, 944, 1884, 769, 957, 1893, 782, 970, 
        1899, 795, 983, 808, 1970, 996, 821, 1979, 1095, 1096, 1912, 833, 
        1104, 1136, 1105, 1922, 845, 1145, 1173, 1146, 1931, 857, 1034, 1938, 
        869, 1046, 1943, 881, 1058, 893, 2007, 1070, 906, 2016, 1082, 919}], 
       Line3DBox[{749, 932, 1875, 750, 945, 1885, 770, 958, 1894, 783, 971, 
        1900, 796, 984, 1904, 809, 1116, 1117, 1119, 2033, 1097, 1125, 1233, 
        1232, 2052, 1231, 1234, 1235, 1137, 1106, 1923, 1185, 1147, 1174, 
        2043, 1148, 1176, 1149, 2035, 1150, 1178, 1152, 2036, 1153, 1180, 
        1154, 2038, 1155, 894, 1158, 1159, 907, 2017, 1161, 1162, 1163}], 
       Line3DBox[CompressedData["
1:eJwVzLsuA2AUwPFTQesxPAtP0MFgMBiMJH2TTo00JUEJiWvV/VqXgZmKSyxF
UVoSm+Bn+OWfL+d8p3twJD2ciIg+mm0RD+0Rj7zxRGcqoq7vPJP0ftEmr6S8
G9qi538nGdGr/XzQZf6pA1xyQZUz7jhniDmumOXXjazOc88CGZa4psPNRZ1g
mRVyrPLtb0knKbPGKBusM8UmW3zZzesO2xTZJdzf0wIH7DPNIQmzio5xzBEz
/Lh1oqeMc8sNNf4AKkA+yA==
        "]], 
       Line3DBox[{753, 934, 1876, 754, 947, 1886, 772, 1111, 2030, 960, 785, 
        1112, 2031, 973, 798, 1113, 2032, 986, 811, 1971, 1115, 1165, 998, 
        823, 1980, 1098, 1128, 1249, 1250, 2051, 835, 1236, 1107, 1140, 1014, 
        2042, 847, 1141, 1024, 859, 1990, 1036, 871, 1994, 1048, 883, 2000, 
        1060, 896, 2008, 1072, 909, 2019, 1084, 921}], 
       Line3DBox[{755, 935, 1877, 756, 948, 1887, 773, 961, 786, 1958, 974, 
        799, 1963, 987, 812, 1972, 1120, 1166, 999, 824, 1981, 1099, 1129, 
        1007, 1913, 836, 1108, 1015, 1924, 848, 1025, 1932, 860, 1037, 872, 
        1995, 1049, 884, 2001, 1061, 897, 2009, 1073, 910, 2020, 1085, 922}], 
       Line3DBox[{757, 936, 1878, 758, 949, 1888, 774, 962, 1895, 787, 975, 
        800, 1964, 988, 813, 1973, 1121, 1167, 1122, 825, 1982, 1100, 1130, 
        1101, 1914, 837, 1016, 1925, 849, 1026, 1933, 861, 1038, 1939, 873, 
        1050, 885, 2002, 1062, 898, 2010, 1074, 911, 2021, 1086, 923}], 
       Line3DBox[{759, 937, 1879, 760, 950, 1889, 775, 963, 1896, 788, 976, 
        1901, 801, 1965, 989, 814, 1974, 1123, 1168, 1124, 826, 1983, 1131, 
        1170, 1132, 1915, 838, 1017, 1926, 850, 1027, 1934, 862, 1039, 1940, 
        874, 1051, 1944, 886, 1063, 899, 2011, 1075, 912, 2022, 1087, 924}], 
       Line3DBox[{761, 938, 1880, 762, 951, 1890, 776, 964, 1897, 789, 977, 
        1902, 802, 990, 1905, 815, 1000, 827, 1984, 1008, 1916, 839, 1018, 
        1927, 851, 1028, 1935, 863, 1040, 1941, 875, 1052, 1945, 887, 1064, 
        1947, 900, 1076, 913, 2023, 1088, 925}], 
       Line3DBox[{763, 939, 1881, 764, 952, 1891, 777, 965, 1898, 790, 978, 
        1903, 803, 991, 1906, 816, 1001, 1907, 828, 1009, 1917, 1918, 840, 
        1019, 1928, 852, 1029, 1936, 864, 1041, 1942, 876, 1053, 1946, 888, 
        1065, 1948, 901, 1077, 1949, 914, 1089, 926}], 
       Line3DBox[{920, 1083, 1164, 2018, 908, 1071, 2041, 1160, 895, 1059, 
        2040, 1157, 882, 1047, 2039, 1156, 870, 1035, 2028, 1109, 858, 1023, 
        2027, 1151, 1230, 1229, 846, 1013, 1251, 1228, 1139, 1196, 1248, 1195,
         834, 2034, 1006, 1241, 1192, 1127, 1225, 1246, 1224, 2050, 822, 997, 
        1223, 1184, 2045, 1094, 810, 985, 2026, 1093, 797, 972, 2024, 1090, 
        784, 959, 2029, 1110, 771, 946, 1952, 752, 933, 1950, 
        1267}]}, {}, {}}},
    VertexNormals->CompressedData["
1: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
ONKXUUT433WTgegt8A7lrsZ6i+CyaCrRWw8jlkW858KLERWqRbzn2l6mQWTP
7bjNxp5bPgmb1LbzrA9sQvy0gbeUggxgW1Pp/mbMf6usn/QtzL/reUuGXc6G
cMDFE+E+C9F0s19xn0W1lvYHSZ9dftD1GOs5ZN+lV1w3kowOdZnMEj3/697h
n3un/xSxYsf/au8n0q/pz9/bR+zIl35ZsWNANSOP7cBA3OdpYsfZAIgOgAOn
505brAOVQ6cKiQ6I2+kZ8jRSQD1gJ3d6VyHKL04SqOm0AuM2xYiNMxTQsi5v
fVX0GvGvOf+UzsYIVm93Nsxmo6AmJ82RqSsNKMJatnX4Nt4He8SD/asoyHKR
p//JXBHqyj4aQZ1hBJNKdQ5rcd9kkNlh8rI3Cx12fLPY3GQFUh2nJgpxXwNe
laNjZa8R86a8N4+sHCDopgWVPdYrWWuWfKX3ieh0rcxHtiBXSN2TID2N9Y32
d0tb3oc41KJcGtaV6gW8z2hf+M9TwFqKkyXu9AtUNGW3HL7BB+Z098ZcHqBA
heDo8Z7wbOh8p7dqIsgH8qzR1quYB4ZXJ2T2TyWiI7o7DvRTueP8n0T0dFIg
0GFcQPBxHlgY6Zke2+oBZXybk/dhHub1d/u/EnuNtqlubxsccQSTtuPChVg3
og7fkq4vzkS/K+S5XrfaQLbNXd6ZYey3Ke/+OsEs5OZ57Myzo/chxdPw+D6s
PyJrcy2ZLAKQvLD82XtWvhAo9cXg6ygF5hr93B6LZIIQj9tC5RZ7cPNsza/E
9tuZFsYG8zNhe4CyQSi2T+EutxPC8XyYz10+ePQ12Nk4qrXheJw3La0LrKJA
8PKZrwxzRaCkfWZuId0I7nXYxx1lpSDF9Drxdu0GcGiTY0x8qgTmFjsOSOB7
CcrdOnrycxbkX/ozv9iqC08yL0bQ4L7wZIti5M+yRICynQ8Ng80gy59l6hDW
8+7KXYcnf0bDp2/mkwUDtmCha7uxHOvzjS7+XblqoRDDfj0j+Y8TVLmObtDC
+bqeklPY5x8IpSk9v6jZPcDQJpg7CuPfjfJDqSX9oIRru3HFcx/o2c/C2eVL
QS8em6qyj5UjrvWzjfwXVaH4YWj5ARyn70gWlX1fFgrZpRIktFYfwh53hO/D
/botSTHajSMZ7Z5lrFnaZg6WvAvWVXh+EFTXflVzLw5VNj+W+xRrBxfeCp0v
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
/xNnTN5KXmBRW9T5v3n98VvhAahlZywJD6yWs4uYN+RpuqGX1M91CtdhwtvJ
J8uXMc9oq9og4RnRXjPeRXg+tC67Cd8L+inCQu4FBdi8O0XuxfR4rhW+R2QW
toqd1I+9xLWVe1TuuvIF3zuKOMUWTepHfd+kLrn385+y9uP6QcKfArVJ/dgn
ySBSP+a/Zpxx/SDxLaJ6pH7YYOEAqZ8nLEIlxM6k/OqV+nHhe/yE2OmYU9Ag
fjnK5blI/bzbys1O/FYov00ncT7nWiR1DqyZlZdInPFfT14keQ3LML8n9aNP
m3yc5HXpCk0U4UGJtWGA1I9wmII84UG9zmMffncohDkul+jSIw6ereTdrak3
jsXvFI25rlUkurTzZFgYeadiqtE5+F0jGxFNJaJLTtYLFuRdi4gklmAdQJ9d
9w4RXQpk2x9NdCCccfgl1g10o+JSKdGlSxK3U4lupMZnUL1RnkAWA+YcRH92
2O4oJvrzUlOK6BU6uyOT6BUEZHI9InrlnjgfTOxo+dk1EP0xvtqeS+wIzpgS
PUQ+/fOTRH9EvafCid+lbuFgEqeh88MV/VlzgtmMxFn8+dZTkteV36Y3if7M
fF27khc7Wyot4SHzzM0ioj8Rd0MYCA+Tes7JWM/R5AkuAdLvPEuCeYieT0zu
2TTW3YOMF1SzSb97v+rcH6L/WrVnlnC/QIOhu/JJv3MZ9HpF+gVLs+pZ3F/Q
sxOThqTfMQ7pzpL+ImSX+xj3I5Qrit6Rfie/U2ma9KNq6963uK8hbmnB66Sv
nbUpXulrbe/1d+M+iERvNTrgPggHbOMNSB88w9dB+iYSPJFL+iacPsHwh9iB
8IdA/PryfXxG+pp16p9Vzdhv0tDAJImTZ2hTGelrOtzKb0icX2ZNhnFfQ/vF
6Ukfh9UVQ2tJH9/CG+hGeNg99f0w6WtxoaK7CA97tszY4jkBGR+oriBz1E2a
chEyJ1Dae3XxXIEqh6vbyRzVv4vehMwVgeJhJ/Ecgtr6R/aSOYqGtnKQzCF7
L/eTOQrVvcoTJ3NUjphLLplbsjyn+fCcg6ZPbjpE5qgbvFrmZM7h8J27hecl
5HjyQSOZl26ntT8h89LhPNF0PF+hICONZjxfQW212bGV+Yo3dcVOn5kJsQPG
DeEexM7BxyJ8xC/18wQg89Ldm8LpxK+fdYcYibNbPmofmZd8eh++J3G++HxO
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
SEaM51fYOUmwrECzh8QHe+/jY3cGO+MMVdmrjbBXZVXu0bIu4mUc1+fvfx9M
th+aotvSArarLxq4K3SQxS46r/QdbOACV328+ZZO2JrWE7Qxspl0PY3NZ2Oz
ghL/vDnxWb0g+f2K2aRrFeTgnOnriorNwFj+tjDK913U9aByWLvUdivKK3NP
xKCetHmGz6keqB6OLEQ9MSE7fuvQ7340fG5CvwvFyU/e4Xf9pg4dQzuPnsj7
SO2E5TaR39BO6SO3yrBfz5+H1NB+QTOjdy/2a/dIZA76593AvT3UP7Dz+bRF
6B9hQx1v9I+R5PS91D/AuWFjKfqnK4vxMqWyBNY3e+WzU15YJegdz83lBmVW
SXvffCuE5deW3Hw6jeLuhWHuuqYeIDeldNV0rjKI9Fk8+wbl0/kLDgVIbHKC
3eA188DNKiD7emcaUd55RTnCRNncDvja3GO5KY9V8ZRWbvrQTdzl19o/+2kF
fnom8+0Inc+vrDxvU/4q4fXOoPCZKTweaPop97Ib3g8rK2fTeZsfJHLoC+W5
6l6z+lGuVu19lMrhVUDgKZSLWcbskafzr/2nyYFHdL597/zdVkT5fvb7ri/2
tN3D44Y8kvR3YhwuZ0zxfzdHQfyoVxU8s809l6jWC6C04W8E5e9R39jnYL9G
Uh6K037By6sJgdiv0uMPg9E/cxvPfKL+gTY+3ST0j6fD5ohk6p8VW7ksqX+g
KdPEFf1jvPuFEN4TEDqRui+I8uO8BAt/v+nj/4N4qDCx7uqex3pOFq8ILDtk
sDmU4rK+6gYTnn/rtz5UmFi/NcClVm8nRxZEznr6SJXy8qeibouKpzgC+1j7
IIU3rPqtWqz6rR9nCs1dsy0fZjNOzE6j/F7bx0CVyTNevyNEYWJd12S7Ldpf
C0vghtpuddn3DHJ8AedKDcm7LP1hCpNZ9V7vsuqu9sd8Ucyj4y7quFSA0HFP
uTwj7YX5LbjDJVp6mo5LhUX30zAar7TCfh78QfH5Y1vtNyiXOngymcphcOYa
XZTfFXmxEPVk/sqZTfVAzbPP6agn3mij6/WqEmgZ2aYUS/0fuzXgsBPFYylm
0rdd9+XDaWMLUaA4rrvWWTqO4je+BdPZ0D/Dk7Y/of4B49ISof/rnyRWHdgB
Vh3YjR53TuF4yXKvUKTjBZXDzxP/73hNrA+78/EmeXM6XpydCdvoeMGKqfMM
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
d+FLPiqH7X8Um1HOxop74/FqByte+Xj81vYsywf7wUv9zpuZkP3S1StQ1QZs
K62O4HpX37RwOurxTlvTh3rG61HemlCP0pF/APtFpk05cRP7daddcDb2K8bP
+/aSaiYEzTwo2aCXDDNVghm/c+xgNG6VwrY8JtRaeCWcXfgBYs7VWJ43s/vX
z38m+D9MpbvskBMDTgT95v0z8zMMJBzaMsvQHvpZdckXsOqSz2LVJR+vV754
gnxoWuvNy1eYoFuznXsRxfP55caHwpRMoe+MWj5dFwBewz/ouoCEcL9HuC4c
Hx8WeLmlG+b3mcUO5zbAdOXdXN8dLaGKVXdjBqvuxgpW3Y01yQ+nbHrDAN7T
6jOyKJ/lODhfY3/AdUhO0dWgcQOkos8cpXEDNgkG22Lc8BVN00b58Z3uBzCe
bHy72QTl4hq/1+m31sNqtfnm01K6SYT1n/zin4bQoximsudcN3j0iy0peNBA
ZMxy5yX1nQdLzqadKN+5q30LlcPJ10FyKN+iYCxI4xi4Btz+SuMY+IvJSGEc
65R9sKKnpxpkWp+e2MHVCy2ZP2WqF9lC5sEt7c85yuGj2uICv2kMAJusP3vr
HFj55fW/eVOKlTf/yY+fFURZdcYFWfWF2Vjtx+fbtv/kx6h/8+P4/mSs65Lh
eM0s8Cq5xQFWTJgv4Zf5XpXGeYlsjgTNLMJo24Ry0r5VLA7l7qJPfF335ZPy
P2+EYSfN73zsK3Ff0aD6W/D1qhJy8uL9vbFvGeRt6KtjuA+pfu7AwbybVSTG
OG0G7n8O/DXJxX1LSW7t49Rv5NGiv2Lot/Unwveh37R7jq3G9tw/o0Vwn/O2
8acibB+gZHYB4/+uR+cUcRx/uZxxw/FSulTIEcpRTqqLZ2dTvxG1/oq/6LeJ
9zDfsO5hjtctvcSqW3qDVbe0StZZgs43cjczw5fON1K7+g0/zreHUy3+yr3s
JqOvQ3bivnp8Vt453Ff3epM+jc43IhJY1/ORzrfzDVWncb79aPB+FL6QSZYW
KHN7634in3dFnuLxNf23DvgHVh3wQFYd8HH5G5Y8YEJ9cLbM/9YH38+S/55Q
N1w1bv7RrUO9JHGd+px52uWkdc7q/Vu67UEos6uCrl+y5fMadrp+SfSNQRlc
v+P1xO+z6omPwj/1xMflbhPqjLd9iw3ZFUVxzOuwh4Iy6WQ4rzb3m48dvN5V
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
4j6oN1jPUsqxGfVmekqiiert3zP9ZMg=
     "]],
   Axes->True,
   AxesLabel->{
     FormBox["\"\[CapitalDelta]lon (degrees)\"", TraditionalForm], 
     FormBox["\"\[CapitalDelta]lat (degrees)\"", TraditionalForm], 
     FormBox["\"Heading (degrees)\"", TraditionalForm]},
   BoxRatios->{1, 1, 0.4},
   Method->{"RotationControl" -> "Globe"},
   PlotLabel->FormBox[
    "\"Haversin Headings as a function of delta lon and delta lat\"", 
     TraditionalForm],
   PlotRange->{{-1., 1.}, {-1., 1.}, {0., 359.5089802676397}},
   PlotRangePadding->{
     Scaled[0.02], 
     Scaled[0.02], 
     Scaled[0.02]}], TraditionalForm]], "Output",
 CellChangeTimes->{
  3.5358171345974736`*^9, 3.5358171668214736`*^9, 3.5358172874758215`*^9, 
   3.5358173735832095`*^9, 3.5358182213154755`*^9, 3.5358264763373384`*^9, 
   3.535827674403616*^9, 3.53583953986703*^9, 3.5359990657736535`*^9, 
   3.5359991890659814`*^9, 3.5360142343580956`*^9, 3.536014880274437*^9, 
   3.5360254435649557`*^9, {3.5360289500335145`*^9, 3.53602895659789*^9}, 
   3.5362707302574673`*^9}]
}, {2}]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Distances and Headings in 3-D Euclidean Space", "Subsection",
 CellChangeTimes->{{3.535811128836211*^9, 3.5358111389322205`*^9}}],

Cell["\<\
Another way to compute distances is in 3-D Euclidean Space. Consider a 3-D \
coordinate system centered at the Earth\[CloseCurlyQuote]s center, with \
\>", "Text",
 CellChangeTimes->{{3.5359994691828613`*^9, 3.5359995926733427`*^9}, 
   3.536017565943048*^9}],

Cell[CellGroupData[{

Cell[TextData[{
 "the ",
 Cell[BoxData[
  FormBox["x", TraditionalForm]]],
 "-axis passing through the Greenwich meridian (0\[Degree] longitude) at the \
equator (0\[Degree] latitude) -- the RED axis in the visualization below"
}], "ItemNumbered",
 CellChangeTimes->{{3.5359994691828613`*^9, 3.5359995926733427`*^9}, 
   3.536017565943048*^9, {3.5360252560592313`*^9, 3.5360252666528373`*^9}}],

Cell[TextData[{
 "the ",
 Cell[BoxData[
  FormBox["y", TraditionalForm]]],
 "-axis passing through the 90\[Degree] meridian at the equator -- the GREEN \
axis in the visualization"
}], "ItemNumbered",
 CellChangeTimes->{{3.5360252708690786`*^9, 3.53602534345123*^9}}],

Cell[TextData[{
 "the ",
 Cell[BoxData[
  FormBox["z", TraditionalForm]]],
 "-axis passing through the North Pole -- the BLUE axis in the visualization"
}], "ItemNumbered",
 CellChangeTimes->{{3.5360253151086087`*^9, 3.536025364823452*^9}}]
}, Open  ]],

Cell[TextData[{
 "In this interactive visualization, drag the point p around in its \
double-slider control just above the rendering to see how the projections of \
the point on the ",
 Cell[BoxData[
  FormBox["x", TraditionalForm]],
  FormatType->"TraditionalForm"],
 "-",
 Cell[BoxData[
  FormBox["y", TraditionalForm]],
  FormatType->"TraditionalForm"],
 " plane and on the ",
 Cell[BoxData[
  FormBox["z", TraditionalForm]],
  FormatType->"TraditionalForm"],
 "-axis change. Also note how the \[OpenCurlyDoubleQuote]little circle\
\[CloseCurlyDoubleQuote] -- that is, the circle of constant latitude and \
constant z through the point -- changes. Finally, note how the \
quarter-meridian from the North Pole through the point to the equator varies \
as you drag the point around. The purpose of the visualization is to give you \
an intuitive feel for the relationship between the 3-D coordinates ",
 Cell[BoxData[
  FormBox["x", TraditionalForm]],
  FormatType->"TraditionalForm"],
 ", ",
 Cell[BoxData[
  FormBox["y", TraditionalForm]],
  FormatType->"TraditionalForm"],
 ", ",
 Cell[BoxData[
  FormBox["z", TraditionalForm]],
  FormatType->"TraditionalForm"],
 " -- represented by the projections of the point on the ",
 Cell[BoxData[
  FormBox["x", TraditionalForm]],
  FormatType->"TraditionalForm"],
 "-",
 Cell[BoxData[
  FormBox["y", TraditionalForm]],
  FormatType->"TraditionalForm"],
 " plane and the ",
 Cell[BoxData[
  FormBox["z", TraditionalForm]],
  FormatType->"TraditionalForm"],
 " axis, and the longitude and latitude -- represented by the little circle \
and the quarter meridian."
}], "Text",
 CellChangeTimes->{{3.5360267122945232`*^9, 3.5360270887650557`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"lon", "=", 
        RowBox[{"p", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}]}],
        ",", 
       RowBox[{"lat", "=", 
        RowBox[{"p", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}]}],
        ",", 
       RowBox[{"axes3D", "=", 
        RowBox[{"With", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"L", "=", "1.25"}], "}"}], ",", "\[IndentingNewLine]", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"Thickness", "[", ".01", "]"}], "\[IndentingNewLine]", 
            ",", 
            RowBox[{"RGBColor", "[", 
             RowBox[{"1", ",", "0", ",", "0"}], "]"}], ",", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"L", ",", "0", ",", "0"}], "}"}]}], "}"}], "]"}], 
            "\[IndentingNewLine]", ",", 
            RowBox[{"RGBColor", "[", 
             RowBox[{"0", ",", "1", ",", "0"}], "]"}], ",", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"0", ",", "L", ",", "0"}], "}"}]}], "}"}], "]"}], 
            "\[IndentingNewLine]", ",", 
            RowBox[{"RGBColor", "[", 
             RowBox[{"0", ",", "0", ",", "1"}], "]"}], ",", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "L"}], "}"}]}], "}"}], "]"}], 
            "\[IndentingNewLine]", ",", 
            RowBox[{"RGBColor", "[", 
             RowBox[{"0", ",", "1", ",", "1"}], "]"}], ",", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{
                 RowBox[{"-", "L"}], ",", "0", ",", "0"}], "}"}]}], "}"}], 
             "]"}], "\[IndentingNewLine]", ",", 
            RowBox[{"RGBColor", "[", 
             RowBox[{"1", ",", "0", ",", "1"}], "]"}], ",", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"0", ",", 
                 RowBox[{"-", "L"}], ",", "0"}], "}"}]}], "}"}], "]"}], 
            "\[IndentingNewLine]", ",", 
            RowBox[{"RGBColor", "[", 
             RowBox[{"1", ",", "1", ",", "0"}], "]"}], ",", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", 
                 RowBox[{"-", "L"}]}], "}"}]}], "}"}], "]"}]}], 
           "\[IndentingNewLine]", "}"}]}], "]"}]}], ",", 
       RowBox[{"equator", "=", 
        RowBox[{"ParametricPlot3D", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"Cos", "[", "\[Upsilon]", "]"}], ",", 
            RowBox[{"Sin", "[", "\[Upsilon]", "]"}], ",", "0"}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"\[Upsilon]", ",", "0", ",", 
            RowBox[{"2.0", "\[Pi]"}]}], "}"}]}], "]"}]}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"greenwich", "=", 
        RowBox[{"ParametricPlot3D", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"Cos", "[", "\[Psi]", "]"}], ",", "0", ",", 
            RowBox[{"Sin", "[", "\[Psi]", "]"}]}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"\[Psi]", ",", "0", ",", 
            RowBox[{"\[Pi]", "/", "2.0"}]}], "}"}]}], "]"}]}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"meridian2", "=", 
        RowBox[{"ParametricPlot3D", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"0", ",", 
            RowBox[{"Cos", "[", "\[Psi]", "]"}], ",", 
            RowBox[{"Sin", "[", "\[Psi]", "]"}]}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"\[Psi]", ",", "0", ",", 
            RowBox[{"\[Pi]", "/", "2.0"}]}], "}"}]}], "]"}]}]}], 
      "\[IndentingNewLine]", "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"x", "=", 
          RowBox[{
           RowBox[{"Cos", "[", "lat", "]"}], 
           RowBox[{"Cos", "[", "lon", "]"}]}]}], ",", "\[IndentingNewLine]", 
         RowBox[{"y", "=", 
          RowBox[{
           RowBox[{"Sin", "[", "lat", "]"}], 
           RowBox[{"Cos", "[", "lon", "]"}]}]}], ",", "\[IndentingNewLine]", 
         RowBox[{"z", "=", 
          RowBox[{"Sin", "[", "lon", "]"}]}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"r", "=", 
           RowBox[{"EuclideanDistance", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{"0", ",", "0", ",", "z"}], "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"x", ",", "y", ",", "z"}], "}"}]}], "]"}]}], "}"}], ",",
          "\[IndentingNewLine]", 
         RowBox[{"Show", "[", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"Graphics3D", "[", 
            RowBox[{"{", "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"Opacity", "[", "0.5", "]"}], ",", 
              RowBox[{"Sphere", "[", 
               RowBox[{
                RowBox[{"{", 
                 RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", "1.0"}], 
               "]"}], ",", "\[IndentingNewLine]", 
              RowBox[{"Opacity", "[", "1.0", "]"}], ",", "axes3D"}], "}"}], 
            "]"}], ",", "\[IndentingNewLine]", "equator", ",", "greenwich", 
           ",", "meridian2", ",", "\[IndentingNewLine]", 
           RowBox[{"ParametricPlot3D", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{
               RowBox[{"r", " ", 
                RowBox[{"Cos", "[", "\[Upsilon]", "]"}]}], ",", 
               RowBox[{"r", " ", 
                RowBox[{"Sin", "[", "\[Upsilon]", "]"}]}], ",", "z"}], "}"}], 
             ",", 
             RowBox[{"{", 
              RowBox[{"\[Upsilon]", ",", "0", ",", 
               RowBox[{"2.0", "\[Pi]"}]}], "}"}]}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"ParametricPlot3D", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{
               RowBox[{"x", " ", 
                RowBox[{
                 RowBox[{"Cos", "[", "\[Psi]", "]"}], "/", "r"}]}], ",", 
               RowBox[{"y", " ", 
                RowBox[{
                 RowBox[{"Cos", "[", "\[Psi]", "]"}], "/", "r"}]}], ",", 
               RowBox[{"Sin", "[", "\[Psi]", "]"}]}], "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"\[Psi]", ",", "0", ",", 
               RowBox[{"\[Pi]", "/", "2.0"}]}], "}"}]}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Graphics3D", "[", 
            RowBox[{"Point", "[", 
             RowBox[{"{", 
              RowBox[{"x", ",", "y", ",", "z"}], "}"}], "]"}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Graphics3D", "[", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"x", ",", "y", ",", "z"}], "}"}]}], "}"}], "]"}], 
            "]"}], ",", "\[IndentingNewLine]", 
           RowBox[{"Graphics3D", "[", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"x", ",", "y", ",", "0"}], "}"}]}], "}"}], "]"}], 
            "]"}], ",", "\[IndentingNewLine]", 
           RowBox[{"Graphics3D", "[", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"x", ",", "y", ",", "z"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"x", ",", "y", ",", "0"}], "}"}]}], "}"}], "]"}], 
            "]"}], ",", "\[IndentingNewLine]", 
           RowBox[{"Graphics3D", "[", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"x", ",", "y", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"x", ",", "0", ",", "0"}], "}"}]}], "}"}], "]"}], 
            "]"}], ",", "\[IndentingNewLine]", 
           RowBox[{"Graphics3D", "[", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"x", ",", "y", ",", "0"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"0", ",", "y", ",", "0"}], "}"}]}], "}"}], "]"}], 
            "]"}], ",", "\[IndentingNewLine]", 
           RowBox[{"Graphics3D", "[", 
            RowBox[{"Line", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"x", ",", "y", ",", "z"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"0", ",", "0", ",", "z"}], "}"}]}], "}"}], "]"}], 
            "]"}], ",", "\[IndentingNewLine]", 
           RowBox[{"ViewPoint", "\[Rule]", 
            RowBox[{"{", 
             RowBox[{"2.4", ",", "1.3", ",", "2.0"}], "}"}]}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Boxed", "\[Rule]", "False"}]}], "\[IndentingNewLine]", 
          "]"}]}], "]"}]}], "]"}]}], "]"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", " ", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"p", ",", 
       RowBox[{"RandomReal", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"0", ",", 
           RowBox[{"90.0", "\[Degree]"}]}], "}"}], ",", "2"}], "]"}]}], "}"}],
      ",", 
     RowBox[{"{", 
      RowBox[{"0", ",", "0"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"90.0", "\[Degree]"}], ",", 
       RowBox[{"90.0", "\[Degree]"}]}], "}"}]}], "}"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"SaveDefinitions", "\[Rule]", "True"}]}], "\[IndentingNewLine]", 
  "]"}]], "Input",
 CellChangeTimes->{{3.536016754414631*^9, 3.536016775563841*^9}, {
   3.5360168393904915`*^9, 3.5360168471109333`*^9}, {3.5360169029631276`*^9, 
   3.5360170214439044`*^9}, {3.536017261324625*^9, 3.5360172736503296`*^9}, {
   3.5360173274824085`*^9, 3.5360173550969887`*^9}, {3.5360174069059515`*^9, 
   3.536017465837322*^9}, {3.536025220585202*^9, 3.536025222911335*^9}, {
   3.5360254217337074`*^9, 3.5360254322543087`*^9}, {3.5360255191542797`*^9, 
   3.5360256664287033`*^9}, {3.536025795239071*^9, 3.536025955943262*^9}, {
   3.536026091317005*^9, 3.536026139438758*^9}, {3.5360261921797743`*^9, 
   3.5360262631368327`*^9}, {3.536026312958682*^9, 3.5360263383281336`*^9}, {
   3.536026368595865*^9, 3.5360263769083405`*^9}, 3.5360264498195105`*^9, {
   3.536026560235826*^9, 3.5360265633590045`*^9}, {3.5360271217509427`*^9, 
   3.536027124315089*^9}}],

Cell[BoxData[
 FormBox[
  TagBox[
   FormBox[
    StyleBox[
     DynamicModuleBox[{$CellContext`p$$ = {1.1400000000000001`, 
      0.5700000000000001}, Typeset`show$$ = True, Typeset`bookmarkList$$ = {},
       Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, 
      Typeset`animvar$$ = 1, Typeset`name$$ = "\"untitled\"", 
      Typeset`specs$$ = {{{
         Hold[$CellContext`p$$], {0.5003465267989831, 1.2438420283260498`}}, {
        0, 0}, {1.5707963267948966`, 1.5707963267948966`}}}, 
      Typeset`size$$ = {540., {288., 298.}}, Typeset`update$$ = 0, 
      Typeset`initDone$$, Typeset`skipInitDone$$ = 
      True, $CellContext`p$525$$ = {0, 0}}, 
      DynamicBox[Manipulate`ManipulateBoxes[
       1, TraditionalForm, 
        "Variables" :> {$CellContext`p$$ = {0.5003465267989831, 
           1.2438420283260498`}}, "ControllerVariables" :> {
          Hold[$CellContext`p$$, $CellContext`p$525$$, {0, 0}]}, 
        "OtherVariables" :> {
         Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
          Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
          Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
          Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> 
        With[{$CellContext`lon = Part[$CellContext`p$$, 2], $CellContext`lat = 
           Part[$CellContext`p$$, 1], $CellContext`axes3D = 
           With[{$CellContext`L = 1.25}, {
              Thickness[0.01], 
              RGBColor[1, 0, 0], 
              Line[{{0, 0, 0}, {$CellContext`L, 0, 0}}], 
              RGBColor[0, 1, 0], 
              Line[{{0, 0, 0}, {0, $CellContext`L, 0}}], 
              RGBColor[0, 0, 1], 
              Line[{{0, 0, 0}, {0, 0, $CellContext`L}}], 
              RGBColor[0, 1, 1], 
              Line[{{0, 0, 0}, {-$CellContext`L, 0, 0}}], 
              RGBColor[1, 0, 1], 
              Line[{{0, 0, 0}, {0, -$CellContext`L, 0}}], 
              RGBColor[1, 1, 0], 
              
              Line[{{0, 0, 0}, {
                0, 0, -$CellContext`L}}]}], $CellContext`equator = 
           ParametricPlot3D[{
              Cos[$CellContext`\[Upsilon]], 
              Sin[$CellContext`\[Upsilon]], 0}, {$CellContext`\[Upsilon], 0, 
              2. Pi}], $CellContext`greenwich = ParametricPlot3D[{
              Cos[$CellContext`\[Psi]], 0, 
              Sin[$CellContext`\[Psi]]}, {$CellContext`\[Psi], 0, Pi/
              2.}], $CellContext`meridian2 = ParametricPlot3D[{0, 
              Cos[$CellContext`\[Psi]], 
              Sin[$CellContext`\[Psi]]}, {$CellContext`\[Psi], 0, Pi/2.}]}, 
          
          With[{$CellContext`x = 
            Cos[$CellContext`lat] Cos[$CellContext`lon], $CellContext`y = 
            Sin[$CellContext`lat] Cos[$CellContext`lon], $CellContext`z = 
            Sin[$CellContext`lon]}, 
           
           With[{$CellContext`r = 
             EuclideanDistance[{
               0, 0, $CellContext`z}, {$CellContext`x, $CellContext`y, \
$CellContext`z}]}, 
            Show[
             Graphics3D[{
               Opacity[0.5], 
               Sphere[{0, 0, 0}, 1.], 
               Opacity[
               1.], $CellContext`axes3D}], $CellContext`equator, \
$CellContext`greenwich, $CellContext`meridian2, 
             
             ParametricPlot3D[{$CellContext`r 
               Cos[$CellContext`\[Upsilon]], $CellContext`r 
               Sin[$CellContext`\[Upsilon]], $CellContext`z}, {$CellContext`\
\[Upsilon], 0, 2. Pi}], 
             
             ParametricPlot3D[{$CellContext`x (
                Cos[$CellContext`\[Psi]]/$CellContext`r), $CellContext`y (
                Cos[$CellContext`\[Psi]]/$CellContext`r), 
               Sin[$CellContext`\[Psi]]}, {$CellContext`\[Psi], 0, Pi/2.}], 
             Graphics3D[
              Point[{$CellContext`x, $CellContext`y, $CellContext`z}]], 
             Graphics3D[
              
              Line[{{0, 0, 
                0}, {$CellContext`x, $CellContext`y, $CellContext`z}}]], 
             Graphics3D[
              Line[{{0, 0, 0}, {$CellContext`x, $CellContext`y, 0}}]], 
             Graphics3D[
              
              Line[{{$CellContext`x, $CellContext`y, $CellContext`z}, \
{$CellContext`x, $CellContext`y, 0}}]], 
             Graphics3D[
              
              Line[{{$CellContext`x, $CellContext`y, 0}, {$CellContext`x, 0, 
                 0}}]], 
             Graphics3D[
              
              Line[{{$CellContext`x, $CellContext`y, 0}, {
                0, $CellContext`y, 0}}]], 
             Graphics3D[
              
              Line[{{$CellContext`x, $CellContext`y, $CellContext`z}, {
                0, 0, $CellContext`z}}]], ViewPoint -> {2.4, 1.3, 2.}, Boxed -> 
             False]]]], 
        "Specifications" :> {{{$CellContext`p$$, {0.5003465267989831, 
            1.2438420283260498`}}, {0, 0}, {1.5707963267948966`, 
           1.5707963267948966`}}}, "Options" :> {}, "DefaultOptions" :> {}],
       ImageSizeCache->{610., {397., 406.}},
       SingleEvaluation->True],
      Deinitialization:>None,
      DynamicModuleValues:>{},
      SynchronousInitialization->True,
      UnsavedVariables:>{Typeset`initDone$$},
      UntrackedVariables:>{Typeset`size$$}], "Manipulate",
     Deployed->True,
     StripOnInput->False],
    TraditionalForm],
   Manipulate`InterpretManipulate[1]], TraditionalForm]], "Output",
 CellChangeTimes->{
  3.536016937482102*^9, 3.5360170234020166`*^9, {3.5360172630657244`*^9, 
   3.5360172747993956`*^9}, 3.5360173560990458`*^9, 3.5360174672404027`*^9, 
   3.536025443762967*^9, 3.5360256701419153`*^9, {3.5360259349140596`*^9, 
   3.5360259583433995`*^9}, {3.536026121172713*^9, 3.536026143006962*^9}, {
   3.536026217193205*^9, 3.5360262652879558`*^9}, 3.53602637899846*^9, 
   3.536026451677617*^9, 3.53602656781726*^9, 3.536027135748743*^9, {
   3.536028950194524*^9, 3.5360289567648993`*^9}, 3.5362707302944717`*^9}]
}, {2}]],

Cell["\<\
With longitude and latitude in decimal degrees, the following function \
returns a list of the 3-D Euclidean coordinates of the point on the Earth\
\[CloseCurlyQuote]s surface, in units of the Earth\[CloseCurlyQuote]s radius, \
that is, on the geometrical unit sphere. To get the coordinates in meters, \
multiply the coordinates by the Earth\[CloseCurlyQuote]s radius in meters.\
\>", "Text",
 CellChangeTimes->{{3.5359995960256777`*^9, 3.5359995969297686`*^9}, {
  3.5360275851514473`*^9, 3.536028124218281*^9}, {3.5360282752229176`*^9, 
  3.536028409529599*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"euclidean3DFromLonLat", "[", 
   RowBox[{"{", 
    RowBox[{"lon_", ",", "lat_"}], "}"}], "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"With", "[", 
   RowBox[{
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"lonRadians", "=", 
       RowBox[{"lon", "*", 
        RowBox[{"\[Pi]", "/", "180.0"}]}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"latRadians", "=", 
       RowBox[{"lat", "*", 
        RowBox[{"\[Pi]", "/", "180.0"}]}]}]}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       RowBox[{"Cos", "[", "latRadians", "]"}], 
       RowBox[{"Cos", "[", "lonRadians", "]"}]}], " ", ",", 
      RowBox[{"(*", " ", 
       RowBox[{"x", " ", "coordinate"}], " ", "*)"}], "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"Cos", "[", "latRadians", "]"}], 
       RowBox[{"Sin", "[", "lonRadians", "]"}]}], ",", " ", 
      RowBox[{"(*", " ", 
       RowBox[{"y", " ", "coordinate"}], " ", "*)"}], "\[IndentingNewLine]", 
      RowBox[{"Sin", "[", "latRadians", "]"}]}], "}"}]}], " ", "]"}], 
  RowBox[{"(*", " ", 
   RowBox[{"z", " ", "coordinate"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.536028135864947*^9, 3.5360282661734*^9}, 
   3.5360283349243326`*^9, {3.5360284160089703`*^9, 3.5360284877670746`*^9}, {
   3.536028704715483*^9, 3.536028747533932*^9}, {3.53602907111344*^9, 
   3.5360291006881313`*^9}}],

Cell[TextData[{
 "In C#, returning a struct containing the coordinates would probably be best \
both for efficiency and for type safety -- as opposed to an array that is \
heap-allocated (slower) and has a secret convention about the order of \
elements (not type-safe). In JavaScript, an object record would be safer, as \
in ",
 Cell[BoxData[
  FormBox[
   RowBox[{"{", 
    RowBox[{
     RowBox[{"x", ":", " ", 
      RowBox[{"-", "0.3614"}]}], ",", " ", 
     RowBox[{"y", ":", 
      RowBox[{"-", "0.5783"}]}], ",", " ", 
     RowBox[{"z", ":", "0.7313"}]}], "}"}], TraditionalForm]],
  FormatType->"TraditionalForm"],
 ", but an array, as in ",
 Cell[BoxData[
  FormBox[
   RowBox[{"[", 
    RowBox[{
     RowBox[{"-", "0.3614"}], ",", " ", 
     RowBox[{"-", "0.5783"}], ",", " ", "0.7313"}], "]"}], TraditionalForm]],
  FormatType->"TraditionalForm"],
 " might have better performance. The trade-off between safety and \
performance should be studied in JavaScript implementations."
}], "Text",
 CellChangeTimes->{{3.5359995960256777`*^9, 3.5359995969297686`*^9}, {
  3.5360275851514473`*^9, 3.536028124218281*^9}, {3.536028498254674*^9, 
  3.5360285471314697`*^9}}],

Cell["\<\
Given a pair of lon-lats, now, we can compute the Euclidean distance between \
them as follows, again in units of the Earth\[CloseCurlyQuote]s radius:\
\>", "Text",
 CellChangeTimes->{{3.536028627793083*^9, 3.5360286700184984`*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"euclidean3DDistance", "[", 
   RowBox[{
    RowBox[{"l1", ":", 
     RowBox[{"{", 
      RowBox[{"lon1_", ",", "lat1_"}], "}"}]}], ",", 
    RowBox[{"l2", ":", 
     RowBox[{"{", 
      RowBox[{"lon2_", ",", "lat2_"}], "}"}]}]}], "]"}], ":=", 
  "\[IndentingNewLine]", 
  RowBox[{"With", "[", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"p1", "=", 
       RowBox[{"euclidean3DFromLonLat", "[", "l1", "]"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"p2", "=", 
       RowBox[{"euclidean3DFromLonLat", "[", "l2", "]"}]}]}], "}"}], ",", 
    "\[IndentingNewLine]", 
    SqrtBox[
     RowBox[{
      RowBox[{"(", 
       RowBox[{"p2", "-", "p1"}], ")"}], ".", 
      RowBox[{"(", 
       RowBox[{"p2", "-", "p1"}], ")"}]}]]}], "]"}]}]], "Input",
 CellChangeTimes->{{3.5360291626956778`*^9, 3.5360292694457836`*^9}, {
  3.5360293036977425`*^9, 3.5360293393187804`*^9}}],

Cell[TextData[{
 "In ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 ", we can call this function with symbolic arguments to check that it \
produces the expected formula:"
}], "Text",
 CellChangeTimes->{{3.5360294314940524`*^9, 3.5360294648529606`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"euclidean3DDistance", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"lon1", ",", "lat1"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"lon2", ",", "lat2"}], "}"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.536029351307466*^9, 3.536029394806954*^9}}],

Cell[BoxData[
 FormBox[
  RowBox[{"\[Sqrt]", 
   RowBox[{"(", 
    RowBox[{
     SuperscriptBox[
      RowBox[{"(", 
       RowBox[{
        RowBox[{
         RowBox[{"cos", "(", 
          RowBox[{"0.017453292519943295`", " ", "lat2"}], ")"}], " ", 
         RowBox[{"cos", "(", 
          RowBox[{"0.017453292519943295`", " ", "lon2"}], ")"}]}], "-", 
        RowBox[{
         RowBox[{"cos", "(", 
          RowBox[{"0.017453292519943295`", " ", "lat1"}], ")"}], " ", 
         RowBox[{"cos", "(", 
          RowBox[{"0.017453292519943295`", " ", "lon1"}], ")"}]}]}], ")"}], 
      "2"], "+", 
     SuperscriptBox[
      RowBox[{"(", 
       RowBox[{
        RowBox[{
         RowBox[{"cos", "(", 
          RowBox[{"0.017453292519943295`", " ", "lat2"}], ")"}], " ", 
         RowBox[{"sin", "(", 
          RowBox[{"0.017453292519943295`", " ", "lon2"}], ")"}]}], "-", 
        RowBox[{
         RowBox[{"cos", "(", 
          RowBox[{"0.017453292519943295`", " ", "lat1"}], ")"}], " ", 
         RowBox[{"sin", "(", 
          RowBox[{"0.017453292519943295`", " ", "lon1"}], ")"}]}]}], ")"}], 
      "2"], "+", 
     SuperscriptBox[
      RowBox[{"(", 
       RowBox[{
        RowBox[{"sin", "(", 
         RowBox[{"0.017453292519943295`", " ", "lat2"}], ")"}], "-", 
        RowBox[{"sin", "(", 
         RowBox[{"0.017453292519943295`", " ", "lat1"}], ")"}]}], ")"}], 
      "2"]}], ")"}]}], TraditionalForm]], "Output",
 CellChangeTimes->{{3.536029371909644*^9, 3.5360293859754486`*^9}, 
   3.53627073037848*^9}]
}, Open  ]],

Cell["\<\
This distance should always be less than the Haversin distance because the \
Euclidean 3-D line connecting two points cuts \[OpenCurlyDoubleQuote]below\
\[CloseCurlyDoubleQuote] the Earth\[CloseCurlyQuote]s surface, while the \
Haversin distance measures integrated distance along the great-circle route, \
which rides along the Earth\[CloseCurlyQuote]s surface. \
\>", "Text",
 CellChangeTimes->{{3.5360294840340576`*^9, 3.5360294999409676`*^9}, {
  3.5360295333148766`*^9, 3.536029544202499*^9}, {3.5360295890740657`*^9, 
  3.536029640676017*^9}}],

Cell["\<\
We can study the difference between the Euclidean 3-D distance and the \
Haversin distance in the following interactivc visualization:\
\>", "Text",
 CellChangeTimes->{{3.5360296564379187`*^9, 3.5360296944630933`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"Plot3D", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
      RowBox[{"(", 
       RowBox[{
        RowBox[{"EarthHaversinDistance", "[", "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"0.0", ",", "0.0"}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"\[CapitalDelta]lon", ",", "\[CapitalDelta]lat"}], "}"}]}],
          "]"}], "-", 
        RowBox[{"earthRadius", "*", 
         RowBox[{"euclidean3DDistance", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"0.0", ",", "0.0"}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{"\[CapitalDelta]lon", ",", "\[CapitalDelta]lat"}], 
            "}"}]}], "]"}]}]}], ")"}], "/", "meter"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{"\[CapitalDelta]lon", ",", 
       RowBox[{"-", "maxDelta"}], ",", "maxDelta"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"\[CapitalDelta]lat", ",", 
       RowBox[{"-", "maxDelta"}], ",", "maxDelta"}], "}"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"AxesLabel", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{
       "\"\<\[CapitalDelta]lon (degrees)\>\"", ",", 
        "\"\<\[CapitalDelta]lat (degrees)\>\"", ",", 
        "\"\<\[CapitalDelta] Distance (meters)\>\""}], "}"}]}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{
     "PlotLabel", "\[Rule]", 
      "\"\<Difference between Haversin Distance and Euclidean \
Distance\>\""}]}], "]"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{"maxDelta", ",", "0.0001", ",", "1.0", ",", 
     RowBox[{"Appearance", "\[Rule]", "\"\<Open\>\""}]}], "}"}], ",", 
   RowBox[{"SaveDefinitions", "\[Rule]", "True"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.5360298654108715`*^9, 3.53603013585834*^9}, {
  3.5360301690012355`*^9, 3.536030427906044*^9}, {3.5360305586245203`*^9, 
  3.536030582897909*^9}}],

Cell[BoxData[
 FormBox[
  TagBox[
   FormBox[
    StyleBox[
     DynamicModuleBox[{$CellContext`maxDelta$$ = 0.0001, Typeset`show$$ = 
      True, Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
      Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
      "\"untitled\"", Typeset`specs$$ = {{
        Hold[$CellContext`maxDelta$$], 0.0001, 1.}}, Typeset`size$$ = {
      540., {160., 170.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
      Typeset`skipInitDone$$ = False, $CellContext`maxDelta$590$$ = 0}, 
      DynamicBox[Manipulate`ManipulateBoxes[
       1, TraditionalForm, "Variables" :> {$CellContext`maxDelta$$ = 0.0001}, 
        "ControllerVariables" :> {
          Hold[$CellContext`maxDelta$$, $CellContext`maxDelta$590$$, 0]}, 
        "OtherVariables" :> {
         Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
          Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
          Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
          Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> 
        Plot3D[($CellContext`EarthHaversinDistance[{0., 
             0.}, {$CellContext`\[CapitalDelta]lon, $CellContext`\
\[CapitalDelta]lat}] - $CellContext`earthRadius \
$CellContext`euclidean3DDistance[{0., 
             0.}, {$CellContext`\[CapitalDelta]lon, $CellContext`\
\[CapitalDelta]lat}])/$CellContext`meter, {$CellContext`\[CapitalDelta]lon, \
-$CellContext`maxDelta$$, $CellContext`maxDelta$$}, {$CellContext`\
\[CapitalDelta]lat, -$CellContext`maxDelta$$, $CellContext`maxDelta$$}, 
          AxesLabel -> {
           "\[CapitalDelta]lon (degrees)", "\[CapitalDelta]lat (degrees)", 
            "\[CapitalDelta] Distance (meters)"}, PlotLabel -> 
          "Difference between Haversin Distance and Euclidean Distance"], 
        "Specifications" :> {{$CellContext`maxDelta$$, 0.0001, 1., Appearance -> 
           "Open"}}, "Options" :> {}, "DefaultOptions" :> {}],
       ImageSizeCache->{610., {255., 264.}},
       SingleEvaluation->True],
      Deinitialization:>None,
      DynamicModuleValues:>{},
      Initialization:>({$CellContext`EarthHaversinDistance[{
            Pattern[$CellContext`lon1, 
             Blank[]], 
            Pattern[$CellContext`lat1, 
             Blank[]]}, {
            Pattern[$CellContext`lon2, 
             Blank[]], 
            Pattern[$CellContext`lat2, 
             Blank[]]}] := $CellContext`earthRadius 2 ArcSin[
            Sqrt[
             $CellContext`q[{$CellContext`lon1, $CellContext`lat1}, \
{$CellContext`lon2, $CellContext`lat2}]]], $CellContext`earthRadius = 
         6.3675*^6 $CellContext`meter, $CellContext`q[{
            Pattern[$CellContext`lon1, 
             Blank[]], 
            Pattern[$CellContext`lat1, 
             Blank[]]}, {
            Pattern[$CellContext`lon2, 
             Blank[]], 
            Pattern[$CellContext`lat2, 
             
             Blank[]]}] := $CellContext`h[$CellContext`lat2 - \
$CellContext`lat1] + 
          Cos[($CellContext`lat1 Pi)/180.] 
           Cos[($CellContext`lat2 Pi)/
             180.] $CellContext`h[$CellContext`lon2 - $CellContext`lon1], \
$CellContext`h[
           Pattern[$CellContext`angleDegrees, 
            Blank[]]] := 
         Sin[($CellContext`angleDegrees Pi)/(180. 
            2)]^2, $CellContext`euclidean3DDistance[
           Pattern[$CellContext`l1, {
             Pattern[$CellContext`lon1, 
              Blank[]], 
             Pattern[$CellContext`lat1, 
              Blank[]]}], 
           Pattern[$CellContext`l2, {
             Pattern[$CellContext`lon2, 
              Blank[]], 
             Pattern[$CellContext`lat2, 
              Blank[]]}]] := 
         With[{$CellContext`p1 = \
$CellContext`euclidean3DFromLonLat[$CellContext`l1], $CellContext`p2 = \
$CellContext`euclidean3DFromLonLat[$CellContext`l2]}, 
           Sqrt[
            
            Dot[$CellContext`p2 - $CellContext`p1, $CellContext`p2 - \
$CellContext`p1]]], $CellContext`euclidean3DFromLonLat[{
            Pattern[$CellContext`lon, 
             Blank[]], 
            Pattern[$CellContext`lat, 
             Blank[]]}] := 
         With[{$CellContext`lonRadians = $CellContext`lon (Pi/
              180.), $CellContext`latRadians = $CellContext`lat (Pi/180.)}, {
           Cos[$CellContext`latRadians] Cos[$CellContext`lonRadians], 
            Cos[$CellContext`latRadians] Sin[$CellContext`lonRadians], 
            Sin[$CellContext`latRadians]}]}; Typeset`initDone$$ = True),
      SynchronousInitialization->True,
      UnsavedVariables:>{Typeset`initDone$$},
      UntrackedVariables:>{Typeset`size$$}], "Manipulate",
     Deployed->True,
     StripOnInput->False],
    TraditionalForm],
   Manipulate`InterpretManipulate[1]], TraditionalForm]], "Output",
 CellChangeTimes->{
  3.536029968854788*^9, 3.5360300770769777`*^9, 3.5360301396265554`*^9, 
   3.5360301769276886`*^9, {3.5360303002397423`*^9, 3.5360304300491667`*^9}, 
   3.536030585157038*^9, 3.5362707304064827`*^9}]
}, {2}]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Distances and Headings in the Tangent Plane", "Subsection",
 CellChangeTimes->{{3.5358265233270264`*^9, 3.5358265310474677`*^9}}],

Cell["TBD", "Text",
 CellChangeTimes->{{3.5362711654969873`*^9, 3.536271166064044*^9}}]
}, Open  ]]
}, Open  ]]
}, Open  ]]
},
WindowSize->{942, 910},
WindowMargins->{{1, Automatic}, {Automatic, 2}},
ShowSelection->True,
FrontEndVersion->"8.0 for Microsoft Windows (64-bit) (October 6, 2011)",
StyleDefinitions->FrontEnd`FileName[{"Report"}, "StandardReport.nb", 
  CharacterEncoding -> "WindowsANSI"]
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{
 "MetricalOptions"->{
  Cell[56702, 1506, 255, 5, 32, "ItemNumbered",
   CellTags->"MetricalOptions"],
  Cell[56960, 1513, 419, 6, 32, "ItemNumbered",
   CellTags->"MetricalOptions"],
  Cell[57382, 1521, 375, 5, 32, "ItemNumbered",
   CellTags->"MetricalOptions"]}
 }
*)
(*CellTagsIndex
CellTagsIndex->{
 {"MetricalOptions", 310679, 6164}
 }
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1257, 32, 115, 1, 120, "Title"],
Cell[1375, 35, 115, 1, 44, "Subtitle"],
Cell[1493, 38, 235, 6, 71, "Subsubtitle"],
Cell[1731, 46, 979, 16, 164, "Text"],
Cell[2713, 64, 148, 2, 41, "Text"],
Cell[2864, 68, 923, 31, 66, "Text"],
Cell[3790, 101, 287, 5, 66, "Text"],
Cell[4080, 108, 1525, 44, 117, "Text"],
Cell[CellGroupData[{
Cell[5630, 156, 5375, 141, 744, "Input"],
Cell[11008, 299, 4371, 82, 679, "Output"]
}, {2}]],
Cell[15391, 384, 978, 20, 115, "Text"],
Cell[16372, 406, 2437, 91, 139, "Text"],
Cell[18812, 499, 752, 21, 90, "Text"],
Cell[19567, 522, 1661, 52, 139, "Text"],
Cell[21231, 576, 476, 13, 41, "Text"],
Cell[21710, 591, 471, 10, 41, "Text"],
Cell[22184, 603, 255, 5, 41, "Text"],
Cell[22442, 610, 992, 34, 41, "Text"],
Cell[23437, 646, 251, 5, 41, "Text"],
Cell[CellGroupData[{
Cell[23713, 655, 670, 21, 85, "Input"],
Cell[24386, 678, 1377, 30, 56, "Output"]
}, Open  ]],
Cell[25778, 711, 254, 5, 66, "Text"],
Cell[26035, 718, 106, 1, 41, "Text"],
Cell[26144, 721, 793, 23, 41, "Text"],
Cell[26940, 746, 613, 19, 90, "Text"],
Cell[27556, 767, 399, 11, 56, "Text"],
Cell[27958, 780, 157, 2, 41, "Text"],
Cell[28118, 784, 954, 28, 56, "Text"],
Cell[29075, 814, 847, 27, 66, "Text"],
Cell[29925, 843, 561, 17, 57, "Text"],
Cell[30489, 862, 780, 25, 66, "Text"],
Cell[31272, 889, 340, 10, 41, "Text"],
Cell[31615, 901, 546, 16, 66, "Text"],
Cell[32164, 919, 193, 2, 41, "Text"],
Cell[32360, 923, 1584, 45, 337, "Input"],
Cell[33947, 970, 579, 15, 90, "Text"],
Cell[CellGroupData[{
Cell[34551, 989, 216, 2, 108, "Section"],
Cell[34770, 993, 596, 20, 66, "Text"],
Cell[CellGroupData[{
Cell[35391, 1017, 10303, 237, 1214, "Input"],
Cell[45697, 1256, 6928, 141, 679, "Output"]
}, {2}]]
}, Open  ]],
Cell[CellGroupData[{
Cell[52671, 1403, 131, 1, 108, "Section"],
Cell[52805, 1406, 946, 26, 115, "Text"],
Cell[53754, 1434, 831, 13, 115, "Text"],
Cell[CellGroupData[{
Cell[54610, 1451, 419, 12, 57, "Input"],
Cell[55032, 1465, 841, 20, 69, "Output"]
}, Open  ]],
Cell[55888, 1488, 539, 8, 90, "Text"],
Cell[56430, 1498, 247, 4, 41, "Text"],
Cell[CellGroupData[{
Cell[56702, 1506, 255, 5, 32, "ItemNumbered",
 CellTags->"MetricalOptions"],
Cell[56960, 1513, 419, 6, 32, "ItemNumbered",
 CellTags->"MetricalOptions"],
Cell[57382, 1521, 375, 5, 32, "ItemNumbered",
 CellTags->"MetricalOptions"]
}, Open  ]],
Cell[57772, 1529, 519, 8, 90, "Text"],
Cell[CellGroupData[{
Cell[58316, 1541, 128, 1, 36, "Subsection"],
Cell[CellGroupData[{
Cell[58469, 1546, 100, 1, 32, "Subsubsection"],
Cell[58572, 1549, 135, 3, 41, "Text"],
Cell[58710, 1554, 363, 10, 83, "Input"],
Cell[59076, 1566, 250, 5, 41, "Text"],
Cell[59329, 1573, 681, 21, 111, "Input"],
Cell[60013, 1596, 543, 9, 115, "Text"],
Cell[60559, 1607, 230, 5, 57, "Input"],
Cell[60792, 1614, 923, 24, 124, "Input"],
Cell[61718, 1640, 712, 11, 139, "Text"],
Cell[CellGroupData[{
Cell[62455, 1655, 1329, 32, 328, "Input"],
Cell[63787, 1689, 68094, 1108, 371, "Output"]
}, Open  ]],
Cell[131896, 2800, 175, 4, 41, "Text"],
Cell[CellGroupData[{
Cell[132096, 2808, 1774, 41, 301, "Input"],
Cell[133873, 2851, 4058, 83, 463, "Output"]
}, {2}]]
}, Open  ]],
Cell[CellGroupData[{
Cell[137977, 2940, 99, 1, 32, "Subsubsection"],
Cell[138079, 2943, 338, 6, 66, "Text"],
Cell[138420, 2951, 2053, 51, 355, "Input"],
Cell[140476, 3004, 376, 7, 66, "Text"],
Cell[CellGroupData[{
Cell[140877, 3015, 1317, 36, 220, "Input"],
Cell[142197, 3053, 3573, 64, 343, "Output"]
}, {2}]],
Cell[145782, 3120, 252, 5, 66, "Text"],
Cell[CellGroupData[{
Cell[146059, 3129, 1396, 38, 220, "Input"],
Cell[147458, 3169, 1976, 37, 324, "Output"]
}, {2}]],
Cell[149446, 3209, 408, 7, 66, "Text"],
Cell[CellGroupData[{
Cell[149879, 3220, 1248, 29, 274, "Input"],
Cell[151130, 3251, 123875, 2023, 374, "Output"]
}, {2}]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[275063, 5281, 135, 1, 36, "Subsection"],
Cell[275201, 5284, 269, 5, 66, "Text"],
Cell[CellGroupData[{
Cell[275495, 5293, 393, 8, 54, "ItemNumbered"],
Cell[275891, 5303, 267, 7, 32, "ItemNumbered"],
Cell[276161, 5312, 240, 6, 32, "ItemNumbered"]
}, Open  ]],
Cell[276416, 5321, 1688, 47, 188, "Text"],
Cell[CellGroupData[{
Cell[278129, 5372, 11682, 281, 1111, "Input"],
Cell[289814, 5655, 5893, 125, 841, "Output"]
}, {2}]],
Cell[295719, 5783, 575, 9, 90, "Text"],
Cell[296297, 5794, 1425, 34, 220, "Input"],
Cell[297725, 5830, 1174, 29, 164, "Text"],
Cell[298902, 5861, 242, 4, 66, "Text"],
Cell[299147, 5867, 948, 28, 189, "Input"],
Cell[300098, 5897, 259, 7, 66, "Text"],
Cell[CellGroupData[{
Cell[300382, 5908, 271, 7, 57, "Input"],
Cell[300656, 5917, 1521, 42, 128, "Output"]
}, Open  ]],
Cell[302192, 5962, 559, 9, 90, "Text"],
Cell[302754, 5973, 228, 4, 66, "Text"],
Cell[CellGroupData[{
Cell[303007, 5981, 1958, 48, 355, "Input"],
Cell[304968, 6031, 5004, 106, 557, "Output"]
}, {2}]]
}, Open  ]],
Cell[CellGroupData[{
Cell[310018, 6143, 135, 1, 36, "Subsection"],
Cell[310156, 6146, 87, 1, 41, "Text"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature RwDqw9sBWWEAKDK##LpW0DLy *)
