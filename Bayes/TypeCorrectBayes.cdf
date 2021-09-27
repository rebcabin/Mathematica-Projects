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
NotebookDataLength[    141164,       4133]
NotebookOptionsPosition[    120119,       3602]
NotebookOutlinePosition[    134516,       3903]
CellTagsIndexPosition[    134473,       3900]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["MOTIVATING EXAMPLE", "Section"],

Cell[TextData[{
 "Consider a school with 50 students: 30 boys and 20 girls. Three of the boys \
wear kilts, and 27 of the boys wear pants. Thirteen of the girls wear skirts \
and seven of the girls wear pants. Kilts and skirts are visually \
indistinguishable, so we will just call them both \"kilts.\" This school is \
considered our ",
 StyleBox["population",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " of outcomes. The term \"outcome\" will be defined below."
}], "Text"],

Cell[CellGroupData[{

Cell["Attributes", "Subsection"],

Cell[TextData[{
 "In this example, each student has two ",
 StyleBox["attributes",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 ", also called properties: ",
 StyleBox["gender",
  FontSlant->"Italic"],
 " and ",
 StyleBox["clothes",
  FontSlant->"Italic"],
 ". The set of all possible genders and the set of all possible clothes in \
our example is as follows:"
}], "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"genders", "=", 
   RowBox[{"{", 
    RowBox[{"\"\<Boy\>\"", ",", "\"\<Girl\>\""}], "}"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"clothes", "=", 
   RowBox[{"{", 
    RowBox[{"\"\<Kilts\>\"", ",", "\"\<Pants\>\""}], "}"}]}], ";"}]}], "Input"],

Cell[TextData[{
 "We represent the distribution information in a ",
 Cell[BoxData[
  FormBox[
   RowBox[{"2", "\[Times]", "2"}], TraditionalForm]]],
 " matrix / table / grid as follows:"
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"example", "=", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"3", ",", "27"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"13", ",", "7"}], "}"}]}], "}"}]}], ")"}], "//", 
  "MatrixForm"}]], "Input"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"3", "27"},
     {"13", "7"}
    },
    GridBoxAlignment->{
     "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
      "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
  Function[BoxForm`e$, 
   MatrixForm[BoxForm`e$]]]], "Output",
 CellChangeTimes->{3.603392433158102*^9}]
}, Open  ]],

Cell["\<\
We can use the attribute sets to label the example distribution matrix:\
\>", "Text"],

Cell[BoxData[
 RowBox[{
  RowBox[{"PrependColumn", "[", 
   RowBox[{"matrix_", ",", "column_"}], "]"}], ":=", 
  RowBox[{"MapThread", "[", 
   RowBox[{"Prepend", ",", 
    RowBox[{"{", 
     RowBox[{"matrix", ",", "column"}], "}"}]}], "]"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Grid", "[", 
  RowBox[{
   RowBox[{"Prepend", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"PrependColumn", "[", 
      RowBox[{"example", ",", "genders"}], "]"}], ",", "\[IndentingNewLine]", 
     
     RowBox[{"Prepend", "[", 
      RowBox[{"clothes", ",", "\"\<\>\""}], "]"}]}], "]"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"Frame", "\[Rule]", "All"}]}], "]"}]], "Input"],

Cell[BoxData[
 TagBox[GridBox[{
    {"\<\"\"\>", "\<\"Kilts\"\>", "\<\"Pants\"\>"},
    {"\<\"Boy\"\>", "3", "27"},
    {"\<\"Girl\"\>", "13", "7"}
   },
   AutoDelete->False,
   GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
   GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
  "Grid"]], "Output",
 CellChangeTimes->{3.603392437361273*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"TableForm", "[", 
  RowBox[{"example", ",", 
   RowBox[{"TableHeadings", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"genders", ",", "clothes"}], "}"}]}], ",", 
   RowBox[{"TableAlignments", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"Right", ",", "Bottom"}], "}"}]}]}], "]"}]], "Input"],

Cell[BoxData[
 TagBox[
  TagBox[GridBox[{
     {
      StyleBox["\[Null]",
       ShowStringCharacters->False], 
      TagBox["\<\"Kilts\"\>",
       HoldForm], 
      TagBox["\<\"Pants\"\>",
       HoldForm]},
     {
      TagBox["\<\"Boy\"\>",
       HoldForm], "3", "27"},
     {
      TagBox["\<\"Girl\"\>",
       HoldForm], "13", "7"}
    },
    GridBoxAlignment->{
     "Columns" -> {{Right}}, "ColumnsIndexed" -> {}, "Rows" -> {{Bottom}}, 
      "RowsIndexed" -> {}},
    GridBoxDividers->{
     "Columns" -> {False, True, {False}, False}, "ColumnsIndexed" -> {}, 
      "Rows" -> {False, True, {False}, False}, "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[2.0999999999999996`]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}],
   {OutputFormsDump`HeadedRows, OutputFormsDump`HeadedColumns}],
  Function[BoxForm`e$, 
   TableForm[
   BoxForm`e$, TableHeadings -> {{"Boy", "Girl"}, {"Kilts", "Pants"}}, 
    TableAlignments -> {Right, Bottom}]]]], "Output",
 CellChangeTimes->{3.6033924393969803`*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Sampling", "Subsection"],

Cell["\<\
Let's model the act of sampling this distribution: picking a student at \
random and recording the student's attributes.\
\>", "Text"],

Cell[CellGroupData[{

Cell["Outcomes", "Subsubsection"],

Cell[TextData[{
 "The set of ",
 StyleBox["outcomes",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " is a set of all possible attribute tuples for a student, namely"
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"(", 
  RowBox[{"outcomes", "=", 
   RowBox[{"Tuples", "[", 
    RowBox[{"{", 
     RowBox[{"genders", ",", "clothes"}], "}"}], "]"}]}], ")"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"\<\"Boy\"\>", ",", "\<\"Kilts\"\>"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"\<\"Boy\"\>", ",", "\<\"Pants\"\>"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"\<\"Girl\"\>", ",", "\<\"Kilts\"\>"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"\<\"Girl\"\>", ",", "\<\"Pants\"\>"}], "}"}]}], "}"}]], "Output",\

 CellChangeTimes->{3.603392443183366*^9}]
}, Open  ]],

Cell["\<\
We motivate the term \"outcome\" by reference to an imaginary experiment in \
which we draw a student at random from the population and record the \
student's attributes.\
\>", "Text"],

Cell["\<\
For the purpose of sampling, the order of attributes in the tuples is \
arbitrary. We must pick an order and stick with it, but whether we list \
gender first and then clothes in each outcome, or clothes first and then \
gender, is not important.\
\>", "Text"],

Cell["\<\
Furthermore, the sequential order in which we list the attribute pairs is not \
important. We must pick an order and stick with it, but any ordering will do. \
The order above amounts to a raster-wise traversal of the original table: \
iterating over the rows most slowly, then over the columns for each row.\
\>", "Text"],

Cell["\<\
Unpack the two-dimensional table above raster-wise into a list of counts that \
matches the order of tuples.\
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"counts", "=", 
  RowBox[{"Flatten", "[", 
   RowBox[{"example", ",", "1"}], "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"3", ",", "27", ",", "13", ",", "7"}], "}"}]], "Output",
 CellChangeTimes->{3.6033924691082783`*^9}]
}, Open  ]],

