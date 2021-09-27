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
NotebookDataLength[     12732,        348]
NotebookOptionsPosition[     12729,        332]
NotebookOutlinePosition[     13172,        350]
CellTagsIndexPosition[     13129,        347]
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
   RowBox[{"montyChoice", "[", "yourFirst_", "]"}], ":=", 
   "\[IndentingNewLine]", 
   RowBox[{"If", "[", 
    RowBox[{
     RowBox[{"yourFirst", "===", "1"}], ",", "\[IndentingNewLine]", 
     RowBox[{"RandomInteger", "[", 
      RowBox[{"{", 
       RowBox[{"2", ",", "3"}], "}"}], "]"}], ",", "\[IndentingNewLine]", 
     RowBox[{"(*", " ", "else", " ", "*)"}], " ", 
     RowBox[{"5", "-", "yourFirst"}]}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"secondChoice", "[", 
    RowBox[{"yourFirst_", ",", "montyChoice_", ",", "switchQ_"}], "]"}], ":=",
    "\[IndentingNewLine]", 
   RowBox[{"If", "[", 
    RowBox[{"switchQ", ",", "\[IndentingNewLine]", 
     RowBox[{"Switch", "[", 
      RowBox[{"yourFirst", ",", "\[IndentingNewLine]", "1", ",", 
       RowBox[{"5", "-", "montyChoice"}], ",", "\[IndentingNewLine]", "2", 
       ",", "1", ",", "\[IndentingNewLine]", "3", ",", "1"}], "]"}], ",", 
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
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"m", "=", 
         RowBox[{"montyChoice", "[", "f", "]"}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"secondChoice", "[", 
        RowBox[{"f", ",", "m", ",", "switchQ"}], "]"}]}], "]"}]}], "]"}]}], 
  ";"}]], "Input"],

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
         RectangleBox[{0.5, 0.}, {1.5, 199435.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{42.125, 175.98724489795921`}, {-111.88785166519888`,
          114.749053681051}}],
       StatusArea[#, 199435.]& ,
       TagBoxNote->"199435."],
      StyleBox["199435.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[199435., {
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
         RectangleBox[{1.5, 0.}, {2.5, 50799.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{174.73724489795921`, 308.5994897959184}, {
         56.08972530496782, 114.749053681051}}],
       StatusArea[#, 50799.]& ,
       TagBoxNote->"50799."],
      StyleBox["50799.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[50799., {
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
         RectangleBox[{2.5, 0.}, {3.5, 49766.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{307.3494897959184, 441.2117346938776}, {
         57.257146636342334`, 114.749053681051}}],
       StatusArea[#, 49766.]& ,
       TagBoxNote->"49766."],
      StyleBox["49766.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[49766., {
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
         RectangleBox[{0.5, 0.}, {1.5, 99673.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{42.125, 175.98724489795921`}, {-110.09547033137797`,
          114.749053681051}}],
       StatusArea[#, 99673.]& ,
       TagBoxNote->"99673."],
      StyleBox["99673.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[99673., {
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
         RectangleBox[{1.5, 0.}, {2.5, 99855.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{174.73724489795921`, 
         308.5994897959184}, {-110.503747431197, 114.749053681051}}],
       StatusArea[#, 99855.]& ,
       TagBoxNote->"99855."],
      StyleBox["99855.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[99855., {
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
         RectangleBox[{2.5, 0.}, {3.5, 100472.}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{307.3494897959184, 
         441.2117346938776}, {-111.88785166519885`, 114.749053681051}}],
       StatusArea[#, 100472.]& ,
       TagBoxNote->"100472."],
      StyleBox["100472.`", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[100472., {
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
  Ticks->{Automatic, Automatic}]], "Output",
 ImageCache->GraphicsData["CompressedBitmap", "\<\
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
HxvzbVr2vCztztiSIN1L0Iv6cE2+Mh3NiqZFSNkDNkQ3hjcsLV5WD9jBjC7u
WSZMy0U/mUkPW1vz69QHN6SWwWtLersfd9swe3mOEdU8XyEqxKuCqFqzQlSI
qu0pxL1H3H/GjD/fn/J9xuWjaktZMqlMvtz43fjGyt5TY7Ku6SO8eHGI47Pr
d/D49fbSY0eidElnuoMJ8fEZIldnRk/+/Tf8VKu+wdEGrkxyS8hGMHWPvYoz
plQQLXedF2sXbSZ52vnQg0madcrchZa+/lpDuzgzztN+GkPPYKi85MY3CaRM
e86Vca1ugG6At4VWtNm0lSM7FQ2rmA7geAPId2AVOaYQ1ZReISpEhahas0JU
iKrtKcS2IC5PxMgwny/kHfabMONPwjfJExzlmEx4ns0JLf4Y307iTG6uKKYR
Q5XHrYw8jbFD/6onw/aeQ5OMzPnDJqhRPfxqdbdPmyi0FdWMsHwmZjzKOg/W
JvYsCUyG3U9nmKV9fmTAT7r4dnvZM6nadOBylsn24Dk2vHBIKiRr/6azQ9a8
fZ31FqK7+xQ2HMkhZdslkXZZrOdNelAI49F0N1q27npSTNt7Mu268Bd6DFbc
82EaJoLBlKVZo8g0xagpRPUcoBAVYlsQVdtTiArxqiCq1qwQn4JRK7IF5oIB
239GTZJPKGYIbR2a6SJgrJpLj81DAzvWGlKNH5DplSfzJr5OntvTJnasNaSa
PPiTM08Ldti27v9hlTVrJ6mGLGXHTofxCF2bv2QW/v0f7Xt9U+7bykb8+Ev6
8enLqFfkNU7q9OwUVMtHv0sas+ljWlwBRu0V0bwYs0XLZPskvSvzGic9rpye
5prmrFEzeq07zlq7RY03tBvsNU56BKptkdFlMC5HHLVVTSGqxwGFqBBbiqja
nkJUiKrtKcTnEFESa9uSY/tBrDFyDI2/8HYBcmzvuTYu4IvVn09jfxckyy6Z
e6PivyeUeBY9j6s/bYRzpNrZNuzZ+Ww75eLqVKV3v3hqLdf5tbNtiLRLpOWI
3Ae4devWz+m3X15QmXV67WwbHu0SWTkpM7syLuOiGq2zamfb0Gfns+2MjFvR
6IOq4J+t/mQVNm1S20CNbcj37FRbneyiM1/72ScuyMXIr0vk0pqNvvqjSRfj
uXZOltWJ+Wob4jtl9K/3SKq2x++dVbVr/wN/8+Ei\
\>"]]
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
Cell[1353, 35, 1235, 30, 256, "Input"],
Cell[2591, 67, 588, 17, 104, "Input"],
Cell[CellGroupData[{
Cell[3204, 88, 275, 8, 46, "Input"],
Cell[3482, 98, 2608, 77, 299, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[6127, 180, 276, 8, 46, "Input"],
Cell[6406, 190, 6307, 139, 373, 2609, 77, "CachedBoxData", "BoxData", "Output"]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature twDcEyLd7LUI2CKXd5QfhBAK *)
