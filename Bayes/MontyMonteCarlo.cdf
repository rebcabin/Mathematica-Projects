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
NotebookDataLength[      9985,        332]
NotebookOptionsPosition[      9801,        308]
NotebookOutlinePosition[     10244,        326]
CellTagsIndexPosition[     10201,        323]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{
Cell["\<\
The car is behind door 1. All other cases are symmetric and have the same \
probabilities. \
\>", "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"firstChoice", "[", "]"}], ":=", 
   RowBox[{"RandomInteger", "[", 
    RowBox[{"{", 
     RowBox[{"1", ",", "3"}], "}"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"montyChoice", "[", "]"}], ":=", 
   RowBox[{"RandomInteger", "[", 
    RowBox[{"{", 
     RowBox[{"2", ",", "3"}], "}"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"secondChoice", "[", 
    RowBox[{"yourFirst_", ",", "montyChoice_", ",", "switchQ_"}], "]"}], ":=",
    "\[IndentingNewLine]", 
   RowBox[{"If", "[", 
    RowBox[{"switchQ", ",", "\[IndentingNewLine]", 
     RowBox[{"(*", " ", 
      RowBox[{
      "choose", " ", "between", " ", "door", " ", "1", " ", "and", " ", 
       "whatever", " ", "monty", " ", 
       RowBox[{"didn", "'"}], "t", " ", "choose"}], " ", "*)"}], 
     RowBox[{"RandomChoice", "[", 
      RowBox[{"{", 
       RowBox[{"1", ",", 
        RowBox[{"5", "-", "montyChoice"}]}], "}"}], "]"}], ",", 
     "\[IndentingNewLine]", "yourFirst"}], "]"}]}], ";"}]}], "Input"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"round", "[", "switchQ_", "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"f", "=", 
       RowBox[{"firstChoice", "[", "]"}]}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"If", "[", 
      RowBox[{
       RowBox[{"f", "===", "1"}], ",", "\[IndentingNewLine]", "1", ",", 
       "\[IndentingNewLine]", 
       RowBox[{"secondChoice", "[", 
        RowBox[{"f", ",", 
         RowBox[{"montyChoice", "[", "]"}], ",", "switchQ"}], "]"}]}], 
      "]"}]}], "]"}]}], ";"}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Tally", "@", 
  RowBox[{"Table", "[", 
   RowBox[{
    RowBox[{"round", "[", "True", "]"}], ",", 
    RowBox[{"{", "300000", "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"3", ",", "50178"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"1", ",", "199842"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"2", ",", "49980"}], "}"}]}], "}"}]], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Tally", "@", 
  RowBox[{"Table", "[", 
   RowBox[{
    RowBox[{"round", "[", "False", "]"}], ",", 
    RowBox[{"{", "300000", "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"2", ",", "99826"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"1", ",", "100023"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"3", ",", "100151"}], "}"}]}], "}"}]], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Histogram", "[", 
  RowBox[{
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"round", "[", "True", "]"}], ",", 
     RowBox[{"{", "300000", "}"}]}], "]"}], ",", 
   RowBox[{"{", 
    RowBox[{"0.5", ",", "3.5", ",", "1"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData[
 GraphicsBox[
  {RGBColor[0.798413061722744, 0.824719615472648, 0.968322270542458], 
   EdgeForm[Opacity[0.7]], {}, 
   {RGBColor[0.798413061722744, 0.824719615472648, 0.968322270542458], 
    EdgeForm[Opacity[0.7]], 
    TagBox[
     TooltipBox[
      TagBox[
       DynamicBox[{
         FEPrivate`If[
          CurrentValue["MouseOver"], 
          EdgeForm[{
            GrayLevel[0.5], 
            AbsoluteThickness[1.5], 
            Opacity[0.66]}], {}, {}], 
         RectangleBox[{0.5, 0.}, {1.5, 199633.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{42.125, 175.98724489795921`}, {-111.8878516651989, 
         114.74905368105101`}}],
       StatusArea[#, 199633.]& ,
       TagBoxNote->"199633."],
      StyleBox["199633.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[199633., {
        GrayLevel[0]}], "Tooltip"]& ], 
    TagBox[
     TooltipBox[
      TagBox[
       DynamicBox[{
         FEPrivate`If[
          CurrentValue["MouseOver"], 
          EdgeForm[{
            GrayLevel[0.5], 
            AbsoluteThickness[1.5], 
            Opacity[0.66]}], {}, {}], 
         RectangleBox[{1.5, 0.}, {2.5, 50161.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{174.73724489795921`, 308.5994897959184}, {
         56.86697101399074, 114.74905368105101`}}],
       StatusArea[#, 50161.]& ,
       TagBoxNote->"50161."],
      StyleBox["50161.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[50161., {
        GrayLevel[0]}], "Tooltip"]& ], 
    TagBox[
     TooltipBox[
      TagBox[
       DynamicBox[{
         FEPrivate`If[
          CurrentValue["MouseOver"], 
          EdgeForm[{
            GrayLevel[0.5], 
            AbsoluteThickness[1.5], 
            Opacity[0.66]}], {}, {}], 
         RectangleBox[{2.5, 0.}, {3.5, 50206.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{307.3494897959184, 441.2117346938776}, {
         56.81616573259648, 114.74905368105101`}}],
       StatusArea[#, 50206.]& ,
       TagBoxNote->"50206."],
      StyleBox["50206.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[50206., {
        GrayLevel[0]}], "Tooltip"]& ]}, {}, {}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesOrigin->{0.5, 0.},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  PlotRange->{{0.5, 3.5}, {All, All}},
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.02], 
     Scaled[0.1]}},
  Ticks->{Automatic, Automatic}]], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Histogram", "[", 
  RowBox[{
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"round", "[", "False", "]"}], ",", 
     RowBox[{"{", "300000", "}"}]}], "]"}], ",", 
   RowBox[{"{", 
    RowBox[{"0.5", ",", "3.5", ",", "1"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData[
 GraphicsBox[
  {RGBColor[0.798413061722744, 0.824719615472648, 0.968322270542458], 
   EdgeForm[Opacity[0.7]], {}, 
   {RGBColor[0.798413061722744, 0.824719615472648, 0.968322270542458], 
    EdgeForm[Opacity[0.7]], 
    TagBox[
     TooltipBox[
      TagBox[
       DynamicBox[{
         FEPrivate`If[
          CurrentValue["MouseOver"], 
          EdgeForm[{
            GrayLevel[0.5], 
            AbsoluteThickness[1.5], 
            Opacity[0.66]}], {}, {}], 
         RectangleBox[{0.5, 0.}, {1.5, 100616.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{42.125, 175.98724489795921`}, {-111.88785166519885`,
          114.749053681051}}],
       StatusArea[#, 100616.]& ,
       TagBoxNote->"100616."],
      StyleBox["100616.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[100616., {
        GrayLevel[0]}], "Tooltip"]& ], 
    TagBox[
     TooltipBox[
      TagBox[
       DynamicBox[{
         FEPrivate`If[
          CurrentValue["MouseOver"], 
          EdgeForm[{
            GrayLevel[0.5], 
            AbsoluteThickness[1.5], 
            Opacity[0.66]}], {}, {}], 
         RectangleBox[{1.5, 0.}, {2.5, 99373.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{174.73724489795921`, 
         308.5994897959184}, {-109.103444380618, 114.749053681051}}],
       StatusArea[#, 99373.]& ,
       TagBoxNote->"99373."],
      StyleBox["99373.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[99373., {
        GrayLevel[0]}], "Tooltip"]& ], 
    TagBox[
     TooltipBox[
      TagBox[
       DynamicBox[{
         FEPrivate`If[
          CurrentValue["MouseOver"], 
          EdgeForm[{
            GrayLevel[0.5], 
            AbsoluteThickness[1.5], 
            Opacity[0.66]}], {}, {}], 
         RectangleBox[{2.5, 0.}, {3.5, 100011.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{307.3494897959184, 
         441.2117346938776}, {-110.5326091815533, 114.749053681051}}],
       StatusArea[#, 100011.]& ,
       TagBoxNote->"100011."],
      StyleBox["100011.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[100011., {
        GrayLevel[0]}], "Tooltip"]& ]}, {}, {}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesOrigin->{0.5, 0.},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  PlotRange->{{0.5, 3.5}, {All, All}},
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.02], 
     Scaled[0.1]}},
  Ticks->{Automatic, Automatic}]], "Output"]
}, Open  ]]
},
WindowSize->{740, 752},
WindowMargins->{{4, Automatic}, {Automatic, 4}},
Magnification->1.25,
FrontEndVersion->"8.0 for Mac OS X x86 (32-bit, 64-bit Kernel) (July 22, \
2012)",
StyleDefinitions->FrontEnd`FileName[{"Creative"}, "NaturalColor.nb", 
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
Cell[1235, 30, 115, 3, 32, "Text"],
Cell[1353, 35, 1074, 29, 161, "Input"],
Cell[2430, 66, 591, 16, 123, "Input"],
Cell[CellGroupData[{
Cell[3046, 86, 176, 5, 46, "Input"],
Cell[3225, 93, 243, 8, 46, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[3505, 106, 177, 5, 46, "Input"],
Cell[3685, 113, 244, 8, 46, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[3966, 126, 275, 8, 46, "Input"],
Cell[4244, 136, 2613, 77, 299, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[6894, 218, 276, 8, 46, "Input"],
Cell[7173, 228, 2612, 77, 299, "Output"]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature 4xpQyecH8TSuwBKN7#ZhHUEL *)