Cell["\<\
Write an object -- as a list of replacement rules -- that will produce the \
corresponding proportional population count given an outcome:\
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"exampleObject", "=", 
  RowBox[{"MapThread", "[", 
   RowBox[{"Rule", ",", 
    RowBox[{"{", 
     RowBox[{"outcomes", ",", "counts"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Boy\"\>", ",", "\<\"Kilts\"\>"}], "}"}], "\[Rule]", "3"}], 
   ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Boy\"\>", ",", "\<\"Pants\"\>"}], "}"}], "\[Rule]", "27"}], 
   ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Girl\"\>", ",", "\<\"Kilts\"\>"}], "}"}], "\[Rule]", "13"}],
    ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Girl\"\>", ",", "\<\"Pants\"\>"}], "}"}], "\[Rule]", 
    "7"}]}], "}"}]], "Output",
 CellChangeTimes->{3.6033924712273808`*^9}]
}, Open  ]],

Cell["In this form, the order does not matter.", "Text"],

Cell["\<\
We have a pretty visualizer for such lists of rules in the Jacquard.m \
library. The visualizer is called \"gridRules.\"\
\>", "Text"],

Cell[BoxData[
 RowBox[{"<<", "\"\<Jacquard.m\>\""}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"exampleObject", "//", "gridRules"}]], "Input"],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          TagBox[GridBox[{
             {
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"Boy\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold]},
             {
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"Kilts\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold]}
            },
            AutoDelete->False,
            FrameStyle->RGBColor[0, 
              Rational[2, 3], 0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {{
                 RGBColor[0.88, 1, 0.88]}}},
            GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          LineColor->GrayLevel[0],
          FrontFaceColor->GrayLevel[0],
          BackFaceColor->GrayLevel[0],
          GraphicsColor->GrayLevel[0],
          FontWeight->Bold,
          FontColor->GrayLevel[0]], 
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"3"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0, 0, 1],
          FrontFaceColor->RGBColor[0, 0, 1],
          BackFaceColor->RGBColor[0, 0, 1],
          GraphicsColor->RGBColor[0, 0, 1],
          FontWeight->Bold,
          FontColor->RGBColor[0, 0, 1]]},
        {
         StyleBox[
          TagBox[GridBox[{
             {
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"Boy\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold]},
             {
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"Pants\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold]}
            },
            AutoDelete->False,
            FrameStyle->RGBColor[0, 
              Rational[2, 3], 0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {{
                 RGBColor[0.88, 1, 0.88]}}},
            GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          LineColor->GrayLevel[0],
          FrontFaceColor->GrayLevel[0],
          BackFaceColor->GrayLevel[0],
          GraphicsColor->GrayLevel[0],
          FontWeight->Bold,
          FontColor->GrayLevel[0]], 
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"27"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0, 0, 1],
          FrontFaceColor->RGBColor[0, 0, 1],
          BackFaceColor->RGBColor[0, 0, 1],
          GraphicsColor->RGBColor[0, 0, 1],
          FontWeight->Bold,
          FontColor->RGBColor[0, 0, 1]]},
        {
         StyleBox[
          TagBox[GridBox[{
             {
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"Girl\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold]},
             {
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"Kilts\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold]}
            },
            AutoDelete->False,
            FrameStyle->RGBColor[0, 
              Rational[2, 3], 0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {{
                 RGBColor[0.88, 1, 0.88]}}},
            GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          LineColor->GrayLevel[0],
          FrontFaceColor->GrayLevel[0],
          BackFaceColor->GrayLevel[0],
          GraphicsColor->GrayLevel[0],
          FontWeight->Bold,
          FontColor->GrayLevel[0]], 
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"13"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0, 0, 1],
          FrontFaceColor->RGBColor[0, 0, 1],
          BackFaceColor->RGBColor[0, 0, 1],
          GraphicsColor->RGBColor[0, 0, 1],
          FontWeight->Bold,
          FontColor->RGBColor[0, 0, 1]]},
        {
         StyleBox[
          TagBox[GridBox[{
             {
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"Girl\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold]},
             {
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"Pants\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold]}
            },
            AutoDelete->False,
            FrameStyle->RGBColor[0, 
              Rational[2, 3], 0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {{
                 RGBColor[0.88, 1, 0.88]}}},
            GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          LineColor->GrayLevel[0],
          FrontFaceColor->GrayLevel[0],
          BackFaceColor->GrayLevel[0],
          GraphicsColor->GrayLevel[0],
          FontWeight->Bold,
          FontColor->GrayLevel[0]], 
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"7"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0, 0, 1],
          FrontFaceColor->RGBColor[0, 0, 1],
          BackFaceColor->RGBColor[0, 0, 1],
          GraphicsColor->RGBColor[0, 0, 1],
          FontWeight->Bold,
          FontColor->RGBColor[0, 0, 1]]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 0, 1],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {
           RGBColor[1, 0.9, 0.8], {
            RGBColor[1, 1, 0.85]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]}
   },
   AutoDelete->False,
   FrameStyle->RGBColor[0, 
     Rational[2, 3], 0],
   GridBoxAlignment->{"Columns" -> {{Left}}},
   GridBoxBackground->{"Columns" -> {{
        RGBColor[0.88, 1, 0.88]}}},
   GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
   GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
  "Grid"]], "Output",
 CellChangeTimes->{3.603392476209803*^9}]
}, Open  ]],

Cell["\<\
Here is a way to get the outcomes and counts back out of the object.\
\>", "Text",
 CellChangeTimes->{{3.603392488716756*^9, 3.603392490293488*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{"keys", ",", "values"}], "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"keys", "[", "obj_", "]"}], ":=", 
   RowBox[{
    RowBox[{"Pluck", "[", "1", "]"}], "/@", "obj"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"values", "[", "obj_", "]"}], ":=", 
   RowBox[{
    RowBox[{"Pluck", "[", "2", "]"}], "/@", "obj"}]}], ";"}]}], "Input"],

Cell["The sum of all counts is", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"s$", "=", 
  RowBox[{"Plus", "@@", 
   RowBox[{"values", "@", "exampleObject"}]}]}]], "Input"],

Cell[BoxData["50"], "Output",
 CellChangeTimes->{3.603392503241991*^9}]
}, Open  ]],

Cell["\<\
The length of the counts -- the number of distinguishable outcomes -- is\
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"n$", "=", 
  RowBox[{"Length", "@", "exampleObject"}]}]], "Input"],

Cell[BoxData["4"], "Output",
 CellChangeTimes->{3.603392509348713*^9}]
}, Open  ]],

Cell[TextData[{
 "We want a constant-time method for sampling the population, honoring the \
original distribution, that uses order-",
 Cell[BoxData[
  FormBox["N", TraditionalForm]]],
 " space, where ",
 Cell[BoxData[
  FormBox[
   RowBox[{"N", Cell[""]}], TraditionalForm]]],
 "is the number of possible outcomes."
}], "Text"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Preprocessing the Counts Object", "Subsubsection"],

Cell["Walker's Method of Aliases; see http://bit.ly/TxVMsG.", "Text"],

Cell["\<\
Think of the counts as colored balls and the slots in the counts array as \
bins. The color of each ball represents its original bin. There are three \
balls of color 1, twenty-seven balls of color 2, thirteen of color 3, and \
seven of color 4.\
\>", "Text"],

Cell[TextData[{
 "Redistribute the balls evenly in the bins, without changing their \
proportions, such that each bin will have the same number of balls (",
 StyleBox["newHeights)", "Input"],
 " and no more than two colors (",
 StyleBox["homeColor", "Input"],
 ", ",
 StyleBox["foreignColor", "Input"],
 "). It suffices to record the counts of the ",
 StyleBox["homeColor", "Input"],
 " since the counts of the ",
 StyleBox["foreignColor", "Input"],
 " are equal to ",
 StyleBox["newHeights", "Input"],
 " minus the counts of the ",
 StyleBox["homeColor", "Input"],
 ". To generate random samples, choose a bin uniformly at random, then choose \
a height value uniformly at random between 0 inclusive and ",
 StyleBox["newHeights", "Input"],
 " exclusive. If the randomly chosen height value is less than the recorded \
counts of the ",
 StyleBox["homeColor", "Input"],
 ", return the ",
 StyleBox["homeColor", "Input"],
 ", else return the ",
 StyleBox["foreignColor", "Input"],
 ". "
}], "Text"],

Cell["\<\
In our example, we cannot redistribute the balls evenly because the total \
number of balls, 50, is not divisible by 4, the number of bins. However, if \
we multiply all counts by the same number, that is, we scale up the counts, \
we can achieve even redistribution without changing the proportions.\
\>", "Text"],

Cell[TextData[{
 "Scale up so that the new total of balls is ",
 StyleBox["t$ = LCM[s$, n$]", "Input"],
 ", that is, so that each bin will have  "
}], "Text"],

Cell[TextData[{
 StyleBox["t$/n$ = LCM[s$,n$]/n$ = s$/GCD[s$,n$]", "Input"],
 ". "
}], "Text"],

Cell[TextData[{
 "balls after redistribution. We choose ",
 StyleBox["LCM[s$, n$]", "Input"],
 " for two reasons: the total ",
 StyleBox["t$", "Input"],
 " must be an integer multiple of ",
 StyleBox["s$", "Input"],
 " so that we can preserve the proportions exactly, and the total ",
 StyleBox["t$", "Input"],
 " must be an integer multiple of ",
 StyleBox["n$", "Input"],
 " so that each bin will have the same number of balls after the \
redistribution. "
}], "Text"],

Cell[TextData[{
 "The original total number of balls is ",
 StyleBox["s$", "Input"],
 ". The new total will be ",
 StyleBox["t$ = LCM[s$,n$]", "Input"],
 ". The ratio between the new total and the old total is ",
 StyleBox["LCM[s$,n$]/s$", "Input"],
 ". Thus, each bin must be scaled up by ",
 StyleBox["LCM[s$,n$]/s$", "Input"],
 ":"
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"multiplier", "=", 
  RowBox[{
   RowBox[{"LCM", "[", 
    RowBox[{"s$", ",", "n$"}], "]"}], "/", "s$"}]}]], "Input"],

Cell[BoxData["2"], "Output",
 CellChangeTimes->{3.603392628032723*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"counts", "*", "multiplier"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"6", ",", "54", ",", "26", ",", "14"}], "}"}]], "Output",
 CellChangeTimes->{3.60339262926726*^9}]
}, Open  ]],

Cell["Here are the new counts in an object:", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"MapThread", "[", 
  RowBox[{"Rule", ",", 
   RowBox[{"{", 
    RowBox[{"outcomes", ",", 
     RowBox[{"counts", "*", "multiplier"}]}], "}"}]}], "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Boy\"\>", ",", "\<\"Kilts\"\>"}], "}"}], "\[Rule]", "6"}], 
   ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Boy\"\>", ",", "\<\"Pants\"\>"}], "}"}], "\[Rule]", "54"}], 
   ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Girl\"\>", ",", "\<\"Kilts\"\>"}], "}"}], "\[Rule]", "26"}],
    ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Girl\"\>", ",", "\<\"Pants\"\>"}], "}"}], "\[Rule]", 
    "14"}]}], "}"}]], "Output",
 CellChangeTimes->{3.603392633838339*^9}]
}, Open  ]],

Cell["Fill up each bin until it has the following number of balls", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"LCM", "[", 
   RowBox[{"s$", ",", "n$"}], "]"}], "/", "n$"}]], "Input"],

Cell[BoxData["25"], "Output",
 CellChangeTimes->{3.603392638277225*^9}]
}, Open  ]],

Cell["\<\
Divide-and-conquer: fill up the shortest from the tallest, recording the \
original color and the new color, then remove the newly filled bin from the \
game\
\>", "Text"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "fillUpBins", "]"}], ";"}], "\[IndentingNewLine]", 

 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"fillUpBins", "[", "\[IndentingNewLine]", 
     RowBox[{"filledIndexedBins_", ",", "\[IndentingNewLine]", 
      RowBox[{"{", "justOneBin_", "}"}], ",", "\[IndentingNewLine]", 
      "targetCount_"}], "]"}], ":=", "\[IndentingNewLine]", 
    RowBox[{"Append", "[", "\[IndentingNewLine]", 
     RowBox[{"filledIndexedBins", ",", "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"Rule", "[", 
         RowBox[{"\"\<originalOutcome\>\"", ",", 
          RowBox[{
          "justOneBin", "\[LeftDoubleBracket]", "1", 
           "\[RightDoubleBracket]"}]}], "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Rule", "[", 
         RowBox[{"\"\<originalOutcomeCount\>\"", ",", 
          RowBox[{
          "justOneBin", "\[LeftDoubleBracket]", "2", 
           "\[RightDoubleBracket]"}]}], "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Rule", "[", 
         RowBox[{"\"\<foreignOutcome\>\"", ",", 
          RowBox[{
          "justOneBin", "\[LeftDoubleBracket]", "1", 
           "\[RightDoubleBracket]"}]}], "]"}]}], "}"}]}], "]"}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"fillUpBins", "[", "\[IndentingNewLine]", 
   RowBox[{
   "filledIndexedBins_", ",", "\[IndentingNewLine]", "unfilledIndexedBins_", 
    ",", 
    RowBox[{"(*", " ", 
     RowBox[{"form", " ", "of", " ", 
      RowBox[{"Rule", "[", 
       RowBox[{"outcome", ",", "count"}], "]"}]}], " ", "*)"}], 
    "\[IndentingNewLine]", "targetCount_"}], "]"}], ":=", 
  "\[IndentingNewLine]", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"sortedBins", "=", 
       RowBox[{"Sort", "[", 
        RowBox[{"unfilledIndexedBins", ",", 
         RowBox[{
          RowBox[{
           RowBox[{
           "#1", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}], "<", 
           
           RowBox[{
           "#2", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}]}], 
          "&"}]}], "]"}]}], ",", "\[IndentingNewLine]", "adjustedBins", ",", 
      "shortest", ",", "tallest", ",", "\[IndentingNewLine]", "amountToMove", 
      ",", "foreignIndex"}], "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"shortest", "=", 
      RowBox[{"First", "[", "sortedBins", "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"tallest", "=", 
      RowBox[{"Last", "[", "sortedBins", "]"}]}], ";", "\[IndentingNewLine]", 
     
     RowBox[{"amountToMove", "=", 
      RowBox[{"targetCount", "-", 
       RowBox[{
       "shortest", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}]}]}],
      ";", "\[IndentingNewLine]", 
     RowBox[{"foreignIndex", "=", 
      RowBox[{
      "tallest", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}]}], 
     ";", "\[IndentingNewLine]", 
     RowBox[{"adjustedBins", "=", 
      RowBox[{"Rest", "[", "sortedBins", "]"}]}], ";", "\[IndentingNewLine]", 
     
     RowBox[{"(*", " ", 
      RowBox[{
       RowBox[{
       "adjust", " ", "the", " ", "count", " ", "in", " ", "the", " ", 
        "tallest", " ", "bin"}], ",", " ", 
       RowBox[{
       "which", " ", "is", "\[IndentingNewLine]", "at", " ", "index", " ", 
        RowBox[{
        "Length", "\[LeftDoubleBracket]", "adjustedBins", 
         "\[RightDoubleBracket]"}]}]}], " ", "*)"}], "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"adjustedBins", "\[LeftDoubleBracket]", 
       RowBox[{
        RowBox[{"Length", "[", "adjustedBins", "]"}], ",", "2"}], 
       "\[RightDoubleBracket]"}], "-=", "amountToMove"}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"fillUpBins", "[", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"Append", "[", 
        RowBox[{"filledIndexedBins", ",", 
         RowBox[{"{", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"Rule", "[", 
            RowBox[{"\"\<originalOutcome\>\"", ",", 
             RowBox[{
             "shortest", "\[LeftDoubleBracket]", "1", 
              "\[RightDoubleBracket]"}]}], "]"}], ",", "\[IndentingNewLine]", 
           
           RowBox[{"Rule", "[", 
            RowBox[{"\"\<originalOutcomeCount\>\"", ",", 
             RowBox[{
             "shortest", "\[LeftDoubleBracket]", "2", 
              "\[RightDoubleBracket]"}]}], "]"}], ",", "\[IndentingNewLine]", 
           
           RowBox[{"Rule", "[", 
            RowBox[{"\"\<foreignOutcome\>\"", ",", 
             RowBox[{
             "tallest", "\[LeftDoubleBracket]", "1", 
              "\[RightDoubleBracket]"}]}], "]"}]}], "}"}]}], "]"}], ",", 
       "\[IndentingNewLine]", "adjustedBins", ",", "\[IndentingNewLine]", 
       "targetCount"}], "\[IndentingNewLine]", "]"}]}]}], "]"}]}]}], "Input",
 CellChangeTimes->{{3.603392662203039*^9, 3.6033926845168943`*^9}}],

Cell["\<\
Note the lemma in the construct below. In C#, we would Debug.Assert that \
section.\
\>", "Text"],

Cell[BoxData[
 RowBox[{
  RowBox[{"WalkersBins", "[", "exampleObject_", "]"}], ":=", 
  "\[IndentingNewLine]", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
     "t", ",", "s", ",", "n", ",", "fs", ",", "lemma", ",", 
      "\[IndentingNewLine]", "outcomes", ",", "counts", ",", 
      "newexampleObject"}], "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"s", "=", 
      RowBox[{"Plus", "@@", 
       RowBox[{"values", "@", "exampleObject"}]}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"n", "=", 
      RowBox[{"Length", "@", "exampleObject"}]}], ";", "\[IndentingNewLine]", 
     
     RowBox[{"t", "=", 
      RowBox[{"LCM", "[", 
       RowBox[{"s", ",", "n"}], "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"outcomes", "=", 
      RowBox[{"keys", "@", "exampleObject"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"counts", "=", 
      RowBox[{"values", "@", "exampleObject"}]}], ";", "\[IndentingNewLine]", 
     
     RowBox[{"newexampleObject", "=", 
      RowBox[{"MapThread", "[", 
       RowBox[{"Rule", ",", 
        RowBox[{"{", 
         RowBox[{"outcomes", ",", 
          RowBox[{"counts", "*", 
           RowBox[{"t", "/", "s"}]}]}], "}"}]}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"fs", "=", 
      RowBox[{"fillUpBins", "[", 
       RowBox[{
        RowBox[{"{", "}"}], ",", "newexampleObject", ",", 
        RowBox[{"t", "/", "n"}]}], "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"lemma", "=", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{
         RowBox[{"t", "/", "n"}], "\[Equal]", 
         "\"\<originalOutcomeCount\>\""}], "/.", "fs"}], ")"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"If", "[", 
      RowBox[{
       RowBox[{"Not", "[", "lemma", "]"}], ",", 
       RowBox[{"Throw", "[", "\"\<catastrophic failure\>\"", "]"}]}], "]"}], 
     ";", "\[IndentingNewLine]", "fs"}]}], "]"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"WalkersBins", "[", "exampleObject", "]"}], "//", 
  "gridRules"}]], "Input"],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              TagBox[GridBox[{
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Boy\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]},
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Kilts\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]}
                },
                AutoDelete->False,
                FrameStyle->RGBColor[0, 
                  Rational[2, 3], 0],
                GridBoxAlignment->{"Columns" -> {{Left}}},
                GridBoxBackground->{"Columns" -> {{
                    RGBColor[0.88, 1, 0.88]}}},
                GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
                
                GridBoxItemSize->{
                 "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
               "Grid"],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"6"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              TagBox[GridBox[{
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Boy\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]},
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Pants\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]}
                },
                AutoDelete->False,
                FrameStyle->RGBColor[0, 
                  Rational[2, 3], 0],
                GridBoxAlignment->{"Columns" -> {{Left}}},
                GridBoxBackground->{"Columns" -> {{
                    RGBColor[0.88, 1, 0.88]}}},
                GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
                
                GridBoxItemSize->{
                 "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
               "Grid"],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              TagBox[GridBox[{
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Girl\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]},
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Pants\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]}
                },
                AutoDelete->False,
                FrameStyle->RGBColor[0, 
                  Rational[2, 3], 0],
                GridBoxAlignment->{"Columns" -> {{Left}}},
                GridBoxBackground->{"Columns" -> {{
                    RGBColor[0.88, 1, 0.88]}}},
                GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
                GridBoxItemSize->{
                 "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
               "Grid"],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"14"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              TagBox[GridBox[{
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Boy\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]},
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Pants\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]}
                },
                AutoDelete->False,
                FrameStyle->RGBColor[0, 
                  Rational[2, 3], 0],
                GridBoxAlignment->{"Columns" -> {{Left}}},
                GridBoxBackground->{"Columns" -> {{
                    RGBColor[0.88, 1, 0.88]}}},
                GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
                
                GridBoxItemSize->{
                 "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
               "Grid"],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              TagBox[GridBox[{
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Boy\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]},
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Pants\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]}
                },
                AutoDelete->False,
                FrameStyle->RGBColor[0, 
                  Rational[2, 3], 0],
                GridBoxAlignment->{"Columns" -> {{Left}}},
                GridBoxBackground->{"Columns" -> {{
                    RGBColor[0.88, 1, 0.88]}}},
                GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
                
                GridBoxItemSize->{
                 "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
               "Grid"],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"24"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              TagBox[GridBox[{
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Girl\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]},
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Kilts\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]}
                },
                AutoDelete->False,
                FrameStyle->RGBColor[0, 
                  Rational[2, 3], 0],
                GridBoxAlignment->{"Columns" -> {{Left}}},
                GridBoxBackground->{"Columns" -> {{
                    RGBColor[0.88, 1, 0.88]}}},
                GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
                
                GridBoxItemSize->{
                 "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
               "Grid"],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              TagBox[GridBox[{
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Girl\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]},
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Kilts\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]}
                },
                AutoDelete->False,
                FrameStyle->RGBColor[0, 
                  Rational[2, 3], 0],
                GridBoxAlignment->{"Columns" -> {{Left}}},
                GridBoxBackground->{"Columns" -> {{
                    RGBColor[0.88, 1, 0.88]}}},
                GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
                
                GridBoxItemSize->{
                 "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
               "Grid"],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"25"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              TagBox[GridBox[{
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Girl\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]},
                 {
                  StyleBox[
                   TagBox[GridBox[{
                    {"\<\"Kilts\"\>"}
                    },
                    AutoDelete->False,
                    GridBoxAlignment->{"Columns" -> {{Left}}},
                    
                    GridBoxItemSize->{
                    "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                    "Grid"],
                   StripOnInput->False,
                   FontWeight->Bold]}
                },
                AutoDelete->False,
                FrameStyle->RGBColor[0, 
                  Rational[2, 3], 0],
                GridBoxAlignment->{"Columns" -> {{Left}}},
                GridBoxBackground->{"Columns" -> {{
                    RGBColor[0.88, 1, 0.88]}}},
                GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
                
                GridBoxItemSize->{
                 "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
               "Grid"],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]}
   },
   AutoDelete->False,
   FrameStyle->RGBColor[0, 
     Rational[2, 3], 0],
   GridBoxAlignment->{"Columns" -> {{Left}}},
   GridBoxBackground->{"Columns" -> {{
        RGBColor[0.88, 1, 0.88]}}},
   GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
   GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
  "Grid"]], "Output",
 CellChangeTimes->{3.603392722868184*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Testing the Preprocessing Procedure", "Subsubsection"],

Cell[BoxData[
 RowBox[{
  RowBox[{"generateRandomOutcomeSpace", "[", 
   RowBox[{"n_", "?", 
    RowBox[{"(", 
     RowBox[{
      RowBox[{"#", "<=", "26"}], "&"}], ")"}]}], "]"}], ":=", 
  "\[IndentingNewLine]", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"outcomes", "=", 
       RowBox[{"Characters", "@", 
        RowBox[{"FromCharacterCode", "[", 
         RowBox[{
          RowBox[{"Range", "[", 
           RowBox[{"1", ",", "n"}], "]"}], "+", "97"}], "]"}]}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"counts", "=", 
       RowBox[{"RandomInteger", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"0", ",", "99"}], "}"}], ",", "n"}], "]"}]}], ",", 
      "\[IndentingNewLine]", "countsObject"}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"countsObject", "=", 
     RowBox[{"MapThread", "[", 
      RowBox[{"Rule", ",", 
       RowBox[{"{", 
        RowBox[{"outcomes", ",", "counts"}], "}"}]}], "]"}]}]}], 
   "\[IndentingNewLine]", "]"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"testObject", "=", 
  RowBox[{"generateRandomOutcomeSpace", "[", "6", "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"\<\"b\"\>", "\[Rule]", "22"}], ",", 
   RowBox[{"\<\"c\"\>", "\[Rule]", "73"}], ",", 
   RowBox[{"\<\"d\"\>", "\[Rule]", "38"}], ",", 
   RowBox[{"\<\"e\"\>", "\[Rule]", "54"}], ",", 
   RowBox[{"\<\"f\"\>", "\[Rule]", "38"}], ",", 
   RowBox[{"\<\"g\"\>", "\[Rule]", "20"}]}], "}"}]], "Output",
 CellChangeTimes->{3.603392751488459*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"t$", "=", 
  RowBox[{"LCM", "[", 
   RowBox[{
    RowBox[{"s$", "=", 
     RowBox[{"Plus", "@@", 
      RowBox[{"values", "@", "testObject"}]}]}], ",", 
    RowBox[{"n$", "=", 
     RowBox[{"Length", "@", "testObject"}]}]}], "]"}]}]], "Input"],

Cell[BoxData["1470"], "Output",
 CellChangeTimes->{3.6033927589288807`*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"t$", "/", "n$"}]], "Input"],

Cell[BoxData["245"], "Output",
 CellChangeTimes->{3.603392760998294*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"WalkersBins", "[", "testObject", "]"}], "//", 
  "gridRules"}]], "Input"],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"g\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"120"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"c\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"b\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"132"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"e\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"e\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"211"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"c\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"d\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"228"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"c\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"f\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"228"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"c\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         TagBox[GridBox[{
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"c\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"originalOutcomeCount\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"245"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]},
            {
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"foreignOutcome\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->GrayLevel[0],
              FrontFaceColor->GrayLevel[0],
              BackFaceColor->GrayLevel[0],
              GraphicsColor->GrayLevel[0],
              FontWeight->Bold,
              FontColor->GrayLevel[0]], 
             StyleBox[
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"c\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold],
              StripOnInput->False,
              LineColor->RGBColor[0, 0, 1],
              FrontFaceColor->RGBColor[0, 0, 1],
              BackFaceColor->RGBColor[0, 0, 1],
              GraphicsColor->RGBColor[0, 0, 1],
              FontWeight->Bold,
              FontColor->RGBColor[0, 0, 1]]}
           },
           AutoDelete->False,
           FrameStyle->RGBColor[0, 0, 1],
           GridBoxAlignment->{"Columns" -> {{Left}}},
           GridBoxBackground->{"Columns" -> {
               RGBColor[1, 0.9, 0.8], {
                RGBColor[1, 1, 0.85]}}},
           GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
          "Grid"]}
       },
       AutoDelete->False,
       FrameStyle->RGBColor[0, 
         Rational[2, 3], 0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {{
            RGBColor[0.88, 1, 0.88]}}},
       GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
      "Grid"]}
   },
   AutoDelete->False,
   FrameStyle->RGBColor[0, 
     Rational[2, 3], 0],
   GridBoxAlignment->{"Columns" -> {{Left}}},
   GridBoxBackground->{"Columns" -> {{
        RGBColor[0.88, 1, 0.88]}}},
   GridBoxFrame->{"Columns" -> {{True}}, "Rows" -> {{True}}},
   GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
  "Grid"]], "Output",
 CellChangeTimes->{3.603392762157419*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Sampling the Preprocessed Counts", "Subsubsection"],

Cell["\<\
There is a lemma that the counts in the last bin of the preprocessed counts \
is equal to the height of each preprocessed bin. The reason is that\
\>", "Text"],

Cell[BoxData[
 RowBox[{
  RowBox[{"SampleWalkersBins", "[", 
   RowBox[{"walkersBins_", ",", 
    RowBox[{"nSamples_:", "1"}]}], "]"}], ":=", 
  RowBox[{"With", "[", 
   RowBox[{
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"newHeights", "=", 
       RowBox[{"\"\<originalOutcomeCount\>\"", "/.", 
        RowBox[{"Last", "[", "walkersBins", "]"}]}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"nBins", "=", 
       RowBox[{"Length", "@", "walkersBins"}]}]}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"Map", "[", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"rBin", "=", 
            RowBox[{"RandomInteger", "[", 
             RowBox[{"{", 
              RowBox[{"1", ",", "nBins"}], "}"}], "]"}]}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"rHeight", "=", 
            RowBox[{"RandomInteger", "[", 
             RowBox[{"{", 
              RowBox[{"1", ",", "newHeights"}], "}"}], "]"}]}]}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"With", "[", 
          RowBox[{
           RowBox[{"{", "\[IndentingNewLine]", 
            RowBox[{"bin", "=", 
             RowBox[{
             "walkersBins", "\[LeftDoubleBracket]", "rBin", 
              "\[RightDoubleBracket]"}]}], "}"}], ",", "\[IndentingNewLine]", 
           
           RowBox[{"If", "[", 
            RowBox[{
             RowBox[{
              RowBox[{
              "rHeight", "\[LessEqual]", "\"\<originalOutcomeCount\>\""}], "/.",
               "bin"}], ",", "\[IndentingNewLine]", 
             RowBox[{"\"\<originalOutcome\>\"", "/.", "bin"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"\"\<foreignOutcome\>\"", "/.", "bin"}]}], "]"}]}], 
          "]"}]}], "]"}], "&"}], ",", "\[IndentingNewLine]", 
      RowBox[{"Range", "[", "nSamples", "]"}]}], "\[IndentingNewLine]", 
     "]"}]}], "]"}]}]], "Input"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "SampleCountsObject", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"SampleCountsObject", "[", 
   RowBox[{"countsObject_", ",", 
    RowBox[{"nSamples_:", "1"}]}], "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"SampleWalkersBins", "[", 
   RowBox[{
    RowBox[{"WalkersBins", "@", "countsObject"}], ",", "nSamples"}], 
   "]"}]}]}], "Input"],

Cell["\<\
If we take a large sample, we expect proportions to be statistically like the \
input counts, with the statistics governed by the Chi-squared \
\[OpenCurlyDoubleQuote]goodness-of-fit\[CloseCurlyDoubleQuote] distribution.\
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"With", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"n", "=", 
     RowBox[{"Length", "@", "outcomes"}]}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Histogram", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
      RowBox[{"SampleCountsObject", "[", 
       RowBox[{"exampleObject", ",", "100000"}], "]"}], "\[IndentingNewLine]",
       "/.", 
      RowBox[{"MapThread", "[", 
       RowBox[{"Rule", ",", 
        RowBox[{"{", 
         RowBox[{"outcomes", ",", 
          RowBox[{"Range", "[", "n", "]"}]}], "}"}]}], "]"}]}], ",", 
     "\[IndentingNewLine]", "n"}], "\[IndentingNewLine]", "]"}]}], 
  "]"}]], "Input"],

Cell[BoxData[
 GraphicsBox[
  {RGBColor[0.798413061722744, 0.824719615472648, 0.968322270542458], 
   EdgeForm[Opacity[0.6719999999999999]], {}, 
   {RGBColor[0.798413061722744, 0.824719615472648, 0.968322270542458], 
    EdgeForm[Opacity[0.6719999999999999]], 
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
         RectangleBox[{1., 0}, {2., 6048}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{36.124999999999986`, 138.30357142857142`}, {
         92.2192734639934, 119.06658525799978`}}],
       StatusArea[#, 6048]& ,
       TagBoxNote->"6048"],
      StyleBox["6048", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[6048, {
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
         RectangleBox[{2., 0}, {3., 54040}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{137.05357142857142`, 
         239.23214285714283`}, {-110.90013586437203`, 119.06658525799978`}}],
       StatusArea[#, 54040]& ,
       TagBoxNote->"54040"],
      StyleBox["54040", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[54040, {
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
         RectangleBox[{3., 0}, {4., 25987}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{237.98214285714283`, 340.1607142857143}, {
         7.830252323005766, 119.06658525799978`}}],
       StatusArea[#, 25987]& ,
       TagBoxNote->"25987"],
      StyleBox["25987", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[25987, {
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
         RectangleBox[{4., 0}, {5., 13925}, "RoundingRadius" -> 0]},
        ImageSizeCache->{{338.9107142857143, 441.0892857142857}, {
         58.88097567937233, 119.06658525799978`}}],
       StatusArea[#, 13925]& ,
       TagBoxNote->"13925"],
      StyleBox["13925", {
        GrayLevel[0]}, StripOnInput -> False]],
     Annotation[#, 
      Style[13925, {
        GrayLevel[0]}], "Tooltip"]& ]}, {}, {}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{1., 0},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  PlotRange->{{1., 5.}, {All, All}},
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.02], 
     Scaled[0.1]}},
  Ticks->{Automatic, Automatic}]], "Output",
 CellChangeTimes->{3.60339279781738*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Tally", "[", 
  RowBox[{"SampleCountsObject", "[", 
   RowBox[{"exampleObject", ",", "100000"}], "]"}], "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\<\"Boy\"\>", ",", "\<\"Pants\"\>"}], "}"}], ",", "53919"}], 
    "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\<\"Girl\"\>", ",", "\<\"Pants\"\>"}], "}"}], ",", "14113"}], 
    "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\<\"Girl\"\>", ",", "\<\"Kilts\"\>"}], "}"}], ",", "25912"}], 
    "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\<\"Boy\"\>", ",", "\<\"Kilts\"\>"}], "}"}], ",", "6056"}], 
    "}"}]}], "}"}]], "Output",
 CellChangeTimes->{3.603392801580553*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["DEFINITIONS", "Section"],

Cell[CellGroupData[{

Cell["Functions", "Subsection"],

Cell[TextData[{
 StyleBox["DEFINITION",
  FontWeight->"Bold"],
 ": A ",
 StyleBox["finite function",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " is a single-valued mapping from a finite subset of some set -- the ",
 StyleBox["domain",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " -- to a subset -- the ",
 StyleBox["range",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " -- of some other set -- the ",
 StyleBox["co-domain",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 ". It is equivalent to a list of pairs "
}], "Text"],

Cell[TextData[{
 Cell[BoxData[
  FormBox[
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{
        SubscriptBox["x", "1"], " ", "\[Epsilon]", " ", "domain"}], ",", " ", 
       
       RowBox[{
        SubscriptBox["y", "1"], " ", "\[Epsilon]", " ", "codomain"}]}], "}"}],
      ",", " ", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{
        SubscriptBox["x", "2"], " ", "\[Epsilon]", " ", "domain"}], ",", " ", 
       
       RowBox[{
        SubscriptBox["y", "2"], " ", "\[Epsilon]", " ", "codomain"}]}], "}"}],
      ",", " ", "..."}], "}"}], TraditionalForm]]],
 " "
}], "Text"],

Cell[TextData[{
 "in which all values ",
 Cell[BoxData[
  FormBox[
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      RowBox[{
       SubscriptBox["x", "i"], "|", "i"}], "=", "1"}], ",", "2", ",", "..."}],
     "}"}], TraditionalForm]]],
 ", from the domain, are distinct. It's also equivalent to "
}], "Text"],

Cell[CellGroupData[{

Cell["a SQL table with the domain column as primary key", "ItemNumbered"],

Cell["a dictionary (single-valued hash tables)", "ItemNumbered"],

Cell["an object (where the domain is the set of member symbols)", \
"ItemNumbered"],

Cell["a list of replacement rules, and so on.", "ItemNumbered"]
}, Open  ]],

Cell[TextData[{
 StyleBox["DEFINITION",
  FontWeight->"Bold"],
 ": An ",
 StyleBox["injective finite function",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 ", or just an ",
 StyleBox["injection",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " (for the purposes of this paper), is a finite function in which every \
value in the codomain also appears just once. "
}], "Text"],

Cell[TextData[{
 "An injection is ",
 StyleBox["invertible",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 ": flipping every pair in the list produces another finite function, the ",
 StyleBox["inverse",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " of the original function. "
}], "Text"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Random Variables", "Subsection"],

Cell[TextData[{
 StyleBox["DEFINITION",
  FontWeight->"Bold"],
 ": A ",
 StyleBox["discrete random variable",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " is a function that returns values drawn at random (with unpredictable \
results) from a domain set ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]]],
 ".The act of calling the function is called a ",
 StyleBox["trial",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 "."
}], "Text"],

Cell["\<\
The extension of the distribution to continuous domains is straightforward \
but complicated. We skip it for now. \
\>", "Text"],

Cell[TextData[{
 StyleBox["DEFINITION",
  FontWeight->"Bold"],
 ": A ",
 StyleBox["sample",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " is an ",
 StyleBox["IEnumerable<A>", "Input",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " (in the dot-net sense): a sequence of trials of the random variable ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]]],
 ", which corresponds to the dot net type ",
 StyleBox["A", "Input"],
 ". A sample may also be represented by an ",
 StyleBox["IObservable<A>", "Input"],
 ", a collection indexed by time."
}], "Text"],

Cell["\<\
In our sample problem, the random variable is a function that returns a pair \
of a gender and a clothing choice. \
\>", "Text"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Distributions", "Subsection"],

Cell[TextData[{
 StyleBox["DEFINITION",
  FontWeight->"Bold"],
 ": A ",
 StyleBox["distribution",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " of a discrete random variable is a finite function from the domain of the \
random variable to numbers -- a function that assigns a number to each \
possible outcome. The numbers represent proportional counts or probabilities \
of values of the random variable in a theoretically infinite sample. "
}], "Text"],

Cell["Model this as a type.", "Text"],

Cell[TextData[{
 "The ",
 StyleBox["type of a set",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " is just the set itself. Model these as lists with a latent requirement \
that there are no duplicates in the list."
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData["outcomes"], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"\<\"Boy\"\>", ",", "\<\"Kilts\"\>"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"\<\"Boy\"\>", ",", "\<\"Pants\"\>"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"\<\"Girl\"\>", ",", "\<\"Kilts\"\>"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"\<\"Girl\"\>", ",", "\<\"Pants\"\>"}], "}"}]}], "}"}]], "Output",\

 CellChangeTimes->{3.603392818972829*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData["exampleObject"], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Boy\"\>", ",", "\<\"Kilts\"\>"}], "}"}], "\[Rule]", "3"}], 
   ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Boy\"\>", ",", "\<\"Pants\"\>"}], "}"}], "\[Rule]", "27"}], 
   ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Girl\"\>", ",", "\<\"Kilts\"\>"}], "}"}], "\[Rule]", "13"}],
    ",", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\<\"Girl\"\>", ",", "\<\"Pants\"\>"}], "}"}], "\[Rule]", 
    "7"}]}], "}"}]], "Output",
 CellChangeTimes->{3.6033928211246843`*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Type Predicates", "Subsection"],

Cell[CellGroupData[{

Cell["ObjectQ", "Subsubsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "ObjectQ", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"ObjectQ", "[", 
    RowBox[{"{", "}"}], "]"}], "=", "True"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"ObjectQ", "[", "thing_", "]"}], ":=", 
  RowBox[{
   RowBox[{"MatchQ", "[", 
    RowBox[{"thing", ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"a_", "\[Rule]", "b_"}], ",", "___"}], "}"}]}], "]"}], "&&", 
   RowBox[{"ObjectQ", "[", 
    RowBox[{"Rest", "[", "thing", "]"}], "]"}]}]}]}], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ObjectQ", "[", "exampleObject", "]"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.603392831201314*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ObjectQ", "[", "42", "]"}]], "Input"],

Cell[BoxData["False"], "Output",
 CellChangeTimes->{3.603392832652389*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ObjectQ", "[", "outcomes", "]"}]], "Input"],

Cell[BoxData["False"], "Output",
 CellChangeTimes->{3.603392833953917*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["SetQ", "Subsubsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "SetQ", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"SetQ", "[", "thing_", "]"}], ":=", 
  RowBox[{
   RowBox[{"ListQ", "[", "thing", "]"}], "&&", 
   RowBox[{"(", 
    RowBox[{
     RowBox[{"Union", "[", "thing", "]"}], "===", 
     RowBox[{"Sort", "[", "thing", "]"}]}], ")"}]}]}]}], "Input"]
}, Open  ]],

Cell[CellGroupData[{

Cell["FunctionQ", "Subsubsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "FunctionQ", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"FunctionQ", "[", "thing_", "]"}], ":=", 
  RowBox[{
   RowBox[{"(", 
    RowBox[{
     RowBox[{"ObjectQ", "[", "thing", "]"}], "&&", 
     RowBox[{"SetQ", "[", 
      RowBox[{"keys", "@", "thing"}], "]"}]}], ")"}], "||", 
   "\[IndentingNewLine]", 
   RowBox[{"(*", " ", 
    RowBox[{
    "handle", " ", "the", " ", "\"\<RuleDelayed\>\"", " ", "syntax", " ", 
     "for", " ", "Functions"}], " ", "*)"}], "\[IndentingNewLine]", 
   RowBox[{"(", 
    RowBox[{
     RowBox[{"ListQ", "[", 
      RowBox[{"DownValues", "@", "thing"}], "]"}], "&&", 
     RowBox[{"(", 
      RowBox[{
       RowBox[{
        RowBox[{"DownValues", "[", "thing", "]"}], "\[LeftDoubleBracket]", 
        RowBox[{"1", ",", "0"}], "\[RightDoubleBracket]"}], "===", 
       "RuleDelayed"}], ")"}], "&&", "\[IndentingNewLine]", 
     RowBox[{"(", 
      RowBox[{
       RowBox[{
        RowBox[{"DownValues", "[", "thing", "]"}], "\[LeftDoubleBracket]", 
        RowBox[{"1", ",", "1", ",", "0"}], "\[RightDoubleBracket]"}], "===", 
       "HoldPattern"}], ")"}]}], ")"}]}]}]}], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"FullForm", "@", 
  RowBox[{"DownValues", "@", "FunctionQ"}]}]], "Input"],

Cell[BoxData[
 TagBox[
  StyleBox[
   RowBox[{"List", "[", 
    RowBox[{"RuleDelayed", "[", 
     RowBox[{
      RowBox[{"HoldPattern", "[", 
       RowBox[{"FunctionQ", "[", 
        RowBox[{"Pattern", "[", 
         RowBox[{"thing", ",", 
          RowBox[{"Blank", "[", "]"}]}], "]"}], "]"}], "]"}], ",", 
      RowBox[{"Or", "[", 
       RowBox[{
        RowBox[{"And", "[", 
         RowBox[{
          RowBox[{"ObjectQ", "[", "thing", "]"}], ",", 
          RowBox[{"SetQ", "[", 
           RowBox[{"keys", "[", "thing", "]"}], "]"}]}], "]"}], ",", 
        RowBox[{"And", "[", 
         RowBox[{
          RowBox[{"ListQ", "[", 
           RowBox[{"DownValues", "[", "thing", "]"}], "]"}], ",", 
          RowBox[{"SameQ", "[", 
           RowBox[{
            RowBox[{"Part", "[", 
             RowBox[{
              RowBox[{"DownValues", "[", "thing", "]"}], ",", "1", ",", "0"}],
              "]"}], ",", "RuleDelayed"}], "]"}], ",", 
          RowBox[{"SameQ", "[", 
           RowBox[{
            RowBox[{"Part", "[", 
             RowBox[{
              RowBox[{"DownValues", "[", "thing", "]"}], ",", "1", ",", "1", 
              ",", "0"}], "]"}], ",", "HoldPattern"}], "]"}]}], "]"}]}], 
       "]"}]}], "]"}], "]"}],
   ShowSpecialCharacters->False,
   ShowStringCharacters->True,
   NumberMarks->True],
  FullForm]], "Output",
 CellChangeTimes->{3.603392840711369*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"FunctionQ", "@", "FunctionQ"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.603392847200663*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"FunctionQ", "@", "exampleObject"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.6033928568599663`*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["DistributionQ", "Subsubsection"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "DistributionQ", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"DistributionQ", "[", "thing_", "]"}], ":=", 
  RowBox[{
   RowBox[{"FunctionQ", "[", "thing", "]"}], "&&", 
   RowBox[{"And", "@@", 
    RowBox[{"NumberQ", "/@", 
     RowBox[{"(", 
      RowBox[{"values", "@", "thing"}], ")"}]}]}]}]}]}], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"DistributionQ", "@", "exampleObject"}]], "Input"],

Cell[BoxData["True"], "Output",
 CellChangeTimes->{3.603392859628923*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Dist", "[", "A", "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"Dist", "[", "A", "]"}]], "Output",
 CellChangeTimes->{3.603392861815217*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Normalized", "Subsubsection"],

Cell[TextData[{
 StyleBox["DEFINITION",
  FontWeight->"Bold"],
 ": A distribution is normalized if the numbers are scaled so that the sum of \
the outputs of the distribution function is one. In practice, we only have \
finite counts and dividing each count by the total number of counts produces \
a normalized distribution. "
}], "Text"]
}, Open  ]]
}, Open  ]],

Cell["Old Bayes", "Subsection"]
}, Open  ]],

Cell[CellGroupData[{

Cell["HORIZON", "Section"],

Cell["Don't look below this line", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Union", "[", 
  RowBox[{"{", 
   RowBox[{"1", ",", "2", ",", "3", ",", "2", ",", "1", ",", "3"}], "}"}], 
  "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"1", ",", "2", ",", "3"}], "}"}]], "Output"]
}, Open  ]]
}, Open  ]]
},
WindowSize->{1280, 1392},
WindowMargins->{{Automatic, 0}, {Automatic, 0}},
ShowSelection->True,
InputAliases->{
 "on" -> "\[CenterDot]", "tp" -> "\[CircleTimes]", "op" -> 
  OverscriptBox["\[Placeholder]", "^"], "her" -> SuperscriptBox[
    RowBox[{"(", "\[Placeholder]", ")"}], "\[Dagger]"], "con" -> 
  SuperscriptBox[
    RowBox[{"(", "\[Placeholder]", ")"}], "*"], "comm" -> TagBox[
    SubscriptBox[
     RowBox[{"\[LeftDoubleBracket]", 
       TagBox[
        RowBox[{"\[Placeholder]", ",", "\[Placeholder]"}], 
        Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True], 
       "\[RightDoubleBracket]"}], "-"], Quantum`Notation`zz050Commutator, 
    Editable -> False, Selectable -> False], "anti" -> TagBox[
    SubscriptBox[
     RowBox[{"\[LeftDoubleBracket]", 
       TagBox[
        RowBox[{"\[Placeholder]", ",", "\[Placeholder]"}], 
        Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True], 
       "\[RightDoubleBracket]"}], "+"], Quantum`Notation`zz050AntiCommutator, 
    Editable -> False, Selectable -> False], "ket" -> TagBox[
    RowBox[{"\[VerticalSeparator]", 
      TagBox[
      "\[Placeholder]", Quantum`Notation`zz080KetArgs, Editable -> True, 
       Selectable -> True, BaseStyle -> {ShowSyntaxStyles -> True}], 
      "\[RightAngleBracket]"}], Quantum`Notation`zz080Ket, Editable -> False, 
    Selectable -> False, BaseStyle -> {ShowSyntaxStyles -> False}], "ev" -> 
  SubscriptBox["\[Placeholder]", 
    OverscriptBox["\[Placeholder]", "^"]], "eval" -> 
  SubscriptBox["\[Placeholder]", 
    OverscriptBox["\[Placeholder]", "^"]], "eket" -> TagBox[
    RowBox[{"\[VerticalSeparator]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[RightAngleBracket]"}], 
    Quantum`Notation`zz080Ket, Editable -> False, Selectable -> False, 
    BaseStyle -> {ShowSyntaxStyles -> False}], "eeket" -> TagBox[
    RowBox[{"\[VerticalSeparator]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[RightAngleBracket]"}], 
    Quantum`Notation`zz080Ket, Editable -> False, Selectable -> False, 
    BaseStyle -> {ShowSyntaxStyles -> False}], "eeeket" -> TagBox[
    RowBox[{"\[VerticalSeparator]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[RightAngleBracket]"}], 
    Quantum`Notation`zz080Ket, Editable -> False, Selectable -> False, 
    BaseStyle -> {ShowSyntaxStyles -> False}], "braket" -> TagBox[
    RowBox[{"\[LeftAngleBracket]", 
      TagBox[
      "\[Placeholder]", Quantum`Notation`zz080BraArgs, Editable -> True, 
       Selectable -> True, BaseStyle -> {ShowSyntaxStyles -> True}], 
      "\[VerticalSeparator]", 
      TagBox[
      "\[Placeholder]", Quantum`Notation`zz080KetArgs, Editable -> True, 
       Selectable -> True, BaseStyle -> {ShowSyntaxStyles -> True}], 
      "\[RightAngleBracket]"}], Quantum`Notation`zz080BraKet, Editable -> 
    False, Selectable -> False, BaseStyle -> {ShowSyntaxStyles -> False}], 
  "ebraket" -> TagBox[
    RowBox[{"\[LeftAngleBracket]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080BraArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[VerticalSeparator]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[RightAngleBracket]"}], 
    Quantum`Notation`zz080BraKet, Editable -> False, Selectable -> False, 
    BaseStyle -> {ShowSyntaxStyles -> False}], "eebraket" -> TagBox[
    RowBox[{"\[LeftAngleBracket]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080BraArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[VerticalSeparator]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[RightAngleBracket]"}], 
    Quantum`Notation`zz080BraKet, Editable -> False, Selectable -> False, 
    BaseStyle -> {ShowSyntaxStyles -> False}], "eeebraket" -> TagBox[
    RowBox[{"\[LeftAngleBracket]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080BraArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[VerticalSeparator]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[RightAngleBracket]"}], 
    Quantum`Notation`zz080BraKet, Editable -> False, Selectable -> False, 
    BaseStyle -> {ShowSyntaxStyles -> False}], "bra" -> TagBox[
    RowBox[{"\[LeftAngleBracket]", 
      TagBox[
      "\[Placeholder]", Quantum`Notation`zz080BraArgs, Editable -> True, 
       Selectable -> True, BaseStyle -> {ShowSyntaxStyles -> True}], 
      "\[VerticalSeparator]"}], Quantum`Notation`zz080Bra, Editable -> False, 
    Selectable -> False, BaseStyle -> {ShowSyntaxStyles -> False}], "ebra" -> 
  TagBox[
    RowBox[{"\[LeftAngleBracket]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080BraArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[VerticalSeparator]"}], 
    Quantum`Notation`zz080Bra, Editable -> False, Selectable -> False, 
    BaseStyle -> {ShowSyntaxStyles -> False}], "eebra" -> TagBox[
    RowBox[{"\[LeftAngleBracket]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080BraArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[VerticalSeparator]"}], 
    Quantum`Notation`zz080Bra, Editable -> False, Selectable -> False, 
    BaseStyle -> {ShowSyntaxStyles -> False}], "eeebra" -> TagBox[
    RowBox[{"\[LeftAngleBracket]", 
      TagBox[
       RowBox[{
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], ",", 
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]]}], 
       Quantum`Notation`zz080BraArgs, Editable -> True, Selectable -> True, 
       BaseStyle -> {ShowSyntaxStyles -> True}], "\[VerticalSeparator]"}], 
    Quantum`Notation`zz080Bra, Editable -> False, Selectable -> False, 
    BaseStyle -> {ShowSyntaxStyles -> False}], "norm" -> 
  RowBox[{"\[LeftDoubleBracketingBar]", "\[Placeholder]", 
     "\[RightDoubleBracketingBar]"}], "trace" -> RowBox[{
     SubscriptBox["Tr", 
      OverscriptBox["\[Placeholder]", "^"]], "[", "\[Placeholder]", "]"}], 
  "ketbra" -> RowBox[{
     TagBox[
      RowBox[{"\[VerticalSeparator]", 
        TagBox[
        "\[Placeholder]", Quantum`Notation`zz080KetArgs, Editable -> True, 
         Selectable -> True, BaseStyle -> {ShowSyntaxStyles -> True}], 
        "\[RightAngleBracket]"}], Quantum`Notation`zz080Ket, Editable -> 
      False, Selectable -> False, BaseStyle -> {ShowSyntaxStyles -> False}], 
     "\[CenterDot]", 
     TagBox[
      RowBox[{"\[LeftAngleBracket]", 
        TagBox[
        "\[Placeholder]", Quantum`Notation`zz080BraArgs, Editable -> True, 
         Selectable -> True, BaseStyle -> {ShowSyntaxStyles -> True}], 
        "\[VerticalSeparator]"}], Quantum`Notation`zz080Bra, Editable -> 
      False, Selectable -> False, BaseStyle -> {ShowSyntaxStyles -> False}]}],
   "eketbra" -> RowBox[{
     TagBox[
      RowBox[{"\[VerticalSeparator]", 
        TagBox[
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], 
         Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True, 
         BaseStyle -> {ShowSyntaxStyles -> True}], "\[RightAngleBracket]"}], 
      Quantum`Notation`zz080Ket, Editable -> False, Selectable -> False, 
      BaseStyle -> {ShowSyntaxStyles -> False}], "\[CenterDot]", 
     TagBox[
      RowBox[{"\[LeftAngleBracket]", 
        TagBox[
         SubscriptBox["\[Placeholder]", 
          OverscriptBox["\[Placeholder]", "^"]], 
         Quantum`Notation`zz080BraArgs, Editable -> True, Selectable -> True, 
         BaseStyle -> {ShowSyntaxStyles -> True}], "\[VerticalSeparator]"}], 
      Quantum`Notation`zz080Bra, Editable -> False, Selectable -> False, 
      BaseStyle -> {ShowSyntaxStyles -> False}]}], "eeketbra" -> RowBox[{
     TagBox[
      RowBox[{"\[VerticalSeparator]", 
        TagBox[
         RowBox[{
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]], ",", 
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]]}], 
         Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True, 
         BaseStyle -> {ShowSyntaxStyles -> True}], "\[RightAngleBracket]"}], 
      Quantum`Notation`zz080Ket, Editable -> False, Selectable -> False, 
      BaseStyle -> {ShowSyntaxStyles -> False}], "\[CenterDot]", 
     TagBox[
      RowBox[{"\[LeftAngleBracket]", 
        TagBox[
         RowBox[{
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]], ",", 
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]]}], 
         Quantum`Notation`zz080BraArgs, Editable -> True, Selectable -> True, 
         BaseStyle -> {ShowSyntaxStyles -> True}], "\[VerticalSeparator]"}], 
      Quantum`Notation`zz080Bra, Editable -> False, Selectable -> False, 
      BaseStyle -> {ShowSyntaxStyles -> False}]}], "eeeketbra" -> RowBox[{
     TagBox[
      RowBox[{"\[VerticalSeparator]", 
        TagBox[
         RowBox[{
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]], ",", 
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]], ",", 
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]]}], 
         Quantum`Notation`zz080KetArgs, Editable -> True, Selectable -> True, 
         BaseStyle -> {ShowSyntaxStyles -> True}], "\[RightAngleBracket]"}], 
      Quantum`Notation`zz080Ket, Editable -> False, Selectable -> False, 
      BaseStyle -> {ShowSyntaxStyles -> False}], "\[CenterDot]", 
     TagBox[
      RowBox[{"\[LeftAngleBracket]", 
        TagBox[
         RowBox[{
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]], ",", 
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]], ",", 
           SubscriptBox["\[Placeholder]", 
            OverscriptBox["\[Placeholder]", "^"]]}], 
         Quantum`Notation`zz080BraArgs, Editable -> True, Selectable -> True, 
         BaseStyle -> {ShowSyntaxStyles -> True}], "\[VerticalSeparator]"}], 
      Quantum`Notation`zz080Bra, Editable -> False, Selectable -> False, 
      BaseStyle -> {ShowSyntaxStyles -> False}]}], "su" -> 
  SubscriptBox["\[Placeholder]", "\[Placeholder]"], "po" -> SuperscriptBox[
    RowBox[{"(", "\[Placeholder]", ")"}], "\[Placeholder]"], "pow" -> 
  SuperscriptBox[
    RowBox[{"(", "\[Placeholder]", ")"}], "\[Placeholder]"], "si" -> RowBox[{
     UnderoverscriptBox["\[Sum]", "\[Placeholder]", "\[Placeholder]"], 
     "\[Placeholder]"}], "qs" -> RowBox[{
     UnderoverscriptBox["\[Sum]", "\[Placeholder]", "\[Placeholder]"], 
     "\[Placeholder]"}], "qp" -> TagBox[
    RowBox[{
      UnderoverscriptBox["\[CircleTimes]", 
       TagBox[
       "\[Placeholder]", Quantum`Notation`zz020TPNotationini, Editable -> 
        True, Selectable -> True], 
       TagBox[
       "\[Placeholder]", Quantum`Notation`zz020TPNotationend, Editable -> 
        True, Selectable -> True]], 
      TagBox[
      "\[Placeholder]", Quantum`Notation`zz020TPNotationdat, Editable -> True,
        Selectable -> True]}], Quantum`Notation`zz020TPNotation, Editable -> 
    False, Selectable -> False]},
Magnification->1.25,
FrontEndVersion->"9.0 for Mac OS X x86 (32-bit, 64-bit Kernel) (January 25, \
2013)",
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
Cell[CellGroupData[{
Cell[1257, 32, 37, 0, 91, "Section"],
Cell[1297, 34, 480, 10, 82, "Text"],
Cell[CellGroupData[{
Cell[1802, 48, 32, 0, 44, "Subsection"],
Cell[1837, 50, 375, 13, 59, "Text"],
Cell[2215, 65, 295, 9, 70, "Input"],
Cell[2513, 76, 198, 6, 36, "Text"],
Cell[CellGroupData[{
Cell[2736, 86, 278, 10, 48, "Input"],
Cell[3017, 98, 629, 18, 85, "Output"]
}, Open  ]],
Cell[3661, 119, 95, 2, 36, "Text"],
Cell[3759, 123, 253, 7, 49, "Input"],
Cell[CellGroupData[{
Cell[4037, 134, 414, 11, 112, "Input"],
Cell[4454, 147, 377, 10, 103, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[4868, 162, 310, 8, 49, "Input"],
Cell[5181, 172, 1198, 35, 105, "Output"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[6428, 213, 30, 0, 44, "Subsection"],
Cell[6461, 215, 144, 3, 36, "Text"],
Cell[CellGroupData[{
Cell[6630, 222, 33, 0, 31, "Subsubsection"],
Cell[6666, 224, 179, 6, 36, "Text"],
Cell[CellGroupData[{
Cell[6870, 234, 176, 5, 49, "Input"],
Cell[7049, 241, 423, 12, 49, "Output"]
}, Open  ]],
Cell[7487, 256, 194, 4, 59, "Text"],
Cell[7684, 262, 270, 5, 59, "Text"],
Cell[7957, 269, 332, 5, 82, "Text"],
Cell[8292, 276, 132, 3, 36, "Text"],
Cell[CellGroupData[{
Cell[8449, 283, 118, 3, 48, "Input"],
Cell[8570, 288, 139, 3, 48, "Output"]
}, Open  ]],
Cell[8724, 294, 162, 3, 36, "Text"],
Cell[CellGroupData[{
Cell[8911, 301, 187, 5, 49, "Input"],
Cell[9101, 308, 570, 19, 49, "Output"]
}, Open  ]],
Cell[9686, 330, 56, 0, 36, "Text"],
Cell[9745, 332, 144, 3, 36, "Text"],
Cell[9892, 337, 62, 1, 48, "Input"],
Cell[CellGroupData[{
Cell[9979, 342, 70, 1, 49, "Input"],
Cell[10052, 345, 10153, 295, 275, "Output"]
}, Open  ]],
Cell[20220, 643, 158, 3, 36, "Text"],
Cell[20381, 648, 448, 14, 91, "Input"],
Cell[20832, 664, 40, 0, 36, "Text"],
Cell[CellGroupData[{
Cell[20897, 668, 118, 3, 49, "Input"],
Cell[21018, 673, 71, 1, 48, "Output"]
}, Open  ]],
Cell[21104, 677, 96, 2, 36, "Text"],
Cell[CellGroupData[{
Cell[21225, 683, 90, 2, 49, "Input"],
Cell[21318, 687, 70, 1, 48, "Output"]
}, Open  ]],
Cell[21403, 691, 328, 10, 61, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[21768, 706, 56, 0, 31, "Subsubsection"],
Cell[21827, 708, 69, 0, 36, "Text"],
Cell[21899, 710, 269, 5, 59, "Text"],
Cell[22171, 717, 997, 27, 127, "Text"],
Cell[23171, 746, 324, 5, 59, "Text"],
Cell[23498, 753, 158, 4, 36, "Text"],
Cell[23659, 759, 94, 3, 36, "Text"],
Cell[23756, 764, 470, 13, 59, "Text"],
Cell[24229, 779, 346, 10, 59, "Text"],
Cell[CellGroupData[{
Cell[24600, 793, 140, 4, 48, "Input"],
Cell[24743, 799, 70, 1, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[24850, 805, 63, 1, 48, "Input"],
Cell[24916, 808, 137, 3, 48, "Output"]
}, Open  ]],
Cell[25068, 814, 53, 0, 36, "Text"],
Cell[CellGroupData[{
Cell[25146, 818, 184, 5, 48, "Input"],
Cell[25333, 825, 569, 19, 49, "Output"]
}, Open  ]],
Cell[25917, 847, 75, 0, 36, "Text"],
Cell[CellGroupData[{
Cell[26017, 851, 106, 3, 48, "Input"],
Cell[26126, 856, 71, 1, 48, "Output"]
}, Open  ]],
Cell[26212, 860, 181, 4, 59, "Text"],
Cell[26396, 866, 4908, 118, 763, "Input"],
Cell[31307, 986, 107, 3, 36, "Text"],
Cell[31417, 991, 1924, 51, 301, "Input"],
Cell[CellGroupData[{
Cell[33366, 1046, 111, 3, 49, "Input"],
Cell[33480, 1051, 30908, 823, 671, "Output"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[64437, 1880, 60, 0, 31, "Subsubsection"],
Cell[64500, 1882, 1062, 31, 175, "Input"],
Cell[CellGroupData[{
Cell[65587, 1917, 111, 2, 49, "Input"],
Cell[65701, 1921, 389, 9, 49, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[66127, 1935, 267, 8, 49, "Input"],
Cell[66397, 1945, 75, 1, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[66509, 1951, 51, 1, 48, "Input"],
Cell[66563, 1954, 72, 1, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[66672, 1960, 108, 3, 49, "Input"],
Cell[66783, 1965, 33032, 906, 587, "Output"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[99864, 2877, 57, 0, 31, "Subsubsection"],
Cell[99924, 2879, 169, 3, 36, "Text"],
Cell[100096, 2884, 2026, 52, 322, "Input"],
Cell[102125, 2938, 410, 11, 91, "Input"],
Cell[102538, 2951, 244, 4, 59, "Text"],
Cell[CellGroupData[{
Cell[102807, 2959, 658, 18, 154, "Input"],
Cell[103468, 2979, 3341, 99, 309, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[106846, 3083, 144, 3, 49, "Input"],
Cell[106993, 3088, 668, 23, 49, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[107734, 3119, 30, 0, 91, "Section"],
Cell[CellGroupData[{
Cell[107789, 3123, 31, 0, 44, "Subsection"],
Cell[107823, 3125, 535, 20, 59, "Text"],
Cell[108361, 3147, 621, 22, 36, "Text"],
Cell[108985, 3171, 309, 11, 37, "Text"],
Cell[CellGroupData[{
Cell[109319, 3186, 73, 0, 36, "ItemNumbered"],
Cell[109395, 3188, 64, 0, 36, "ItemNumbered"],
Cell[109462, 3190, 83, 1, 36, "ItemNumbered"],
Cell[109548, 3193, 63, 0, 36, "ItemNumbered"]
}, Open  ]],
Cell[109626, 3196, 379, 13, 59, "Text"],
Cell[110008, 3211, 293, 10, 36, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[110338, 3226, 38, 0, 44, "Subsection"],
Cell[110379, 3228, 442, 16, 59, "Text"],
Cell[110824, 3246, 138, 3, 36, "Text"],
Cell[110965, 3251, 557, 19, 59, "Text"],
Cell[111525, 3272, 138, 3, 36, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[111700, 3280, 35, 0, 44, "Subsection"],
Cell[111738, 3282, 457, 11, 82, "Text"],
Cell[112198, 3295, 37, 0, 36, "Text"],
Cell[112238, 3297, 228, 7, 36, "Text"],
Cell[CellGroupData[{
Cell[112491, 3308, 34, 0, 48, "Input"],
Cell[112528, 3310, 423, 12, 49, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[112988, 3327, 39, 0, 49, "Input"],
Cell[113030, 3329, 570, 19, 49, "Output"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[113649, 3354, 37, 0, 44, "Subsection"],
Cell[CellGroupData[{
Cell[113711, 3358, 32, 0, 31, "Subsubsection"],
Cell[113746, 3360, 553, 16, 91, "Input"],
Cell[CellGroupData[{
Cell[114324, 3380, 72, 1, 49, "Input"],
Cell[114399, 3383, 73, 1, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[114509, 3389, 61, 1, 49, "Input"],
Cell[114573, 3392, 74, 1, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[114684, 3398, 67, 1, 49, "Input"],
Cell[114754, 3401, 74, 1, 48, "Output"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[114877, 3408, 29, 0, 31, "Subsubsection"],
Cell[114909, 3410, 360, 10, 70, "Input"]
}, Open  ]],
Cell[CellGroupData[{
Cell[115306, 3425, 34, 0, 31, "Subsubsection"],
Cell[115343, 3427, 1182, 31, 133, "Input"],
Cell[CellGroupData[{
Cell[116550, 3462, 96, 2, 48, "Input"],
Cell[116649, 3466, 1390, 39, 105, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[118076, 3510, 65, 1, 48, "Input"],
Cell[118144, 3513, 73, 1, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[118254, 3519, 69, 1, 49, "Input"],
Cell[118326, 3522, 75, 1, 48, "Output"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[118450, 3529, 38, 0, 31, "Subsubsection"],
Cell[118491, 3531, 378, 11, 70, "Input"],
Cell[CellGroupData[{
Cell[118894, 3546, 73, 1, 49, "Input"],
Cell[118970, 3549, 73, 1, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[119080, 3555, 57, 1, 48, "Input"],
Cell[119140, 3558, 100, 2, 48, "Output"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[119289, 3566, 35, 0, 31, "Subsubsection"],
Cell[119327, 3568, 339, 7, 59, "Text"]
}, Open  ]]
}, Open  ]],
Cell[119693, 3579, 31, 0, 44, "Subsection"]
}, Open  ]],
Cell[CellGroupData[{
Cell[119761, 3584, 26, 0, 91, "Section"],
Cell[119790, 3586, 42, 0, 36, "Text"],
Cell[CellGroupData[{
Cell[119857, 3590, 148, 4, 48, "Input"],
Cell[120008, 3596, 83, 2, 48, "Output"]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature yuDsX49m9kxt8D1qTv5zsUJa *)
