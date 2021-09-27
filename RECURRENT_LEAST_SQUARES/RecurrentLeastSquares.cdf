(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 11.3' *)

(***************************************************************************)
(*                                                                         *)
(*                                                                         *)
(*  Under the Wolfram FreeCDF terms of use, this file and its content are  *)
(*  bound by the Creative Commons BY-SA Attribution-ShareAlike license.    *)
(*                                                                         *)
(*        For additional information concerning CDF licensing, see:        *)
(*                                                                         *)
(*         www.wolfram.com/cdf/adopting-cdf/licensing-options.html         *)
(*                                                                         *)
(*                                                                         *)
(***************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1088,         20]
NotebookDataLength[    634041,      13685]
NotebookOptionsPosition[    601657,      13138]
NotebookOutlinePosition[    605206,      13230]
CellTagsIndexPosition[    604781,      13211]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["Efficient Bayesian Regularization \[LineSeparator]by Kalman Folding", \
"Title",
 CellChangeTimes->{{3.727038100871808*^9, 3.727038119380846*^9}, {
  3.727471593317396*^9, 3.7274715984595823`*^9}, {3.729120277549485*^9, 
  3.729120279330949*^9}, {3.729164818218039*^9, 3.729164831400428*^9}, {
  3.72917959045429*^9, 3.7291795965711203`*^9}, {3.7291976388841267`*^9, 
  3.729197641402032*^9}},
 CellTags->"c:1",ExpressionUUID->"6f3cba05-b339-4654-99a4-829a31dbb3b1"],

Cell["\<\
Brian Beckman
31 Mar 2018\
\>", "Text",
 CellChangeTimes->{{3.727471602355763*^9, 3.7274716101393967`*^9}, {
   3.727925773402236*^9, 3.727925775055613*^9}, {3.7291796049113493`*^9, 
   3.729179606176675*^9}, 3.729642307282371*^9, {3.72971195796128*^9, 
   3.729711959054461*^9}, {3.7297934248121*^9, 3.729793424979403*^9}, 
   3.731527806071295*^9},ExpressionUUID->"f8a900e9-2e08-4795-8dd9-\
f13eab31aca1"],

Cell[CellGroupData[{

Cell["Abstract", "Chapter",
 CellChangeTimes->{{3.729196441150124*^9, 3.7291964428392887`*^9}, {
  3.729793427963233*^9, 
  3.7297934299790154`*^9}},ExpressionUUID->"c691a64c-109c-488d-abc8-\
7f93f0bcc661"],

Cell["\<\
We show, by numerical examples, that Kalman folding (KAL) produces the same \
results as recurrent least squares (RLS) and maximum a-posteriori (MAP) for \
appropriate choices of a-priori covariances, i.e., regularization \
hyperparameters. KAL and RLS are more intuitive than MAP for practical \
applications, plus offer space-time efficiency over MAP by avoiding storage \
and multiplication of large matrices. Because RLS and KAL are overt \
recurrences, a-priori data are necessary to bootstrap them, so regularization \
is naturally built-in to the formulation: they are Bayesian by construction. \
Contrast MAP, wherein a-priori belief is introduced as a Bayesian \
modification of traditional, maximum-likelihood (MLE) least-squares through \
the normal equations. 

We exploit the novel fact that MAP estimates --- not covariances --- are \
invariant when MAP\[CloseCurlyQuote]s hyperparameters are both swapped and \
inverted. After that transformation, the MAP equations strongly resemble the \
equations of Kalman filtering. This resemblance may suggest a future, general \
proof of the invariance, perhaps by conversion of MAP from explicit to \
recurrent form.

We close with an extension of the recurrent method to Pade approximates, a \
restricted kind of non-linear model that can be converted easily to linear \
form. Such models are typically handled with full non-linear methods like \
Levenberg-Marquardt (LM). LM does not directly track covariances, so Kalman \
has an advantage because it does.\
\>", "Text",
 CellChangeTimes->{{3.7291964484304113`*^9, 3.729196613945616*^9}, 
   3.7292030970835457`*^9, {3.72968771341329*^9, 3.729687716858973*^9}, {
   3.729711791511696*^9, 3.72971179468015*^9}, {3.729793438706923*^9, 
   3.7297938892411823`*^9}, {3.729793935626384*^9, 3.729793942511643*^9}, {
   3.729793972831012*^9, 3.7297939745590477`*^9}, {3.729794610127033*^9, 
   3.729794682412895*^9}, {3.729794964535297*^9, 3.729795210547194*^9}, {
   3.729795571545514*^9, 3.7297956107276*^9}, {3.729796915642858*^9, 
   3.729796923833707*^9}, {3.731800495618454*^9, 
   3.73180068729769*^9}},ExpressionUUID->"5d23495e-5728-42d6-9934-\
6c2838298bd0"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Introduction", "Chapter",
 CellChangeTimes->{{3.727481450088695*^9, 3.7274814520560217`*^9}, {
  3.729180217802278*^9, 3.7291802195774593`*^9}, {3.729793433035008*^9, 
  3.729793435162754*^9}},
 CellTags->"c:2",ExpressionUUID->"ac34acab-a5c3-4ce8-a17e-2e0809ef5c38"],

Cell[TextData[{
 "Linear systems appear everywhere, and, where they don\[CloseCurlyQuote]t \
appear naturally, linear approximations abound because non-linear systems are \
often intractable. Examples comprise machine learning, control, dynamics, \
robotics, and many more. \n\n",
 StyleBox["Linear regression",
  FontSlant->"Italic"],
 " is the standard technique for estimating coefficients or ",
 StyleBox["parameters",
  FontSlant->"Italic"],
 " of a linear model from given data. Often, authors sweep linear regression \
under the rug, presumably because readers know all about it. However, time \
and again, I see the normal equations directly applied (fat, slow, \
over-fitting), \.7fmatrices inverted (expensive and risky), and neural \
networks applied (overkill).\n\nOver-fitting is another hazard. Linear \
models, as their ",
 StyleBox["order",
  FontSlant->"Italic"],
 " (number of parameters) nears or exceeds the number of data points, tend to \
follow data too well, limiting smoothness and predictive power outside the \
bounds of the data. Models that over-fit \[OpenCurlyDoubleQuote]wiggle\
\[CloseCurlyDoubleQuote] too much and ",
 StyleBox["generalize",
  FontSlant->"Italic"],
 " poorly.\n\n",
 StyleBox["Regularization",
  FontSlant->"Italic"],
 " is the usual mitigation for over-fitting. In Bayesian MAP, regularization \
is introduced through a-priori ",
 StyleBox["belief",
  FontSlant->"Italic"],
 " hyperparameters ",
 Cell[BoxData[
  FormBox["\[Alpha]", TraditionalForm]],ExpressionUUID->
  "2e094fd1-d320-48fa-8784-29b632121441"],
 " and ",
 Cell[BoxData[
  FormBox["\[Beta]", TraditionalForm]],ExpressionUUID->
  "06e7edf1-7609-40b5-bbb0-0ebee319dafe"],
 ", the reciprocal variance of an a-priori estimate ",
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "7d011c9f-d162-4e9d-983e-e7e7e180edf5"],
 " of the unknown parameters of the model, and the variance of the \
observations ",
 Cell[BoxData[
  FormBox["\[Zeta]", TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "9cd4dd5b-9dea-4cd2-b319-54b0385a5e7e"],
 ", respectively. \n\nWe show here, numerically, that MAP produces the same \
estimate ",
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "5ab0d86c-75be-4274-bad4-b678a30f5f50"],
 " when ",
 Cell[BoxData[
  FormBox["\[Alpha]", TraditionalForm]],ExpressionUUID->
  "3f9a0544-efa5-4cce-bb42-6d76b9af5b08"],
 " and ",
 Cell[BoxData[
  FormBox["\[Beta]", TraditionalForm]],ExpressionUUID->
  "b54789e4-b2ba-4e13-af91-61734cd5d755"],
 " are swapped and inverted. After that transformation, the MAP equations \
strongly resemble the equations of Kalman filtering, promoting intuition in \
applications. Applied directly, rather than as reciprocals, and in opposite \
positions from MAP, these variances are concrete and can be estimated or \
learned directly from experimental conditions. Covariances of the estimates \
and of the predicted observations must still be produced from nominal ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Alpha]", "=", 
    RowBox[{"1", "/", 
     SubsuperscriptBox["\[Sigma]", "\[Xi]", "2"]}]}], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "dab570f6-de63-472e-b707-f9e4a16cdf42"],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Beta]", "=", 
    RowBox[{"1", "/", 
     SubsuperscriptBox["\[Sigma]", "\[Zeta]", "2"]}]}], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "3ac96ef7-ec00-4ae5-99ee-4b52a0fe6bdf"],
 " as specified in the original formulation of MAP. \n\nRLS and KAL also \
offer scaling advantages over MAP (see ",
 ButtonBox["Beckman\[CloseCurlyQuote]s series on Kalman folding at \
https://goo.gl/iTxTzs",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://github.com/rebcabin/kalman-folding"], None},
  ButtonNote->"https://github.com/rebcabin/kalman-folding"],
 "). MAP is a  modification of the ",
 StyleBox["normal equations",
  FontSlant->"Italic"],
 " of maximum-likelihood (MLE) regression. The normal equations and the MAP \
equations encourage explicit computation over whole data sets. There is no \
obvious way to convert them into recurrences. RLS and KAL, however, overtly \
process data one observation at a time, avoiding storage and multiplication \
of large matrices. RLS and KAL have natural expressions as ",
 StyleBox["functional folds",
  FontSlant->"Italic"],
 ", fitting into contemporary programming languages. "
}], "Text",
 CellChangeTimes->{{3.7274814553838453`*^9, 3.727481471849703*^9}, {
   3.727481502548395*^9, 3.727481543290386*^9}, {3.7274815762427998`*^9, 
   3.727481597731824*^9}, {3.727481661069376*^9, 3.7274817001125383`*^9}, {
   3.727481803352981*^9, 3.727481863536408*^9}, {3.7274819760213203`*^9, 
   3.727481983533637*^9}, {3.72748203670294*^9, 3.727482052238491*^9}, {
   3.727482189409683*^9, 3.727482202321042*^9}, {3.727482237078443*^9, 
   3.7274824455142107`*^9}, {3.727482502224814*^9, 3.727482511663734*^9}, {
   3.727482542628716*^9, 3.727482573300147*^9}, {3.7274826061847153`*^9, 
   3.727482641957479*^9}, {3.727483068187994*^9, 3.72748306969718*^9}, {
   3.727483495698502*^9, 3.727483517296239*^9}, {3.727483586049469*^9, 
   3.7274836308700047`*^9}, {3.7274837441660624`*^9, 3.727483765339192*^9}, 
   3.7274838852467213`*^9, {3.7279259770520372`*^9, 3.727926056795493*^9}, {
   3.727927567316916*^9, 3.7279276585683327`*^9}, {3.727965622939703*^9, 
   3.727965628844901*^9}, {3.7279657010285673`*^9, 3.727965810694715*^9}, {
   3.728090783678996*^9, 3.728090785427752*^9}, {3.728090821738459*^9, 
   3.7280909405099163`*^9}, {3.72916210505669*^9, 3.7291621946893387`*^9}, {
   3.729162225195818*^9, 3.729162512932467*^9}, {3.729164726885667*^9, 
   3.729164884422428*^9}, {3.7291795375260077`*^9, 3.729179581270995*^9}, {
   3.729179619964759*^9, 3.729180297389501*^9}, {3.7291803726342297`*^9, 
   3.729180703771147*^9}, {3.7291812861388683`*^9, 3.729181349663971*^9}, {
   3.7296423196925898`*^9, 3.729642550146667*^9}, {3.729794000505768*^9, 
   3.729794021508069*^9}, {3.729794071613781*^9, 3.729794080908226*^9}, {
   3.729794125149901*^9, 3.7297942448527946`*^9}, {3.7297943254956703`*^9, 
   3.729794591812196*^9}, {3.7297947291482353`*^9, 3.729794806053865*^9}, {
   3.729794850239337*^9, 3.7297949381799383`*^9}, {3.729795222271432*^9, 
   3.729795252056612*^9}, {3.729795296933094*^9, 3.7297955335461597`*^9}, {
   3.729795625169161*^9, 3.72979570950813*^9}, {3.729795770236939*^9, 
   3.729795773761647*^9}, {3.729796088260374*^9, 3.729796150829298*^9}, {
   3.731800717621215*^9, 
   3.731800969569174*^9}},ExpressionUUID->"5d1cffa9-8f1d-42f1-8975-\
2ad10bf3fb46"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Motivating Review", "Chapter",
 CellChangeTimes->{{3.727448922904108*^9, 3.7274489260707684`*^9}, {
  3.7297961891455393`*^9, 3.729796190065695*^9}},
 CellTags->"c:3",ExpressionUUID->"60f0d5e4-c389-49f8-8a99-2be345d490c1"],

Cell[TextData[{
 "First, we exhibit ",
 StyleBox["maximum-likelihood estimation (MLE)",
  Background->None],
 " for a problem of order two: estimating the slope and intercept of a \
best-fit line to noisy data. This example puts an elementary problem into a \
setting that we generalize to higher order below. Furthermore, MLE ",
 StyleBox["operates over all the data at once",
  FontSlant->"Italic"],
 ", requiring matrices full of data to be stored, multiplied, and inverted. \
Not until we get to RLS and KAL do we see approaches much more efficient in \
memory and time.\n\nMLE is computed four ways: "
}], "Text",
 CellChangeTimes->{{3.728090971639092*^9, 3.728091137803318*^9}, {
   3.729162525262968*^9, 3.7291625523646097`*^9}, {3.729162594386468*^9, 
   3.729162644882078*^9}, {3.729180713797406*^9, 3.7291809759860487`*^9}, {
   3.729182777816757*^9, 3.729182779123023*^9}, {3.7291914192080936`*^9, 
   3.729191421173909*^9}, {3.729191463421255*^9, 3.729191512351722*^9}, {
   3.7295528209947367`*^9, 3.7295529738343067`*^9}, {3.729553031138538*^9, 
   3.7295530645530767`*^9}, {3.729553105041057*^9, 3.729553167790482*^9}, {
   3.7295532207179813`*^9, 3.7295532291625338`*^9}, {3.729642617580188*^9, 
   3.7296426611004972`*^9}, {3.72964271057891*^9, 3.72964271161131*^9}, 
   3.7297962068854017`*^9, {3.729796237410095*^9, 3.729796270643283*^9}, {
   3.729796301832774*^9, 
   3.7297963166712847`*^9}},ExpressionUUID->"257c66c7-5f70-4622-9ebc-\
7929e4f16274"],

Cell[CellGroupData[{

Cell["using Wolfram built-in functions", "ItemNumbered",
 CellChangeTimes->{{3.728090971639092*^9, 3.728091137803318*^9}, {
  3.729162525262968*^9, 3.7291625523646097`*^9}, {3.729162594386468*^9, 
  3.729162644882078*^9}, {3.729180713797406*^9, 3.7291809759860487`*^9}, {
  3.729182777816757*^9, 3.729182779123023*^9}, {3.7291914192080936`*^9, 
  3.729191421173909*^9}, {3.729191463421255*^9, 3.729191512351722*^9}, {
  3.7295528209947367`*^9, 3.7295529738343067`*^9}, {3.729553031138538*^9, 
  3.7295530645530767`*^9}, {3.729553105041057*^9, 3.729553167790482*^9}, {
  3.7295532207179813`*^9, 3.7295532291625338`*^9}, {3.729642617580188*^9, 
  3.729642669989204*^9}, {3.729642705230754*^9, 
  3.729642708875139*^9}},ExpressionUUID->"ebd2fb63-b879-4d99-993d-\
f021c07b07e9"],

Cell["directly through the classic normal equations", "ItemNumbered",
 CellChangeTimes->{{3.728090971639092*^9, 3.728091137803318*^9}, {
  3.729162525262968*^9, 3.7291625523646097`*^9}, {3.729162594386468*^9, 
  3.729162644882078*^9}, {3.729180713797406*^9, 3.7291809759860487`*^9}, {
  3.729182777816757*^9, 3.729182779123023*^9}, {3.7291914192080936`*^9, 
  3.729191421173909*^9}, {3.729191463421255*^9, 3.729191512351722*^9}, {
  3.7295528209947367`*^9, 3.7295529738343067`*^9}, {3.729553031138538*^9, 
  3.7295530645530767`*^9}, {3.729553105041057*^9, 3.729553167790482*^9}, {
  3.7295532207179813`*^9, 3.7295532291625338`*^9}, {3.729642617580188*^9, 
  3.729642703803406*^9}},ExpressionUUID->"25af2013-58eb-435d-91ee-\
e15f90db485e"],

Cell["using the Moore-Penrose left pseudoinverse", "ItemNumbered",
 CellChangeTimes->{{3.728090971639092*^9, 3.728091137803318*^9}, {
  3.729162525262968*^9, 3.7291625523646097`*^9}, {3.729162594386468*^9, 
  3.729162644882078*^9}, {3.729180713797406*^9, 3.7291809759860487`*^9}, {
  3.729182777816757*^9, 3.729182779123023*^9}, {3.7291914192080936`*^9, 
  3.729191421173909*^9}, {3.729191463421255*^9, 3.729191512351722*^9}, {
  3.7295528209947367`*^9, 3.7295529738343067`*^9}, {3.729553031138538*^9, 
  3.7295530645530767`*^9}, {3.729553105041057*^9, 3.729553167790482*^9}, {
  3.7295532207179813`*^9, 3.7295532291625338`*^9}, {3.729642617580188*^9, 
  3.7296427014033957`*^9}},ExpressionUUID->"cf917ebf-e7b0-4c48-aca2-\
a22973e85a6b"],

Cell["sidestepping the risky inverse by solving a linear system", \
"ItemNumbered",
 CellChangeTimes->{{3.728090971639092*^9, 3.728091137803318*^9}, {
  3.729162525262968*^9, 3.7291625523646097`*^9}, {3.729162594386468*^9, 
  3.729162644882078*^9}, {3.729180713797406*^9, 3.7291809759860487`*^9}, {
  3.729182777816757*^9, 3.729182779123023*^9}, {3.7291914192080936`*^9, 
  3.729191421173909*^9}, {3.729191463421255*^9, 3.729191512351722*^9}, {
  3.7295528209947367`*^9, 3.7295529738343067`*^9}, {3.729553031138538*^9, 
  3.7295530645530767`*^9}, {3.729553105041057*^9, 3.729553167790482*^9}, {
  3.7295532207179813`*^9, 3.7295532291625338`*^9}, {3.729642617580188*^9, 
  3.729642697209589*^9}, {3.7296427333059397`*^9, 3.729642738112775*^9}, {
  3.731801023095665*^9, 
  3.731801023340835*^9}},ExpressionUUID->"e0b493a0-0397-4fab-ae3f-\
432a214c55a4"]
}, Open  ]],

Cell["\<\
These methods of MLE yield exactly and numerically the same results for this \
small example. It is easy to make them diverge numerically for models with \
more parameters, that is, of larger order. \
\>", "Text",
 CellChangeTimes->{{3.728090971639092*^9, 3.728091137803318*^9}, {
  3.729162525262968*^9, 3.7291625523646097`*^9}, {3.729162594386468*^9, 
  3.729162644882078*^9}, {3.729180713797406*^9, 3.7291809759860487`*^9}, {
  3.729182777816757*^9, 3.729182779123023*^9}, {3.7291914192080936`*^9, 
  3.729191421173909*^9}, {3.729191463421255*^9, 3.729191512351722*^9}, {
  3.7295528209947367`*^9, 3.7295529738343067`*^9}, {3.729553031138538*^9, 
  3.7295530645530767`*^9}, {3.729553105041057*^9, 3.729553167790482*^9}, {
  3.7295532207179813`*^9, 3.7295532291625338`*^9}, {3.729642617580188*^9, 
  3.729642692379868*^9}, {3.729642750810244*^9, 3.729642753623979*^9}, {
  3.7297963357540913`*^9, 3.729796336620441*^9}, {3.731801048527586*^9, 
  3.731801051590125*^9}},ExpressionUUID->"e52f8176-4cc0-4ca1-aff7-\
64070f8c385c"],

Cell[CellGroupData[{

Cell["Problem Statement", "Subchapter",
 CellChangeTimes->{{3.729642799531767*^9, 
  3.729642803227457*^9}},ExpressionUUID->"58114e63-81c6-462c-bbd6-\
d03045d0a7a0"],

Cell[TextData[{
 "Find best-fit, unknown parameters ",
 Cell[BoxData[
  FormBox["m", TraditionalForm]],ExpressionUUID->
  "23d9cfff-f3b2-481a-b6b0-b0dd5f9b1280"],
 " (slope) and ",
 Cell[BoxData[
  FormBox["b", TraditionalForm]],ExpressionUUID->
  "26440a3d-fedb-4ee7-bb0c-8168bf0e1838"],
 " (intercept), where ",
 Cell[BoxData[
  FormBox[
   RowBox[{"z", "=", 
    RowBox[{
     RowBox[{"m", " ", "x"}], "+", "b"}]}], TraditionalForm]],ExpressionUUID->
  "327c6fd2-96f6-4323-8eb6-291777ee6a3a"],
 ", given known, noisy data ",
 Cell[BoxData[
  FormBox[
   RowBox[{"(", 
    RowBox[{
     SubscriptBox["z", "1"], ",", 
     SubscriptBox["z", "2"], ",", "\[Ellipsis]", ",", 
     SubscriptBox["z", "k"]}], ")"}], TraditionalForm]],ExpressionUUID->
  "75075c60-5e3c-42da-b661-296a1ae1ee60"],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{"(", 
    RowBox[{
     SubscriptBox["x", "1"], ",", 
     SubscriptBox["x", "2"], ",", "\[Ellipsis]", ",", 
     SubscriptBox["x", "k"]}], ")"}], TraditionalForm]],ExpressionUUID->
  "46e64d18-1f5c-4926-95b8-33f6a7ecf798"],
 ". \n\nWrite this ",
 StyleBox["system",
  FontSlant->"Italic"],
 " as a matrix equation and remember the symbols ",
 Cell[BoxData[
  FormBox["\[CapitalZeta]", TraditionalForm]],ExpressionUUID->
  "6506ca43-d29d-41ac-a6e2-79dfb4a63621"],
 " (",
 StyleBox["observations",
  FontSlant->"Italic",
  Background->RGBColor[1, 1, 0]],
 ", known, concrete, numerical), ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "fefe6189-4c2b-40bc-a442-4a207b3a6e94"],
 " (",
 StyleBox["partials",
  FontSlant->"Italic",
  Background->RGBColor[1, 1, 0]],
 ", known, concrete, numerical), and ",
 Cell[BoxData[
  FormBox["\[CapitalXi]", TraditionalForm]],ExpressionUUID->
  "5765724f-9455-410c-b18a-1b8e1a10f25e"],
 " (",
 StyleBox["model",
  FontSlant->"Italic",
  Background->RGBColor[1, 1, 0]],
 StyleBox[", state; ",
  FontSlant->"Italic"],
 "unknown",
 StyleBox[" abstract, symbolic \.7fparameters",
  FontSlant->"Italic"],
 " to be estimated). \n\nRows of ",
 Cell[BoxData[
  FormBox["\[CapitalZeta]", TraditionalForm]],ExpressionUUID->
  "e1f5a451-c282-4e3b-b834-f2563cf67bfe"],
 " and ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "84ee545a-a45b-43c3-ad12-365049e2f5e2"],
 " come in matched pairs."
}], "Text",
 CellChangeTimes->{{3.727038390871489*^9, 3.727038456274043*^9}, {
  3.7274311898792877`*^9, 3.727431210306458*^9}, {3.72743162057631*^9, 
  3.727431625628214*^9}, {3.727431899653804*^9, 3.727431979499525*^9}, {
  3.727432013573489*^9, 3.7274321573609333`*^9}, {3.727432239814447*^9, 
  3.7274322449709*^9}, {3.7274337661533823`*^9, 3.727433787800761*^9}, {
  3.727440517352091*^9, 3.727440560289133*^9}, {3.727471626984016*^9, 
  3.727471663001911*^9}, {3.7274858550759478`*^9, 3.727485860274253*^9}, {
  3.728091149168085*^9, 3.728091201530199*^9}, {3.729162651880166*^9, 
  3.7291627523168507`*^9}, {3.729162841547649*^9, 3.729162848090231*^9}, {
  3.729642807195567*^9, 3.72964282455161*^9}, {3.7297963463658*^9, 
  3.729796348669681*^9}, {3.7318011764284687`*^9, 
  3.731801265252699*^9}},ExpressionUUID->"4c44fa41-5e68-4119-bb8a-\
3a430d2406f7"],

Cell[BoxData[{
 FormBox[
  RowBox[{
   RowBox[{
    SubscriptBox["\[CapitalZeta]", 
     RowBox[{"\[ThinSpace]", 
      RowBox[{"\[CapitalNu]", "\[Times]", "1"}]}]], "  ", "=", "  ", 
    RowBox[{
     RowBox[{"(", GridBox[{
        {
         SubscriptBox["z", "1"]},
        {
         SubscriptBox["z", "2"]},
        {"\[VerticalEllipsis]"},
        {
         SubscriptBox["z", "\[CapitalNu]"]}
       }], ")"}], "   ", "=", "   ", 
     RowBox[{
      RowBox[{
       RowBox[{"(", GridBox[{
          {
           SubscriptBox["x", "1"], "1"},
          {
           SubscriptBox["x", "2"], "1"},
          {"\[VerticalEllipsis]", "\[VerticalEllipsis]"},
          {
           SubscriptBox["x", "\[CapitalNu]"], "1"}
         }], ")"}], "  ", "\[CenterDot]", "  ", 
       RowBox[{"(", GridBox[{
          {
           SubscriptBox["m", "unknown"]},
          {
           SubscriptBox["b", "unknown"]}
         }], ")"}]}], "   ", "+", "  ", "noise"}]}]}], "   "}], 
  TraditionalForm], "\[LineSeparator]", 
 FormBox[
  RowBox[{"=", "  ", 
   RowBox[{
    RowBox[{
     SubscriptBox["A", 
      RowBox[{"\[ThinSpace]", 
       RowBox[{"\[CapitalNu]", "\[Times]", "2"}]}]], "\[CenterDot]", 
     SubscriptBox["\[CapitalXi]", 
      RowBox[{"\[ThinSpace]", 
       RowBox[{"2", "\[Times]", "1"}]}]]}], "  ", "+", "  ", 
    RowBox[{"samples", " ", "of", " ", 
     RowBox[{"NormalDistribution", "[", 
      RowBox[{"0", ",", 
       SubscriptBox["\[Sigma]", "\[CapitalZeta]"]}], "]"}]}]}]}], 
  TraditionalForm]}], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.727431219978753*^9, 3.7274313049913387`*^9}, {
  3.72743141969454*^9, 3.7274316161107063`*^9}, {3.727431991078349*^9, 
  3.727431991079677*^9}, {3.727433277603713*^9, 3.727433294425931*^9}, {
  3.727440753860702*^9, 3.7274407556831503`*^9}, {3.7274408733251953`*^9, 
  3.727440951766347*^9}, {3.727441005231421*^9, 3.727441018782874*^9}, {
  3.727471698016046*^9, 3.727471719286708*^9}, {3.7289478978830757`*^9, 
  3.728947929231979*^9}, {3.728948042008193*^9, 3.7289480682892017`*^9}, {
  3.72979637262674*^9, 
  3.72979641776385*^9}},ExpressionUUID->"dc4eebef-5104-4cd0-aefc-\
2b89d29cc5b5"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Ground Truth", "Subchapter",
 CellChangeTimes->{{3.727038130736038*^9, 3.727038133799975*^9}, {
   3.727038190200441*^9, 3.727038194262557*^9}, {3.7270382668439693`*^9, 
   3.727038273195747*^9}, 3.727449676637067*^9},
 CellTags->"c:4",ExpressionUUID->"44a54455-7a93-4f41-8b0d-0963fc34ef68"],

Cell[TextData[{
 "Fake some data by (1) sampling a line specified by ",
 StyleBox["ground truth",
  FontSlant->"Italic",
  Background->RGBColor[1, 1, 0]],
 " ",
 Cell[BoxData[
  FormBox["m", TraditionalForm]],ExpressionUUID->
  "a6958922-45d9-44d5-a140-5d74dfa03120"],
 " and ",
 Cell[BoxData[
  FormBox["b", TraditionalForm]],ExpressionUUID->
  "39031738-b4df-4535-8d32-6ba1d755ca94"],
 ", then (2) adding Gaussian noise. Run the faked data through the four \
estimation procedures and see how close the estimated ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["m", "estimated"], TraditionalForm]],ExpressionUUID->
  "7d3a917e-e714-40a5-94eb-7b389b102b52"],
 " and ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["b", "estimated"], TraditionalForm]],ExpressionUUID->
  "130f7ec9-23b1-4ada-a060-010d925dcafa"],
 " come to ground truth. \n\nIn real-world applications, we rarely have \
ground truth. Its purpose here is to baseline or calibrate the various \
methods."
}], "Text",
 CellChangeTimes->{{3.7274717486938457`*^9, 3.727471863121015*^9}, {
   3.727471943951993*^9, 3.727471974860942*^9}, 3.7274752992891693`*^9, {
   3.727485889951729*^9, 3.727485910971366*^9}, {3.727485957242045*^9, 
   3.727485990073215*^9}, {3.727877625333728*^9, 3.727877661014937*^9}, {
   3.727877785098357*^9, 3.727877790057716*^9}, {3.728091354555441*^9, 
   3.728091378646338*^9}, {3.729162811973446*^9, 3.729162819633565*^9}, {
   3.7291628558399363`*^9, 3.729162932572029*^9}, {3.729181028160221*^9, 
   3.72918106154837*^9}, {3.7296428409291563`*^9, 3.729642850910636*^9}, {
   3.729796453908016*^9, 3.7297964759964657`*^9}, {3.731801106400538*^9, 
   3.731801123495727*^9}},ExpressionUUID->"a05b652d-dbed-4dbe-b08e-\
e00ac5fb316c"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{"groundTruth", ",", "m", ",", "b"}], "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"groundTruth", "=", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"m", ",", "b"}], "}"}], "=", 
    RowBox[{"{", 
     RowBox[{"0.5", ",", 
      RowBox[{
       RowBox[{"-", "1."}], "/", "3."}]}], "}"}]}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.727038221106352*^9, 3.72703825991599*^9}, {
  3.727450214764965*^9, 3.727450221204816*^9}},
 CellLabel->"In[1]:=",ExpressionUUID->"f62c0cce-ff47-4c98-9aad-0a450d6c5fa6"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Partials", "Subchapter",
 CellChangeTimes->{{3.727038381072097*^9, 3.7270383858220654`*^9}, 
   3.727472022244463*^9},
 CellTags->"c:5",ExpressionUUID->"433846fc-b9f7-4657-832d-cdc66c8f4802"],

Cell[TextData[{
 "The partials ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "9309b19a-9472-465f-84be-8ecd35011dde"],
 " are a (order-",
 Cell[BoxData[
  FormBox["\[CapitalNu]", TraditionalForm]],ExpressionUUID->
  "ae8db516-cb35-42df-90bb-15aa620bf7ce"],
 ", column) vector of covectors (order-",
 Cell[BoxData[
  FormBox["\[CapitalMu]", TraditionalForm]],ExpressionUUID->
  "a2ba7cf0-657a-4b1e-8900-015915a1c1d9"],
 ", row vectors). Each covector is the gradient 1-form of ",
 Cell[BoxData[
  FormBox[
   RowBox[{"A", "\[CenterDot]", "\[CapitalXi]"}], TraditionalForm]],
  ExpressionUUID->"24f492e1-8cbc-4b9e-85e3-f2475b30584a"],
 " with respect to ",
 Cell[BoxData[
  FormBox["\[CapitalXi]", TraditionalForm]],ExpressionUUID->
  "32a3d80d-1e15-455e-a684-128e0a220123"],
 ", evaluated at specific values of ",
 Cell[BoxData[
  FormBox["\[CapitalXi]", TraditionalForm]],ExpressionUUID->
  "482810e6-322f-4783-a84c-dc625d8b0917"],
 " from the data. Gradients are best viewed as 1-forms, always",
 StyleBox[" covectors:",
  FontWeight->"Plain"],
 " linear transformations of vectors. "
}], "Text",
 CellChangeTimes->{{3.727474059032774*^9, 3.727474241042626*^9}, {
  3.727475321236279*^9, 3.727475337122877*^9}, {3.727877875957012*^9, 
  3.727877901401568*^9}, {3.728091432235373*^9, 3.728091454599753*^9}, {
  3.7291191792753353`*^9, 3.7291191793375893`*^9}, {3.729162951360962*^9, 
  3.729163067652018*^9}, {3.7291810738050528`*^9, 3.729181098851663*^9}, {
  3.7297964988703747`*^9, 3.729796563292739*^9}, {3.73180115038993*^9, 
  3.731801158654298*^9}},ExpressionUUID->"35ffa721-f0f8-44d8-87ab-\
ab6692b08760"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{"nData", ",", "min", ",", "max"}], "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  StyleBox[
   RowBox[{"nData", "=", "119"}],
   Background->RGBColor[1, 1, 0]], ";", 
  RowBox[{"min", "=", 
   RowBox[{"-", "1."}]}], ";", 
  RowBox[{"max", "=", "3."}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"ClearAll", "[", "partials", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   StyleBox["partials",
    Background->RGBColor[1, 1, 0]], "=", 
   RowBox[{"Array", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{"#", ",", "1.0"}], "}"}], "&"}], ",", "nData", ",", 
     RowBox[{"{", 
      RowBox[{"min", ",", "max"}], "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"Short", "[", 
  RowBox[{"partials", ",", "3"}], "]"}]}], "Input",
 CellChangeTimes->{{3.727038484294626*^9, 3.727038506353806*^9}, {
   3.727038672360093*^9, 3.7270386925152807`*^9}, {3.7270387298032637`*^9, 
   3.727038738723681*^9}, {3.727432689921877*^9, 3.7274327110981913`*^9}, {
   3.727445567876906*^9, 3.727445568010209*^9}, {3.7274468698582373`*^9, 
   3.727446869999188*^9}, 3.727446939266643*^9, {3.7274470220360327`*^9, 
   3.7274470231123457`*^9}, {3.727447792622075*^9, 3.7274477929568863`*^9}, {
   3.727449108405336*^9, 3.727449126986397*^9}, {3.727449270042646*^9, 
   3.727449276077201*^9}, {3.727449337024444*^9, 3.727449352022664*^9}, {
   3.7274494075242367`*^9, 3.727449431344298*^9}, {3.72744956654039*^9, 
   3.727449572786269*^9}, {3.7274496209308167`*^9, 3.727449635986744*^9}, 
   3.727449690711412*^9, {3.727449766317731*^9, 3.727449816846671*^9}, {
   3.727451747352453*^9, 3.727451747877816*^9}, 3.7274561390872173`*^9, {
   3.727462576366873*^9, 3.727462593386175*^9}, {3.727472063650128*^9, 
   3.727472063729579*^9}},
 CellLabel->"In[3]:=",ExpressionUUID->"9af9d278-a60f-46e9-b91e-f8985ee51e42"],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"-", "1.`"}], ",", "1.`"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"-", "0.9661016949152542`"}], ",", "1.`"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"-", "0.9322033898305084`"}], ",", "1.`"}], "}"}], ",", 
    RowBox[{"\[LeftSkeleton]", "113", "\[RightSkeleton]"}], ",", 
    RowBox[{"{", 
     RowBox[{"2.9322033898305087`", ",", "1.`"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"2.9661016949152543`", ",", "1.`"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"3.`", ",", "1.`"}], "}"}]}], "}"}],
  Short[#, 3]& ]], "Output",
 CellChangeTimes->{{3.727038583630406*^9, 3.727038608390233*^9}, 
   3.727038709777071*^9, 3.727038740778534*^9, 3.727055663056172*^9, 
   3.727057129327168*^9, 3.727059177376666*^9, 3.7270594202840557`*^9, 
   3.727059460469883*^9, 3.727059722172241*^9, 3.7273704074561377`*^9, 
   3.727379374177999*^9, 3.7273796189946833`*^9, 3.727382952016055*^9, 
   3.7274396353755617`*^9, 3.72744299207996*^9, 3.727443422013879*^9, 
   3.7274434527589293`*^9, 3.727444587495447*^9, 3.727444680192195*^9, 
   3.7274455717862053`*^9, 3.72744624615656*^9, 3.72744640590419*^9, 
   3.727446838013892*^9, 3.727446872924258*^9, {3.727446907842485*^9, 
   3.727447069879878*^9}, 3.727447290299449*^9, 3.727447347017867*^9, 
   3.7274478385022182`*^9, 3.727449204471116*^9, 3.7274492775476*^9, 
   3.7274496365181932`*^9, 3.727449693340242*^9, {3.727449807165443*^9, 
   3.727449817081092*^9}, 3.727449903758767*^9, 3.727450179720099*^9, 
   3.7274506510519867`*^9, 3.7274509739039373`*^9, 3.7274517486268787`*^9, 
   3.727451981813099*^9, 3.7274548446844063`*^9, 3.727455078961658*^9, 
   3.727455974394829*^9, {3.727456142033311*^9, 3.727456186089284*^9}, 
   3.72745682664186*^9, 3.727457103211014*^9, 3.727462537773409*^9, 
   3.727462600894341*^9, 3.7274720648603897`*^9, 3.727472137401977*^9, 
   3.727485510677791*^9, 3.727486308137322*^9, 3.727878577703927*^9, 
   3.727880786980283*^9, 3.727881187293543*^9, 3.727881367162183*^9, 
   3.7279153846145782`*^9, 3.727918036001253*^9, 3.727918094003922*^9, 
   3.727924197077376*^9, {3.7279277061564293`*^9, 3.7279277315954943`*^9}, 
   3.727967809713481*^9, 3.72796873270875*^9, 3.727969807680747*^9, 
   3.727969954624679*^9, 3.728044351074147*^9, 3.72804644720837*^9, 
   3.728066469128708*^9, 3.728068120342204*^9, 3.728083782832687*^9, 
   3.7280907407468643`*^9, 3.728169444417408*^9, 3.72816954001482*^9, 
   3.728169822168985*^9, 3.7281698821964903`*^9, 3.728252954623953*^9, 
   3.728946255244152*^9, 3.729022899498974*^9, {3.7291199776963177`*^9, 
   3.729119994943653*^9}, 3.729121071330551*^9, 3.729121109944316*^9, 
   3.729172306734695*^9, 3.7291756896573877`*^9, 3.729175732578528*^9, 
   3.729183411371399*^9, {3.7291834466465073`*^9, 3.729183459697401*^9}, 
   3.7292559361641417`*^9, 3.729552300379833*^9, 3.729557874992567*^9, 
   3.729629836791162*^9, 3.729634634527203*^9, 3.729642870835823*^9, 
   3.729642907315332*^9, 3.729643937395816*^9, 3.729647183669672*^9, 
   3.729683200518203*^9, 3.729778152836467*^9, 3.729779231029831*^9, 
   3.729779278929041*^9, 3.731525583822114*^9, 3.731527813748137*^9, 
   3.7315829924054956`*^9, 3.731670255005756*^9, 3.731671800943514*^9, 
   3.7316718375129757`*^9, 3.7318012903056583`*^9, 3.731803351814928*^9, 
   3.731837026574437*^9},
 CellLabel->
  "Out[7]//Short=",ExpressionUUID->"77a40b6f-f8e2-4bce-b213-9af7e5ebb8b9"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Faked Observations \[CapitalZeta]", "Subchapter",
 CellChangeTimes->{{3.727038130736038*^9, 3.727038133799975*^9}, 
   3.727038190200441*^9, {3.7280914789368753`*^9, 3.728091489257578*^9}},
 CellTags->"c:6",ExpressionUUID->"0d62cc58-4a7d-4ab1-afbb-f501bfb6ca94"],

Cell[TextData[{
 "Here we define a global variable, ",
 Cell[BoxData[
  FormBox["data", TraditionalForm]], "Code",
  FormatType->"TraditionalForm",ExpressionUUID->
  "b08739b2-ea21-42be-a02e-2062d457b83b"],
 ", to be used in later derivations and demonstrations:"
}], "Text",
 CellChangeTimes->{{3.729796582381321*^9, 
  3.729796618172481*^9}},ExpressionUUID->"c286be14-3574-4e2f-aee0-\
88b3eca1df91"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "fake", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"fake", "[", 
    RowBox[{"n_", ",", "\[Sigma]_", ",", "A_", ",", 
     RowBox[{"{", 
      RowBox[{"m_", ",", "b_"}], "}"}]}], "]"}], ":=", "\[IndentingNewLine]", 
   
   RowBox[{"Table", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
      RowBox[{"RandomVariate", "[", 
       RowBox[{"NormalDistribution", "[", 
        RowBox[{"0", ",", "\[Sigma]"}], "]"}], "]"}], "+", 
      RowBox[{
       RowBox[{"A", "\[LeftDoubleBracket]", "i", "\[RightDoubleBracket]"}], 
       ".", 
       RowBox[{"{", 
        RowBox[{"m", ",", "b"}], "}"}]}]}], ",", "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{"i", ",", "n"}], "}"}]}], "]"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.727447704011672*^9, 3.727447786446568*^9}, {
  3.7274490411388807`*^9, 3.727449101412051*^9}, {3.727449980043066*^9, 
  3.727449994241746*^9}, {3.727450133949367*^9, 3.727450162748006*^9}, {
  3.727451390752479*^9, 3.727451399962222*^9}},
 CellLabel->"In[8]:=",ExpressionUUID->"68458ec7-49df-48ae-ada3-aabe6fcd1144"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{"data", ",", "noise\[Sigma]"}], "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"noise\[Sigma]", "=", "0.65"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"data", "=", 
   RowBox[{"fake", "[", 
    RowBox[{
    "nData", ",", "noise\[Sigma]", ",", "partials", ",", "groundTruth"}], 
    "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"Short", "[", 
  RowBox[{"data", ",", "3"}], "]"}]}], "Input",
 CellChangeTimes->{{3.727038280219474*^9, 3.727038287790659*^9}, {
  3.7270383211500597`*^9, 3.72703835571806*^9}, {3.7270386358940287`*^9, 
  3.727038663927939*^9}, {3.727038747737464*^9, 3.727038876839672*^9}, {
  3.727050006302822*^9, 3.7270500110829983`*^9}, {3.727432654265699*^9, 
  3.727432659697441*^9}, {3.727432723054358*^9, 3.727432765462573*^9}, {
  3.72744344707723*^9, 3.7274434481794357`*^9}, {3.727446952499505*^9, 
  3.7274469532000103`*^9}, {3.727447283073348*^9, 3.727447284101734*^9}, {
  3.727447801831417*^9, 3.7274478305638647`*^9}, {3.72745000784216*^9, 
  3.727450013288878*^9}, {3.7274501435089684`*^9, 3.727450170037139*^9}, {
  3.727450669288356*^9, 3.727450670595593*^9}, {3.727451668943946*^9, 
  3.727451671078163*^9}, {3.7274720470935698`*^9, 3.727472053265984*^9}, {
  3.7280915253683*^9, 3.728091537656971*^9}, {3.729552257778557*^9, 
  3.729552307472777*^9}},
 CellLabel->"In[10]:=",ExpressionUUID->"a06eade6-df5a-4a64-bc67-512ccb726142"],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{
    RowBox[{"-", "0.6304090761275682`"}], ",", 
    RowBox[{"-", "0.7169910305149817`"}], ",", 
    RowBox[{"-", "1.178771498821437`"}], ",", 
    RowBox[{"-", "0.6544407622119716`"}], ",", 
    RowBox[{"\[LeftSkeleton]", "112", "\[RightSkeleton]"}], ",", 
    "1.9557537693860536`", ",", "1.184962538539887`", ",", 
    "1.1273636876885673`"}], "}"}],
  Short[#, 3]& ]], "Output",
 CellChangeTimes->{
  3.7270387677851763`*^9, {3.727038867149591*^9, 3.7270388773964233`*^9}, 
   3.727055663102105*^9, 3.727057129370555*^9, 3.727059177422636*^9, 
   3.72705942033997*^9, 3.7270594605156918`*^9, 3.7270597222146673`*^9, 
   3.727370407509316*^9, 3.72737937420789*^9, 3.727379619053474*^9, 
   3.7273829520789537`*^9, {3.727432741397806*^9, 3.7274327662165937`*^9}, 
   3.7274396353972178`*^9, 3.727442992108829*^9, 3.727443422045128*^9, 
   3.727443452800355*^9, 3.727444587519507*^9, 3.72744468023639*^9, 
   3.72744557183354*^9, 3.7274462462052383`*^9, 3.727446405956995*^9, 
   3.727446838056027*^9, 3.727446872970574*^9, {3.7274469079026823`*^9, 
   3.7274470702684298`*^9}, {3.727447285361125*^9, 3.727447290697486*^9}, 
   3.727447347400682*^9, 3.727447838556155*^9, 3.727449704912554*^9, 
   3.727449903803282*^9, {3.727450008789967*^9, 3.727450014801861*^9}, 
   3.727450179801093*^9, {3.727450656921492*^9, 3.7274506714803667`*^9}, 
   3.727450973950561*^9, 3.727451671368905*^9, 3.727451987158052*^9, 
   3.727454844732745*^9, 3.727455079003149*^9, 3.7274559744493303`*^9, {
   3.727456142089485*^9, 3.7274561861436663`*^9}, 3.7274568266819696`*^9, 
   3.7274571032765923`*^9, 3.727462547831717*^9, 3.727462600948619*^9, {
   3.72747204808424*^9, 3.727472053925476*^9}, 3.727472137462739*^9, 
   3.7274855107778893`*^9, 3.727486308212657*^9, 3.727878577784017*^9, 
   3.727880787054256*^9, 3.7278811873704453`*^9, 3.7278813672409067`*^9, 
   3.7279153846882277`*^9, 3.727918036075748*^9, 3.727918094088941*^9, 
   3.727924197165626*^9, {3.7279277062395906`*^9, 3.727927731659636*^9}, 
   3.727967809786593*^9, 3.7279687327633533`*^9, 3.727969807759448*^9, 
   3.7279699546901617`*^9, 3.728044351191318*^9, 3.728046447285791*^9, 
   3.728066469199588*^9, 3.728068120401382*^9, 3.728083782912451*^9, 
   3.7280907408080997`*^9, 3.72809154205811*^9, 3.728169444492231*^9, 
   3.728169540095767*^9, 3.7281698222504396`*^9, 3.728169882302762*^9, 
   3.728252954702303*^9, 3.728946255311282*^9, 3.729022899574115*^9, {
   3.729119977772545*^9, 3.729119995034758*^9}, 3.729121071418002*^9, 
   3.72912111002391*^9, 3.7291723068108187`*^9, 3.7291756897299347`*^9, 
   3.729175743883057*^9, 3.7291834114467783`*^9, {3.72918344672998*^9, 
   3.729183459797777*^9}, 3.729255936257759*^9, {3.729552286826548*^9, 
   3.7295523004417877`*^9}, 3.72955787504913*^9, 3.729629836851104*^9, 
   3.72963463460248*^9, 3.729642870919276*^9, 3.729642907407959*^9, 
   3.7296439374687357`*^9, 3.7296471837506723`*^9, 3.72968320059123*^9, 
   3.729778152946784*^9, 3.729779231114318*^9, 3.729779279013398*^9, 
   3.731525583903779*^9, 3.73152781383072*^9, 3.731582992464345*^9, 
   3.731670255075953*^9, 3.7316718010091343`*^9, 3.7316718375636387`*^9, 
   3.731801302306161*^9, 3.731803351887765*^9, 3.731837026657051*^9},
 CellLabel->
  "Out[13]//Short=",ExpressionUUID->"436d67ee-52d5-4ffa-9dc6-b67b936d9261"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Wolfram Built-In", "Subchapter",
 CellChangeTimes->{{3.727039137746358*^9, 3.727039138418336*^9}, {
  3.7291811790576487`*^9, 3.729181183481278*^9}},
 CellTags->"c:7",ExpressionUUID->"e91f2fba-5676-430d-9745-205c1814fa0e"],

Cell[TextData[{
 "The Wolfram built-in ",
 Cell[BoxData[
  FormBox["LinearModelFit", TraditionalForm]], "Code",ExpressionUUID->
  "c8409882-2bda-4f1b-a5f5-345712fdf085"],
 " computes an MLE (maximum-likelihood estimate) for ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalXi]", "=", 
    RowBox[{"(", GridBox[{
       {"m"},
       {"b"}
      }], ")"}]}], TraditionalForm]],ExpressionUUID->
  "a072ad03-e1f6-4a62-8845-fb0fb07daace"],
 ". The estimated ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["m", "estimated"], TraditionalForm]],ExpressionUUID->
  "8bb6137a-c373-4e68-859f-b628ae16677d"],
 " and ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["b", "estimated"], TraditionalForm]],ExpressionUUID->
  "d7218397-fec7-4a19-834c-58cc47b9f6a1"],
 " are reasonably close to the ground truth ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"(", GridBox[{
       {"m"},
       {"b"}
      }], ")"}], "=", 
    FormBox[
     RowBox[{"(", "\[NoBreak]", GridBox[{
        {"0.5`"},
        {
         RowBox[{"-", "0.3333333333333333`"}]}
       },
       GridBoxAlignment->{
        "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
         "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
       GridBoxSpacings->{"Columns" -> {
           Offset[0.27999999999999997`], {
            Offset[0.7]}, 
           Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
           Offset[0.2], {
            Offset[0.4]}, 
           Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
     TraditionalForm]}], TraditionalForm]],ExpressionUUID->
  "619be9a3-ed89-4377-b9a4-f9b3307ba376"],
 ". "
}], "Text",
 CellChangeTimes->{{3.727432553517992*^9, 3.727432621798977*^9}, {
  3.727472080939521*^9, 3.727472088160452*^9}, {3.728091559509233*^9, 
  3.7280915965871964`*^9}, {3.729181114250214*^9, 3.729181127378771*^9}, {
  3.729642997093185*^9, 3.7296430459691153`*^9}, {3.729796629339664*^9, 
  3.729796655666141*^9}},ExpressionUUID->"9648f90a-a626-4271-8be6-\
c25292b618eb"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "model", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"model", "=", 
   RowBox[{
    StyleBox["LinearModelFit",
     Background->RGBColor[0.87, 0.94, 1]], "[", 
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"partials", "\[LeftDoubleBracket]", 
         RowBox[{"All", ",", "1"}], "\[RightDoubleBracket]"}], ",", "data"}], 
       "}"}], "\[Transpose]"}], ",", "x", ",", "x"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"Normal", "[", "model", "]"}]}], "Input",
 CellChangeTimes->{{3.7270391419515553`*^9, 3.727039222672346*^9}, {
   3.727039589022585*^9, 3.727039634463044*^9}, {3.72703984614863*^9, 
   3.7270398612337418`*^9}, {3.727432525241551*^9, 3.727432532127486*^9}, 
   3.727445246314415*^9, {3.729022958695567*^9, 3.729022961245884*^9}},
 CellLabel->"In[14]:=",ExpressionUUID->"83aa8865-1d03-4f5f-8eee-bf94e902264f"],

Cell[BoxData[
 RowBox[{
  RowBox[{"-", "0.31780144311804515`"}], "+", 
  RowBox[{"0.5377933922887307`", " ", "x"}]}]], "Output",
 CellChangeTimes->{
  3.727039636453086*^9, 3.727039861741905*^9, 3.727055663158083*^9, 
   3.727057129421227*^9, 3.727059177473164*^9, 3.727059420390205*^9, 
   3.727059460559739*^9, 3.7270597222647333`*^9, 3.727370407570586*^9, 
   3.727379374273665*^9, 3.727379619119594*^9, 3.727382952138339*^9, 
   3.727432540947384*^9, 3.7274396354423*^9, 3.727442992152419*^9, 
   3.7274434220853767`*^9, 3.727443452837515*^9, 3.7274445875622473`*^9, 
   3.727444680287569*^9, 3.7274451623174067`*^9, 3.727445248914556*^9, 
   3.7274455718832607`*^9, 3.727446246253859*^9, 3.727446406005806*^9, 
   3.7274468381061697`*^9, 3.727446873004697*^9, {3.727446907951789*^9, 
   3.7274470703496027`*^9}, 3.727447290772621*^9, 3.7274473474807863`*^9, 
   3.727447838604089*^9, 3.72744971744767*^9, 3.727449903849738*^9, 
   3.727450179854268*^9, 3.72745067894905*^9, 3.727450974002071*^9, 
   3.7274519905214252`*^9, 3.727454844781467*^9, 3.7274550790484867`*^9, 
   3.727455974499503*^9, {3.7274561421377363`*^9, 3.727456186189336*^9}, 
   3.7274568267039757`*^9, 3.727457103314196*^9, 3.727462551096787*^9, 
   3.727462600989726*^9, 3.7274721375146713`*^9, 3.727485510832881*^9, 
   3.7274863082710543`*^9, 3.727878577840499*^9, 3.727880787101037*^9, 
   3.727881187428447*^9, 3.7278813672674103`*^9, 3.727915384737116*^9, 
   3.72791803614151*^9, 3.7279180941213903`*^9, 3.727924197222649*^9, {
   3.727927706298745*^9, 3.7279277317186337`*^9}, 3.727967809847283*^9, 
   3.7279687328234253`*^9, 3.727969807818206*^9, 3.7279699547399473`*^9, 
   3.7280443512586803`*^9, 3.728046447345396*^9, 3.728066469257868*^9, 
   3.72806812045158*^9, 3.728083782977825*^9, 3.728090740871644*^9, 
   3.728169444560561*^9, 3.728169540157092*^9, 3.72816982231103*^9, 
   3.7281698823703403`*^9, 3.728252954766592*^9, 3.7289462553806963`*^9, 
   3.729022899597123*^9, 3.729022962429747*^9, {3.729119977839348*^9, 
   3.729119995092936*^9}, 3.729121071495359*^9, 3.729121110082161*^9, 
   3.729172306871163*^9, 3.729175689791526*^9, 3.729175746503436*^9, 
   3.729183411514368*^9, {3.729183446802239*^9, 3.729183459872917*^9}, 
   3.7292559363249063`*^9, 3.7295523004935513`*^9, 3.729557875098798*^9, 
   3.729629836899338*^9, 3.729634634660095*^9, 3.729642870980741*^9, 
   3.729642907467251*^9, 3.72964393753092*^9, 3.7296471838097754`*^9, 
   3.729683200649811*^9, 3.72977815300661*^9, 3.7297792311672363`*^9, 
   3.729779279076786*^9, 3.7315255840148373`*^9, 3.7315278139546127`*^9, 
   3.731582992556518*^9, 3.731670257542354*^9, 3.731671801060905*^9, 
   3.731671837629904*^9, 3.731801323536462*^9, 3.7318033519248447`*^9, 
   3.731837026773629*^9},
 CellLabel->"Out[16]=",ExpressionUUID->"7371cd1f-74e4-405f-8849-8eeebfdd8203"]
}, Open  ]],

Cell["\<\
Un-comment the following line to see everything Wolfram has to say about this \
MLE (it\[CloseCurlyQuote]s a lot of data).\
\>", "Text",
 CellChangeTimes->{{3.727445705251766*^9, 3.727445735756525*^9}, {
   3.727446896680705*^9, 3.727446898174596*^9}, 3.727447110091947*^9, {
   3.728091613989747*^9, 
   3.7280916153070917`*^9}},ExpressionUUID->"5b048dbd-26e5-41a7-a5e0-\
f8f76a86b877"],

Cell[BoxData[
 RowBox[{"(*", 
  RowBox[{"Association", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"(", 
      RowBox[{"#", "\[Rule]", 
       RowBox[{"model", "[", "#", "]"}]}], ")"}], "&"}], "/@", 
    RowBox[{"model", "[", "\"\<Properties\>\"", "]"}]}], "]"}], 
  "*)"}]], "Input",
 CellChangeTimes->{{3.727445423183494*^9, 3.727445453352212*^9}, {
  3.727445496770472*^9, 3.727445513033325*^9}, {3.727445697132193*^9, 
  3.727445698524333*^9}, {3.727446901104203*^9, 3.727446903566482*^9}, {
  3.727453939742375*^9, 3.727453943568625*^9}, {3.727454015364012*^9, 
  3.727454016578137*^9}},
 CellLabel->"In[17]:=",ExpressionUUID->"bccb08a3-bc86-406e-b91a-cb8f4590cb84"],

Cell["\<\
For purposes below, the most important attribute of the model is its \
covariance matrix. We come back to it below.\
\>", "Text",
 CellChangeTimes->{{3.72955741357407*^9, 
  3.7295574395717163`*^9}},ExpressionUUID->"c9624449-1281-4c8f-b284-\
ffbdd9c15235"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"model", "[", "\"\<CovarianceMatrix\>\"", "]"}], "//", 
  "MatrixForm"}]], "Input",
 CellChangeTimes->{{3.7295573787326307`*^9, 3.7295574025236588`*^9}},
 CellLabel->"In[18]:=",ExpressionUUID->"1aa612f5-94a1-47e8-a61b-a5e1600171d0"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"0.006047175062445957`", 
      RowBox[{"-", "0.0025667865372972047`"}]},
     {
      RowBox[{"-", "0.0025667865372972047`"}], "0.0025667865372972047`"}
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
 CellChangeTimes->{{3.729557386643347*^9, 3.72955740355597*^9}, 
   3.729557875150962*^9, 3.729629836975811*^9, 3.729634634732983*^9, 
   3.729642871050211*^9, 3.729642907554695*^9, 3.729643937605584*^9, 
   3.729647183884037*^9, 3.729683200722887*^9, 3.729778153092148*^9, 
   3.729779231241169*^9, 3.729779279163685*^9, 3.731525584095064*^9, 
   3.731527814042692*^9, 3.731582992615946*^9, 3.731670257609758*^9, 
   3.731671801114793*^9, 3.7316718376776*^9, 3.7318013350292177`*^9, 
   3.731803351972896*^9, 3.731837026850183*^9},
 CellLabel->
  "Out[18]//MatrixForm=",ExpressionUUID->"442c0a7d-af12-4093-984b-\
3832ff7b71f9"]
}, Open  ]],

Cell[TextData[{
 "The plot shows that Wolfram does an acceptable job, for practical purposes, \
of estimating the parameters ",
 Cell[BoxData[
  FormBox["m", TraditionalForm]],ExpressionUUID->
  "957969ed-d6e9-4dae-9f5d-a59132086d64"],
 " and ",
 Cell[BoxData[
  FormBox["b", TraditionalForm]],ExpressionUUID->
  "c753b193-4efd-408f-83db-bd5ff456e748"],
 " that define the line. We have 119 data and two parameters to estimate, so \
over-fitting will not be an issue in this early example. We explore \
over-fitting at length below."
}], "Text",
 CellChangeTimes->{{3.72748603072836*^9, 3.7274860648301*^9}, {
  3.7291812022277317`*^9, 3.7291812668515997`*^9}, {3.729643073881525*^9, 
  3.729643087239958*^9}},ExpressionUUID->"bf371dfc-b470-4783-b2ee-\
dd6343a808a9"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Show", "[", 
  RowBox[{
   RowBox[{"ListPlot", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"partials", "\[LeftDoubleBracket]", 
        RowBox[{"All", ",", "1"}], "\[RightDoubleBracket]"}], ",", "data"}], 
      "}"}], "\[Transpose]"}], "]"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Plot", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{
        RowBox[{"m", " ", "x"}], "+", "b"}], ",", 
       RowBox[{"model", "[", "x", "]"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"x", ",", "min", ",", "max"}], "}"}]}], "]"}]}], "]"}]], "Input",\

 CellChangeTimes->{{3.727039646243634*^9, 3.7270396697516117`*^9}, {
   3.727039719966466*^9, 3.727039823407961*^9}, 3.727447260921829*^9, {
   3.727472117984476*^9, 3.72747212110266*^9}, {3.7274729782058973`*^9, 
   3.727472978941469*^9}, {3.729022972254067*^9, 3.729022988249905*^9}, 
   3.729558657302623*^9},
 CellLabel->"In[19]:=",ExpressionUUID->"922b24d0-ae9a-4fbc-a366-23e6b3d1e168"],

Cell[BoxData[
 GraphicsBox[{{{}, {{}, 
     {RGBColor[0.368417, 0.506779, 0.709798], PointSize[0.009166666666666668],
       AbsoluteThickness[1.6], PointBox[CompressedData["
1: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
vZk=
       "]]}, {}}, {}, {}, {}, {}}, {{{}, {}, 
     TagBox[
      {RGBColor[0.368417, 0.506779, 0.709798], AbsoluteThickness[1.6], 
       Opacity[1.], LineBox[CompressedData["
1:eJwVxX081HccAPDD8SO5Yg1RSyVTeZx5bO3znRQ1CkVSnYskKsp6UHGSjstC
dR7mQlvyXGioPKxvSWjhhXOccBwyDh0/T5Xjtv3xfr3X+4a4+8tTKBSX//z/
EaZRu0wmwYLRl0kFBWIsJB1XTs9KsM7D5u8eZosxI8DPeXhMgr3pPS0Zv4ux
vyu3trFTgnvb5pffSRHj4A3K5WnFEjxQZcK6dF2Mo+oGky18JHgsPv2Cg7cY
59DuHQx48REvmYd5ClXEeDJTpbs5fAJvuGKqrRE4igvytdqjX4vxtcinSaeX
j+Dt1/oMg21G8NsgHSyqG8bBnWzVbyo/YF/NkJKK2A/4jbZff6niIFaz7uHe
MB7Cs5vmV0ZG9uPs7QYWQeIBnGoXFsCI6cauFexa+1siHLnlTYPLtx14z2z3
Gub3/Xj1nyxRtn4r9jXR3pX3Ty+W6br+xTlVjz2O5DvYmXVjH6VPzr7xlXi9
50ymXK4APz4RYmuQy8VxLXqxCVs68COF0O3Afww6lsxjcmE87IRlc0UxryDa
Pzk1f7oFq3r0eVw82wj6lKrIkNBGbHQ+/QWHwwOmFW1cU6se6+XwuVF3BRBH
5a/YrF2DGxQe381a7IValwVTmncF7jvODjSOEUFJdAAdLhfhsqM3tbJ2DMHK
K7hno+4dPMbPs94/MwwMFZtNQkka7L5OkzZdHIWW0iHuAKsEohx2NPuajkNJ
9bNBy5NV0G/3wqGm4iNovmsVdjXUgJugULPo3iRwn1JL1GrrYd03/ers2Slo
a+KnX9jaBBSmtY+jzTQU5qwOtNVtheaTF0u/SpkBx/BU9bYOHuzl1KKIiVlw
bLUwymZ1gKjTUq/ReB7OeGuO2St1wbHcBCXDm5/gzOf6Z1+qu2Hm9jIIbPoM
nEZsGLFTCLaVySWOqguQsGJMMYPRD0HBypstjkvh5eujTHaFCIp/yJxWyFkE
6t1pp0MLAyBK1n0jkpeB1dhZHWuvIeBQ6efd9SkonK7+45eMD0ATlj+Qr6Wg
UPVXXO/eYaBERB2wPSeHPPd5LdVbj8BCHr14QEMeOedqlOlcHYUz3OJ4jRp5
ZBZXdvZKlxieb2UrqwcroLpH/icumY/D8j2hRtdpVBQ8alt0KHQCOo1beJer
qYj6ZFbq1PwRCjNBf4iuiDx3i5sTVCbBq9hKfe2SIlLwFlXV503CVdYfUT0F
SsjAzNko1mMK8kbW3qM5E2g/p2FnxdwU3MhgMYR7CWTqZKZ68/MUMNwnNhW5
EUh1MbXFSzoFWtXVJS4HCVRzIuDwJzkSYhIP193yJZC5ndI5azUSjlulTS27
TKAVoh3p5RtJ0LuxyonIIdA7E0w+cSVBahOu1plHoNxBg+dR+0kQTAy25RQS
KPq3hAg3TxISD5Ye3fWEQHbydOWpwyQsbXH/hVVNoHy+dK1ZAAk9rYmZCjwC
xYbb7S6KIOF5zLwfj08gP/MHNOY1EpK2+WzOEhAIhlXaXaJJ+DnbpMxeSKC5
fV30CTYJlWFNb6NGCeS/Mey8URIJKcaWiW7jBPpJ0GcrTSHh3ED6gfUSAq2J
d5S9SyPB0Pl038sZAvHmNONO3SeBKtf+8PY8gYoLmfu2PSChv3xbEOMLgX5l
DK9SzSahOijL1GyRQAFf733/PpeE1HWqszIZgez/Lr9fUEDCv0Lec4Y=
        "]]},
      Annotation[#, "Charting`Private`Tag$2355#1"]& ], 
     TagBox[
      {RGBColor[0.880722, 0.611041, 0.142051], AbsoluteThickness[1.6], 
       Opacity[1.], LineBox[CompressedData["
1:eJwB4QQe+yFib1JlAgAAAE0AAAACAAAAXH4s1P//7782lARUCGHrv97yRxDz
9e+/IwhKtqBb679gZ2NM5uvvvxB8jxg5Vuu/ZVCaxMzX77/qYxrdaUvrv24i
CLWZr++/njMwZss167+BxuOVM1/vvwbTW3iOCuu/pg6bV2e+7r/WEbOcFLTq
v/CeCdvOfO2/do9h5SAH6r+qqRfUg8Pqvxz2EP8gkOi/PYDfKG446L9SQfDY
+jHnv27XiAseuuW/YvMKC7Pa5b/FGGPgswXjv9cQeMVSZuS/9SX3EH9/4L/e
EhVAzArjv5c6eGdghtu/SoAEQy2S4b9/KsXITSfWv5BUL55sIOC/GbKF4aUk
0b/MGhRzC4/dv/8bUL2Ta8e/RGNuugyj2r9fBvhMYo26v990KILB6Ne/rWZv
OSanmr8pVFn6MjzVv6wDcj0/1a0/QQovg3NV0r9Iv//2robBP/USyRjPQM+/
C1XfVXZwzD8Cv31MVWLJvyx0nL6Tk9M/bwYg4VSfw78gptWagZLYP0LAA+12
f7y/yAOtkqP93T/YzlpagNewv99kiGkthuE/0AfEJF/Zl7+0XYkXo0PkP/C+
lRVSTpc/69WoN1P05j+sqiASjmaxP0mCDvzNduk/EMFcnbkyvD+BREPOYi/s
PyK+AnPU88M/4Dq+RMK57j94iZcW5WrJP1HYqxaum/A/cLk+WXzGzj8fHuAR
iPXxP+gdTr06S9I/AH43X0c48z/0FZ3NgwHVP85odrMTlvQ/MjdHzf3x1z9O
k8RAfe31P8SKehy71No/4dc1IMwt9z8yFU7rxIXdP2GnjgYoifg/aWS+1H84
4D/0kAo/ac35P6jZpXNDleE/ObqVsEcL+z8Q6FG6KOviP2puCCkzZPw/EYur
eCZe5D+vPJ7zA6b9P4FJ1XZKuOU/4ZUbxeEC/z+KnKzshi/nP5MEXnRSJABA
BAtUoumN6D8O3rWiAsQAQKQSwP9t5ek/AH2BVDlxAUDertnUClrrP/uoXq/i
EgJAhmbD6c217D9tmq+NEsICQMqyWnapLu4/uCuICBFuA0A2mLaqpqDvPwxK
ciyCDgRAh0xxD+V88D/XLdDTebwEQEEXXgUDOPE/q54/JOReBUCy7zIbtObx
P1ivNhEd/gVAtxTqBPaR8j97haGB3KoGQAkEeCrES/M/qOgdmw5MB0ASAe5v
JfnzP4SdhWDeTgdAWdsPnSv88z9gUu0lrlEHQKG1Mcox//M/F7y8sE1XB0Av
anUkPgX0P4aPW8aMYgdATdP82FYR9D9kNpnxCnkHQImlC0KIKfQ/IIQUSAem
B0D/SSkU61n0P/w4fA3XqAdARyRLQfFc9D/Y7ePSpqsHQI/+bG73X/Q/j1ez
XUaxB0Ads7DIA2b0P/4qUnOFvAdAOxw4fRxy9D/c0Y+eA9MHQHbuRuZNivQ/
uIb3Y9PVB0C+yGgTVI30P5Q7Xymj2AdABqOKQFqQ9D9LpS60Qt4HQJRXzppm
lvQ/unjNyYHpB0CywFVPf6L0P5YtNY9R7AdA+Zp3fIWl9D9x4pxUIe8HQEB1
mamLqPQ/KExs38D0B0DOKd0DmK70PwQB1KSQ9wdAFgT/MJ6x9D/gtTtqYPoH
QF7eIF6ktPQ/vGqjLzD9B0CluEKLqrf0P5cfC/X//wdA7JJkuLC69D/gOmvY

        "]]},
      Annotation[#, "Charting`Private`Tag$2355#2"]& ]}, {}, {}}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, 0},
  DisplayFunction->Identity,
  Frame->{{False, False}, {False, False}},
  FrameLabel->{{None, None}, {None, None}},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  ImagePadding->All,
  Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& ), "CopiedValueFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& )}},
  PlotRange->{{-1., 3.}, {-2.1020289220592567`, 2.502298433697786}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.05], 
     Scaled[0.05]}},
  Ticks->{Automatic, Automatic}]], "Output",
 CellChangeTimes->{{3.7270397600884542`*^9, 3.727039824579692*^9}, 
   3.727055663223078*^9, 3.727057129486121*^9, 3.7270591775352287`*^9, {
   3.7270594204521437`*^9, 3.727059460621175*^9}, 3.727059722329212*^9, 
   3.7273704078372583`*^9, 3.7273793744929037`*^9, 3.727379619346348*^9, 
   3.72738295235072*^9, 3.727439635504332*^9, 3.7274429922215157`*^9, 
   3.727443422152643*^9, 3.727443452894998*^9, 3.7274445876245737`*^9, 
   3.727444680345767*^9, 3.727445572187066*^9, 3.727446246645545*^9, 
   3.727446406395307*^9, 3.727446838396817*^9, {3.7274468849772997`*^9, 
   3.727447072208765*^9}, {3.72744726321743*^9, 3.727447292342368*^9}, 
   3.727447349128606*^9, 3.7274478387626667`*^9, 3.727449904022327*^9, 
   3.727450180015175*^9, 3.727454252117652*^9, 3.727454844917451*^9, 
   3.7274550791704597`*^9, 3.7274559746420507`*^9, {3.727456142274695*^9, 
   3.7274561863233337`*^9}, 3.727456826835528*^9, 3.7274571034544353`*^9, 
   3.727462557970257*^9, 3.727462601129395*^9, 3.727472137742113*^9, 
   3.727485511026442*^9, 3.7274863084589243`*^9, 3.727878578108341*^9, 
   3.727880787187166*^9, 3.727881187660624*^9, 3.727881367362421*^9, 
   3.727915384979436*^9, 3.727918036407303*^9, 3.727918094232634*^9, 
   3.727924197467864*^9, {3.7279277065514917`*^9, 3.72792773181036*^9}, 
   3.7279678100081873`*^9, 3.727968732916506*^9, 3.727969807912593*^9, 
   3.727969954824*^9, 3.728044351393855*^9, 3.7280464474397182`*^9, 
   3.728066469373081*^9, 3.728068120547882*^9, 3.728083783120768*^9, 
   3.728090741113459*^9, 3.72816944482609*^9, 3.728169540411261*^9, 
   3.728169822560478*^9, 3.728169882589735*^9, 3.728252955037623*^9, 
   3.7289462555001717`*^9, 3.729022899694229*^9, {3.7290229785172358`*^9, 
   3.729022989025024*^9}, {3.7291199780929327`*^9, 3.72911999521071*^9}, 
   3.7291210716202803`*^9, 3.729121110195902*^9, 3.729172306990698*^9, 
   3.729175690032875*^9, 3.729175752112059*^9, 3.729183411778121*^9, {
   3.729183447029324*^9, 3.729183459995894*^9}, 3.729255936469942*^9, 
   3.729552300734869*^9, 3.7295578752136106`*^9, 3.729629837059063*^9, 
   3.729634634939146*^9, 3.729642871231386*^9, 3.729642907748444*^9, 
   3.729643937794228*^9, 3.7296471840945873`*^9, 3.7296832009361258`*^9, 
   3.729778153343004*^9, 3.729779231469899*^9, 3.729779279378066*^9, 
   3.731525584328485*^9, 3.7315278143265676`*^9, 3.7315829928449297`*^9, 
   3.731670257839517*^9, 3.731671801188936*^9, 3.7316718378653593`*^9, 
   3.73180135169821*^9, 3.731803352044848*^9, 3.731837027101844*^9},
 CellLabel->"Out[19]=",ExpressionUUID->"7191b8ee-db95-4b8f-ba2f-680b8219b491"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Normal Equations ", "Subchapter",
 CellChangeTimes->{{3.727038154048767*^9, 3.7270381788082533`*^9}, {
  3.72737126177953*^9, 3.727371269395361*^9}, {3.7273713004742193`*^9, 
  3.727371301473422*^9}, {3.727432388690963*^9, 3.727432389111678*^9}},
 CellTags->"c:8",ExpressionUUID->"ca281e5b-c608-485a-9d34-ff27451115a8"],

Cell[TextData[{
 "Solve equation 1 for a value of ",
 Cell[BoxData[
  FormBox["\[CapitalXi]", TraditionalForm]],ExpressionUUID->
  "e1070982-4510-452d-9104-4027b4282bf6"],
 " that minimizes sum-squared error ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"J", "(", "\[CapitalXi]", ")"}], 
    OverscriptBox["=", "def"], 
    RowBox[{
     RowBox[{
      RowBox[{"(", 
       RowBox[{"\[CapitalZeta]", "-", 
        RowBox[{"A", "\[CenterDot]", "\[CapitalXi]"}]}], ")"}], 
      "\[Transpose]"}], "\[CenterDot]", 
     RowBox[{"(", 
      RowBox[{"\[CapitalZeta]", "-", 
       RowBox[{"A", "\[CenterDot]", "\[CapitalXi]"}]}], ")"}]}]}], 
   TraditionalForm]],ExpressionUUID->"a1b9d468-03dc-49c4-9943-08e96ac761de"],
 ". That is the same as maximizing the likelihood of the data given the \
parameters, ",
 Cell[BoxData[
  FormBox[
   RowBox[{"p", "\[ThinSpace]", "(", "\[ThinSpace]", 
    RowBox[{"Z", "\[VerticalSeparator]", "\[CapitalXi]"}], "\[ThinSpace]", 
    ")"}], TraditionalForm]],ExpressionUUID->
  "9c939515-2fd8-483c-8d91-92bc6c692f12"],
 ". Because the noise ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"\[ScriptCapitalN]", "(", 
     RowBox[{"0", ",", "\[Sigma]"}], ")"}], " "}], TraditionalForm]],
  ExpressionUUID->"d2ef2ed6-3502-41a9-ab64-83e47fa693fe"],
 "has zero mean, The solution turns out to be exactly what one would get from \
naive algebra:  ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "A"}], TraditionalForm]],
  ExpressionUUID->"8524cb7a-422e-4376-9160-8b30cfd59b34"],
 " is square; when it is invertible,"
}], "Text",
 CellChangeTimes->{{3.7274327843718157`*^9, 3.7274328812568607`*^9}, {
   3.7274329695492764`*^9, 3.727432987909341*^9}, {3.7274405929522963`*^9, 
   3.727440597776662*^9}, {3.7274408305087957`*^9, 3.727440834532775*^9}, {
   3.727441137039894*^9, 3.7274412589545507`*^9}, {3.727441298555641*^9, 
   3.7274413240290527`*^9}, {3.727443711138123*^9, 3.727443712008112*^9}, 
   3.727443932952423*^9, {3.7274449899160423`*^9, 3.727444993644582*^9}, {
   3.7274721541913548`*^9, 3.727472171381256*^9}, {3.728091667557364*^9, 
   3.728091738028015*^9}, {3.729163097998804*^9, 3.729163154268798*^9}, {
   3.7291813681246843`*^9, 3.729181394329205*^9}, {3.729796702007291*^9, 
   3.729796706164723*^9}},ExpressionUUID->"a9137087-d558-4777-9e56-\
9e100bfcc743"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "A"}], ")"}], 
     RowBox[{"-", "1"}]], "\[CenterDot]", 
    RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "Z"}], "  ", "=", "  ", 
   "\[CapitalXi]"}], TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.7274329995816317`*^9, 3.727433086256638*^9}, {
   3.727440616369582*^9, 3.727440619713708*^9}, 3.727440980127179*^9, {
   3.727441064009115*^9, 3.7274410867129498`*^9}, 3.7274412680182333`*^9, {
   3.727443724893661*^9, 3.7274437756712503`*^9}, {3.727443806351503*^9, 
   3.727443813377001*^9}, 
   3.727445003473629*^9},ExpressionUUID->"f8ba42d7-04ae-4e9e-8434-\
d4ba4a95557e"],

Cell["\<\
That gives numerically the same answer as Wolfram\[CloseCurlyQuote]s built-in:\
\>", "Text",
 CellChangeTimes->{{3.72747218573221*^9, 3.727472199188305*^9}, {
  3.7280917625845823`*^9, 3.728091764046361*^9}, {3.729181412765233*^9, 
  3.729181414139698*^9}},ExpressionUUID->"82e3ae29-29c1-416f-b544-\
fd3c6d827ad2"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"Inverse", "[", 
   RowBox[{
    RowBox[{"partials", "\[Transpose]"}], ".", "partials"}], "]"}], ".", 
  RowBox[{"partials", "\[Transpose]"}], ".", "data"}]], "Input",
 CellChangeTimes->{{3.727039915051565*^9, 3.727039947873397*^9}, {
  3.7274446395823927`*^9, 3.727444668828559*^9}},
 CellLabel->"In[20]:=",ExpressionUUID->"986deba2-6cc4-4f3b-8665-91369b1c6aee"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"0.5377933922887305`", ",", 
   RowBox[{"-", "0.31780144311804487`"}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.727039950530216*^9, 3.7270556632408323`*^9, 3.7270571295031*^9, 
   3.7270591775686493`*^9, 3.727059420486622*^9, {3.727059460678652*^9, 
   3.727059488023638*^9}, 3.727059722365232*^9, 3.727370407864249*^9, 
   3.727379374524898*^9, 3.727379619403*^9, 3.7273829524231453`*^9, 
   3.727439635518877*^9, 3.72744299227162*^9, 3.727443422204742*^9, 
   3.7274434529244432`*^9, 3.7274445876536283`*^9, {3.727444644095763*^9, 
   3.727444680375827*^9}, 3.727445572201291*^9, 3.7274462466755257`*^9, 
   3.727446406427293*^9, 3.727446838427972*^9, {3.727446885017421*^9, 
   3.727447072404998*^9}, 3.727447292581995*^9, 3.727447349354774*^9, 
   3.7274478387943707`*^9, 3.727449904059287*^9, 3.727450180032485*^9, 
   3.72745484494238*^9, 3.727455079217379*^9, 3.727455974674*^9, {
   3.727456142288823*^9, 3.727456186372755*^9}, 3.727456826850039*^9, 
   3.727457103498486*^9, 3.7274626011682777`*^9, 3.7274721377771683`*^9, 
   3.7274855110572844`*^9, 3.727486308524558*^9, 3.727878578139612*^9, 
   3.727880787216714*^9, 3.727881187690591*^9, 3.727881367391988*^9, 
   3.727915385038457*^9, 3.727918036443694*^9, 3.727918094268628*^9, 
   3.727924197544126*^9, {3.727927706619681*^9, 3.727927731843884*^9}, 
   3.727967810043667*^9, 3.727968732947627*^9, 3.727969807968458*^9, 
   3.72796995487074*^9, 3.728044351457707*^9, 3.728046447476817*^9, 
   3.7280664694244013`*^9, 3.7280681205745*^9, 3.728083783151114*^9, 
   3.7280907411475573`*^9, 3.728169444868794*^9, 3.7281695404344788`*^9, 
   3.7281698225833893`*^9, 3.728169882612453*^9, 3.728252955102865*^9, 
   3.7289462555432*^9, 3.729022899709242*^9, {3.729119978129813*^9, 
   3.7291199952297564`*^9}, 3.7291210716763897`*^9, 3.729121110230036*^9, 
   3.729172307024598*^9, 3.729175690092051*^9, 3.729175756864266*^9, 
   3.729183411801414*^9, {3.7291834470773993`*^9, 3.7291834600163918`*^9}, 
   3.729255936489287*^9, 3.729552300792214*^9, 3.7295573170951357`*^9, 
   3.729557875240993*^9, 3.729629837077847*^9, 3.729634634968029*^9, 
   3.729642871251685*^9, 3.729642907795554*^9, 3.729643937848379*^9, 
   3.729647184159255*^9, 3.729683200973136*^9, 3.729778153407301*^9, 
   3.729779231531921*^9, 3.72977927943953*^9, 3.731525584389176*^9, 
   3.731527814386093*^9, 3.731582992912774*^9, 3.7316702578634233`*^9, 
   3.731671801243863*^9, 3.731671837910372*^9, 3.731801379234276*^9, 
   3.7318033520908823`*^9, 3.7318370271371183`*^9},
 CellLabel->"Out[20]=",ExpressionUUID->"a0eb4184-c32a-487d-a58d-6da7ae881ae8"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Moore-Penrose PseudoInverse", "Subsection",
 CellChangeTimes->{{3.729181426526401*^9, 
  3.729181437678577*^9}},ExpressionUUID->"2ff6d613-8b0c-4933-8790-\
78acf6a0ec5e"],

Cell[TextData[{
 "The matrix ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "A"}], ")"}], 
     RowBox[{"-", "1"}]], "\[CenterDot]", 
    RowBox[{"A", "\[Transpose]"}]}], TraditionalForm]],ExpressionUUID->
  "04ef20b8-51b5-460f-b822-21c6e642d720"],
 " is the ",
 StyleBox["Moore-Penrose left pseudoinverse",
  FontSlant->"Italic"],
 ". Wolfram has a built-in for it. We get exactly the same answer as above:"
}], "Text",
 CellChangeTimes->{{3.727433101666657*^9, 3.727433150009388*^9}, {
  3.7280917743950377`*^9, 
  3.728091785282933*^9}},ExpressionUUID->"e17fdc0c-7b6b-46f1-bcac-\
cdcca86ed4bc"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
   StyleBox["PseudoInverse",
    Background->RGBColor[0.87, 0.94, 1]], "[", "partials", "]"}], ".", 
  "data"}]], "Input",
 CellChangeTimes->{{3.7273712853724957`*^9, 3.727371293874542*^9}},
 CellLabel->"In[21]:=",ExpressionUUID->"06613afb-3b7f-49b3-b605-2e19ad87234f"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"0.5377933922887304`", ",", 
   RowBox[{"-", "0.3178014431180447`"}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.7273712944857807`*^9, 3.727379374585855*^9, 3.7273796194663477`*^9, 
   3.727382952487862*^9, 3.7274396355559683`*^9, 3.727442992319318*^9, 
   3.727443422251007*^9, 3.7274434529627523`*^9, 3.7274445876951447`*^9, 
   3.727444680417789*^9, 3.7274455722476873`*^9, 3.727446246720119*^9, 
   3.72744640647122*^9, 3.727446838471692*^9, {3.727446885072898*^9, 
   3.727447072503195*^9}, 3.727447292697041*^9, 3.7274473494713697`*^9, 
   3.727447838830246*^9, 3.7274499040967627`*^9, 3.727450180082849*^9, 
   3.727454844964015*^9, 3.727455079266862*^9, 3.727455974717*^9, {
   3.727456142338996*^9, 3.727456186421357*^9}, 3.7274568268760567`*^9, 
   3.727457103548245*^9, 3.7274626012243567`*^9, 3.727472137829957*^9, 
   3.7274855111041203`*^9, 3.7274863085745363`*^9, 3.727878578191661*^9, 
   3.727880787262898*^9, 3.7278811877447987`*^9, 3.7278813674336567`*^9, 
   3.727915385085929*^9, 3.7279180365110283`*^9, 3.7279180943317223`*^9, 
   3.727924197609661*^9, {3.727927706685451*^9, 3.727927731906424*^9}, 
   3.7279678100965147`*^9, 3.727968733006201*^9, 3.727969808022567*^9, 
   3.727969954920972*^9, 3.728044351520423*^9, 3.7280464475530863`*^9, 
   3.72806646947083*^9, 3.7280681206141787`*^9, 3.728083783213682*^9, 
   3.728090741206085*^9, 3.7281694449283533`*^9, 3.72816954049078*^9, 
   3.728169822646145*^9, 3.7281698826713457`*^9, 3.728252955169929*^9, 
   3.728946255597731*^9, 3.729022899770589*^9, {3.729119978187595*^9, 
   3.7291199952927637`*^9}, 3.729121071744602*^9, 3.729121110282917*^9, 
   3.729172307089141*^9, 3.72917569014242*^9, 3.729175758767949*^9, 
   3.7291834118647947`*^9, {3.729183447136406*^9, 3.729183460090003*^9}, 
   3.7292559365559196`*^9, 3.729552300842052*^9, 3.729557875298991*^9, 
   3.7296298371310453`*^9, 3.7296346349947653`*^9, 3.729642871293008*^9, 
   3.729642907867766*^9, 3.729643937910441*^9, 3.729647184209032*^9, 
   3.729683201016131*^9, 3.729778153456196*^9, 3.729779231587756*^9, 
   3.7297792795058413`*^9, 3.7315255844386663`*^9, 3.731527814452662*^9, 
   3.731582992979712*^9, 3.731670257893465*^9, 3.731671801310679*^9, 
   3.731671837944116*^9, 3.731801387768558*^9, 3.7318033521424294`*^9, 
   3.73183702719459*^9},
 CellLabel->"Out[21]=",ExpressionUUID->"790b9497-fb5a-4b2b-a93c-5a71c49df922"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Avoiding Inversion", "Subsection",
 CellChangeTimes->{{3.7291814457025623`*^9, 
  3.729181460660458*^9}},ExpressionUUID->"68070156-b8f5-4f5d-a4c3-\
925e43fdf042"],

Cell[TextData[{
 "Avoid the inverse via ",
 Cell[BoxData[
  FormBox["LinearSolve", TraditionalForm]], "Code",ExpressionUUID->
  "37533133-5282-4799-abf2-0ebc04a81068"],
 ". We have more to say about avoiding inverses below."
}], "Text",
 CellChangeTimes->{{3.729163192693755*^9, 3.729163205069344*^9}, {
  3.729163249751759*^9, 3.729163251892954*^9}, {3.729181463137731*^9, 
  3.7291814787717247`*^9}},ExpressionUUID->"559740ea-7cb1-4970-ad69-\
ec06a4bf828a"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"LinearSolve", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"partials", "\[Transpose]"}], ".", "partials"}], ",", 
    RowBox[{"partials", "\[Transpose]"}]}], "]"}], ".", "data"}]], "Input",
 CellChangeTimes->{{3.7291632280602016`*^9, 3.72916324189844*^9}},
 CellLabel->"In[22]:=",ExpressionUUID->"5e10efde-95ce-4c1d-bf2d-6e19aa756c02"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"0.5377933922887306`", ",", 
   RowBox[{"-", "0.3178014431180448`"}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.729163242164153*^9, 3.729172307155374*^9, 3.729175690191784*^9, 
   3.729175760404626*^9, 3.729183411932454*^9, {3.729183447202159*^9, 
   3.7291834601576347`*^9}, 3.729255936622262*^9, 3.729552300896743*^9, 
   3.729557875348524*^9, 3.729629837180914*^9, 3.7296346350478573`*^9, 
   3.729642871344585*^9, 3.7296429079352827`*^9, 3.729643937976184*^9, 
   3.729647184259219*^9, 3.729683201066106*^9, 3.7297781535055656`*^9, 
   3.7297792316516247`*^9, 3.729779279556422*^9, 3.731525584489263*^9, 
   3.731527814520081*^9, 3.731582993046843*^9, 3.731670257927182*^9, 
   3.731671801359992*^9, 3.7316718379784803`*^9, 3.731801399301709*^9, 
   3.731803352192768*^9, 3.731837027244701*^9},
 CellLabel->"Out[22]=",ExpressionUUID->"f5ed7055-d859-4b44-9718-d614b99803ab"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Don\[CloseCurlyQuote]t Use the Normal Equations", "Subsection",
 CellChangeTimes->{{3.729023046617814*^9, 
  3.729023056448161*^9}},ExpressionUUID->"bc33d2c7-2d46-4ea7-a314-\
ca4d8b6355b9"],

Cell[TextData[{
 Cell[BoxData[
  FormBox[
   RowBox[{
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "A"}], ")"}], 
     RowBox[{"-", "1"}]], "\[CenterDot]", 
    RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "\[CapitalZeta]"}], 
   TraditionalForm]],ExpressionUUID->"d629675c-f1af-4371-900e-61ae690a0095"],
 " is a nasty computation: in memory usage (big matrices), in time (matrix \
multiplication), and in numerical risk (inverse). How to avoid these hazards? \
Find a recurrence relation."
}], "Text",
 CellChangeTimes->{{3.727472215578988*^9, 3.727472331662753*^9}, {
   3.727472374436943*^9, 3.727472378052897*^9}, {3.727475400731699*^9, 
   3.727475478400813*^9}, {3.727486165404456*^9, 3.727486166210432*^9}, {
   3.7278779774894447`*^9, 3.7278779789823847`*^9}, {3.7279659504745617`*^9, 
   3.7279659782582006`*^9}, {3.729023065666107*^9, 3.7290230711752653`*^9}, 
   3.7291631748405437`*^9, {3.729181515226803*^9, 3.729181589797641*^9}, {
   3.729643138837819*^9, 3.729643155547853*^9}, {3.7297967431907587`*^9, 
   3.729796744103146*^9}},ExpressionUUID->"9094bcb8-aac9-4711-af2f-\
db10bec4f3de"]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Recurrence", "Chapter",
 CellChangeTimes->{{3.7270402093685093`*^9, 3.727040216990353*^9}, {
  3.72744887906024*^9, 3.727448879173937*^9}},
 CellTags->"c:9",ExpressionUUID->"f7c0e206-7d74-4627-a983-340eb9a5954e"],

Cell[TextData[{
 Cell[BoxData[
  FormBox["Fold", TraditionalForm]], "Code",ExpressionUUID->
  "9d09a6fc-b121-455e-a488-8b5ba33270cc"],
 " this recurrence over ",
 Cell[BoxData[
  FormBox["\[CapitalZeta]", TraditionalForm]],ExpressionUUID->
  "604c3712-17a2-49f9-be34-dd3b93db078a"],
 " and ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "cf261e04-8ab6-46fc-8bda-0e7b27452129"],
 ":"
}], "Text",
 CellChangeTimes->{{3.7274333353229113`*^9, 3.727433378179881*^9}, {
  3.7274334464649353`*^9, 3.727433551754867*^9}, {3.727433834133542*^9, 
  3.727433857990193*^9}, {3.7274406408677483`*^9, 3.727440686530654*^9}, {
  3.7274413441593647`*^9, 3.7274413518281183`*^9}, {3.727472397267685*^9, 
  3.727472404763022*^9}, {3.727475498217351*^9, 3.727475507311516*^9}, {
  3.728949021675457*^9, 3.728949025315466*^9}, {3.7296432127240763`*^9, 
  3.729643225187282*^9}},ExpressionUUID->"0f205045-666c-467b-8341-\
2d65449ef1f1"],

Cell[BoxData[{
 FormBox[
  RowBox[{"\[Xi]", "\[LeftArrow]", 
   RowBox[{
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{"\[CapitalLambda]", "+", 
       RowBox[{
        RowBox[{"a", "\[Transpose]"}], "\[CenterDot]", "a"}]}], ")"}], 
     RowBox[{"-", "1"}]], "\[CenterDot]", 
    RowBox[{"(", 
     RowBox[{
      RowBox[{
       RowBox[{"a", "\[Transpose]"}], "\[CenterDot]", "\[Zeta]"}], "+", 
      RowBox[{"\[CapitalLambda]", "\[CenterDot]", "\[Xi]"}]}], ")"}]}]}], 
  TraditionalForm], "\[IndentingNewLine]", 
 FormBox[
  RowBox[{"\[CapitalLambda]", "\[LeftArrow]", 
   RowBox[{"(", 
    RowBox[{"\[CapitalLambda]", "+", 
     RowBox[{
      RowBox[{"a", "\[Transpose]"}], "\[CenterDot]", "a"}]}], ")"}]}], 
  TraditionalForm]}], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.7274335859903107`*^9, 3.727433717944153*^9}, {
  3.727435926163211*^9, 3.7274359787146387`*^9}, {3.7274435816067543`*^9, 
  3.7274435995641823`*^9}, {3.727443898455867*^9, 3.727443902554981*^9}, {
  3.7289483265782537`*^9, 
  3.728948362573649*^9}},ExpressionUUID->"60ecaaeb-3b39-467a-9960-\
75dccfc81a5b"],

Cell["where", "Text",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.7274743397668333`*^9}, {3.727475519390863*^9, 3.727475555533572*^9}, {
   3.728948365542074*^9, 3.728948365542119*^9}, 3.728948905148108*^9, {
   3.728948947025461*^9, 3.728948959432898*^9}, {3.729163268464349*^9, 
   3.729163279091194*^9}},ExpressionUUID->"05908300-c5e1-4295-8faf-\
8c5c1deee5ed"],

Cell[CellGroupData[{

Cell[TextData[{
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],ExpressionUUID->
  "ca15d208-e524-41c0-86fa-973d1991e372"],
 " is the current estimate of ",
 Cell[BoxData[
  FormBox["\[CapitalXi]", TraditionalForm]],ExpressionUUID->
  "7e9f4450-1588-4d24-a011-c32f0e00a6ac"]
}], "Item",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.7274743397668333`*^9}, {3.727475519390863*^9, 3.727475555533572*^9}, {
   3.728948365542074*^9, 3.728948365542119*^9}, 3.728948905148108*^9, {
   3.728948947025461*^9, 3.728948959432898*^9}, {3.729163268464349*^9, 
   3.7291632861423903`*^9}},ExpressionUUID->"a370fb9a-10f0-4f59-807e-\
c414b3d01f79"],

Cell[TextData[{
 Cell[BoxData[
  FormBox["a", TraditionalForm]],ExpressionUUID->
  "a23b953c-cf49-41f8-8447-fbb397bff922"],
 " and ",
 Cell[BoxData[
  FormBox["\[Zeta]", TraditionalForm]],ExpressionUUID->
  "6d94e1b0-0bbb-42e2-906c-580263360fee"],
 " are matched rows of ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "9a4623dd-e230-41f2-9800-86cd6f5d5c72"],
 " and ",
 Cell[BoxData[
  FormBox["\[CapitalZeta]", TraditionalForm]],ExpressionUUID->
  "eb9de015-f9e0-4d0b-a5ef-5bef8a6f08fe"]
}], "Item",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.7274743397668333`*^9}, {3.727475519390863*^9, 3.727475555533572*^9}, {
   3.728948365542074*^9, 3.728948365542119*^9}, 3.728948905148108*^9, {
   3.728948947025461*^9, 3.728948959432898*^9}, {3.729163268464349*^9, 
   3.72916328446143*^9}},ExpressionUUID->"b7b431ff-ac19-4a02-91be-\
c1eeafd93b20"],

Cell[TextData[{
 Cell[BoxData[
  FormBox["\[CapitalLambda]", TraditionalForm]],ExpressionUUID->
  "40f23918-c675-4b98-8edb-bb01eadd40cd"],
 " accumulates ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "A"}], TraditionalForm]],
  ExpressionUUID->"dadb94d5-443c-474e-b745-213b7ceefa94"],
 ". "
}], "Item",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.7274743397668333`*^9}, {3.727475519390863*^9, 3.727475555533572*^9}, {
   3.728948365542074*^9, 3.728948365542119*^9}, 3.728948905148108*^9, {
   3.728948947025461*^9, 3.728948959432898*^9}, {3.729163268464349*^9, 
   3.729163280317943*^9}},ExpressionUUID->"55a754d6-6e23-4d10-96b6-\
2ec60d09bf0f"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Derivation Sketch", "Subsection",
 CellChangeTimes->{{3.729181602847373*^9, 
  3.7291816059298487`*^9}},ExpressionUUID->"1b451674-a32b-4a68-8fc0-\
63501280f112"],

Cell["\<\
Derive the recurrence as follows: Treat the estimate-so-far, \
\>", "Text",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.727474381777117*^9}, {3.7274744338469057`*^9, 3.727474441826235*^9}, {
   3.727474630428966*^9, 3.727474631651125*^9}, {3.727474814968113*^9, 
   3.7274748698817673`*^9}, {3.727475577962327*^9, 3.7274756335231857`*^9}, {
   3.7278780344572*^9, 3.727878045059162*^9}, 3.727966016823514*^9, {
   3.7279661542692223`*^9, 3.727966155428653*^9}, {3.727966432921638*^9, 
   3.7279665200041933`*^9}, {3.729163880807461*^9, 3.729163884901907*^9}, 
   3.7291816149796658`*^9},ExpressionUUID->"3d8412f1-baec-4559-9817-\
5f73a37328f9"],

Cell[BoxData[
 FormBox[
  RowBox[{
   SubscriptBox["\[Xi]", 
    RowBox[{"so", "-", "far"}]], 
   OverscriptBox["=", "def"], 
   RowBox[{
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "A"}], ")"}], 
     RowBox[{"-", "1"}]], "\[CenterDot]", 
    RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", 
    SubscriptBox["\[CapitalZeta]", 
     RowBox[{"so", "-", "far"}]]}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.727474381777117*^9}, {3.7274744338469057`*^9, 3.727474441826235*^9}, {
   3.727474630428966*^9, 3.727474631651125*^9}, {3.727474814968113*^9, 
   3.7274748698817673`*^9}, {3.727475577962327*^9, 3.7274756335231857`*^9}, {
   3.7278780344572*^9, 3.727878045059162*^9}, 3.727966016823514*^9, {
   3.7279661542692223`*^9, 3.727966155428653*^9}, {3.727966432921638*^9, 
   3.727966534440386*^9}, 3.728948369963612*^9, {3.729163903631165*^9, 
   3.7291639050399637`*^9}},ExpressionUUID->"049a87cf-3e93-4f73-a537-\
9755c620fece"],

Cell["as just one more observation with information matrix ", "Text",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.727474381777117*^9}, {3.7274744338469057`*^9, 3.727474441826235*^9}, {
   3.727474630428966*^9, 3.727474631651125*^9}, {3.727474814968113*^9, 
   3.7274748698817673`*^9}, {3.727475577962327*^9, 3.7274756335231857`*^9}, {
   3.7278780344572*^9, 3.727878045059162*^9}, 3.727966016823514*^9, {
   3.7279661542692223`*^9, 3.727966155428653*^9}, {3.727966432921638*^9, 
   3.7279665258422337`*^9}, {3.728091815451824*^9, 3.728091821154443*^9}, 
   3.729023129658637*^9, {3.729643258643651*^9, 
   3.729643268273799*^9}},ExpressionUUID->"9cf10725-469b-4b70-8cad-\
99e63f4accc4"],

Cell[BoxData[
 FormBox[
  RowBox[{"\[CapitalLambda]", "=", 
   RowBox[{
    RowBox[{
     SubscriptBox["A", 
      RowBox[{"so", "-", "far"}]], "\[Transpose]"}], "\[CenterDot]", 
    SubscriptBox["A", 
     RowBox[{"so", "-", "far"}]]}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.727474381777117*^9}, {3.7274744338469057`*^9, 3.727474441826235*^9}, {
   3.727474630428966*^9, 3.727474631651125*^9}, {3.727474814968113*^9, 
   3.7274748698817673`*^9}, {3.727475577962327*^9, 3.7274756335231857`*^9}, {
   3.7278780344572*^9, 3.727878045059162*^9}, 3.727966016823514*^9, {
   3.7279661542692223`*^9, 3.727966155428653*^9}, {3.727966432921638*^9, 
   3.7279665258422337`*^9}, {3.728091815451824*^9, 3.728091821154443*^9}, {
   3.729023134641241*^9, 
   3.729023151157517*^9}},ExpressionUUID->"6f4a34cf-6a11-49f5-b834-\
bc228fcdcabf"],

Cell[TextData[{
 "The scalar ",
 StyleBox["performance",
  FontSlant->"Italic"],
 " or ",
 StyleBox["squared error",
  FontSlant->"Italic"],
 " of the known estimate, ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Xi]", 
    RowBox[{"so", "-", "far"}]], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "8662be2f-5f0e-4eb3-a25b-416a74fbe6a0"],
 ", is"
}], "Text",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.727474381777117*^9}, {3.7274744338469057`*^9, 3.727474441826235*^9}, {
   3.727474630428966*^9, 3.727474631651125*^9}, {3.727474814968113*^9, 
   3.7274748698817673`*^9}, {3.727475577962327*^9, 3.7274756335231857`*^9}, {
   3.7278780344572*^9, 3.727878045059162*^9}, 3.727966016823514*^9, {
   3.7279661542692223`*^9, 3.727966155428653*^9}, {3.727966432921638*^9, 
   3.7279665258422337`*^9}, {3.728091815451824*^9, 3.728091821154443*^9}, {
   3.731801438806159*^9, 
   3.73180146919384*^9}},ExpressionUUID->"eeff7d74-acd8-40b2-9a3c-\
62ffbb11d73b"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"J", "(", "\[Xi]", ")"}], "  ", "=", "  ", 
   RowBox[{
    RowBox[{
     RowBox[{
      RowBox[{"(", 
       RowBox[{
        SubscriptBox["\[CapitalZeta]", 
         RowBox[{"so", "-", "far"}]], "-", 
        RowBox[{
         SubscriptBox["A", 
          RowBox[{"so", "-", "far"}]], "\[CenterDot]", "\[Xi]"}]}], ")"}], 
      "\[Transpose]"}], "\[CenterDot]", 
     RowBox[{"(", 
      RowBox[{
       SubscriptBox["\[CapitalZeta]", 
        RowBox[{"so", "-", "far"}]], "-", 
       RowBox[{
        SubscriptBox["A", 
         RowBox[{"so", "-", "far"}]], "\[CenterDot]", "\[Xi]"}]}], ")"}]}], 
    "  ", "=", "  ", 
    RowBox[{
     RowBox[{
      RowBox[{"(", 
       RowBox[{"\[Xi]", "-", 
        SubscriptBox["\[Xi]", 
         RowBox[{"so", "-", "far"}]]}], ")"}], "\[Transpose]"}], 
     "\[CenterDot]", "\[CapitalLambda]", "\[CenterDot]", 
     RowBox[{"(", 
      RowBox[{"\[Xi]", "-", 
       SubscriptBox["\[Xi]", 
        RowBox[{"so", "-", "far"}]]}], ")"}]}]}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.727474381777117*^9}, {3.7274744338469057`*^9, 3.727474441826235*^9}, {
   3.727474630428966*^9, 3.727474631651125*^9}, {3.727474814968113*^9, 
   3.7274748698817673`*^9}, {3.727475577962327*^9, 3.7274756335231857`*^9}, {
   3.7278780344572*^9, 3.727878045059162*^9}, {3.727966018203845*^9, 
   3.727966033785829*^9}, {3.727966098475103*^9, 3.7279661060884457`*^9}, {
   3.727966143206888*^9, 3.727966171156918*^9}, {3.7279662043636503`*^9, 
   3.727966213619438*^9}, {3.727966500313883*^9, 3.727966508975876*^9}, {
   3.7289483740986834`*^9, 3.728948376110648*^9}, {3.729023185419231*^9, 
   3.729023197425653*^9}},ExpressionUUID->"28e27674-dc73-48b5-a111-\
4a3c918e786b"],

Cell[TextData[{
 "where ",
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],ExpressionUUID->
  "dabda0f9-23ef-422e-9934-9019237efd52"],
 " is the unknown true parameter vector, ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[CapitalZeta]", 
    RowBox[{"so", "-", "far"}]], TraditionalForm]],ExpressionUUID->
  "684f54e2-bac0-42af-ad38-c1084a76ae15"],
 " is the (known, concrete) column vector of all observations so-far, and ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalLambda]", "=", 
    RowBox[{
     RowBox[{
      SubscriptBox["A", 
       RowBox[{"so", "-", "far"}]], "\[Transpose]"}], "\[CenterDot]", 
     SubscriptBox["A", 
      RowBox[{"so", "-", "far"}]]}]}], TraditionalForm]],ExpressionUUID->
  "88dc0af1-fc18-4f07-8ec8-6c0cef0ffb99"],
 ". Adding a new observation, ",
 Cell[BoxData[
  FormBox["\[Zeta]", TraditionalForm]],ExpressionUUID->
  "f1276f71-b142-463f-9ad8-441cb4641cde"],
 " and its corresponding partial row covector ",
 Cell[BoxData[
  FormBox["a", TraditionalForm]],ExpressionUUID->
  "53497380-bd47-4d43-9f90-bf6637131b87"],
 ", increases the error ",
 Cell[BoxData[
  FormBox[
   RowBox[{"J", "(", "\[Xi]", ")"}], TraditionalForm]],ExpressionUUID->
  "f0d40762-7e96-4647-bdc6-37929527ce7b"],
 " by ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     RowBox[{"(", 
      RowBox[{"\[Zeta]", "-", 
       RowBox[{"a", "\[CenterDot]", "\[Xi]"}]}], ")"}], "\[Transpose]"}], 
    "\[CenterDot]", 
    RowBox[{"(", 
     RowBox[{"\[Zeta]", "-", 
      RowBox[{"a", "\[CenterDot]", "\[Xi]"}]}], ")"}]}], TraditionalForm]],
  ExpressionUUID->"9ec14d68-822d-4fce-a2c9-85c5fb353fe0"],
 ". Minimize the new total error with respect to ",
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],ExpressionUUID->
  "96d4bc3a-53e7-428b-90b0-341c7f7145b3"],
 " to find the recurrence (exercise; hint: set the derivative of ",
 Cell[BoxData[
  FormBox["J", TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "6c2dda8c-e871-4beb-888c-09d9f34a5642"],
 " with respect to ",
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "313b7634-bbe2-4d5a-87af-81fbb0692b0a"],
 " to zero and solve the resulting system symbolically). \[FilledSquare]\n\n\
We see that RLS perforce introduces an a-priori estimate ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Xi]", "0"], TraditionalForm]],ExpressionUUID->
  "a3077632-64d2-4dd3-97b2-78d84dfbc138"],
 " and its covariance, which is the inverse of the information matrix ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[CapitalLambda]", "0"], TraditionalForm]],ExpressionUUID->
  "09ea8b7f-b9f9-4c6c-bfbc-41c5d12b2f3e"],
 ". RLS is Bayesian by construction. We show below that, when renormalized \
with an a-priori covariance for the observations ",
 Cell[BoxData[
  FormBox["\[Zeta]", TraditionalForm]],ExpressionUUID->
  "27be3aff-c6a3-47ce-bd0d-45ac2c3f778a"],
 ", the recurrence relation in equation 3 is theoretically equivalent to KAL \
and numerically equivalent to MAP. Proof of theoretical equivalence to MAP \
awaits future work."
}], "Text",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.7274743159268417`*^9, 
   3.727474381777117*^9}, {3.7274744338469057`*^9, 3.727474441826235*^9}, {
   3.727474630428966*^9, 3.727474631651125*^9}, {3.727474814968113*^9, 
   3.7274748698817673`*^9}, {3.727475577962327*^9, 3.7274756335231857`*^9}, {
   3.7278780344572*^9, 3.727878045059162*^9}, {3.727966018203845*^9, 
   3.727966022744957*^9}, {3.727966060652214*^9, 3.7279660814388037`*^9}, {
   3.727966122293776*^9, 3.727966131387149*^9}, {3.727966225308963*^9, 
   3.7279663153865147`*^9}, {3.72796657797972*^9, 3.7279665841676197`*^9}, {
   3.7290232013137093`*^9, 3.7290232220612392`*^9}, {3.729023260685502*^9, 
   3.729023282116056*^9}, 3.729119179347542*^9, {3.729163926938323*^9, 
   3.729163937969397*^9}, {3.729796790646969*^9, 3.72979688978856*^9}, {
   3.729796948582293*^9, 3.7297970605133133`*^9}, 3.731676238838593*^9, {
   3.731801484126436*^9, 3.731801565561491*^9}, {3.731801595940607*^9, 
   3.731801614273982*^9}},ExpressionUUID->"9845ca25-86c3-4f4a-850b-\
75e20bbba84f"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Numerical Demonstration", "Subsection",
 CellChangeTimes->{{3.729181632544861*^9, 
  3.7291816365144157`*^9}},ExpressionUUID->"52abf8d8-f1cf-4628-8ed0-\
a072dfee45a0"],

Cell[TextData[{
 "Bootstrap the recurrence with ad-hoc, a-priori values ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubscriptBox["\[Xi]", "0"], "=", 
    RowBox[{
     RowBox[{"(", GridBox[{
        {"0", "0"}
       }], ")"}], "\[Transpose]"}]}], TraditionalForm]],ExpressionUUID->
  "95c478f8-14cb-4c33-8055-6e0a24add5df"],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubscriptBox["\[CapitalLambda]", "0"], "=", 
    RowBox[{"(", 
     RowBox[{
      RowBox[{"(", GridBox[{
         {
          SuperscriptBox["10", 
           RowBox[{"-", "6"}]], "0"}
        }], ")"}], 
      RowBox[{"(", GridBox[{
         {"0", 
          SuperscriptBox["10", 
           RowBox[{"-", "6"}]]}
        }], ")"}]}], ")"}]}], TraditionalForm]],ExpressionUUID->
  "e79d365d-7771-4fa6-b690-5108edb5e668"],
 ". "
}], "Text",
 CellChangeTimes->{{3.727433690566415*^9, 3.727433691990076*^9}, {
   3.727433722702998*^9, 3.727433752037438*^9}, {3.727433801728943*^9, 
   3.727433813439355*^9}, {3.727435879529455*^9, 3.727435920139254*^9}, {
   3.7274395624863253`*^9, 3.72743960583661*^9}, {3.727439679294853*^9, 
   3.727439942216538*^9}, {3.727440429170088*^9, 3.727440449936098*^9}, {
   3.727440693988052*^9, 3.727440706787099*^9}, {3.727442440538804*^9, 
   3.7274424436438828`*^9}, {3.727443225488162*^9, 3.727443283700737*^9}, {
   3.727443629007498*^9, 3.727443630821762*^9}, {3.727445076605159*^9, 
   3.7274450788697367`*^9}, {3.727454527614051*^9, 3.727454553816103*^9}, {
   3.7274545955114317`*^9, 3.727454595511548*^9}, {3.7274546866285877`*^9, 
   3.727454763133893*^9}, {3.727455239597176*^9, 3.727455255845674*^9}, {
   3.7274553253206472`*^9, 3.727455326184396*^9}, 3.727455653598051*^9, {
   3.727472422563363*^9, 3.7274724518468323`*^9}, {3.727475653063583*^9, 
   3.727475668421556*^9}, {3.727878056292527*^9, 3.7278781337625647`*^9}, {
   3.727966321732579*^9, 3.727966322440028*^9}, {3.727966591137054*^9, 
   3.727966628253271*^9}, {3.727966659401678*^9, 3.7279667699874363`*^9}, {
   3.728091848600717*^9, 3.728091848856659*^9}, {3.7289483786020403`*^9, 
   3.728948380301387*^9}, {3.729163955385151*^9, 3.729163980174839*^9}, {
   3.729643297812354*^9, 3.729643332107801*^9}, {3.7297970766391563`*^9, 
   3.7297970790208406`*^9}},ExpressionUUID->"241702ba-d389-4dde-a4d5-\
c59d9b478c61"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "update", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"update", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\[Xi]_", ",", "\[CapitalLambda]_"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"\[Zeta]_", ",", "a_"}], "}"}]}], "]"}], ":=", 
    "\[IndentingNewLine]", 
    RowBox[{"With", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\[CapitalPi]", "=", 
        RowBox[{"(", 
         RowBox[{"\[CapitalLambda]", "+", 
          RowBox[{
           RowBox[{"a", "\[Transpose]"}], ".", "a"}]}], ")"}]}], "}"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{
         RowBox[{"Inverse", "[", "\[CapitalPi]", "]"}], ".", 
         RowBox[{"(", 
          RowBox[{
           RowBox[{
            RowBox[{"a", "\[Transpose]"}], ".", "\[Zeta]"}], "+", " ", 
           RowBox[{"\[CapitalLambda]", ".", "\[Xi]"}]}], ")"}]}], ",", 
        "\[CapitalPi]"}], "}"}]}], "]"}]}], ";"}], 
  "\[IndentingNewLine]"}], "\n", 
 RowBox[{"MatrixForm", "/@", "\[IndentingNewLine]", 
  RowBox[{"(", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"(", GridBox[{
         {"mBar"},
         {"bBar"}
        }], ")"}], ",", "\[CapitalPi]"}], "}"}], "=", "\[IndentingNewLine]", 
    RowBox[{
     StyleBox["Fold",
      Background->RGBColor[1, 1, 0]], "[", 
     RowBox[{"update", ",", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"(", GridBox[{
           {"0"},
           {"0"}
          }], ")"}], ",", 
        RowBox[{"(", GridBox[{
           {"1.0*^-6", "0"},
           {"0", "1.0*^-6"}
          }], ")"}]}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{
          StyleBox["List",
           Background->RGBColor[1, 1, 0]], "/@", "data"}], ",", 
         RowBox[{
          StyleBox["List",
           Background->RGBColor[1, 1, 0]], "/@", "partials"}]}], "}"}], 
       "\[Transpose]"}]}], "]"}]}], ")"}]}]}], "Input",
 CellChangeTimes->{{3.727054852495049*^9, 3.72705494257406*^9}, {
   3.727055026792467*^9, 3.727055093506559*^9}, {3.7270551930291023`*^9, 
   3.727055263833913*^9}, {3.727055297216107*^9, 3.7270554270906563`*^9}, {
   3.7270560338846903`*^9, 3.72705612788085*^9}, {3.7270561855129213`*^9, 
   3.7270561959544077`*^9}, {3.727056250031129*^9, 3.727056367103942*^9}, {
   3.727056427865035*^9, 3.727056443080068*^9}, {3.727056561323501*^9, 
   3.727056598046468*^9}, {3.727056640141169*^9, 3.727056654582451*^9}, {
   3.727056728700244*^9, 3.7270567914565277`*^9}, {3.727056869366274*^9, 
   3.727056921039433*^9}, 3.72705709924362*^9, {3.727057420502048*^9, 
   3.7270575464285316`*^9}, {3.7270577446377487`*^9, 3.727057775909028*^9}, {
   3.7270578799866133`*^9, 3.727057901007744*^9}, 3.7270581603330593`*^9, {
   3.727058349930079*^9, 3.7270584478842707`*^9}, {3.727058490337566*^9, 
   3.727058577824399*^9}, {3.727058673744141*^9, 3.7270586947547493`*^9}, {
   3.727058788099071*^9, 3.7270588909590683`*^9}, {3.727058934322414*^9, 
   3.7270589393580847`*^9}, {3.72705898616982*^9, 3.7270589868650723`*^9}, {
   3.7270592331231947`*^9, 3.727059237300102*^9}, {3.7274435231168203`*^9, 
   3.727443546500602*^9}, {3.727443876120749*^9, 3.7274438848810577`*^9}, {
   3.727444759010458*^9, 3.727444822403467*^9}, {3.727444904584729*^9, 
   3.727444917600658*^9}, {3.727444951170147*^9, 3.72744495624857*^9}, {
   3.727455276322372*^9, 3.7274553027713842`*^9}, {3.727455828581184*^9, 
   3.727455858661305*^9}, {3.7274561810931997`*^9, 3.727456183162497*^9}, {
   3.727472496770452*^9, 3.727472540592374*^9}, {3.727472571262414*^9, 
   3.7274725926081057`*^9}, {3.727473460371025*^9, 3.727473470385874*^9}, {
   3.727967024755598*^9, 3.7279670373987417`*^9}, 3.727967235445434*^9, {
   3.728948393392125*^9, 3.728948394937408*^9}, {3.729174117188925*^9, 
   3.729174123668703*^9}},
 CellLabel->"In[23]:=",ExpressionUUID->"dbaf9a17-ac84-4ad7-a492-c93ee24a7a98"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"0.5377933869868411`"},
       {
        RowBox[{"-", "0.31780143514599035`"}]}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"280.35593320338984`", "119.`"},
       {"119.`", "119.000001`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]]}], "}"}]], "Output",
 CellChangeTimes->{{3.727472529149095*^9, 3.727472541371006*^9}, {
   3.727472582072073*^9, 3.727472596728858*^9}, 3.72747347227721*^9, 
   3.727485511156743*^9, 3.727486308620812*^9, 3.727878578245182*^9, 
   3.727880787316627*^9, 3.727881187795374*^9, 3.72788136748368*^9, 
   3.7279153851348257`*^9, 3.727918036577284*^9, 3.7279180943800097`*^9, 
   3.727924197677032*^9, {3.727927706752205*^9, 3.727927731973207*^9}, 
   3.727967810149074*^9, 3.7279687330645437`*^9, 3.727969808085505*^9, 
   3.727969954973427*^9, 3.728044351569767*^9, 3.72804644760787*^9, 
   3.728066469525443*^9, 3.728068120668467*^9, 3.728083783280686*^9, 
   3.728090741272605*^9, 3.728169444994749*^9, 3.728169540556728*^9, 
   3.7281698227111*^9, 3.7281698827372704`*^9, 3.72825295523654*^9, 
   3.728946255665695*^9, 3.72902289982128*^9, {3.729119978255114*^9, 
   3.729119995360593*^9}, 3.7291210718114223`*^9, 3.729121110350542*^9, 
   3.7291723072225113`*^9, 3.729174119552033*^9, 3.729175690243061*^9, 
   3.729175768561432*^9, 3.729183411998878*^9, {3.729183447270482*^9, 
   3.7291834602232447`*^9}, 3.729255936689374*^9, 3.7295523012311068`*^9, 
   3.729557875800249*^9, 3.7296298378048058`*^9, 3.72963463574932*^9, 
   3.729642872038753*^9, 3.729642908638049*^9, 3.729643938027584*^9, 
   3.729647184308378*^9, 3.729683201116581*^9, 3.729778153560226*^9, 
   3.729779231717586*^9, 3.729779279623641*^9, 3.731525584537953*^9, 
   3.7315278145807533`*^9, 3.731582993113884*^9, 3.731670257955245*^9, 
   3.7316718014109707`*^9, 3.731671838013941*^9, 3.731801628343306*^9, 
   3.73180335224266*^9, 3.7318370272908278`*^9},
 CellLabel->"Out[25]=",ExpressionUUID->"24c6abb8-494a-4e33-9d7f-aac19e57213c"]
}, Open  ]],

Cell[TextData[{
 "The estimates ",
 Cell[BoxData[
  FormBox["mBar", TraditionalForm]], "Code",ExpressionUUID->
  "ace851a5-9f4d-49ce-a0fa-1ee094af68d5"],
 " and ",
 Cell[BoxData[
  FormBox["bBar", TraditionalForm]], "Code",ExpressionUUID->
  "1f76bfd3-e9db-47db-a0f3-738e5d40384b"],
 " are, numerically, the same as we got from Wolfram\[CloseCurlyQuote]s \
built-in. For this example, the choice of ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Xi]", "0"], TraditionalForm]],ExpressionUUID->
  "7a752cc3-5524-4727-98d1-99e9e3e3c2f9"],
 " and ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[CapitalLambda]", "0"], TraditionalForm]],ExpressionUUID->
  "1040a599-038c-43fc-961e-93c029f458cd"],
 " had negligible effect. "
}], "Text",
 CellChangeTimes->{{3.727455669635949*^9, 3.727455714844105*^9}, {
   3.727456293561727*^9, 3.727456338621636*^9}, {3.727456381984915*^9, 
   3.727456493199937*^9}, {3.7274567040936413`*^9, 3.727456704869124*^9}, {
   3.727456739701139*^9, 3.72745677855204*^9}, {3.727472821547103*^9, 
   3.727472872838442*^9}, {3.7279667472572412`*^9, 3.72796679667021*^9}, {
   3.72894839921102*^9, 3.728948399211062*^9}, {3.729181651280912*^9, 
   3.729181667411229*^9}, {3.729643345781581*^9, 3.729643368401565*^9}, 
   3.729797100393939*^9},ExpressionUUID->"c7441eff-d24d-462a-b81a-\
c02c0abdd45a"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Structural Notes", "Subsection",
 CellChangeTimes->{{3.729181678137927*^9, 
  3.729181681293388*^9}},ExpressionUUID->"009547f9-cdd9-4b41-b0ac-\
a45b3bd11079"],

Cell[TextData[{
 "The highlighted mappings of ",
 Cell[BoxData[
  FormBox["List", TraditionalForm]], "Code",ExpressionUUID->
  "370d0a8b-9c99-495c-8b0f-e38240d3f06a"],
 " over the data and partials convert them into column vectors. Wolfram \
built-ins and the normal equations, implicitly, treat one-dimensional lists \
as columns or rows as needed, then compute inner (dot) products as if the \
distinction did not matter. Python\[CloseCurlyQuote]s numpy has the same \
dubious feature. "
}], "Text",
 CellChangeTimes->{{3.727473114735071*^9, 3.727473196429072*^9}, 
   3.727475691841303*^9, {3.727879000591062*^9, 3.727879183230468*^9}, {
   3.727966817515026*^9, 3.727966992448154*^9}, {3.728091889609682*^9, 
   3.7280919220828123`*^9}, {3.729023350420405*^9, 3.729023392246647*^9}, {
   3.729119179359543*^9, 3.729119179371344*^9}, {3.7291640123507442`*^9, 
   3.7291640329396763`*^9}, {3.72916408829683*^9, 3.7291641046167603`*^9}, {
   3.729181694426371*^9, 3.729181705205323*^9}, {3.7318016732466793`*^9, 
   3.731801675437202*^9}},ExpressionUUID->"45bb6a3c-6183-46fa-bcdc-\
67faf162b472"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Memory and Time Efficiency", "Subsection",
 CellChangeTimes->{{3.729181722918578*^9, 
  3.7291817314071093`*^9}},ExpressionUUID->"aea5d153-88f7-4013-8a0f-\
80206ab9b05f"],

Cell[TextData[{
 "The required memory for the recurrence is ",
 Cell[BoxData[
  FormBox[
   RowBox[{"O", "(", "\[CapitalMu]", ")"}], TraditionalForm]],ExpressionUUID->
  "a43af123-6e23-4747-99f5-4541967c6079"],
 ", where ",
 Cell[BoxData[
  FormBox["\[CapitalMu]", TraditionalForm]],ExpressionUUID->
  "554653cf-ce3e-4f63-b5d1-49baddb2469f"],
 " is the order of the model, the number of parameters to estimate, the \
length of ",
 Cell[BoxData[
  FormBox["\[CapitalXi]", TraditionalForm]],ExpressionUUID->
  "5cad892a-a66c-4479-a419-39792c33e9e0"],
 ", and the length of each row of ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "332e127a-feaa-4be6-a475-985ccedc0886"],
 ". There is no dependency at all on the number ",
 Cell[BoxData[
  FormBox["\[CapitalNu]", TraditionalForm]],ExpressionUUID->
  "70e72b1a-0126-4373-80a0-6d790e7d6cc8"],
 " of data items. Also, the recurrence accumulates data one observation at a \
time, and is thus ",
 Cell[BoxData[
  FormBox[
   RowBox[{"O", "(", "\[CapitalNu]", ")"}], TraditionalForm]],ExpressionUUID->
  "efd7941a-b9ef-460b-abc5-d458205967fa"],
 " in time. Contrast with the normal equations, which multiply at ",
 Cell[BoxData[
  FormBox[
   RowBox[{"~", 
    RowBox[{"O", "(", 
     SuperscriptBox["\[CapitalNu]", 
      RowBox[{"\[ThinSpace]", "3"}]], ")"}]}], TraditionalForm]],
  ExpressionUUID->"d0c9ea26-5793-4a2e-88e5-b820100f9d13"],
 " and invert at ",
 Cell[BoxData[
  FormBox[
   RowBox[{"~", 
    RowBox[{"O", "(", 
     SuperscriptBox["\[CapitalMu]", 
      RowBox[{"\[ThinSpace]", "3"}]], ")"}]}], TraditionalForm]],
  ExpressionUUID->"e1c00670-04cc-4eda-87ab-028f1f89e82a"],
 ", i.e., at much greater time cost."
}], "Text",
 CellChangeTimes->{{3.727878157797224*^9, 3.72787827045693*^9}, {
  3.729023428386662*^9, 3.729023477424836*^9}, {3.729164123699872*^9, 
  3.729164253182089*^9}, {3.729181740696765*^9, 3.729181815543811*^9}, {
  3.72964339464333*^9, 3.729643452303581*^9}, {3.729797162651799*^9, 
  3.7297972726054*^9}, {3.731801717339837*^9, 
  3.731801731976182*^9}},ExpressionUUID->"208256bd-b9ea-4b31-b13d-\
16c94d398ac7"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Check the A-Priori", "Subsection",
 CellChangeTimes->{{3.729181823844157*^9, 
  3.729181830180563*^9}},ExpressionUUID->"d579222c-220c-48fb-943b-\
d078dfc110cf"],

Cell[TextData[{
 "The final value of ",
 Cell[BoxData[
  FormBox["\[CapitalLambda]", TraditionalForm]],ExpressionUUID->
  "39d494bd-234a-46ce-b910-d7f503d343eb"],
 " (called ",
 Cell[BoxData[
  FormBox["\[CapitalPi]", TraditionalForm]],ExpressionUUID->
  "8c23b7e5-b715-408b-91a1-2fb52b1f7699"],
 " in the code, a returned value), is ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     RowBox[{
      SubscriptBox["A", "full"], "\[Transpose]"}], "\[CenterDot]", 
     SubscriptBox["A", "full"]}], "+", 
    SubscriptBox["\[CapitalLambda]", "0"]}], TraditionalForm]],
  ExpressionUUID->"1891af79-d866-486f-a629-9b2b77a22d21"],
 ". To check the code, check that the difference between \[CapitalPi] and ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     SubscriptBox["A", "full"], "\[Transpose]"}], "\[CenterDot]", 
    SubscriptBox["A", "full"]}], TraditionalForm]],ExpressionUUID->
  "d79187f3-f0a0-4931-8c09-8a661166ccf3"],
 " is ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[CapitalLambda]", "0"], TraditionalForm]],ExpressionUUID->
  "c764f547-094a-4d7e-9887-56726f224d1b"],
 ":"
}], "Text",
 CellChangeTimes->{{3.727455669635949*^9, 3.727455714844105*^9}, {
  3.727456293561727*^9, 3.727456338621636*^9}, {3.727456381984915*^9, 
  3.727456493199937*^9}, {3.7274567040936413`*^9, 3.727456704869124*^9}, {
  3.727456739701139*^9, 3.72745677855204*^9}, {3.727472821547103*^9, 
  3.727472866769026*^9}, {3.72747570063941*^9, 3.72747570624365*^9}, {
  3.727486207037271*^9, 3.727486226047611*^9}, {3.727967052949963*^9, 
  3.727967092304611*^9}, {3.72902349359485*^9, 
  3.729023506985579*^9}},ExpressionUUID->"687c3b9e-097a-48df-bf2f-\
bb6be8805802"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"\[CapitalPi]", "-", 
  RowBox[{
   RowBox[{"partials", "\[Transpose]"}], ".", "partials"}]}]], "Input",
 CellChangeTimes->{{3.7274551709419003`*^9, 3.727455208922634*^9}, {
  3.727455747486219*^9, 3.727455758602953*^9}},
 CellLabel->"In[26]:=",ExpressionUUID->"bb0da3f3-13d8-45ee-82ab-26365a385f8b"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"9.999999974752427`*^-7", ",", "0.`"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"0.`", ",", "9.999999974752427`*^-7"}], "}"}]}], "}"}]], "Output",\

 CellChangeTimes->{{3.72745518631077*^9, 3.7274552106865807`*^9}, {
   3.7274552828550367`*^9, 3.727455294638937*^9}, 3.727455760140656*^9, {
   3.72745583557261*^9, 3.7274558626374598`*^9}, 3.727455974817852*^9, {
   3.7274561424375877`*^9, 3.7274561865312757`*^9}, 3.727456826962592*^9, 
   3.727457103648644*^9, 3.7274626013231*^9, 3.727472137933955*^9, 
   3.727485511219474*^9, 3.7274863086743803`*^9, 3.727878578292219*^9, 
   3.727880787367092*^9, 3.72788118784524*^9, 3.727881367533016*^9, 
   3.7279153851883383`*^9, 3.7279180366404953`*^9, 3.727918094433138*^9, 
   3.727924197744144*^9, {3.727927706819661*^9, 3.727927732038946*^9}, 
   3.727967810195277*^9, 3.7279687331233892`*^9, 3.7279698081358833`*^9, 
   3.727969955024419*^9, 3.728044351619812*^9, 3.7280464476574707`*^9, 
   3.728066469570793*^9, 3.7280681207187157`*^9, 3.728083783348742*^9, 
   3.728090741322768*^9, 3.728169445060842*^9, 3.728169540624917*^9, 
   3.7281698227788277`*^9, 3.728169882804495*^9, 3.728252955301944*^9, 
   3.728946255715186*^9, 3.729022899869521*^9, {3.729119978321847*^9, 
   3.7291199954270573`*^9}, 3.729121071878161*^9, 3.729121110417275*^9, 
   3.729172307287985*^9, 3.729175690293468*^9, 3.729175772153051*^9, 
   3.729183412064961*^9, {3.72918344733591*^9, 3.729183460290135*^9}, 
   3.7292559367593613`*^9, 3.729552301396994*^9, 3.729557875848024*^9, 
   3.7296298378646383`*^9, 3.7296346358091793`*^9, 3.729642872096381*^9, 
   3.7296429086974907`*^9, 3.729643938076329*^9, 3.7296471843588*^9, 
   3.7296832011663933`*^9, 3.7297781536275663`*^9, 3.7297792317673607`*^9, 
   3.729779279689464*^9, 3.731525584589945*^9, 3.731527814734982*^9, 
   3.7315829931801243`*^9, 3.7316702579953537`*^9, 3.731671801460478*^9, 
   3.7316718380476017`*^9, 3.731801745610325*^9, 3.731803352292261*^9, 
   3.731837027344488*^9},
 CellLabel->"Out[26]=",ExpressionUUID->"a6e8cbb0-f569-4ceb-a161-5224a5a74e35"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Covariance of the Estimate", "Subsection",
 CellChangeTimes->{{3.7291818416264057`*^9, 
  3.729181847224715*^9}},ExpressionUUID->"3abb11b6-0e3e-4659-bfff-\
b6e4ed93daa0"],

Cell[TextData[{
 "The covariance of this estimate ",
 Cell[BoxData[
  FormBox["\[CapitalXi]", TraditionalForm]],ExpressionUUID->
  "05f6e13c-eb2e-49b9-b7d4-f01f499237e6"],
 " is ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"(", 
     FractionBox[
      RowBox[{"n", "-", "1"}], 
      RowBox[{"n", "-", "2"}]], ")"}], "*", 
    RowBox[{"Variance", "\[ThinSpace]", "[", "\[ThinSpace]", 
     RowBox[{"\[CapitalZeta]", "-", 
      RowBox[{"A", "\[CenterDot]", "\[CapitalXi]"}]}], "\[ThinSpace]", "]"}], 
    "*", 
    SuperscriptBox["\[CapitalLambda]", 
     RowBox[{"-", "1"}]]}], TraditionalForm]],ExpressionUUID->
  "ed6dc5b0-2569-4482-a89f-9e45c1d9c8e7"],
 " except for a small contribution from the a-priori information ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[CapitalLambda]", "0"], TraditionalForm]],ExpressionUUID->
  "117837c1-2354-4d76-b779-38f2077da583"],
 ". The correction factor ",
 Cell[BoxData[
  FormBox[
   RowBox[{"(", 
    FractionBox[
     RowBox[{"n", "-", "1"}], 
     RowBox[{"n", "-", "2"}]], ")"}], TraditionalForm]],ExpressionUUID->
  "b55c017a-1015-4a56-951f-cf8b3a01de97"],
 " is a generalization \.7fof Bessel\[CloseCurlyQuote]s correction. The ",
 Cell[BoxData[
  FormBox["2", TraditionalForm]],ExpressionUUID->
  "b7c81e78-cd2f-451d-8792-9b212764ec84"],
 " in ",
 Cell[BoxData[
  FormBox[
   RowBox[{"(", 
    RowBox[{"n", "-", "2"}], ")"}], TraditionalForm]],ExpressionUUID->
  "d9f330f5-17bd-4ad7-b656-bdd5eb0f57d5"],
 " in the denominator of Bessel\[CloseCurlyQuote]s correction is the number \
of parameters being estimated, also called ",
 StyleBox["degrees of freedom",
  FontSlant->"Italic"],
 " (see ",
 ButtonBox["VAN DE GEER, Least Squares Estimation, Volume 2, pp. \
1041\[Dash]1045, in Encyclopedia of Statistics in Behavioral Science, Eds. \
Brian S. Everitt & David C. Howell, Wiley, 2005",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://stat.ethz.ch/~geer/bsa199_o.pdf"], None},
  ButtonNote->"https://stat.ethz.ch/~geer/bsa199_o.pdf"],
 "). The denominator of the correction, in general, is ",
 Cell[BoxData[
  FormBox[
   RowBox[{"n", "-", "p"}], TraditionalForm]],ExpressionUUID->
  "5b344576-2589-491a-bed2-c362a3e367e3"],
 ", where ",
 Cell[BoxData[
  FormBox["n", TraditionalForm]],ExpressionUUID->
  "ab45ec8c-fdab-4d50-a890-e44870c87fa3"],
 " is the number of data and ",
 Cell[BoxData[
  FormBox["p", TraditionalForm]],ExpressionUUID->
  "606cb52c-426a-44c2-baf8-3756d84116c8"],
 " is the number of parameters being estimated."
}], "Text",
 CellChangeTimes->{{3.7274567852393503`*^9, 3.727456791351314*^9}, {
  3.7274626311713448`*^9, 3.727462680678966*^9}, {3.727472647355248*^9, 
  3.727472725986993*^9}, {3.7274728947945757`*^9, 3.727472940968391*^9}, {
  3.727474911778737*^9, 3.727474913439685*^9}, {3.727475723944086*^9, 
  3.727475733135212*^9}, {3.7279249725397797`*^9, 3.727924984997408*^9}, {
  3.727967100099558*^9, 3.7279671039316263`*^9}, {3.7280919485134687`*^9, 
  3.728091949527707*^9}, {3.72916432284585*^9, 3.729164348695956*^9}, {
  3.729797302412488*^9, 3.729797317021042*^9}, {3.731677716708598*^9, 
  3.731677728619828*^9}},ExpressionUUID->"61d6dbe7-f587-4a2d-861d-\
5bd72462f329"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"Inverse", "[", 
    RowBox[{
     RowBox[{"partials", "\[Transpose]"}], ".", "partials"}], "]"}], "*", 
   FractionBox[
    RowBox[{"nData", "-", "1"}], 
    RowBox[{"nData", "-", "2"}]], "*", 
   RowBox[{"Variance", "[", 
    RowBox[{"data", "-", 
     RowBox[{"partials", ".", 
      RowBox[{"{", 
       RowBox[{"mBar", ",", "bBar"}], "}"}]}]}], "]"}]}], "//", 
  "MatrixForm"}]], "Input",
 CellChangeTimes->{{3.7274431897876062`*^9, 3.7274432610082397`*^9}, {
   3.7274547829132023`*^9, 3.7274548281175823`*^9}, {3.727454917043985*^9, 
   3.727454946560256*^9}, {3.727455103776779*^9, 3.727455133855278*^9}, {
   3.727455965944152*^9, 3.727455966694631*^9}, {3.7274560116101933`*^9, 
   3.727456093212741*^9}, 3.72745616117476*^9, {3.727456227849722*^9, 
   3.727456234387219*^9}, 3.727472952057025*^9},
 CellLabel->"In[27]:=",ExpressionUUID->"793b242f-6145-4465-9e12-baae777851b2"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"0.002566786537297206`", 
      RowBox[{"-", "0.0025667865372972064`"}]},
     {
      RowBox[{"-", "0.002566786537297206`"}], "0.00604717506244596`"}
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
 CellChangeTimes->{{3.727454928111648*^9, 3.72745494746028*^9}, 
   3.727455079366056*^9, {3.727455124455585*^9, 3.72745513496389*^9}, {
   3.727455812047991*^9, 3.727455864570829*^9}, {3.7274559677572517`*^9, 
   3.727455974867505*^9}, {3.727456050499832*^9, 3.727456094070848*^9}, {
   3.7274561424870367`*^9, 3.7274561865735826`*^9}, 3.727456239429667*^9, 
   3.7274568270134773`*^9, 3.727457103698028*^9, 3.7274626013731823`*^9, 
   3.727472137981408*^9, 3.727472954371911*^9, 3.727485511269794*^9, 
   3.7274863087240047`*^9, 3.727878578345954*^9, 3.7278807874127703`*^9, 
   3.7278811878958673`*^9, 3.727881367587798*^9, 3.72791538523671*^9, 
   3.727918036690276*^9, 3.7279180944824457`*^9, 3.727924197810088*^9, {
   3.727927706882574*^9, 3.727927732105157*^9}, 3.727967810245639*^9, 
   3.727968733172824*^9, 3.727969808184746*^9, 3.7279699550719757`*^9, 
   3.728044351669427*^9, 3.728046447707358*^9, 3.728066469624007*^9, 
   3.728068120768632*^9, 3.728083783416733*^9, 3.728090741371833*^9, 
   3.7281694451273947`*^9, 3.7281695406895*^9, 3.728169822844509*^9, 
   3.72816988287199*^9, 3.728252955370139*^9, 3.728946255764901*^9, 
   3.729022899921451*^9, {3.729119978388329*^9, 3.72911999549438*^9}, 
   3.729121071944837*^9, 3.729121110483716*^9, 3.7291723073551702`*^9, 
   3.7291756903603086`*^9, 3.72917577469937*^9, 3.729183412131897*^9, {
   3.729183447403452*^9, 3.729183460358261*^9}, 3.729255936823028*^9, 
   3.729552301456296*^9, 3.729557875898464*^9, 3.729629837913718*^9, 
   3.729634635859951*^9, 3.729642872142787*^9, 3.729642908767935*^9, 
   3.7296439381313267`*^9, 3.729647184407447*^9, 3.729683201217225*^9, 
   3.729778153693164*^9, 3.7297792318163977`*^9, 3.729779279861124*^9, 
   3.731525584653665*^9, 3.731527814799761*^9, 3.731582993247814*^9, 
   3.731670258043111*^9, 3.731671801509981*^9, 3.7316718380807533`*^9, 
   3.731801767113022*^9, 3.731803352342677*^9, 3.7318370273944607`*^9},
 CellLabel->
  "Out[27]//MatrixForm=",ExpressionUUID->"3aed2fca-61d9-470b-9887-\
b3a6ce17b934"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"cov$", "=", 
    RowBox[{
     RowBox[{"Inverse", "[", "\[CapitalPi]", "]"}], "*", 
     FractionBox[
      RowBox[{"nData", "-", "1"}], 
      RowBox[{"nData", "-", "2"}]], "*", 
     RowBox[{"Variance", "[", 
      RowBox[{"data", "-", 
       RowBox[{"partials", ".", 
        RowBox[{"{", 
         RowBox[{"mBar", ",", "bBar"}], "}"}]}]}], "]"}]}]}], ")"}], "//", 
  "MatrixForm"}]], "Input",
 CellChangeTimes->{{3.731678604096655*^9, 3.731678619237616*^9}, {
  3.731678690664836*^9, 3.7316786923669863`*^9}, {3.7316788615643167`*^9, 
  3.731678864441324*^9}},
 CellLabel->"In[28]:=",ExpressionUUID->"2d3810ad-710c-4b05-b9f7-2488b30acd79"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"0.002566786505481995`", 
      RowBox[{"-", "0.0025667864839123604`"}]},
     {
      RowBox[{"-", "0.0025667864839123604`"}], "0.006047174958244518`"}
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
 CellChangeTimes->{{3.7316786059796467`*^9, 3.731678619772847*^9}, 
   3.731678693591798*^9, 3.7316788648334312`*^9, 3.731748938943488*^9, 
   3.731801769030253*^9, 3.731803352393113*^9, 3.731837027520831*^9},
 CellLabel->
  "Out[28]//MatrixForm=",ExpressionUUID->"e6f377ca-44dc-408a-8637-\
e282960dea79"]
}, Open  ]],

Cell[TextData[{
 "(We use a naming convention of suffixed dollar signs for undisciplined, \
ad-hoc, global variables like ",
 Cell[BoxData[
  FormBox[
   StyleBox["cov$", "Input"], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "4b820263-66e8-4da8-8e5e-aa34f2d3c78b"],
 ". Such variables may be assigned and reassigned without care, so are not \
for permanent definitions. They are conveniences for intermediate \
calculations.)"
}], "Text",
 CellChangeTimes->{{3.731678705910927*^9, 3.731678801183219*^9}, {
  3.73167902763903*^9, 
  3.731679131916511*^9}},ExpressionUUID->"a65871fd-2b75-46b8-b0d4-\
3b8f6cf602d8"],

Cell[TextData[{
 "Except for the reversed order, this is the same covariance matrix that \
Wolfram\[CloseCurlyQuote]s ",
 Cell[BoxData[
  FormBox["LinearModel", TraditionalForm]], "Code",ExpressionUUID->
  "927b6594-6052-40b2-8ebb-205fa75a1b9c"],
 " reports:"
}], "Text",
 CellChangeTimes->{{3.727454999214408*^9, 3.7274550230616837`*^9}, {
  3.7274550552077837`*^9, 3.727455069630582*^9}, {3.727456815268976*^9, 
  3.72745682043734*^9}, {3.727462715836411*^9, 3.7274627328032312`*^9}, {
  3.7281214802053127`*^9, 
  3.72812148718871*^9}},ExpressionUUID->"8bce497b-a196-4551-ab1b-\
790b924da603"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"Reverse", "@", 
   RowBox[{"(", 
    RowBox[{"Reverse", "/@", 
     RowBox[{
      StyleBox["model",
       Background->RGBColor[1, 1, 0]], "[", "\"\<CovarianceMatrix\>\"", 
      "]"}]}], ")"}]}], "//", "MatrixForm"}]], "Input",
 CellChangeTimes->{{3.7274549491384163`*^9, 3.727454976961426*^9}, {
  3.727455029510784*^9, 3.727455047125711*^9}},
 CellLabel->"In[29]:=",ExpressionUUID->"cc83693c-dd45-4cb6-9a39-d3ca807546bd"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"0.0025667865372972047`", 
      RowBox[{"-", "0.0025667865372972047`"}]},
     {
      RowBox[{"-", "0.0025667865372972047`"}], "0.006047175062445957`"}
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
 CellChangeTimes->{{3.727454966848208*^9, 3.727454977604638*^9}, 
   3.727455048234387*^9, 3.7274550794174843`*^9, {3.727455816251672*^9, 
   3.727455842245935*^9}, 3.727455974915807*^9, {3.72745614253647*^9, 
   3.727456186624792*^9}, 3.727456827063628*^9, 3.727457103748019*^9, 
   3.727462601420088*^9, 3.727472138034376*^9, 3.727485511317802*^9, 
   3.7274863087704897`*^9, 3.727878578395075*^9, 3.727880787467642*^9, 
   3.727881187944561*^9, 3.727881367638068*^9, 3.7279153852886133`*^9, 
   3.727918036745358*^9, 3.727918094551241*^9, 3.727924197877178*^9, {
   3.727927706952642*^9, 3.727927732168346*^9}, 3.727967810295855*^9, 
   3.7279687332273684`*^9, 3.72796980823939*^9, 3.72796995512359*^9, 
   3.728044351719689*^9, 3.728046447758238*^9, 3.728066469672233*^9, 
   3.7280681208188887`*^9, 3.728083783480638*^9, 3.7280907414232063`*^9, 
   3.728169445193625*^9, 3.728169540756772*^9, 3.728169822911014*^9, 
   3.728169882937654*^9, 3.728252955435904*^9, 3.728946255816115*^9, 
   3.729022899969944*^9, {3.729119978456131*^9, 3.729119995560389*^9}, 
   3.729121072011354*^9, 3.729121110549224*^9, 3.729172307421925*^9, 
   3.7291756904081097`*^9, 3.729175777027215*^9, 3.729183412197935*^9, {
   3.7291834474691057`*^9, 3.7291834604242697`*^9}, 3.729255936889614*^9, 
   3.729552301510076*^9, 3.729557875948141*^9, 3.729629837964074*^9, 
   3.7296346359095287`*^9, 3.729642872193766*^9, 3.729642908831292*^9, 
   3.729643938195087*^9, 3.7296471844591093`*^9, 3.729683201266974*^9, 
   3.7297781538643713`*^9, 3.729779231867325*^9, 3.729779279921195*^9, 
   3.7315255847994823`*^9, 3.731527814870738*^9, 3.731582993400248*^9, 
   3.731670258078223*^9, 3.731671801560294*^9, 3.731671838128117*^9, 
   3.731801786714716*^9, 3.7318033524435463`*^9, 3.731837027576721*^9},
 CellLabel->
  "Out[29]//MatrixForm=",ExpressionUUID->"666dba50-fa79-4a35-9907-\
2943b983f97a"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Covariance of the Prediction", "Subsection",
 CellChangeTimes->{{3.731676271399749*^9, 
  3.7316762761986933`*^9}},ExpressionUUID->"94984d4e-1d6a-4942-926c-\
766c72826662"],

Cell[TextData[{
 "If the two parameters, ",
 Cell[BoxData[
  FormBox["m", TraditionalForm]],ExpressionUUID->
  "39acf361-c541-4c64-ae5a-a106bb592608"],
 " and ",
 Cell[BoxData[
  FormBox["b", TraditionalForm]],ExpressionUUID->
  "5a22f64d-c52e-4ce5-8e5c-2d913fee2283"],
 ", are viewed as random variables, then the predicted value ",
 Cell[BoxData[
  FormBox["z", TraditionalForm]],ExpressionUUID->
  "ffc73627-73bc-4e34-b483-38dc21f48a28"],
 " at every input point ",
 Cell[BoxData[
  FormBox["x", TraditionalForm]],ExpressionUUID->
  "6fb9a0b1-2aae-4eda-aebc-66dab6646985"],
 " is a linear combination of those random variables, and thus, a random \
variable with variance ",
 Cell[BoxData[
  FormBox[
   RowBox[{"(", 
    RowBox[{
     RowBox[{
      SuperscriptBox["x", "2"], 
      SubsuperscriptBox["\[Sigma]", "m", "2"]}], "+", 
     SubsuperscriptBox["\[Sigma]", "b", "2"], "+", 
     RowBox[{"E", "[", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"b", "-", 
         RowBox[{"E", "[", "b", "]"}]}], ")"}], 
       RowBox[{"(", 
        RowBox[{
         RowBox[{"m", " ", "x"}], "-", 
         RowBox[{"E", "[", 
          RowBox[{"m", " ", "x"}], "]"}]}], ")"}]}], "]"}]}], ")"}], 
   TraditionalForm]],ExpressionUUID->"a8299ea0-aeb1-4fd4-a33b-eccdacddb8e9"],
 " in the scalar case. The following shows the one-sigma band around the \
model in blue, ground truth in green. MAP adds an a-priori covariance of the \
observations, and we ",
 StyleBox["renormalize",
  FontSlant->"Italic"],
 " the recurrent form, below, to match covariance of the predictions to MAP \
exactly."
}], "Text",
 CellChangeTimes->{{3.731677780251335*^9, 3.731677856363761*^9}, {
  3.731678451523408*^9, 3.73167847086788*^9}, {3.731706841968087*^9, 
  3.7317069008472357`*^9}, {3.7317071094233923`*^9, 3.731707206370275*^9}, {
  3.731707263450365*^9, 3.7317072963600197`*^9}, {3.7317176283409567`*^9, 
  3.731717692031049*^9}, {3.7318018058209553`*^9, 
  3.731801925731496*^9}},ExpressionUUID->"81328d03-7318-4e5a-a4c0-\
ded6f7e01d3c"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Module", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
    "row", ",", "diagonalTerm", ",", "offDiagonalTerm", ",", 
     "\[CapitalSigma]"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"row", "[", "x_", "]"}], ":=", 
     RowBox[{"{", 
      RowBox[{"{", 
       RowBox[{"x", ",", "1."}], "}"}], "}"}]}], ";", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"diagonalTerm", "[", "x_", "]"}], ":=", 
     RowBox[{"Map", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"Dot", "[", 
         RowBox[{
          RowBox[{"Diagonal", "[", "cov$", "]"}], ",", "#"}], "]"}], "&"}], 
       ",", 
       RowBox[{
        RowBox[{
         SuperscriptBox["#", "2"], "&"}], "/@", 
        RowBox[{"row", "[", "x", "]"}]}]}], "]"}]}], ";", 
    "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"offDiagonalTerm", "[", "x_", "]"}], ":=", 
     RowBox[{"MapThread", "[", 
      RowBox[{"Dot", ",", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{
          RowBox[{"row", "[", "x", "]"}], ".", "cov$"}], ",", 
         RowBox[{"row", "[", "x", "]"}]}], "}"}]}], "]"}]}], ";", 
    "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"\[CapitalSigma]", "[", "x_", "]"}], ":=", 
     RowBox[{"Sqrt", "[", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{
         RowBox[{"row", "[", "x", "]"}], ".", "cov$", ".", 
         RowBox[{
          RowBox[{"row", "[", "x", "]"}], "\[Transpose]"}]}], ")"}], 
       "\[LeftDoubleBracket]", 
       RowBox[{"1", ",", "1"}], "\[RightDoubleBracket]"}], "]"}]}], ";", 
    "\[IndentingNewLine]", 
    RowBox[{"With", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"points", "=", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
           RowBox[{"partials", "\[LeftDoubleBracket]", 
            RowBox[{"All", ",", "1"}], "\[RightDoubleBracket]"}], ",", 
           "data"}], "}"}], "\[Transpose]"}]}], "}"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"Show", "[", 
       RowBox[{
        RowBox[{"ListPlot", "[", 
         RowBox[{"{", "points", "}"}], "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Plot", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{
             RowBox[{"m", " ", "x"}], "+", "b"}], ",", "\[IndentingNewLine]", 
            
            RowBox[{"model", "[", "x", "]"}], ",", "\[IndentingNewLine]", 
            RowBox[{
             RowBox[{"model", "[", "x", "]"}], "+", 
             RowBox[{"\[CapitalSigma]", "[", "x", "]"}]}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{
             RowBox[{"model", "[", "x", "]"}], "-", 
             RowBox[{"\[CapitalSigma]", "[", "x", "]"}]}]}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"x", ",", "min", ",", "max"}], "}"}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{"PlotStyle", "\[Rule]", 
           RowBox[{"{", "\[IndentingNewLine]", 
            RowBox[{"Green", ",", "Blue", ",", "\[IndentingNewLine]", 
             RowBox[{"{", 
              RowBox[{"Thin", ",", 
               RowBox[{"{", 
                RowBox[{
                 RowBox[{"Opacity", "[", "0", "]"}], ",", "Blue"}], "}"}]}], 
              "}"}], ",", "\[IndentingNewLine]", 
             RowBox[{"{", 
              RowBox[{"Thin", ",", 
               RowBox[{"{", 
                RowBox[{
                 RowBox[{"Opacity", "[", "0", "]"}], ",", "Blue"}], "}"}]}], 
              "}"}]}], "}"}]}], ",", "\[IndentingNewLine]", 
          RowBox[{"Filling", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"2", "\[Rule]", 
              RowBox[{"{", "3", "}"}]}], ",", 
             RowBox[{"2", "\[Rule]", 
              RowBox[{"{", "4", "}"}]}]}], "}"}]}]}], "]"}]}], "]"}]}], 
     "]"}]}]}], "]"}]], "Input",
 CellChangeTimes->{{3.7316795721040573`*^9, 3.731679613001815*^9}, {
   3.731679647500627*^9, 3.73167967929961*^9}, 3.731679753065332*^9, {
   3.731679956002748*^9, 3.73168009744453*^9}, {3.7316804510081053`*^9, 
   3.7316804968865*^9}, {3.731680532677692*^9, 3.731680673956003*^9}, {
   3.7316807275478354`*^9, 3.731680738316875*^9}, {3.7316807899714108`*^9, 
   3.731681060067861*^9}, {3.7317062465109873`*^9, 3.731706434441803*^9}, {
   3.7317064859042807`*^9, 3.731706494687858*^9}, {3.7317072342559347`*^9, 
   3.731707257117319*^9}, {3.7317073004957848`*^9, 3.73170730700956*^9}, {
   3.731717600150476*^9, 3.731717606259035*^9}, {3.731748663163302*^9, 
   3.731748761068933*^9}, {3.731748998813139*^9, 3.7317490473386087`*^9}, {
   3.731749161986907*^9, 3.731749193185526*^9}, {3.731749652734717*^9, 
   3.731749658044611*^9}},
 CellLabel->"In[30]:=",ExpressionUUID->"c20f3ee8-263d-44b5-9904-457f4a2e4d56"],

Cell[BoxData[
 GraphicsBox[{{{}, {{}, 
     {RGBColor[0.368417, 0.506779, 0.709798], PointSize[0.009166666666666668],
       AbsoluteThickness[1.6], PointBox[CompressedData["
1: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
vZk=
       "]]}, {}}, {}, {}, {}, {}}, {GraphicsComplexBox[CompressedData["
1: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
     
     "], {{{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, 
       {RGBColor[0, 0, 1], Opacity[0.2], EdgeForm[None], 
        GraphicsGroupBox[
         PolygonBox[{{78, 148, 142, 137, 133, 130, 128, 79, 80, 81, 82, 83, 
          84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
           101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 
          114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 
          149, 143, 138, 134, 131, 129, 150, 144, 139, 135, 132, 151, 145, 
          140, 136, 152, 146, 141, 153, 147, 154, 127, 204, 231, 224, 230, 
          218, 223, 229, 213, 217, 222, 228, 209, 212, 216, 221, 227, 206, 
          208, 211, 215, 220, 226, 203, 202, 201, 200, 199, 198, 197, 196, 
          195, 194, 193, 192, 191, 190, 189, 188, 187, 186, 185, 184, 183, 
          182, 181, 180, 179, 178, 177, 176, 175, 174, 173, 172, 171, 170, 
          169, 168, 167, 166, 165, 164, 163, 162, 161, 160, 159, 158, 157, 
          156, 205, 207, 210, 214, 219, 225, 155}}]]}, {}, {}, 
       {RGBColor[0, 0, 1], Opacity[0.2], EdgeForm[None], 
        GraphicsGroupBox[PolygonBox[CompressedData["
1:eJwt0Gc3FgAABeD3RaFFRjLCm5KVkN+hyGynnb2iMkMRipD0C6PQEBLynFMf
ng/33C/33FB9S0VzWCAQCPKJzxQKOWSRQRopLOmW+cJXVlhljW985wc/WecX
G2yyxW+2+cMOu+zxN/BvQJAwwongAAeJJIpoDnGYIxzlGDHEcpw44kkgkRMk
cZIL5HKGTE6RShF5nCVEOsXkk81pSijgHBc5TynJDPz/bpZFpnjPR8aYZIYF
RnjNBNN8YIhhXvGGd8zTTx+9vOA5z+ihm6d00UkH7bTRSgvNNNFIA094zCMe
8oD73OMu9dzhNre4yQ2uc42r1FFLDdVUUckVKijnMpcY5CWjjPOWOcrYBzXq
QZ8=
          "]]]}, {}, {}, {}, {}, {}, {}}, {{}, {}, {}, 
       TagBox[
        {RGBColor[0, 1, 0], AbsoluteThickness[1.6], Opacity[1.], 
         LineBox[{1, 71, 65, 60, 56, 53, 51, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
          12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 
          29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 
          46, 47, 48, 49, 72, 66, 61, 57, 54, 52, 73, 67, 62, 58, 55, 74, 68, 
          63, 59, 75, 69, 64, 76, 70, 77, 50}]},
        Annotation[#, "Charting`Private`Tag$2713#1"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], AbsoluteThickness[1.6], Opacity[1.], 
         LineBox[{78, 148, 142, 137, 133, 130, 128, 79, 80, 81, 82, 83, 84, 
          85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 
          101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 
          114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 
          149, 143, 138, 134, 131, 129, 150, 144, 139, 135, 132, 151, 145, 
          140, 136, 152, 146, 141, 153, 147, 154, 127}]},
        Annotation[#, "Charting`Private`Tag$2713#2"]& ], 
       TagBox[
        {Opacity[0], 
         LineBox[{155, 225, 219, 214, 210, 207, 205, 156, 157, 158, 159, 160, 
          161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 
          174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 
          187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 
          200, 201, 202, 203, 226, 220, 215, 211, 208, 206, 227, 221, 216, 
          212, 209, 228, 222, 217, 213, 229, 223, 218, 230, 224, 231, 204}]},
        Annotation[#, "Charting`Private`Tag$2713#3"]& ], 
       TagBox[
        {Opacity[0], LineBox[CompressedData["
1:eJwNzNlWgQEAhdFfkTJrkKLB0FwIr9GNR/AA9dooJZKpwb7YF986a51S96Xz
HAqC4IkeNXFNhTOKHNO3DXjljSHvfDDikzETvpjyzYw5C5as+OGXP/4J/IfY
YJMwEbaIss0OMeIkSJIiTYYsu+yxzwE5DslT54Yq55xQoMEtF5Q45ZE7LinT
5J4rWjzQ5og16U8ebA==
          "]]},
        Annotation[#, "Charting`Private`Tag$2713#4"]& ]}}], {}, {}}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, 0},
  DisplayFunction->Identity,
  Frame->{{False, False}, {False, False}},
  FrameLabel->{{None, None}, {None, None}},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  ImagePadding->All,
  Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& ), "CopiedValueFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& )}},
  PlotRange->{{-1., 3.}, {-2.1020289220592567`, 2.502298433697786}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.05], 
     Scaled[0.05]}},
  Ticks->{Automatic, Automatic}]], "Output",
 CellChangeTimes->{{3.731749032616172*^9, 3.7317490483769703`*^9}, {
   3.731749168730905*^9, 3.731749194587873*^9}, 3.731749278324253*^9, 
   3.731749658651566*^9, 3.731801828293459*^9, 3.731803352533175*^9, 
   3.731837027696876*^9},
 CellLabel->"Out[30]=",ExpressionUUID->"be59c8dc-daae-4b5e-883b-fe01505a9478"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Don\[CloseCurlyQuote]t Invert That Matrix\.7f", "Subchapter",
 CellChangeTimes->{{3.727456856590333*^9, 3.727456866525626*^9}, {
  3.727456903416147*^9, 3.727456929038941*^9}},
 CellTags->"c:10",ExpressionUUID->"fa5c3c19-9228-4e76-bd56-41d0e5fcc961"],

Cell[TextData[{
 "See ",
 ButtonBox["https://www.johndcook.com/blog/2010/01/19/dont-invert-that-matrix/\
",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://www.johndcook.com/blog/2010/01/19/dont-invert-that-matrix/"],
     None},
  ButtonNote->
   "https://www.johndcook.com/blog/2010/01/19/dont-invert-that-matrix/"],
 " \n\nIn general, replace any occurrence of ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SuperscriptBox["A", 
     RowBox[{"-", "1"}]], "\[CenterDot]", "B"}], TraditionalForm]],
  ExpressionUUID->"32698cd4-2dcc-4b05-9117-50af35fbcccc"],
 " or ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"Inverse", "[", "A", "]"}], ".", "B"}], TraditionalForm]], "Code",
  ExpressionUUID->"0208196a-6c21-4a62-9f05-79b2f4e5fe89"],
 " with ",
 Cell[BoxData[
  FormBox[
   RowBox[{"LinearSolve", "[", 
    RowBox[{"A", ",", "B"}], "]"}], TraditionalForm]], "Code",ExpressionUUID->
  "4e7fbc22-09d2-4e39-a5b5-b93b7697af49"],
 " for arbitrary square matrix ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "776ee4c1-d1ce-42de-85cc-2ca525876f54"],
 " and arbitrary matrix ",
 Cell[BoxData[
  FormBox["B", TraditionalForm]],ExpressionUUID->
  "493b32c5-9bbd-4079-b87d-0885d8421239"],
 ". Almost all programming languages and toolkits support an efficient and \
robust analogue to Wolfram\[CloseCurlyQuote]s ",
 Cell[BoxData[
  FormBox["LinearSolve", TraditionalForm]], "Code",ExpressionUUID->
  "908053eb-6863-4781-928e-21ed138ed5fc"],
 "."
}], "Text",
 CellChangeTimes->{{3.727377065079856*^9, 3.7273770966536922`*^9}, {
  3.727456910929248*^9, 3.727456922321958*^9}, {3.727967129773798*^9, 
  3.727967138858366*^9}, {3.7279671799345827`*^9, 3.727967207643837*^9}, {
  3.7281215143410273`*^9, 3.728121560473433*^9}, {3.729023567817812*^9, 
  3.729023646362337*^9}, {3.729164385351775*^9, 3.729164386998762*^9}, {
  3.729173657472382*^9, 3.729173717927524*^9}, {3.729643492684564*^9, 
  3.729643541414435*^9}},ExpressionUUID->"e95f16a2-0a88-4102-b389-\
ba64fa309a2a"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "update", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{
     StyleBox["update",
      Background->RGBColor[1, 1, 0]], "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\[Xi]_", ",", "\[CapitalLambda]_"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"\[Zeta]_", ",", "a_"}], "}"}]}], "]"}], ":=", 
    "\[IndentingNewLine]", 
    RowBox[{"With", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\[CapitalPi]", "=", 
        RowBox[{"(", 
         RowBox[{"\[CapitalLambda]", "+", 
          RowBox[{
           RowBox[{"a", "\[Transpose]"}], ".", "a"}]}], ")"}]}], "}"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{
         StyleBox["LinearSolve",
          Background->RGBColor[0.88, 1, 0.88]], "[", 
         RowBox[{"\[CapitalPi]", ",", 
          RowBox[{"(", 
           RowBox[{
            RowBox[{
             RowBox[{"a", "\[Transpose]"}], ".", "\[Zeta]"}], "+", 
            RowBox[{"\[CapitalLambda]", ".", "\[Xi]"}]}], ")"}]}], "]"}], ",",
         "\[CapitalPi]"}], "}"}]}], "]"}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{"MatrixForm", "/@", 
  RowBox[{"(", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"(", GridBox[{
         {"mBar"},
         {"bBar"}
        }], ")"}], ",", "\[CapitalPi]"}], "}"}], "=", "\[IndentingNewLine]", 
    RowBox[{
     StyleBox["Fold",
      Background->RGBColor[1, 1, 0]], "[", 
     RowBox[{
      StyleBox["update",
       Background->RGBColor[1, 1, 0]], ",", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"(", GridBox[{
           {"0"},
           {"0"}
          }], ")"}], ",", 
        RowBox[{"(", GridBox[{
           {"1.0*^-6", "0"},
           {"0", "1.0*^-6"}
          }], ")"}]}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"List", "/@", "data"}], ",", 
         RowBox[{"List", "/@", "partials"}]}], "}"}], "\[Transpose]"}]}], 
     "]"}]}], ")"}]}]}], "Input",
 CellChangeTimes->{{3.727054852495049*^9, 3.72705494257406*^9}, {
   3.727055026792467*^9, 3.727055093506559*^9}, {3.7270551930291023`*^9, 
   3.727055263833913*^9}, {3.727055297216107*^9, 3.7270554270906563`*^9}, {
   3.7270560338846903`*^9, 3.72705612788085*^9}, {3.7270561855129213`*^9, 
   3.7270561959544077`*^9}, {3.727056250031129*^9, 3.727056367103942*^9}, {
   3.727056427865035*^9, 3.727056443080068*^9}, {3.727056561323501*^9, 
   3.727056598046468*^9}, {3.727056640141169*^9, 3.727056654582451*^9}, {
   3.727056728700244*^9, 3.7270567914565277`*^9}, {3.727056869366274*^9, 
   3.727056921039433*^9}, 3.72705709924362*^9, {3.727057420502048*^9, 
   3.7270575464285316`*^9}, {3.7270577446377487`*^9, 3.727057775909028*^9}, {
   3.7270578799866133`*^9, 3.727057901007744*^9}, 3.7270581603330593`*^9, {
   3.727058349930079*^9, 3.7270584478842707`*^9}, {3.727058490337566*^9, 
   3.727058577824399*^9}, {3.727058673744141*^9, 3.7270586947547493`*^9}, {
   3.727058788099071*^9, 3.7270588909590683`*^9}, {3.727058934322414*^9, 
   3.7270589393580847`*^9}, {3.72705898616982*^9, 3.7270589868650723`*^9}, {
   3.7270592331231947`*^9, 3.727059237300102*^9}, {3.727370367915408*^9, 
   3.727370398721291*^9}, {3.727457046333558*^9, 3.727457067436592*^9}, {
   3.727473022344759*^9, 3.727473052764071*^9}, {3.727473241324421*^9, 
   3.7274732753376427`*^9}, {3.7274734820130367`*^9, 3.727473491340034*^9}, {
   3.7289484043309593`*^9, 3.728948405468891*^9}, {3.729174099251841*^9, 
   3.7291741039734783`*^9}, 3.7291741376366043`*^9},
 CellLabel->"In[31]:=",ExpressionUUID->"3f9feebb-e998-4c6f-bd9b-8bce5c193591"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"0.5377933869862003`"},
       {
        RowBox[{"-", "0.31780143514491455`"}]}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"280.35593320338984`", "119.`"},
       {"119.`", "119.000001`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]]}], "}"}]], "Output",
 CellChangeTimes->{{3.727473265842018*^9, 3.7274732757004232`*^9}, 
   3.727473492609377*^9, 3.727485511701943*^9, 3.727486309173321*^9, 
   3.727878578445228*^9, 3.7278807875164957`*^9, 3.727881187996175*^9, 
   3.72788136768466*^9, 3.7279153853534393`*^9, 3.727918036812088*^9, 
   3.727918094615041*^9, 3.7279241979432487`*^9, {3.727927707015217*^9, 
   3.72792773222125*^9}, 3.727967810349496*^9, 3.7279687332731037`*^9, 
   3.7279698083019648`*^9, 3.7279699551693897`*^9, 3.728044351771216*^9, 
   3.7280464478070717`*^9, 3.7280664697246733`*^9, 3.728068120868615*^9, 
   3.728083783546753*^9, 3.728090741492902*^9, 3.728169445260518*^9, 
   3.728169540823485*^9, 3.728169822977787*^9, 3.7281698830032377`*^9, 
   3.728252955627798*^9, 3.728946255859652*^9, 3.72894933878874*^9, 
   3.729022900020834*^9, {3.729119978523779*^9, 3.7291199956273623`*^9}, 
   3.729121072078249*^9, 3.7291211106160603`*^9, 3.729172307489259*^9, 
   3.729174106495594*^9, 3.729174141124625*^9, 3.7291756904605827`*^9, 
   3.729175784083406*^9, 3.729183412264688*^9, {3.729183447536147*^9, 
   3.7291834604902687`*^9}, 3.729255936956237*^9, 3.7295523015566072`*^9, 
   3.729557876032403*^9, 3.72962983801383*^9, 3.729634635965757*^9, 
   3.729642872243292*^9, 3.729642908898361*^9, 3.729643938245161*^9, 
   3.7296471845136013`*^9, 3.7296832013162327`*^9, 3.729778153926168*^9, 
   3.72977923191739*^9, 3.729779279992197*^9, 3.731525584854208*^9, 
   3.731527814933241*^9, 3.7315829934643393`*^9, 3.731670258109017*^9, 
   3.731671801609912*^9, 3.731671838163617*^9, 3.731801945267673*^9, 
   3.73180335256218*^9, 3.7318370277377453`*^9},
 CellLabel->"Out[33]=",ExpressionUUID->"0d1a8d3a-9a70-41e0-8f6b-b48487621732"]
}, Open  ]],

Cell[TextData[{
 "Because this example is small, ",
 Cell[BoxData[
  FormBox["Inverse", TraditionalForm]], "Code",ExpressionUUID->
  "1e8b6ec0-9f26-4e41-ac8c-020e2f7853de"],
 " has no obvious numerical issues. It is very easy to produce large, \
ill-conditioned matrices, and one will spend a lot of time and storage \
inverting them, only to get useless results."
}], "Text",
 CellChangeTimes->{{3.727473280120357*^9, 3.7274732832085*^9}, {
   3.7279911307811337`*^9, 3.727991131940103*^9}, {3.728121572695258*^9, 
   3.728121612596923*^9}, {3.729023701182482*^9, 3.729023764199581*^9}, 
   3.7291737430479116`*^9, {3.729181869246784*^9, 
   3.729181869373077*^9}},ExpressionUUID->"e26be4d4-88d8-4e26-b76a-\
6a0f143a5a31"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Interim Conclusions", "Subchapter",
 CellChangeTimes->{{3.729164407912829*^9, 
  3.729164418350677*^9}},ExpressionUUID->"44cdee8b-206e-48f6-9264-\
a90ffd3d95c6"],

Cell[TextData[{
 "We have eliminated memory bloat by processing updates one observation at a \
time, each with its paired partial. We reduce computation time and numerical \
risk by solving a linear system instead of inverting a matrix. We also avoid \
multiplication of ",
 Cell[BoxData[
  FormBox[
   RowBox[{"O", "(", "\[CapitalNu]", ")"}], TraditionalForm]],ExpressionUUID->
  "f1e31217-fd6e-41e1-90c4-263aba7bf238"],
 " matrices, which is of approximately ",
 Cell[BoxData[
  FormBox[
   RowBox[{"O", "(", 
    SuperscriptBox["\[CapitalNu]", "3"], ")"}], TraditionalForm]],
  ExpressionUUID->"816d662d-3cd4-47fe-8656-616095fce9ed"],
 " time. We still have work to do with observation covariances. "
}], "Text",
 CellChangeTimes->{{3.727475777156247*^9, 3.727475832537896*^9}, {
  3.72748624599329*^9, 3.727486246966188*^9}, {3.729023774567375*^9, 
  3.729023775311418*^9}, {3.7291818849549427`*^9, 3.729182029375617*^9}, {
  3.729644121939213*^9, 3.729644164344136*^9}, {3.729797388940627*^9, 
  3.7297974303556147`*^9}, {3.7318019740023537`*^9, 
  3.731801990729644*^9}},ExpressionUUID->"f737cec4-37d1-4831-9d33-\
1965e8fe2119"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Sidebar: Estimating 1-Forms (Gradients)", "Chapter",
 CellChangeTimes->{{3.7273771343297157`*^9, 3.727377139800111*^9}, {
  3.7291646932512817`*^9, 3.729164695199853*^9}, {3.72917377485328*^9, 
  3.729173781833387*^9}},
 CellTags->"c:11",ExpressionUUID->"a72d02c1-4d0c-4859-b900-7c456316807a"],

Cell[TextData[{
 "In linear algebra, vectors are conventionally columns, i.e., ",
 Cell[BoxData[
  FormBox[
   RowBox[{"n", "\[Times]", "1"}], TraditionalForm]],ExpressionUUID->
  "a6cadbf5-eaec-46e8-a3d5-eddcc2e4eb77"],
 " matrices, and covectors are rows, i.e., ",
 Cell[BoxData[
  FormBox[
   RowBox[{"1", "\[Times]", "n"}], TraditionalForm]],ExpressionUUID->
  "b7266d47-c9dc-4139-81ba-04ba699e26b9"],
 " matrices (see ",
 ButtonBox["Vector Calculus, Linear Algebra, and Differential Forms, A \
Unified Approach",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://www.amazon.com/Calculus-Algebra-Differential-Unified-\
Approach/dp/0971576653/"], None},
  ButtonNote->
   "https://www.amazon.com/Calculus-Algebra-Differential-Unified-Approach/dp/\
0971576653/"],
 " by John H. Hubbard and Barbara Burke Hubbard). In this language, ",
 StyleBox["dual",
  FontSlant->"Italic"],
 " means ",
 StyleBox["transpose",
  FontSlant->"Italic"],
 "."
}], "Text",
 CellChangeTimes->{{3.729171298029805*^9, 3.729171328988427*^9}, {
  3.729171450083456*^9, 
  3.729171568542794*^9}},ExpressionUUID->"e302ce55-543f-481c-9e13-\
79d56a4ae834"],

Cell[TextData[{
 "When the model --- the thing we\[CloseCurlyQuote]re estimating --- is a \
covector (row-vector), e.g., a 1-form, we have the dual (transposed) problem \
to the one above. This situation arises in reinforcement learning by policy \
gradient. In that case, the observations ",
 Cell[BoxData[
  FormBox["\[CapitalOmega]", TraditionalForm]],ExpressionUUID->
  "0fcd49da-549d-4513-bc2a-55e5a3acca81"],
 " and the model ",
 Cell[BoxData[
  FormBox["\[CapitalGamma]", TraditionalForm]],ExpressionUUID->
  "c54ce737-c37c-4bf4-9780-c31893284bab"],
 " are now\.7f covectors with elements \[Omega] and \[Gamma]  instead of \
\[Zeta] and \[Xi]. The co-partials ",
 Cell[BoxData[
  FormBox["\[CapitalTheta]", TraditionalForm]],ExpressionUUID->
  "595110e6-8484-4e8f-924b-1631a75a7403"],
 " (replacing ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "a5959bab-c708-499c-8174-f99a22842500"],
 ") are now a covector of column vectors \[Theta]. The observation equation \
is ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalOmega]", "=", 
    RowBox[{"\[CapitalGamma]", "\[CenterDot]", "\[CapitalTheta]"}]}], 
   TraditionalForm]],ExpressionUUID->"1de13883-b79d-4fc7-96bd-cf06cf9564dc"],
 " and the error-so-far is ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"(", 
     RowBox[{"x", "-", "\[Gamma]"}], ")"}], "\[CenterDot]", 
    "\[CapitalLambda]", "\[CenterDot]", 
    RowBox[{
     RowBox[{"(", 
      RowBox[{"x", "-", "\[Gamma]"}], ")"}], "\[Transpose]"}]}], 
   TraditionalForm]],ExpressionUUID->"b1dadb23-5a5d-431a-a7d4-4fd905f473fa"],
 ", where ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalLambda]", "=", 
    RowBox[{
     SubscriptBox["\[CapitalTheta]", 
      RowBox[{"so", "-", "far"}]], "\[CenterDot]", 
     RowBox[{
      SubscriptBox["\[CapitalTheta]", 
       RowBox[{"so", "-", "far"}]], "\[Transpose]"}]}]}], TraditionalForm]],
  ExpressionUUID->"3e9237e0-1492-41e0-9db9-9439ab6ebd6b"],
 ". We don\[CloseCurlyQuote]t change the name of \[CapitalLambda] because it\
\[CloseCurlyQuote]s symmetric. Adding a new observation ",
 Cell[BoxData[
  FormBox["\[Omega]", TraditionalForm]],ExpressionUUID->
  "26a398ad-1d0d-4db9-818d-7de4a635932a"],
 " introduces new error ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"(", 
     RowBox[{"\[Omega]", "-", 
      RowBox[{"x", "\[CenterDot]", "\[Theta]"}]}], ")"}], "\[CenterDot]", 
    RowBox[{
     RowBox[{"(", 
      RowBox[{"\[Omega]", "-", 
       RowBox[{"x", "\[CenterDot]", "\[Theta]"}]}], ")"}], "\[Transpose]"}]}],
    TraditionalForm]],ExpressionUUID->
  "032998b6-a96c-4d29-a61c-9ced58867980"],
 ". Minimizing the total error yields"
}], "Text",
 CellChangeTimes->{{3.727371218106142*^9, 3.727371240353272*^9}, {
   3.727371321069407*^9, 3.7273713296417093`*^9}, {3.7273713611621637`*^9, 
   3.7273714263190937`*^9}, {3.727371840069378*^9, 3.727371867019196*^9}, {
   3.727372044036509*^9, 3.727372359143402*^9}, {3.7273723988812304`*^9, 
   3.727372407831134*^9}, {3.727372456820087*^9, 3.727372576254916*^9}, {
   3.727372611880259*^9, 3.727372641828212*^9}, {3.727372745304285*^9, 
   3.727372762735136*^9}, {3.727373158078546*^9, 3.727373237360611*^9}, {
   3.727373343633808*^9, 3.727373660775297*^9}, {3.727373697002878*^9, 
   3.727373742098151*^9}, {3.7273741179275093`*^9, 3.727374119292781*^9}, 
   3.727374177681995*^9, {3.727374220080714*^9, 3.727374222719513*^9}, {
   3.7273750571767797`*^9, 3.7273750585288754`*^9}, {3.7273752241900177`*^9, 
   3.727375304998845*^9}, {3.727375354434124*^9, 3.727375583810218*^9}, {
   3.727375623795074*^9, 3.727375730528801*^9}, {3.727375806827318*^9, 
   3.727375932949609*^9}, {3.727376001504113*^9, 3.7273760221258574`*^9}, {
   3.727376063086153*^9, 3.727376156532493*^9}, {3.727376198118507*^9, 
   3.7273762919936867`*^9}, {3.727376351159185*^9, 3.727376363855044*^9}, {
   3.727376403668652*^9, 3.727376583289638*^9}, {3.727381968753878*^9, 
   3.7273821258780212`*^9}, {3.727382164112809*^9, 3.7273822084773273`*^9}, {
   3.727382248170485*^9, 3.7273823090681543`*^9}, {3.727382364895949*^9, 
   3.7273824245463467`*^9}, {3.727382516398245*^9, 3.727382517532123*^9}, {
   3.727382625583332*^9, 3.727382645314341*^9}, {3.727385201688477*^9, 
   3.72738520738167*^9}, {3.727385254691243*^9, 3.727385293535783*^9}, {
   3.727385323848435*^9, 3.727385374988439*^9}, {3.7273854084548693`*^9, 
   3.727385428127161*^9}, {3.727385559242544*^9, 3.72738569411847*^9}, {
   3.72738573051742*^9, 3.727385964398753*^9}, {3.727386005984235*^9, 
   3.72738615274949*^9}, {3.7273861954556293`*^9, 3.727386233565445*^9}, {
   3.727386269771594*^9, 3.727386271096093*^9}, {3.72738631202649*^9, 
   3.727386328269546*^9}, {3.727386360536889*^9, 3.7273864416740427`*^9}, {
   3.727386563853504*^9, 3.7273865694578733`*^9}, {3.727473691712545*^9, 
   3.727473706980104*^9}, {3.727473910423223*^9, 3.727473930847046*^9}, {
   3.7274739978523407`*^9, 3.727474003956037*^9}, {3.727475018387333*^9, 
   3.7274752353192043`*^9}, {3.7274758667159777`*^9, 
   3.7274761487187138`*^9}, {3.727485043325775*^9, 3.727485063734617*^9}, {
   3.727878432124065*^9, 3.727878474409099*^9}, 3.728948410297505*^9, {
   3.729119179477888*^9, 3.729119179623824*^9}, {3.729171586876195*^9, 
   3.729171594465631*^9}, {3.729173804727751*^9, 3.7291738082872458`*^9}, {
   3.7291820610672693`*^9, 3.7291820942076683`*^9}, 3.729644623998877*^9, {
   3.729644658106*^9, 
   3.7296446644356623`*^9}},ExpressionUUID->"a48f160e-1684-401e-a3aa-\
d4b6f371c2d7"],

Cell[BoxData[{
 FormBox[
  RowBox[{"\[Gamma]", "\[LeftArrow]", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{
      RowBox[{"\[Gamma]", "\[CenterDot]", "\[CapitalLambda]"}], "+", 
      RowBox[{"\[Omega]", "\[CenterDot]", 
       RowBox[{"\[Theta]", "\[ThinSpace]", "\[Transpose]"}]}]}], 
     "\[ThinSpace]", ")"}], ".", 
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{"\[CapitalLambda]", "+", 
       RowBox[{"\[Theta]", "\[CenterDot]", 
        RowBox[{"\[Theta]", "\[ThinSpace]", "\[Transpose]"}]}]}], 
      "\[ThinSpace]", ")"}], 
     RowBox[{"-", "1"}]]}]}], TraditionalForm], "\n", 
 FormBox[
  RowBox[{"\[CapitalLambda]", "\[LeftArrow]", 
   RowBox[{"(", 
    RowBox[{"\[CapitalLambda]", "+", 
     RowBox[{"\[Theta]", "\[CenterDot]", 
      RowBox[{"\[Theta]", "\[ThinSpace]", "\[Transpose]"}]}]}], 
    "\[ThinSpace]", ")"}]}], TraditionalForm]}], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.727473769463854*^9, 3.7274737789509773`*^9}, {
  3.727473829318837*^9, 3.727473867909276*^9}, {3.727476024957868*^9, 
  3.727476030734923*^9}, {3.727476186696595*^9, 3.727476277887042*^9}, {
  3.727476413804344*^9, 3.727476415307171*^9}, {3.727519463791893*^9, 
  3.727519480366523*^9}},ExpressionUUID->"75e334be-e1b6-4c01-a995-\
dfe7294f9f8e"],

Cell[TextData[{
 "straight transposes of equation 3. ",
 Cell[BoxData[
  FormBox["LinearSolve", TraditionalForm]], "Code",ExpressionUUID->
  "cb78cef6-6105-441c-b121-2693c4ccb84d"],
 " operates on the transposed right-hand side of the recurrence, and we \
transpose the solution to get the recurrence. We apply this dual model to the \
transpose of the original data:"
}], "Text",
 CellChangeTimes->{{3.727476457185042*^9, 3.727476506319212*^9}, {
  3.727476549477606*^9, 3.7274765535653963`*^9}, {3.727878507367712*^9, 
  3.727878521964983*^9}, {3.7279672954218388`*^9, 
  3.727967307737608*^9}},ExpressionUUID->"039c120f-4333-4106-885b-\
537fd523a4e5"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Short", "[", 
  RowBox[{
   RowBox[{"Transpose", "/@", 
    RowBox[{"List", "/@", "partials"}]}], ",", "3"}], "]"}]], "Input",
 CellChangeTimes->{{3.72747707307362*^9, 3.727477115704844*^9}, {
  3.7279673222701263`*^9, 3.727967373721106*^9}},
 CellLabel->"In[34]:=",ExpressionUUID->"ec136c96-4375-44a8-a302-745bbc5d2137"],

Cell[BoxData[
 TagBox[
  RowBox[{"{", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"-", "1.`"}], "}"}], ",", 
      RowBox[{"{", "1.`", "}"}]}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"-", "0.9661016949152542`"}], "}"}], ",", 
      RowBox[{"{", "1.`", "}"}]}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"-", "0.9322033898305084`"}], "}"}], ",", 
      RowBox[{"{", "1.`", "}"}]}], "}"}], ",", 
    RowBox[{"\[LeftSkeleton]", "113", "\[RightSkeleton]"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", "2.9322033898305087`", "}"}], ",", 
      RowBox[{"{", "1.`", "}"}]}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", "2.9661016949152543`", "}"}], ",", 
      RowBox[{"{", "1.`", "}"}]}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", "3.`", "}"}], ",", 
      RowBox[{"{", "1.`", "}"}]}], "}"}]}], "}"}],
  Short[#, 3]& ]], "Output",
 CellChangeTimes->{{3.727477084780794*^9, 3.727477117039559*^9}, 
   3.7274855118872547`*^9, 3.727486309346143*^9, 3.727878578500392*^9, 
   3.72788078756756*^9, 3.727881188048245*^9, 3.7278813677339783`*^9, 
   3.727915385401812*^9, 3.7279180369804287`*^9, 3.727918094667513*^9, 
   3.72792419801117*^9, {3.727927707085987*^9, 3.727927732269897*^9}, {
   3.727967328044313*^9, 3.727967374382712*^9}, 3.72796781039671*^9, 
   3.727968733327298*^9, 3.727969808356143*^9, 3.727969955220028*^9, 
   3.728044351820155*^9, 3.7280464478574*^9, 3.728066469771554*^9, 
   3.728068120919256*^9, 3.728083783615262*^9, 3.728090741576128*^9, 
   3.728169445436224*^9, 3.728169540889641*^9, 3.7281698230448112`*^9, 
   3.728169883071618*^9, 3.728252955686994*^9, 3.728946255916401*^9, 
   3.7290229000710297`*^9, {3.7291199785882177`*^9, 3.729119995691979*^9}, 
   3.7291210721447773`*^9, 3.7291211106835527`*^9, 3.729172307556221*^9, 
   3.7291756905252857`*^9, 3.729183412440611*^9, {3.729183447710875*^9, 
   3.729183460557459*^9}, 3.729255937022531*^9, 3.729552301609993*^9, 
   3.729557876084003*^9, 3.729629838065102*^9, 3.72963463602686*^9, 
   3.729642872292902*^9, 3.729642908965888*^9, 3.729643939010482*^9, 
   3.72964718527703*^9, 3.729683201999112*^9, 3.729778155298472*^9, 
   3.729779233421752*^9, 3.729779280547061*^9, 3.731525584907669*^9, 
   3.731527815004632*^9, 3.731582993532523*^9, 3.7316702581449957`*^9, 
   3.731671801677801*^9, 3.7316718381970177`*^9, 3.731802063532301*^9, 
   3.731803352609248*^9, 3.7318370277943363`*^9},
 CellLabel->
  "Out[34]//Short=",ExpressionUUID->"f56e37cc-355e-4860-8609-f02a5c0b53fa"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "coUpdate", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    StyleBox["coUpdate",
     Background->RGBColor[1, 1, 0]], "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\[Gamma]_", ",", "\[CapitalLambda]_"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"\[Omega]_", ",", "\[Theta]_"}], "}"}]}], "]"}], ":=", 
   "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\[CapitalPi]", "=", 
       RowBox[{"(", 
        RowBox[{"\[CapitalLambda]", "+", 
         RowBox[{"\[Theta]", ".", 
          RowBox[{"\[Theta]", "\[Transpose]"}]}]}], ")"}]}], "}"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{
        RowBox[{"LinearSolve", "[", 
         RowBox[{"\[CapitalPi]", ",", 
          RowBox[{
           RowBox[{"\[CapitalLambda]", ".", 
            RowBox[{"\[Gamma]", "\[Transpose]"}]}], "+", 
           RowBox[{"\[Theta]", ".", 
            RowBox[{"\[Omega]", "\[Transpose]"}]}]}]}], "]"}], 
        "\[Transpose]"}], ",", "\[CapitalPi]"}], "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"MatrixForm", "/@", 
  RowBox[{
   StyleBox["Fold",
    Background->RGBColor[1, 1, 0]], "[", 
   RowBox[{
    StyleBox["coUpdate",
     Background->RGBColor[1, 1, 0]], ",", "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"(", GridBox[{
         {"0", "0"}
        }], ")"}], ",", 
      RowBox[{"(", GridBox[{
         {"1.0*^-6", "0"},
         {"0", "1.0*^-6"}
        }], ")"}]}], "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"List", "/@", 
        RowBox[{"List", "/@", "data"}]}], ",", 
       RowBox[{"Transpose", "/@", 
        RowBox[{"List", "/@", "partials"}]}]}], "}"}], "\[Transpose]"}]}], 
   "]"}]}]}], "Input",
 CellChangeTimes->{{3.727373282942794*^9, 3.727373311804191*^9}, {
   3.727376180517476*^9, 3.727376181653618*^9}, {3.7273767470214643`*^9, 
   3.727376772415944*^9}, {3.727376838568122*^9, 3.727376996930687*^9}, {
   3.72738256636836*^9, 3.727382569358986*^9}, {3.727382665863063*^9, 
   3.727382700900879*^9}, {3.7273827517208357`*^9, 3.7273827939392014`*^9}, {
   3.727382854392722*^9, 3.727382887313746*^9}, {3.727382928030025*^9, 
   3.7273829350883923`*^9}, {3.727383062267906*^9, 3.7273833443529673`*^9}, {
   3.727383375173339*^9, 3.727383375684123*^9}, {3.727383409608202*^9, 
   3.727383500022263*^9}, {3.727476338632511*^9, 3.7274763769100018`*^9}, {
   3.727476597581078*^9, 3.7274770426433783`*^9}, {3.727477148842947*^9, 
   3.727477169094758*^9}, 3.7274773761933823`*^9, {3.727477430990588*^9, 
   3.7274774638671503`*^9}, {3.7274774973342*^9, 3.7274775628692408`*^9}, 
   3.727967383277925*^9},
 CellLabel->"In[35]:=",ExpressionUUID->"17701f33-3e3c-42dd-9c7b-fdb6f8f4b767"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"0.5377933869862003`", 
        RowBox[{"-", "0.31780143514491455`"}]}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"280.35593320338984`", "119.`"},
       {"119.`", "119.000001`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]]}], "}"}]], "Output",
 CellChangeTimes->{
  3.727383072193253*^9, 3.727383354047873*^9, 3.727383390761856*^9, 
   3.7273834247745028`*^9, {3.727383458844083*^9, 3.7273835011111603`*^9}, 
   3.727442992945771*^9, 3.72744342284167*^9, 3.727443453425893*^9, 
   3.727444588221921*^9, 3.727444680887401*^9, 3.7274455727767982`*^9, 
   3.727446247275579*^9, 3.727446407013369*^9, 3.72744683899579*^9, {
   3.7274468858224363`*^9, 3.727447006380907*^9}, {3.727447047179235*^9, 
   3.72744708786588*^9}, 3.727447307524426*^9, 3.727447364795184*^9, 
   3.7274478393573503`*^9, 3.727449904650557*^9, 3.72745018058704*^9, 
   3.7274550798510838`*^9, 3.727455975376423*^9, {3.727456143282322*^9, 
   3.7274561870786343`*^9}, 3.727457104301549*^9, 3.7274626019151583`*^9, 
   3.727472138649213*^9, {3.727476713990739*^9, 3.727476741082378*^9}, 
   3.727476781425972*^9, {3.727476852153051*^9, 3.727476875672526*^9}, 
   3.727477048974312*^9, {3.727477150418499*^9, 3.727477170510271*^9}, 
   3.7274773773967867`*^9, 3.727477433395472*^9, {3.727477479732809*^9, 
   3.7274775639291077`*^9}, 3.727485511931388*^9, 3.7274863093907747`*^9, 
   3.727878578548321*^9, 3.727880787616843*^9, 3.727881188097982*^9, 
   3.727881367783843*^9, 3.727915385450048*^9, 3.7279180370407333`*^9, 
   3.7279180947349854`*^9, 3.727924198197872*^9, {3.727927707221209*^9, 
   3.727927732334594*^9}, 3.7279678104450483`*^9, 3.72796873339045*^9, 
   3.727969808418737*^9, 3.727969955270645*^9, 3.7280443518882*^9, 
   3.7280464479120703`*^9, 3.728066469825574*^9, 3.72806812096865*^9, 
   3.728083783681383*^9, 3.72809074183177*^9, 3.728169445494536*^9, 
   3.728169541066454*^9, 3.728169823201066*^9, 3.7281698832458076`*^9, 
   3.72825295575315*^9, 3.7289462559605093`*^9, 3.729022900119602*^9, {
   3.729119978766576*^9, 3.729119995760891*^9}, 3.729121072211591*^9, 
   3.729121110749249*^9, 3.729172307621312*^9, 3.729175690576067*^9, 
   3.729183412498708*^9, {3.729183447769383*^9, 3.7291834606631536`*^9}, 
   3.729255937096897*^9, 3.729552301655949*^9, 3.729557876131513*^9, 
   3.729629838113813*^9, 3.729634636079982*^9, 3.729642872344131*^9, 
   3.729642909034739*^9, 3.729643939060902*^9, 3.729647185325626*^9, 
   3.729683202049787*^9, 3.729778155335161*^9, 3.729779233488535*^9, 
   3.729779280608066*^9, 3.731525584957828*^9, 3.7315278150722322`*^9, 
   3.731582993598693*^9, 3.731670258168612*^9, 3.731671801714114*^9, 
   3.7316718382443647`*^9, 3.7318020653681097`*^9, 3.731803352658812*^9, 
   3.7318370278413067`*^9},
 CellLabel->"Out[37]=",ExpressionUUID->"0d66a248-f929-470a-a21e-fd007f981cc3"]
}, Open  ]],

Cell["\<\
This also awaits renormalization, however, the new equations will be obvious.\
\
\>", "Text",
 CellChangeTimes->{{3.7318020721403913`*^9, 
  3.731802112976431*^9}},ExpressionUUID->"268ca108-0db2-4d58-91c5-\
569aeb311acb"],

Cell[CellGroupData[{

Cell["Application of the Dual Problem", "Subchapter",
 CellChangeTimes->{{3.7274775822773733`*^9, 3.727477598570956*^9}},
 CellTags->"c:12",ExpressionUUID->"7d924a7d-213d-4b77-996e-4b77a2416acf"],

Cell[TextData[{
 "The finite-difference method of policy-gradient machine learning provides \
an example of this dual problem (see ",
 ButtonBox["http://www.scholarpedia.org/article/Policy_gradient_methods",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://www.scholarpedia.org/article/Policy_gradient_methods"], None},
  
  ButtonNote->"http://www.scholarpedia.org/article/Policy_gradient_methods"],
 "). \n\nImagine a scalar function ",
 Cell[BoxData[
  FormBox[
   RowBox[{"J", "(", "\[Theta]", ")"}], TraditionalForm]],ExpressionUUID->
  "a46cd651-f70b-4e54-9a6e-79b25be38dd7"],
 " of a column ",
 Cell[BoxData[
  FormBox["K", TraditionalForm]],ExpressionUUID->
  "ab77f425-87e5-438e-a999-1aa211a17e08"],
 "-vector ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Theta]", 
    RowBox[{"K", "\[Times]", "1"}]], TraditionalForm]],ExpressionUUID->
  "530b2f34-3906-48d5-af1a-6fe88ef3be97"],
 ". We want to estimate its gradient covector ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubscriptBox["\[Del]", "\[Theta]"], "\[ThinSpace]", "J"}], 
   TraditionalForm]],ExpressionUUID->"1baa8577-d9b7-4297-b4ca-ceff99f13c83"],
 ", given a ",
 StyleBox["batch",
  FontSlant->"Italic"],
 " of ",
 Cell[BoxData[
  FormBox["\[ScriptCapitalI]", TraditionalForm]],ExpressionUUID->
  "16c4d51a-b042-4c78-b089-d3f26f019b67"],
 " random increments ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubscriptBox["\[CapitalDelta]\[CapitalTheta]", 
     RowBox[{"K", "\[Times]", "\[ScriptCapitalI]"}]], ","}], 
   TraditionalForm]],ExpressionUUID->"07503476-cdb0-4917-b1e9-2a5bbc9dd003"],
 " from the system ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     RowBox[{
      SubscriptBox["\[Del]", "\[Theta]"], "\[ThinSpace]", "J"}], 
     "\[CenterDot]", "\[CapitalDelta]\[CapitalTheta]"}], "=", 
    RowBox[{"\[CapitalDelta]", "\[ThinSpace]", "J"}]}], TraditionalForm]],
  ExpressionUUID->"7b50038e-f020-411d-a8a2-3c512776b63e"],
 ". Here, ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubscriptBox["\[Del]", "\[Theta]"], "\[ThinSpace]", "J"}], 
   TraditionalForm]],ExpressionUUID->"9f1abe83-d0e2-43da-a239-0e56844ff5d8"],
 " takes the role of the model whose state parameters ",
 Cell[BoxData[
  FormBox["\[CapitalGamma]", TraditionalForm]],ExpressionUUID->
  "13159cff-0fd5-42f2-88dd-3dfe54451576"],
 " we want to estimate, ",
 Cell[BoxData[
  FormBox["\[CapitalDelta]\[CapitalTheta]", TraditionalForm]],ExpressionUUID->
  "e8af39e2-8f2f-44b9-9891-43d8fb9a20fe"],
 " takes the role of the partials of the model w.r.t. those parameters, and \
",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalDelta]", "\[ThinSpace]", "J"}], TraditionalForm]],
  ExpressionUUID->"7283a09d-4a9c-4d7a-bf28-7284694732f9"],
 " takes the role of measured data. Let ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalDelta]", "\[ThinSpace]", 
    SubscriptBox["J", 
     RowBox[{"\[ScriptCapitalI]", "\[Times]", "1"}]]}], TraditionalForm]],
  ExpressionUUID->"b150a273-134d-41de-89ec-a18131d86339"],
 " be a batch of observed increments to ",
 Cell[BoxData[
  FormBox["J", TraditionalForm]],ExpressionUUID->
  "cfe89e57-0ac0-495d-b341-1b42902614f8"],
 " and ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[CapitalDelta]\[CapitalTheta]", 
    RowBox[{"K", "\[Times]", "\[ScriptCapitalI]"}]], TraditionalForm]],
  ExpressionUUID->"a4dd2cda-aed9-4a18-8bbe-2a27aefc37f0"],
 " be a matrix of the ",
 Cell[BoxData[
  FormBox["\[ScriptCapitalI]", TraditionalForm]],ExpressionUUID->
  "cf54303a-6d4c-4789-96f9-78229c49e87c"],
 " corresponding column-vector random increments to the input vectors ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Theta]", 
    RowBox[{"K", "\[Times]", "1"}]], TraditionalForm]],ExpressionUUID->
  "63e9ca28-5dcc-463b-aaab-a5f0f7b650c8"],
 ". The Moore-Penrose right pseudoinverse ",
 Cell[BoxData[
  FormBox[
   RowBox[{"RPI", 
    OverscriptBox["=", "def"], 
    RowBox[{
     SuperscriptBox[
      RowBox[{"(", 
       RowBox[{
        SubscriptBox["\[CapitalDelta]\[CapitalTheta]", 
         RowBox[{"K", "\[Times]", "\[ScriptCapitalI]"}]], "\[CenterDot]", 
        SubsuperscriptBox["\[CapitalDelta]\[CapitalTheta]", 
         RowBox[{"K", "\[Times]", "\[ScriptCapitalI]"}], "\[Transpose]"]}], 
       ")"}], 
      RowBox[{"-", "1"}]], "\[CenterDot]", 
     SubsuperscriptBox["\[CapitalDelta]\[CapitalTheta]", 
      RowBox[{"K", "\[Times]", "\[ScriptCapitalI]"}], "\[Transpose]"]}]}], 
   TraditionalForm]],ExpressionUUID->"ba4a5a39-1a06-4e05-9e99-d9d1a27f325d"],
 " solves ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     RowBox[{
      SubscriptBox["\[Del]", "\[Theta]"], "\[ThinSpace]", 
      SubscriptBox["J", 
       RowBox[{"\[ScriptCapitalI]", "\[Times]", "1"}]]}], "\[CenterDot]", 
     SubscriptBox["\[CapitalDelta]\[CapitalTheta]", 
      RowBox[{"K", "\[Times]", "\[ScriptCapitalI]"}]]}], "=", 
    RowBox[{"\[CapitalDelta]", "\[ThinSpace]", 
     SubscriptBox["J", 
      RowBox[{"\[ScriptCapitalI]", "\[Times]", "1"}]]}]}], TraditionalForm]],
  ExpressionUUID->"c9d377eb-a6b1-41cd-9897-feb501018138"],
 " to yield ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"\[Del]", "\[ThinSpace]", 
     SubscriptBox["J", 
      RowBox[{"\[ScriptCapitalI]", "\[Times]", "1"}]]}], "\[TildeTilde]", 
    RowBox[{"\[CapitalDelta]", "\[ThinSpace]", 
     RowBox[{
      SubscriptBox["J", 
       RowBox[{"\[ScriptCapitalI]", "\[Times]", "1"}]], "\[CenterDot]", 
      "RPI"}]}]}], TraditionalForm]],ExpressionUUID->
  "ad9393d1-07c0-4272-a9d5-2784ac220021"],
 ". \n\nInstead of the pseudoinverse, which is large, slow, and risky, use \
the co-update recurrence of equation 7, or its later renormalization, for \
this problem."
}], "Text",
 CellChangeTimes->{{3.727371218106142*^9, 3.727371240353272*^9}, {
   3.727371321069407*^9, 3.7273713296417093`*^9}, {3.7273713611621637`*^9, 
   3.7273714263190937`*^9}, {3.727371840069378*^9, 3.727371867019196*^9}, {
   3.727372044036509*^9, 3.727372359143402*^9}, {3.7273723988812304`*^9, 
   3.727372407831134*^9}, {3.727372456820087*^9, 3.727372576254916*^9}, {
   3.727372611880259*^9, 3.727372641828212*^9}, {3.727372745304285*^9, 
   3.727372762735136*^9}, {3.727373158078546*^9, 3.727373237360611*^9}, {
   3.727373343633808*^9, 3.727373660775297*^9}, {3.727373697002878*^9, 
   3.727373742098151*^9}, {3.7273741179275093`*^9, 3.727374119292781*^9}, 
   3.727374177681995*^9, {3.727374220080714*^9, 3.727374222719513*^9}, {
   3.7273750571767797`*^9, 3.7273750585288754`*^9}, {3.7273752241900177`*^9, 
   3.727375304998845*^9}, {3.727375354434124*^9, 3.727375583810218*^9}, {
   3.727375623795074*^9, 3.727375730528801*^9}, {3.727375806827318*^9, 
   3.727375932949609*^9}, {3.727376001504113*^9, 3.7273760221258574`*^9}, {
   3.727376063086153*^9, 3.727376156532493*^9}, {3.727376198118507*^9, 
   3.7273762919936867`*^9}, {3.727376351159185*^9, 3.727376363855044*^9}, {
   3.727376403668652*^9, 3.727376583289638*^9}, {3.727381968753878*^9, 
   3.7273821258780212`*^9}, {3.727382164112809*^9, 3.7273822084773273`*^9}, {
   3.727382248170485*^9, 3.7273823090681543`*^9}, {3.727382364895949*^9, 
   3.7273824245463467`*^9}, {3.727382516398245*^9, 3.727382517532123*^9}, {
   3.727382625583332*^9, 3.727382645314341*^9}, {3.727477798829159*^9, 
   3.727477804771535*^9}, 3.72748531820835*^9, {3.7274853820587463`*^9, 
   3.727485407991457*^9}, {3.727485470328353*^9, 3.72748548941591*^9}, {
   3.727971127714642*^9, 3.727971222057963*^9}, 3.7291191797426023`*^9, {
   3.7291644828303432`*^9, 3.7291645329693336`*^9}, {3.729182106318571*^9, 
   3.7291821066066723`*^9}, {3.7296447322664423`*^9, 3.729644752148653*^9}, {
   3.729644782560891*^9, 3.729644805790003*^9}, {3.73180216647228*^9, 
   3.731802208090819*^9}},ExpressionUUID->"c9c6ad4d-0286-4b98-a99a-\
c1a9553369dd"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Regularization By A-Priori", "Chapter",
 CellChangeTimes->{{3.7278786048568163`*^9, 3.727878609238576*^9}, {
   3.7278835476425943`*^9, 3.727883549040578*^9}, {3.727924834507627*^9, 
   3.727924836977462*^9}, {3.727925756497532*^9, 3.727925760501575*^9}, {
   3.729023822401535*^9, 3.7290238231434097`*^9}, {3.7291828363150797`*^9, 
   3.729182841338913*^9}, 3.729712704361965*^9},
 CellTags->"c:13",ExpressionUUID->"919e5e5b-7d8b-4c5f-ab4c-0bcbe514a42c"],

Cell[TextData[{
 "Chris Bishop\[CloseCurlyQuote]s ",
 StyleBox[ButtonBox["Pattern Recognition and Machine Learning",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://www.amazon.com/Pattern-Recognition-Learning-Information-\
Statistics/dp/0387310738"], None},
  ButtonNote->
   "https://www.amazon.com/Pattern-Recognition-Learning-Information-\
Statistics/dp/0387310738"],
  FontSlant->"Italic"],
 " has an extended example fitting higher-order polynomials, linear in their \
coefficients, starting in section 1.1. The higher the order of the \
polynomial, the more MLE over-fits. Bishop presents MAP regularization as a \
cure for this over-fitting. RLS and KAL already regularize, by construction. \
In this section, we relate their regularization to MAP\[CloseCurlyQuote]s.\n\n\
RLS and KAL each require an a-priori estimate of the unknown parameters and \
an a-priori uncertainty of that estimate to bootstrap recurrences. RLS takes \
the uncertainty as an ",
 StyleBox["information matrix",
  FontSlant->"Italic"],
 ". KAL takes the uncertainty as a ",
 StyleBox["covariance matrix",
  FontSlant->"Italic"],
 ", inverse of the information matrix. Bishop also computes the information \
matrix as ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["S", 
    RowBox[{"-", "1"}]], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "3f763d70-1942-4ec4-bdeb-cd6d6f1d3f33"],
 ", though Bishop does not name it so. KAL additionally requires an estimate \
of observation noise, which arises in real problems and can often be \
estimated out-of-band. We show that RLS can and should be renormalized with \
observation noise to produce results equivalent to KAL and MAP."
}], "Text",
 CellChangeTimes->{{3.727878623850936*^9, 3.727878709219612*^9}, {
   3.727878861523492*^9, 3.7278788615269413`*^9}, {3.727879302741879*^9, 
   3.727879309849668*^9}, 3.727883517024404*^9, {3.727922726553706*^9, 
   3.727922764150456*^9}, 3.727922954590423*^9, {3.727924470079568*^9, 
   3.727924536073629*^9}, {3.7279245945103197`*^9, 3.727924814835289*^9}, {
   3.7279675670922203`*^9, 3.727967666149938*^9}, {3.727971057289061*^9, 
   3.727971066302681*^9}, {3.728121698098153*^9, 3.7281219113362703`*^9}, {
   3.728251250200307*^9, 3.7282512840101357`*^9}, {3.7282513246052217`*^9, 
   3.728251329374619*^9}, {3.729023929197901*^9, 3.7290239300994596`*^9}, {
   3.729164542139102*^9, 3.72916456944278*^9}, {3.729164610806293*^9, 
   3.729164677156509*^9}, {3.729164919918866*^9, 3.729165054532934*^9}, {
   3.729182136434248*^9, 3.729182214000979*^9}, {3.729191528488492*^9, 
   3.729191529399126*^9}, {3.729191562138418*^9, 3.7291916195642443`*^9}, {
   3.729644842368363*^9, 3.729644891045639*^9}, {3.72979744862106*^9, 
   3.7297974664738607`*^9}, {3.7297975040084763`*^9, 3.729797584823832*^9}, {
   3.731802273118628*^9, 
   3.731802327421598*^9}},ExpressionUUID->"6a6e19cf-bb4f-4ebf-92d0-\
5675f3aa2870"],

Cell[CellGroupData[{

Cell["Reproducing Bishop\[CloseCurlyQuote]s Example", "Subchapter",
 CellChangeTimes->{{3.729165065884509*^9, 
  3.7291650737726173`*^9}},ExpressionUUID->"d04122b3-0bd9-4a07-8e16-\
0eb62f4778b6"],

Cell[CellGroupData[{

Cell["Bishop\[CloseCurlyQuote]s Training Set", "Subsection",
 CellChangeTimes->{{3.729182234376062*^9, 
  3.7291822398475657`*^9}},ExpressionUUID->"5e29a4bc-2b27-406e-b59f-\
74db2a413316"],

Cell[TextData[{
 "First, create a sequence of ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalNu]", "=", "10"}], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "6e69dab0-348e-439f-952d-c4bf86dc91a9"],
 " inputs for a ",
 StyleBox["training set",
  FontSlant->"Italic"],
 ", equally spaced in ",
 Cell[BoxData[
  FormBox[
   RowBox[{"[", 
    RowBox[{
     RowBox[{"0", ".."}], "1"}], "]"}], TraditionalForm]],ExpressionUUID->
  "29ce8c8d-9344-4003-8aa1-108c7bd407ca"],
 ". "
}], "Text",
 CellChangeTimes->{{3.727903592625655*^9, 3.727903632159232*^9}, {
   3.7279036735048943`*^9, 3.727903706547583*^9}, {3.727905942818769*^9, 
   3.727905962112603*^9}, {3.7280864904938383`*^9, 3.72808650130811*^9}, 
   3.7281253834656553`*^9, {3.7290239585551653`*^9, 3.729023962286766*^9}, {
   3.729797599233794*^9, 3.729797625818816*^9}, {3.729798320229357*^9, 
   3.729798328906424*^9}},ExpressionUUID->"1f2ddae9-d226-4854-aaed-\
3e7270210e2d"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "bishopTrainingSetX", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"bishopTrainingSetX", "[", "\[CapitalNu]_", "]"}], ":=", 
   RowBox[{"Array", "[", 
    RowBox[{"Identity", ",", "\[CapitalNu]", ",", 
     RowBox[{"{", 
      RowBox[{"0.", ",", "1."}], "}"}]}], "]"}]}], ";"}], "\n", 
 RowBox[{"ListPlot", "[", 
  RowBox[{"bishopTrainingSetX", "[", "10", "]"}], "]"}]}], "Input",
 CellChangeTimes->{{3.7278793831155243`*^9, 3.727879483430056*^9}, {
  3.7278795217592373`*^9, 3.7278795713344812`*^9}, {3.727879616737006*^9, 
  3.727879619545887*^9}, {3.727879705352076*^9, 3.7278797261345243`*^9}, {
  3.7278805381565742`*^9, 3.727880538743538*^9}, {3.727922980939206*^9, 
  3.7279229886203623`*^9}, {3.729797634646571*^9, 3.7297976426699123`*^9}},
 CellLabel->"In[38]:=",ExpressionUUID->"ca2e499b-f00f-4414-9609-b4647b6d10d6"],

Cell[BoxData[
 GraphicsBox[{{}, {{}, 
    {RGBColor[0.368417, 0.506779, 0.709798], PointSize[0.012833333333333334`],
      AbsoluteThickness[1.6], 
     PointBox[{{1., 0.}, {2., 0.1111111111111111}, {3., 0.2222222222222222}, {
      4., 0.3333333333333333}, {5., 0.4444444444444444}, {6., 
      0.5555555555555556}, {7., 0.6666666666666666}, {8., 
      0.7777777777777777}, {9., 0.8888888888888888}, {10., 
      1.}}]}, {}}, {}, {}, {}, {}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0., 0},
  DisplayFunction->Identity,
  Frame->{{False, False}, {False, False}},
  FrameLabel->{{None, None}, {None, None}},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  ImagePadding->All,
  Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& ), "CopiedValueFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& )}},
  PlotRange->{{0., 10.}, {0, 1.}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.02], 
     Scaled[0.05]}},
  Ticks->{Automatic, Automatic}]], "Output",
 CellChangeTimes->{
  3.7279036576643267`*^9, 3.7279153856605663`*^9, 3.727918037116987*^9, 
   3.7279180948276176`*^9, {3.7279229839121304`*^9, 3.727922989728109*^9}, 
   3.7279241982632713`*^9, {3.727927707284925*^9, 3.727927732385895*^9}, 
   3.727967810497973*^9, 3.72796873344042*^9, 3.727969808476139*^9, 
   3.7279699553203173`*^9, 3.728044351955875*^9, 3.728046448005164*^9, 
   3.728066469870434*^9, 3.728068121014494*^9, 3.728083783783091*^9, 
   3.7280907419079514`*^9, 3.728169445558825*^9, 3.728169541122375*^9, 
   3.7281698232597103`*^9, 3.728169883302211*^9, 3.728252955818722*^9, 
   3.728946256012908*^9, 3.72902290017245*^9, {3.729119978824182*^9, 
   3.729119995825794*^9}, 3.729121072276454*^9, 3.729121110814158*^9, 
   3.729172307690002*^9, 3.729175690740155*^9, 3.7291757911047173`*^9, 
   3.729183412564513*^9, {3.729183447842392*^9, 3.729183460727846*^9}, 
   3.72925593715775*^9, 3.729552301708386*^9, 3.729557876182742*^9, 
   3.729629838166031*^9, 3.729634636127739*^9, 3.729642872393754*^9, 
   3.729642909097967*^9, 3.729643939109083*^9, 3.729647185377458*^9, 
   3.729683202099824*^9, 3.729778155387088*^9, 3.729779233549402*^9, 
   3.729779280671722*^9, 3.729797644246916*^9, 3.731525585016386*^9, 
   3.731527815142128*^9, 3.7315829936704397`*^9, 3.7316702582089243`*^9, 
   3.731671801783867*^9, 3.731671838287574*^9, 3.731802344474712*^9, 
   3.731803352710573*^9, 3.7318370278900337`*^9},
 CellLabel->"Out[40]=",ExpressionUUID->"43aa32eb-add0-4f00-b462-427c4f36bac1"]
}, Open  ]],

Cell[TextData[{
 "Bishop\[CloseCurlyQuote]s ground truth is a single cycle of a sine wave. \
Add noise to a sample taken at the inputs of the training set above. Bishop \
doesn\[CloseCurlyQuote]t state his observation noise, but I guess ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubscriptBox["\[Sigma]", "z"], "=", 
    RowBox[{
     SubscriptBox["\[Sigma]", "t"], "=", "0.30"}]}], TraditionalForm]],
  ExpressionUUID->"f7563510-3ca6-49c1-a9be-eaa9281a75a2"],
 " to create a fake data set that resembles Bishop\[CloseCurlyQuote]s \
qualitatively.\n\nWolfram\[CloseCurlyQuote]s built-in ",
 Cell[BoxData[
  FormBox["NormalDistribution", TraditionalForm]], "Code",ExpressionUUID->
  "391719cb-f0ae-47d9-b6f8-cf0a16d1de30"],
 " takes the standard deviation as its second argument, not the variance. \
Mixing up standard deviation and variance is an easy mistake. Bishop\
\[CloseCurlyQuote]s notation for normal distribution takes variance as second \
argument, so beware. "
}], "Text",
 CellChangeTimes->{{3.727925037995728*^9, 3.7279251079034653`*^9}, {
  3.7281672861902847`*^9, 3.728167315662861*^9}, {3.728217520627878*^9, 
  3.7282175317062597`*^9}, {3.728217692277302*^9, 3.728217821974227*^9}, {
  3.72821832687463*^9, 3.7282183503446493`*^9}, {3.728219468837654*^9, 
  3.728219505064865*^9}, {3.728251312926087*^9, 3.728251372591283*^9}, {
  3.729024054019828*^9, 3.729024066384492*^9}, {3.7291650862455063`*^9, 
  3.7291651414164467`*^9}, {3.729165177227763*^9, 3.729165178485721*^9}, {
  3.729182224031723*^9, 3.7291822276320543`*^9}, {3.729797666011817*^9, 
  3.729797705464027*^9}},ExpressionUUID->"886d53e2-9c58-42a8-83ba-\
2c3c50e31a6d"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{"bishopTrainingSetY", ",", "bishopGroundTruthY"}], "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"bishopGroundTruthY", "[", "xs_", "]"}], ":=", 
   RowBox[{
    RowBox[{
     RowBox[{"Sin", "[", 
      RowBox[{"2.", "\[Pi]", "#"}], "]"}], "&"}], "/@", "xs"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"bishopTrainingSetY", "[", 
    RowBox[{"xs_", ",", "\[Sigma]_"}], "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"n", "=", 
       RowBox[{"Length", "@", "xs"}]}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"bishopGroundTruthY", "[", "xs", "]"}], "\[IndentingNewLine]", 
      "+", 
      RowBox[{"RandomVariate", "[", 
       RowBox[{
        RowBox[{"NormalDistribution", "[", 
         RowBox[{"0.", ",", "\[Sigma]"}], "]"}], ",", "n"}], "]"}]}]}], 
    "]"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.727879752743185*^9, 3.7278799854455643`*^9}, {
  3.727880015690054*^9, 3.7278800794720173`*^9}, {3.727880507980577*^9, 
  3.7278805461972027`*^9}, {3.729175578225967*^9, 3.729175578232574*^9}},
 CellLabel->"In[41]:=",ExpressionUUID->"ea17c6c6-73e8-482d-9173-e74d40acfa12"],

Cell[TextData[{
 "Take a sample of the outputs and assign it the names ",
 Cell[BoxData[
  FormBox["bts", TraditionalForm]], "Code",ExpressionUUID->
  "72d63cd9-b72b-47f5-b59e-8ee44c6dcc64"],
 " for ",
 Cell[BoxData[
  FormBox["bishopTrainingSet", TraditionalForm]], "Code",ExpressionUUID->
  "f9cdc4b8-56b6-4315-84c8-cce498dec61d"],
 ". It isn\[CloseCurlyQuote]t his actual training set, which I didn\
\[CloseCurlyQuote]t find in print, just my simulation."
}], "Text",
 CellChangeTimes->{{3.7278832163983307`*^9, 3.7278832375275517`*^9}, {
  3.727906008140655*^9, 3.727906061879993*^9}, {3.727967692026178*^9, 
  3.727967840843544*^9}, {3.727967872455134*^9, 3.7279678771043777`*^9}, {
  3.727969674731044*^9, 3.727969699819124*^9}, {3.727969774693037*^9, 
  3.727969782528049*^9}, {3.727969836960168*^9, 3.727969942714082*^9}, {
  3.72796998393566*^9, 3.727969992896991*^9}, {3.727970026070797*^9, 
  3.727970373300626*^9}, {3.727970485196838*^9, 3.727970512318493*^9}, {
  3.727970712603229*^9, 3.7279707772612677`*^9}, {3.727971265852014*^9, 
  3.7279713568853807`*^9}, {3.7281671900202827`*^9, 3.7281672837287903`*^9}, {
  3.728167321065092*^9, 3.728167321584338*^9}, {3.729182260744134*^9, 
  3.729182293947283*^9}, {3.7297977262479973`*^9, 
  3.729797728261697*^9}},ExpressionUUID->"bcb70fe7-7930-4e10-aa29-\
d0c91f15c417"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{
   "bishopTrainingSet", ",", "bts", ",", "bishopFake", ",", 
    "bishopFakeSigma"}], "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"bishopFake", "[", 
    RowBox[{"n_", ",", "\[Sigma]_"}], "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"xs", "=", 
       RowBox[{"bishopTrainingSetX", "[", "n", "]"}]}], "}"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"ys", "=", 
         RowBox[{"bishopTrainingSetY", "[", 
          RowBox[{"xs", ",", "\[Sigma]"}], "]"}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"{", 
        RowBox[{"xs", ",", "ys"}], "}"}]}], "]"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"bishopFakeSigma", "=", "0.30"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"bishopTrainingSet", "=", 
   RowBox[{"bts", "=", 
    RowBox[{"bishopFake", "[", 
     RowBox[{"10", ",", "bishopFakeSigma"}], "]"}]}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.72788015184029*^9, 3.727880231778208*^9}, {
   3.727880385369709*^9, 3.727880413342643*^9}, 3.727880526308257*^9, {
   3.727967805222126*^9, 3.72796780531704*^9}, {3.7279697920516977`*^9, 
   3.72796979498647*^9}, {3.727969950515656*^9, 3.727969950591378*^9}, {
   3.727994080862403*^9, 3.727994108975196*^9}, {3.729175578236166*^9, 
   3.7291756088584633`*^9}},
 CellLabel->"In[44]:=",ExpressionUUID->"f8159651-8cde-4010-a415-e872d295ae47"],

Cell["Make a plot like Bishop\[CloseCurlyQuote]s figure 1.7 (page 10).", \
"Text",
 CellChangeTimes->{{3.727906073807754*^9, 3.727906077471641*^9}, {
  3.727915536304657*^9, 3.7279155386681232`*^9}, {3.7279713648223457`*^9, 
  3.727971369779395*^9}},ExpressionUUID->"4a6f7e0c-c2e9-4cd8-970a-\
e86cf976b5a2"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"With", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"lp", "=", 
     RowBox[{"ListPlot", "[", 
      RowBox[{
       RowBox[{"bts", "\[Transpose]"}], ",", "\[IndentingNewLine]", 
       RowBox[{"PlotMarkers", "\[Rule]", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"Graphics", "@", 
           RowBox[{"{", 
            RowBox[{"Blue", ",", 
             RowBox[{"Circle", "[", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"0", ",", "0"}], "}"}], ",", "1"}], "]"}]}], "}"}]}], 
          ",", ".05"}], "}"}]}]}], "]"}]}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Show", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"lp", ",", 
       RowBox[{"(*", " ", 
        RowBox[{"once", " ", "to", " ", "set", " ", "the", " ", "scale"}], 
        " ", "*)"}], "\[IndentingNewLine]", 
       RowBox[{"Plot", "[", 
        RowBox[{
         RowBox[{"Sin", "[", 
          RowBox[{"2.", "\[Pi]", " ", "x"}], "]"}], ",", 
         RowBox[{"{", 
          RowBox[{"x", ",", "0.", ",", "1."}], "}"}], ",", 
         RowBox[{"PlotStyle", "\[Rule]", 
          RowBox[{"{", 
           RowBox[{"Thick", ",", "Green"}], "}"}]}]}], "]"}], ",", 
       "\[IndentingNewLine]", "lp"}], " ", 
      RowBox[{"(*", " ", 
       RowBox[{"again", " ", "to", " ", "overdraw", " ", "the", " ", "plot"}],
        " ", "*)"}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"Frame", "\[Rule]", "True"}], ",", "\[IndentingNewLine]", 
     RowBox[{"FrameLabel", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{"\"\<x\>\"", ",", "\"\<t\>\""}], "}"}]}]}], "]"}]}], 
  "]"}]], "Input",
 CellChangeTimes->{{3.727880085493072*^9, 3.72788013972164*^9}, {
   3.7278802437563953`*^9, 3.7278802581076803`*^9}, {3.7278803034902487`*^9, 
   3.727880361169203*^9}, {3.7278804194474173`*^9, 3.727880429435811*^9}, 
   3.7278806446621532`*^9, {3.7278807572759333`*^9, 3.7278807745809507`*^9}, {
   3.727880893504468*^9, 3.7278809867037153`*^9}, {3.7278810338930473`*^9, 
   3.727881110077335*^9}, {3.7278811411219473`*^9, 3.7278813474824867`*^9}, {
   3.727881617681645*^9, 3.727881731860063*^9}, {3.727882548678594*^9, 
   3.72788267853528*^9}, {3.727882716394725*^9, 3.727882813824841*^9}, {
   3.727882846153562*^9, 3.727882924674261*^9}, {3.72788567102006*^9, 
   3.727885671857286*^9}, {3.727923022530311*^9, 3.727923022847533*^9}, 
   3.7291756286936607`*^9},
 CellLabel->"In[48]:=",ExpressionUUID->"f2335999-3930-4868-b73a-70aff705e87c"],

Cell[BoxData[
 GraphicsBox[{{{}, {
     {RGBColor[0.368417, 0.506779, 0.709798], AbsolutePointSize[6], 
      AbsoluteThickness[1.6], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0., 0.003001658695512032}, Automatic, 
       Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.1111111111111111, 0.7794672403069915}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.2222222222222222, 1.1406569850289172}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.3333333333333333, 0.899734455590184}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.4444444444444444, 0.7026663953142508}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.5555555555555556, 0.2850277206741547}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.6666666666666666, -0.6815240021043126}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.7777777777777777, -0.5295454011747109}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.8888888888888888, -1.0491002960001101}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {1., -0.6664008446591924}, Automatic, 
       Scaled[{0.05, 0.05}]]}, {}}, {}, {}, {}, {}}, {{{}, {}, 
     TagBox[
      {RGBColor[0, 1, 0], Thickness[Large], Opacity[1.], 
       LineBox[CompressedData["
1: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
        "]]},
      Annotation[#, "Charting`Private`Tag$3576#1"]& ]}, {}, {}}, {{}, {
     {RGBColor[0.368417, 0.506779, 0.709798], AbsolutePointSize[6], 
      AbsoluteThickness[1.6], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0., 0.003001658695512032}, Automatic, 
       Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.1111111111111111, 0.7794672403069915}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.2222222222222222, 1.1406569850289172}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.3333333333333333, 0.899734455590184}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.4444444444444444, 0.7026663953142508}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.5555555555555556, 0.2850277206741547}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.6666666666666666, -0.6815240021043126}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.7777777777777777, -0.5295454011747109}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {0.8888888888888888, -1.0491002960001101}, 
       Automatic, Scaled[{0.05, 0.05}]], InsetBox[
       GraphicsBox[
        {RGBColor[0, 0, 1], AbsolutePointSize[6], AbsoluteThickness[1.6], 
         CircleBox[{0, 0}]}], {1., -0.6664008446591924}, Automatic, 
       Scaled[{0.05, 0.05}]]}, {}}, {}, {}, {}, {}}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, 0},
  DisplayFunction->Identity,
  Frame->True,
  FrameLabel->{
    FormBox["\"x\"", TraditionalForm], 
    FormBox["\"t\"", TraditionalForm]},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  ImagePadding->All,
  Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& ), "CopiedValueFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& )}},
  PlotRange->{{0, 1.}, {-1.0491002960001101`, 1.1406569850289172`}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.05], 
     Scaled[0.05]}},
  Ticks->{Automatic, Automatic}]], "Output",
 CellChangeTimes->{{3.727880775294775*^9, 3.727880787730764*^9}, {
   3.727880934685656*^9, 3.7278809872854*^9}, {3.727881034647586*^9, 
   3.72788111070538*^9}, {3.727881149340519*^9, 3.727881273359902*^9}, {
   3.727881331668276*^9, 3.727881367908173*^9}, {3.727881679253851*^9, 
   3.727881732639435*^9}, {3.727882562737458*^9, 3.727882578070189*^9}, {
   3.727882623588429*^9, 3.727882694410623*^9}, {3.727882734556818*^9, 
   3.727882799272423*^9}, {3.727882852380828*^9, 3.727882925334324*^9}, 
   3.7278856759136066`*^9, 3.7278870450627317`*^9, 3.7279153858103523`*^9, 
   3.72791803725655*^9, 3.72791809498518*^9, 3.727923023895686*^9, 
   3.7279241984537888`*^9, 3.727925186689782*^9, {3.7279277074383373`*^9, 
   3.727927732567607*^9}, 3.727967810615572*^9, 3.7279687335582027`*^9, 
   3.727969808589816*^9, 3.7279699554358187`*^9, 3.7280443521874313`*^9, 
   3.728046448171671*^9, 3.7280664700061007`*^9, 3.728068121166772*^9, 
   3.7280837839406548`*^9, 3.728090742104409*^9, 3.728169445708262*^9, 
   3.728169541253911*^9, 3.728169823409259*^9, 3.728169883432933*^9, 
   3.728252955971521*^9, 3.728946256243698*^9, 3.729022900259424*^9, {
   3.729119978973509*^9, 3.729119995969993*^9}, 3.7291210724993067`*^9, 
   3.7291211109977207`*^9, 3.7291723078683023`*^9, 3.7291756908751507`*^9, 
   3.7291757981263313`*^9, 3.729183412685206*^9, {3.72918344796786*^9, 
   3.7291834608971157`*^9}, 3.729255937258317*^9, 3.729552301814382*^9, 
   3.72955787630888*^9, 3.7296298382718487`*^9, 3.729634636236637*^9, 
   3.7296428725154552`*^9, 3.7296429092535467`*^9, 3.7296439391961117`*^9, 
   3.729647185507022*^9, 3.7296832022027597`*^9, 3.729778155560172*^9, 
   3.729779233716967*^9, 3.729779280842063*^9, 3.7315255851251507`*^9, 
   3.731527815281479*^9, 3.731582993842102*^9, 3.731670258306548*^9, 
   3.731671801894014*^9, 3.7316718383814373`*^9, 3.7318024007663183`*^9, 
   3.7318033528057423`*^9, 3.731837028003559*^9},
 CellLabel->"Out[48]=",ImageCache->GraphicsData["CompressedBitmap", "\<\
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
x8fnOnQSkavpdd3/ATCWZvY=\
\>"],ExpressionUUID->"ed306d7c-bc07-49f6-9c49-a596a4eb766a"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Partials: Gradients of the Unknown Parameters", "Subsection",
 CellChangeTimes->{{3.729182306493725*^9, 
  3.7291823233798018`*^9}},ExpressionUUID->"7a8821b4-9a07-46c9-98b4-\
e1b96d1ff277"],

Cell[TextData[{
 "Write a function for partials. Quietly map the indeterminate ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["0", "0"], TraditionalForm]],ExpressionUUID->
  "b579cedc-762e-4d8b-9c45-f853e45c0428"],
 " to 1. Test it symbolically."
}], "Text",
 CellChangeTimes->{{3.727925195515706*^9, 3.727925232785982*^9}, {
   3.7279678941263742`*^9, 3.727967900133898*^9}, {3.72797367998691*^9, 
   3.727973685039398*^9}, 3.728086523246662*^9, {3.72816734159263*^9, 
   3.7281673598690157`*^9}},ExpressionUUID->"584c671b-5ffb-410f-ae13-\
1b86b26deaf8"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "partialsFn", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"partialsFn", "[", 
    RowBox[{"order_", ",", "xs_"}], "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"Transpose", "@", 
      RowBox[{"Quiet", "@", 
       RowBox[{"Table", "[", 
        RowBox[{
         RowBox[{
          SuperscriptBox["#", 
           RowBox[{"i", "-", "1"}]], "/.", 
          RowBox[{"{", 
           RowBox[{"Indeterminate", "\[Rule]", "1"}], "}"}]}], ",", 
         RowBox[{"{", 
          RowBox[{"i", ",", 
           RowBox[{"order", "+", "1"}]}], "}"}]}], "]"}]}]}], "&"}], "@", 
    "xs"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"MatrixForm", "@", 
  RowBox[{"partialsFn", "[", 
   RowBox[{"6", ",", 
    RowBox[{"{", 
     RowBox[{
      SubscriptBox["x", "1"], ",", 
      SubscriptBox["x", "2"], ",", 
      SubscriptBox["x", "\[CapitalMu]"]}], "}"}]}], "]"}]}]}], "Input",
 CellChangeTimes->{{3.727887092392867*^9, 3.7278870953121367`*^9}, {
  3.7278927196950607`*^9, 3.727893003172378*^9}, {3.727903114052039*^9, 
  3.7279031476650763`*^9}, {3.7279033176045437`*^9, 3.727903339378933*^9}, {
  3.727915570017507*^9, 3.727915600803166*^9}, {3.7279156539215097`*^9, 
  3.727915686797736*^9}, {3.727923101166524*^9, 3.727923181040741*^9}},
 CellLabel->"In[49]:=",ExpressionUUID->"29309786-33e3-4d7f-b23c-35b3c9734d36"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"1", 
      SubscriptBox["x", "1"], 
      SubsuperscriptBox["x", "1", "2"], 
      SubsuperscriptBox["x", "1", "3"], 
      SubsuperscriptBox["x", "1", "4"], 
      SubsuperscriptBox["x", "1", "5"], 
      SubsuperscriptBox["x", "1", "6"]},
     {"1", 
      SubscriptBox["x", "2"], 
      SubsuperscriptBox["x", "2", "2"], 
      SubsuperscriptBox["x", "2", "3"], 
      SubsuperscriptBox["x", "2", "4"], 
      SubsuperscriptBox["x", "2", "5"], 
      SubsuperscriptBox["x", "2", "6"]},
     {"1", 
      SubscriptBox["x", "\[CapitalMu]"], 
      SubsuperscriptBox["x", "\[CapitalMu]", "2"], 
      SubsuperscriptBox["x", "\[CapitalMu]", "3"], 
      SubsuperscriptBox["x", "\[CapitalMu]", "4"], 
      SubsuperscriptBox["x", "\[CapitalMu]", "5"], 
      SubsuperscriptBox["x", "\[CapitalMu]", "6"]}
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
 CellChangeTimes->{{3.7279231186573143`*^9, 3.7279231819525948`*^9}, 
   3.7279241985452023`*^9, {3.727927707499826*^9, 3.727927732638883*^9}, 
   3.7279678106408577`*^9, 3.727968733627557*^9, 3.727969808625535*^9, 
   3.727969955460413*^9, 3.728044352257525*^9, 3.728046448251258*^9, 
   3.728066470133565*^9, 3.728068121219434*^9, 3.728083784014492*^9, 
   3.728090742211894*^9, 3.728169445777561*^9, 3.728169541293954*^9, 
   3.7281698234776993`*^9, 3.728169883478408*^9, 3.728252956051774*^9, 
   3.728946256298505*^9, 3.729022900282452*^9, {3.729119979041417*^9, 
   3.7291199960654287`*^9}, 3.729121072577467*^9, 3.729121111088888*^9, 
   3.729172307938603*^9, 3.729175690912595*^9, 3.729175799963489*^9, 
   3.729183412718895*^9, {3.729183448005946*^9, 3.729183460929661*^9}, 
   3.7292559373083487`*^9, 3.7295523018487167`*^9, 3.729557876329398*^9, 
   3.729629838290058*^9, 3.729634636267157*^9, 3.729642872549694*^9, 
   3.729642909372253*^9, 3.729643939223579*^9, 3.7296471855760403`*^9, 
   3.729683202239718*^9, 3.729778155623721*^9, 3.7297792337834044`*^9, 
   3.729779280904265*^9, 3.73152558517445*^9, 3.73152781533629*^9, 
   3.731582993932736*^9, 3.7316702583447237`*^9, 3.73167180195955*^9, 
   3.7316718385290728`*^9, 3.731802424145198*^9, 3.731803352859779*^9, 
   3.731837028056645*^9},
 CellLabel->
  "Out[51]//MatrixForm=",ExpressionUUID->"b1e148c9-ab4d-4aad-bc54-\
438c5e043b47"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["The Observation Equations", "Subsection",
 CellChangeTimes->{{3.7291823695201817`*^9, 3.7291823731744957`*^9}, {
  3.731760646979594*^9, 
  3.731760648339855*^9}},ExpressionUUID->"cabf026b-cd3e-47dc-ac6b-\
00a40636e98f"],

Cell[TextData[{
 "Confer Bishop\[CloseCurlyQuote]s equation 3.3, page 138, where he writes \
the parameters to estimate as ",
 Cell[BoxData[
  FormBox[
   StyleBox["w",
    FontWeight->"Bold"], TraditionalForm]],ExpressionUUID->
  "f93adc3c-853e-4c72-9d86-2aa88377c8d3"],
 " and the observation equation as"
}], "Text",
 CellChangeTimes->{{3.727967934130774*^9, 3.727967994255875*^9}, {
  3.728167384043807*^9, 3.7281673844840384`*^9}, {3.7282203912603188`*^9, 
  3.728220431494154*^9}, {3.7282205477554483`*^9, 3.728220580377705*^9}, {
  3.728220691138853*^9, 3.72822075490273*^9}, {3.728222921609508*^9, 
  3.728222923769473*^9}, {3.72822433008339*^9, 
  3.728224339280476*^9}},ExpressionUUID->"a521c716-257a-46bb-93c0-\
0cb7e74cd04d"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"y", "(", 
    RowBox[{
     StyleBox["x",
      FontWeight->"Bold"], 
     StyleBox[",",
      FontWeight->"Plain"], 
     StyleBox[" ",
      FontWeight->"Plain"], 
     StyleBox["w",
      FontWeight->"Bold"]}], 
    StyleBox[")",
     FontWeight->"Plain"]}], 
   StyleBox["=",
    FontWeight->"Plain"], 
   RowBox[{
    UnderoverscriptBox["\[Sum]", 
     RowBox[{"j", "=", "0"}], "\[CapitalMu]"], 
    RowBox[{
     SubscriptBox[
      StyleBox["w",
       FontWeight->"Plain"], "j"], 
     RowBox[{
      SubscriptBox["\[Phi]", 
       RowBox[{"\[ThinSpace]", "j"}]], "\[ThinSpace]", "(", 
      StyleBox["x",
       FontWeight->"Bold"], ")"}]}]}]}], TraditionalForm]], "DisplayFormula",
 CellChangeTimes->{{3.7282207613079443`*^9, 3.728220889669578*^9}, {
  3.728221929311122*^9, 3.728221929312549*^9}, {3.7282229942899933`*^9, 
  3.728223000986117*^9}, {3.728251451814763*^9, 
  3.728251478938428*^9}},ExpressionUUID->"8ce8ed38-8005-420e-8673-\
a164985fab34"],

Cell[TextData[{
 "(",
 StyleBox["bias",
  FontSlant->"Italic"],
 " incorporated as coefficient ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["w", "0"], TraditionalForm]],ExpressionUUID->
  "47a29354-35e1-4999-8a23-378844599a74"],
 " of ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["0", "th"], TraditionalForm]],ExpressionUUID->
  "856ceccb-b337-46f7-acfb-9cde919fa114"],
 " basis function). This is predictive: you give me concrete inputs ",
 Cell[BoxData[
  FormBox[
   StyleBox["x",
    FontWeight->"Bold"], TraditionalForm]],ExpressionUUID->
  "15dedbdc-ea13-4583-be2d-b0f2fd3052c4"],
 ", parameters ",
 Cell[BoxData[
  FormBox[
   StyleBox["w",
    FontWeight->"Bold"], TraditionalForm]],ExpressionUUID->
  "5c7a5a42-af1e-409a-a658-bfca1a86f03c"],
 ", and I\[CloseCurlyQuote]ll give you a predicted observation ",
 Cell[BoxData[
  FormBox["y", TraditionalForm]],ExpressionUUID->
  "6aae751e-38d8-4953-867b-5863b83af9f4"],
 " in terms of ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalMu]", "+", "1"}], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "9695c06c-b4ec-4727-8d09-f402312042ba"],
 " basis functions ",
 Cell[BoxData[
  FormBox["\[Phi]", TraditionalForm]],ExpressionUUID->
  "81dd4bd5-3e34-40e2-8c3d-0e0c557b5c29"],
 " corresponding to the ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalMu]", "+", "1"}], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "43b2d63e-6d89-4612-9554-3a508721c906"],
 " unknown parameters. For polynomial basis functions, the number of \
parameters is one more than the order ",
 Cell[BoxData[
  FormBox["\[CapitalMu]", TraditionalForm]],ExpressionUUID->
  "ab13ff31-c2c7-47c2-8dd5-58fb42fbf222"],
 " of the polynomials. The basis functions can be anything, however: \
wavelets, Fourier components, etc.\n\nBishop (inexplicably) converts ",
 Cell[BoxData[
  FormBox[
   StyleBox["w",
    FontWeight->"Bold"], TraditionalForm]],ExpressionUUID->
  "2413a212-ea76-40c0-9640-4e8b71d6160d"],
 " into a covector and writes"
}], "Text",
 CellChangeTimes->{{3.728220906295454*^9, 3.728220946192494*^9}, {
   3.7282218953744383`*^9, 3.728221919178042*^9}, {3.728222933472761*^9, 
   3.728222989706678*^9}, {3.728223024410286*^9, 3.728223057641677*^9}, {
   3.72822435625596*^9, 3.728224387983367*^9}, 3.728251485977022*^9, 
   3.729119179755419*^9, {3.72916521124009*^9, 3.729165279052802*^9}, {
   3.7291823881914263`*^9, 3.7291824219583178`*^9}, {3.729644981843032*^9, 
   3.729644984372673*^9}, {3.729797791815206*^9, 
   3.72979787349229*^9}},ExpressionUUID->"77007d50-8c72-49e2-8ffc-\
25028cfd6d20"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"y", "(", 
    RowBox[{
     StyleBox["x",
      FontWeight->"Bold"], 
     StyleBox[",",
      FontWeight->"Plain"], 
     StyleBox[" ",
      FontWeight->"Plain"], 
     StyleBox["w",
      FontWeight->"Bold"]}], 
    StyleBox[")",
     FontWeight->"Plain"]}], 
   StyleBox["=",
    FontWeight->"Plain"], 
   RowBox[{
    RowBox[{
     StyleBox["w",
      FontWeight->"Bold"], 
     StyleBox["\[Transpose]",
      FontWeight->"Plain"]}], 
    RowBox[{
     StyleBox["\[Phi]",
      FontWeight->"Bold"], 
     StyleBox["\[ThinSpace]",
      FontWeight->"Plain"], "(", 
     StyleBox["x",
      FontWeight->"Bold"], 
     StyleBox[")",
      FontWeight->"Plain"]}]}]}], TraditionalForm]], "DisplayFormula",
 CellChangeTimes->{{3.7282219448855343`*^9, 
  3.728222027597753*^9}},ExpressionUUID->"ddc70e3c-e350-4b18-b0d8-\
0e84969e5977"],

Cell[TextData[{
 "where ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    StyleBox["\[Phi]",
     FontWeight->"Bold"], "\[ThinSpace]", "(", 
    StyleBox["x",
     FontWeight->"Bold"], ")"}], TraditionalForm]],ExpressionUUID->
  "7664d159-29b2-44e2-8792-094becf35ae2"],
 " is an ",
 Cell[BoxData[
  FormBox[
   RowBox[{"(", 
    RowBox[{"\[CapitalMu]", "+", "1"}], ")"}], TraditionalForm]],
  ExpressionUUID->"2c7292a6-4c65-41e9-b006-06cbefd16de3"],
 "-dimensional column-vector of basis functions, the transpose of one row of \
our partials matrix ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "ed495fe0-6173-47f1-97f1-6ccd7a93693a"],
 ". We claim it\[CloseCurlyQuote]s better always to think of partials or \
gradients as values of differential forms, thus covectors (row vectors or \
covariant vectors, see ",
 ButtonBox["https://goo.gl/DkeVmM",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://goo.gl/DkeVmM"], None},
  ButtonNote->"https://goo.gl/DkeVmM"],
 ", ",
 ButtonBox["https://goo.gl/JgzqLR",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://goo.gl/JgzqLR"], None},
  ButtonNote->"https://goo.gl/JgzqLR"],
 ", and ",
 ButtonBox["https://goo.gl/4TcF4T",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://goo.gl/4TcF4T"], None},
  ButtonNote->"https://goo.gl/4TcF4T"],
 "). \n\nTo find best-fit values for ",
 Cell[BoxData[
  FormBox[
   StyleBox["w",
    FontWeight->"Bold"], TraditionalForm]],ExpressionUUID->
  "2e0cbb6f-7787-4b3a-9367-89d4bc1761dd"],
 ", rows of the partials matrix ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "4ef83fad-5c97-4ae5-98df-5042206ebc41"],
 " are the covector gradients of ",
 Cell[BoxData[
  FormBox["y", TraditionalForm]],ExpressionUUID->
  "c7e242fb-2722-4ae6-9a2b-3e2d84e871a3"],
 " with respect to ",
 Cell[BoxData[
  FormBox[
   StyleBox["w",
    FontWeight->"Bold"], TraditionalForm]],ExpressionUUID->
  "baff650f-684a-47d3-95c6-278ac2b4a93c"],
 ". We prefer to write"
}], "Text",
 CellChangeTimes->{{3.728222034989254*^9, 3.728222053237129*^9}, {
   3.728222178848859*^9, 3.7282222660799637`*^9}, {3.728222300000989*^9, 
   3.7282223904929523`*^9}, {3.7282228551572657`*^9, 3.728222859737496*^9}, {
   3.728223076788225*^9, 3.728223190463003*^9}, {3.728223230865528*^9, 
   3.728223361801167*^9}, 3.728223984636827*^9, {3.7282240554498873`*^9, 
   3.728224092328535*^9}, {3.728224400399331*^9, 3.728224741229491*^9}, {
   3.728224776796547*^9, 3.728224809363667*^9}, {3.7282517358200502`*^9, 
   3.7282517662896633`*^9}, {3.729091174357189*^9, 3.7290911785502853`*^9}, {
   3.729091212251935*^9, 3.729091219775629*^9}, {3.729091277188416*^9, 
   3.7290913266532917`*^9}, {3.72909268413879*^9, 3.729092706422126*^9}, {
   3.729119179778685*^9, 3.7291191797984324`*^9}, {3.729120346504904*^9, 
   3.7291203520894012`*^9}, {3.729165311843924*^9, 3.729165352537273*^9}, {
   3.7297978998390903`*^9, 
   3.7297979011646757`*^9}},ExpressionUUID->"173108f7-73b5-47f1-ad97-\
5c2e132d79f4"],

Cell[CellGroupData[{

Cell[TextData[{
 "observations as an ",
 Cell[BoxData[
  FormBox["\[CapitalNu]", TraditionalForm]],ExpressionUUID->
  "fcfdbf6a-2e88-4194-8eb9-62448305406d"],
 "-dimensional column-vector ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[CapitalZeta]", 
    RowBox[{"\[VeryThinSpace]", "\[CapitalNu]"}]], TraditionalForm]],
  ExpressionUUID->"7f371c41-2439-49ff-a405-bbbac410c97c"],
 " with elements ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Zeta]", 
    RowBox[{"\[VeryThinSpace]", 
     RowBox[{"j", "\[ThinSpace]", "\[Element]", "\[ThinSpace]", 
      RowBox[{"[", "\[ThinSpace]", 
       RowBox[{
        RowBox[{"1", "\[ThinSpace]", ".."}], "\[CapitalNu]"}], "\[ThinSpace]",
        "]"}]}]}]], TraditionalForm]],ExpressionUUID->
  "31127627-edad-47a8-807a-e6bbbe593f86"]
}], "Item",
 CellChangeTimes->{{3.728222034989254*^9, 3.728222053237129*^9}, {
   3.728222178848859*^9, 3.7282222660799637`*^9}, {3.728222300000989*^9, 
   3.7282223904929523`*^9}, {3.7282228551572657`*^9, 3.728222859737496*^9}, {
   3.728223076788225*^9, 3.728223190463003*^9}, {3.728223230865528*^9, 
   3.728223361801167*^9}, 3.728223984636827*^9, {3.7282240554498873`*^9, 
   3.728224092328535*^9}, {3.728224400399331*^9, 3.728224741229491*^9}, {
   3.728224776796547*^9, 3.728224809363667*^9}, {3.7282517358200502`*^9, 
   3.728251740048966*^9}, {3.728251771407675*^9, 3.728251772575143*^9}, {
   3.729029834166656*^9, 3.7290298371502934`*^9}, {3.72912036382929*^9, 
   3.7291203684585857`*^9}, {3.729645042322447*^9, 
   3.7296450425379868`*^9}},ExpressionUUID->"fd6a76be-08c1-4926-a786-\
56d957ea6dbb"],

Cell[TextData[{
 "the model or unknown parameters, an ",
 Cell[BoxData[
  FormBox[
   RowBox[{"(", 
    RowBox[{"\[CapitalMu]", "+", "1"}], ")"}], TraditionalForm]],
  ExpressionUUID->"34093d14-aa35-4214-a3e2-8b50e8957f15"],
 "-dimensional column-vector ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[CapitalXi]", 
    RowBox[{"\[ThinSpace]", 
     RowBox[{
      RowBox[{"(", 
       RowBox[{"\[CapitalMu]", "+", "1"}], ")"}], "\[Times]", "1"}]}]], 
   TraditionalForm]],ExpressionUUID->"27530d6a-94c4-4ec6-98d8-e68dfb593b21"],
 " with elements ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Xi]", 
    RowBox[{"\[ThinSpace]", 
     RowBox[{"i", "\[ThinSpace]", "\[Element]", "\[ThinSpace]", 
      RowBox[{"[", "\[ThinSpace]", 
       RowBox[{
        RowBox[{"0", "\[ThinSpace]", ".."}], "\[CapitalMu]"}], "\[ThinSpace]",
        "]"}]}]}]], TraditionalForm]],ExpressionUUID->
  "18943418-6c16-48be-9e34-aa1a1b321058"]
}], "Item",
 CellChangeTimes->{{3.728222034989254*^9, 3.728222053237129*^9}, {
   3.728222178848859*^9, 3.7282222660799637`*^9}, {3.728222300000989*^9, 
   3.7282223904929523`*^9}, {3.7282228551572657`*^9, 3.728222859737496*^9}, {
   3.728223076788225*^9, 3.728223190463003*^9}, {3.728223230865528*^9, 
   3.728223361801167*^9}, 3.728223984636827*^9, {3.7282240554498873`*^9, 
   3.728224092328535*^9}, {3.728224400399331*^9, 3.728224741229491*^9}, {
   3.728224776796547*^9, 3.728224809363667*^9}, {3.7282517358200502`*^9, 
   3.728251740048966*^9}, {3.728251771407675*^9, 3.7282517814515944`*^9}, {
   3.7282518993121*^9, 3.7282519004727907`*^9}, {3.729029844861236*^9, 
   3.72902984786119*^9}, {3.729120316833633*^9, 3.729120321664834*^9}, {
   3.729645058784465*^9, 3.729645058784536*^9}, {3.729797943877902*^9, 
   3.729797958453072*^9}},ExpressionUUID->"8fd3a815-7a28-430b-901f-\
356c01956330"],

Cell[TextData[{
 "partials matrix as ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["A", 
    RowBox[{"N", "\[Times]", 
     RowBox[{"(", 
      RowBox[{"\[CapitalMu]", "+", "1"}], ")"}]}]], TraditionalForm]],
  ExpressionUUID->"d3592327-6324-4fd1-8aca-3364bb7df57a"]
}], "Item",
 CellChangeTimes->{{3.728222034989254*^9, 3.728222053237129*^9}, {
   3.728222178848859*^9, 3.7282222660799637`*^9}, {3.728222300000989*^9, 
   3.7282223904929523`*^9}, {3.7282228551572657`*^9, 3.728222859737496*^9}, {
   3.728223076788225*^9, 3.728223190463003*^9}, {3.728223230865528*^9, 
   3.728223361801167*^9}, 3.728223984636827*^9, {3.7282240554498873`*^9, 
   3.728224092328535*^9}, {3.728224400399331*^9, 3.728224741229491*^9}, {
   3.728224776796547*^9, 3.728224809363667*^9}, {3.7282517358200502`*^9, 
   3.728251740048966*^9}, {3.728251771407675*^9, 3.728251789543252*^9}, {
   3.72825189594316*^9, 3.7282518961283197`*^9}, {3.729029865577499*^9, 
   3.7290298774959583`*^9}, {3.729797981334482*^9, 
   3.7297979898657427`*^9}},ExpressionUUID->"88c4c2dd-b425-47ef-8c71-\
edb1850e2691"]
}, Open  ]],

Cell[TextData[{
 "Bishop calls our partials matrix the ",
 StyleBox["design matrix",
  FontSlant->"Italic"],
 " in his equation 3.16, page 142, consisting of values of the basis \
functions at the concrete inputs ",
 Cell[BoxData[
  FormBox[
   SubscriptBox[
    StyleBox["x",
     FontWeight->"Bold"], 
    RowBox[{"n", "\[ThinSpace]", "\[Element]", "\[ThinSpace]", 
     RowBox[{"[", 
      RowBox[{
       RowBox[{"1", ".."}], "N"}], "]"}]}]], TraditionalForm]],
  ExpressionUUID->"d2561181-7429-4cc2-999c-7fe2b5f36bac"],
 ". Bishop must (more cumbersomely) work in the dual of our formulation. \n\n\
We prefer to write as follows: the covector rows of the design matrix terms \
as polynomial basis functions evaluated at the input points ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["x", 
    RowBox[{"n", "\[ThinSpace]", "\[Element]", "\[ThinSpace]", 
     RowBox[{"[", 
      RowBox[{
       RowBox[{"1", ".."}], "\[CapitalNu]"}], "]"}]}]], TraditionalForm]],
  ExpressionUUID->"c0cfc668-a741-4199-891b-2bde10b355d7"],
 ":"
}], "Text",
 CellChangeTimes->{{3.728222034989254*^9, 3.728222053237129*^9}, {
   3.728222178848859*^9, 3.7282222660799637`*^9}, {3.728222300000989*^9, 
   3.7282223904929523`*^9}, {3.7282228551572657`*^9, 3.728222859737496*^9}, {
   3.728223076788225*^9, 3.728223190463003*^9}, {3.728223230865528*^9, 
   3.728223361801167*^9}, 3.728223984636827*^9, {3.7282240554498873`*^9, 
   3.728224092328535*^9}, {3.728224400399331*^9, 3.728224741229491*^9}, {
   3.728224776796547*^9, 3.728224809363667*^9}, {3.7282517358200502`*^9, 
   3.728251740048966*^9}, {3.728251771407675*^9, 3.728251888355431*^9}, {
   3.729029892321496*^9, 3.729029983337439*^9}, {3.7291204222110157`*^9, 
   3.729120492782894*^9}, {3.7291653714940968`*^9, 3.729165462908938*^9}, {
   3.729182456005975*^9, 
   3.7291824795949993`*^9}},ExpressionUUID->"3308f821-1e8b-4ae5-b21a-\
329f44c14a1b"],

Cell[BoxData[
 FormBox[
  RowBox[{"Z", "  ", "=", "  ", 
   RowBox[{
    RowBox[{"A", "\[CenterDot]", "\[CapitalXi]"}], "  ", "=", "  ", 
    RowBox[{
     RowBox[{"(", GridBox[{
        {
         SubscriptBox["\[Zeta]", "0"]},
        {
         SubscriptBox["\[Zeta]", "1"]},
        {"\[VerticalEllipsis]"},
        {
         SubscriptBox["\[Zeta]", "\[CapitalNu]"]}
       }], ")"}], "  ", "=", "   ", 
     RowBox[{
      RowBox[{
       StyleBox[
        RowBox[{"(", GridBox[{
           {
            RowBox[{"1", "=", 
             SubsuperscriptBox["x", "1", "0"]}], 
            SubscriptBox["x", "1"], 
            SubsuperscriptBox["x", "1", "2"], "\[CenterEllipsis]", 
            SubsuperscriptBox["x", "1", "M"]},
           {
            RowBox[{"1", "=", 
             SubsuperscriptBox["x", "2", "0"]}], 
            SubscriptBox["x", "2"], 
            SubsuperscriptBox["x", "2", "2"], "\[CenterEllipsis]", 
            SubsuperscriptBox["x", "2", "M"]},
           {"\[VerticalEllipsis]", "\[VerticalEllipsis]", " ", 
            "\[DescendingEllipsis]", "\[VerticalEllipsis]"},
           {
            RowBox[{"1", "=", 
             SubsuperscriptBox["x", "N", "0"]}], 
            SubscriptBox["x", "N"], 
            SubsuperscriptBox["x", "N", "2"], "\[CenterEllipsis]", 
            SubsuperscriptBox["x", "N", "M"]}
          }], ")"}],
        FontWeight->"Plain"], "  ", "\[CenterDot]", "  ", 
       RowBox[{"(", GridBox[{
          {
           SubscriptBox["\[Xi]", "0"]},
          {
           SubscriptBox["\[Xi]", "1"]},
          {"\[VerticalEllipsis]"},
          {
           SubscriptBox["\[Xi]", "\[CapitalMu]"]}
         }], ")"}]}], "  ", "+", "  ", "noise"}]}]}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.7282223267202578`*^9, 3.728222330771399*^9}, {
  3.728223414452943*^9, 3.728223474859379*^9}, {3.728223514299732*^9, 
  3.728223975929124*^9}, {3.728224109293193*^9, 3.728224109294752*^9}, {
  3.728224191499645*^9, 3.728224196666141*^9}, {3.728947752192189*^9, 
  3.728947823567884*^9}, {3.728949775673676*^9, 3.728949826088863*^9}, {
  3.729109560005604*^9, 3.72910969334587*^9}, {3.729109729502664*^9, 
  3.729109798273975*^9}, {3.729645085890316*^9, 
  3.729645106992324*^9}},ExpressionUUID->"23e476e6-a928-4d95-9eec-\
ebe62c08fd2e"],

Cell[TextData[{
 "then packed up into rows of the ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "867233d0-d313-41bb-ac38-e2b5260ac135"],
 " matrix. "
}], "Text",
 CellChangeTimes->{{3.729120500205209*^9, 
  3.729120518926064*^9}},ExpressionUUID->"0f3864f6-d0cf-4e57-bf7d-\
26b4de3792a9"],

Cell[BoxData[
 FormBox[
  RowBox[{"Z", "  ", "=", "  ", 
   RowBox[{
    RowBox[{"A", "\[CenterDot]", "\[CapitalXi]"}], "  ", "=", "  ", 
    RowBox[{
     RowBox[{"(", GridBox[{
        {
         SubscriptBox["\[Zeta]", "0"]},
        {
         SubscriptBox["\[Zeta]", "1"]},
        {"\[VerticalEllipsis]"},
        {
         SubscriptBox["\[Zeta]", "\[CapitalNu]"]}
       }], ")"}], "  ", "=", "   ", 
     RowBox[{
      RowBox[{
       SubscriptBox[
        StyleBox[
         RowBox[{"(", GridBox[{
            {
             RowBox[{
              SubscriptBox[
               RowBox[{
                StyleBox["A",
                 FontWeight->"Plain"], 
                StyleBox["\[ThinSpace]",
                 FontWeight->"Bold"]}], 
               RowBox[{"1", "\[Times]", 
                RowBox[{"(", 
                 RowBox[{"\[CapitalMu]", "+", "1"}], ")"}]}]], 
              RowBox[{"(", 
               SubscriptBox["x", "1"], ")"}]}]},
            {
             RowBox[{
              SubscriptBox[
               RowBox[{
                StyleBox["A",
                 FontWeight->"Plain"], 
                StyleBox["\[ThinSpace]",
                 FontWeight->"Bold"]}], 
               RowBox[{"1", "\[Times]", 
                RowBox[{"(", 
                 RowBox[{"\[CapitalMu]", "+", "1"}], ")"}]}]], 
              RowBox[{"(", 
               SubscriptBox["x", "2"], ")"}]}]},
            {"\[VerticalEllipsis]"},
            {
             RowBox[{
              SubscriptBox[
               RowBox[{
                StyleBox["A",
                 FontWeight->"Plain"], 
                StyleBox["\[ThinSpace]",
                 FontWeight->"Bold"]}], 
               RowBox[{"1", "\[Times]", 
                RowBox[{"(", 
                 RowBox[{"\[CapitalMu]", "+", "1"}], ")"}]}]], 
              RowBox[{"(", 
               SubscriptBox["x", "\[CapitalNu]"], ")"}]}]}
           }], ")"}],
         FontWeight->"Plain"], 
        RowBox[{"\[CapitalNu]", "\[Times]", 
         RowBox[{"(", 
          RowBox[{"\[CapitalMu]", "+", "1"}], ")"}]}]], "  ", "\[CenterDot]", 
       "  ", 
       RowBox[{"(", GridBox[{
          {
           SubscriptBox["\[Xi]", "0"]},
          {
           SubscriptBox["\[Xi]", "1"]},
          {"\[VerticalEllipsis]"},
          {
           SubscriptBox["\[Xi]", "\[CapitalMu]"]}
         }], ")"}]}], "  ", "+", "  ", "noise"}]}]}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.7282223267202578`*^9, 3.728222330771399*^9}, {
  3.728223414452943*^9, 3.728223474859379*^9}, {3.728223514299732*^9, 
  3.728223975929124*^9}, {3.728224109293193*^9, 3.728224109294752*^9}, {
  3.728224191499645*^9, 3.728224196666141*^9}, {3.728947752192189*^9, 
  3.728947823567884*^9}, {3.728949775673676*^9, 3.728949826088863*^9}, {
  3.7297980290173683`*^9, 
  3.729798052887404*^9}},ExpressionUUID->"e134c690-45ab-4081-a08d-\
6622b7f509c1"]
}, Open  ]],

Cell[CellGroupData[{

Cell["MLE: The Normal Equations", "Subsection",
 CellChangeTimes->{{3.728251929759521*^9, 
  3.728251940262474*^9}},ExpressionUUID->"20e5a4b4-841a-4943-8ffd-\
e4462ff9e392"],

Cell["\<\
Mechanize the normal equations for comparison purposes; we expect them to \
over-fit.\
\>", "Text",
 CellChangeTimes->{{3.7279232272996387`*^9, 3.727923264174778*^9}, {
  3.727925248541918*^9, 3.7279252612235193`*^9}, {3.728219535976645*^9, 
  3.728219544909062*^9}, {3.728251418408484*^9, 3.728251422388431*^9}, {
  3.729024215377202*^9, 3.729024217223057*^9}, {3.729165197628982*^9, 
  3.729165198403118*^9}, {3.7291823464471197`*^9, 
  3.7291823613313932`*^9}},ExpressionUUID->"c6bef0ca-8f63-4549-85c2-\
b7a696745332"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "mleFit", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"mleFit", "[", 
    RowBox[{"\[CapitalMu]_", ",", "trainingSet_"}], "]"}], ":=", 
   "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"xs", "=", 
        RowBox[{
        "trainingSet", "\[LeftDoubleBracket]", "1", 
         "\[RightDoubleBracket]"}]}], ",", 
       RowBox[{"ys", "=", 
        RowBox[{
        "trainingSet", "\[LeftDoubleBracket]", "2", 
         "\[RightDoubleBracket]"}]}]}], "}"}], ",", "\[IndentingNewLine]", 
     StyleBox[
      RowBox[{
       RowBox[{"PseudoInverse", "[", 
        RowBox[{"partialsFn", "[", 
         RowBox[{"\[CapitalMu]", ",", "xs"}], "]"}], "]"}], ".", "ys"}],
      Background->RGBColor[1, 1, 0]]}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"mleFit", "[", 
  RowBox[{"3", ",", "bts"}], "]"}]}], "Input",
 CellChangeTimes->{{3.727885728192296*^9, 3.727885779639097*^9}, {
   3.727885809907544*^9, 3.727885814458734*^9}, {3.727886129093534*^9, 
   3.7278861410970383`*^9}, {3.72788617438813*^9, 3.7278862220128107`*^9}, {
   3.7278865585658693`*^9, 3.727886599363595*^9}, {3.7279031627619*^9, 
   3.727903227220593*^9}, {3.727913081988744*^9, 3.7279130820838013`*^9}, {
   3.727913123878634*^9, 3.727913123932819*^9}, {3.728090725899406*^9, 
   3.7280907259084253`*^9}, {3.728169613067173*^9, 3.728169613076036*^9}, 
   3.729175629972382*^9, {3.7291764342927237`*^9, 3.7291764366839447`*^9}},
 CellLabel->"In[52]:=",ExpressionUUID->"119b0dce-ddb9-4f1a-b3bf-f2677c37d430"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"-", "0.010564904793739414`"}], ",", "10.086592178128138`", ",", 
   RowBox[{"-", "26.34684426926654`"}], ",", "15.573071352566242`"}], 
  "}"}]], "Output",
 CellChangeTimes->{
  3.7278862229627943`*^9, {3.727886559667815*^9, 3.727886599739743*^9}, {
   3.72790316911255*^9, 3.727903214869055*^9}, 3.7279033439958277`*^9, {
   3.727913077175877*^9, 3.727913082662711*^9}, 3.727913124658298*^9, 
   3.727915385897655*^9, 3.727915689226351*^9, 3.727918037352195*^9, 
   3.727918095083848*^9, 3.7279241986227837`*^9, {3.727927707553419*^9, 
   3.727927732702104*^9}, 3.727967810695971*^9, 3.727968733693976*^9, 
   3.7279698086933317`*^9, 3.727969955502687*^9, 3.728044352304865*^9, 
   3.728046448308305*^9, 3.728066470172489*^9, 3.72806812129386*^9, 
   3.728083784080934*^9, 3.728090742292589*^9, 3.72816944582929*^9, 
   3.728169541357428*^9, 3.728169823527856*^9, 3.728169883537332*^9, 
   3.728252956118902*^9, 3.7289462563501463`*^9, 3.729022900336874*^9, {
   3.729119979107937*^9, 3.729119996139695*^9}, 3.729121072645164*^9, 
   3.7291211111233273`*^9, 3.7291723080042467`*^9, 3.7291756909413757`*^9, 
   3.7291758020892*^9, 3.7291834127551937`*^9, {3.7291834480703287`*^9, 
   3.729183460969283*^9}, 3.729255937373231*^9, 3.729552301877532*^9, 
   3.729557876381481*^9, 3.7296298383478403`*^9, 3.729634636327812*^9, 
   3.729642872576435*^9, 3.7296429094051437`*^9, 3.7296439392773237`*^9, 
   3.729647185633141*^9, 3.7296832022663383`*^9, 3.7297781556886253`*^9, 
   3.729779233854649*^9, 3.7297792809555397`*^9, 3.731525585222241*^9, 
   3.7315278154017878`*^9, 3.731582994016753*^9, 3.731670258368471*^9, 
   3.73167180200987*^9, 3.731671838558537*^9, 3.731802526064639*^9, 
   3.7318033528859863`*^9, 3.7318370281072187`*^9},
 CellLabel->"Out[54]=",ExpressionUUID->"c79c95ce-82e9-4c45-a4a9-a868f0ee1005"]
}, Open  ]],

Cell["A convenience function:", "Text",
 CellChangeTimes->{{3.729798126892275*^9, 
  3.729798131955408*^9}},ExpressionUUID->"1547d31a-8f58-4224-8c92-\
e4055e4c716b"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "symbolicPowers", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"symbolicPowers", "[", 
    RowBox[{"variable_", ",", "order_"}], "]"}], ":=", "\[IndentingNewLine]", 
   
   RowBox[{
    RowBox[{"partialsFn", "[", 
     RowBox[{"order", ",", 
      RowBox[{"{", "variable", "}"}]}], "]"}], "\[LeftDoubleBracket]", "1", 
    "\[RightDoubleBracket]"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.7279153202694693`*^9, 3.727915371067972*^9}, {
  3.7279237255692472`*^9, 3.727923807685313*^9}, {3.729182514215464*^9, 
  3.729182515145398*^9}},
 CellLabel->"In[55]:=",ExpressionUUID->"fcd9ad29-609b-4b87-addc-958717781912"],

Cell["\<\
The normal equations as a symbolic polynomial. Notice we can increase the \
order beyond the number of data, creating an underdetermined system. This is \
not typical\.7f in real-world data processing. Usually the number of data \
exceed the order and the system is overdetermined. The pseudoinverse is \
agnostic to the distinction.\
\>", "Text",
 CellChangeTimes->{{3.728086616407036*^9, 3.728086644421227*^9}, {
  3.728167395574012*^9, 3.7281673997415857`*^9}, {3.728219572416009*^9, 
  3.728219595133831*^9}, {3.729645137300458*^9, 3.729645224959401*^9}, {
  3.731802551374851*^9, 
  3.731802556390719*^9}},ExpressionUUID->"2e09cfb4-b1d0-4784-b6b6-\
471044a2ea96"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "x", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"symbolicPowers", "[", 
     RowBox[{"x", ",", "\[CapitalMu]"}], "]"}], ".", 
    RowBox[{"mleFit", "[", 
     RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
      "\[CapitalMu]", ",", "3", ",", 
       "\"\<polynomial order \[CapitalMu]\>\""}], "}"}], ",", "0", ",", "16", 
     ",", "1", ",", 
     RowBox[{"Appearance", "\[Rule]", 
      RowBox[{"{", "\"\<Labeled\>\"", "}"}]}]}], "}"}]}], "]"}]}], "Input",
 CellChangeTimes->{{3.7280866505961733`*^9, 3.728086772996965*^9}, 
   3.728086803589117*^9, 3.728090725912261*^9, 3.7281696130841227`*^9, 
   3.7291756311754827`*^9, {3.729175826437456*^9, 3.7291758460147743`*^9}},
 CellLabel->"In[57]:=",ExpressionUUID->"98a7f42f-5743-430d-a4cf-7e4a7c2d5065"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`\[CapitalMu]$$ = 3, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`\[CapitalMu]$$], 3, "polynomial order \[CapitalMu]"},
       0, 16, 1}}, Typeset`size$$ = {499., {1., 18.}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = 
    True, $CellContext`\[CapitalMu]$3615$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, "Variables" :> {$CellContext`\[CapitalMu]$$ = 3}, 
      "ControllerVariables" :> {
        Hold[$CellContext`\[CapitalMu]$$, $CellContext`\[CapitalMu]$3615$$, 
         0]}, "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> Dot[
        $CellContext`symbolicPowers[$CellContext`x, \
$CellContext`\[CapitalMu]$$], 
        $CellContext`mleFit[$CellContext`\[CapitalMu]$$, $CellContext`bts]], 
      "Specifications" :> {{{$CellContext`\[CapitalMu]$$, 3, 
          "polynomial order \[CapitalMu]"}, 0, 16, 1, 
         Appearance -> {"Labeled"}}}, "Options" :> {}, "DefaultOptions" :> {}],
     ImageSizeCache->{565., {72., 80.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{
  3.728086773562842*^9, 3.728086804275236*^9, 3.728090742426281*^9, 
   3.7281694459480057`*^9, 3.728169541460916*^9, 3.728169823628757*^9, 
   3.728169883652279*^9, 3.728225863858274*^9, 3.728252956249748*^9, 
   3.728946256894178*^9, 3.729022900437813*^9, {3.729119979237938*^9, 
   3.7291199962606564`*^9}, 3.729121072777959*^9, 3.729121111249694*^9, 
   3.7291723081374826`*^9, 3.729175691045731*^9, {3.729175810410253*^9, 
   3.729175846848763*^9}, 3.729182527081111*^9, 3.729183412855047*^9, {
   3.7291834481917963`*^9, 3.729183461081573*^9}, 3.729255937827094*^9, 
   3.729552301962193*^9, 3.729557876456039*^9, 3.729629838836141*^9, 
   3.7296346365430202`*^9, 3.729642872651252*^9, 3.729642909488571*^9, 
   3.7296439393563423`*^9, 3.729647185741205*^9, 3.729683202341844*^9, 
   3.729778155770583*^9, 3.7297792339418173`*^9, 3.729779281028274*^9, 
   3.731525585815942*^9, 3.731527815989522*^9, 3.731582994130941*^9, 
   3.731670259033853*^9, 3.7316718020775957`*^9, 3.731671838622099*^9, 
   3.731802568828367*^9, 3.731803352930781*^9, 3.731837028630254*^9},
 CellLabel->"Out[58]=",ExpressionUUID->"8f83364c-c8bb-4955-bb06-da2aeb97f709"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["RLS: Recurrent Least Squares", "Subsection",
 CellChangeTimes->{{3.72825197766994*^9, 
  3.72825198556595*^9}},ExpressionUUID->"12711458-3802-48cf-a8a9-\
c0133c3ac7ef"],

Cell[TextData[{
 "RLS is regularized by its a-priori estimate of the unknown parameters and \
its a-priori information matrix. Use the slider below to see that once the \
minimum info becomes too large, the \[CapitalLambda] matrix becomes \
ill-conditioned: pink warning message appear from the Wolfram kernel, and the \
solution is numerically suspect. In the rest of this paper, we eliminate \
these error message by applying Wolfram\[CloseCurlyQuote]s ",
 Cell[BoxData[
  FormBox["Quiet", TraditionalForm]], "Code",ExpressionUUID->
  "9b505f9f-26c0-4b35-9fff-cb61a0fb8312"],
 " because we notice, numerically, that ill-conditioning of the information \
matrix does not seem to be harmful in this example. However, such \
ill-conditioning is a serious problem in practice and must be managed with \
methods out-of-scope in this paper."
}], "Text",
 CellChangeTimes->{{3.72792327800198*^9, 3.7279233078789587`*^9}, {
  3.7279713983804617`*^9, 3.72797140314161*^9}, {3.7280360936971283`*^9, 
  3.728036119472001*^9}, {3.728036163659585*^9, 3.728036240971705*^9}, {
  3.728219601486958*^9, 3.728219652487793*^9}, {3.728252003629099*^9, 
  3.7282520048359327`*^9}, {3.7291654907947273`*^9, 3.7291655087082767`*^9}, {
  3.729174198506338*^9, 3.729174199241322*^9}, {3.729182539373966*^9, 
  3.729182552706852*^9}, {3.729645241053973*^9, 3.72964531696039*^9}, {
  3.729798163505123*^9, 3.729798175666603*^9}, {3.7318026012137127`*^9, 
  3.731802645878169*^9}},ExpressionUUID->"779cd83e-6865-4894-b584-\
67ce2ba7c322"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "rlsFit", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{
     RowBox[{"rlsFit", "[", "\[Sigma]2\[CapitalLambda]_", "]"}], "[", 
     RowBox[{"\[CapitalMu]_", ",", "trainingSet_"}], "]"}], ":=", 
    "\[IndentingNewLine]", 
    RowBox[{"With", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"xs", "=", 
         RowBox[{
         "trainingSet", "\[LeftDoubleBracket]", "1", 
          "\[RightDoubleBracket]"}]}], ",", 
        RowBox[{"ys", "=", 
         RowBox[{
         "trainingSet", "\[LeftDoubleBracket]", "2", 
          "\[RightDoubleBracket]"}]}]}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"With", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"\[Xi]0", "=", 
           RowBox[{"List", "/@", 
            RowBox[{"ConstantArray", "[", 
             RowBox[{"0", ",", 
              RowBox[{"\[CapitalMu]", "+", "1"}]}], "]"}]}]}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{"\[CapitalLambda]0", "=", 
           RowBox[{"\[Sigma]2\[CapitalLambda]", "*", 
            RowBox[{"IdentityMatrix", "[", 
             RowBox[{"\[CapitalMu]", "+", "1"}], "]"}]}]}]}], "}"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"Fold", "[", 
         RowBox[{"update", ",", 
          RowBox[{"{", 
           RowBox[{"\[Xi]0", ",", "\[CapitalLambda]0"}], "}"}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"List", "/@", "ys"}], ",", 
             RowBox[{"List", "/@", 
              RowBox[{"partialsFn", "[", 
               RowBox[{"\[CapitalMu]", ",", "xs"}], "]"}]}]}], "}"}], 
           "\[Transpose]"}]}], "]"}]}], "]"}]}], "]"}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{
     RowBox[{"rlsFit", "[", 
      SuperscriptBox["10", 
       RowBox[{"-", "log\[Sigma]2\[CapitalLambda]"}]], "]"}], "[", 
     RowBox[{"3", ",", "bts"}], "]"}], "\[LeftDoubleBracket]", "1", 
    "\[RightDoubleBracket]"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"log\[Sigma]2\[CapitalLambda]", ",", "9.034"}], "}"}], ",", "0",
      ",", "16", ",", 
     RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}]}], 
  "]"}]}], "Input",
 CellChangeTimes->{{3.727883299044437*^9, 3.727883408526169*^9}, {
   3.727883570679338*^9, 3.727883753730864*^9}, {3.727883800858717*^9, 
   3.727883838115073*^9}, {3.727883894473887*^9, 3.727884018340303*^9}, {
   3.72788406916578*^9, 3.727884157272581*^9}, {3.727884225392531*^9, 
   3.7278842277505903`*^9}, {3.7278843168329363`*^9, 
   3.7278844893030443`*^9}, {3.72788451944672*^9, 3.727884559637722*^9}, {
   3.727884601998887*^9, 3.727884641880664*^9}, {3.727884702205894*^9, 
   3.727884709112802*^9}, {3.727884840379463*^9, 3.727884840498255*^9}, {
   3.7279032520135508`*^9, 3.727903302618636*^9}, 3.7279033915207367`*^9, {
   3.727913089794886*^9, 3.727913129180463*^9}, {3.727923317022047*^9, 
   3.727923549746903*^9}, {3.727923650995542*^9, 3.727923655663189*^9}, 
   3.727923702873125*^9, {3.727923927853791*^9, 3.727923934334038*^9}, {
   3.727925310895234*^9, 3.727925333557376*^9}, {3.728036060877223*^9, 
   3.728036070969619*^9}, {3.7280362269856453`*^9, 3.72803623654352*^9}, {
   3.7280907259214077`*^9, 3.7280907259309683`*^9}, {3.728225889419126*^9, 
   3.728225889490087*^9}, {3.729173873480887*^9, 3.729173873491919*^9}, {
   3.729173952692565*^9, 3.729174033832899*^9}, {3.729174227557437*^9, 
   3.729174255702014*^9}, 3.729175632402956*^9, {3.729647132778007*^9, 
   3.729647148168085*^9}},
 CellLabel->"In[59]:=",ExpressionUUID->"53ef4ef5-6a1a-4886-bac4-5d1d719b8c26"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`log\[Sigma]2\[CapitalLambda]$$ = 9.034, 
    Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`log\[Sigma]2\[CapitalLambda]$$], 9.034}, 0, 16}}, 
    Typeset`size$$ = {554., {5., 13.}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = 
    True, $CellContext`log\[Sigma]2\[CapitalLambda]$3659$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`log\[Sigma]2\[CapitalLambda]$$ = 9.034}, 
      "ControllerVariables" :> {
        Hold[$CellContext`log\[Sigma]2\[CapitalLambda]$$, $CellContext`log\
\[Sigma]2\[CapitalLambda]$3659$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> Part[
        $CellContext`rlsFit[
        10^(-$CellContext`log\[Sigma]2\[CapitalLambda]$$)][
        3, $CellContext`bts], 1], 
      "Specifications" :> {{{$CellContext`log\[Sigma]2\[CapitalLambda]$$, 
          9.034}, 0, 16, Appearance -> "Labeled"}}, "Options" :> {}, 
      "DefaultOptions" :> {}],
     ImageSizeCache->{620., {72., 80.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{{3.727913103888098*^9, 3.7279131297094307`*^9}, 
   3.72791538595157*^9, 3.727915690618195*^9, 3.727918037406971*^9, 
   3.7279180951339293`*^9, 3.727923485679799*^9, {3.7279235212598963`*^9, 
   3.727923539397266*^9}, 3.727923656903368*^9, 3.727923703600333*^9, 
   3.7279240791268167`*^9, 3.7279241986997967`*^9, 3.727925360788505*^9, {
   3.727927707618471*^9, 3.7279277327546997`*^9}, 3.727967810771263*^9, 
   3.727968733807341*^9, 3.727969808755946*^9, 3.727969955556759*^9, {
   3.728036061824555*^9, 3.728036072918947*^9}, {3.7280362295589123`*^9, 
   3.7280362371095047`*^9}, 3.72804435235367*^9, 3.728046448406433*^9, 
   3.728066470986565*^9, 3.728068121352648*^9, 3.728083784580184*^9, 
   3.728090742542427*^9, 3.728169446059235*^9, 3.728169541523823*^9, 
   3.728169823744402*^9, 3.728169883754513*^9, {3.728225871308848*^9, 
   3.728225890298745*^9}, 3.728252956368375*^9, 3.728946256965219*^9, 
   3.7290229005394793`*^9, {3.729119979308299*^9, 3.729119996363627*^9}, 
   3.729121072861215*^9, 3.729121111350686*^9, 3.7291723082385883`*^9, 
   3.72917389958121*^9, {3.729174004154214*^9, 3.729174028000448*^9}, 
   3.729175691158844*^9, 3.729175854610073*^9, 3.729183412914186*^9, {
   3.729183448249649*^9, 3.729183461158495*^9}, 3.729255937922879*^9, 
   3.72955230200729*^9, 3.729557876515918*^9, 3.729629838903739*^9, 
   3.7296346366745358`*^9, 3.7296428727312737`*^9, 3.72964290955186*^9, 
   3.7296439394770603`*^9, 3.729646853151237*^9, 3.729647185826949*^9, 
   3.729683202415702*^9, 3.729778155827753*^9, 3.729779234003327*^9, 
   3.729779281093878*^9, 3.7315255860095263`*^9, 3.731527816189361*^9, 
   3.731582994268127*^9, 3.731670259240353*^9, 3.7316718021731987`*^9, 
   3.7316718387225323`*^9, 3.731802652721105*^9, 3.73180335300814*^9, 
   3.731837028770793*^9},
 CellLabel->"Out[61]=",ExpressionUUID->"a65c159a-0e00-43b1-be28-151913c25528"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["KAL: Foldable Kalman Filter", "Subsection",
 CellChangeTimes->{{3.728252019102867*^9, 3.728252024734199*^9}, {
  3.7290943120705023`*^9, 
  3.7290943137983313`*^9}},ExpressionUUID->"cbbfcbf3-b8c1-4ca7-90fa-\
0cea834ffd35"],

Cell[TextData[{
 "The foldable Kalman filter (KAL) follows below. This version has only the \
",
 StyleBox["update",
  FontSlant->"Italic"],
 " phase of a typical Kalman filter because the parameters-to-estimate are \
constant and there is no ",
 StyleBox["predict",
  FontSlant->"Italic"],
 " phase.\n\nNote the ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["P", "\[CapitalZeta]"], TraditionalForm]],ExpressionUUID->
  "944fe3ef-92a4-4716-82e3-d3bdcef1b832"],
 " parameter, the first in the definition of ",
 Cell[BoxData[
  FormBox["kalmanUpdate", TraditionalForm]], "Code",ExpressionUUID->
  "217ff7f6-5c5e-4f2d-b3fe-0e8e9924016d"],
 ". This is the ",
 StyleBox["covariance matrix of the observation noise",
  FontSlant->"Italic"],
 ". It is a constant throughout the folding run of the filter. That\
\[CloseCurlyQuote]s why it\[CloseCurlyQuote]s lambda-lifted into its own \
function slot; ",
 Cell[BoxData[
  FormBox["kalmanUpdate", TraditionalForm]], "Code",ExpressionUUID->
  "a6d93a7a-fed8-40bf-98a2-004f1bf9b537"],
 ", called with some concrete value of ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["P", "\[CapitalZeta]"], TraditionalForm]],ExpressionUUID->
  "87bdc418-bc3f-44b6-8a9a-fbee89c68b91"],
 ", yields a function that can be folded over an a-priori estimate ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Xi]", "0"], TraditionalForm]],ExpressionUUID->
  "2125d705-4d59-4364-b34e-6de72dbb8e08"],
 " and covariance ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["P", "0"], TraditionalForm]],ExpressionUUID->
  "cae5d4c1-22e1-4e7d-a1db-7c46cb34fc07"],
 " and a sequence of observation-and-partial-covector pairs ",
 Cell[BoxData[
  FormBox[
   RowBox[{"{", 
    RowBox[{"\[Zeta]", ",", "a"}], "}"}], TraditionalForm]],ExpressionUUID->
  "49799594-1382-4aab-87dd-b9fc92b25aa6"],
 ". The fit of ",
 Cell[BoxData[
  FormBox[
   StyleBox["Fold", "Code"], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "c4d95e11-4329-4566-b74d-92d133027324"],
 ", which requires an a-priori ",
 StyleBox["abstract zero of the monoid",
  FontSlant->"Italic"],
 " (",
 ButtonBox["https://goo.gl/Xzd1Am",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://goo.gl/Xzd1Am"], None},
  ButtonNote->"https://goo.gl/Xzd1Am"],
 ") to Bayesian methods is notable and remarkable."
}], "Text",
 CellChangeTimes->CompressedData["
1:eJxTTMoPSmViYGAQBmIQrXBUXqjk2GtHjQl8EiDaaF/mgw4gfdX31WsQ/T/q
b1cXkJ50a00fiA59me76Ckg/afYLB9E9j2cdZD7+2vFageEJEK2UcugsiJ4n
2nMVRH/bGnGWDUgfOrIXTN/zK5wgDKTrhEqngOj6/SUzQXRP8sElIHrC1PrS
/hOvHR3d4stB9J2V0S9BdFa+6CcQnd/wU2IdkNZWWicHom99Ypx9EUg/Nvff
AqKtH/94fhVIn6hZ8RFEy39Z9/YmkJZ78PIDiK7heV684+Rrx4Ro9yoQrfBA
rIPt1GtHpt3v+0B0bUum182zrx2beiYEgGiOwqmhIPqDQm4UiAYAC3Cv+A==

  "],ExpressionUUID->"e9fb215c-d438-48ee-a6e4-ea2f514ed2a7"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{"kalmanUpdate", ",", "kalFit"}], "]"}], ";"}], "\n", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{
     RowBox[{
      StyleBox["kalmanUpdate",
       Background->RGBColor[1, 1, 0]], "[", "P\[CapitalZeta]_", "]"}], "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\[Xi]_", ",", "P_"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"\[Zeta]_", ",", "a_"}], "}"}]}], "]"}], ":=", 
    "\[IndentingNewLine]", 
    RowBox[{"Module", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"D", ",", "KT", ",", "K", ",", "L"}], "}"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"D", "=", 
        RowBox[{"P\[CapitalZeta]", "+", 
         RowBox[{"a", ".", "P", ".", 
          RowBox[{"a", "\[Transpose]"}]}]}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"KT", "=", 
        RowBox[{"LinearSolve", "[", 
         RowBox[{"D", ",", 
          RowBox[{"a", ".", "P"}]}], "]"}]}], ";", 
       RowBox[{"K", "=", 
        RowBox[{"KT", "\[Transpose]"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"L", "=", 
        RowBox[{
         RowBox[{"IdentityMatrix", "[", 
          RowBox[{"Length", "[", "P", "]"}], "]"}], "-", 
         RowBox[{"K", ".", "a"}]}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{"Print", "[", "\"\<K:\[Zeta]\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", "\[Zeta]", "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Print", "[", "\"\<K:a\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", "a", "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Print", "[", "\"\<K:a.\[Xi]\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", 
           RowBox[{"a", ".", "\[Xi]"}], "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Print", "[", "\"\<K:\[Zeta]-a.\[Xi]\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", 
           RowBox[{"\[Zeta]", "-", 
            RowBox[{"a", ".", "\[Xi]"}]}], "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Print", "[", "\"\<K:K\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", "K", "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Print", "[", "\"\<K:K.(\[Zeta]-a.\[Xi])\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", 
           RowBox[{"K", ".", 
            RowBox[{"(", 
             RowBox[{"\[Zeta]", "-", 
              RowBox[{"a", ".", "\[Xi]"}]}], ")"}]}], "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Print", "[", "\"\<K:\[Xi]+K.(\[Zeta]-a.\[Xi])\>\"", "]"}], 
         ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", 
           RowBox[{"\[Xi]", "+", 
            RowBox[{"K", ".", 
             RowBox[{"(", 
              RowBox[{"\[Zeta]", "-", 
               RowBox[{"a", ".", "\[Xi]"}]}], ")"}]}]}], "]"}], "]"}], ";"}], 
        "*)"}], "\[IndentingNewLine]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"\[Xi]", "+", 
          RowBox[{"K", ".", 
           RowBox[{"(", 
            RowBox[{"\[Zeta]", "-", 
             RowBox[{"a", ".", "\[Xi]"}]}], ")"}]}]}], ",", 
         RowBox[{"L", ".", "P"}]}], "}"}]}]}], "]"}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"kalFit", "[", 
     RowBox[{"\[Sigma]\[Zeta]2_", ",", "\[Sigma]\[Xi]2_"}], "]"}], "[", 
    RowBox[{"order_", ",", "trainingSet_"}], "]"}], ":=", 
   "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"xs", "=", 
        RowBox[{
        "trainingSet", "\[LeftDoubleBracket]", "1", 
         "\[RightDoubleBracket]"}]}], ",", 
       RowBox[{"ys", "=", 
        RowBox[{
        "trainingSet", "\[LeftDoubleBracket]", "2", 
         "\[RightDoubleBracket]"}]}]}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"\[Xi]0", "=", 
          RowBox[{"List", "/@", 
           RowBox[{"ConstantArray", "[", 
            RowBox[{"0", ",", 
             RowBox[{"order", "+", "1"}]}], "]"}]}]}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"P0", "=", 
          RowBox[{"\[Sigma]\[Xi]2", "*", 
           RowBox[{"IdentityMatrix", "[", 
            RowBox[{"order", "+", "1"}], "]"}]}]}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"Fold", "[", 
        RowBox[{
         RowBox[{"kalmanUpdate", "[", 
          RowBox[{"\[Sigma]\[Zeta]2", "*", 
           RowBox[{"IdentityMatrix", "[", "1", "]"}]}], "]"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"{", 
          RowBox[{"\[Xi]0", ",", "P0"}], "}"}], ",", "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"List", "/@", "ys"}], ",", 
            RowBox[{"List", "/@", 
             RowBox[{"partialsFn", "[", 
              RowBox[{"order", ",", "xs"}], "]"}]}]}], "}"}], 
          "\[Transpose]"}]}], "]"}]}], "]"}]}], "]"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.727913455235773*^9, 3.727913522283977*^9}, 
   3.727913696290469*^9, {3.727913736480159*^9, 3.727913844376683*^9}, {
   3.727917392534089*^9, 3.727917436971686*^9}, {3.727917505035927*^9, 
   3.727917528745805*^9}, {3.727917565263034*^9, 3.727917689094305*^9}, {
   3.727917745897264*^9, 3.7279177578567343`*^9}, {3.727917794603846*^9, 
   3.727917832787274*^9}, 3.727917880971725*^9, {3.727917936171432*^9, 
   3.727918023146969*^9}, {3.727918153331463*^9, 3.727918275269082*^9}, {
   3.727918376669937*^9, 3.727918414049831*^9}, {3.727918508981811*^9, 
   3.727918529673747*^9}, {3.727918590013206*^9, 3.727918649485745*^9}, {
   3.727918701604838*^9, 3.727918748563583*^9}, {3.727919051486678*^9, 
   3.727919074926166*^9}, {3.7279191082942677`*^9, 3.7279191590963287`*^9}, {
   3.7279192864475107`*^9, 3.727919323121303*^9}, {3.727919354826254*^9, 
   3.727919508497794*^9}, {3.727919541340006*^9, 3.727919683877797*^9}, {
   3.727920118873128*^9, 3.7279202093625507`*^9}, {3.727921237681443*^9, 
   3.727921317118623*^9}, {3.7279213549874077`*^9, 3.727921369577837*^9}, {
   3.727921727194334*^9, 3.727921729479971*^9}, {3.727921764122665*^9, 
   3.727921833477203*^9}, {3.72792411169958*^9, 3.727924167792699*^9}, {
   3.72792422895082*^9, 3.727924231141032*^9}, {3.72792438065587*^9, 
   3.7279243990664377`*^9}, {3.727925449102767*^9, 3.7279255631525297`*^9}, {
   3.72792560570716*^9, 3.7279256061694813`*^9}, {3.7279681913170443`*^9, 
   3.727968211031343*^9}, 3.728167450131751*^9, {3.72816963059844*^9, 
   3.728169630606372*^9}, {3.728950036924389*^9, 3.728950066472802*^9}, {
   3.729165737473629*^9, 3.729165758394801*^9}, {3.729174264764344*^9, 
   3.729174321096059*^9}, {3.729638286474793*^9, 3.7296382904326887`*^9}, {
   3.731671415435944*^9, 3.731671591996649*^9}, 3.731671652736911*^9},
 CellLabel->"In[62]:=",ExpressionUUID->"b8eef9f7-1a8b-45ed-9e41-c9550f1c3bd1"]
}, Open  ]],

Cell[CellGroupData[{

Cell["See All Three", "Subsection",
 CellChangeTimes->{{3.729094292024653*^9, 
  3.729094294711062*^9}},ExpressionUUID->"81e11b90-d12f-4788-9a5c-\
479a11b854de"],

Cell[TextData[{
 "The following interactive demonstration shows ",
 Cell[BoxData[
  FormBox["mleFit", TraditionalForm]], "Code",ExpressionUUID->
  "4cb84eca-55a6-402e-87b6-60cd967b9f5b"],
 " (normal equations), ",
 Cell[BoxData[
  FormBox["rlsFit", TraditionalForm]], "Code",ExpressionUUID->
  "32d5863c-f1e1-40c4-9b5d-481484f253d0"],
 " (recurrent least squares), and ",
 Cell[BoxData[
  FormBox["kalFit", TraditionalForm]], "Code",ExpressionUUID->
  "1a3bf1c2-c6f4-4897-8186-d26fb9573d41"],
 " (Kalman folding) on Bishop\[CloseCurlyQuote]s training set.\n\nWhen the \
a-priori information matrix in RLS is ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["10", 
    RowBox[{"-", "6"}]], TraditionalForm]],ExpressionUUID->
  "f6fa54ad-2bf3-49fc-8f51-d6ac554275e8"],
 ", and when the a-priori covariance of the a-priori estimate in KAL is ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["10", "6"], TraditionalForm]],ExpressionUUID->
  "b5f6a42b-8214-43eb-b532-b23cb54f2a71"],
 ", both RLS and KAL produce regularized fits. In contrast, the MLE over-fits \
a ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["9", "th"], TraditionalForm]],ExpressionUUID->
  "df6e2ce4-ee21-4852-9304-c5350f92ab2f"],
 "-order polynomial by interpolating (going through) every data point because \
a ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["9", "th"], TraditionalForm]],ExpressionUUID->
  "6ea035c7-661b-4906-ba49-314a63a809b6"],
 "-order polynomial fits ten data points exactly: the normal equations are \
neither overdetermined nor underdetermined at order nine, but accidentally \
constitute an exactly solvable linear system.\n\nIncreasing ",
 Cell[BoxData[
  FormBox[
   RowBox[{"-", "log\[CapitalLambda]"}], TraditionalForm]], "Code",
  ExpressionUUID->"61902d13-4626-4d5f-8830-5b0bd423956c"],
 " ",
 StyleBox["decreases",
  FontSlant->"Italic"],
 " the (magnitude of the) a-priori information matrix in RLS, meaning that we \
have less Bayesian belief in the a-priori estimate of the unknown parameters. \
Increasing ",
 Cell[BoxData[
  FormBox["log\[Sigma]\[Xi]2", TraditionalForm]], "Code",ExpressionUUID->
  "c17d11ea-e11e-4a64-bf08-fb5cc88187e6"],
 " ",
 StyleBox["increases",
  FontSlant->"Italic"],
 " the a-priori covariance of the estimate in KAL and similarly decreases \
belief in the a-priori estimate. They eventually both over-fit the data \
completely and align with MLE. Later, we show that MAP similarly over-fits. \
Run the polynomial order up to nine, then ",
 Cell[BoxData[
  FormBox[
   RowBox[{"-", "log\[CapitalLambda]"}], TraditionalForm]], "Code",
  ExpressionUUID->"a0f39e4c-2db3-415b-a534-44240dd6e6ec"],
 " and ",
 Cell[BoxData[
  FormBox["log\[Sigma]\[Xi]2", TraditionalForm]], "Code",ExpressionUUID->
  "2b542e52-8384-4059-9874-7f53c5d64849"],
 " all the way to the right, to their maximum values. "
}], "Text",
 CellChangeTimes->CompressedData["
1:eJwlzk0og3EAx/Execl7smgzb6NwILEcmB5lB0Vey4UthbLDWnHwNpG3LclG
O1BrrVBbxEGz1kTkZUxhXrbWTuPgyUSUvJT/73kOvz7H3ze7S9ncHc7hcIRk
cF+bUNx/TFOeOH8V3EsbrYViKb8FNmqk7VByNs9YwfOYZ4gjjemrsCBa/DJL
TAmuvcKfgek/WFj2kqohDkYYBdC3NVcEdyedEqjaCG+DklRZL/Tr+H0w9iZj
GPaYL6cgV5RerUXfeDnj88HHApy0eE1QHdx2HxD3dzQ+aFDaL46I505Wa5Su
iSbKbYIeqHZc+7gnNLXYWvwEnwwxlhRirk5hhYJqvvPqlPw8BNxw02VX3RIn
QqyizJJN6G1gvc+VfcKkxFnGLPf0xR1R8caaVx/x5SUKcw6/oYhn7QgQXYXb
nVB6u/LoOKOpT/37Oww9rH/BSh9rRU3YUqSLpobGihjjW23L0FInMUN5cpbc
66YpY34pozihvBvqTb+M/xZrEXk=
  
  "],ExpressionUUID->"38dc6e9e-29df-4e27-8994-2e7124c48fb4"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"Module", "[", 
    RowBox[{
     RowBox[{"{", "x", "}"}], ",", 
     RowBox[{"(*", " ", 
      RowBox[{"gensym", ":", " ", 
       RowBox[{"fresh", " ", "variable", " ", "name"}]}], " ", "*)"}], 
     "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"terms", "=", 
          RowBox[{"symbolicPowers", "[", 
           RowBox[{"x", ",", "\[CapitalMu]"}], "]"}]}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"cs", "=", 
          RowBox[{
           RowBox[{"\[Phi]", "[", "\[CapitalMu]", "]"}], "/@", 
           RowBox[{"List", "/@", 
            RowBox[{
            "bts", "\[LeftDoubleBracket]", "1", 
             "\[RightDoubleBracket]"}]}]}]}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"recurrent", "=", 
            RowBox[{"Quiet", "@", 
             RowBox[{
              RowBox[{"rlsFit", "[", 
               SuperscriptBox["10", 
                RowBox[{"-", "log\[CapitalLambda]0"}]], "]"}], "[", 
              RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}]}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"normal", "=", 
            RowBox[{"mleFit", "[", 
             RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"kalman", "=", 
            RowBox[{
             RowBox[{"kalFit", "[", 
              RowBox[{
               SuperscriptBox["bishopFakeSigma", "2"], ",", 
               SuperscriptBox["10", "log\[Sigma]\[Xi]2"]}], "]"}], "[", 
             RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}]}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"With", "[", 
          RowBox[{
           RowBox[{"{", "\[IndentingNewLine]", 
            RowBox[{
             RowBox[{"rlsFn", "=", 
              RowBox[{
               RowBox[{"{", "terms", "}"}], ".", 
               RowBox[{
               "recurrent", "\[LeftDoubleBracket]", "1", 
                "\[RightDoubleBracket]"}]}]}], ",", "\[IndentingNewLine]", 
             RowBox[{"mleFn", "=", 
              RowBox[{"terms", ".", "normal"}]}], ",", "\[IndentingNewLine]", 
             
             RowBox[{"kalFn", "=", 
              RowBox[{
               RowBox[{"{", "terms", "}"}], ".", 
               RowBox[{
               "kalman", "\[LeftDoubleBracket]", "1", 
                "\[RightDoubleBracket]"}]}]}]}], "}"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"With", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{"lp", "=", 
               RowBox[{"ListPlot", "[", 
                RowBox[{
                 RowBox[{"bts", "\[Transpose]"}], ",", "\[IndentingNewLine]", 
                 
                 RowBox[{"PlotMarkers", "\[Rule]", 
                  RowBox[{"{", 
                   RowBox[{
                    RowBox[{"Graphics", "@", 
                    RowBox[{"{", 
                    RowBox[{"Blue", ",", 
                    RowBox[{"Circle", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"0", ",", "0"}], "}"}], ",", "1"}], "]"}]}], 
                    "}"}]}], ",", ".05"}], "}"}]}]}], "]"}]}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"Module", "[", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"showlist", "=", 
                 RowBox[{"{", 
                  RowBox[{"lp", ",", 
                   RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox[
                    RowBox[{"Sin", "[", 
                    RowBox[{"2.", "\[Pi]", " ", "x"}], "]"}],
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0.", ",", "1."}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"Thick", ",", 
                    StyleBox["Green",
                    Background->RGBColor[1, 1, 0]]}], "}"}]}]}], "]"}]}], 
                  "}"}]}], "}"}], ",", "\[IndentingNewLine]", 
               RowBox[{
                RowBox[{"If", "[", 
                 RowBox[{"rlsQ", ",", 
                  RowBox[{"AppendTo", "[", 
                   RowBox[{"showlist", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox["rlsFn",
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    StyleBox["Purple",
                    Background->RGBColor[1, 1, 0]], "}"}]}]}], "]"}]}], 
                   "]"}]}], "]"}], ";", "\[IndentingNewLine]", 
                RowBox[{"If", "[", 
                 RowBox[{"mleQ", ",", 
                  RowBox[{"AppendTo", "[", 
                   RowBox[{"showlist", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox["mleFn",
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    StyleBox["Orange",
                    Background->RGBColor[1, 1, 0]], "}"}]}]}], "]"}]}], 
                   "]"}]}], "]"}], ";", "\[IndentingNewLine]", 
                RowBox[{"If", "[", 
                 RowBox[{"kalQ", ",", 
                  RowBox[{"AppendTo", "[", 
                   RowBox[{"showlist", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox["kalFn",
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    StyleBox["Cyan",
                    Background->RGBColor[1, 1, 0]], "}"}]}]}], "]"}]}], 
                   "]"}]}], "]"}], ";", "\[IndentingNewLine]", 
                RowBox[{"Quiet", "@", 
                 RowBox[{"Show", "[", 
                  RowBox[{"showlist", ",", 
                   RowBox[{"Frame", "\[Rule]", "True"}], ",", 
                   RowBox[{"FrameLabel", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"\"\<x\>\"", ",", "\"\<t\>\""}], "}"}]}]}], 
                  "]"}]}]}]}], "]"}]}], "]"}]}], "]"}]}], "]"}]}], "]"}]}], 
    "]"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Grid", "[", 
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"Grid", "[", 
        RowBox[{"{", 
         RowBox[{"{", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"Button", "[", 
            RowBox[{"\"\<RESET\>\"", ",", 
             RowBox[{
              RowBox[{"(", 
               RowBox[{
                RowBox[{"\[CapitalMu]", "=", "9"}], ";", 
                RowBox[{"log\[CapitalLambda]0", "=", "3"}], ";", 
                RowBox[{"log\[Sigma]\[Xi]2", "=", "3"}]}], ")"}], "&"}]}], 
            "]"}], ",", "\[IndentingNewLine]", 
           RowBox[{"Control", "[", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"rlsQ", ",", "True", ",", "\"\<RLS\>\""}], "}"}], ",", 
              
              RowBox[{"{", 
               RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Control", "[", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"kalQ", ",", "True", ",", "\"\<KAL\>\""}], "}"}], ",", 
              
              RowBox[{"{", 
               RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Control", "[", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"mleQ", ",", "True", ",", "\"\<MLE\>\""}], "}"}], ",", 
              
              RowBox[{"{", 
               RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}]}], "}"}],
          "}"}], "]"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
           "\[CapitalMu]", ",", "9", ",", "\"\<polynomial order\>\""}], "}"}],
           ",", "0", ",", "16", ",", "1", ",", 
          RowBox[{"Appearance", "\[Rule]", 
           RowBox[{"{", "\"\<Labeled\>\"", "}"}]}]}], "}"}], "]"}], "}"}], 
      ",", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
           "log\[CapitalLambda]0", ",", "3", ",", 
            "\"\<-log a-priori info (RLS)\>\""}], "}"}], ",", "0", ",", "16", 
          ",", 
          RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
        "]"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
           "log\[Sigma]\[Xi]2", ",", "3", ",", 
            "\"\<log a-priori cov (KAL)\>\""}], "}"}], ",", "0", ",", "16", 
          ",", 
          RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
        "]"}], "}"}]}], "}"}], "]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.727884681931381*^9, 3.7278848244947367`*^9}, 
   3.727884861217602*^9, {3.727884975910451*^9, 3.7278849940673532`*^9}, {
   3.727885103521431*^9, 3.727885154698123*^9}, {3.72788520225443*^9, 
   3.727885279820177*^9}, {3.727885496115718*^9, 3.727885517688189*^9}, {
   3.72788559395383*^9, 3.727885598972475*^9}, {3.7278856296542664`*^9, 
   3.727885630876935*^9}, {3.727885695972756*^9, 3.727885696864628*^9}, {
   3.727886633660364*^9, 3.72788671287046*^9}, {3.727886975364171*^9, 
   3.727886975439041*^9}, {3.727903476653379*^9, 3.7279034819231358`*^9}, {
   3.727903531862627*^9, 3.727903539245574*^9}, 3.727913149489944*^9, {
   3.727915429732944*^9, 3.7279154437948627`*^9}, {3.727915750998211*^9, 
   3.7279158447033873`*^9}, {3.7279213832695303`*^9, 3.72792149154887*^9}, {
   3.727921523149373*^9, 3.72792161270367*^9}, {3.72792165300301*^9, 
   3.727921654632832*^9}, {3.727921753282296*^9, 3.727921753360197*^9}, {
   3.727924008558401*^9, 3.727924045018003*^9}, {3.727924293814445*^9, 
   3.727924370827516*^9}, 3.727965590613636*^9, {3.7279686551525917`*^9, 
   3.727968670349081*^9}, {3.7279689406605043`*^9, 3.727969019631563*^9}, {
   3.727970883056108*^9, 3.727970945128386*^9}, {3.727971005813472*^9, 
   3.727971023734253*^9}, {3.727990640753121*^9, 3.727990674786282*^9}, {
   3.727990711779483*^9, 3.727990808626033*^9}, {3.727991307012423*^9, 
   3.727991307022031*^9}, {3.7279932412769613`*^9, 3.7279932949280367`*^9}, {
   3.7279933910397243`*^9, 3.727993398358789*^9}, {3.727993778490755*^9, 
   3.72799379332897*^9}, {3.727993826040863*^9, 3.7279938751552763`*^9}, {
   3.727993956673335*^9, 3.727993958184173*^9}, 3.727994128012043*^9, {
   3.7280354067714148`*^9, 3.7280354258611927`*^9}, {3.728035634299762*^9, 
   3.728035732029833*^9}, {3.72803585641748*^9, 3.728035906176405*^9}, {
   3.728038924314391*^9, 3.728039041653799*^9}, {3.728039077026232*^9, 
   3.72803913265169*^9}, {3.728039194847865*^9, 3.728039320044661*^9}, {
   3.728044256958378*^9, 3.728044343151896*^9}, {3.728044393583234*^9, 
   3.728044466540698*^9}, 3.7280447095836163`*^9, {3.728044856722988*^9, 
   3.728044959527645*^9}, {3.728044995179022*^9, 3.728044998104682*^9}, {
   3.728045028753289*^9, 3.728045063548128*^9}, {3.728045464570526*^9, 
   3.728045476328084*^9}, {3.728045812340419*^9, 3.728045836978776*^9}, {
   3.7280461335391397`*^9, 3.728046355530389*^9}, {3.728046392282709*^9, 
   3.728046397281275*^9}, {3.728046429888109*^9, 3.728046434285967*^9}, {
   3.728046509047914*^9, 3.728046577986915*^9}, {3.728048625582951*^9, 
   3.728048658147644*^9}, {3.728048704639155*^9, 3.7280487209829884`*^9}, {
   3.728048763333255*^9, 3.728048783520523*^9}, 3.728048849900649*^9, {
   3.728048881350296*^9, 3.7280488887365723`*^9}, {3.7280489358794527`*^9, 
   3.728048947834031*^9}, {3.7280492952517767`*^9, 3.728049427179392*^9}, {
   3.728049506853256*^9, 3.7280496162697783`*^9}, {3.728049702949929*^9, 
   3.728049708359687*^9}, {3.7280497561537037`*^9, 3.728049819625853*^9}, {
   3.728049930158724*^9, 3.728049930640306*^9}, {3.728089854705469*^9, 
   3.728089855621914*^9}, {3.728090725808407*^9, 3.7280907258189697`*^9}, {
   3.728169349695664*^9, 3.728169349720875*^9}, {3.7281694009815397`*^9, 
   3.7281694178910418`*^9}, {3.728169511786654*^9, 3.7281695237214537`*^9}, {
   3.728169612536371*^9, 3.728169630625689*^9}, 3.72825398263583*^9, {
   3.729093231337966*^9, 3.729093231816064*^9}, {3.729119276943676*^9, 
   3.729119308121522*^9}, {3.7291200359185753`*^9, 3.729120071022612*^9}, {
   3.729120620963278*^9, 3.729120653409905*^9}, {3.729120691319798*^9, 
   3.729120728301819*^9}, {3.729173389813801*^9, 3.729173389829308*^9}, {
   3.729173873512885*^9, 3.729173873529933*^9}, {3.7291744772483892`*^9, 
   3.7291744951446943`*^9}, {3.7291745287743883`*^9, 3.729174572901572*^9}, {
   3.729175490403535*^9, 3.7291755161637173`*^9}, {3.729175633605082*^9, 
   3.729175638831461*^9}, {3.729183394512477*^9, 3.729183394521019*^9}},
 CellLabel->"In[65]:=",ExpressionUUID->"41b77482-27f2-4c90-b765-448121521c46"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`kalQ$$ = 
    True, $CellContext`log\[CapitalLambda]0$$ = 
    3, $CellContext`log\[Sigma]\[Xi]2$$ = 3, $CellContext`mleQ$$ = 
    True, $CellContext`rlsQ$$ = True, $CellContext`\[CapitalMu]$$ = 9, 
    Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`rlsQ$$], True, "RLS"}, {True, False}}, {{
       Hold[$CellContext`kalQ$$], True, "KAL"}, {True, False}}, {{
       Hold[$CellContext`mleQ$$], True, "MLE"}, {True, False}}, {{
       Hold[$CellContext`\[CapitalMu]$$], 9, "polynomial order"}, 0, 16, 1}, {{
       Hold[$CellContext`log\[CapitalLambda]0$$], 3, 
       "-log a-priori info (RLS)"}, 0, 16}, {{
       Hold[$CellContext`log\[Sigma]\[Xi]2$$], 3, "log a-priori cov (KAL)"}, 
      0, 16}, {
      Hold[
       Grid[{{
          Grid[{{
             Button[
             "RESET", ($CellContext`\[CapitalMu]$$ = 
               9; $CellContext`log\[CapitalLambda]0$$ = 
               3; $CellContext`log\[Sigma]\[Xi]2$$ = 3)& ], 
             Manipulate`Place[1], 
             Manipulate`Place[2], 
             Manipulate`Place[3]}}]}, {
          Manipulate`Place[4]}, {
          Manipulate`Place[5]}, {
          Manipulate`Place[6]}}]], Manipulate`Dump`ThisIsNotAControl}}, 
    Typeset`size$$ = {540., {168., 175.}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = 
    True, $CellContext`rlsQ$3682$$ = False, $CellContext`kalQ$3683$$ = 
    False, $CellContext`mleQ$3684$$ = 
    False, $CellContext`\[CapitalMu]$3685$$ = 
    0, $CellContext`log\[CapitalLambda]0$3686$$ = 
    0, $CellContext`log\[Sigma]\[Xi]2$3687$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     2, StandardForm, 
      "Variables" :> {$CellContext`kalQ$$ = 
        True, $CellContext`log\[CapitalLambda]0$$ = 
        3, $CellContext`log\[Sigma]\[Xi]2$$ = 3, $CellContext`mleQ$$ = 
        True, $CellContext`rlsQ$$ = True, $CellContext`\[CapitalMu]$$ = 9}, 
      "ControllerVariables" :> {
        Hold[$CellContext`rlsQ$$, $CellContext`rlsQ$3682$$, False], 
        Hold[$CellContext`kalQ$$, $CellContext`kalQ$3683$$, False], 
        Hold[$CellContext`mleQ$$, $CellContext`mleQ$3684$$, False], 
        Hold[$CellContext`\[CapitalMu]$$, $CellContext`\[CapitalMu]$3685$$, 
         0], 
        Hold[$CellContext`log\[CapitalLambda]0$$, $CellContext`log\
\[CapitalLambda]0$3686$$, 0], 
        Hold[$CellContext`log\[Sigma]\[Xi]2$$, \
$CellContext`log\[Sigma]\[Xi]2$3687$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> Module[{$CellContext`x$}, 
        With[{$CellContext`terms$ = \
$CellContext`symbolicPowers[$CellContext`x$, $CellContext`\[CapitalMu]$$], \
$CellContext`cs$ = Map[
            $CellContext`\[Phi][$CellContext`\[CapitalMu]$$], 
            Map[List, 
             Part[$CellContext`bts, 1]]]}, 
         With[{$CellContext`recurrent$ = Quiet[
             $CellContext`rlsFit[
             10^(-$CellContext`log\[CapitalLambda]0$$)][$CellContext`\
\[CapitalMu]$$, $CellContext`bts]], $CellContext`normal$ = \
$CellContext`mleFit[$CellContext`\[CapitalMu]$$, $CellContext`bts], \
$CellContext`kalman$ = $CellContext`kalFit[$CellContext`bishopFakeSigma^2, 
             10^$CellContext`log\[Sigma]\[Xi]2$$][$CellContext`\[CapitalMu]$$,\
 $CellContext`bts]}, 
          With[{$CellContext`rlsFn$ = Dot[{$CellContext`terms$}, 
              Part[$CellContext`recurrent$, 1]], $CellContext`mleFn$ = 
            Dot[$CellContext`terms$, $CellContext`normal$], \
$CellContext`kalFn$ = Dot[{$CellContext`terms$}, 
              Part[$CellContext`kalman$, 1]]}, 
           With[{$CellContext`lp$ = ListPlot[
               Transpose[$CellContext`bts], PlotMarkers -> {
                 Graphics[{Blue, 
                   Circle[{0, 0}, 1]}], 0.05}]}, 
            Module[{$CellContext`showlist$ = {$CellContext`lp$, 
                Plot[
                 Sin[2. Pi $CellContext`x$], {$CellContext`x$, 0., 1.}, 
                 PlotStyle -> {Thick, Green}]}}, If[$CellContext`rlsQ$$, 
               AppendTo[$CellContext`showlist$, 
                
                Plot[$CellContext`rlsFn$, {$CellContext`x$, 0, 1}, 
                 PlotStyle -> {Purple}]]]; If[$CellContext`mleQ$$, 
               AppendTo[$CellContext`showlist$, 
                
                Plot[$CellContext`mleFn$, {$CellContext`x$, 0, 1}, 
                 PlotStyle -> {Orange}]]]; If[$CellContext`kalQ$$, 
               AppendTo[$CellContext`showlist$, 
                
                Plot[$CellContext`kalFn$, {$CellContext`x$, 0, 1}, 
                 PlotStyle -> {Cyan}]]]; Quiet[
               
               Show[$CellContext`showlist$, Frame -> True, 
                FrameLabel -> {"x", "t"}]]]]]]]], 
      "Specifications" :> {{{$CellContext`rlsQ$$, True, "RLS"}, {True, False},
          ControlPlacement -> 1}, {{$CellContext`kalQ$$, True, "KAL"}, {
         True, False}, ControlPlacement -> 
         2}, {{$CellContext`mleQ$$, True, "MLE"}, {True, False}, 
         ControlPlacement -> 
         3}, {{$CellContext`\[CapitalMu]$$, 9, "polynomial order"}, 0, 16, 1, 
         Appearance -> {"Labeled"}, ControlPlacement -> 
         4}, {{$CellContext`log\[CapitalLambda]0$$, 3, 
          "-log a-priori info (RLS)"}, 0, 16, Appearance -> "Labeled", 
         ControlPlacement -> 
         5}, {{$CellContext`log\[Sigma]\[Xi]2$$, 3, "log a-priori cov (KAL)"},
          0, 16, Appearance -> "Labeled", ControlPlacement -> 6}, 
        Grid[{{
           Grid[{{
              Button[
              "RESET", ($CellContext`\[CapitalMu]$$ = 
                9; $CellContext`log\[CapitalLambda]0$$ = 
                3; $CellContext`log\[Sigma]\[Xi]2$$ = 3)& ], 
              Manipulate`Place[1], 
              Manipulate`Place[2], 
              Manipulate`Place[3]}}]}, {
           Manipulate`Place[4]}, {
           Manipulate`Place[5]}, {
           Manipulate`Place[6]}}]}, "Options" :> {}, "DefaultOptions" :> {}],
     ImageSizeCache->{606., {284., 292.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{
  3.729120694893572*^9, 3.729120729239387*^9, 3.729121073140068*^9, 
   3.729121111649043*^9, 3.729172308359383*^9, 3.729174504534432*^9, 
   3.729174541120797*^9, 3.729174577438936*^9, 3.7291756912669277`*^9, 
   3.729175878038041*^9, 3.729183413008506*^9, {3.729183448351598*^9, 
   3.729183461260701*^9}, 3.7292559380417747`*^9, 3.7295523020803957`*^9, 
   3.729557876588092*^9, 3.729629838965455*^9, 3.729634637046328*^9, 
   3.7296428728365097`*^9, 3.729642909628141*^9, 3.729643939586529*^9, 
   3.72964718593789*^9, 3.7296832025410233`*^9, 3.729778155948976*^9, 
   3.7297792341062117`*^9, 3.729779281194851*^9, 3.7315255861300573`*^9, 
   3.731527816328477*^9, 3.731582994481003*^9, 3.731670259341756*^9, 
   3.731671802279232*^9, 3.731671838828988*^9, 3.731802940037053*^9, 
   3.7318033530826883`*^9, 3.731837028872808*^9},
 CellLabel->"Out[65]=",ExpressionUUID->"17d03fd0-307c-4e11-8859-82aef3eead13"]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Renormalizing RLS", "Subchapter",
 CellChangeTimes->{{3.729092768444851*^9, 3.729092782412208*^9}, {
  3.729191699611701*^9, 3.729191706169241*^9}, {3.729798432235529*^9, 
  3.7297984335852747`*^9}},ExpressionUUID->"8a090d5c-2e53-4773-be11-\
04b6147a0d55"],

Cell[TextData[{
 "When the observation noise ",
 Cell[BoxData[
  FormBox["\[CapitalZeta]", TraditionalForm]],ExpressionUUID->
  "cee2b76b-94f4-4d39-af2d-0579b6076db6"],
 " is unity, KAL coincides with RLS. In the demonstration below, a-priori \
information ",
 Cell[BoxData[
  FormBox["\[CapitalLambda]", TraditionalForm]],ExpressionUUID->
  "64b2c5a6-569c-42ea-9d39-1c5b1e4d462c"],
 " in RLS is set always to be the inverse of a-priori estimate covariance ",
 Cell[BoxData[
  FormBox["P", TraditionalForm]],ExpressionUUID->
  "0c6f3956-3d95-4cf6-a9d1-9ca1c9fcb773"],
 " in KAL; RLS and KAL will have the same belief in the a-priori estimate of \
the unknown parameters. Vary the observation noise independently to see KAL \
and RLS coincide when the observation noise is unity (its log is zero).\n\nAs \
observation noise decreases, the solutions believe the observations more and \
the solution over-fits. As the a-priori covariance decreases, the solution \
believes the a-priori estimates more and the solution regularizes."
}], "Text",
 CellChangeTimes->{{3.729093282411186*^9, 3.729093313683037*^9}, {
   3.729117959440587*^9, 3.729117962326047*^9}, {3.7291180366585493`*^9, 
   3.7291181529404573`*^9}, {3.729120823468717*^9, 3.7291208319067087`*^9}, {
   3.729120924129122*^9, 3.7291209334511013`*^9}, {3.7291612546720057`*^9, 
   3.7291614312105837`*^9}, {3.729161481669347*^9, 3.729161524300392*^9}, {
   3.729165948834399*^9, 3.7291660151159143`*^9}, 3.7291746302654448`*^9, 
   3.729174660835752*^9, {3.729182703813655*^9, 3.7291827056457043`*^9}, {
   3.729645533347239*^9, 3.729645535008542*^9}, {3.72968376925354*^9, 
   3.729683796986575*^9}, {3.72968383611133*^9, 3.729683840551021*^9}, {
   3.7296873492799683`*^9, 3.7296874288640547`*^9}, {3.729798450427746*^9, 
   3.729798491548514*^9}, {3.731530197668253*^9, 
   3.7315302145619373`*^9}},ExpressionUUID->"022dc5da-694c-4d7d-b66d-\
84c771de4860"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", 
  RowBox[{
   RowBox[{"Module", "[", 
    RowBox[{
     RowBox[{"{", "x", "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"terms", "=", 
          RowBox[{"symbolicPowers", "[", 
           RowBox[{"x", ",", "\[CapitalMu]"}], "]"}]}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"cs", "=", 
          RowBox[{
           RowBox[{"\[Phi]", "[", "\[CapitalMu]", "]"}], "/@", 
           RowBox[{"List", "/@", 
            RowBox[{
            "bts", "\[LeftDoubleBracket]", "1", 
             "\[RightDoubleBracket]"}]}]}]}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
           RowBox[{"rls", "=", 
            RowBox[{"Quiet", "@", 
             RowBox[{
              RowBox[{"rlsFit", "[", 
               SuperscriptBox["10", 
                RowBox[{
                 RowBox[{"-", "2"}], "log\[Sigma]\[Xi]"}]], "]"}], "[", 
              RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}]}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"kalman", "=", 
            RowBox[{
             RowBox[{"kalFit", "[", 
              RowBox[{
               SuperscriptBox["10", 
                RowBox[{"2", "log\[Sigma]\[Zeta]"}]], ",", 
               SuperscriptBox["10", 
                RowBox[{"2", "log\[Sigma]\[Xi]"}]]}], "]"}], "[", 
             RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}]}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"With", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"rlsFn", "=", 
              RowBox[{
               RowBox[{"{", "terms", "}"}], ".", 
               RowBox[{
               "rls", "\[LeftDoubleBracket]", "1", 
                "\[RightDoubleBracket]"}]}]}], ",", "\[IndentingNewLine]", 
             RowBox[{"kalFn", "=", 
              RowBox[{
               RowBox[{"{", "terms", "}"}], ".", 
               RowBox[{
               "kalman", "\[LeftDoubleBracket]", "1", 
                "\[RightDoubleBracket]"}]}]}]}], "}"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"With", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{"lp", "=", 
               RowBox[{"ListPlot", "[", 
                RowBox[{
                 RowBox[{"bts", "\[Transpose]"}], ",", "\[IndentingNewLine]", 
                 
                 RowBox[{"PlotMarkers", "\[Rule]", 
                  RowBox[{"{", 
                   RowBox[{
                    RowBox[{"Graphics", "@", 
                    RowBox[{"{", 
                    RowBox[{"Blue", ",", 
                    RowBox[{"Circle", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"0", ",", "0"}], "}"}], ",", "1"}], "]"}]}], 
                    "}"}]}], ",", ".05"}], "}"}]}]}], "]"}]}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"Module", "[", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"showlist", "=", 
                 RowBox[{"{", 
                  RowBox[{"lp", ",", 
                   RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox[
                    RowBox[{"Sin", "[", 
                    RowBox[{"2.", "\[Pi]", " ", "x"}], "]"}],
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0.", ",", "1."}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"Thick", ",", 
                    StyleBox["Green",
                    Background->RGBColor[1, 1, 0]]}], "}"}]}]}], "]"}]}], 
                  "}"}]}], "}"}], ",", "\[IndentingNewLine]", 
               RowBox[{
                RowBox[{"If", "[", 
                 RowBox[{"rlsQ", ",", 
                  RowBox[{"AppendTo", "[", 
                   RowBox[{"showlist", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox["rlsFn",
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    StyleBox["Purple",
                    Background->RGBColor[1, 1, 0]], "}"}]}]}], "]"}]}], 
                   "]"}]}], "]"}], ";", "\[IndentingNewLine]", 
                RowBox[{"If", "[", 
                 RowBox[{"kalQ", ",", 
                  RowBox[{"AppendTo", "[", 
                   RowBox[{"showlist", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox["kalFn",
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    StyleBox["Cyan",
                    Background->RGBColor[1, 1, 0]], "}"}]}]}], "]"}]}], 
                   "]"}]}], "]"}], ";", "\[IndentingNewLine]", 
                RowBox[{"Quiet", "@", 
                 RowBox[{"Show", "[", 
                  RowBox[{"showlist", ",", 
                   RowBox[{"Frame", "\[Rule]", "True"}], ",", 
                   RowBox[{"FrameLabel", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"\"\<x\>\"", ",", "\"\<t\>\""}], "}"}]}]}], 
                  "]"}]}]}]}], "]"}]}], "]"}]}], "]"}]}], "]"}]}], "]"}]}], 
    "]"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Grid", "[", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"Grid", "[", 
         RowBox[{"{", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"Button", "[", 
             RowBox[{"\"\<RESET\>\"", ",", 
              RowBox[{
               RowBox[{"(", 
                RowBox[{
                 RowBox[{"log\[Sigma]\[Zeta]", "=", "0.0"}], ";", 
                 RowBox[{"log\[Sigma]\[Xi]", "=", "1.5"}], ";", 
                 RowBox[{"\[CapitalMu]", "=", "9"}]}], ")"}], "&"}]}], "]"}], 
            ",", "\[IndentingNewLine]", 
            RowBox[{"Control", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"rlsQ", ",", "True", ",", "\"\<RLS\>\""}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"Control", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"kalQ", ",", "True", ",", "\"\<KAL\>\""}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}]}], 
           "}"}], "}"}], "]"}], ",", "\"\<\>\""}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"Control", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
            "\[CapitalMu]", ",", "9", ",", "\"\<polynomial order\>\""}], 
            "}"}], ",", "0", ",", "16", ",", "1", ",", 
           RowBox[{"Appearance", "\[Rule]", 
            RowBox[{"{", "\"\<Labeled\>\"", "}"}]}]}], "}"}], "]"}], ",", 
        "\"\<\>\""}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
           "log\[Sigma]\[Xi]", ",", "1.5", ",", 
            "\"\<log \!\(\*SqrtBox[\(P\)]\) (KAL) = (-log \!\(\*SqrtBox[\(\
\[CapitalLambda]\)]\)) (RLS) \>\""}], "}"}], ",", 
          RowBox[{"-", "3"}], ",", "8", ",", 
          RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
        "]"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
           "log\[Sigma]\[Zeta]", ",", "0.0", ",", 
            "\"\<log \!\(\*SqrtBox[\(\[CapitalZeta]\)]\) (KAL)\>\""}], "}"}], 
          ",", 
          RowBox[{"-", "6"}], ",", "3", ",", 
          RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
        "]"}], "}"}]}], "}"}], "]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.727884681931381*^9, 3.7278848244947367`*^9}, 
   3.727884861217602*^9, {3.727884975910451*^9, 3.7278849940673532`*^9}, {
   3.727885103521431*^9, 3.727885154698123*^9}, {3.72788520225443*^9, 
   3.727885279820177*^9}, {3.727885496115718*^9, 3.727885517688189*^9}, {
   3.72788559395383*^9, 3.727885598972475*^9}, {3.7278856296542664`*^9, 
   3.727885630876935*^9}, {3.727885695972756*^9, 3.727885696864628*^9}, {
   3.727886633660364*^9, 3.72788671287046*^9}, {3.727886975364171*^9, 
   3.727886975439041*^9}, {3.727903476653379*^9, 3.7279034819231358`*^9}, {
   3.727903531862627*^9, 3.727903539245574*^9}, 3.727913149489944*^9, {
   3.727915429732944*^9, 3.7279154437948627`*^9}, {3.727915750998211*^9, 
   3.7279158447033873`*^9}, {3.7279213832695303`*^9, 3.72792149154887*^9}, {
   3.727921523149373*^9, 3.72792161270367*^9}, {3.72792165300301*^9, 
   3.727921654632832*^9}, {3.727921753282296*^9, 3.727921753360197*^9}, {
   3.727924008558401*^9, 3.727924045018003*^9}, {3.727924293814445*^9, 
   3.727924370827516*^9}, 3.727965590613636*^9, {3.7279686551525917`*^9, 
   3.727968670349081*^9}, {3.7279689406605043`*^9, 3.727969019631563*^9}, {
   3.727970883056108*^9, 3.727970945128386*^9}, {3.727971005813472*^9, 
   3.727971023734253*^9}, {3.727990640753121*^9, 3.727990674786282*^9}, {
   3.727990711779483*^9, 3.727990808626033*^9}, {3.727991307012423*^9, 
   3.727991307022031*^9}, {3.7279932412769613`*^9, 3.7279932949280367`*^9}, {
   3.7279933910397243`*^9, 3.727993398358789*^9}, {3.727993778490755*^9, 
   3.72799379332897*^9}, {3.727993826040863*^9, 3.7279938751552763`*^9}, {
   3.727993956673335*^9, 3.727993958184173*^9}, 3.727994128012043*^9, {
   3.7280354067714148`*^9, 3.7280354258611927`*^9}, {3.728035634299762*^9, 
   3.728035732029833*^9}, {3.72803585641748*^9, 3.728035906176405*^9}, {
   3.728038924314391*^9, 3.728039041653799*^9}, {3.728039077026232*^9, 
   3.72803913265169*^9}, {3.728039194847865*^9, 3.728039320044661*^9}, {
   3.728044256958378*^9, 3.728044343151896*^9}, {3.728044393583234*^9, 
   3.728044466540698*^9}, 3.7280447095836163`*^9, {3.728044856722988*^9, 
   3.728044959527645*^9}, {3.728044995179022*^9, 3.728044998104682*^9}, {
   3.728045028753289*^9, 3.728045063548128*^9}, {3.728045464570526*^9, 
   3.728045476328084*^9}, {3.728045812340419*^9, 3.728045836978776*^9}, {
   3.7280461335391397`*^9, 3.728046355530389*^9}, {3.728046392282709*^9, 
   3.728046397281275*^9}, {3.728046429888109*^9, 3.728046434285967*^9}, {
   3.728046509047914*^9, 3.728046577986915*^9}, {3.728048625582951*^9, 
   3.728048658147644*^9}, {3.728048704639155*^9, 3.7280487209829884`*^9}, {
   3.728048763333255*^9, 3.728048783520523*^9}, 3.728048849900649*^9, {
   3.728048881350296*^9, 3.7280488887365723`*^9}, {3.7280489358794527`*^9, 
   3.728048947834031*^9}, {3.7280492952517767`*^9, 3.728049427179392*^9}, {
   3.728049506853256*^9, 3.7280496162697783`*^9}, {3.728049702949929*^9, 
   3.728049708359687*^9}, {3.7280497561537037`*^9, 3.728049819625853*^9}, {
   3.728049930158724*^9, 3.728049930640306*^9}, {3.728089854705469*^9, 
   3.728089855621914*^9}, {3.728090725808407*^9, 3.7280907258189697`*^9}, {
   3.728169349695664*^9, 3.728169349720875*^9}, {3.7281694009815397`*^9, 
   3.7281694178910418`*^9}, {3.728169511786654*^9, 3.7281695237214537`*^9}, {
   3.728169612536371*^9, 3.728169630625689*^9}, 3.72825398263583*^9, {
   3.7290928993104963`*^9, 3.7290929198661003`*^9}, {3.729093017541959*^9, 
   3.7290930188886843`*^9}, {3.7290930762770233`*^9, 3.729093076719734*^9}, {
   3.72909336384054*^9, 3.729093404015414*^9}, {3.729095580798506*^9, 
   3.7290957047591*^9}, {3.729095766580648*^9, 3.7290957771880827`*^9}, {
   3.729107615295549*^9, 3.729107649857699*^9}, {3.729107694037426*^9, 
   3.729107743875201*^9}, {3.7291077762521057`*^9, 3.7291078031246223`*^9}, {
   3.729118170017755*^9, 3.729118205624216*^9}, {3.729118574833902*^9, 
   3.729118716465946*^9}, 3.729118800635138*^9, {3.7291198853367987`*^9, 
   3.729119917193569*^9}, {3.729119958982697*^9, 3.729119965955413*^9}, {
   3.7291200866814137`*^9, 3.729120095768982*^9}, {3.729120128434678*^9, 
   3.729120131648838*^9}, {3.729120172278734*^9, 3.729120172356533*^9}, {
   3.729120743402363*^9, 3.7291207441433563`*^9}, {3.729120788602343*^9, 
   3.7291207913479967`*^9}, {3.7291208644443913`*^9, 3.72912086593517*^9}, {
   3.729120949328354*^9, 3.729120951079392*^9}, {3.729120998089177*^9, 
   3.729121101876314*^9}, {3.729161109484889*^9, 3.729161122514371*^9}, {
   3.729161176256221*^9, 3.729161200551162*^9}, {3.729166018684317*^9, 
   3.729166061187087*^9}, {3.729173389847056*^9, 3.729173389871232*^9}, {
   3.729173453409334*^9, 3.729173453420225*^9}, {3.729174596320022*^9, 
   3.7291746086723146`*^9}, {3.72917468944347*^9, 3.729174740763813*^9}, {
   3.729175490419692*^9, 3.729175516174968*^9}, {3.729175639773261*^9, 
   3.729175642039402*^9}, {3.729647100398603*^9, 3.729647108685156*^9}},
 CellLabel->"In[66]:=",ExpressionUUID->"c502f911-698b-4b59-b300-a3375e19d774"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`kalQ$$ = 
    True, $CellContext`log\[Sigma]\[Zeta]$$ = 
    0., $CellContext`log\[Sigma]\[Xi]$$ = 1.5, $CellContext`rlsQ$$ = 
    True, $CellContext`\[CapitalMu]$$ = 9, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`rlsQ$$], True, "RLS"}, {True, False}}, {{
       Hold[$CellContext`kalQ$$], True, "KAL"}, {True, False}}, {{
       Hold[$CellContext`\[CapitalMu]$$], 9, "polynomial order"}, 0, 16, 1}, {{
       Hold[$CellContext`log\[Sigma]\[Xi]$$], 1.5, 
       "log \!\(\*SqrtBox[\(P\)]\) (KAL) = (-log \!\(\*SqrtBox[\(\
\[CapitalLambda]\)]\)) (RLS) "}, -3, 8}, {{
       Hold[$CellContext`log\[Sigma]\[Zeta]$$], 0., 
       "log \!\(\*SqrtBox[\(\[CapitalZeta]\)]\) (KAL)"}, -6, 3}, {
      Hold[
       Grid[{{
          Grid[{{
             Button[
             "RESET", ($CellContext`log\[Sigma]\[Zeta]$$ = 
               0.; $CellContext`log\[Sigma]\[Xi]$$ = 
               1.5; $CellContext`\[CapitalMu]$$ = 9)& ], 
             Manipulate`Place[1], 
             Manipulate`Place[2]}}], ""}, {
          Manipulate`Place[3], ""}, {
          Manipulate`Place[4]}, {
          Manipulate`Place[5]}}]], Manipulate`Dump`ThisIsNotAControl}}, 
    Typeset`size$$ = {540., {168., 175.}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = 
    True, $CellContext`rlsQ$3958$$ = False, $CellContext`kalQ$3959$$ = 
    False, $CellContext`\[CapitalMu]$3960$$ = 
    0, $CellContext`log\[Sigma]\[Xi]$3961$$ = 
    0, $CellContext`log\[Sigma]\[Zeta]$3962$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     2, StandardForm, 
      "Variables" :> {$CellContext`kalQ$$ = 
        True, $CellContext`log\[Sigma]\[Zeta]$$ = 
        0., $CellContext`log\[Sigma]\[Xi]$$ = 1.5, $CellContext`rlsQ$$ = 
        True, $CellContext`\[CapitalMu]$$ = 9}, "ControllerVariables" :> {
        Hold[$CellContext`rlsQ$$, $CellContext`rlsQ$3958$$, False], 
        Hold[$CellContext`kalQ$$, $CellContext`kalQ$3959$$, False], 
        Hold[$CellContext`\[CapitalMu]$$, $CellContext`\[CapitalMu]$3960$$, 
         0], 
        Hold[$CellContext`log\[Sigma]\[Xi]$$, \
$CellContext`log\[Sigma]\[Xi]$3961$$, 0], 
        Hold[$CellContext`log\[Sigma]\[Zeta]$$, $CellContext`log\[Sigma]\
\[Zeta]$3962$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> Module[{$CellContext`x$}, 
        With[{$CellContext`terms$ = \
$CellContext`symbolicPowers[$CellContext`x$, $CellContext`\[CapitalMu]$$], \
$CellContext`cs$ = Map[
            $CellContext`\[Phi][$CellContext`\[CapitalMu]$$], 
            Map[List, 
             Part[$CellContext`bts, 1]]]}, 
         With[{$CellContext`rls$ = Quiet[
             $CellContext`rlsFit[
             10^((-2) $CellContext`log\[Sigma]\[Xi]$$)][$CellContext`\
\[CapitalMu]$$, $CellContext`bts]], $CellContext`kalman$ = \
$CellContext`kalFit[
            10^(2 $CellContext`log\[Sigma]\[Zeta]$$), 
             10^(2 $CellContext`log\[Sigma]\[Xi]$$)][$CellContext`\[CapitalMu]\
$$, $CellContext`bts]}, 
          With[{$CellContext`rlsFn$ = Dot[{$CellContext`terms$}, 
              Part[$CellContext`rls$, 1]], $CellContext`kalFn$ = 
            Dot[{$CellContext`terms$}, 
              Part[$CellContext`kalman$, 1]]}, 
           With[{$CellContext`lp$ = ListPlot[
               Transpose[$CellContext`bts], PlotMarkers -> {
                 Graphics[{Blue, 
                   Circle[{0, 0}, 1]}], 0.05}]}, 
            Module[{$CellContext`showlist$ = {$CellContext`lp$, 
                Plot[
                 Sin[2. Pi $CellContext`x$], {$CellContext`x$, 0., 1.}, 
                 PlotStyle -> {Thick, Green}]}}, If[$CellContext`rlsQ$$, 
               AppendTo[$CellContext`showlist$, 
                
                Plot[$CellContext`rlsFn$, {$CellContext`x$, 0, 1}, 
                 PlotStyle -> {Purple}]]]; If[$CellContext`kalQ$$, 
               AppendTo[$CellContext`showlist$, 
                
                Plot[$CellContext`kalFn$, {$CellContext`x$, 0, 1}, 
                 PlotStyle -> {Cyan}]]]; Quiet[
               
               Show[$CellContext`showlist$, Frame -> True, 
                FrameLabel -> {"x", "t"}]]]]]]]], 
      "Specifications" :> {{{$CellContext`rlsQ$$, True, "RLS"}, {True, False},
          ControlPlacement -> 1}, {{$CellContext`kalQ$$, True, "KAL"}, {
         True, False}, ControlPlacement -> 
         2}, {{$CellContext`\[CapitalMu]$$, 9, "polynomial order"}, 0, 16, 1, 
         Appearance -> {"Labeled"}, ControlPlacement -> 
         3}, {{$CellContext`log\[Sigma]\[Xi]$$, 1.5, 
          "log \!\(\*SqrtBox[\(P\)]\) (KAL) = (-log \!\(\*SqrtBox[\(\
\[CapitalLambda]\)]\)) (RLS) "}, -3, 8, Appearance -> "Labeled", 
         ControlPlacement -> 
         4}, {{$CellContext`log\[Sigma]\[Zeta]$$, 0., 
          "log \!\(\*SqrtBox[\(\[CapitalZeta]\)]\) (KAL)"}, -6, 3, Appearance -> 
         "Labeled", ControlPlacement -> 5}, 
        Grid[{{
           Grid[{{
              Button[
              "RESET", ($CellContext`log\[Sigma]\[Zeta]$$ = 
                0.; $CellContext`log\[Sigma]\[Xi]$$ = 
                1.5; $CellContext`\[CapitalMu]$$ = 9)& ], 
              Manipulate`Place[1], 
              Manipulate`Place[2]}}], ""}, {
           Manipulate`Place[3], ""}, {
           Manipulate`Place[4]}, {
           Manipulate`Place[5]}}]}, "Options" :> {}, "DefaultOptions" :> {}],
     ImageSizeCache->{643., {284., 292.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{
  3.7291608432818193`*^9, 3.72916112450849*^9, {3.729161176716465*^9, 
   3.729161201301146*^9}, 3.7291612332234373`*^9, 3.729166027254204*^9, 
   3.729166062247652*^9, 3.729172308588915*^9, 3.729174610695847*^9, {
   3.729174741969412*^9, 3.7291747607471*^9}, 3.729175691543783*^9, 
   3.729175884256433*^9, 3.729183413081258*^9, {3.729183448421172*^9, 
   3.7291834613216057`*^9}, 3.7292559386259813`*^9, 3.729552302382516*^9, 
   3.729557876632798*^9, 3.7296298391238832`*^9, 3.7296346371776114`*^9, 
   3.72964287312507*^9, 3.729642909680106*^9, 3.729643939780446*^9, 
   3.729647111709886*^9, 3.7296471859968224`*^9, 3.729683202732308*^9, 
   3.7296836129467773`*^9, 3.7297781560231*^9, 3.7297792341882687`*^9, 
   3.729779281260777*^9, 3.731525586366488*^9, 3.7315278166097813`*^9, 
   3.7315829947894793`*^9, 3.731670259543796*^9, 3.73167180248155*^9, 
   3.731671839086322*^9, 3.7318029718917933`*^9, 3.731803353276864*^9, 
   3.731837029077726*^9},
 CellLabel->"Out[66]=",ExpressionUUID->"ce685066-8dc7-4a07-b313-970b96fccad8"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Add Observation Noise to RLS", "Subsection",
 CellChangeTimes->{{3.729094358222797*^9, 3.7290944123276787`*^9}, {
  3.729798505179409*^9, 
  3.7297985074907103`*^9}},ExpressionUUID->"d4c02f95-4b36-4a00-abe3-\
96d6b2e858e1"],

Cell[TextData[{
 "RLS, so far, is normalized to unit observation (OBN) noise. How to modify \
RLS to account for non-normalized OBN noise? \n\nScale (each row of) the \
partials by the inverse of the OBN standard deviation, represented below by a \
matrix square root of the OBN covariance ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["P", "\[CapitalZeta]"], TraditionalForm]],ExpressionUUID->
  "47ef5763-33fe-40ce-8d6b-6dca9bd22ffb"],
 ". Finally, rescale the final estimate (not the final covariance) by a \
matrix built from the inverse OBN standard deviation because the recurrent \
normal equations, which incrementally build ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SuperscriptBox[
     RowBox[{"(", 
      RowBox[{
       SubsuperscriptBox["P", "\[CapitalZeta]", 
        RowBox[{"-", "1"}]], "\[CenterDot]", 
       RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "A", "\[CenterDot]", 
       SubsuperscriptBox["P", "\[CapitalZeta]", 
        RowBox[{"-", "T"}]]}], ")"}], 
     RowBox[{"-", "1"}]], "\[CenterDot]", 
    SubsuperscriptBox["P", "\[CapitalZeta]", 
     RowBox[{"-", "1"}]], "\[CenterDot]", 
    RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "\[CapitalZeta]"}], 
   TraditionalForm]],ExpressionUUID->"71782ec1-e57e-4a36-9cc9-684e06306435"],
 ", have one too many factors of ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["P", "\[CapitalZeta]"], TraditionalForm]],ExpressionUUID->
  "c536a520-ad98-411c-bb70-5ca584b90b94"],
 "."
}], "Text",
 CellChangeTimes->{{3.729094387864348*^9, 3.729094408224104*^9}, {
  3.7290949467513723`*^9, 3.729094978828157*^9}, {3.7290954227665462`*^9, 
  3.729095484361279*^9}, {3.729107556348858*^9, 3.729107556825692*^9}, {
  3.729169365030899*^9, 3.72916938704521*^9}, {3.7291728712132807`*^9, 
  3.7291729647708797`*^9}, {3.729182737533868*^9, 3.729182738415864*^9}, {
  3.7296381231351852`*^9, 3.729638151867065*^9}, {3.729639553579912*^9, 
  3.72963957002866*^9}, {3.729639602824461*^9, 3.729639607872213*^9}, {
  3.729639746459138*^9, 3.729639966397956*^9}, {3.7296461335142803`*^9, 
  3.729646178394472*^9}, {3.729646644796595*^9, 3.729646660280738*^9}, {
  3.7296839614014273`*^9, 3.72968396184893*^9}, {3.729687467727697*^9, 
  3.7296874741909933`*^9}},ExpressionUUID->"a2af6572-cbe8-4201-be03-\
067fcaddce09"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "rlsUpdate", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{
     RowBox[{"rlsUpdate", "[", "sqrtP\[CapitalZeta]_", "]"}], "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\[Xi]_", ",", "\[CapitalLambda]_"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"\[Zeta]_", ",", "a_"}], "}"}]}], "]"}], ":=", 
    "\[IndentingNewLine]", 
    RowBox[{"With", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"sP\[CapitalZeta]ia", "=", 
        RowBox[{"LinearSolve", "[", 
         RowBox[{"sqrtP\[CapitalZeta]", ",", "a"}], "]"}]}], "}"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"With", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"\[CapitalPi]", "=", 
          RowBox[{"(", 
           RowBox[{"\[CapitalLambda]", "+", 
            RowBox[{
             RowBox[{"sP\[CapitalZeta]ia", "\[Transpose]"}], ".", 
             "sP\[CapitalZeta]ia"}]}], ")"}]}], "}"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"LinearSolve", "[", 
           RowBox[{"\[CapitalPi]", ",", 
            RowBox[{"(", 
             RowBox[{
              RowBox[{
               RowBox[{"sP\[CapitalZeta]ia", "\[Transpose]"}], ".", 
               "\[Zeta]"}], "+", 
              RowBox[{"\[CapitalLambda]", ".", "\[Xi]"}]}], ")"}]}], "]"}], 
          ",", "\[CapitalPi]"}], "}"}]}], "]"}]}], "]"}]}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"\[Xi]0", "=", 
        RowBox[{"(", GridBox[{
           {"0"},
           {"0"}
          }], ")"}]}], ",", 
       RowBox[{"\[CapitalLambda]0", "=", 
        RowBox[{"(", GridBox[{
           {"1.0*^-6", "0"},
           {"0", "1.0*^-6"}
          }], ")"}]}], ",", 
       RowBox[{"m", "=", "MatrixForm"}], ",", "\[IndentingNewLine]", 
       RowBox[{"inputs", "=", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
           RowBox[{"List", "/@", 
            RowBox[{"data", "\[LeftDoubleBracket]", 
             RowBox[{"1", ";;", "n"}], "\[RightDoubleBracket]"}]}], ",", 
           RowBox[{"List", "/@", 
            RowBox[{"partials", "\[LeftDoubleBracket]", 
             RowBox[{"1", ";;", "n"}], "\[RightDoubleBracket]"}]}]}], "}"}], 
         "\[Transpose]"}]}]}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"Module", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
        "\[Xi]rr", ",", "\[Xi]r", ",", "\[Xi]k", ",", "\[CapitalPi]rr", ",", 
         "\[CapitalPi]r", ",", "\[CapitalPi]k"}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"\[Xi]rr", ",", "\[CapitalPi]rr"}], "}"}], "=", 
          RowBox[{"Fold", "[", 
           RowBox[{
            RowBox[{"rlsUpdate", "[", 
             RowBox[{"\[Sigma]", " ", 
              RowBox[{"IdentityMatrix", "[", "1", "]"}]}], "]"}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"{", 
             RowBox[{"\[Xi]0", ",", "\[CapitalLambda]0"}], "}"}], ",", 
            "inputs"}], "]"}]}], ")"}], ";", "\[IndentingNewLine]", 
        RowBox[{"(", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"\[Xi]r", ",", "\[CapitalPi]r"}], "}"}], "=", 
          RowBox[{"Fold", "[", 
           RowBox[{"update", ",", 
            RowBox[{"{", 
             RowBox[{"\[Xi]0", ",", "\[CapitalLambda]0"}], "}"}], ",", 
            "inputs"}], "]"}]}], ")"}], ";", "\[IndentingNewLine]", 
        RowBox[{"(", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"\[Xi]k", ",", "\[CapitalPi]k"}], "}"}], "=", 
          RowBox[{"Fold", "[", 
           RowBox[{
            RowBox[{"kalmanUpdate", "[", 
             SuperscriptBox["\[Sigma]", "2"], "]"}], ",", 
            RowBox[{"{", 
             RowBox[{"\[Xi]0", ",", 
              RowBox[{"Inverse", "@", "\[CapitalLambda]0"}]}], "}"}], ",", 
            "inputs"}], "]"}]}], ")"}], ";", "\[IndentingNewLine]", 
        RowBox[{"Grid", "[", 
         RowBox[{
          RowBox[{"{", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{
             "\"\<\>\"", ",", "\"\<Renormalized RLS\>\"", ",", "\"\<RLS\>\"", 
              ",", "\"\<KAL\>\""}], "}"}], ",", "\[IndentingNewLine]", 
            RowBox[{"{", 
             RowBox[{"\"\<Estimate\>\"", ",", 
              RowBox[{"m", "[", 
               RowBox[{
                FractionBox[
                 RowBox[{"IdentityMatrix", "[", "2", "]"}], "\[Sigma]"], ".", 
                "\[Xi]rr"}], "]"}], ",", 
              RowBox[{"m", "@", "\[Xi]r"}], ",", 
              RowBox[{"m", "@", "\[Xi]k"}]}], "}"}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"{", 
             RowBox[{"\"\<Info Mat\>\"", ",", 
              RowBox[{"m", "@", "\[CapitalPi]rr"}], ",", 
              RowBox[{"m", "[", 
               RowBox[{"\[CapitalPi]r", "/", 
                SuperscriptBox["\[Sigma]", "2"]}], "]"}], ",", 
              RowBox[{"m", "[", 
               RowBox[{"Inverse", "@", "\[CapitalPi]k"}], "]"}]}], "}"}], ",",
             "\[IndentingNewLine]", 
            RowBox[{"{", 
             RowBox[{"\"\<Mat Diffs\>\"", ",", "\[IndentingNewLine]", 
              RowBox[{"m", "@", 
               RowBox[{"Chop", "[", 
                RowBox[{
                 RowBox[{"Abs", "[", 
                  RowBox[{"\[CapitalPi]rr", "-", 
                   RowBox[{"\[CapitalPi]r", "/", 
                    SuperscriptBox["\[Sigma]", "2"]}]}], "]"}], ",", 
                 SuperscriptBox["10", 
                  RowBox[{"-", "9"}]]}], "]"}]}], ",", "\[IndentingNewLine]", 
              
              RowBox[{"m", "@", 
               RowBox[{"Chop", "[", 
                RowBox[{
                 RowBox[{"Abs", "[", 
                  RowBox[{
                   RowBox[{"Inverse", "@", "\[CapitalPi]k"}], "-", 
                   RowBox[{"\[CapitalPi]r", "/", 
                    SuperscriptBox["\[Sigma]", "2"]}]}], "]"}], ",", 
                 SuperscriptBox["10", 
                  RowBox[{"-", "9"}]]}], "]"}]}], ",", "\[IndentingNewLine]", 
              
              RowBox[{"m", "@", 
               RowBox[{"Chop", "[", 
                RowBox[{
                 RowBox[{"Abs", "[", 
                  RowBox[{
                   RowBox[{"Inverse", "@", "\[CapitalPi]k"}], "-", 
                   "\[CapitalPi]rr"}], "]"}], ",", 
                 SuperscriptBox["10", 
                  RowBox[{"-", "9"}]]}], "]"}]}]}], "}"}]}], "}"}], ",", 
          RowBox[{"Frame", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{"All", ",", 
             RowBox[{"{", 
              RowBox[{"True", ",", "True", ",", "None"}], "}"}]}], "}"}]}]}], 
         "]"}]}]}], "]"}]}], "]"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"n", ",", "3"}], "}"}], ",", "3", ",", "nData", ",", "1", ",", 
     RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\[Sigma]", ",", "10"}], "}"}], ",", 
     RowBox[{"-", "100"}], ",", "100", ",", 
     RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}]}], 
  "]"}]}], "Input",
 CellChangeTimes->{{3.727054852495049*^9, 3.72705494257406*^9}, {
   3.727055026792467*^9, 3.727055093506559*^9}, {3.7270551930291023`*^9, 
   3.727055263833913*^9}, {3.727055297216107*^9, 3.7270554270906563`*^9}, {
   3.7270560338846903`*^9, 3.72705612788085*^9}, {3.7270561855129213`*^9, 
   3.7270561959544077`*^9}, {3.727056250031129*^9, 3.727056367103942*^9}, {
   3.727056427865035*^9, 3.727056443080068*^9}, {3.727056561323501*^9, 
   3.727056598046468*^9}, {3.727056640141169*^9, 3.727056654582451*^9}, {
   3.727056728700244*^9, 3.7270567914565277`*^9}, {3.727056869366274*^9, 
   3.727056921039433*^9}, 3.72705709924362*^9, {3.727057420502048*^9, 
   3.7270575464285316`*^9}, {3.7270577446377487`*^9, 3.727057775909028*^9}, {
   3.7270578799866133`*^9, 3.727057901007744*^9}, 3.7270581603330593`*^9, {
   3.727058349930079*^9, 3.7270584478842707`*^9}, {3.727058490337566*^9, 
   3.727058577824399*^9}, {3.727058673744141*^9, 3.7270586947547493`*^9}, {
   3.727058788099071*^9, 3.7270588909590683`*^9}, {3.727058934322414*^9, 
   3.7270589393580847`*^9}, {3.72705898616982*^9, 3.7270589868650723`*^9}, {
   3.7270592331231947`*^9, 3.727059237300102*^9}, {3.7274435231168203`*^9, 
   3.727443546500602*^9}, {3.727443876120749*^9, 3.7274438848810577`*^9}, {
   3.727444759010458*^9, 3.727444822403467*^9}, {3.727444904584729*^9, 
   3.727444917600658*^9}, {3.727444951170147*^9, 3.72744495624857*^9}, {
   3.727455276322372*^9, 3.7274553027713842`*^9}, {3.727455828581184*^9, 
   3.727455858661305*^9}, {3.7274561810931997`*^9, 3.727456183162497*^9}, {
   3.727472496770452*^9, 3.727472540592374*^9}, {3.727472571262414*^9, 
   3.7274725926081057`*^9}, {3.727473460371025*^9, 3.727473470385874*^9}, {
   3.727967024755598*^9, 3.7279670373987417`*^9}, 3.727967235445434*^9, {
   3.728948393392125*^9, 3.728948394937408*^9}, {3.7290949247050467`*^9, 
   3.729094943930032*^9}, {3.729095003042301*^9, 3.729095003876113*^9}, {
   3.7290950412490463`*^9, 3.729095051008603*^9}, {3.7290950822550173`*^9, 
   3.729095135857238*^9}, {3.7290951897446327`*^9, 3.729095402554632*^9}, {
   3.729107574665441*^9, 3.7291075901656437`*^9}, 3.7291080484571247`*^9, {
   3.729108084736548*^9, 3.72910825558943*^9}, {3.729161604459531*^9, 
   3.729161610440398*^9}, {3.7291616424288397`*^9, 3.729161760746108*^9}, {
   3.729161803140615*^9, 3.72916181703271*^9}, {3.7291721056426287`*^9, 
   3.729172155283436*^9}, {3.7291721980443363`*^9, 3.729172276420932*^9}, {
   3.729172336052294*^9, 3.729172342704544*^9}, {3.7291723737632227`*^9, 
   3.729172427102948*^9}, {3.729172497300097*^9, 3.7291726002607937`*^9}, {
   3.729172635205014*^9, 3.7291727804950743`*^9}, {3.729172814049247*^9, 
   3.72917282262862*^9}, {3.729172924194323*^9, 3.729172927538876*^9}, {
   3.7291729818445587`*^9, 3.729173000378613*^9}, {3.729174803584015*^9, 
   3.729174827188703*^9}, {3.729635300462594*^9, 3.729635329025786*^9}, 
   3.729636008968544*^9, {3.729636272681835*^9, 3.7296363081017237`*^9}, {
   3.729636416390744*^9, 3.7296364270043907`*^9}, {3.7296365151239147`*^9, 
   3.729636544411797*^9}, {3.729636598430265*^9, 3.729636615497266*^9}, {
   3.729636673165737*^9, 3.729636822399268*^9}, {3.72963687410984*^9, 
   3.7296368920773907`*^9}, {3.7296369845843077`*^9, 
   3.7296370095969133`*^9}, {3.7296371791119556`*^9, 3.729637188403821*^9}, {
   3.729637251543976*^9, 3.7296374636954813`*^9}, {3.7296375127019663`*^9, 
   3.729637650441799*^9}, 3.729637697282694*^9, 3.729637746956402*^9, {
   3.729637912605995*^9, 3.729638007565567*^9}, {3.7296380790331573`*^9, 
   3.729638109879693*^9}, {3.729638194298698*^9, 3.7296382277516327`*^9}, 
   3.72964577609685*^9, {3.7296460525874643`*^9, 3.729646120714403*^9}, 
   3.729682464425685*^9, {3.729682496154779*^9, 3.729682501153379*^9}, {
   3.729683983125988*^9, 3.729683996176063*^9}, {3.7296853629102182`*^9, 
   3.7296853792222557`*^9}, {3.729685411789864*^9, 3.729685447926292*^9}, {
   3.72968551455221*^9, 3.729685521383741*^9}, {3.729685560401882*^9, 
   3.729685629173448*^9}, {3.7296856732126093`*^9, 3.729685903363908*^9}, {
   3.729686096422873*^9, 3.729686185724934*^9}, {3.7296862221744957`*^9, 
   3.729686222655352*^9}, {3.729686261470471*^9, 3.729686307392109*^9}, {
   3.729686344163858*^9, 3.729686424060445*^9}, {3.729686474516107*^9, 
   3.7296865793443832`*^9}, {3.729686619156342*^9, 3.72968666650456*^9}, {
   3.729687217278598*^9, 3.7296872845587063`*^9}, {3.7296876028411913`*^9, 
   3.7296876338678923`*^9}, {3.729798616749312*^9, 3.729798662617351*^9}, {
   3.731661980800391*^9, 3.731662094118231*^9}, {3.731662124351397*^9, 
   3.7316622230238256`*^9}, {3.731662495955132*^9, 3.731662655444421*^9}, {
   3.731662739996496*^9, 3.731662745784322*^9}, {3.731662895968258*^9, 
   3.731662949708384*^9}},
 CellLabel->"In[67]:=",ExpressionUUID->"f3eab681-e533-4cec-8155-72b04604e909"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`n$$ = 3, $CellContext`\[Sigma]$$ = 10, 
    Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`n$$], 3}, 3, 119, 1}, {{
       Hold[$CellContext`\[Sigma]$$], 10}, -100, 100}}, Typeset`size$$ = {
    1073., {96.7010498046875, 105.2989501953125}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = True, $CellContext`n$4185$$ =
     0, $CellContext`\[Sigma]$4186$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`n$$ = 3, $CellContext`\[Sigma]$$ = 10}, 
      "ControllerVariables" :> {
        Hold[$CellContext`n$$, $CellContext`n$4185$$, 0], 
        Hold[$CellContext`\[Sigma]$$, $CellContext`\[Sigma]$4186$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      With[{$CellContext`\[Xi]0$ = {{0}, {
          0}}, $CellContext`\[CapitalLambda]0$ = {{1.*^-6, 0}, {
           0, 1.*^-6}}, $CellContext`m$ = MatrixForm, $CellContext`inputs$ = 
         Transpose[{
            Map[List, 
             Part[$CellContext`data, 
              Span[1, $CellContext`n$$]]], 
            Map[List, 
             Part[$CellContext`partials, 
              Span[1, $CellContext`n$$]]]}]}, 
        Module[{$CellContext`\[Xi]rr$, $CellContext`\[Xi]r$, $CellContext`\
\[Xi]k$, $CellContext`\[CapitalPi]rr$, $CellContext`\[CapitalPi]r$, \
$CellContext`\[CapitalPi]k$}, {$CellContext`\[Xi]rr$, $CellContext`\
\[CapitalPi]rr$} = Fold[
            $CellContext`rlsUpdate[$CellContext`\[Sigma]$$ 
             IdentityMatrix[
              1]], {$CellContext`\[Xi]0$, $CellContext`\[CapitalLambda]0$}, \
$CellContext`inputs$]; {$CellContext`\[Xi]r$, $CellContext`\[CapitalPi]r$} = 
          Fold[$CellContext`update, {$CellContext`\[Xi]0$, $CellContext`\
\[CapitalLambda]0$}, $CellContext`inputs$]; {$CellContext`\[Xi]k$, \
$CellContext`\[CapitalPi]k$} = Fold[
            $CellContext`kalmanUpdate[$CellContext`\[Sigma]$$^2], \
{$CellContext`\[Xi]0$, 
             Inverse[$CellContext`\[CapitalLambda]0$]}, $CellContext`inputs$]; 
         Grid[{{"", "Renormalized RLS", "RLS", "KAL"}, {"Estimate", 
             $CellContext`m$[
              Dot[
              IdentityMatrix[
                2]/$CellContext`\[Sigma]$$, $CellContext`\[Xi]rr$]], 
             $CellContext`m$[$CellContext`\[Xi]r$], 
             $CellContext`m$[$CellContext`\[Xi]k$]}, {"Info Mat", 
             $CellContext`m$[$CellContext`\[CapitalPi]rr$], 
             $CellContext`m$[$CellContext`\[CapitalPi]r$/$CellContext`\[Sigma]\
$$^2], 
             $CellContext`m$[
              Inverse[$CellContext`\[CapitalPi]k$]]}, {"Mat Diffs", 
             $CellContext`m$[
              Chop[
               
               Abs[$CellContext`\[CapitalPi]rr$ - \
$CellContext`\[CapitalPi]r$/$CellContext`\[Sigma]$$^2], 10^(-9)]], 
             $CellContext`m$[
              Chop[
               Abs[
               Inverse[$CellContext`\[CapitalPi]k$] - $CellContext`\
\[CapitalPi]r$/$CellContext`\[Sigma]$$^2], 10^(-9)]], 
             $CellContext`m$[
              Chop[
               Abs[
               Inverse[$CellContext`\[CapitalPi]k$] - $CellContext`\
\[CapitalPi]rr$], 10^(-9)]]}}, Frame -> {All, {True, True, None}}]]], 
      "Specifications" :> {{{$CellContext`n$$, 3}, 3, 119, 1, Appearance -> 
         "Labeled"}, {{$CellContext`\[Sigma]$$, 10}, -100, 100, Appearance -> 
         "Labeled"}}, "Options" :> {}, "DefaultOptions" :> {}],
     ImageSizeCache->{1139., {175., 184.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{
  3.72968605374187*^9, {3.729686160079255*^9, 3.729686224438879*^9}, 
   3.729686308803747*^9, 3.7296863933549547`*^9, 3.729686424622281*^9, {
   3.729686501023221*^9, 3.72968651336834*^9}, {3.7296865684021482`*^9, 
   3.729686582348391*^9}, {3.729686643824795*^9, 3.7296866678473473`*^9}, 
   3.729687255698826*^9, 3.729687285772131*^9, {3.7296876265461206`*^9, 
   3.7296876456103354`*^9}, 3.729778156089766*^9, 3.729779234251914*^9, 
   3.729779281327022*^9, {3.729798617730486*^9, 3.7297986636105833`*^9}, 
   3.731525586579865*^9, 3.731527816846395*^9, 3.7315829950865*^9, {
   3.731661982121278*^9, 3.7316620364313917`*^9}, 3.731662095047181*^9, 
   3.7316621299569397`*^9, {3.731662176088788*^9, 3.731662200241103*^9}, {
   3.731662497400406*^9, 3.731662656251441*^9}, 3.731662747870447*^9, {
   3.731662900931445*^9, 3.731662950289366*^9}, 3.731670259712484*^9, 
   3.731671802663683*^9, 3.731671839334594*^9, 3.7318030024792557`*^9, 
   3.731803353437533*^9, 3.731837029240252*^9},
 CellLabel->"Out[69]=",ExpressionUUID->"349a2574-c09e-4c9c-9ffd-7e11fcdb7f7c"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["RLS beats KAL", "Subsection",
 CellChangeTimes->{{3.729182753746653*^9, 3.729182764662409*^9}, {
  3.7291917374240217`*^9, 3.729191746263137*^9}, {3.7296405387074757`*^9, 
  3.72964054391427*^9}},ExpressionUUID->"e6b7bebe-e457-4cf4-9ba3-\
0618afcaecde"],

Cell["\<\
KAL and renormalized RLS are mathematically equivalent. Operationally, KAL \
uses subtraction to recur the covariance of the estimates, so is exposed to \
catastrophic cancelation. RLS only adds to the information matrix, so is \
exposed only to ill-conditioning, which is empirically less severe. We show \
this below.\
\>", "Text",
 CellChangeTimes->{{3.729108318055666*^9, 3.729108347023395*^9}, {
  3.729119343997692*^9, 3.729119359971643*^9}, {3.729169476126769*^9, 
  3.729169477106061*^9}, {3.72917483481177*^9, 3.7291748799421263`*^9}, {
  3.729191759307276*^9, 3.729191781475971*^9}, {3.729640562998232*^9, 
  3.729640568230112*^9}, {3.729640980175406*^9, 3.729640998789782*^9}, {
  3.7296411048780746`*^9, 3.7296411151875257`*^9}, {3.729641300872263*^9, 
  3.729641334229947*^9}, {3.7296461936050053`*^9, 3.729646207586768*^9}, {
  3.729712752322254*^9, 3.729712803608899*^9}, {3.7297987012257757`*^9, 
  3.729798723965109*^9}},ExpressionUUID->"0baf8cfa-14b7-4fe0-93bb-\
e184e7fdd49d"]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Regularization and MAP", "Chapter",
 CellChangeTimes->{{3.727878613935317*^9, 3.727878617609169*^9}},
 CellTags->"c:14",ExpressionUUID->"5c7c5664-b41c-4b04-8932-015a8fb21123"],

Cell[TextData[{
 "Bishop reports ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Beta]", "=", 
    RowBox[{"11.111", "\[Ellipsis]"}]}], TraditionalForm]],ExpressionUUID->
  "8e22fb9c-13dd-4596-83d2-17c772c852a1"],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Alpha]", "=", "0.005"}], TraditionalForm]],ExpressionUUID->
  "9439b565-4e31-4d22-ae02-3f68785439e4"],
 " in his figure 1.17 (page 32) and in equations 1.70 through 1.72 (page 31), \
which look suspiciously like the equations for Kalman filtering. Bishop\
\[CloseCurlyQuote]s matrix ",
 Cell[BoxData[
  FormBox[
   StyleBox["S",
    FontWeight->"Bold"], TraditionalForm]],ExpressionUUID->
  "15229e6b-eefa-48a8-80b0-df50abb6726b"],
 StyleBox[" looks like ",
  FontWeight->"Plain"],
 Cell[BoxData[
  FormBox[
   SuperscriptBox[
    StyleBox["D",
     FontWeight->"Bold"], 
    RowBox[{"\[ThinSpace]", 
     RowBox[{"-", "1"}]}]], TraditionalForm]],ExpressionUUID->
  "1c5226ee-b619-4054-a482-ddd3e76e3691"],
 " in ",
 Cell[BoxData[
  FormBox["kalmanUpdate", TraditionalForm]], "Code",ExpressionUUID->
  "de857dd2-14f7-46ca-88a7-ba75c4137d1c"],
 " above. Let\[CloseCurlyQuote]s reproduce MAP via RLS and KAL."
}], "Text",
 CellChangeTimes->{{3.727971621209344*^9, 3.727971949635846*^9}, {
  3.72797205224653*^9, 3.7279722021279373`*^9}, {3.7279725817509613`*^9, 
  3.727972703314744*^9}, {3.7280847454753532`*^9, 3.728084792840749*^9}, {
  3.728220011630794*^9, 3.7282200748560743`*^9}, {3.728252317415781*^9, 
  3.728252334400373*^9}, {3.729171081665955*^9, 3.729171117218204*^9}, {
  3.729191351993813*^9, 3.729191365808433*^9}, {3.7291948298181257`*^9, 
  3.729194830792169*^9}, {3.729798750699163*^9, 
  3.72979875284214*^9}},ExpressionUUID->"7d62442d-2662-4b69-bb4b-\
eb7121fd4b2b"],

Cell[CellGroupData[{

Cell["Bishop\[CloseCurlyQuote]s MAP", "Subchapter",
 CellChangeTimes->{{3.72797221730235*^9, 3.727972224770916*^9}, {
  3.728034928939948*^9, 3.7280349304923964`*^9}},
 CellTags->"c:15",ExpressionUUID->"745a88e4-3128-451b-92f3-e1940cb4b2c0"],

Cell[CellGroupData[{

Cell["The MAP Equations", "Subsection",
 CellChangeTimes->{{3.7317606781255283`*^9, 
  3.731760684405781*^9}},ExpressionUUID->"9e2e803a-3851-417d-bf3f-\
1b356271afcd"],

Cell[TextData[{
 "Bishop\[CloseCurlyQuote]s equations 1.70 through 1.72 are reproduced here. \
The dimensions of the identity matrix in ",
 Cell[BoxData[
  FormBox["S", TraditionalForm]],ExpressionUUID->
  "1eacf56a-a8d9-4664-995f-125386c0e309"],
 " is ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalMu]", "+", "1"}], TraditionalForm]],ExpressionUUID->
  "3ce7d474-d9b6-4b6b-9a80-613654c0eeeb"],
 ", where ",
 Cell[BoxData[
  FormBox["\[CapitalMu]", TraditionalForm]],ExpressionUUID->
  "5120e51b-c864-42ac-a6ed-b95ded545421"],
 " is the order of the polynomial, one more than ",
 Cell[BoxData[
  FormBox["\[CapitalMu]", TraditionalForm]],ExpressionUUID->
  "aab244ae-ede9-45f4-b7b4-4d49f0916e6c"],
 " to account for the leading bias term. It turns out that Bishop\
\[CloseCurlyQuote]s ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["S", 
    RowBox[{"-", "1"}]], TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "a88206b3-9e23-4157-9e3f-fa5f5741a8ca"],
 " is exactly the information matrix of RRLS, as we see in the section on ",
 StyleBox["Covariance of the Prediction",
  FontSlant->"Italic"],
 ", below. "
}], "Text",
 CellChangeTimes->{{3.727972249677867*^9, 3.727972263698797*^9}, {
   3.727992395654808*^9, 3.7279924502184677`*^9}, {3.7281700269116917`*^9, 
   3.7281700419010553`*^9}, {3.728170120216963*^9, 3.728170134209874*^9}, {
   3.72911884925035*^9, 3.729118878325338*^9}, {3.729162024195531*^9, 
   3.7291620299164963`*^9}, {3.7291711306418667`*^9, 3.729171176680653*^9}, 
   3.729178684600383*^9, {3.729182872291184*^9, 3.7291828738856*^9}, {
   3.729798765133129*^9, 3.729798765324222*^9}, {3.731803045378565*^9, 
   3.73180309426196*^9}},ExpressionUUID->"aca499ee-d424-47ba-91c1-\
6bb9f604563c"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"m", "(", "x", ")"}], "  ", "=", "  ", 
   RowBox[{"\[Beta]", " ", 
    RowBox[{
     RowBox[{
      RowBox[{"\[Phi]", "\[ThinSpace]", "(", "x", ")"}], "\[Transpose]"}], 
     "\[CenterDot]", "S", "\[CenterDot]", 
     RowBox[{
      UnderoverscriptBox["\[Sum]", 
       RowBox[{"n", "=", "1"}], "N"], 
      RowBox[{
       RowBox[{"\[Phi]", "\[ThinSpace]", "(", 
        SubscriptBox["x", "n"], ")"}], 
       SubscriptBox["t", "n"]}]}]}]}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.727972280222818*^9, 3.7279724431858997`*^9}, {
  3.727972476930735*^9, 3.727972478697866*^9}, {3.7279730887912483`*^9, 
  3.7279731267447147`*^9}},ExpressionUUID->"fbc1f348-e782-4ff1-90e1-\
ccf062fc867d"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{
    SuperscriptBox["s", "2"], "(", "x", ")"}], "  ", "=", "  ", 
   RowBox[{
    SuperscriptBox["\[Beta]", 
     RowBox[{"\[ThinSpace]", 
      RowBox[{"-", "1"}]}]], "+", 
    RowBox[{
     RowBox[{
      RowBox[{"\[Phi]", "\[ThinSpace]", "(", "x", ")"}], "\[Transpose]"}], 
     "\[CenterDot]", "S", "\[CenterDot]", 
     RowBox[{"\[Phi]", "\[ThinSpace]", "(", "x", ")"}]}]}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.7279724613260727`*^9, 3.727972528960863*^9}, {
  3.727972730192233*^9, 3.727972730194661*^9}, {3.727973130733033*^9, 
  3.727973133972931*^9}},ExpressionUUID->"5d418c7f-7bc8-4633-91e0-\
275c4509b20d"],

Cell[BoxData[
 FormBox[
  RowBox[{
   SuperscriptBox["S", 
    RowBox[{"\[ThinSpace]", 
     RowBox[{"-", "1"}]}]], "  ", 
   OverscriptBox["=", "def"], "  ", 
   RowBox[{
    RowBox[{"\[Alpha]", " ", 
     SubscriptBox["I", 
      RowBox[{"\[CapitalMu]", "+", "1"}]]}], "+", 
    RowBox[{"\[Beta]", 
     RowBox[{
      UnderoverscriptBox["\[Sum]", 
       RowBox[{"n", "=", "1"}], "N"], 
      RowBox[{
       RowBox[{"\[Phi]", "\[ThinSpace]", "(", 
        SubscriptBox["x", "n"], ")"}], "\[CenterDot]", 
       RowBox[{
        RowBox[{"\[Phi]", "\[ThinSpace]", "(", 
         SubscriptBox["x", "n"], ")"}], "\[Transpose]"}]}]}]}]}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.72797275156035*^9, 3.727972881609983*^9}, {
  3.727973139344582*^9, 3.727973142448781*^9}, {3.727992385246423*^9, 
  3.727992388437778*^9}},ExpressionUUID->"0ea5cab6-cb7c-4a44-a0f5-\
bccb50c127c2"],

Cell["\<\
Here are some links between Bishop\[CloseCurlyQuote]s formulation and ours, \
without derivation. \
\>", "Text",
 CellChangeTimes->{{3.728247291344137*^9, 3.728247310423942*^9}, {
  3.728248735711397*^9, 3.7282487376877623`*^9}, {3.7318031049438133`*^9, 
  3.731803105821023*^9}},ExpressionUUID->"a48a2e34-f742-4913-8ca2-\
02d091ae3b19"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{
    UnderoverscriptBox["\[Sum]", 
     RowBox[{"n", "=", "1"}], "N"], 
    RowBox[{
     RowBox[{"\[Phi]", "\[ThinSpace]", "(", 
      SubscriptBox["x", "n"], ")"}], 
     SubscriptBox["t", "n"]}]}], "=", 
   RowBox[{
    RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "\[CapitalZeta]"}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.728246767415718*^9, 3.728246838582246*^9}, {
  3.728246899084139*^9, 3.72824690103373*^9}, {3.728247197825539*^9, 
  3.728247228753024*^9}, {3.728247278577318*^9, 
  3.72824728616096*^9}},ExpressionUUID->"133ba4e4-702d-47d3-ae43-\
f290227a85c1"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{
    UnderscriptBox["lim", 
     RowBox[{"\[Alpha]", "\[Rule]", "0"}]], 
    RowBox[{"(", "\[ThinSpace]", 
     RowBox[{
      SuperscriptBox["\[Beta]", 
       RowBox[{"\[ThinSpace]", 
        RowBox[{"-", "1"}]}]], 
      SuperscriptBox["S", 
       RowBox[{"\[ThinSpace]", 
        RowBox[{"-", "1"}]}]]}], ")"}]}], "=", 
   RowBox[{
    RowBox[{"A", "\[Transpose]"}], "\[CenterDot]", "A"}]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.728247724107789*^9, 
  3.728247835449356*^9}},ExpressionUUID->"2955cca1-e387-448b-bcdb-\
740aa86252c1"]
}, Open  ]],

Cell[CellGroupData[{

Cell["\[CapitalPhi] Vectors", "Subsection",
 CellChangeTimes->{{3.728246200325514*^9, 
  3.72824620633247*^9}},ExpressionUUID->"f7e8e836-c281-4b13-9f64-\
b689453a2045"],

Cell[TextData[{
 "Bishop\[CloseCurlyQuote]s ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Phi]", "\[ThinSpace]", "(", 
    SubscriptBox["x", "n"], ")"}], TraditionalForm]],ExpressionUUID->
  "d0357893-7a34-47d5-b9df-6d65e4cd6db3"],
 " is a ",
 Cell[BoxData[
  FormBox[
   RowBox[{"(", 
    RowBox[{"\[CapitalMu]", "+", "1"}], ")"}], TraditionalForm]],
  ExpressionUUID->"be18f1f6-fa19-4618-85e4-a7b0798c19b0"],
 "-dimensional column vector of the powers of the ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["n", "th"], TraditionalForm]],ExpressionUUID->
  "a695a214-da64-4bf6-9e54-8c1109d67926"],
 " input ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["x", "n"], TraditionalForm]],ExpressionUUID->
  "a592915b-b190-4cca-a80f-fa0eb5f0f7b6"],
 ". These powers are the basis functions of a polynomial model for the curve. \
",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Phi]", "\[ThinSpace]", "(", 
    SubscriptBox["x", "n"], ")"}], TraditionalForm]],ExpressionUUID->
  "c73c1dda-88c8-44a2-92c1-fc534674e49f"],
 " is the dual (transpose) of one row of our partials matrix ",
 Cell[BoxData[
  FormBox["A", TraditionalForm]],ExpressionUUID->
  "711ac6f0-8e88-49d6-896e-5df4757ff9bf"],
 ". \n\nAs written, Bishop\[CloseCurlyQuote]s equations are non-recurrent, \
requiring all data ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["t", "n"], TraditionalForm]],ExpressionUUID->
  "8c93d51c-82cf-4849-9217-6ca946a75539"],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Phi]", "\[ThinSpace]", "(", 
    SubscriptBox["x", "n"], ")"}], TraditionalForm]],ExpressionUUID->
  "a73423ff-d81a-49db-8ce5-8bf4b609f34c"],
 " in memory. Plus, as written, they require inverting matrix ",
 Cell[BoxData[
  FormBox["S", TraditionalForm]],ExpressionUUID->
  "883351be-2cb8-44c7-a551-6e0d6beceae2"],
 ". They thus suffer from the operational ills of the normal equations. "
}], "Text",
 CellChangeTimes->{{3.727972933675117*^9, 3.727973078876171*^9}, {
   3.7279731471152554`*^9, 3.727973158916931*^9}, {3.727973221836879*^9, 
   3.727973225832409*^9}, {3.727973303634624*^9, 3.727973419552944*^9}, {
   3.72797356270901*^9, 3.727973628849347*^9}, {3.72797366287252*^9, 
   3.727973666796633*^9}, {3.727974021159554*^9, 3.727974048392016*^9}, {
   3.7279742261495733`*^9, 3.727974272673163*^9}, {3.7279743703033*^9, 
   3.727974393755924*^9}, {3.7279744457003307`*^9, 3.7279744754841213`*^9}, {
   3.7279909913943167`*^9, 3.7279910540283127`*^9}, {3.727992083686421*^9, 
   3.7279920838762627`*^9}, {3.7279924628991203`*^9, 3.727992516567472*^9}, {
   3.728034977126224*^9, 3.7280350056809273`*^9}, {3.7280848433291597`*^9, 
   3.728084865045436*^9}, {3.728084911051063*^9, 3.7280851520750723`*^9}, {
   3.7281700673790197`*^9, 3.728170114044112*^9}, {3.72817017243155*^9, 
   3.728170228710331*^9}, {3.728220150909762*^9, 3.728220256483842*^9}, {
   3.72822645762605*^9, 3.728226489609394*^9}, {3.728252404072995*^9, 
   3.728252407743845*^9}, {3.729031135725021*^9, 3.7290311504327307`*^9}, {
   3.729031182197022*^9, 3.729031247473465*^9}, {3.729118895789219*^9, 
   3.7291189027722054`*^9}, {3.7291191791553907`*^9, 3.729119179167945*^9}, {
   3.7291712705279293`*^9, 3.729171273095373*^9}, {3.7291716361016483`*^9, 
   3.729171713599073*^9}, {3.7291749543161783`*^9, 3.729174983647272*^9}, 
   3.7291828972165833`*^9, {3.729798784388638*^9, 
   3.7297987849222937`*^9}},ExpressionUUID->"6d995139-a278-45a3-8244-\
07749a96e64b"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "\[Phi]", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"\[Phi]", "[", "\[CapitalMu]_", "]"}], "[", "xn_", "]"}], ":=", 
   RowBox[{
    RowBox[{"Quiet", "@", 
     RowBox[{"Table", "[", 
      RowBox[{
       SuperscriptBox["xn", "i"], ",", 
       RowBox[{"{", 
        RowBox[{"i", ",", "0", ",", "\[CapitalMu]"}], "}"}]}], "]"}]}], "/.", 
    
    RowBox[{"{", 
     RowBox[{"Indeterminate", "\[Rule]", "1"}], "}"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"MatrixForm", "/@", 
  RowBox[{
   RowBox[{"\[Phi]", "[", "3", "]"}], "/@", 
   RowBox[{"List", "/@", 
    RowBox[{
    "bts", "\[LeftDoubleBracket]", "1", 
     "\[RightDoubleBracket]"}]}]}]}]}], "Input",
 CellChangeTimes->{{3.727973167925046*^9, 3.7279732069191923`*^9}, {
   3.727973258420764*^9, 3.727973267473878*^9}, {3.727973429851573*^9, 
   3.727973456984548*^9}, {3.7279735073990107`*^9, 3.727973544918976*^9}, {
   3.727973599459084*^9, 3.727973603790498*^9}, {3.7279736372428493`*^9, 
   3.727973649545477*^9}, {3.72797372689071*^9, 3.7279737331067553`*^9}, {
   3.727973816644998*^9, 3.7279738168679523`*^9}, {3.72797400882194*^9, 
   3.7279740141305532`*^9}, {3.727974059584772*^9, 3.727974079989175*^9}, {
   3.727974139169652*^9, 3.727974144037814*^9}, {3.727974283500222*^9, 
   3.727974357586182*^9}, {3.7279743965807533`*^9, 3.727974431722498*^9}, {
   3.727974493179165*^9, 3.7279747668644867`*^9}, {3.727989252021517*^9, 
   3.727989259286603*^9}, {3.7279894297361*^9, 3.727989457309639*^9}, {
   3.72799130695959*^9, 3.727991323954713*^9}, {3.7279914092481813`*^9, 
   3.727991418823888*^9}, {3.727992110982379*^9, 3.727992136250567*^9}, 
   3.727992510695593*^9, 3.727993474811754*^9, 3.729175642856516*^9},
 CellLabel->"In[70]:=",ExpressionUUID->"28b65850-0064-473e-9482-c7728bf05d4a"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1"},
       {"0.`"},
       {"0.`"},
       {"0.`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1.`"},
       {"0.1111111111111111`"},
       {"0.012345679012345678`"},
       {"0.0013717421124828531`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1.`"},
       {"0.2222222222222222`"},
       {"0.04938271604938271`"},
       {"0.010973936899862825`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1.`"},
       {"0.3333333333333333`"},
       {"0.1111111111111111`"},
       {"0.037037037037037035`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1.`"},
       {"0.4444444444444444`"},
       {"0.19753086419753085`"},
       {"0.0877914951989026`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1.`"},
       {"0.5555555555555556`"},
       {"0.308641975308642`"},
       {"0.1714677640603567`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1.`"},
       {"0.6666666666666666`"},
       {"0.4444444444444444`"},
       {"0.2962962962962963`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1.`"},
       {"0.7777777777777777`"},
       {"0.6049382716049381`"},
       {"0.4705075445816184`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1.`"},
       {"0.8888888888888888`"},
       {"0.7901234567901234`"},
       {"0.7023319615912208`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]], ",", 
   TagBox[
    RowBox[{"(", "\[NoBreak]", GridBox[{
       {"1.`"},
       {"1.`"},
       {"1.`"},
       {"1.`"}
      },
      GridBoxAlignment->{
       "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, 
        "Rows" -> {{Baseline}}, "RowsIndexed" -> {}},
      GridBoxSpacings->{"Columns" -> {
          Offset[0.27999999999999997`], {
           Offset[0.7]}, 
          Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
          Offset[0.2], {
           Offset[0.4]}, 
          Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
    Function[BoxForm`e$, 
     MatrixForm[BoxForm`e$]]]}], "}"}]], "Output",
 CellChangeTimes->{
  3.72797476735454*^9, {3.727989442724881*^9, 3.7279894588380623`*^9}, {
   3.727991319054626*^9, 3.727991333268414*^9}, {3.727992119104147*^9, 
   3.727992136593679*^9}, 3.727992528933445*^9, 3.727993509509782*^9, 
   3.728044352739295*^9, 3.7280464487735233`*^9, 3.728066471393063*^9, 
   3.728068121686639*^9, 3.728083785006975*^9, 3.7280907429940033`*^9, 
   3.728169446568424*^9, 3.728169541724071*^9, 3.728169824254798*^9, 
   3.728169884294923*^9, 3.7282529567610817`*^9, 3.7289462573501*^9, 
   3.729022900837743*^9, 3.729119979791541*^9, 3.729121073594092*^9, 
   3.729121112049911*^9, 3.7291723088762493`*^9, 3.729175691909602*^9, 
   3.729175898527714*^9, 3.729183413214457*^9, {3.72918344855357*^9, 
   3.729183461458799*^9}, 3.7292559391231413`*^9, 3.729552302640155*^9, 
   3.7295578767316313`*^9, 3.729629839331705*^9, 3.729634637380622*^9, 
   3.7296428734670143`*^9, 3.729642909800926*^9, 3.7296439400116787`*^9, 
   3.729647186226632*^9, 3.729683245991271*^9, 3.72977817757222*^9, 
   3.7297792343175077`*^9, 3.729779281386825*^9, 3.731525586679324*^9, 
   3.731527816977981*^9, 3.731582995237206*^9, 3.731670259794118*^9, 
   3.7316718027654533`*^9, 3.731671839497781*^9, 3.731803126100218*^9, 
   3.73180335352594*^9, 3.731837029322558*^9},
 CellLabel->"Out[72]=",ExpressionUUID->"106b9f47-9363-47db-94f5-1f12265a592c"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["S Inverse", "Subsection",
 CellChangeTimes->{{3.7282461813905153`*^9, 
  3.728246183677311*^9}},ExpressionUUID->"fc979955-7f91-4dd4-aac0-\
6bf050fb0365"],

Cell["Bishop\[CloseCurlyQuote]s equation 1.72.", "Text",
 CellChangeTimes->{{3.727973854544991*^9, 3.727973958387879*^9}, {
  3.7279935391781883`*^9, 3.7279935616792603`*^9}, {3.7281702480246696`*^9, 
  3.7281702828359957`*^9}, {3.7291717549435673`*^9, 3.729171756365779*^9}, {
  3.729173508646914*^9, 
  3.7291735382601423`*^9}},ExpressionUUID->"8b75787c-e946-4efe-87fe-\
d79c56d3d80b"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{"sInv", ",", "\[Alpha]", ",", "\[Beta]"}], "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"sInv", "[", 
    RowBox[{"\[Alpha]_", ",", "\[Beta]_", ",", "cs_", ",", "\[CapitalMu]_"}], 
    "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\[CapitalNu]", "=", 
       RowBox[{"Length", "[", "cs", "]"}]}], "}"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"\[Alpha]", " ", 
       RowBox[{"IdentityMatrix", "[", 
        RowBox[{"\[CapitalMu]", "+", "1"}], "]"}]}], "+", 
      RowBox[{"\[Beta]", " ", 
       RowBox[{"Sum", "[", 
        RowBox[{
         RowBox[{
          RowBox[{
          "cs", "\[LeftDoubleBracket]", "i", "\[RightDoubleBracket]"}], ".", 
          RowBox[{
           RowBox[{
           "cs", "\[LeftDoubleBracket]", "i", "\[RightDoubleBracket]"}], 
           "\[Transpose]"}]}], ",", 
         RowBox[{"{", 
          RowBox[{"i", ",", "\[CapitalNu]"}], "}"}]}], "]"}]}]}]}], "]"}]}], 
  ";"}]}], "Input",
 CellChangeTimes->{{3.727973884729273*^9, 3.727973893707472*^9}, {
   3.727973967319463*^9, 3.727973981031104*^9}, {3.727974108227893*^9, 
   3.72797411197365*^9}, {3.7279741548510723`*^9, 3.72797416892636*^9}, {
   3.7279748009815598`*^9, 3.727974944132066*^9}, {3.727974978991621*^9, 
   3.727975013741935*^9}, {3.727975044573173*^9, 3.727975082061253*^9}, {
   3.727975179449038*^9, 3.727975183788499*^9}, {3.727989511270849*^9, 
   3.727989517784666*^9}, {3.7279913069753647`*^9, 3.727991306982168*^9}, {
   3.727991851964892*^9, 3.727992057554862*^9}, {3.727992211691082*^9, 
   3.7279923598616533`*^9}, 3.728035965335248*^9, {3.72917351493624*^9, 
   3.729173515353211*^9}},
 CellLabel->"In[73]:=",ExpressionUUID->"48d3e8ca-9708-495b-a0e7-6ff895bff3ae"]
}, Open  ]],

Cell[CellGroupData[{

Cell["MAP Mean", "Subsection",
 CellChangeTimes->{{3.7282462270238667`*^9, 
  3.7282462292069902`*^9}},ExpressionUUID->"7f14bb9f-1bbf-482f-a2d0-\
e4e99dbf491f"],

Cell["Bishop\[CloseCurlyQuote]s equation 1.70.", "Text",
 CellChangeTimes->{{3.7279935722104673`*^9, 3.727993577636578*^9}, {
   3.728252554798936*^9, 3.728252645286251*^9}, {3.729171771786726*^9, 
   3.72917177432257*^9}, 
   3.729182916782524*^9},ExpressionUUID->"b35de153-6b3f-47c6-abbc-\
f4605aa4ae33"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "mapMean", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"mapMean", "[", 
    RowBox[{
    "\[Alpha]_", ",", "\[Beta]_", ",", "x_", ",", "cs_", ",", "ts_", ",", 
     "\[CapitalMu]_"}], "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"With", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\[CapitalNu]", "=", 
        RowBox[{"Length", "@", "cs"}]}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"\[Beta]", "*", 
         RowBox[{
          RowBox[{"\[Phi]", "[", "\[CapitalMu]", "]"}], "[", "x", "]"}]}], 
        "}"}], ".", 
       RowBox[{"(*", " ", 
        RowBox[{"row", " ", "of", " ", "partials"}], " ", "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"LinearSolve", "[", 
        RowBox[{"(*", " ", 
         RowBox[{"vector", " ", "of", " ", "coefficients"}], " ", "*)"}], 
        "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"sInv", "[", 
          RowBox[{
          "\[Alpha]", ",", "\[Beta]", ",", "cs", ",", "\[CapitalMu]"}], "]"}],
          ",", "\[IndentingNewLine]", 
         RowBox[{"ts", ".", "cs"}]}], "]"}]}]}], "]"}], 
    "\[LeftDoubleBracket]", 
    RowBox[{"1", ",", "1"}], "\[RightDoubleBracket]"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.727989096190207*^9, 3.727989111607684*^9}, {
   3.727989185580763*^9, 3.7279892393755693`*^9}, {3.72798955173129*^9, 
   3.727989594075267*^9}, {3.727989624561162*^9, 3.7279897672865*^9}, 
   3.727990207781111*^9, {3.7279902406039467`*^9, 3.727990276509069*^9}, {
   3.727990432145055*^9, 3.727990545195623*^9}, {3.72799130699829*^9, 
   3.727991307005333*^9}, {3.727991591768076*^9, 3.727991609737764*^9}, {
   3.727991645183196*^9, 3.72799166420612*^9}, {3.727992608834428*^9, 
   3.727992654156641*^9}, {3.7279927039199*^9, 3.7279927175692453`*^9}, {
   3.7279930333670883`*^9, 3.727993080952739*^9}, {3.727993138537717*^9, 
   3.727993147323758*^9}, {3.727993213160774*^9, 3.727993217820777*^9}, 
   3.728035955225011*^9, {3.7282262295415688`*^9, 3.728226243962159*^9}, {
   3.728226290221162*^9, 3.728226420069693*^9}, {3.728226502066142*^9, 
   3.728226526171074*^9}, {3.7282265682957487`*^9, 3.728226638371058*^9}, {
   3.728227010234784*^9, 3.7282270232238007`*^9}, {3.728245933205378*^9, 
   3.728245936365489*^9}, {3.7282459778757668`*^9, 3.728246022965337*^9}, {
   3.7282460585043507`*^9, 3.728246102733577*^9}, {3.7282462526429663`*^9, 
   3.728246318744425*^9}, {3.7282463492129383`*^9, 3.7282463559800463`*^9}, {
   3.728246442446768*^9, 3.728246466102882*^9}, {3.728246507569501*^9, 
   3.728246536388625*^9}, {3.728246579393989*^9, 3.7282466681208487`*^9}, {
   3.728247344958013*^9, 3.728247355611513*^9}, {3.7282474213422194`*^9, 
   3.728247422795175*^9}, {3.728247471143052*^9, 3.7282474904691353`*^9}, {
   3.728247907660754*^9, 3.7282479741618853`*^9}, {3.728248056332654*^9, 
   3.728248134124445*^9}, {3.728248164455634*^9, 3.7282481746776342`*^9}, 
   3.728248206633081*^9, {3.7282482403818007`*^9, 3.728248407583012*^9}, {
   3.728248438362019*^9, 3.72824858749609*^9}, {3.728248829569028*^9, 
   3.728249068639111*^9}, {3.728249133978136*^9, 3.7282492510926323`*^9}, 
   3.7282530152093763`*^9, {3.7282530485877857`*^9, 3.7282530512187223`*^9}, {
   3.72825308467808*^9, 3.7282531487824993`*^9}, {3.728253205404887*^9, 
   3.728253436301762*^9}, {3.72830462816504*^9, 3.7283050236694736`*^9}, {
   3.729177176419301*^9, 3.729177182963616*^9}, {3.729177255620264*^9, 
   3.729177269247582*^9}, 3.729177430853569*^9, {3.729177461134405*^9, 
   3.729177625835404*^9}, {3.7291776788725452`*^9, 3.729177737476037*^9}, {
   3.729177797007773*^9, 3.7291777980048656`*^9}, {3.7291783630299997`*^9, 
   3.72917836685954*^9}, {3.729179191155795*^9, 3.729179191813648*^9}},
 CellLabel->"In[75]:=",ExpressionUUID->"54f13db1-d65c-44c7-a28b-58b1ef97b0ff"]
}, Open  ]],

Cell[CellGroupData[{

Cell["A-Priori Variances \[Alpha] and \[Beta]", "Subsection",
 CellChangeTimes->{{3.729433856658804*^9, 3.7294338622133093`*^9}, {
  3.7296329364064617`*^9, 3.729632937814076*^9}, {3.7297178930877743`*^9, 
  3.729717894821443*^9}, {3.729792663995645*^9, 
  3.7297926706425962`*^9}},ExpressionUUID->"6c94572c-7e03-4c46-8136-\
06d0c2475616"],

Cell[TextData[{
 "Bishop defines ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Beta]", "=", 
    RowBox[{"1", "/", 
     SubsuperscriptBox["\[Sigma]", "\[Zeta]", "2"]}]}], TraditionalForm]],
  ExpressionUUID->"3cb59500-197e-4c4e-ac9f-4d98e4a2a78f"],
 ", where ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Sigma]", "\[Zeta]"], TraditionalForm]],ExpressionUUID->
  "4effa52e-3332-40b9-89db-fd17665a3169"],
 " is the standard deviation, from the model, of the prediction ",
 Cell[BoxData[
  FormBox["\[Zeta]", TraditionalForm]],ExpressionUUID->
  "d2430b71-8a16-463d-b08f-b4d69197671a"],
 ". The prediction ",
 Cell[BoxData[
  FormBox["\[Zeta]", TraditionalForm]],ExpressionUUID->
  "b4d5173e-78b5-4555-ba3f-38a350e58db3"],
 " is the value of the model on an arbitrary input ",
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],ExpressionUUID->
  "c0efd558-47a6-464c-8219-11b4b7c12c31"],
 ". Similarly, Bishop defines ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Alpha]", "=", 
    RowBox[{"1", "/", 
     SubsuperscriptBox["\[Sigma]", "\[Xi]", "2"]}]}], TraditionalForm]],
  ExpressionUUID->"da801590-9053-4510-8f2d-61ce312277e8"],
 ", where ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["\[Sigma]", "\[Xi]"], TraditionalForm]],ExpressionUUID->
  "c3e1a099-1dc9-4e14-9310-78cf5ec0e7cf"],
 " is the standard deviation of the a-priori distribution of the unknown \
parameter estimate ",
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],ExpressionUUID->
  "4cbca5ac-87c6-4cca-bb56-d89b90a797bf"],
 ". "
}], "Text",
 CellChangeTimes->CompressedData["
1:eJwdzE0og3EAx/E1kpWDEjUpL0m4GEnTpB6Ww9z0TBY1VoittryNaaVNYm2z
YkVty8tJirK4yFpsB7ILzTMztFmbPNSUUtrG/+fw7XP7VirUPcNcDofDJ0Gp
3TFAX7IUL/0xBrslWTUsLG42Qv3b6gpMKPtN0PWk3oWGJH8fWjKhQ1jqsfpg
uPxcaSaeNLSrIH3XMQk9FKOFBaPM9TGx9oYNQK/+OxQhTtHjL1Bz/5qEs5qf
dyh2P9LPxK8ioRTyOh0z8KjLpYVeyZ4BivOti1AQPQ2kiTtN9TGoqK6RZYmt
m1tDcCFlNMP07bINDtqn537xN4fnoSkosuRcsVQ8WLYBY1WNTrjuW9qGgogs
CNOqigfI9mqjUJjQxWGfv4XJI07I2/4tCR3YLgIslWt0r0G/M/UJ46KRDDyr
Y3Q+opkrn4d/u6btlg==
  
  "],ExpressionUUID->"5c514ede-5b30-4407-8784-9cc4422a30d9"],

Cell[CellGroupData[{

Cell["Mean Is Invariant Under \[OpenCurlyDoubleQuote]Swap and Invert\
\[CloseCurlyDoubleQuote]", "Subsubsection",
 CellChangeTimes->{{3.731760095648629*^9, 3.7317601139852743`*^9}, {
  3.731760717748952*^9, 
  3.731760718213067*^9}},ExpressionUUID->"4168dfd3-c582-479d-8fe3-\
6e245ab90b08"],

Cell[TextData[{
 "We observe, numerically, that Bishop's equations for the estimate (mean) \
match RLS and KAL when ",
 Cell[BoxData[
  FormBox["\[Beta]", TraditionalForm]],ExpressionUUID->
  "a1cdd015-c9ed-46ec-bda8-b8a65628aafe"],
 " is ",
 Cell[BoxData[
  FormBox[
   SubsuperscriptBox["\[Sigma]", "\[Xi]", "2"], TraditionalForm]],
  ExpressionUUID->"a850f77c-d9b2-496b-8a34-bd1d1ee6ccab"],
 " and when ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Alpha]", "=", 
    SubsuperscriptBox["\[Sigma]", "\[Zeta]", "2"]}], TraditionalForm]],
  ExpressionUUID->"0b3cd709-6174-49ff-9194-7ad9208763e2"],
 ", that is, the covariances are swapped and inverted. We leave full proof to \
another paper. Semi-numerically, the proposition is true (above order 4, The \
following becomes taxing for Mathematica). "
}], "Text",
 CellChangeTimes->CompressedData["
1:eJwdzE0og3EAx/GFZOWgRE3KSxIuRtI0qbEc5qZnsiisEJu2vI1ppU1ibbNi
RW3Ly0mKsuYia7EdyC40z8zQZm3yUFNKsY3/b4dvn9u3QqroHs5isVgcEhRb
rP3UJSNgJz/GYJcorYAFRU06qHlbW4UxWZ8e2p8Ue1Ab5xxAYypwBEtcJg8M
lp3LDMST+jY5pO7ap6BLQKtg/ih97STW3DA+6NZ8B0LEaWr8BSrvX+NwTvnz
DoWOR+qZ+FXIE0N2h3UWHnfaVdAt2tdCYZ5pCXLDp74kcbexLgKlVdWSNLFl
a3sILiZ0Bpi8XTHDQcvM/B/+huAC1Pv5xuwrRhD1l27CSGWDDW54lncgNyTx
w6S8/AEyPaow5MXUUdjrbaZziZMDrRmLA4fmCx8jyNE51qHXlviEUf5ICp7V
0moP0Tnxm/Efw37uxQ==
  
  "],ExpressionUUID->"670c63d7-680c-413c-b1fe-67528e14a146"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", 
   RowBox[{"x", ",", "\[Alpha]", ",", "\[Beta]", ",", "chopQ"}], "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"DynamicModule", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"chopQ", "=", "False"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Manipulate", "[", 
    RowBox[{
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"cs", "=", 
          RowBox[{
           RowBox[{"\[Phi]", "[", "\[CapitalMu]", "]"}], "/@", 
           RowBox[{"List", "/@", 
            RowBox[{
            "bts", "\[LeftDoubleBracket]", "1", 
             "\[RightDoubleBracket]"}]}]}]}], ",", 
         RowBox[{"ts", "=", 
          RowBox[{
          "bts", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}]}], 
         ",", "\[IndentingNewLine]", 
         RowBox[{"pf", "=", 
          RowBox[{
           RowBox[{"If", "[", 
            RowBox[{"chopQ", ",", "Chop", ",", "Identity"}], "]"}], "@*", 
           "FullSimplify"}]}]}], "}"}], ",", "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
           RowBox[{"m1", "=", 
            RowBox[{"mapMean", "[", 
             RowBox[{
             "\[Alpha]", ",", "\[Beta]", ",", "x", ",", "cs", ",", "ts", ",", 
              "\[CapitalMu]"}], "]"}]}], ",", "\[IndentingNewLine]", 
           RowBox[{"m2", "=", 
            RowBox[{"mapMean", "[", 
             RowBox[{
              FractionBox["1", "\[Beta]"], ",", 
              FractionBox["1", "\[Alpha]"], ",", "x", ",", "cs", ",", "ts", 
              ",", "\[CapitalMu]"}], "]"}]}], ",", "\[IndentingNewLine]", 
           RowBox[{"si1", "=", 
            RowBox[{"sInv", "[", 
             RowBox[{
             "\[Alpha]", ",", "\[Beta]", ",", "cs", ",", "\[CapitalMu]"}], 
             "]"}]}], ",", "\[IndentingNewLine]", 
           RowBox[{"si2", "=", 
            RowBox[{"sInv", "[", 
             RowBox[{
              FractionBox["1", "\[Beta]"], ",", 
              FractionBox["1", "\[Alpha]"], ",", "cs", ",", "\[CapitalMu]"}], 
             "]"}]}]}], "}"}], ",", "\[IndentingNewLine]", 
         RowBox[{"Grid", "[", 
          RowBox[{
           RowBox[{"(", GridBox[{
              {"\"\<m1\>\"", 
               RowBox[{"pf", "@", "m1"}]},
              {"\"\<m2\>\"", 
               RowBox[{"pf", "@", "m2"}]},
              {"\"\<m1-m2\>\"", 
               RowBox[{"pf", "[", 
                RowBox[{"m1", "-", "m2"}], "]"}]},
              {"\"\<si1\>\"", 
               RowBox[{"pf", "@", "si1"}]},
              {"\"\<si2\>\"", 
               RowBox[{"pf", "@", "si2"}]},
              {"\"\<si1-si2\>\"", 
               RowBox[{"pf", "[", 
                RowBox[{"si1", "-", "si2"}], "]"}]}
             }], ")"}], ",", 
           RowBox[{"Frame", "\[Rule]", "All"}]}], "]"}]}], "]"}]}], "]"}], 
     ",", "\[IndentingNewLine]", 
     RowBox[{"Column", "[", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"Row", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"Button", "[", 
            RowBox[{"\"\<UN-CHOP\>\"", ",", 
             RowBox[{"chopQ", "=", "False"}]}], "]"}], ",", 
           "\"\<        \>\"", ",", "\[IndentingNewLine]", 
           RowBox[{"Button", "[", 
            RowBox[{"\"\<CHOP\>\"", ",", 
             RowBox[{"chopQ", "=", "True"}]}], "]"}]}], "}"}], "]"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"Control", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
            "\[CapitalMu]", ",", "2", ",", "\"\<order \[CapitalMu]\>\""}], 
            "}"}], ",", "0", ",", "4", ",", "1", ",", 
           RowBox[{"Appearance", "\[Rule]", 
            RowBox[{"{", 
             RowBox[{"\"\<Open\>\"", ",", "\"\<Labeled\>\""}], "}"}]}]}], 
          "}"}], "]"}]}], "}"}], "]"}]}], "]"}]}], "]"}]}], "Input",
 CellChangeTimes->{{3.727884681931381*^9, 3.7278848244947367`*^9}, 
   3.727884861217602*^9, {3.727884975910451*^9, 3.7278849940673532`*^9}, {
   3.727885103521431*^9, 3.727885154698123*^9}, {3.72788520225443*^9, 
   3.727885279820177*^9}, {3.727885496115718*^9, 3.727885517688189*^9}, {
   3.72788559395383*^9, 3.727885598972475*^9}, {3.7278856296542664`*^9, 
   3.727885630876935*^9}, {3.727885695972756*^9, 3.727885696864628*^9}, {
   3.727886633660364*^9, 3.72788671287046*^9}, {3.727886975364171*^9, 
   3.727886975439041*^9}, {3.727903476653379*^9, 3.7279034819231358`*^9}, {
   3.727903531862627*^9, 3.727903539245574*^9}, 3.727913149489944*^9, {
   3.727915429732944*^9, 3.7279154437948627`*^9}, {3.727915750998211*^9, 
   3.7279158447033873`*^9}, {3.7279213832695303`*^9, 3.72792149154887*^9}, {
   3.727921523149373*^9, 3.72792161270367*^9}, {3.72792165300301*^9, 
   3.727921654632832*^9}, {3.727921753282296*^9, 3.727921753360197*^9}, {
   3.727924008558401*^9, 3.727924045018003*^9}, {3.727924293814445*^9, 
   3.727924370827516*^9}, 3.727965590613636*^9, {3.7279686551525917`*^9, 
   3.727968670349081*^9}, {3.7279689406605043`*^9, 3.727969019631563*^9}, {
   3.727970883056108*^9, 3.727970945128386*^9}, {3.727971005813472*^9, 
   3.727971023734253*^9}, {3.727990640753121*^9, 3.727990674786282*^9}, {
   3.727990711779483*^9, 3.727990808626033*^9}, {3.727991307012423*^9, 
   3.727991307022031*^9}, {3.7279932412769613`*^9, 3.7279932949280367`*^9}, {
   3.7279933910397243`*^9, 3.727993398358789*^9}, {3.727993778490755*^9, 
   3.72799379332897*^9}, {3.727993826040863*^9, 3.7279938751552763`*^9}, {
   3.727993956673335*^9, 3.727993958184173*^9}, 3.727994128012043*^9, {
   3.7280354067714148`*^9, 3.7280354258611927`*^9}, {3.728035634299762*^9, 
   3.728035732029833*^9}, {3.72803585641748*^9, 3.728035906176405*^9}, {
   3.728038924314391*^9, 3.728039041653799*^9}, {3.728039077026232*^9, 
   3.72803913265169*^9}, {3.728039194847865*^9, 3.728039320044661*^9}, {
   3.728044256958378*^9, 3.728044343151896*^9}, {3.728044393583234*^9, 
   3.728044466540698*^9}, 3.7280447095836163`*^9, {3.728044856722988*^9, 
   3.728044959527645*^9}, {3.728044995179022*^9, 3.728044998104682*^9}, {
   3.728045028753289*^9, 3.728045063548128*^9}, {3.728045464570526*^9, 
   3.728045476328084*^9}, {3.728045812340419*^9, 3.728045836978776*^9}, {
   3.7280461335391397`*^9, 3.728046355530389*^9}, {3.728046392282709*^9, 
   3.728046397281275*^9}, {3.728046429888109*^9, 3.728046434285967*^9}, {
   3.728046509047914*^9, 3.728046577986915*^9}, {3.728048625582951*^9, 
   3.728048658147644*^9}, {3.728048704639155*^9, 3.7280487209829884`*^9}, {
   3.728048763333255*^9, 3.728048783520523*^9}, 3.728048849900649*^9, {
   3.728048881350296*^9, 3.7280488887365723`*^9}, {3.7280489358794527`*^9, 
   3.728048947834031*^9}, {3.7280492952517767`*^9, 3.728049427179392*^9}, {
   3.728049506853256*^9, 3.7280496162697783`*^9}, {3.728050015065921*^9, 
   3.7280500376507397`*^9}, {3.7280500733077374`*^9, 
   3.7280501005796213`*^9}, {3.728089881496944*^9, 3.728089882038129*^9}, {
   3.728090725835964*^9, 3.728090725845487*^9}, {3.728169349750301*^9, 
   3.728169349773612*^9}, {3.728169400997793*^9, 3.728169417906619*^9}, {
   3.728169511798567*^9, 3.728169523731205*^9}, {3.7281696125541363`*^9, 
   3.7281696306368437`*^9}, 3.728226727530678*^9, {3.728226810131266*^9, 
   3.728226816018466*^9}, {3.728226857072884*^9, 3.728226861119492*^9}, 
   3.728245946305786*^9, {3.7282487072286263`*^9, 3.728248709889584*^9}, {
   3.728251170478485*^9, 3.728251170709284*^9}, {3.7282526609079533`*^9, 
   3.728252718943617*^9}, 3.728252776351699*^9, {3.728252825506783*^9, 
   3.7282528275522842`*^9}, {3.7282528645183697`*^9, 3.728252865147182*^9}, 
   3.7282539826691*^9, {3.7291194284711437`*^9, 3.729119493281761*^9}, {
   3.7291195510227203`*^9, 3.729119680314639*^9}, {3.729119849724024*^9, 
   3.7291198585722113`*^9}, {3.7291717881457*^9, 3.729171818317573*^9}, {
   3.729171854440769*^9, 3.729171871385407*^9}, {3.72917192869256*^9, 
   3.7291720371346607`*^9}, {3.729173126976542*^9, 3.729173139435835*^9}, {
   3.729173200255974*^9, 3.729173275110746*^9}, {3.7291733458987417`*^9, 
   3.729173346264063*^9}, {3.729173389656439*^9, 3.729173389676496*^9}, {
   3.729173453362727*^9, 3.729173453374463*^9}, {3.72917500863538*^9, 
   3.729175053102626*^9}, {3.729175506297736*^9, 3.72917551618956*^9}, {
   3.729175643623238*^9, 3.729175648090048*^9}, {3.729176146733549*^9, 
   3.729176146742311*^9}, {3.729178985302376*^9, 3.729179018757811*^9}, {
   3.729179428316293*^9, 3.729179429546385*^9}, {3.729183394535775*^9, 
   3.729183394547886*^9}, {3.729190274999607*^9, 3.72919028248487*^9}, {
   3.729195946539386*^9, 3.729195963662328*^9}, {3.729256050052142*^9, 
   3.729256067693101*^9}, {3.729551202293354*^9, 3.7295512309957952`*^9}, {
   3.7296339987183323`*^9, 3.7296340585670023`*^9}, {3.72963414997302*^9, 
   3.7296342843671503`*^9}, {3.729634402705227*^9, 3.729634445056549*^9}, {
   3.729640374024897*^9, 3.7296403796236258`*^9}, {3.729640414581646*^9, 
   3.729640440813695*^9}, {3.729682825170733*^9, 3.729682850158277*^9}, {
   3.729687964822157*^9, 3.729687976272668*^9}, {3.729688124350306*^9, 
   3.729688350523089*^9}, {3.729688433189711*^9, 3.729688519693812*^9}, {
   3.7296888315942287`*^9, 3.729688853951269*^9}, {3.729688885214087*^9, 
   3.729688980761574*^9}, {3.729689047339793*^9, 3.72968904899368*^9}, {
   3.729689085039751*^9, 3.729689088321394*^9}, {3.729689126691318*^9, 
   3.729689162680344*^9}, {3.729689199269363*^9, 3.729689319536848*^9}, {
   3.7296894525051317`*^9, 3.7296895044680653`*^9}, {3.7296895377540073`*^9, 
   3.729689925517149*^9}, {3.729698780575644*^9, 3.7296988032889967`*^9}, {
   3.72969891708257*^9, 3.729698973930211*^9}, {3.729699028638085*^9, 
   3.729699670715773*^9}, {3.729699704631276*^9, 3.7296997129720783`*^9}, {
   3.729706992747849*^9, 3.729707001634725*^9}, {3.7297070524424753`*^9, 
   3.729707066383106*^9}, {3.7297071244821672`*^9, 3.729707137919736*^9}, {
   3.729707203038928*^9, 3.72970729917104*^9}, {3.729707646971855*^9, 
   3.729707660202389*^9}, {3.7297079419830017`*^9, 3.72970797164758*^9}, {
   3.729708009957337*^9, 3.729708049867004*^9}, {3.729708084939846*^9, 
   3.7297080920715303`*^9}, {3.729708515163211*^9, 3.729708569024414*^9}, {
   3.729708613027947*^9, 3.729708623070286*^9}, {3.729708794113842*^9, 
   3.729708805535737*^9}, {3.729710516671919*^9, 3.7297105167550173`*^9}, {
   3.729715343638529*^9, 3.729715514668886*^9}, {3.72971554649118*^9, 
   3.729715548641029*^9}, {3.729716174415708*^9, 3.7297162284181137`*^9}, {
   3.72971633922969*^9, 3.729716391073391*^9}, {3.729716434095726*^9, 
   3.7297164499844*^9}, {3.72971649749555*^9, 3.7297165316584883`*^9}, {
   3.7297165626756287`*^9, 3.72971664507301*^9}, 3.7297169348805857`*^9, {
   3.729717614590805*^9, 3.72971765727661*^9}, {3.729717764117723*^9, 
   3.729717812221105*^9}, {3.729775043049199*^9, 3.729775109731035*^9}, {
   3.729775163059536*^9, 3.7297751691054783`*^9}, {3.7297752542857*^9, 
   3.729775353153812*^9}, {3.729775426509468*^9, 3.729775439298881*^9}, {
   3.729775501959437*^9, 3.729775509498376*^9}, {3.7297756788539267`*^9, 
   3.729775889524164*^9}, {3.729775998285616*^9, 3.7297760435753508`*^9}, {
   3.729776079463018*^9, 3.72977609036007*^9}, {3.729782135519264*^9, 
   3.729782210852579*^9}, {3.7297822445658417`*^9, 3.729782365608235*^9}, {
   3.729782395984023*^9, 3.7297824531580763`*^9}, {3.729782495606496*^9, 
   3.729782567276868*^9}, {3.729782598609139*^9, 3.729782697457747*^9}, {
   3.729782728227727*^9, 3.7297827325418167`*^9}, {3.729782956333859*^9, 
   3.729782990916945*^9}, {3.7297830295719624`*^9, 3.7297830711784143`*^9}, {
   3.729783101922255*^9, 3.7297831604734583`*^9}, {3.729783202732057*^9, 
   3.7297832061980753`*^9}, {3.729783273985505*^9, 3.729783295285995*^9}, {
   3.729792821533854*^9, 3.7297928677603407`*^9}, {3.731758279121814*^9, 
   3.731758368769455*^9}, {3.731758437471436*^9, 3.731758846731009*^9}, {
   3.731758904246872*^9, 3.7317589420373087`*^9}, {3.731759952708638*^9, 
   3.731759988065346*^9}},
 CellLabel->"In[77]:=",ExpressionUUID->"8c0807b6-1cc7-4f40-b93c-0ca462262062"],

Cell[BoxData[
 DynamicModuleBox[{$CellContext`chopQ$$ = False}, 
  TagBox[
   StyleBox[
    DynamicModuleBox[{$CellContext`\[CapitalMu]$$ = 2, Typeset`show$$ = True, 
     Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
     Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
     "\"untitled\"", Typeset`specs$$ = {{{
        Hold[$CellContext`\[CapitalMu]$$], 2, "order \[CapitalMu]"}, 0, 4, 
       1}, {
       Hold[
        Column[{
          Row[{
            Button["UN-CHOP", $CellContext`chopQ$$ = False], "        ", 
            Button["CHOP", $CellContext`chopQ$$ = True]}], 
          Manipulate`Place[1]}]], Manipulate`Dump`ThisIsNotAControl}}, 
     Typeset`size$$ = {1158., {348.2010498046875, 356.7989501953125}}, 
     Typeset`update$$ = 0, Typeset`initDone$$, Typeset`skipInitDone$$ = 
     True, $CellContext`\[CapitalMu]$4259$$ = 0}, 
     DynamicBox[Manipulate`ManipulateBoxes[
      2, StandardForm, "Variables" :> {$CellContext`\[CapitalMu]$$ = 2}, 
       "ControllerVariables" :> {
         Hold[$CellContext`\[CapitalMu]$$, $CellContext`\[CapitalMu]$4259$$, 
          0]}, "OtherVariables" :> {
        Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
         Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
         Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
         Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> 
       With[{$CellContext`cs$ = Map[
            $CellContext`\[Phi][$CellContext`\[CapitalMu]$$], 
            Map[List, 
             Part[$CellContext`bts, 1]]], $CellContext`ts$ = 
          Part[$CellContext`bts, 2], $CellContext`pf$ = Composition[
            If[$CellContext`chopQ$$, Chop, Identity], FullSimplify]}, 
         With[{$CellContext`m1$ = $CellContext`mapMean[$CellContext`\[Alpha], \
$CellContext`\[Beta], $CellContext`x, $CellContext`cs$, $CellContext`ts$, \
$CellContext`\[CapitalMu]$$], $CellContext`m2$ = $CellContext`mapMean[
            1/$CellContext`\[Beta], 
             1/$CellContext`\[Alpha], $CellContext`x, $CellContext`cs$, \
$CellContext`ts$, $CellContext`\[CapitalMu]$$], $CellContext`si1$ = \
$CellContext`sInv[$CellContext`\[Alpha], $CellContext`\[Beta], \
$CellContext`cs$, $CellContext`\[CapitalMu]$$], $CellContext`si2$ = \
$CellContext`sInv[
            1/$CellContext`\[Beta], 
             1/$CellContext`\[Alpha], $CellContext`cs$, $CellContext`\
\[CapitalMu]$$]}, 
          Grid[{{"m1", 
             $CellContext`pf$[$CellContext`m1$]}, {"m2", 
             $CellContext`pf$[$CellContext`m2$]}, {"m1-m2", 
             $CellContext`pf$[$CellContext`m1$ - $CellContext`m2$]}, {"si1", 
             $CellContext`pf$[$CellContext`si1$]}, {"si2", 
             $CellContext`pf$[$CellContext`si2$]}, {"si1-si2", 
             $CellContext`pf$[$CellContext`si1$ - $CellContext`si2$]}}, Frame -> 
           All]]], "Specifications" :> {{{$CellContext`\[CapitalMu]$$, 2, 
           "order \[CapitalMu]"}, 0, 4, 1, Appearance -> {"Open", "Labeled"}, 
          ControlPlacement -> 1}, 
         Column[{
           Row[{
             Button["UN-CHOP", $CellContext`chopQ$$ = False], "        ", 
             Button["CHOP", $CellContext`chopQ$$ = True]}], 
           Manipulate`Place[1]}]}, "Options" :> {}, "DefaultOptions" :> {}],
      ImageSizeCache->{1224., {453., 462.}},
      SingleEvaluation->True],
     Deinitialization:>None,
     DynamicModuleValues:>{},
     SynchronousInitialization->True,
     UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
     UnsavedVariables:>{Typeset`initDone$$},
     UntrackedVariables:>{Typeset`size$$}], "Manipulate",
    Deployed->True,
    StripOnInput->False],
   Manipulate`InterpretManipulate[1]],
  DynamicModuleValues:>{}]], "Output",
 CellChangeTimes->{
  3.7297782657737503`*^9, 3.729779234914673*^9, 3.729779309463353*^9, 
   3.729782169097911*^9, 3.729782212385736*^9, 3.729782264223064*^9, {
   3.729782321149456*^9, 3.729782334713049*^9}, {3.729782366911766*^9, 
   3.729782409837133*^9}, 3.729782456605835*^9, 3.729782570409789*^9, {
   3.729782606279397*^9, 3.729782640383834*^9}, {3.729782699444137*^9, 
   3.729782733551096*^9}, {3.7297829709597683`*^9, 3.729782991922044*^9}, {
   3.729783051941214*^9, 3.729783072104805*^9}, {3.729783103752767*^9, 
   3.729783162251648*^9}, 3.72978321464939*^9, 3.729783296029469*^9, {
   3.729792849257351*^9, 3.729792868783079*^9}, 3.7315255869961147`*^9, 
   3.731527817074958*^9, 3.731582995354537*^9, 3.731670259838567*^9, 
   3.7316718028184347`*^9, 3.731671839569832*^9, 3.731758371292795*^9, 
   3.731758461781231*^9, 3.7317585928003683`*^9, 3.731758675110376*^9, {
   3.7317587113731956`*^9, 3.731758732627964*^9}, {3.731758832606538*^9, 
   3.7317588479481783`*^9}, 3.731758943288939*^9, {3.731759965955133*^9, 
   3.731759988495071*^9}, {3.731803160869989*^9, 3.731803176666226*^9}, 
   3.731803353604714*^9, 3.7318370294055147`*^9},
 CellLabel->"Out[78]=",ExpressionUUID->"cbc6ff77-4055-438f-b672-1494d6ab9d88"]
}, Open  ]],

Cell[TextData[{
 "The other two combinations, where ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Beta]", "=", 
    RowBox[{
     RowBox[{
      RowBox[{"1", "/", 
       SubsuperscriptBox["\[Sigma]", "\[Zeta]", "2"]}], " ", "\[Wedge]", " ", 
      "\[Alpha]"}], "=", 
     SubsuperscriptBox["\[Sigma]", "\[Zeta]", "2"]}]}], TraditionalForm]],
  ExpressionUUID->"3c8c5deb-108d-43ab-9803-c6eeaa41be5a"],
 " or ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Beta]", "=", 
    RowBox[{
     RowBox[{
      SubsuperscriptBox["\[Sigma]", "\[Xi]", "2"], " ", "\[Wedge]", " ", 
      "\[Alpha]"}], "=", 
     RowBox[{"1", "/", 
      SubsuperscriptBox["\[Sigma]", "\[Xi]", "2"]}]}]}], TraditionalForm]],
  ExpressionUUID->"091d4ea1-9899-4f40-8494-d4a5560376dc"],
 " are not correct. Intuitively, these two combinations do not contain full \
information about the a-priori beliefs in both ",
 Cell[BoxData[
  FormBox["\[Zeta]", TraditionalForm]],ExpressionUUID->
  "25c9f435-1258-4111-ae97-95819c0dc110"],
 " and ",
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],ExpressionUUID->
  "f2270d0c-8d5e-48db-beb9-f5b6e221e6c1"],
 ", so we do not expect them to be correct. This fact can be demonstrated \
numerically.\n\nIn the following demonstration, the numerical evidence for \
equality of the estimates (not the covariances) produced by the two \
applications of MAP becomes overwhelming. MAP, RLS, and KAL match for all \
settings of ",
 Cell[BoxData[
  FormBox[
   SubsuperscriptBox["\[Sigma]", "\[Xi]", "2"], TraditionalForm]],
  ExpressionUUID->"43777bf0-347f-4339-a30b-caaca26375ea"],
 ", ",
 Cell[BoxData[
  FormBox[
   SubsuperscriptBox["\[Sigma]", "\[Zeta]", "2"], TraditionalForm]],
  ExpressionUUID->"03f7d140-bb9e-4b49-a90c-93d03643da4e"],
 ", ",
 Cell[BoxData[
  FormBox["\[CapitalMu]", TraditionalForm]],ExpressionUUID->
  "4e14f357-6e1d-4562-a503-d8a33ad79b0d"],
 " (order of the model), and assignments of ",
 Cell[BoxData[
  FormBox["\[Alpha]", TraditionalForm]],ExpressionUUID->
  "6d988ecb-a118-4856-94a5-c1b3425efc15"],
 " and ",
 Cell[BoxData[
  FormBox["\[Beta]", TraditionalForm]],ExpressionUUID->
  "f755a1b1-ab8a-4891-9c0e-de8f6f0c9f59"],
 ". The one deviation from perfect match concerns KAL. Explore the case where \
the order is around ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[CapitalMu]", "=", "4"}], TraditionalForm]],ExpressionUUID->
  "427b4264-a2e3-4974-a79b-bd1e22d45410"],
 ". For high ",
 Cell[BoxData[
  FormBox[
   SubsuperscriptBox["\[Sigma]", "\[Xi]", "2"], TraditionalForm]],
  ExpressionUUID->"6138c40a-4c79-4f97-88b0-ea1e16441c42"],
 " (don\[CloseCurlyQuote]t believe the a-priori estimate of ",
 Cell[BoxData[
  FormBox["\[Xi]", TraditionalForm]],ExpressionUUID->
  "8ede57ef-973c-4114-bf65-08adc80e2d22"],
 ") and low ",
 Cell[BoxData[
  FormBox[
   SubsuperscriptBox["\[Sigma]", "\[Zeta]z", "2"], TraditionalForm]],
  ExpressionUUID->"976c4626-4857-4fb0-9890-7e1c2c476242"],
 " (",
 StyleBox["do",
  FontSlant->"Italic"],
 " believe the observational data), KAL fluctuates wildly. Why? The Kalman \
denominator ",
 Cell[BoxData[
  FormBox[
   RowBox[{"D", "=", 
    RowBox[{
     SubscriptBox["P", "\[Zeta]"], "+", 
     RowBox[{
      RowBox[{"a", "\[Transpose]"}], 
      SubscriptBox["P", "\[Xi]"], "a"}]}]}], TraditionalForm]],
  ExpressionUUID->"f370fac0-c8e6-480a-bb39-fa1c564318d6"],
 " becomes nearly ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"a", "\[Transpose]"}], 
    SubscriptBox["P", "\[Xi]"], "a"}], TraditionalForm]],ExpressionUUID->
  "a6bc1f16-0b8a-4d78-b8ca-1ec54345ea34"],
 ". The Kalman gain, ",
 Cell[BoxData[
  FormBox[
   RowBox[{"K", "=", 
    RowBox[{
     SubscriptBox["P", "\[Xi]"], " ", 
     RowBox[{"a", "\[Transpose]"}], 
     SuperscriptBox["D", 
      RowBox[{"-", "1"}]]}]}], TraditionalForm]],ExpressionUUID->
  "67d8e535-dd07-4789-8b7e-d765ef3ab24d"],
 " is nearly ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["a", 
    RowBox[{"-", "1"}]], TraditionalForm]],ExpressionUUID->
  "bc26f308-cc73-4f74-99c5-b2cd9c9df669"],
 ". The covariance update, ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"(", 
     RowBox[{"I", "-", 
      RowBox[{"K", " ", "a"}]}], ")"}], "\[CenterDot]", "P"}], 
   TraditionalForm]],ExpressionUUID->"507f8d85-dc1a-442b-8c74-d6548ac0649a"],
 ", becomes ill-conditioned, if not negative, because ",
 Cell[BoxData[
  FormBox[
   RowBox[{"K", " ", "a"}], TraditionalForm]],ExpressionUUID->
  "2f1be427-a6af-4e70-ba49-a962269a03ad"],
 " is near unity. \n\nRenormalized RLS does not suffer from these ills \
because it never subtracts. Renormalized RLS is still exposed to \
ill-conditioning of the information matrix, but that seems numerically to be \
less harmful to the final result in this example. Wrap RLS in ",
 Cell[BoxData[
  FormBox["Quiet", TraditionalForm]], "Code",ExpressionUUID->
  "5bc2626d-10d1-4129-a6ff-b0cfb809366f"],
 " to suppress warnings. There is no free lunch; MAP also shows \
ill-conditioning and is similarly wrapped."
}], "Text",
 CellChangeTimes->{{3.729783790020461*^9, 3.729783833800892*^9}, {
  3.729792752988352*^9, 3.729792754474485*^9}, {3.72979292818992*^9, 
  3.729793090930941*^9}, {3.7297931436578207`*^9, 3.729793265017269*^9}, {
  3.729793300332588*^9, 3.729793320164184*^9}, {3.7297988561592207`*^9, 
  3.729798964992071*^9}, {3.7317594051356916`*^9, 3.731759420415043*^9}, {
  3.731759457993595*^9, 3.731759458854267*^9}, {3.731803232396076*^9, 
  3.731803235009956*^9}},ExpressionUUID->"9d415275-e924-4701-9e69-\
d3a0fa17870e"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "rrlsFit", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"rrlsFit", "[", 
     RowBox[{"\[Sigma]2\[Zeta]_", ",", "\[Sigma]2\[Xi]_"}], "]"}], "[", 
    RowBox[{"\[CapitalMu]_", ",", "trainingSet_"}], "]"}], ":=", 
   "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"xs", "=", 
        RowBox[{
        "trainingSet", "\[LeftDoubleBracket]", "1", 
         "\[RightDoubleBracket]"}]}], ",", 
       RowBox[{"ys", "=", 
        RowBox[{
        "trainingSet", "\[LeftDoubleBracket]", "2", 
         "\[RightDoubleBracket]"}]}]}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"\[Xi]0", "=", 
          RowBox[{"List", "/@", 
           RowBox[{"ConstantArray", "[", 
            RowBox[{"0", ",", 
             RowBox[{"\[CapitalMu]", "+", "1"}]}], "]"}]}]}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"\[CapitalLambda]0", "=", 
          RowBox[{
           SuperscriptBox["\[Sigma]2\[Xi]", 
            RowBox[{"-", "1"}]], "*", 
           RowBox[{"IdentityMatrix", "[", 
            RowBox[{"\[CapitalMu]", "+", "1"}], "]"}]}]}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"Module", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"\[Xi]", ",", "\[CapitalLambda]"}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{
           RowBox[{"{", 
            RowBox[{"\[Xi]", ",", "\[CapitalLambda]"}], "}"}], "=", 
           RowBox[{"Fold", "[", "\[IndentingNewLine]", 
            RowBox[{
             RowBox[{"rlsUpdate", "[", 
              RowBox[{
               SqrtBox["\[Sigma]2\[Zeta]"], " ", 
               RowBox[{"IdentityMatrix", "[", "1", "]"}]}], "]"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"{", 
              RowBox[{"\[Xi]0", ",", "\[CapitalLambda]0"}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{
                RowBox[{"List", "/@", "ys"}], ",", 
                RowBox[{"List", "/@", 
                 RowBox[{"partialsFn", "[", 
                  RowBox[{"\[CapitalMu]", ",", "xs"}], "]"}]}]}], "}"}], 
              "\[Transpose]"}]}], "]"}]}], ";", "\[IndentingNewLine]", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"\[Xi]", "/", 
             SqrtBox["\[Sigma]2\[Zeta]"]}], ",", "\[CapitalLambda]"}], 
           "}"}]}]}], "]"}]}], "]"}]}], "]"}]}], ";"}]}], "Input",
 CellChangeTimes->{
  3.729633130001239*^9, {3.729633467830708*^9, 3.729633492149434*^9}, {
   3.7296337563259163`*^9, 3.729633881138937*^9}, {3.729634078099366*^9, 
   3.729634114632291*^9}, {3.729634488868413*^9, 3.729634543490809*^9}, {
   3.729634604318096*^9, 3.729634609788732*^9}, {3.729634698866778*^9, 
   3.7296346994928493`*^9}, {3.729634739708737*^9, 3.729634753142261*^9}, {
   3.729634799344757*^9, 3.7296347996478977`*^9}, {3.729634920657688*^9, 
   3.729634927950851*^9}, {3.729634993197016*^9, 3.729635007292894*^9}, {
   3.729640041813924*^9, 3.729640137924788*^9}, {3.72964025016105*^9, 
   3.729640319535129*^9}, {3.7296827987466717`*^9, 3.729682819296286*^9}, {
   3.729683287333426*^9, 3.729683287716338*^9}},
 CellLabel->"In[79]:=",ExpressionUUID->"0c528889-9a88-42b3-b34d-187b989c26be"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"DynamicModule", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"\[Alpha]\[Beta]Bishop", "=", "True"}], "}"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"Manipulate", "[", 
    RowBox[{
     RowBox[{"Module", "[", 
      RowBox[{
       RowBox[{"{", "x", "}"}], ",", "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
           RowBox[{"terms", "=", 
            RowBox[{"symbolicPowers", "[", 
             RowBox[{"x", ",", "\[CapitalMu]"}], "]"}]}], ",", 
           RowBox[{"cs", "=", 
            RowBox[{
             RowBox[{"\[Phi]", "[", "\[CapitalMu]", "]"}], "/@", 
             RowBox[{"List", "/@", 
              RowBox[{
              "bts", "\[LeftDoubleBracket]", "1", 
               "\[RightDoubleBracket]"}]}]}]}], ",", 
           RowBox[{"ts", "=", 
            RowBox[{
            "bts", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}]}], 
           ",", 
           RowBox[{"\[Sigma]\[Zeta]2", "=", 
            SuperscriptBox["10.", 
             RowBox[{"2", "log\[Sigma]\[Zeta]"}]]}], ",", 
           RowBox[{"\[Sigma]\[Xi]2", "=", 
            SuperscriptBox["10.", 
             RowBox[{"2", "log\[Sigma]\[Xi]"}]]}]}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"With", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"normal", "=", 
              RowBox[{"mleFit", "[", 
               RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"kalman", "=", 
              RowBox[{
               RowBox[{"kalFit", "[", 
                RowBox[{"\[Sigma]\[Zeta]2", ",", "\[Sigma]\[Xi]2"}], "]"}], 
               "[", 
               RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"rrls", "=", 
              RowBox[{"Quiet", "@", 
               RowBox[{
                RowBox[{"rrlsFit", "[", 
                 RowBox[{"\[Sigma]\[Zeta]2", ",", "\[Sigma]\[Xi]2"}], "]"}], 
                "[", 
                RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}]}]}], "}"}], ",",
            "\[IndentingNewLine]", 
           RowBox[{"With", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{
               RowBox[{"\[Alpha]", "=", 
                RowBox[{"If", "[", 
                 RowBox[{"\[Alpha]\[Beta]Bishop", ",", 
                  FractionBox["1", "\[Sigma]\[Xi]2"], ",", 
                  "\[Sigma]\[Zeta]2"}], "]"}]}], ",", 
               RowBox[{"\[Beta]", "=", 
                RowBox[{"If", "[", 
                 RowBox[{"\[Alpha]\[Beta]Bishop", ",", 
                  FractionBox["1", "\[Sigma]\[Zeta]2"], ",", 
                  "\[Sigma]\[Xi]2"}], "]"}]}]}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"With", "[", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{
                 RowBox[{"mleFn", "=", 
                  RowBox[{"terms", ".", "normal"}]}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"kalFn", "=", 
                  RowBox[{
                   RowBox[{"{", "terms", "}"}], ".", 
                   RowBox[{
                   "kalman", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}]}]}], ",", "\[IndentingNewLine]", 
                 RowBox[{"mapFn", "=", 
                  RowBox[{"Quiet", "@", 
                   RowBox[{"mapMean", "[", 
                    RowBox[{
                    "\[Alpha]", ",", "\[Beta]", ",", "x", ",", "cs", ",", 
                    "ts", ",", "\[CapitalMu]"}], "]"}]}]}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"rlsFn", "=", 
                  RowBox[{
                   RowBox[{"{", "terms", "}"}], ".", 
                   RowBox[{
                   "rrls", "\[LeftDoubleBracket]", "1", 
                    "\[RightDoubleBracket]"}]}]}]}], "}"}], ",", 
               "\[IndentingNewLine]", 
               RowBox[{"With", "[", 
                RowBox[{
                 RowBox[{"{", 
                  RowBox[{"lp", "=", 
                   RowBox[{"ListPlot", "[", 
                    RowBox[{
                    RowBox[{"bts", "\[Transpose]"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"PlotMarkers", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Graphics", "@", 
                    RowBox[{"{", 
                    RowBox[{"Blue", ",", 
                    RowBox[{"Circle", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"0", ",", "0"}], "}"}], ",", "1"}], "]"}]}], 
                    "}"}]}], ",", ".05"}], "}"}]}]}], "]"}]}], "}"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"Module", "[", 
                  RowBox[{
                   RowBox[{"{", 
                    RowBox[{"showlist", "=", 
                    RowBox[{"{", 
                    RowBox[{"lp", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox[
                    RowBox[{"Sin", "[", 
                    RowBox[{"2.", "\[Pi]", " ", "x"}], "]"}],
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0.", ",", "1."}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"Thick", ",", 
                    StyleBox["Green",
                    Background->RGBColor[1, 1, 0]]}], "}"}]}]}], "]"}]}], 
                    "}"}]}], "}"}], ",", "\[IndentingNewLine]", 
                   RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{"mleQ", ",", 
                    RowBox[{"AppendTo", "[", 
                    RowBox[{"showlist", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox["mleFn",
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    StyleBox["Orange",
                    Background->RGBColor[1, 1, 0]], "}"}]}]}], "]"}]}], 
                    "]"}]}], "]"}], ";", "\[IndentingNewLine]", 
                    RowBox[{"If", "[", 
                    RowBox[{"rlsQ", ",", 
                    RowBox[{"AppendTo", "[", 
                    RowBox[{"showlist", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox["rlsFn",
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    StyleBox["Purple",
                    Background->RGBColor[1, 1, 0]], "}"}]}]}], "]"}]}], 
                    "]"}]}], "]"}], ";", 
                    RowBox[{"If", "[", 
                    RowBox[{"kalQ", ",", 
                    RowBox[{"AppendTo", "[", 
                    RowBox[{"showlist", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox["kalFn",
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    StyleBox["Cyan",
                    Background->RGBColor[1, 1, 0]], "}"}]}]}], "]"}]}], 
                    "]"}]}], "]"}], ";", "\[IndentingNewLine]", 
                    RowBox[{"If", "[", 
                    RowBox[{"mapQ", ",", 
                    RowBox[{"AppendTo", "[", 
                    RowBox[{"showlist", ",", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    StyleBox["mapFn",
                    Background->RGBColor[1, 1, 0]], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    StyleBox["Magenta",
                    Background->RGBColor[1, 1, 0]], "}"}]}]}], "]"}]}], 
                    "]"}]}], "]"}], ";", "\[IndentingNewLine]", 
                    RowBox[{"Quiet", "@", 
                    RowBox[{"Show", "[", 
                    RowBox[{"showlist", ",", 
                    RowBox[{"Frame", "\[Rule]", "True"}], ",", 
                    RowBox[{"ImageSize", "\[Rule]", "Medium"}], ",", 
                    RowBox[{"FrameLabel", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"\"\<\[Zeta]\>\"", ",", "\"\<\>\""}], "}"}], ",", 
                    
                    RowBox[{"{", 
                    RowBox[{"\"\<\[Xi]\>\"", ",", 
                    RowBox[{"Grid", "[", 
                    RowBox[{"{", 
                    RowBox[{"{", 
                    RowBox[{
                    "\"\<\[Alpha]: \>\"", ",", "\[Alpha]", ",", 
                    "\"\<\[Beta]:\>\"", ",", "\[Beta]"}], "}"}], "}"}], 
                    "]"}]}], "\[IndentingNewLine]", "}"}]}], "}"}]}]}], 
                    "]"}]}]}]}], "]"}]}], "]"}]}], "]"}]}], "]"}]}], "]"}]}], 
        "]"}]}], "]"}], ",", "\[IndentingNewLine]", 
     RowBox[{"Column", "[", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"SetterBar", "[", 
         RowBox[{
          RowBox[{"Dynamic", "[", "\[Alpha]\[Beta]Bishop", "]"}], ",", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{
            "True", "\[Rule]", 
             "\"\<\[Alpha] = \!\(\*FractionBox[\(1\), SubsuperscriptBox[\(\
\[Sigma]\), \(\[Xi]\), \(2\)]]\), \[Beta] = \!\(\*FractionBox[\(1\), \
SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \(2\)]]\)\>\""}], ",", 
            RowBox[{
            "False", "\[Rule]", 
             "\"\<\[Alpha] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \
\(\[Zeta]\), \(2\)]\), \[Beta] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \
\(\[Xi]\), \(2\)]\)\>\""}]}], "}"}]}], "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Row", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"Button", "[", 
             RowBox[{"\"\<RESET\>\"", ",", 
              RowBox[{
               RowBox[{"(", 
                RowBox[{
                 RowBox[{"\[CapitalMu]", "=", "4"}], ";", 
                 RowBox[{"log\[Sigma]\[Xi]", "=", ".5"}], ";", 
                 RowBox[{"log\[Sigma]\[Zeta]", "=", 
                  RowBox[{"-", "1.5"}]}]}], ")"}], "&"}]}], "]"}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"Control", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"kalQ", ",", "True", ",", "\"\<        KAL\>\""}], 
                "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"Control", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"rlsQ", ",", "True", ",", "\"\<        RLS\>\""}], 
                "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"Control", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"mleQ", ",", "False", ",", "\"\<        MLE\>\""}], 
                "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}], ",", 
            "\[IndentingNewLine]", 
            RowBox[{"Control", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"mapQ", ",", "True", ",", "\"\<        MAP\>\""}], 
                "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}]}], 
           "}"}], ",", 
          RowBox[{"Frame", "\[Rule]", "All"}]}], "]"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"Control", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
            "\[CapitalMu]", ",", "4", ",", "\"\<order \[CapitalMu]\>\""}], 
            "}"}], ",", "0", ",", "16", ",", "1", ",", 
           RowBox[{"Appearance", "\[Rule]", 
            RowBox[{"{", "\"\<Labeled\>\"", "}"}]}]}], "}"}], "]"}], ",", 
        RowBox[{"Control", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
            "log\[Sigma]\[Xi]", ",", ".5", ",", 
             "\"\<log \[Sigma]\[Xi] (KAL)\>\""}], "}"}], ",", 
           RowBox[{"-", "3"}], ",", " ", "5", ",", 
           RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
         "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Control", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"log\[Sigma]\[Zeta]", ",", 
             RowBox[{"-", "1.5"}], ",", "\"\<log \[Sigma]\[Zeta] (KAL)\>\""}],
             "}"}], ",", 
           RowBox[{"-", "7"}], ",", "3", ",", 
           RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
         "]"}]}], "}"}], "]"}]}], "]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.727884681931381*^9, 3.7278848244947367`*^9}, 
   3.727884861217602*^9, {3.727884975910451*^9, 3.7278849940673532`*^9}, {
   3.727885103521431*^9, 3.727885154698123*^9}, {3.72788520225443*^9, 
   3.727885279820177*^9}, {3.727885496115718*^9, 3.727885517688189*^9}, {
   3.72788559395383*^9, 3.727885598972475*^9}, {3.7278856296542664`*^9, 
   3.727885630876935*^9}, {3.727885695972756*^9, 3.727885696864628*^9}, {
   3.727886633660364*^9, 3.72788671287046*^9}, {3.727886975364171*^9, 
   3.727886975439041*^9}, {3.727903476653379*^9, 3.7279034819231358`*^9}, {
   3.727903531862627*^9, 3.727903539245574*^9}, 3.727913149489944*^9, {
   3.727915429732944*^9, 3.7279154437948627`*^9}, {3.727915750998211*^9, 
   3.7279158447033873`*^9}, {3.7279213832695303`*^9, 3.72792149154887*^9}, {
   3.727921523149373*^9, 3.72792161270367*^9}, {3.72792165300301*^9, 
   3.727921654632832*^9}, {3.727921753282296*^9, 3.727921753360197*^9}, {
   3.727924008558401*^9, 3.727924045018003*^9}, {3.727924293814445*^9, 
   3.727924370827516*^9}, 3.727965590613636*^9, {3.7279686551525917`*^9, 
   3.727968670349081*^9}, {3.7279689406605043`*^9, 3.727969019631563*^9}, {
   3.727970883056108*^9, 3.727970945128386*^9}, {3.727971005813472*^9, 
   3.727971023734253*^9}, {3.727990640753121*^9, 3.727990674786282*^9}, {
   3.727990711779483*^9, 3.727990808626033*^9}, {3.727991307012423*^9, 
   3.727991307022031*^9}, {3.7279932412769613`*^9, 3.7279932949280367`*^9}, {
   3.7279933910397243`*^9, 3.727993398358789*^9}, {3.727993778490755*^9, 
   3.72799379332897*^9}, {3.727993826040863*^9, 3.7279938751552763`*^9}, {
   3.727993956673335*^9, 3.727993958184173*^9}, 3.727994128012043*^9, {
   3.7280354067714148`*^9, 3.7280354258611927`*^9}, {3.728035634299762*^9, 
   3.728035732029833*^9}, {3.72803585641748*^9, 3.728035906176405*^9}, {
   3.728038924314391*^9, 3.728039041653799*^9}, {3.728039077026232*^9, 
   3.72803913265169*^9}, {3.728039194847865*^9, 3.728039320044661*^9}, {
   3.728044256958378*^9, 3.728044343151896*^9}, {3.728044393583234*^9, 
   3.728044466540698*^9}, 3.7280447095836163`*^9, {3.728044856722988*^9, 
   3.728044959527645*^9}, {3.728044995179022*^9, 3.728044998104682*^9}, {
   3.728045028753289*^9, 3.728045063548128*^9}, {3.728045464570526*^9, 
   3.728045476328084*^9}, {3.728045812340419*^9, 3.728045836978776*^9}, {
   3.7280461335391397`*^9, 3.728046355530389*^9}, {3.728046392282709*^9, 
   3.728046397281275*^9}, {3.728046429888109*^9, 3.728046434285967*^9}, {
   3.728046509047914*^9, 3.728046577986915*^9}, {3.728048625582951*^9, 
   3.728048658147644*^9}, {3.728048704639155*^9, 3.7280487209829884`*^9}, {
   3.728048763333255*^9, 3.728048783520523*^9}, 3.728048849900649*^9, {
   3.728048881350296*^9, 3.7280488887365723`*^9}, {3.7280489358794527`*^9, 
   3.728048947834031*^9}, {3.7280492952517767`*^9, 3.728049427179392*^9}, {
   3.728049506853256*^9, 3.7280496162697783`*^9}, {3.728050015065921*^9, 
   3.7280500376507397`*^9}, {3.7280500733077374`*^9, 
   3.7280501005796213`*^9}, {3.728089881496944*^9, 3.728089882038129*^9}, {
   3.728090725835964*^9, 3.728090725845487*^9}, {3.728169349750301*^9, 
   3.728169349773612*^9}, {3.728169400997793*^9, 3.728169417906619*^9}, {
   3.728169511798567*^9, 3.728169523731205*^9}, {3.7281696125541363`*^9, 
   3.7281696306368437`*^9}, 3.728226727530678*^9, {3.728226810131266*^9, 
   3.728226816018466*^9}, {3.728226857072884*^9, 3.728226861119492*^9}, 
   3.728245946305786*^9, {3.7282487072286263`*^9, 3.728248709889584*^9}, {
   3.728251170478485*^9, 3.728251170709284*^9}, {3.7282526609079533`*^9, 
   3.728252718943617*^9}, 3.728252776351699*^9, {3.728252825506783*^9, 
   3.7282528275522842`*^9}, {3.7282528645183697`*^9, 3.728252865147182*^9}, 
   3.7282539826691*^9, {3.7291194284711437`*^9, 3.729119493281761*^9}, {
   3.7291195510227203`*^9, 3.729119680314639*^9}, {3.729119849724024*^9, 
   3.7291198585722113`*^9}, {3.7291717881457*^9, 3.729171818317573*^9}, {
   3.729171854440769*^9, 3.729171871385407*^9}, {3.72917192869256*^9, 
   3.7291720371346607`*^9}, {3.729173126976542*^9, 3.729173139435835*^9}, {
   3.729173200255974*^9, 3.729173275110746*^9}, {3.7291733458987417`*^9, 
   3.729173346264063*^9}, {3.729173389656439*^9, 3.729173389676496*^9}, {
   3.729173453362727*^9, 3.729173453374463*^9}, {3.72917500863538*^9, 
   3.729175053102626*^9}, {3.729175506297736*^9, 3.72917551618956*^9}, {
   3.729175643623238*^9, 3.729175648090048*^9}, {3.729176146733549*^9, 
   3.729176146742311*^9}, {3.729178985302376*^9, 3.729179018757811*^9}, {
   3.729179428316293*^9, 3.729179429546385*^9}, {3.729183394535775*^9, 
   3.729183394547886*^9}, {3.729190274999607*^9, 3.72919028248487*^9}, {
   3.729195946539386*^9, 3.729195963662328*^9}, {3.729256050052142*^9, 
   3.729256067693101*^9}, {3.729551202293354*^9, 3.7295512309957952`*^9}, {
   3.7296339987183323`*^9, 3.7296340585670023`*^9}, {3.72963414997302*^9, 
   3.7296342843671503`*^9}, {3.729634402705227*^9, 3.729634445056549*^9}, {
   3.729640374024897*^9, 3.7296403796236258`*^9}, {3.729640414581646*^9, 
   3.729640440813695*^9}, {3.729682825170733*^9, 3.729682850158277*^9}, {
   3.729687964822157*^9, 3.729687976272668*^9}, {3.729688124350306*^9, 
   3.729688350523089*^9}, {3.729688433189711*^9, 3.729688519693812*^9}, {
   3.7296888315942287`*^9, 3.729688853951269*^9}, {3.729688885214087*^9, 
   3.729688980761574*^9}, {3.729689047339793*^9, 3.72968904899368*^9}, {
   3.729689085039751*^9, 3.729689088321394*^9}, {3.729689126691318*^9, 
   3.729689162680344*^9}, {3.729689199269363*^9, 3.729689319536848*^9}, {
   3.7296894525051317`*^9, 3.7296895044680653`*^9}, {3.7296895377540073`*^9, 
   3.729689925517149*^9}, {3.729698780575644*^9, 3.7296988032889967`*^9}, {
   3.72969891708257*^9, 3.729698973930211*^9}, {3.729699028638085*^9, 
   3.729699670715773*^9}, {3.729699704631276*^9, 3.7296997129720783`*^9}, {
   3.729706992747849*^9, 3.729707001634725*^9}, {3.7297070524424753`*^9, 
   3.729707066383106*^9}, {3.7297071244821672`*^9, 3.729707137919736*^9}, {
   3.729707203038928*^9, 3.72970729917104*^9}, {3.729707646971855*^9, 
   3.729707660202389*^9}, {3.7297079419830017`*^9, 3.72970797164758*^9}, {
   3.729708009957337*^9, 3.729708049867004*^9}, {3.729708084939846*^9, 
   3.7297080920715303`*^9}, {3.729708515163211*^9, 3.729708569024414*^9}, {
   3.729708613027947*^9, 3.729708623070286*^9}, {3.729708794113842*^9, 
   3.729708805535737*^9}, {3.729710516671919*^9, 3.7297105167550173`*^9}, {
   3.729784342249545*^9, 3.7297847167390738`*^9}, {3.729784762209856*^9, 
   3.7297847785042458`*^9}, {3.729784818040599*^9, 3.7297849058292437`*^9}, {
   3.729784947378476*^9, 3.7297849866650257`*^9}, {3.729790334304122*^9, 
   3.7297904006081543`*^9}, {3.7297904543011217`*^9, 3.729790469826312*^9}, {
   3.729790510736865*^9, 3.729790515646512*^9}, {3.729790569437749*^9, 
   3.729790630375985*^9}, {3.729790726049513*^9, 3.7297908347358427`*^9}, {
   3.729790886318983*^9, 3.7297908985495443`*^9}, {3.729790931251046*^9, 
   3.72979112317486*^9}, {3.72979116931327*^9, 3.729791269353731*^9}, {
   3.729791359892681*^9, 3.729791406067814*^9}, {3.7297914485241547`*^9, 
   3.72979144921026*^9}, {3.729791484698999*^9, 3.729791499044384*^9}, {
   3.729791566561154*^9, 3.729791584345121*^9}, {3.7297916430977707`*^9, 
   3.7297917327178802`*^9}, {3.729791770348117*^9, 3.729791837674281*^9}},
 CellLabel->"In[81]:=",ExpressionUUID->"daf34d48-70c5-4161-9b91-805d3b5d8479"],

Cell[BoxData[
 DynamicModuleBox[{$CellContext`\[Alpha]\[Beta]Bishop$$ = True}, 
  TagBox[
   StyleBox[
    DynamicModuleBox[{$CellContext`kalQ$$ = 
     True, $CellContext`log\[Sigma]\[Zeta]$$ = -1.5, $CellContext`log\[Sigma]\
\[Xi]$$ = 0.5, $CellContext`mapQ$$ = True, $CellContext`mleQ$$ = 
     False, $CellContext`rlsQ$$ = True, $CellContext`\[CapitalMu]$$ = 4, 
     Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
     Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
     1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{{
        Hold[$CellContext`kalQ$$], True, "        KAL"}, {True, False}}, {{
        Hold[$CellContext`rlsQ$$], True, "        RLS"}, {True, False}}, {{
        Hold[$CellContext`mleQ$$], False, "        MLE"}, {True, False}}, {{
        Hold[$CellContext`mapQ$$], True, "        MAP"}, {True, False}}, {{
        Hold[$CellContext`\[CapitalMu]$$], 4, "order \[CapitalMu]"}, 0, 16, 
       1}, {{
        Hold[$CellContext`log\[Sigma]\[Xi]$$], 0.5, 
        "log \[Sigma]\[Xi] (KAL)"}, -3, 5}, {{
        Hold[$CellContext`log\[Sigma]\[Zeta]$$], -1.5, 
        "log \[Sigma]\[Zeta] (KAL)"}, -7, 3}, {
       Hold[
        Column[{
          SetterBar[
           Dynamic[$CellContext`\[Alpha]\[Beta]Bishop$$], {
           True -> "\[Alpha] = \!\(\*FractionBox[\(1\), SubsuperscriptBox[\(\
\[Sigma]\), \(\[Xi]\), \(2\)]]\), \[Beta] = \!\(\*FractionBox[\(1\), \
SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \(2\)]]\)", False -> 
            "\[Alpha] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \(\[Zeta]\), \
\(2\)]\), \[Beta] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \
\(2\)]\)"}], 
          Row[{
            Button[
            "RESET", ($CellContext`\[CapitalMu]$$ = 
              4; $CellContext`log\[Sigma]\[Xi]$$ = 
              0.5; $CellContext`log\[Sigma]\[Zeta]$$ = -1.5)& ], 
            Manipulate`Place[1], 
            Manipulate`Place[2], 
            Manipulate`Place[3], 
            Manipulate`Place[4]}, Frame -> All], 
          Manipulate`Place[5], 
          Manipulate`Place[6], 
          Manipulate`Place[7]}]], Manipulate`Dump`ThisIsNotAControl}}, 
     Typeset`size$$ = {540., {174., 182.}}, Typeset`update$$ = 0, 
     Typeset`initDone$$, Typeset`skipInitDone$$ = 
     True, $CellContext`kalQ$6394$$ = False, $CellContext`rlsQ$6395$$ = 
     False, $CellContext`mleQ$6396$$ = False, $CellContext`mapQ$6397$$ = 
     False, $CellContext`\[CapitalMu]$6398$$ = 
     0, $CellContext`log\[Sigma]\[Xi]$6399$$ = 
     0, $CellContext`log\[Sigma]\[Zeta]$6400$$ = 0}, 
     DynamicBox[Manipulate`ManipulateBoxes[
      2, StandardForm, 
       "Variables" :> {$CellContext`kalQ$$ = 
         True, $CellContext`log\[Sigma]\[Zeta]$$ = -1.5, $CellContext`log\
\[Sigma]\[Xi]$$ = 0.5, $CellContext`mapQ$$ = True, $CellContext`mleQ$$ = 
         False, $CellContext`rlsQ$$ = True, $CellContext`\[CapitalMu]$$ = 4}, 
       "ControllerVariables" :> {
         Hold[$CellContext`kalQ$$, $CellContext`kalQ$6394$$, False], 
         Hold[$CellContext`rlsQ$$, $CellContext`rlsQ$6395$$, False], 
         Hold[$CellContext`mleQ$$, $CellContext`mleQ$6396$$, False], 
         Hold[$CellContext`mapQ$$, $CellContext`mapQ$6397$$, False], 
         Hold[$CellContext`\[CapitalMu]$$, $CellContext`\[CapitalMu]$6398$$, 
          0], 
         Hold[$CellContext`log\[Sigma]\[Xi]$$, \
$CellContext`log\[Sigma]\[Xi]$6399$$, 0], 
         Hold[$CellContext`log\[Sigma]\[Zeta]$$, $CellContext`log\[Sigma]\
\[Zeta]$6400$$, 0]}, 
       "OtherVariables" :> {
        Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
         Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
         Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
         Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> 
       Module[{$CellContext`x$}, 
         With[{$CellContext`terms$ = \
$CellContext`symbolicPowers[$CellContext`x$, $CellContext`\[CapitalMu]$$], \
$CellContext`cs$ = Map[
             $CellContext`\[Phi][$CellContext`\[CapitalMu]$$], 
             Map[List, 
              Part[$CellContext`bts, 1]]], $CellContext`ts$ = 
           Part[$CellContext`bts, 2], $CellContext`\[Sigma]\[Zeta]2$ = 
           10.^(2 $CellContext`log\[Sigma]\[Zeta]$$), $CellContext`\[Sigma]\
\[Xi]2$ = 10.^(2 $CellContext`log\[Sigma]\[Xi]$$)}, 
          
          With[{$CellContext`normal$ = $CellContext`mleFit[$CellContext`\
\[CapitalMu]$$, $CellContext`bts], $CellContext`kalman$ = \
$CellContext`kalFit[$CellContext`\[Sigma]\[Zeta]2$, \
$CellContext`\[Sigma]\[Xi]2$][$CellContext`\[CapitalMu]$$, $CellContext`bts], \
$CellContext`rrls$ = Quiet[
              $CellContext`rrlsFit[$CellContext`\[Sigma]\[Zeta]2$, \
$CellContext`\[Sigma]\[Xi]2$][$CellContext`\[CapitalMu]$$, \
$CellContext`bts]]}, 
           
           With[{$CellContext`\[Alpha]$ = 
             If[$CellContext`\[Alpha]\[Beta]Bishop$$, 
               1/$CellContext`\[Sigma]\[Xi]2$, \
$CellContext`\[Sigma]\[Zeta]2$], $CellContext`\[Beta]$ = 
             If[$CellContext`\[Alpha]\[Beta]Bishop$$, 
               1/$CellContext`\[Sigma]\[Zeta]2$, \
$CellContext`\[Sigma]\[Xi]2$]}, 
            
            With[{$CellContext`mleFn$ = 
              Dot[$CellContext`terms$, $CellContext`normal$], \
$CellContext`kalFn$ = Dot[{$CellContext`terms$}, 
                Part[$CellContext`kalman$, 1]], $CellContext`mapFn$ = Quiet[
                $CellContext`mapMean[$CellContext`\[Alpha]$, $CellContext`\
\[Beta]$, $CellContext`x$, $CellContext`cs$, $CellContext`ts$, $CellContext`\
\[CapitalMu]$$]], $CellContext`rlsFn$ = Dot[{$CellContext`terms$}, 
                Part[$CellContext`rrls$, 1]]}, 
             With[{$CellContext`lp$ = ListPlot[
                 Transpose[$CellContext`bts], PlotMarkers -> {
                   Graphics[{Blue, 
                    Circle[{0, 0}, 1]}], 0.05}]}, 
              Module[{$CellContext`showlist$ = {$CellContext`lp$, 
                  Plot[
                   Sin[2. Pi $CellContext`x$], {$CellContext`x$, 0., 1.}, 
                   PlotStyle -> {Thick, Green}]}}, If[$CellContext`mleQ$$, 
                 AppendTo[$CellContext`showlist$, 
                  
                  Plot[$CellContext`mleFn$, {$CellContext`x$, 0, 1}, 
                   PlotStyle -> {Orange}]]]; If[$CellContext`rlsQ$$, 
                 AppendTo[$CellContext`showlist$, 
                  
                  Plot[$CellContext`rlsFn$, {$CellContext`x$, 0, 1}, 
                   PlotStyle -> {Purple}]]]; If[$CellContext`kalQ$$, 
                 AppendTo[$CellContext`showlist$, 
                  
                  Plot[$CellContext`kalFn$, {$CellContext`x$, 0, 1}, 
                   PlotStyle -> {Cyan}]]]; If[$CellContext`mapQ$$, 
                 AppendTo[$CellContext`showlist$, 
                  
                  Plot[$CellContext`mapFn$, {$CellContext`x$, 0, 1}, 
                   PlotStyle -> {Magenta}]]]; Quiet[
                 
                 Show[$CellContext`showlist$, Frame -> True, ImageSize -> 
                  Medium, FrameLabel -> {{"\[Zeta]", ""}, {"\[Xi]", 
                    
                    Grid[{{"\[Alpha]: ", $CellContext`\[Alpha]$, 
                    "\[Beta]:", $CellContext`\[Beta]$}}]}}]]]]]]]]], 
       "Specifications" :> {{{$CellContext`kalQ$$, True, "        KAL"}, {
          True, False}, ControlPlacement -> 
          1}, {{$CellContext`rlsQ$$, True, "        RLS"}, {True, False}, 
          ControlPlacement -> 
          2}, {{$CellContext`mleQ$$, False, "        MLE"}, {True, False}, 
          ControlPlacement -> 
          3}, {{$CellContext`mapQ$$, True, "        MAP"}, {True, False}, 
          ControlPlacement -> 
          4}, {{$CellContext`\[CapitalMu]$$, 4, "order \[CapitalMu]"}, 0, 16, 
          1, Appearance -> {"Labeled"}, ControlPlacement -> 
          5}, {{$CellContext`log\[Sigma]\[Xi]$$, 0.5, 
           "log \[Sigma]\[Xi] (KAL)"}, -3, 5, Appearance -> "Labeled", 
          ControlPlacement -> 
          6}, {{$CellContext`log\[Sigma]\[Zeta]$$, -1.5, 
           "log \[Sigma]\[Zeta] (KAL)"}, -7, 3, Appearance -> "Labeled", 
          ControlPlacement -> 7}, 
         Column[{
           SetterBar[
            Dynamic[$CellContext`\[Alpha]\[Beta]Bishop$$], {
            True -> "\[Alpha] = \!\(\*FractionBox[\(1\), SubsuperscriptBox[\(\
\[Sigma]\), \(\[Xi]\), \(2\)]]\), \[Beta] = \!\(\*FractionBox[\(1\), \
SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \(2\)]]\)", False -> 
             "\[Alpha] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \(\[Zeta]\), \
\(2\)]\), \[Beta] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \
\(2\)]\)"}], 
           Row[{
             Button[
             "RESET", ($CellContext`\[CapitalMu]$$ = 
               4; $CellContext`log\[Sigma]\[Xi]$$ = 
               0.5; $CellContext`log\[Sigma]\[Zeta]$$ = -1.5)& ], 
             Manipulate`Place[1], 
             Manipulate`Place[2], 
             Manipulate`Place[3], 
             Manipulate`Place[4]}, Frame -> All], 
           Manipulate`Place[5], 
           Manipulate`Place[6], 
           Manipulate`Place[7]}]}, "Options" :> {}, "DefaultOptions" :> {}],
      ImageSizeCache->{606., {321., 329.}},
      SingleEvaluation->True],
     Deinitialization:>None,
     DynamicModuleValues:>{},
     SynchronousInitialization->True,
     UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
     UnsavedVariables:>{Typeset`initDone$$},
     UntrackedVariables:>{Typeset`size$$}], "Manipulate",
    Deployed->True,
    StripOnInput->False],
   Manipulate`InterpretManipulate[1]],
  DynamicModuleValues:>{}]], "Output",
 CellChangeTimes->{
  3.729784381207548*^9, 3.7297844163676357`*^9, {3.729784455537157*^9, 
   3.7297844797500753`*^9}, 3.72978454961663*^9, {3.729784579881394*^9, 
   3.729784637108739*^9}, {3.729784681722384*^9, 3.729784717710224*^9}, 
   3.729784779431076*^9, 3.729784841514982*^9, 3.729784874445601*^9, 
   3.7297849071649437`*^9, 3.729784987534523*^9, {3.729790344993404*^9, 
   3.729790401881814*^9}, 3.729790471804407*^9, 3.729790516129326*^9, {
   3.729790611352343*^9, 3.729790631024955*^9}, 3.7297908377804728`*^9, 
   3.729791052324683*^9, 3.729791125345771*^9, 3.729791176940489*^9, {
   3.729791226113031*^9, 3.7297912700673437`*^9}, {3.729791366986239*^9, 
   3.7297914073716087`*^9}, 3.729791450410841*^9, {3.7297914878437138`*^9, 
   3.729791499782393*^9}, {3.729791573356472*^9, 3.7297915848841753`*^9}, {
   3.729791700338099*^9, 3.729791721639224*^9}, 3.729791807132395*^9, 
   3.731525587359068*^9, 3.73152781742505*^9, 3.7315829955648212`*^9, 
   3.731670260062196*^9, 3.731671802958537*^9, 3.731671839808331*^9, 
   3.731803241357608*^9, 3.7318033539865828`*^9, 3.731837030007495*^9},
 CellLabel->"Out[81]=",ExpressionUUID->"2c728718-13f7-486a-8a98-0d07d9ef72ad"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Covariance and Information Matrices", "Subsubsection",
 CellChangeTimes->{{3.731757346711896*^9, 
  3.731757353278956*^9}},ExpressionUUID->"4336228a-36c1-403e-9e47-\
bdc1e8420710"],

Cell[TextData[{
 "Notice that Bishop' s Information matrix, ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["S", 
    RowBox[{"-", "1"}]], TraditionalForm]],ExpressionUUID->
  "2813f066-621e-42f3-b0e7-637b80549d68"],
 ", is different when ",
 Cell[BoxData[
  FormBox["\[Alpha]", TraditionalForm]],ExpressionUUID->
  "7cfc8b3c-8df0-40f4-969c-4bdb0ede2fe2"],
 " and ",
 Cell[BoxData[
  FormBox["\[Beta]", TraditionalForm]],ExpressionUUID->
  "51c098fd-402f-496c-9088-2531d661099d"],
 " are swapped and inverted; it can only be used as an information matrix \
when ",
 Cell[BoxData[
  FormBox["\[Alpha]", TraditionalForm]],ExpressionUUID->
  "e1379c29-4378-4793-bd9d-afe4e3004cf6"],
 " and ",
 Cell[BoxData[
  FormBox["\[Beta]", TraditionalForm]],ExpressionUUID->
  "5249a1a4-93a5-4b91-8894-e9905d495392"],
 " have their original assignments as ",
 Cell[BoxData[
  FormBox[
   RowBox[{"1", "/", 
    SubsuperscriptBox["\[Sigma]", "\[Xi]", "2"]}], TraditionalForm]],
  ExpressionUUID->"49930280-df1d-4cb2-8917-502f5bcaf442"],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{"1", "/", 
    SubsuperscriptBox["\[Sigma]", "\[Zeta]", "2"]}], TraditionalForm]],
  ExpressionUUID->"3bbae410-f62d-4e61-a2f9-b9655290f0f1"],
 ", respectively. The meaning of ",
 Cell[BoxData[
  FormBox[
   SuperscriptBox["S", 
    RowBox[{"-", "1"}]], TraditionalForm]],ExpressionUUID->
  "c07a2fd5-35a2-419c-a8ee-8bf0f460f5c3"],
 " under the swapped and inverted assignments of ",
 Cell[BoxData[
  FormBox["\[Alpha]", TraditionalForm]],ExpressionUUID->
  "a7e4efae-87f9-4941-9958-d33d5443058f"],
 " and ",
 Cell[BoxData[
  FormBox["\[Beta]", TraditionalForm]],ExpressionUUID->
  "d7c7db5e-2a33-4a85-9e1a-fee3cf3ff3ce"],
 " has not been explored."
}], "Text",
 CellChangeTimes->{{3.7317595008367*^9, 3.731759522457942*^9}, {
  3.731759654899416*^9, 
  3.731759785980098*^9}},ExpressionUUID->"de36e4fe-9e51-407a-b8b5-\
d391384bf05d"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"DynamicModule", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"\[Alpha]\[Beta]Bishop", "=", "True"}], "}"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"Manipulate", "[", 
    RowBox[{
     RowBox[{"Module", "[", 
      RowBox[{
       RowBox[{"{", "x", "}"}], ",", "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
           RowBox[{"cs", "=", 
            RowBox[{
             RowBox[{"\[Phi]", "[", "\[CapitalMu]", "]"}], "/@", 
             RowBox[{"List", "/@", 
              RowBox[{
              "bts", "\[LeftDoubleBracket]", "1", 
               "\[RightDoubleBracket]"}]}]}]}], ",", 
           RowBox[{"ts", "=", 
            RowBox[{
            "bts", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}]}], 
           ",", 
           RowBox[{"\[Sigma]\[Zeta]2", "=", 
            SuperscriptBox["10.", 
             RowBox[{"2", "log\[Sigma]\[Zeta]"}]]}], ",", 
           RowBox[{"\[Sigma]\[Xi]2", "=", 
            SuperscriptBox["10.", 
             RowBox[{"2", "log\[Sigma]\[Xi]"}]]}]}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"With", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"kalman", "=", 
              RowBox[{
               RowBox[{"kalFit", "[", 
                RowBox[{"\[Sigma]\[Zeta]2", ",", "\[Sigma]\[Xi]2"}], "]"}], 
               "[", 
               RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"rrls", "=", 
              RowBox[{"Quiet", "@", 
               RowBox[{
                RowBox[{"rrlsFit", "[", 
                 RowBox[{"\[Sigma]\[Zeta]2", ",", "\[Sigma]\[Xi]2"}], "]"}], 
                "[", 
                RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}]}]}], "}"}], ",",
            "\[IndentingNewLine]", 
           RowBox[{"With", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{
               RowBox[{"\[Alpha]", "=", 
                RowBox[{"If", "[", 
                 RowBox[{"\[Alpha]\[Beta]Bishop", ",", 
                  FractionBox["1", "\[Sigma]\[Xi]2"], ",", 
                  "\[Sigma]\[Zeta]2"}], "]"}]}], ",", 
               RowBox[{"\[Beta]", "=", 
                RowBox[{"If", "[", 
                 RowBox[{"\[Alpha]\[Beta]Bishop", ",", 
                  FractionBox["1", "\[Sigma]\[Zeta]2"], ",", 
                  "\[Sigma]\[Xi]2"}], "]"}]}]}], "}"}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"Grid", "[", 
              RowBox[{"(", GridBox[{
                 {"\"\<inverse\\nKAL P\>\"", 
                  RowBox[{"MatrixForm", "[", 
                   RowBox[{"Inverse", "[", 
                    RowBox[{
                    "kalman", "\[LeftDoubleBracket]", "2", 
                    "\[RightDoubleBracket]"}], "]"}], "]"}]},
                 {"\"\<rrls \[CapitalLambda]\>\"", 
                  RowBox[{"MatrixForm", "[", 
                   RowBox[{
                   "rrls", "\[LeftDoubleBracket]", "2", 
                    "\[RightDoubleBracket]"}], "]"}]},
                 {"\"\<Bishop \!\(\*SuperscriptBox[\(S\), \(-1\)]\)\>\"", 
                  RowBox[{"MatrixForm", "[", 
                   RowBox[{"sInv", "[", 
                    RowBox[{
                    "\[Alpha]", ",", "\[Beta]", ",", "cs", ",", 
                    "\[CapitalMu]"}], "]"}], "]"}]}
                }], ")"}], "]"}]}], "   ", "]"}]}], "]"}]}], "]"}]}], "]"}], 
     ",", "\[IndentingNewLine]", 
     RowBox[{"Column", "[", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"SetterBar", "[", 
         RowBox[{
          RowBox[{"Dynamic", "[", "\[Alpha]\[Beta]Bishop", "]"}], ",", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{
            "True", "\[Rule]", 
             "\"\<\[Alpha] = \!\(\*FractionBox[\(1\), SubsuperscriptBox[\(\
\[Sigma]\), \(\[Xi]\), \(2\)]]\), \[Beta] = \!\(\*FractionBox[\(1\), \
SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \(2\)]]\)\>\""}], ",", 
            RowBox[{
            "False", "\[Rule]", 
             "\"\<\[Alpha] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \
\(\[Zeta]\), \(2\)]\), \[Beta] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \
\(\[Xi]\), \(2\)]\)\>\""}]}], "}"}]}], "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Row", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"Button", "[", 
            RowBox[{"\"\<RESET\>\"", ",", 
             RowBox[{
              RowBox[{"(", 
               RowBox[{
                RowBox[{"\[CapitalMu]", "=", "4"}], ";", 
                RowBox[{"log\[Sigma]\[Xi]", "=", ".5"}], ";", 
                RowBox[{"log\[Sigma]\[Zeta]", "=", 
                 RowBox[{"-", "1.5"}]}]}], ")"}], "&"}]}], "]"}], "}"}], ",", 
          
          RowBox[{"Frame", "\[Rule]", "All"}]}], "]"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"Control", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
            "\[CapitalMu]", ",", "4", ",", "\"\<order \[CapitalMu]\>\""}], 
            "}"}], ",", "0", ",", "16", ",", "1", ",", 
           RowBox[{"Appearance", "\[Rule]", 
            RowBox[{"{", "\"\<Labeled\>\"", "}"}]}]}], "}"}], "]"}], ",", 
        RowBox[{"Control", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
            "log\[Sigma]\[Xi]", ",", ".5", ",", 
             "\"\<log \[Sigma]\[Xi] (KAL)\>\""}], "}"}], ",", 
           RowBox[{"-", "3"}], ",", " ", "5", ",", 
           RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
         "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Control", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"log\[Sigma]\[Zeta]", ",", 
             RowBox[{"-", "1.5"}], ",", "\"\<log \[Sigma]\[Zeta] (KAL)\>\""}],
             "}"}], ",", 
           RowBox[{"-", "7"}], ",", "3", ",", 
           RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
         "]"}]}], "}"}], "]"}]}], "]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.727884681931381*^9, 3.7278848244947367`*^9}, 
   3.727884861217602*^9, {3.727884975910451*^9, 3.7278849940673532`*^9}, {
   3.727885103521431*^9, 3.727885154698123*^9}, {3.72788520225443*^9, 
   3.727885279820177*^9}, {3.727885496115718*^9, 3.727885517688189*^9}, {
   3.72788559395383*^9, 3.727885598972475*^9}, {3.7278856296542664`*^9, 
   3.727885630876935*^9}, {3.727885695972756*^9, 3.727885696864628*^9}, {
   3.727886633660364*^9, 3.72788671287046*^9}, {3.727886975364171*^9, 
   3.727886975439041*^9}, {3.727903476653379*^9, 3.7279034819231358`*^9}, {
   3.727903531862627*^9, 3.727903539245574*^9}, 3.727913149489944*^9, {
   3.727915429732944*^9, 3.7279154437948627`*^9}, {3.727915750998211*^9, 
   3.7279158447033873`*^9}, {3.7279213832695303`*^9, 3.72792149154887*^9}, {
   3.727921523149373*^9, 3.72792161270367*^9}, {3.72792165300301*^9, 
   3.727921654632832*^9}, {3.727921753282296*^9, 3.727921753360197*^9}, {
   3.727924008558401*^9, 3.727924045018003*^9}, {3.727924293814445*^9, 
   3.727924370827516*^9}, 3.727965590613636*^9, {3.7279686551525917`*^9, 
   3.727968670349081*^9}, {3.7279689406605043`*^9, 3.727969019631563*^9}, {
   3.727970883056108*^9, 3.727970945128386*^9}, {3.727971005813472*^9, 
   3.727971023734253*^9}, {3.727990640753121*^9, 3.727990674786282*^9}, {
   3.727990711779483*^9, 3.727990808626033*^9}, {3.727991307012423*^9, 
   3.727991307022031*^9}, {3.7279932412769613`*^9, 3.7279932949280367`*^9}, {
   3.7279933910397243`*^9, 3.727993398358789*^9}, {3.727993778490755*^9, 
   3.72799379332897*^9}, {3.727993826040863*^9, 3.7279938751552763`*^9}, {
   3.727993956673335*^9, 3.727993958184173*^9}, 3.727994128012043*^9, {
   3.7280354067714148`*^9, 3.7280354258611927`*^9}, {3.728035634299762*^9, 
   3.728035732029833*^9}, {3.72803585641748*^9, 3.728035906176405*^9}, {
   3.728038924314391*^9, 3.728039041653799*^9}, {3.728039077026232*^9, 
   3.72803913265169*^9}, {3.728039194847865*^9, 3.728039320044661*^9}, {
   3.728044256958378*^9, 3.728044343151896*^9}, {3.728044393583234*^9, 
   3.728044466540698*^9}, 3.7280447095836163`*^9, {3.728044856722988*^9, 
   3.728044959527645*^9}, {3.728044995179022*^9, 3.728044998104682*^9}, {
   3.728045028753289*^9, 3.728045063548128*^9}, {3.728045464570526*^9, 
   3.728045476328084*^9}, {3.728045812340419*^9, 3.728045836978776*^9}, {
   3.7280461335391397`*^9, 3.728046355530389*^9}, {3.728046392282709*^9, 
   3.728046397281275*^9}, {3.728046429888109*^9, 3.728046434285967*^9}, {
   3.728046509047914*^9, 3.728046577986915*^9}, {3.728048625582951*^9, 
   3.728048658147644*^9}, {3.728048704639155*^9, 3.7280487209829884`*^9}, {
   3.728048763333255*^9, 3.728048783520523*^9}, 3.728048849900649*^9, {
   3.728048881350296*^9, 3.7280488887365723`*^9}, {3.7280489358794527`*^9, 
   3.728048947834031*^9}, {3.7280492952517767`*^9, 3.728049427179392*^9}, {
   3.728049506853256*^9, 3.7280496162697783`*^9}, {3.728050015065921*^9, 
   3.7280500376507397`*^9}, {3.7280500733077374`*^9, 
   3.7280501005796213`*^9}, {3.728089881496944*^9, 3.728089882038129*^9}, {
   3.728090725835964*^9, 3.728090725845487*^9}, {3.728169349750301*^9, 
   3.728169349773612*^9}, {3.728169400997793*^9, 3.728169417906619*^9}, {
   3.728169511798567*^9, 3.728169523731205*^9}, {3.7281696125541363`*^9, 
   3.7281696306368437`*^9}, 3.728226727530678*^9, {3.728226810131266*^9, 
   3.728226816018466*^9}, {3.728226857072884*^9, 3.728226861119492*^9}, 
   3.728245946305786*^9, {3.7282487072286263`*^9, 3.728248709889584*^9}, {
   3.728251170478485*^9, 3.728251170709284*^9}, {3.7282526609079533`*^9, 
   3.728252718943617*^9}, 3.728252776351699*^9, {3.728252825506783*^9, 
   3.7282528275522842`*^9}, {3.7282528645183697`*^9, 3.728252865147182*^9}, 
   3.7282539826691*^9, {3.7291194284711437`*^9, 3.729119493281761*^9}, {
   3.7291195510227203`*^9, 3.729119680314639*^9}, {3.729119849724024*^9, 
   3.7291198585722113`*^9}, {3.7291717881457*^9, 3.729171818317573*^9}, {
   3.729171854440769*^9, 3.729171871385407*^9}, {3.72917192869256*^9, 
   3.7291720371346607`*^9}, {3.729173126976542*^9, 3.729173139435835*^9}, {
   3.729173200255974*^9, 3.729173275110746*^9}, {3.7291733458987417`*^9, 
   3.729173346264063*^9}, {3.729173389656439*^9, 3.729173389676496*^9}, {
   3.729173453362727*^9, 3.729173453374463*^9}, {3.72917500863538*^9, 
   3.729175053102626*^9}, {3.729175506297736*^9, 3.72917551618956*^9}, {
   3.729175643623238*^9, 3.729175648090048*^9}, {3.729176146733549*^9, 
   3.729176146742311*^9}, {3.729178985302376*^9, 3.729179018757811*^9}, {
   3.729179428316293*^9, 3.729179429546385*^9}, {3.729183394535775*^9, 
   3.729183394547886*^9}, {3.729190274999607*^9, 3.72919028248487*^9}, {
   3.729195946539386*^9, 3.729195963662328*^9}, {3.729256050052142*^9, 
   3.729256067693101*^9}, {3.729551202293354*^9, 3.7295512309957952`*^9}, {
   3.7296339987183323`*^9, 3.7296340585670023`*^9}, {3.72963414997302*^9, 
   3.7296342843671503`*^9}, {3.729634402705227*^9, 3.729634445056549*^9}, {
   3.729640374024897*^9, 3.7296403796236258`*^9}, {3.729640414581646*^9, 
   3.729640440813695*^9}, {3.729682825170733*^9, 3.729682850158277*^9}, {
   3.729687964822157*^9, 3.729687976272668*^9}, {3.729688124350306*^9, 
   3.729688350523089*^9}, {3.729688433189711*^9, 3.729688519693812*^9}, {
   3.7296888315942287`*^9, 3.729688853951269*^9}, {3.729688885214087*^9, 
   3.729688980761574*^9}, {3.729689047339793*^9, 3.72968904899368*^9}, {
   3.729689085039751*^9, 3.729689088321394*^9}, {3.729689126691318*^9, 
   3.729689162680344*^9}, {3.729689199269363*^9, 3.729689319536848*^9}, {
   3.7296894525051317`*^9, 3.7296895044680653`*^9}, {3.7296895377540073`*^9, 
   3.729689925517149*^9}, {3.729698780575644*^9, 3.7296988032889967`*^9}, {
   3.72969891708257*^9, 3.729698973930211*^9}, {3.729699028638085*^9, 
   3.729699670715773*^9}, {3.729699704631276*^9, 3.7296997129720783`*^9}, {
   3.729706992747849*^9, 3.729707001634725*^9}, {3.7297070524424753`*^9, 
   3.729707066383106*^9}, {3.7297071244821672`*^9, 3.729707137919736*^9}, {
   3.729707203038928*^9, 3.72970729917104*^9}, {3.729707646971855*^9, 
   3.729707660202389*^9}, {3.7297079419830017`*^9, 3.72970797164758*^9}, {
   3.729708009957337*^9, 3.729708049867004*^9}, {3.729708084939846*^9, 
   3.7297080920715303`*^9}, {3.729708515163211*^9, 3.729708569024414*^9}, {
   3.729708613027947*^9, 3.729708623070286*^9}, {3.729708794113842*^9, 
   3.729708805535737*^9}, {3.729710516671919*^9, 3.7297105167550173`*^9}, {
   3.729784342249545*^9, 3.7297847167390738`*^9}, {3.729784762209856*^9, 
   3.7297847785042458`*^9}, {3.729784818040599*^9, 3.7297849058292437`*^9}, {
   3.729784947378476*^9, 3.7297849866650257`*^9}, {3.729790334304122*^9, 
   3.7297904006081543`*^9}, {3.7297904543011217`*^9, 3.729790469826312*^9}, {
   3.729790510736865*^9, 3.729790515646512*^9}, {3.729790569437749*^9, 
   3.729790630375985*^9}, {3.729790726049513*^9, 3.7297908347358427`*^9}, {
   3.729790886318983*^9, 3.7297908985495443`*^9}, {3.729790931251046*^9, 
   3.72979112317486*^9}, {3.72979116931327*^9, 3.729791269353731*^9}, {
   3.729791359892681*^9, 3.729791406067814*^9}, {3.7297914485241547`*^9, 
   3.72979144921026*^9}, {3.729791484698999*^9, 3.729791499044384*^9}, {
   3.729791566561154*^9, 3.729791584345121*^9}, {3.7297916430977707`*^9, 
   3.7297917327178802`*^9}, {3.729791770348117*^9, 3.729791837674281*^9}, {
   3.731757094772335*^9, 3.7317571111575108`*^9}, {3.731757155691042*^9, 
   3.731757172493279*^9}, {3.731757391120328*^9, 3.731757471765375*^9}, {
   3.731757511270165*^9, 3.7317575540659513`*^9}, {3.731757727065297*^9, 
   3.7317577508640203`*^9}, {3.731757792505725*^9, 3.7317578173543158`*^9}, {
   3.731757853306868*^9, 3.731757858260828*^9}, {3.7317579155173683`*^9, 
   3.731757969235733*^9}, {3.73175800261622*^9, 3.7317581849537067`*^9}},
 CellLabel->"In[82]:=",ExpressionUUID->"f523199a-8693-49fb-9687-72bb3bdaf9af"],

Cell[BoxData[
 DynamicModuleBox[{$CellContext`\[Alpha]\[Beta]Bishop$$ = True}, 
  TagBox[
   StyleBox[
    DynamicModuleBox[{$CellContext`log\[Sigma]\[Zeta]$$ = -1.5, \
$CellContext`log\[Sigma]\[Xi]$$ = 0.5, $CellContext`\[CapitalMu]$$ = 4, 
     Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
     Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
     1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{{
        Hold[$CellContext`\[CapitalMu]$$], 4, "order \[CapitalMu]"}, 0, 16, 
       1}, {{
        Hold[$CellContext`log\[Sigma]\[Xi]$$], 0.5, 
        "log \[Sigma]\[Xi] (KAL)"}, -3, 5}, {{
        Hold[$CellContext`log\[Sigma]\[Zeta]$$], -1.5, 
        "log \[Sigma]\[Zeta] (KAL)"}, -7, 3}, {
       Hold[
        Column[{
          SetterBar[
           Dynamic[$CellContext`\[Alpha]\[Beta]Bishop$$], {
           True -> "\[Alpha] = \!\(\*FractionBox[\(1\), SubsuperscriptBox[\(\
\[Sigma]\), \(\[Xi]\), \(2\)]]\), \[Beta] = \!\(\*FractionBox[\(1\), \
SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \(2\)]]\)", False -> 
            "\[Alpha] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \(\[Zeta]\), \
\(2\)]\), \[Beta] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \
\(2\)]\)"}], 
          Row[{
            Button[
            "RESET", ($CellContext`\[CapitalMu]$$ = 
              4; $CellContext`log\[Sigma]\[Xi]$$ = 
              0.5; $CellContext`log\[Sigma]\[Zeta]$$ = -1.5)& ]}, Frame -> 
           All], 
          Manipulate`Place[1], 
          Manipulate`Place[2], 
          Manipulate`Place[3]}]], Manipulate`Dump`ThisIsNotAControl}}, 
     Typeset`size$$ = {628., {188.2010498046875, 196.7989501953125}}, 
     Typeset`update$$ = 0, Typeset`initDone$$, Typeset`skipInitDone$$ = 
     True, $CellContext`\[CapitalMu]$6682$$ = 
     0, $CellContext`log\[Sigma]\[Xi]$6683$$ = 
     0, $CellContext`log\[Sigma]\[Zeta]$6684$$ = 0}, 
     DynamicBox[Manipulate`ManipulateBoxes[
      2, StandardForm, 
       "Variables" :> {$CellContext`log\[Sigma]\[Zeta]$$ = -1.5, \
$CellContext`log\[Sigma]\[Xi]$$ = 0.5, $CellContext`\[CapitalMu]$$ = 4}, 
       "ControllerVariables" :> {
         Hold[$CellContext`\[CapitalMu]$$, $CellContext`\[CapitalMu]$6682$$, 
          0], 
         Hold[$CellContext`log\[Sigma]\[Xi]$$, \
$CellContext`log\[Sigma]\[Xi]$6683$$, 0], 
         Hold[$CellContext`log\[Sigma]\[Zeta]$$, $CellContext`log\[Sigma]\
\[Zeta]$6684$$, 0]}, 
       "OtherVariables" :> {
        Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
         Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
         Typeset`specs$$, Typeset`size$$, Typeset`update$$, 
         Typeset`initDone$$, Typeset`skipInitDone$$}, "Body" :> 
       Module[{$CellContext`x$}, 
         With[{$CellContext`cs$ = Map[
             $CellContext`\[Phi][$CellContext`\[CapitalMu]$$], 
             Map[List, 
              Part[$CellContext`bts, 1]]], $CellContext`ts$ = 
           Part[$CellContext`bts, 2], $CellContext`\[Sigma]\[Zeta]2$ = 
           10.^(2 $CellContext`log\[Sigma]\[Zeta]$$), $CellContext`\[Sigma]\
\[Xi]2$ = 10.^(2 $CellContext`log\[Sigma]\[Xi]$$)}, 
          
          With[{$CellContext`kalman$ = $CellContext`kalFit[$CellContext`\
\[Sigma]\[Zeta]2$, $CellContext`\[Sigma]\[Xi]2$][$CellContext`\[CapitalMu]$$, \
$CellContext`bts], $CellContext`rrls$ = Quiet[
              $CellContext`rrlsFit[$CellContext`\[Sigma]\[Zeta]2$, \
$CellContext`\[Sigma]\[Xi]2$][$CellContext`\[CapitalMu]$$, \
$CellContext`bts]]}, 
           
           With[{$CellContext`\[Alpha]$ = 
             If[$CellContext`\[Alpha]\[Beta]Bishop$$, 
               1/$CellContext`\[Sigma]\[Xi]2$, \
$CellContext`\[Sigma]\[Zeta]2$], $CellContext`\[Beta]$ = 
             If[$CellContext`\[Alpha]\[Beta]Bishop$$, 
               1/$CellContext`\[Sigma]\[Zeta]2$, \
$CellContext`\[Sigma]\[Xi]2$]}, 
            Grid[{{"inverse\nKAL P", 
               MatrixForm[
                Inverse[
                 Part[$CellContext`kalman$, 2]]]}, {"rrls \[CapitalLambda]", 
               MatrixForm[
                Part[$CellContext`rrls$, 2]]}, {
              "Bishop \!\(\*SuperscriptBox[\(S\), \(-1\)]\)", 
               MatrixForm[
                $CellContext`sInv[$CellContext`\[Alpha]$, \
$CellContext`\[Beta]$, $CellContext`cs$, $CellContext`\[CapitalMu]$$]]}}]]]]],
        "Specifications" :> {{{$CellContext`\[CapitalMu]$$, 4, 
           "order \[CapitalMu]"}, 0, 16, 1, Appearance -> {"Labeled"}, 
          ControlPlacement -> 
          1}, {{$CellContext`log\[Sigma]\[Xi]$$, 0.5, 
           "log \[Sigma]\[Xi] (KAL)"}, -3, 5, Appearance -> "Labeled", 
          ControlPlacement -> 
          2}, {{$CellContext`log\[Sigma]\[Zeta]$$, -1.5, 
           "log \[Sigma]\[Zeta] (KAL)"}, -7, 3, Appearance -> "Labeled", 
          ControlPlacement -> 3}, 
         Column[{
           SetterBar[
            Dynamic[$CellContext`\[Alpha]\[Beta]Bishop$$], {
            True -> "\[Alpha] = \!\(\*FractionBox[\(1\), SubsuperscriptBox[\(\
\[Sigma]\), \(\[Xi]\), \(2\)]]\), \[Beta] = \!\(\*FractionBox[\(1\), \
SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \(2\)]]\)", False -> 
             "\[Alpha] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \(\[Zeta]\), \
\(2\)]\), \[Beta] = \!\(\*SubsuperscriptBox[\(\[Sigma]\), \(\[Xi]\), \
\(2\)]\)"}], 
           Row[{
             Button[
             "RESET", ($CellContext`\[CapitalMu]$$ = 
               4; $CellContext`log\[Sigma]\[Xi]$$ = 
               0.5; $CellContext`log\[Sigma]\[Zeta]$$ = -1.5)& ]}, Frame -> 
            All], 
           Manipulate`Place[1], 
           Manipulate`Place[2], 
           Manipulate`Place[3]}]}, "Options" :> {}, "DefaultOptions" :> {}],
      ImageSizeCache->{694., {336., 344.}},
      SingleEvaluation->True],
     Deinitialization:>None,
     DynamicModuleValues:>{},
     SynchronousInitialization->True,
     UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
     UnsavedVariables:>{Typeset`initDone$$},
     UntrackedVariables:>{Typeset`size$$}], "Manipulate",
    Deployed->True,
    StripOnInput->False],
   Manipulate`InterpretManipulate[1]],
  DynamicModuleValues:>{}]], "Output",
 CellChangeTimes->{
  3.731757082748592*^9, 3.731757114913705*^9, {3.7317571622150183`*^9, 
   3.7317572099894857`*^9}, 3.731757442002295*^9, 3.7317574732710733`*^9, 
   3.731757522227098*^9, {3.7317577366279383`*^9, 3.731757751327533*^9}, 
   3.731757818562789*^9, {3.7317579161233273`*^9, 3.731757938251275*^9}, 
   3.731757969575286*^9, 3.731758186434442*^9, 3.731803260307165*^9, 
   3.7318033541756697`*^9, 3.731837030212345*^9},
 CellLabel->"Out[82]=",ExpressionUUID->"23f6e226-fcd8-4ace-9d5a-61ef17b63e02"]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Covariance of the Prediction", "Subsection",
 CellChangeTimes->{{3.729182953019375*^9, 3.7291829585476*^9}, {
  3.731675216240808*^9, 
  3.731675217750049*^9}},ExpressionUUID->"0f5271c6-1a4d-43b6-add2-\
f90ac417363f"],

Cell[TextData[{
 "The following shows estimated coefficients with their error bars. To \
translate from covariance of the estimate to covariance of the prediction, \
note that the prediction is a linear combination of the estimates and \
\.7f\.7ffollow ",
 ButtonBox["https://goo.gl/tG3BM7",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://goo.gl/tG3BM7"], None},
  ButtonNote->"https://goo.gl/tG3BM7"],
 ", the covariance of the prediction at each input ",
 Cell[BoxData[
  FormBox["x", TraditionalForm]],ExpressionUUID->
  "c934449c-9d5e-4917-88d3-0f17a9b72256"],
 " is ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"a", "(", "x", ")"}], "\[CenterDot]", "P", "\[CenterDot]", 
    RowBox[{
     RowBox[{"a", "(", "x", ")"}], "\[Transpose]"}]}], TraditionalForm]],
  ExpressionUUID->"accc44e3-6828-41d2-b203-aaab5f9f3e86"],
 ". Bishop adds the fixed observation covariance ",
 Cell[BoxData[
  FormBox[
   SubsuperscriptBox["\[Sigma]", "\[Zeta]", "2"], TraditionalForm]],
  ExpressionUUID->"f5a389de-eaea-4f96-b904-1897f559491c"],
 " to the covariance of the prediction"
}], "Text",
 CellChangeTimes->{{3.731760524306388*^9, 3.731760587522809*^9}, {
  3.731760725517132*^9, 3.731760758228746*^9}, {3.731760794770914*^9, 
  3.731760795839443*^9}, {3.731760852209713*^9, 3.731760961444509*^9}, {
  3.731760994436451*^9, 3.731761017812114*^9}, {3.731761261503652*^9, 
  3.731761338474408*^9}, {3.731803276239264*^9, 
  3.731803284358035*^9}},ExpressionUUID->"88e0b2c9-5a0a-4814-9155-\
5e2b40ce58ec"],

Cell[BoxData[
 RowBox[{"<<", "ErrorBarPlots`"}]], "Input",
 CellChangeTimes->{{3.731715394303833*^9, 3.73171541878154*^9}},
 CellLabel->"In[83]:=",ExpressionUUID->"d46e1f83-0d62-4aa9-a485-77b63b6e0000"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", 
  RowBox[{
   RowBox[{"Module", "[", 
    RowBox[{
     RowBox[{"{", "x", "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"terms", "=", 
          RowBox[{"symbolicPowers", "[", 
           RowBox[{"x", ",", "\[CapitalMu]"}], "]"}]}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"\[Sigma]\[Zeta]2", "=", 
          SuperscriptBox["10.", 
           RowBox[{"2", "log\[Sigma]\[Zeta]"}]]}], ",", 
         RowBox[{"\[Sigma]\[Xi]2", "=", 
          SuperscriptBox["10.", 
           RowBox[{"2", "log\[Sigma]\[Xi]"}]]}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"k", "=", 
           RowBox[{
            RowBox[{"kalFit", "[", 
             RowBox[{"\[Sigma]\[Zeta]2", ",", "\[Sigma]\[Xi]2"}], "]"}], "[", 
            
            RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"With", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"\[Delta]\[Xi]", "=", 
              RowBox[{"Sqrt", "@", 
               RowBox[{"Diagonal", "[", 
                RowBox[{
                "k", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}], 
                "]"}]}]}], ",", "\[IndentingNewLine]", 
             RowBox[{"\[Xi]", "=", 
              RowBox[{"Flatten", "@", 
               RowBox[{
               "k", "\[LeftDoubleBracket]", "1", 
                "\[RightDoubleBracket]"}]}]}]}], "}"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"With", "[", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{"eds", "=", 
               RowBox[{
                RowBox[{"{", 
                 RowBox[{"\[Xi]", ",", "\[Delta]\[Xi]"}], "}"}], 
                "\[Transpose]"}]}], "}"}], ",", "\[IndentingNewLine]", 
             RowBox[{"Show", "[", 
              RowBox[{"{", 
               RowBox[{"ErrorListPlot", "[", 
                RowBox[{"eds", ",", 
                 RowBox[{"Joined", "\[Rule]", "True"}]}], "]"}], "}"}], 
              "]"}]}], "]"}]}], "]"}]}], "]"}]}], "]"}]}], "]"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"Column", "[", 
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"Row", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"Button", "[", 
          RowBox[{"\"\<RESET\>\"", ",", 
           RowBox[{
            RowBox[{"(", 
             RowBox[{
              RowBox[{"\[CapitalMu]", "=", "9"}], ";", 
              RowBox[{"log\[Sigma]\[Xi]", "=", ".5"}], ";", 
              RowBox[{"log\[Sigma]\[Zeta]", "=", 
               RowBox[{"-", "1.5"}]}]}], ")"}], "&"}]}], "]"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"Control", "[", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{
             "\[CapitalMu]", ",", "9", ",", "\"\<order \[CapitalMu]\>\""}], 
             "}"}], ",", "0", ",", "16", ",", "1", ",", 
            RowBox[{"Appearance", "\[Rule]", 
             RowBox[{"{", "\"\<Labeled\>\"", "}"}]}]}], "}"}], "]"}]}], "}"}],
        "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
          "log\[Sigma]\[Xi]", ",", ".5", ",", 
           "\"\<log \[Sigma]\[Xi] (KAL)\>\""}], "}"}], ",", 
         RowBox[{"-", "3"}], ",", " ", "5", ",", 
         RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], "]"}],
       ",", "\[IndentingNewLine]", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"log\[Sigma]\[Zeta]", ",", 
           RowBox[{"-", "1.5"}], ",", "\"\<log \[Sigma]\[Zeta] (KAL)\>\""}], 
          "}"}], ",", 
         RowBox[{"-", "7"}], ",", "3", ",", 
         RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
       "]"}]}], "}"}], "]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.727884681931381*^9, 3.7278848244947367`*^9}, 
   3.727884861217602*^9, {3.727884975910451*^9, 3.7278849940673532`*^9}, {
   3.727885103521431*^9, 3.727885154698123*^9}, {3.72788520225443*^9, 
   3.727885279820177*^9}, {3.727885496115718*^9, 3.727885517688189*^9}, {
   3.72788559395383*^9, 3.727885598972475*^9}, {3.7278856296542664`*^9, 
   3.727885630876935*^9}, {3.727885695972756*^9, 3.727885696864628*^9}, {
   3.727886633660364*^9, 3.72788671287046*^9}, {3.727886975364171*^9, 
   3.727886975439041*^9}, {3.727903476653379*^9, 3.7279034819231358`*^9}, {
   3.727903531862627*^9, 3.727903539245574*^9}, 3.727913149489944*^9, {
   3.727915429732944*^9, 3.7279154437948627`*^9}, {3.727915750998211*^9, 
   3.7279158447033873`*^9}, {3.7279213832695303`*^9, 3.72792149154887*^9}, {
   3.727921523149373*^9, 3.72792161270367*^9}, {3.72792165300301*^9, 
   3.727921654632832*^9}, {3.727921753282296*^9, 3.727921753360197*^9}, {
   3.727924008558401*^9, 3.727924045018003*^9}, {3.727924293814445*^9, 
   3.727924370827516*^9}, 3.727965590613636*^9, {3.7279686551525917`*^9, 
   3.727968670349081*^9}, {3.7279689406605043`*^9, 3.727969019631563*^9}, {
   3.727970883056108*^9, 3.727970945128386*^9}, {3.727971005813472*^9, 
   3.727971023734253*^9}, {3.727990640753121*^9, 3.727990674786282*^9}, {
   3.727990711779483*^9, 3.727990808626033*^9}, {3.727991307012423*^9, 
   3.727991307022031*^9}, {3.7279932412769613`*^9, 3.7279932949280367`*^9}, {
   3.7279933910397243`*^9, 3.727993398358789*^9}, {3.727993778490755*^9, 
   3.72799379332897*^9}, {3.727993826040863*^9, 3.7279938751552763`*^9}, {
   3.727993956673335*^9, 3.727993958184173*^9}, 3.727994128012043*^9, {
   3.7280354067714148`*^9, 3.7280354258611927`*^9}, {3.728035634299762*^9, 
   3.728035732029833*^9}, {3.72803585641748*^9, 3.728035906176405*^9}, {
   3.728038924314391*^9, 3.728039041653799*^9}, {3.728039077026232*^9, 
   3.72803913265169*^9}, {3.728039194847865*^9, 3.728039320044661*^9}, {
   3.728044256958378*^9, 3.728044343151896*^9}, {3.728044393583234*^9, 
   3.728044466540698*^9}, 3.7280447095836163`*^9, {3.728044856722988*^9, 
   3.728044959527645*^9}, {3.728044995179022*^9, 3.728044998104682*^9}, {
   3.728045028753289*^9, 3.728045063548128*^9}, {3.728045464570526*^9, 
   3.728045476328084*^9}, {3.728045812340419*^9, 3.728045836978776*^9}, {
   3.7280461335391397`*^9, 3.728046355530389*^9}, {3.728046392282709*^9, 
   3.728046397281275*^9}, {3.728046429888109*^9, 3.728046434285967*^9}, {
   3.728046509047914*^9, 3.728046577986915*^9}, {3.728048625582951*^9, 
   3.728048658147644*^9}, {3.728048704639155*^9, 3.7280487209829884`*^9}, {
   3.728048763333255*^9, 3.728048783520523*^9}, 3.728048849900649*^9, {
   3.728048881350296*^9, 3.7280488887365723`*^9}, {3.7280489358794527`*^9, 
   3.728048947834031*^9}, {3.7280492952517767`*^9, 3.728049427179392*^9}, {
   3.728049506853256*^9, 3.7280496162697783`*^9}, {3.728050015065921*^9, 
   3.7280500376507397`*^9}, {3.7280500733077374`*^9, 
   3.7280501005796213`*^9}, {3.728089881496944*^9, 3.728089882038129*^9}, {
   3.728090725835964*^9, 3.728090725845487*^9}, {3.728169349750301*^9, 
   3.728169349773612*^9}, {3.728169400997793*^9, 3.728169417906619*^9}, {
   3.728169511798567*^9, 3.728169523731205*^9}, {3.7281696125541363`*^9, 
   3.7281696306368437`*^9}, 3.728226727530678*^9, {3.728226810131266*^9, 
   3.728226816018466*^9}, {3.728226857072884*^9, 3.728226861119492*^9}, 
   3.728245946305786*^9, {3.7282487072286263`*^9, 3.728248709889584*^9}, {
   3.728251170478485*^9, 3.728251170709284*^9}, {3.7282526609079533`*^9, 
   3.728252718943617*^9}, 3.728252776351699*^9, {3.728252825506783*^9, 
   3.7282528275522842`*^9}, {3.7282528645183697`*^9, 3.728252865147182*^9}, 
   3.7282539826691*^9, {3.7291194284711437`*^9, 3.729119493281761*^9}, {
   3.7291195510227203`*^9, 3.729119680314639*^9}, {3.729119849724024*^9, 
   3.7291198585722113`*^9}, {3.7291717881457*^9, 3.729171818317573*^9}, {
   3.729171854440769*^9, 3.729171871385407*^9}, {3.72917192869256*^9, 
   3.7291720371346607`*^9}, {3.729173126976542*^9, 3.729173139435835*^9}, {
   3.729173200255974*^9, 3.729173275110746*^9}, {3.7291733458987417`*^9, 
   3.729173346264063*^9}, {3.729173389656439*^9, 3.729173389676496*^9}, {
   3.729173453362727*^9, 3.729173453374463*^9}, {3.72917500863538*^9, 
   3.729175053102626*^9}, {3.729175506297736*^9, 3.72917551618956*^9}, {
   3.729175643623238*^9, 3.729175648090048*^9}, {3.729176146733549*^9, 
   3.729176146742311*^9}, {3.729178985302376*^9, 3.729179018757811*^9}, {
   3.729179428316293*^9, 3.729179429546385*^9}, {3.729183394535775*^9, 
   3.729183394547886*^9}, {3.729190274999607*^9, 3.72919028248487*^9}, {
   3.729195946539386*^9, 3.729195963662328*^9}, {3.729256050052142*^9, 
   3.729256067693101*^9}, {3.729551202293354*^9, 3.7295512309957952`*^9}, {
   3.7296339987183323`*^9, 3.7296340585670023`*^9}, {3.72963414997302*^9, 
   3.7296342843671503`*^9}, {3.729634402705227*^9, 3.729634445056549*^9}, {
   3.729640374024897*^9, 3.7296403796236258`*^9}, {3.729640414581646*^9, 
   3.729640440813695*^9}, {3.729682825170733*^9, 3.729682850158277*^9}, {
   3.729687964822157*^9, 3.729687976272668*^9}, {3.729688124350306*^9, 
   3.729688350523089*^9}, {3.729688433189711*^9, 3.729688519693812*^9}, {
   3.7296888315942287`*^9, 3.729688853951269*^9}, {3.729688885214087*^9, 
   3.729688980761574*^9}, {3.729689047339793*^9, 3.72968904899368*^9}, {
   3.729689085039751*^9, 3.729689088321394*^9}, {3.729689126691318*^9, 
   3.729689162680344*^9}, {3.729689199269363*^9, 3.729689319536848*^9}, {
   3.7296894525051317`*^9, 3.7296895044680653`*^9}, {3.7296895377540073`*^9, 
   3.729689925517149*^9}, {3.729698780575644*^9, 3.7296988032889967`*^9}, {
   3.72969891708257*^9, 3.729698973930211*^9}, {3.729699028638085*^9, 
   3.729699670715773*^9}, {3.729699704631276*^9, 3.7296997129720783`*^9}, {
   3.729706992747849*^9, 3.729707001634725*^9}, {3.7297070524424753`*^9, 
   3.729707066383106*^9}, {3.7297071244821672`*^9, 3.729707137919736*^9}, {
   3.729707203038928*^9, 3.72970729917104*^9}, {3.729707646971855*^9, 
   3.729707660202389*^9}, {3.7297079419830017`*^9, 3.72970797164758*^9}, {
   3.729708009957337*^9, 3.729708049867004*^9}, {3.729708084939846*^9, 
   3.7297080920715303`*^9}, {3.729708515163211*^9, 3.729708569024414*^9}, {
   3.729708613027947*^9, 3.729708623070286*^9}, {3.729708794113842*^9, 
   3.729708805535737*^9}, {3.729710516671919*^9, 3.7297105167550173`*^9}, {
   3.729784342249545*^9, 3.7297847167390738`*^9}, {3.729784762209856*^9, 
   3.7297847785042458`*^9}, {3.729784818040599*^9, 3.7297849058292437`*^9}, {
   3.729784947378476*^9, 3.7297849866650257`*^9}, {3.729790334304122*^9, 
   3.7297904006081543`*^9}, {3.7297904543011217`*^9, 3.729790469826312*^9}, {
   3.729790510736865*^9, 3.729790515646512*^9}, {3.729790569437749*^9, 
   3.729790630375985*^9}, {3.729790726049513*^9, 3.7297908347358427`*^9}, {
   3.729790886318983*^9, 3.7297908985495443`*^9}, {3.729790931251046*^9, 
   3.72979112317486*^9}, {3.72979116931327*^9, 3.729791269353731*^9}, {
   3.729791359892681*^9, 3.729791406067814*^9}, {3.7297914485241547`*^9, 
   3.72979144921026*^9}, {3.729791484698999*^9, 3.729791499044384*^9}, {
   3.729791566561154*^9, 3.729791584345121*^9}, {3.7297916430977707`*^9, 
   3.7297917327178802`*^9}, {3.729791770348117*^9, 3.729791837674281*^9}, {
   3.731709971677794*^9, 3.7317101639463053`*^9}, {3.7317102037503433`*^9, 
   3.731710215700788*^9}, {3.731715141994503*^9, 3.7317152882227173`*^9}, {
   3.731715343440835*^9, 3.731715354998831*^9}, {3.7317154306617107`*^9, 
   3.731715485633067*^9}, {3.7317155236838818`*^9, 3.7317156018969603`*^9}, {
   3.7317156579314938`*^9, 3.731715666159513*^9}, {3.731715701442419*^9, 
   3.731715704994631*^9}, {3.731715830355187*^9, 3.731715830424828*^9}, {
   3.7317158743919773`*^9, 3.731715890285887*^9}, {3.731715921379428*^9, 
   3.731715928200734*^9}, {3.731761233372013*^9, 3.731761237105967*^9}},
 CellLabel->"In[84]:=",ExpressionUUID->"e38ec606-c377-4c8f-9073-9d7aa5f8da17"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`log\[Sigma]\[Zeta]$$ = -1.5, \
$CellContext`log\[Sigma]\[Xi]$$ = 0.5, $CellContext`\[CapitalMu]$$ = 9, 
    Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`\[CapitalMu]$$], 9, "order \[CapitalMu]"}, 0, 16, 
      1}, {{
       Hold[$CellContext`log\[Sigma]\[Xi]$$], 0.5, 
       "log \[Sigma]\[Xi] (KAL)"}, -3, 5}, {{
       Hold[$CellContext`log\[Sigma]\[Zeta]$$], -1.5, 
       "log \[Sigma]\[Zeta] (KAL)"}, -7, 3}, {
      Hold[
       Column[{
         Row[{
           Button[
           "RESET", ($CellContext`\[CapitalMu]$$ = 
             9; $CellContext`log\[Sigma]\[Xi]$$ = 
             0.5; $CellContext`log\[Sigma]\[Zeta]$$ = -1.5)& ], 
           Manipulate`Place[1]}], 
         Manipulate`Place[2], 
         Manipulate`Place[3]}]], Manipulate`Dump`ThisIsNotAControl}}, 
    Typeset`size$$ = {540., {157., 165.}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = 
    True, $CellContext`\[CapitalMu]$6741$$ = 
    0, $CellContext`log\[Sigma]\[Xi]$6742$$ = 
    0, $CellContext`log\[Sigma]\[Zeta]$6743$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     2, StandardForm, 
      "Variables" :> {$CellContext`log\[Sigma]\[Zeta]$$ = -1.5, \
$CellContext`log\[Sigma]\[Xi]$$ = 0.5, $CellContext`\[CapitalMu]$$ = 9}, 
      "ControllerVariables" :> {
        Hold[$CellContext`\[CapitalMu]$$, $CellContext`\[CapitalMu]$6741$$, 
         0], 
        Hold[$CellContext`log\[Sigma]\[Xi]$$, \
$CellContext`log\[Sigma]\[Xi]$6742$$, 0], 
        Hold[$CellContext`log\[Sigma]\[Zeta]$$, $CellContext`log\[Sigma]\
\[Zeta]$6743$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> Module[{$CellContext`x$}, 
        With[{$CellContext`terms$ = \
$CellContext`symbolicPowers[$CellContext`x$, $CellContext`\[CapitalMu]$$], \
$CellContext`\[Sigma]\[Zeta]2$ = 
          10.^(2 $CellContext`log\[Sigma]\[Zeta]$$), $CellContext`\[Sigma]\
\[Xi]2$ = 10.^(2 $CellContext`log\[Sigma]\[Xi]$$)}, 
         With[{$CellContext`k = $CellContext`kalFit[$CellContext`\[Sigma]\
\[Zeta]2$, $CellContext`\[Sigma]\[Xi]2$][$CellContext`\[CapitalMu]$$, \
$CellContext`bts]}, 
          With[{$CellContext`\[Delta]\[Xi] = Sqrt[
              Diagonal[
               Part[$CellContext`k, 2]]], $CellContext`\[Xi] = Flatten[
              Part[$CellContext`k, 1]]}, 
           
           With[{$CellContext`eds = 
             Transpose[{$CellContext`\[Xi], $CellContext`\[Delta]\[Xi]}]}, 
            Show[{
              
              ErrorBarPlots`ErrorListPlot[$CellContext`eds, Joined -> 
               True]}]]]]]], 
      "Specifications" :> {{{$CellContext`\[CapitalMu]$$, 9, 
          "order \[CapitalMu]"}, 0, 16, 1, Appearance -> {"Labeled"}, 
         ControlPlacement -> 
         1}, {{$CellContext`log\[Sigma]\[Xi]$$, 0.5, 
          "log \[Sigma]\[Xi] (KAL)"}, -3, 5, Appearance -> "Labeled", 
         ControlPlacement -> 
         2}, {{$CellContext`log\[Sigma]\[Zeta]$$, -1.5, 
          "log \[Sigma]\[Zeta] (KAL)"}, -7, 3, Appearance -> "Labeled", 
         ControlPlacement -> 3}, 
        Column[{
          Row[{
            Button[
            "RESET", ($CellContext`\[CapitalMu]$$ = 
              9; $CellContext`log\[Sigma]\[Xi]$$ = 
              0.5; $CellContext`log\[Sigma]\[Zeta]$$ = -1.5)& ], 
            Manipulate`Place[1]}], 
          Manipulate`Place[2], 
          Manipulate`Place[3]}]}, "Options" :> {}, "DefaultOptions" :> {}],
     ImageSizeCache->{606., {257., 266.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{
  3.731715185429943*^9, {3.731715226788912*^9, 3.7317152511557198`*^9}, 
   3.731715288961686*^9, 3.7317153559159613`*^9, 3.731715439776992*^9, 
   3.73171548902258*^9, 3.731715602565584*^9, 3.731715667015134*^9, 
   3.731715706175913*^9, 3.7317158312510443`*^9, 3.7317158913677063`*^9, 
   3.731715941891592*^9, 3.73176123920177*^9, 3.731803294278098*^9, 
   3.731803354289679*^9, 3.731837030337208*^9},
 CellLabel->"Out[84]=",ExpressionUUID->"f1e1e0a9-d154-49f5-be60-0f1895183d8b"]
}, Open  ]],

Cell[TextData[{
 "Consider Bishop' s equation 1.71 ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     SuperscriptBox["s", "2"], "(", "x", ")"}], "=", 
    RowBox[{
     SuperscriptBox["\[Beta]", 
      RowBox[{"\[ThinSpace]", 
       RowBox[{"-", "1"}]}]], "+", 
     RowBox[{
      RowBox[{
       RowBox[{"\[Phi]", "\[ThinSpace]", "(", "x", ")"}], "\[Transpose]"}], 
      "\[CenterDot]", "S", "\[CenterDot]", 
      RowBox[{"\[Phi]", "\[ThinSpace]", "(", "x", ")"}]}]}]}], 
   TraditionalForm]],ExpressionUUID->"6dfcd263-a97d-4bbd-8240-18fb850b2a01"],
 ", which does not depend on the output data ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["t", "n"], TraditionalForm]],ExpressionUUID->
  "2c5fff2e-1c1d-406e-901d-41521c38df61"],
 ", just as with KAL and RLS\.7f."
}], "Text",
 CellChangeTimes->{{3.727994165301249*^9, 3.7279941851829967`*^9}, {
  3.72808526244471*^9, 3.728085323623013*^9}, {3.728253500899654*^9, 
  3.728253506076968*^9}, {3.729175093713661*^9, 3.7291750988463297`*^9}, {
  3.729189840044029*^9, 3.7291898706889067`*^9}, {3.7291903288986673`*^9, 
  3.729190329452014*^9}, {3.7297115752429132`*^9, 
  3.729711651456718*^9}},ExpressionUUID->"86f22a65-52af-43d7-9c9e-\
9a478716cfd4"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "mapsSquared", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"mapsSquared", "[", 
    RowBox[{
    "\[Alpha]_", ",", "\[Beta]_", ",", "x_", ",", "cs_", ",", 
     "\[CapitalMu]_"}], "]"}], ":=", "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"a", "=", 
       RowBox[{
        RowBox[{"\[Phi]", "[", "\[CapitalMu]", "]"}], "[", "x", "]"}]}], 
      "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{
      SuperscriptBox["\[Beta]", 
       RowBox[{"-", "1"}]], "+", 
      RowBox[{
       RowBox[{"{", "a", "}"}], ".", 
       RowBox[{"LinearSolve", "[", 
        RowBox[{
         RowBox[{"sInv", "[", 
          RowBox[{
          "\[Alpha]", ",", "\[Beta]", ",", "cs", ",", "\[CapitalMu]"}], "]"}],
          ",", 
         RowBox[{"List", "/@", "a"}]}], "]"}]}]}]}], "]"}]}], ";"}]}], "Input",\

 CellChangeTimes->{{3.727994197366062*^9, 3.7279942096588373`*^9}, {
   3.727994247046831*^9, 3.7279942495547533`*^9}, {3.7279943024871273`*^9, 
   3.7279946538407373`*^9}, {3.7280359193758917`*^9, 3.728035920837536*^9}, 
   3.729175085479534*^9, 3.7291756488901587`*^9, {3.729175930984292*^9, 
   3.7291759413745337`*^9}, {3.72918296865281*^9, 3.72918296932966*^9}, {
   3.729195696029108*^9, 3.729195744219352*^9}},
 CellLabel->"In[85]:=",ExpressionUUID->"eb275326-2c0a-4c89-a365-8e286549f53e"],

Cell[TextData[{
 "Bishop kindly supplies the sigma-bars for his mean. He cites ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Alpha]", "=", "0.005"}], TraditionalForm]],ExpressionUUID->
  "716c6835-a0ca-4e21-a1e5-f1fabb29a20e"],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Beta]", "=", "11.1"}], TraditionalForm]],ExpressionUUID->
  "34eda4a5-047a-4ac4-89f4-ad3002dd4e23"],
 ", which correspond to ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubscriptBox["\[Sigma]", "\[Zeta]"], "=", 
    FormBox["0.07071",
     TraditionalForm]}], TraditionalForm]],ExpressionUUID->
  "84d7f102-4b43-4dff-aa17-d8119992c171"],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubscriptBox["\[Sigma]", "\[Xi]"], "=", 
    FormBox["3.333",
     TraditionalForm]}], TraditionalForm]],ExpressionUUID->
  "0925b158-a2eb-4d33-8d5d-20d2fb6b998c"],
 ", and ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     SubscriptBox["log", "10"], 
     SubscriptBox["\[Sigma]", "\[Zeta]"]}], "=", 
    FormBox[
     RowBox[{"-", "1.1505149978319906`"}],
     TraditionalForm]}], TraditionalForm]],ExpressionUUID->
  "89a82430-c61c-45d2-8428-421f2038513e"],
 " and ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     SubscriptBox["log", "10"], 
     SubscriptBox["\[Sigma]", "\[Xi]"]}], "=", 
    FormBox["0.5229",
     TraditionalForm]}], TraditionalForm]],ExpressionUUID->
  "6c4ddb46-0404-4254-a14b-31d303fbb18d"],
 ". These values reproduce Bishop\[CloseCurlyQuote]s figure 1.17 well. Bishop\
\[CloseCurlyQuote]s equation 1.71 equals ",
 Cell[BoxData[
  FormBox[
   RowBox[{
    SubsuperscriptBox["\[Sigma]", "\[Zeta]", "2"], "+", 
    RowBox[{
     RowBox[{
      SubscriptBox["a", "row"], "(", "x", ")"}], "\[CenterDot]", "P", 
     "\[CenterDot]", 
     RowBox[{
      RowBox[{
       SubscriptBox["a", "row"], "(", "x", ")"}], "\[Transpose]"}]}]}], 
   TraditionalForm]],
  FormatType->"TraditionalForm",ExpressionUUID->
  "d0f36f30-fec5-47ce-94ed-3c93a731bd84"],
 "."
}], "Text",
 CellChangeTimes->{{3.728047983582913*^9, 3.728048001419952*^9}, {
   3.728048031472519*^9, 3.728048102784032*^9}, 3.728048334620097*^9, {
   3.728048573076227*^9, 3.7280485742423983`*^9}, {3.7291832860169077`*^9, 
   3.729183286905438*^9}, {3.7291909187303047`*^9, 3.729190931736122*^9}, {
   3.729190966915935*^9, 3.72919115612007*^9}, {3.7291913182402887`*^9, 
   3.729191334853733*^9}, {3.729194967822537*^9, 3.7291949964757357`*^9}, {
   3.729195092532947*^9, 3.729195228731798*^9}, {3.7291952960364323`*^9, 
   3.729195346443692*^9}, {3.729195461293686*^9, 3.729195465395809*^9}, {
   3.729195529898984*^9, 3.7291955825492153`*^9}, 3.729196046713995*^9, {
   3.729196202829361*^9, 3.729196223138455*^9}, {3.7291963897537813`*^9, 
   3.7291963938344088`*^9}, {3.729711666635454*^9, 3.729711717573139*^9}, {
   3.731760451442841*^9, 3.731760509363139*^9}, {3.731760809871917*^9, 
   3.731760824256186*^9}, {3.7317614414418364`*^9, 
   3.731761462647687*^9}},ExpressionUUID->"b6b03868-5043-45c1-b57b-\
2154f2462fdc"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", 
  RowBox[{
   RowBox[{"Module", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"x", ",", "\[CapitalSigma]2Fn"}], "}"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"terms", "=", 
          RowBox[{"symbolicPowers", "[", 
           RowBox[{"x", ",", "\[CapitalMu]"}], "]"}]}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"cs", "=", 
          RowBox[{
           RowBox[{"\[Phi]", "[", "\[CapitalMu]", "]"}], "/@", 
           RowBox[{"List", "/@", 
            RowBox[{
            "bts", "\[LeftDoubleBracket]", "1", 
             "\[RightDoubleBracket]"}]}]}]}], ",", 
         RowBox[{"ts", "=", 
          RowBox[{
          "bts", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}]}], 
         ",", 
         RowBox[{"\[Sigma]2\[Xi]", "=", 
          SuperscriptBox["10", 
           RowBox[{"2", "log\[Sigma]\[Xi]"}]]}], ",", 
         RowBox[{"\[Sigma]2\[Zeta]", "=", 
          SuperscriptBox["10", 
           RowBox[{"2", "log\[Sigma]\[Zeta]"}]]}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"With", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"kalman", "=", 
           RowBox[{
            RowBox[{"kalFit", "[", 
             RowBox[{"\[Sigma]2\[Zeta]", ",", "\[Sigma]2\[Xi]"}], "]"}], "[", 
            
            RowBox[{"\[CapitalMu]", ",", "bts"}], "]"}]}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"With", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"kalFn", "=", 
              RowBox[{
               RowBox[{"{", "terms", "}"}], ".", 
               RowBox[{
               "kalman", "\[LeftDoubleBracket]", "1", 
                "\[RightDoubleBracket]"}]}]}], ",", "\[IndentingNewLine]", 
             RowBox[{"bs2", "=", 
              RowBox[{"mapsSquared", "[", 
               RowBox[{
                FractionBox["1", "\[Sigma]2\[Xi]"], ",", 
                FractionBox["1", "\[Sigma]2\[Zeta]"], ",", "x", ",", "cs", 
                ",", "\[CapitalMu]"}], "]"}]}], ",", "\[IndentingNewLine]", 
             RowBox[{"mapFn", "=", 
              RowBox[{"Quiet", "@", 
               RowBox[{"mapMean", "[", 
                RowBox[{
                "\[Sigma]2\[Zeta]", ",", "\[Sigma]2\[Xi]", ",", "x", ",", 
                 "cs", ",", "ts", ",", "\[CapitalMu]"}], "]"}]}]}]}], "}"}], 
           ",", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"\[CapitalSigma]2Fn", "=", 
             RowBox[{"\[Sigma]2\[Zeta]", "+", 
              RowBox[{
               RowBox[{"(", 
                RowBox[{
                 RowBox[{"{", "terms", "}"}], ".", 
                 RowBox[{
                 "kalman", "\[LeftDoubleBracket]", "2", 
                  "\[RightDoubleBracket]"}], ".", 
                 RowBox[{
                  RowBox[{"{", "terms", "}"}], "\[Transpose]"}]}], ")"}], 
               "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}]}]}], 
            ";", "\[IndentingNewLine]", 
            RowBox[{"With", "[", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"lp", "=", 
                RowBox[{"ListPlot", "[", 
                 RowBox[{
                  RowBox[{"bts", "\[Transpose]"}], ",", 
                  RowBox[{"PlotMarkers", "\[Rule]", 
                   RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Graphics", "@", 
                    RowBox[{"{", 
                    RowBox[{"Blue", ",", 
                    RowBox[{"Circle", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"0", ",", "0"}], "}"}], ",", "1"}], "]"}]}], 
                    "}"}]}], ",", ".05"}], "}"}]}]}], "]"}]}], "}"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"Module", "[", 
               RowBox[{
                RowBox[{"{", 
                 RowBox[{"showlist", "=", 
                  RowBox[{"{", 
                   RowBox[{"lp", ",", "\[IndentingNewLine]", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    RowBox[{"Sin", "[", 
                    RowBox[{"2.", "\[Pi]", " ", "x"}], "]"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0.", ",", "1."}], "}"}], ",", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"Thick", ",", "Green"}], "}"}]}]}], "]"}]}], 
                   "}"}]}], "}"}], ",", "\[IndentingNewLine]", 
                RowBox[{
                 RowBox[{"If", "[", 
                  RowBox[{"kalQ", ",", 
                   RowBox[{"AppendTo", "[", 
                    RowBox[{"showlist", ",", "\[IndentingNewLine]", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"kalFn", ",", 
                    RowBox[{"kalFn", "+", 
                    SqrtBox["\[CapitalSigma]2Fn"]}], ",", 
                    RowBox[{"kalFn", "-", 
                    SqrtBox["\[CapitalSigma]2Fn"]}]}], "}"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"Cyan", ",", 
                    RowBox[{"{", 
                    RowBox[{"Thin", ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Opacity", "[", "0", "]"}], ",", "Cyan"}], 
                    "}"}]}], "}"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"Thin", ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Opacity", "[", "0", "]"}], ",", "Cyan"}], 
                    "}"}]}], "}"}]}], "}"}]}], ",", 
                    RowBox[{"Filling", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"1", "\[Rule]", 
                    RowBox[{"{", "2", "}"}]}], ",", 
                    RowBox[{"1", "\[Rule]", 
                    RowBox[{"{", "3", "}"}]}]}], "}"}]}]}], "]"}]}], "]"}]}], 
                  "]"}], ";", "\[IndentingNewLine]", 
                 RowBox[{"If", "[", 
                  RowBox[{"mapQ", ",", 
                   RowBox[{"AppendTo", "[", 
                    RowBox[{"showlist", ",", "\[IndentingNewLine]", 
                    RowBox[{"Plot", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"mapFn", ",", 
                    RowBox[{"mapFn", "+", 
                    SqrtBox["bs2"]}], ",", 
                    RowBox[{"mapFn", "-", 
                    SqrtBox["bs2"]}]}], "}"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"x", ",", "0", ",", "1"}], "}"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"PlotStyle", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"Magenta", ",", 
                    RowBox[{"{", 
                    RowBox[{"Thin", ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Opacity", "[", "0", "]"}], ",", "Magenta"}], 
                    "}"}]}], "}"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"Thin", ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Opacity", "[", "0", "]"}], ",", "Magenta"}], 
                    "}"}]}], "}"}]}], "}"}]}], ",", "\[IndentingNewLine]", 
                    RowBox[{"Filling", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"1", "\[Rule]", 
                    RowBox[{"{", "2", "}"}]}], ",", 
                    RowBox[{"1", "\[Rule]", 
                    RowBox[{"{", "3", "}"}]}]}], "}"}]}]}], "]"}]}], "]"}]}], 
                  "]"}], ";", "\[IndentingNewLine]", 
                 RowBox[{"Quiet", "@", 
                  RowBox[{"Show", "[", 
                   RowBox[{"showlist", ",", 
                    RowBox[{"Frame", "\[Rule]", "True"}], ",", 
                    RowBox[{"FrameLabel", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"\"\<x\>\"", ",", "\"\<t\>\""}], "}"}]}]}], 
                   "]"}]}]}]}], "]"}]}], "]"}]}]}], "]"}]}], "]"}]}], "]"}]}],
     "]"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Grid", "[", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"Grid", "[", 
        RowBox[{"{", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"Button", "[", 
            RowBox[{"\"\<RESET\>\"", ",", 
             RowBox[{
              RowBox[{"(", 
               RowBox[{
                RowBox[{"\[CapitalMu]", "=", "9"}], ";", 
                RowBox[{"log\[Sigma]\[Xi]", "=", 
                 RowBox[{"Log10", "[", 
                  SqrtBox[
                   RowBox[{"1", "/", "0.09"}]], "]"}]}], ";", 
                RowBox[{"log\[Sigma]\[Zeta]", "=", 
                 RowBox[{"Log10", "[", 
                  SqrtBox["0.005"], "]"}]}]}], ")"}], "&"}]}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Control", "[", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"kalQ", ",", "True", ",", "\"\<KAL\>\""}], "}"}], ",", 
              
              RowBox[{"{", 
               RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"Control", "[", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"mapQ", ",", "True", ",", "\"\<MAP\>\""}], "}"}], ",", 
              
              RowBox[{"{", 
               RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}]}], "}"}],
          "}"}], "]"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
           "\[CapitalMu]", ",", "9", ",", "\"\<order \[CapitalMu]\>\""}], 
           "}"}], ",", "0", ",", "16", ",", "1", ",", 
          RowBox[{"Appearance", "\[Rule]", 
           RowBox[{"{", "\"\<Labeled\>\"", "}"}]}]}], "}"}], "]"}], "}"}], 
      ",", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"log\[Sigma]\[Xi]", ",", 
            RowBox[{"Log10", "[", 
             SqrtBox[
              RowBox[{"1", "/", "0.09"}]], "]"}], ",", 
            "\"\<log \[Sigma]\[Xi] (KAL)\>\""}], "}"}], ",", 
          RowBox[{"-", "3"}], ",", " ", "5", ",", 
          RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
        "]"}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"log\[Sigma]\[Zeta]", ",", 
            RowBox[{"Log10", "[", 
             SqrtBox["0.005"], "]"}], ",", 
            "\"\<log \[Sigma]\[Zeta] (KAL)\>\""}], "}"}], ",", 
          RowBox[{"-", "5"}], ",", "3", ",", 
          RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
        "]"}], "}"}]}], "}"}], "]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.727884681931381*^9, 3.7278848244947367`*^9}, 
   3.727884861217602*^9, {3.727884975910451*^9, 3.7278849940673532`*^9}, {
   3.727885103521431*^9, 3.727885154698123*^9}, {3.72788520225443*^9, 
   3.727885279820177*^9}, {3.727885496115718*^9, 3.727885517688189*^9}, {
   3.72788559395383*^9, 3.727885598972475*^9}, {3.7278856296542664`*^9, 
   3.727885630876935*^9}, {3.727885695972756*^9, 3.727885696864628*^9}, {
   3.727886633660364*^9, 3.72788671287046*^9}, {3.727886975364171*^9, 
   3.727886975439041*^9}, {3.727903476653379*^9, 3.7279034819231358`*^9}, {
   3.727903531862627*^9, 3.727903539245574*^9}, 3.727913149489944*^9, {
   3.727915429732944*^9, 3.7279154437948627`*^9}, {3.727915750998211*^9, 
   3.7279158447033873`*^9}, {3.7279213832695303`*^9, 3.72792149154887*^9}, {
   3.727921523149373*^9, 3.72792161270367*^9}, {3.72792165300301*^9, 
   3.727921654632832*^9}, {3.727921753282296*^9, 3.727921753360197*^9}, {
   3.727924008558401*^9, 3.727924045018003*^9}, {3.727924293814445*^9, 
   3.727924370827516*^9}, 3.727965590613636*^9, {3.7279686551525917`*^9, 
   3.727968670349081*^9}, {3.7279689406605043`*^9, 3.727969019631563*^9}, {
   3.727970883056108*^9, 3.727970945128386*^9}, {3.727971005813472*^9, 
   3.727971023734253*^9}, {3.727990640753121*^9, 3.727990674786282*^9}, {
   3.727990711779483*^9, 3.727990808626033*^9}, {3.727991307012423*^9, 
   3.727991307022031*^9}, {3.7279932412769613`*^9, 3.7279932949280367`*^9}, {
   3.7279933910397243`*^9, 3.727993398358789*^9}, {3.727993778490755*^9, 
   3.72799379332897*^9}, {3.727993826040863*^9, 3.7279938751552763`*^9}, {
   3.727993956673335*^9, 3.727993958184173*^9}, 3.727994128012043*^9, {
   3.7280354067714148`*^9, 3.7280354258611927`*^9}, {3.728035634299762*^9, 
   3.728035732029833*^9}, {3.72803585641748*^9, 3.728035906176405*^9}, {
   3.728038924314391*^9, 3.728039041653799*^9}, {3.728039077026232*^9, 
   3.72803913265169*^9}, {3.728039194847865*^9, 3.728039320044661*^9}, {
   3.728044256958378*^9, 3.728044343151896*^9}, {3.728044393583234*^9, 
   3.728044466540698*^9}, 3.7280447095836163`*^9, {3.728044856722988*^9, 
   3.728044959527645*^9}, {3.728044995179022*^9, 3.728044998104682*^9}, {
   3.728045028753289*^9, 3.728045063548128*^9}, {3.728045464570526*^9, 
   3.728045476328084*^9}, {3.728045812340419*^9, 3.728045836978776*^9}, {
   3.7280461335391397`*^9, 3.728046355530389*^9}, {3.728046392282709*^9, 
   3.728046397281275*^9}, {3.728046429888109*^9, 3.728046434285967*^9}, {
   3.728046509047914*^9, 3.728046577986915*^9}, {3.728048625582951*^9, 
   3.728048658147644*^9}, {3.728048704639155*^9, 3.7280487209829884`*^9}, {
   3.728048763333255*^9, 3.728048783520523*^9}, 3.728048849900649*^9, {
   3.728048881350296*^9, 3.7280488887365723`*^9}, {3.7280489358794527`*^9, 
   3.728048947834031*^9}, {3.7280492952517767`*^9, 3.728049427179392*^9}, {
   3.728049506853256*^9, 3.7280496162697783`*^9}, {3.728050015065921*^9, 
   3.7280500376507397`*^9}, {3.7280500733077374`*^9, 
   3.7280501005796213`*^9}, {3.728089881496944*^9, 3.728089882038129*^9}, {
   3.728090725835964*^9, 3.728090725845487*^9}, {3.728169349750301*^9, 
   3.728169349773612*^9}, {3.728169400997793*^9, 3.728169417906619*^9}, {
   3.728169511798567*^9, 3.728169523731205*^9}, {3.7281696125541363`*^9, 
   3.7281696306368437`*^9}, 3.728226727530678*^9, {3.728226810131266*^9, 
   3.728226816018466*^9}, {3.728226857072884*^9, 3.728226861119492*^9}, 
   3.728245946305786*^9, {3.7282487072286263`*^9, 3.728248709889584*^9}, {
   3.728251170478485*^9, 3.728251170709284*^9}, {3.7282526609079533`*^9, 
   3.728252718943617*^9}, 3.728252776351699*^9, {3.728252825506783*^9, 
   3.7282528275522842`*^9}, {3.7282528645183697`*^9, 3.728252865147182*^9}, 
   3.7282539826691*^9, {3.7291194284711437`*^9, 3.729119493281761*^9}, {
   3.7291195510227203`*^9, 3.729119680314639*^9}, {3.729119849724024*^9, 
   3.7291198585722113`*^9}, {3.7291717881457*^9, 3.729171818317573*^9}, {
   3.729171854440769*^9, 3.729171871385407*^9}, {3.72917192869256*^9, 
   3.7291720371346607`*^9}, {3.729173126976542*^9, 3.729173139435835*^9}, {
   3.729173200255974*^9, 3.729173275110746*^9}, {3.7291733458987417`*^9, 
   3.729173346264063*^9}, {3.729173389656439*^9, 3.729173389676496*^9}, {
   3.729173453362727*^9, 3.729173453374463*^9}, {3.72917500863538*^9, 
   3.729175053102626*^9}, {3.729175506297736*^9, 3.72917551618956*^9}, {
   3.729175643623238*^9, 3.729175648090048*^9}, {3.729176146733549*^9, 
   3.729176146742311*^9}, {3.729178985302376*^9, 3.729179018757811*^9}, {
   3.729179428316293*^9, 3.729179429546385*^9}, {3.7291833107508097`*^9, 
   3.729183351716688*^9}, {3.729183394435251*^9, 3.729183394441711*^9}, {
   3.729190091733934*^9, 3.729190094653805*^9}, {3.7291901727265663`*^9, 
   3.729190190738206*^9}, 3.7291903189647007`*^9, {3.729190363535774*^9, 
   3.729190420438587*^9}, {3.729190855161989*^9, 3.7291908759621487`*^9}, {
   3.729191173998303*^9, 3.729191310565546*^9}, {3.729191815211359*^9, 
   3.729191966406259*^9}, {3.729192009289757*^9, 3.729192012183796*^9}, 
   3.729192076913485*^9, {3.7291921189255133`*^9, 3.72919222651994*^9}, {
   3.7291934084762163`*^9, 3.7291934717245827`*^9}, {3.729193512347974*^9, 
   3.729193699962986*^9}, {3.7291937883162937`*^9, 3.72919391294538*^9}, {
   3.729193943825762*^9, 3.7291939503531523`*^9}, {3.729194005235033*^9, 
   3.729194075561458*^9}, 3.729195508767318*^9, {3.729196245290443*^9, 
   3.7291962556403313`*^9}, {3.729196364803418*^9, 3.7291963689564*^9}, {
   3.729196403932249*^9, 3.729196414116873*^9}, 3.729551253178636*^9, {
   3.731707944355975*^9, 3.7317079582354*^9}, {3.731708119193424*^9, 
   3.7317083331665287`*^9}, {3.731708368930249*^9, 3.7317084052656307`*^9}, {
   3.731708453514224*^9, 3.731708458143113*^9}, {3.7317162072863693`*^9, 
   3.731716227328266*^9}, {3.7317162612736483`*^9, 3.7317163177914133`*^9}, {
   3.7317164519149218`*^9, 3.7317164821709347`*^9}, {3.731716518605393*^9, 
   3.7317165205696907`*^9}, {3.731716750323658*^9, 3.731716767667555*^9}, {
   3.731716801978195*^9, 3.731716802080037*^9}, {3.73171685224058*^9, 
   3.731716884225387*^9}, {3.731716946344927*^9, 3.7317169819604893`*^9}, {
   3.731717161414843*^9, 3.731717231711906*^9}, {3.731717310352366*^9, 
   3.731717315762765*^9}, 3.7317173631157207`*^9, {3.731717446630186*^9, 
   3.731717489079268*^9}, 3.7317175209139957`*^9, {3.731749741128438*^9, 
   3.7317498228966303`*^9}, {3.731749860248348*^9, 3.731749868791813*^9}, {
   3.731749945743106*^9, 3.731749961974657*^9}, {3.731750024045692*^9, 
   3.7317500297105513`*^9}, {3.731750120441139*^9, 3.731750195509553*^9}, {
   3.7317502422047663`*^9, 3.731750294213427*^9}, {3.731750331503096*^9, 
   3.731750390752705*^9}, {3.731750425420389*^9, 3.7317504330175123`*^9}, 
   3.7317504853269577`*^9, {3.731750539019405*^9, 3.731750596025795*^9}, {
   3.73175083667457*^9, 3.731750838448154*^9}, {3.731750886429639*^9, 
   3.73175089135631*^9}, {3.731760221154327*^9, 3.731760258513726*^9}, {
   3.731760337438588*^9, 3.7317603817844267`*^9}},
 CellLabel->"In[87]:=",ExpressionUUID->"c1abac75-c82f-4b71-8d8e-2ff33722210e"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`kalQ$$ = 
    True, $CellContext`log\[Sigma]\[Zeta]$$ = -1.1505149978319906`, \
$CellContext`log\[Sigma]\[Xi]$$ = 0.5228787452803376, $CellContext`mapQ$$ = 
    True, $CellContext`\[CapitalMu]$$ = 9, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`kalQ$$], True, "KAL"}, {True, False}}, {{
       Hold[$CellContext`mapQ$$], True, "MAP"}, {True, False}}, {{
       Hold[$CellContext`\[CapitalMu]$$], 9, "order \[CapitalMu]"}, 0, 16, 
      1}, {{
       Hold[$CellContext`log\[Sigma]\[Xi]$$], 0.5228787452803376, 
       "log \[Sigma]\[Xi] (KAL)"}, -3, 5}, {{
       Hold[$CellContext`log\[Sigma]\[Zeta]$$], -1.1505149978319906`, 
       "log \[Sigma]\[Zeta] (KAL)"}, -5, 3}, {
      Hold[
       Grid[{{
          Grid[{{
             Button[
             "RESET", ($CellContext`\[CapitalMu]$$ = 
               9; $CellContext`log\[Sigma]\[Xi]$$ = Log10[
                 Sqrt[1/0.09]]; $CellContext`log\[Sigma]\[Zeta]$$ = Log10[
                 Sqrt[0.005]])& ], 
             Manipulate`Place[1], 
             Manipulate`Place[2]}}]}, {
          Manipulate`Place[3]}, {
          Manipulate`Place[4]}, {
          Manipulate`Place[5]}}]], Manipulate`Dump`ThisIsNotAControl}}, 
    Typeset`size$$ = {540., {168., 175.}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = 
    True, $CellContext`kalQ$6834$$ = False, $CellContext`mapQ$6835$$ = 
    False, $CellContext`\[CapitalMu]$6836$$ = 
    0, $CellContext`log\[Sigma]\[Xi]$6837$$ = 
    0, $CellContext`log\[Sigma]\[Zeta]$6838$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     2, StandardForm, 
      "Variables" :> {$CellContext`kalQ$$ = 
        True, $CellContext`log\[Sigma]\[Zeta]$$ = -1.1505149978319906`, \
$CellContext`log\[Sigma]\[Xi]$$ = 0.5228787452803376, $CellContext`mapQ$$ = 
        True, $CellContext`\[CapitalMu]$$ = 9}, "ControllerVariables" :> {
        Hold[$CellContext`kalQ$$, $CellContext`kalQ$6834$$, False], 
        Hold[$CellContext`mapQ$$, $CellContext`mapQ$6835$$, False], 
        Hold[$CellContext`\[CapitalMu]$$, $CellContext`\[CapitalMu]$6836$$, 
         0], 
        Hold[$CellContext`log\[Sigma]\[Xi]$$, \
$CellContext`log\[Sigma]\[Xi]$6837$$, 0], 
        Hold[$CellContext`log\[Sigma]\[Zeta]$$, $CellContext`log\[Sigma]\
\[Zeta]$6838$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Module[{$CellContext`x$, $CellContext`\[CapitalSigma]2Fn$}, 
        With[{$CellContext`terms$ = \
$CellContext`symbolicPowers[$CellContext`x$, $CellContext`\[CapitalMu]$$], \
$CellContext`cs$ = Map[
            $CellContext`\[Phi][$CellContext`\[CapitalMu]$$], 
            Map[List, 
             Part[$CellContext`bts, 1]]], $CellContext`ts$ = 
          Part[$CellContext`bts, 2], $CellContext`\[Sigma]2\[Xi]$ = 
          10^(2 $CellContext`log\[Sigma]\[Xi]$$), $CellContext`\[Sigma]2\
\[Zeta]$ = 10^(2 $CellContext`log\[Sigma]\[Zeta]$$)}, 
         With[{$CellContext`kalman$ = $CellContext`kalFit[$CellContext`\
\[Sigma]2\[Zeta]$, $CellContext`\[Sigma]2\[Xi]$][$CellContext`\[CapitalMu]$$, \
$CellContext`bts]}, 
          With[{$CellContext`kalFn$ = Dot[{$CellContext`terms$}, 
              
              Part[$CellContext`kalman$, 
               1]], $CellContext`bs2$ = $CellContext`mapsSquared[
             1/$CellContext`\[Sigma]2\[Xi]$, 
              1/$CellContext`\[Sigma]2\[Zeta]$, $CellContext`x$, \
$CellContext`cs$, $CellContext`\[CapitalMu]$$], $CellContext`mapFn$ = Quiet[
              $CellContext`mapMean[$CellContext`\[Sigma]2\[Zeta]$, \
$CellContext`\[Sigma]2\[Xi]$, $CellContext`x$, $CellContext`cs$, \
$CellContext`ts$, $CellContext`\[CapitalMu]$$]]}, \
$CellContext`\[CapitalSigma]2Fn$ = $CellContext`\[Sigma]2\[Zeta]$ + Part[
               Dot[{$CellContext`terms$}, 
                Part[$CellContext`kalman$, 2], 
                Transpose[{$CellContext`terms$}]], 1]; 
           With[{$CellContext`lp$ = ListPlot[
                Transpose[$CellContext`bts], PlotMarkers -> {
                  Graphics[{Blue, 
                    Circle[{0, 0}, 1]}], 0.05}]}, 
             Module[{$CellContext`showlist$ = {$CellContext`lp$, 
                 Plot[
                  Sin[2. Pi $CellContext`x$], {$CellContext`x$, 0., 1.}, 
                  PlotStyle -> {Thick, Green}]}}, If[$CellContext`kalQ$$, 
                AppendTo[$CellContext`showlist$, 
                 
                 Plot[{$CellContext`kalFn$, $CellContext`kalFn$ + 
                   Sqrt[$CellContext`\[CapitalSigma]2Fn$], \
$CellContext`kalFn$ - 
                   Sqrt[$CellContext`\[CapitalSigma]2Fn$]}, {$CellContext`x$, 
                   0, 1}, PlotStyle -> {Cyan, {Thin, {
                    Opacity[0], Cyan}}, {Thin, {
                    Opacity[0], Cyan}}}, Filling -> {1 -> {2}, 1 -> {3}}]]]; 
              If[$CellContext`mapQ$$, 
                AppendTo[$CellContext`showlist$, 
                 
                 Plot[{$CellContext`mapFn$, $CellContext`mapFn$ + 
                   Sqrt[$CellContext`bs2$], $CellContext`mapFn$ - 
                   Sqrt[$CellContext`bs2$]}, {$CellContext`x$, 0, 1}, 
                  PlotStyle -> {Magenta, {Thin, {
                    Opacity[0], Magenta}}, {Thin, {
                    Opacity[0], Magenta}}}, 
                  Filling -> {1 -> {2}, 1 -> {3}}]]]; Quiet[
                
                Show[$CellContext`showlist$, Frame -> True, 
                 FrameLabel -> {"x", "t"}]]]]]]]], 
      "Specifications" :> {{{$CellContext`kalQ$$, True, "KAL"}, {True, False},
          ControlPlacement -> 1}, {{$CellContext`mapQ$$, True, "MAP"}, {
         True, False}, ControlPlacement -> 
         2}, {{$CellContext`\[CapitalMu]$$, 9, "order \[CapitalMu]"}, 0, 16, 
         1, Appearance -> {"Labeled"}, ControlPlacement -> 
         3}, {{$CellContext`log\[Sigma]\[Xi]$$, 0.5228787452803376, 
          "log \[Sigma]\[Xi] (KAL)"}, -3, 5, Appearance -> "Labeled", 
         ControlPlacement -> 
         4}, {{$CellContext`log\[Sigma]\[Zeta]$$, -1.1505149978319906`, 
          "log \[Sigma]\[Zeta] (KAL)"}, -5, 3, Appearance -> "Labeled", 
         ControlPlacement -> 5}, 
        Grid[{{
           Grid[{{
              Button[
              "RESET", ($CellContext`\[CapitalMu]$$ = 
                9; $CellContext`log\[Sigma]\[Xi]$$ = Log10[
                  Sqrt[1/0.09]]; $CellContext`log\[Sigma]\[Zeta]$$ = Log10[
                  Sqrt[0.005]])& ], 
              Manipulate`Place[1], 
              Manipulate`Place[2]}}]}, {
           Manipulate`Place[3]}, {
           Manipulate`Place[4]}, {
           Manipulate`Place[5]}}]}, "Options" :> {}, "DefaultOptions" :> {}],
     ImageSizeCache->{606., {284., 292.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{
  3.7317162352437153`*^9, 3.7317163310028553`*^9, 3.731716483230978*^9, 
   3.7317165217201557`*^9, 3.731716769778563*^9, 3.73171680301869*^9, 
   3.7317168576680737`*^9, {3.7317169554865093`*^9, 3.731716983112734*^9}, 
   3.73171723287193*^9, 3.7317173168148823`*^9, 3.73171736931497*^9, 
   3.7317174601562157`*^9, 3.7317174933333693`*^9, 3.731717524519074*^9, 
   3.73174980074445*^9, {3.731749913704867*^9, 3.731749947604061*^9}, 
   3.7317500310874643`*^9, {3.7317500758135643`*^9, 3.7317500922794037`*^9}, {
   3.731750143240687*^9, 3.731750196094768*^9}, 3.7317504017741823`*^9, {
   3.731750434115745*^9, 3.7317504455457983`*^9}, 3.7317508402317247`*^9, 
   3.731760184330817*^9, {3.731760262313336*^9, 3.7317603010799437`*^9}, 
   3.73176034495264*^9, {3.731760384400159*^9, 3.731760409654035*^9}, {
   3.731803316887396*^9, 3.7318033544195232`*^9}, 3.7318370304948673`*^9},
 CellLabel->"Out[87]=",ExpressionUUID->"379bab10-22e3-4332-96f6-1fa8f34b19bb"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Pad\[EAcute] Approximant: Example from NIST", "Chapter",
 CellChangeTimes->{{3.731525643609439*^9, 3.7315256500484133`*^9}, {
  3.731578282117167*^9, 3.731578293191307*^9}, {3.73157903523098*^9, 
  3.731579039558917*^9}},ExpressionUUID->"5af8943a-1d98-47e8-b4ff-\
da1344057eab"],

Cell[TextData[{
 "A Pad\[EAcute] approximant is a ratio of two polynomials, where the bias \
term in the denominator is unity to discourage division by zero. Quoting from \
Srini Kumar and Bob Horton ",
 ButtonBox["https://goo.gl/BXEHs1",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://goo.gl/BXEHs1"], None},
  ButtonNote->"https://goo.gl/BXEHs1"],
 ":"
}], "Text",
 CellChangeTimes->{{3.7315789988809967`*^9, 3.731579000415886*^9}, {
  3.731579043520563*^9, 3.73157910142607*^9}, {3.731579468507571*^9, 
  3.731579512323703*^9}, {3.731579579131967*^9, 
  3.731579597428026*^9}},ExpressionUUID->"abe0b5d5-726c-4254-9d16-\
98a13687b90f"],

Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{
    StyleBox["R", "TI"], "(", 
    StyleBox["x", "TI"], ")"}], "\[LongEqual]", 
   FractionBox[
    RowBox[{
     UnderoverscriptBox["\[Sum]", 
      RowBox[{
       StyleBox["j", "TI"], "=", "0"}], 
      StyleBox["m", "TI"],
      LimitsPositioning->True], 
     RowBox[{
      SubscriptBox[
       StyleBox["a", "TI"], 
       StyleBox["j", "TI"]], 
      SuperscriptBox[
       StyleBox["x", "TI"], 
       StyleBox["j", "TI"]]}]}], 
    RowBox[{"1", "+", 
     RowBox[{
      UnderoverscriptBox["\[Sum]", 
       RowBox[{
        StyleBox["k", "TI"], "=", "1"}], 
       StyleBox["n", "TI"],
       LimitsPositioning->True], 
      RowBox[{
       SubscriptBox[
        StyleBox["b", "TI"], 
        StyleBox["k", "TI"]], 
       SuperscriptBox[
        StyleBox["x", "TI"], 
        StyleBox["k", "TI"]]}]}]}]], "\[LongEqual]", 
   FractionBox[
    RowBox[{
     SubscriptBox[
      StyleBox["a", "TI"], "0"], "+", 
     RowBox[{
      SubscriptBox[
       StyleBox["a", "TI"], "1"], 
      StyleBox["x", "TI"]}], "+", 
     RowBox[{
      SubscriptBox[
       StyleBox["a", "TI"], "2"], 
      SuperscriptBox[
       StyleBox["x", "TI"], "2"]}], "+", "\[CenterEllipsis]", "+", 
     RowBox[{
      SubscriptBox[
       StyleBox["a", "TI"], 
       StyleBox["m", "TI"]], 
      SuperscriptBox[
       StyleBox["x", "TI"], 
       StyleBox["m", "TI"]]}]}], 
    RowBox[{"1", "+", 
     RowBox[{
      SubscriptBox[
       StyleBox["b", "TI"], "1"], 
      StyleBox["x", "TI"]}], "+", 
     RowBox[{
      SubscriptBox[
       StyleBox["b", "TI"], "2"], 
      SuperscriptBox[
       StyleBox["x", "TI"], "2"]}], "+", "\[CenterEllipsis]", "+", 
     RowBox[{
      SubscriptBox[
       StyleBox["b", "TI"], 
       StyleBox["n", "TI"]], 
      SuperscriptBox[
       StyleBox["x", "TI"], 
       StyleBox["n", "TI"]]}]}]]}], 
  TraditionalForm]], "DisplayFormulaNumbered",
 CellChangeTimes->{{3.731579433266018*^9, 
  3.731579449165316*^9}},ExpressionUUID->"8e4f2c5a-7da8-499f-a742-\
402cba9cce8a"],

Cell[TextData[{
 "The following example from NIST (",
 ButtonBox["https://goo.gl/nybGP9",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["https://goo.gl/nybGP9"], None},
  ButtonNote->"https://goo.gl/nybGP9"],
 ", edited to remove some blank lines) allows us to illustrate:"
}], "Text",
 CellChangeTimes->{{3.731579557291642*^9, 3.731579564067965*^9}, {
  3.7315796404870567`*^9, 
  3.731579677937595*^9}},ExpressionUUID->"a1c1052e-aa50-47f7-968e-\
ca0e07eccaf7"],

Cell["\<\
NIST/ITL StRD
Dataset Name:  Thurber           (Thurber.dat)

File Format:   ASCII
               Starting Values   (lines 41 to 47)
               Certified Values  (lines 41 to 52)
               Data              (lines 61 to 97)

Procedure:     Nonlinear Least Squares Regression

Description:   These data are the result of a NIST study involving
               semiconductor electron mobility.  The response 
               variable is a measure of electron mobility, and the 
               predictor variable is the natural log of the density.

Reference:     Thurber, R., NIST (197?).  
               Semiconductor electron mobility modeling.

Data:          1 Response Variable  (y = electron mobility)
               1 Predictor Variable (x = log[density])
               37 Observations
               Higher Level of Difficulty
               Observed Data

Model:         Rational Class (cubic/cubic)
               7 Parameters (b1 to b7)

               y = (b1 + b2*x + b3*x**2 + b4*x**3) / 
                   (1 + b5*x + b6*x**2 + b7*x**3)  +  e

          Starting Values                  Certified Values

        Start 1     Start 2           Parameter     Standard Deviation
  b1 =   1000        1300          1.2881396800E+03  4.6647963344E+00
  b2 =   1000        1500          1.4910792535E+03  3.9571156086E+01
  b3 =    400         500          5.8323836877E+02  2.8698696102E+01
  b4 =     40          75          7.5416644291E+01  5.5675370270E+00
  b5 =      0.7         1          9.6629502864E-01  3.1333340687E-02
  b6 =      0.3         0.4        3.9797285797E-01  1.4984928198E-02
  b7 =      0.03        0.05       4.9727297349E-02  6.5842344623E-03

Residual Sum of Squares:                    5.6427082397E+03
Residual Standard Deviation:                1.3714600784E+01
Degrees of Freedom:                                30
Number of Observations:                            37

Data:   y             x
      80.574E0      -3.067E0
      84.248E0      -2.981E0
      87.264E0      -2.921E0
      87.195E0      -2.912E0
      89.076E0      -2.840E0
      89.608E0      -2.797E0
      89.868E0      -2.702E0
      90.101E0      -2.699E0
      92.405E0      -2.633E0
      95.854E0      -2.481E0
     100.696E0      -2.363E0
     101.060E0      -2.322E0
     401.672E0      -1.501E0
     390.724E0      -1.460E0
     567.534E0      -1.274E0
     635.316E0      -1.212E0
     733.054E0      -1.100E0
     759.087E0      -1.046E0
     894.206E0      -0.915E0
     990.785E0      -0.714E0
    1090.109E0      -0.566E0
    1080.914E0      -0.545E0
    1122.643E0      -0.400E0
    1178.351E0      -0.309E0
    1260.531E0      -0.109E0
    1273.514E0      -0.103E0
    1288.339E0       0.010E0
    1327.543E0       0.119E0
    1353.863E0       0.377E0
    1414.509E0       0.790E0
    1425.208E0       0.963E0
    1421.384E0       1.006E0
    1442.962E0       1.115E0
    1464.350E0       1.572E0
    1468.705E0       1.841E0
    1447.894E0       2.047E0
    1457.628E0       2.200E0\
\>", "Text",
 CellChangeTimes->{
  3.7315258060738163`*^9, {3.731530299793519*^9, 3.731530312577435*^9}},
 FontFamily->"Courier",ExpressionUUID->"4cfa08b7-0988-4c0c-ba5f-0c0346e0ba24"],

Cell[TextData[{
 "Identifiers ending in a dollar sign denote ad-hoc convenience variables, \
that is, global variables that we set to anything anywhere, accepting the \
risk of arbitrary overwriting. With other variables, we are more careful to \
encapsulate them in ",
 StyleBox["Modules", "Code"],
 ", ",
 StyleBox["With", "Code"],
 ", or ",
 StyleBox["Block", "Code"],
 " forms, or to ",
 StyleBox["ClearAll", "Code"],
 " them before defining values and patterns."
}], "Text",
 CellChangeTimes->{{3.7315796986294317`*^9, 
  3.731579822045335*^9}},ExpressionUUID->"1076e4c9-7c82-4536-8edd-\
64eb364990cf"],

Cell[BoxData[
 RowBox[{
  RowBox[{
  "nistData$", "=", "\[IndentingNewLine]", 
   "\"\<    80.574E0      -3.067E0\n      84.248E0      -2.981E0\n      \
87.264E0      -2.921E0\n      87.195E0      -2.912E0\n      89.076E0      \
-2.840E0\n      89.608E0      -2.797E0\n      89.868E0      -2.702E0\n      \
90.101E0      -2.699E0\n      92.405E0      -2.633E0\n      95.854E0      \
-2.481E0\n     100.696E0      -2.363E0\n     101.060E0      -2.322E0\n     \
401.672E0      -1.501E0\n     390.724E0      -1.460E0\n     567.534E0      \
-1.274E0\n     635.316E0      -1.212E0\n     733.054E0      -1.100E0\n     \
759.087E0      -1.046E0\n     894.206E0      -0.915E0\n     990.785E0      \
-0.714E0\n    1090.109E0      -0.566E0\n    1080.914E0      -0.545E0\n    \
1122.643E0      -0.400E0\n    1178.351E0      -0.309E0\n    1260.531E0      \
-0.109E0\n    1273.514E0      -0.103E0\n    1288.339E0       0.010E0\n    \
1327.543E0       0.119E0\n    1353.863E0       0.377E0\n    1414.509E0       \
0.790E0\n    1425.208E0       0.963E0\n    1421.384E0       1.006E0\n    \
1442.962E0       1.115E0\n    1464.350E0       1.572E0\n    1468.705E0       \
1.841E0\n    1447.894E0       2.047E0\n    1457.628E0       2.200E0\>\""}], 
  ";"}]], "Input",
 CellChangeTimes->{{3.731525946674505*^9, 3.731526013943205*^9}, {
  3.731526129469571*^9, 3.731526140418027*^9}},
 CellLabel->"In[88]:=",ExpressionUUID->"169b56db-b515-4771-b03f-e2a9f1e04df3"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"nistTrainingSet$", "=", 
    RowBox[{"Transpose", "[", "\[IndentingNewLine]", 
     RowBox[{"nistDataPoints$", "=", 
      RowBox[{"Reverse", "/@", 
       RowBox[{"ReadList", "[", "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{"StringToStream", "[", "nistData$", "]"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"{", 
          RowBox[{"Number", ",", "Number"}], "}"}]}], "]"}]}]}], "]"}]}], 
   ")"}], "//", "MatrixForm"}]], "Input",
 CellChangeTimes->{{3.731526143681961*^9, 3.731526147175933*^9}, {
  3.7315262361519623`*^9, 3.7315262465198*^9}, {3.731526282616621*^9, 
  3.731526404428029*^9}, {3.731526470013728*^9, 3.731526499243676*^9}, {
  3.7315278489544353`*^9, 3.731527888612979*^9}, {3.731530330988184*^9, 
  3.7315303515143623`*^9}, {3.73153098683005*^9, 3.731530995337134*^9}, {
  3.731532514458892*^9, 3.731532517000317*^9}, {3.731578309784212*^9, 
  3.731578319075132*^9}},
 CellLabel->"In[89]:=",ExpressionUUID->"e149a6d5-9ef6-4090-aeae-80012f977d84"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {
      RowBox[{"-", "3.067`"}], 
      RowBox[{"-", "2.981`"}], 
      RowBox[{"-", "2.921`"}], 
      RowBox[{"-", "2.912`"}], 
      RowBox[{"-", "2.84`"}], 
      RowBox[{"-", "2.797`"}], 
      RowBox[{"-", "2.702`"}], 
      RowBox[{"-", "2.699`"}], 
      RowBox[{"-", "2.633`"}], 
      RowBox[{"-", "2.481`"}], 
      RowBox[{"-", "2.363`"}], 
      RowBox[{"-", "2.322`"}], 
      RowBox[{"-", "1.501`"}], 
      RowBox[{"-", "1.46`"}], 
      RowBox[{"-", "1.274`"}], 
      RowBox[{"-", "1.212`"}], 
      RowBox[{"-", "1.1`"}], 
      RowBox[{"-", "1.046`"}], 
      RowBox[{"-", "0.915`"}], 
      RowBox[{"-", "0.714`"}], 
      RowBox[{"-", "0.566`"}], 
      RowBox[{"-", "0.545`"}], 
      RowBox[{"-", "0.4`"}], 
      RowBox[{"-", "0.309`"}], 
      RowBox[{"-", "0.109`"}], 
      RowBox[{"-", "0.103`"}], "0.01`", "0.119`", "0.377`", "0.79`", "0.963`",
       "1.006`", "1.115`", "1.572`", "1.841`", "2.047`", "2.2`"},
     {"80.574`", "84.248`", "87.264`", "87.195`", "89.076`", "89.608`", 
      "89.868`", "90.101`", "92.405`", "95.854`", "100.696`", "101.06`", 
      "401.672`", "390.724`", "567.534`", "635.316`", "733.054`", "759.087`", 
      "894.206`", "990.785`", "1090.109`", "1080.914`", "1122.643`", 
      "1178.351`", "1260.531`", "1273.514`", "1288.339`", "1327.543`", 
      "1353.863`", "1414.509`", "1425.208`", "1421.384`", "1442.962`", 
      "1464.35`", "1468.705`", "1447.894`", "1457.628`"}
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
 CellChangeTimes->{3.731530352208815*^9, 3.7315310001906767`*^9, 
  3.731532517813445*^9, 3.7315783196342278`*^9, 3.731582995774282*^9, 
  3.731670260518455*^9, 3.731671803427608*^9, 3.731671840279418*^9, 
  3.7318033546653223`*^9, 3.731837030754533*^9},
 CellLabel->
  "Out[89]//MatrixForm=",ExpressionUUID->"2dcf377e-829e-4126-a1d6-\
5cb846a46f85"]
}, Open  ]],

Cell["\<\
Using the notation of the NIST example, rather than that of Kumar and Horton:\
\
\>", "Text",
 CellChangeTimes->{{3.7315798626063223`*^9, 
  3.7315798844533453`*^9}},ExpressionUUID->"667c3c2c-592e-422c-baea-\
3c034932719c"],

Cell[BoxData[
 RowBox[{"ClearAll", "[", 
  RowBox[{"x", ",", "y"}], "]"}]], "Input",
 CellChangeTimes->{{3.731528378173296*^9, 3.731528381019408*^9}, {
  3.7315285009035378`*^9, 3.731528501317789*^9}},
 CellLabel->"In[90]:=",ExpressionUUID->"2ce77940-b330-44d6-8d55-bc774893aee3"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"nistModelPre$", "=", 
  RowBox[{
   RowBox[{"ReadList", "[", 
    RowBox[{"StringToStream", "[", 
     RowBox[{"StringReplace", "[", 
      RowBox[{
      "\"\<y = (b1 + b2*x + b3*x**2 + b4*x**3) / \n                   (1 + \
b5*x + b6*x**2 + b7*x**3)\>\"", ",", 
       RowBox[{"\"\<**\>\"", "\[Rule]", "\"\<^\>\""}]}], "]"}], "]"}], "]"}], 
   "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}]}]], "Input",
 CellChangeTimes->{{3.731527926090287*^9, 3.731527954619615*^9}, {
  3.731528013722282*^9, 3.7315280352430563`*^9}, {3.731528088620686*^9, 
  3.7315281035523987`*^9}, {3.731528142577414*^9, 3.73152819025456*^9}, {
  3.731528374133614*^9, 3.731528393650753*^9}, {3.731528491170555*^9, 
  3.731528495845935*^9}, {3.731528702063856*^9, 3.731528702330567*^9}},
 CellLabel->"In[91]:=",ExpressionUUID->"6cbedc95-cf6d-4775-ad6e-7db918530cdb"],

Cell[BoxData[
 FractionBox[
  RowBox[{"b1", "+", 
   RowBox[{"b2", " ", "x"}], "+", 
   RowBox[{"b3", " ", 
    SuperscriptBox["x", "2"]}], "+", 
   RowBox[{"b4", " ", 
    SuperscriptBox["x", "3"]}]}], 
  RowBox[{"1", "+", 
   RowBox[{"b5", " ", "x"}], "+", 
   RowBox[{"b6", " ", 
    SuperscriptBox["x", "2"]}], "+", 
   RowBox[{"b7", " ", 
    SuperscriptBox["x", "3"]}]}]]], "Output",
 CellChangeTimes->{
  3.7315281541641006`*^9, 3.731528190997254*^9, {3.7315283829783688`*^9, 
   3.731528394419691*^9}, 3.7315284969684467`*^9, 3.731528719655821*^9, {
   3.731532523078319*^9, 3.731532540018152*^9}, 3.731582995890554*^9, 
   3.731670260580196*^9, 3.731671803476194*^9, 3.731671840330942*^9, 
   3.731803354710734*^9, 3.7318370308412447`*^9},
 CellLabel->"Out[91]=",ExpressionUUID->"a6e540d9-7636-4e9f-adcc-e234ac96fe22"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"nistDenominator$", "=", 
  RowBox[{"nistModelPre$", "\[LeftDoubleBracket]", 
   RowBox[{"2", ",", "1"}], "\[RightDoubleBracket]"}]}]], "Input",
 CellChangeTimes->{{3.731528270449655*^9, 3.73152834106684*^9}, 
   3.731528708742735*^9},
 CellLabel->"In[92]:=",ExpressionUUID->"cf5889c3-2420-4917-9118-7e67b1006b44"],

Cell[BoxData[
 RowBox[{"1", "+", 
  RowBox[{"b5", " ", "x"}], "+", 
  RowBox[{"b6", " ", 
   SuperscriptBox["x", "2"]}], "+", 
  RowBox[{"b7", " ", 
   SuperscriptBox["x", "3"]}]}]], "Output",
 CellChangeTimes->{{3.731528276879298*^9, 3.731528341464398*^9}, 
   3.731528396356797*^9, 3.731528498608878*^9, 3.731528719755743*^9, {
   3.731532525018331*^9, 3.731532547175681*^9}, 3.731582995973846*^9, 
   3.731670260602799*^9, 3.7316718035044203`*^9, 3.7316718403608093`*^9, 
   3.731803354760371*^9, 3.731837030895073*^9},
 CellLabel->"Out[92]=",ExpressionUUID->"b20e743a-0ca1-4211-bb5e-d9ea44b7dcef"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"nistNumerator$", "=", 
  RowBox[{"nistModelPre$", "*", 
   RowBox[{"nistModelPre$", "\[LeftDoubleBracket]", 
    RowBox[{"2", ",", "1"}], "\[RightDoubleBracket]"}]}]}]], "Input",
 CellChangeTimes->{{3.731528239313684*^9, 3.7315282627206173`*^9}, {
   3.731528320397196*^9, 3.7315283683144484`*^9}, 3.731528711198641*^9, {
   3.731532565232473*^9, 3.731532565630568*^9}},
 CellLabel->"In[93]:=",ExpressionUUID->"b69312e1-2f62-4d00-ad40-5968ae777c40"],

Cell[BoxData[
 RowBox[{"b1", "+", 
  RowBox[{"b2", " ", "x"}], "+", 
  RowBox[{"b3", " ", 
   SuperscriptBox["x", "2"]}], "+", 
  RowBox[{"b4", " ", 
   SuperscriptBox["x", "3"]}]}]], "Output",
 CellChangeTimes->{{3.7315282400432777`*^9, 3.731528264766774*^9}, 
   3.7315283212220163`*^9, {3.731528353593068*^9, 3.731528397544222*^9}, 
   3.7315287198710318`*^9, 3.731532526556217*^9, 3.731532566634986*^9, 
   3.731582996058372*^9, 3.731670260642017*^9, 3.731671803543371*^9, 
   3.731671840397615*^9, 3.73180335480971*^9, 3.731837030942404*^9},
 CellLabel->"Out[93]=",ExpressionUUID->"90857ecd-997f-4c67-bc6b-df38b712d05f"]
}, Open  ]],

Cell[BoxData[
 RowBox[{"ClearAll", "[", 
  RowBox[{"e", ",", "y"}], "]"}]], "Input",
 CellChangeTimes->{{3.731528544288904*^9, 3.731528574060845*^9}},
 CellLabel->"In[94]:=",ExpressionUUID->"0e67108f-6a82-4885-ae10-9fe12d7844b9"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"nistModel$", "=", 
  RowBox[{"nistNumerator$", "-", 
   RowBox[{"nistDenominator$", "*", "y"}]}]}]], "Input",
 CellChangeTimes->{{3.7315285125814667`*^9, 3.731528534542844*^9}, {
  3.731528734891511*^9, 3.731528738985442*^9}},
 CellLabel->"In[95]:=",ExpressionUUID->"ee944917-9e77-48c0-af5c-9b5b5d57192d"],

Cell[BoxData[
 RowBox[{"b1", "+", 
  RowBox[{"b2", " ", "x"}], "+", 
  RowBox[{"b3", " ", 
   SuperscriptBox["x", "2"]}], "+", 
  RowBox[{"b4", " ", 
   SuperscriptBox["x", "3"]}], "-", 
  RowBox[{
   RowBox[{"(", 
    RowBox[{"1", "+", 
     RowBox[{"b5", " ", "x"}], "+", 
     RowBox[{"b6", " ", 
      SuperscriptBox["x", "2"]}], "+", 
     RowBox[{"b7", " ", 
      SuperscriptBox["x", "3"]}]}], ")"}], " ", "y"}]}]], "Output",
 CellChangeTimes->{{3.731528535349306*^9, 3.731528549340774*^9}, {
   3.731528720019812*^9, 3.731528739391429*^9}, 3.731532530468458*^9, 
   3.731532569912554*^9, 3.731578389117178*^9, 3.731582996158894*^9, 
   3.731670260685609*^9, 3.7316718035844793`*^9, 3.731671840476095*^9, 
   3.731803354860573*^9, 3.731837031041716*^9},
 CellLabel->"Out[95]=",ExpressionUUID->"2d4b7162-21ee-49fb-b9d0-df276a185d0f"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"A$", "[", 
   RowBox[{"{", 
    RowBox[{"x_", ",", "y_"}], "}"}], "]"}], "=", 
  RowBox[{"(", GridBox[{
     {"1", "x", 
      SuperscriptBox["x", "2"], 
      SuperscriptBox["x", "3"], 
      RowBox[{
       RowBox[{"-", "x"}], " ", "y"}], 
      RowBox[{
       RowBox[{"-", 
        SuperscriptBox["x", "2"]}], "y"}], 
      RowBox[{
       RowBox[{"-", 
        SuperscriptBox["x", "3"]}], "y"}]}
    }], ")"}]}]], "Input",
 CellChangeTimes->{{3.731528820243787*^9, 3.731528914702125*^9}, {
  3.731528966541246*^9, 3.731528974157235*^9}, {3.731529005925462*^9, 
  3.731529057795312*^9}, {3.7315783754302*^9, 3.73157838177831*^9}},
 CellLabel->"In[96]:=",ExpressionUUID->"b29623ea-ed8e-4483-9efc-f8502196c9ac"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"{", 
   RowBox[{"1", ",", "x", ",", 
    SuperscriptBox["x", "2"], ",", 
    SuperscriptBox["x", "3"], ",", 
    RowBox[{
     RowBox[{"-", "x"}], " ", "y"}], ",", 
    RowBox[{
     RowBox[{"-", 
      SuperscriptBox["x", "2"]}], " ", "y"}], ",", 
    RowBox[{
     RowBox[{"-", 
      SuperscriptBox["x", "3"]}], " ", "y"}]}], "}"}], "}"}]], "Output",
 CellChangeTimes->{3.73152905916818*^9, 3.7315325726381273`*^9, 
  3.731578390688274*^9, 3.7315829962417603`*^9, 3.731670260726347*^9, 
  3.731671803627302*^9, 3.731671840515133*^9, 3.731803354909808*^9, 
  3.731837031092113*^9},
 CellLabel->"Out[96]=",ExpressionUUID->"2cfb4f65-5482-4b45-b30e-2bfba555b8cd"]
}, Open  ]],

Cell[BoxData[
 RowBox[{"ClearAll", "[", 
  RowBox[{
  "\[Xi]", ",", "\[Xi]01", ",", "\[Xi]02", ",", "\[CapitalLambda]01", ",", 
   "\[CapitalLambda]02", ",", "P01", ",", "P02", ",", "certified\[Xi]", ",", 
   "certifiedSqrtP"}], "]"}]], "Input",
 CellChangeTimes->{{3.731529372734186*^9, 3.7315294050856943`*^9}, {
   3.7315307690989103`*^9, 3.731530772473665*^9}, {3.7315310346364183`*^9, 
   3.731531048879114*^9}, {3.7315311779200077`*^9, 3.731531190805094*^9}, {
   3.731531521941373*^9, 3.73153153068974*^9}, 3.731579909218305*^9},
 CellLabel->"In[97]:=",ExpressionUUID->"dd573627-4eb1-4feb-a213-700e3593b95f"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"nistAPrioris$", "=", 
  RowBox[{
   RowBox[{"ReadList", "[", 
    RowBox[{
     RowBox[{
     "StringToStream", "[", 
      "\"\<1000        1300          1.2881396800E+03  4.6647963344E+00\n1000 \
       1500          1.4910792535E+03  3.9571156086E+01\n400         500      \
    5.8323836877E+02  2.8698696102E+01\n40          75          \
7.5416644291E+01  5.5675370270E+00\n0.7         1          9.6629502864E-01  \
3.1333340687E-02\n0.3         0.4        3.9797285797E-01  1.4984928198E-02\n\
0.03        0.05       4.9727297349E-02  6.5842344623E-03\>\"", "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"Number", ",", "Number", ",", "Number", ",", "Number"}], 
      "}"}]}], "]"}], "\[Transpose]"}]}]], "Input",
 CellChangeTimes->{{3.731529464567831*^9, 3.73152960143254*^9}},
 CellLabel->"In[98]:=",ExpressionUUID->"97a58270-440a-416a-9abb-630a8d969805"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
    "1000", ",", "1000", ",", "400", ",", "40", ",", "0.7`", ",", "0.3`", ",",
      "0.03`"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
    "1300", ",", "1500", ",", "500", ",", "75", ",", "1", ",", "0.4`", ",", 
     "0.05`"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
    "1288.13968`", ",", "1491.0792535`", ",", "583.23836877`", ",", 
     "75.416644291`", ",", "0.96629502864`", ",", "0.39797285797`", ",", 
     "0.049727297349`"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
    "4.6647963344`", ",", "39.571156086`", ",", "28.698696102`", ",", 
     "5.567537027`", ",", "0.031333340687`", ",", "0.014984928198`", ",", 
     "0.0065842344623`"}], "}"}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.73152947883757*^9, 3.731529531079343*^9, {3.7315295622128897`*^9, 
   3.731529601977798*^9}, 3.7315312036121798`*^9, 3.7315315343799562`*^9, 
   3.731532579377927*^9, 3.731578395265177*^9, 3.731582996342507*^9, 
   3.7316702607690268`*^9, 3.731671803666421*^9, 3.731671840566702*^9, 
   3.7318033549609127`*^9, 3.7318370311754837`*^9},
 CellLabel->"Out[98]=",ExpressionUUID->"177ea6c9-6445-45ac-bc91-6c82dfd7892c"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{"\[Xi]01", "=", 
  RowBox[{"List", "/@", 
   RowBox[{
   "nistAPrioris$", "\[LeftDoubleBracket]", "1", 
    "\[RightDoubleBracket]"}]}]}], "\[IndentingNewLine]", 
 RowBox[{"certified\[Xi]", "=", 
  RowBox[{"List", "/@", 
   RowBox[{
   "nistAPrioris$", "\[LeftDoubleBracket]", "3", 
    "\[RightDoubleBracket]"}]}]}]}], "Input",
 CellChangeTimes->{{3.731529612868752*^9, 3.7315297108393927`*^9}, {
   3.731530783592304*^9, 3.7315307917253*^9}, {3.731531079184366*^9, 
   3.731531097486068*^9}, {3.731531139824059*^9, 3.731531140702301*^9}, 
   3.731531199383656*^9, 3.731531539000311*^9},
 CellLabel->"In[99]:=",ExpressionUUID->"d7e92687-5f6e-42ff-9229-2ad97494578d"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", "1000", "}"}], ",", 
   RowBox[{"{", "1000", "}"}], ",", 
   RowBox[{"{", "400", "}"}], ",", 
   RowBox[{"{", "40", "}"}], ",", 
   RowBox[{"{", "0.7`", "}"}], ",", 
   RowBox[{"{", "0.3`", "}"}], ",", 
   RowBox[{"{", "0.03`", "}"}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.731529622549986*^9, {3.7315297018390827`*^9, 3.7315297123119717`*^9}, 
   3.731530792237446*^9, 3.7315310983553143`*^9, 3.7315311425158777`*^9, 
   3.731531206071899*^9, 3.731531539698097*^9, 3.731532582923311*^9, 
   3.731578397106058*^9, 3.731582996425026*^9, 3.7316702608131647`*^9, 
   3.731671803710025*^9, 3.731671840614888*^9, 3.731803355049788*^9, 
   3.731837031229394*^9},
 CellLabel->"Out[99]=",ExpressionUUID->"bf01628e-6401-48c5-8ee9-ae557b8bb6cb"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", "1288.13968`", "}"}], ",", 
   RowBox[{"{", "1491.0792535`", "}"}], ",", 
   RowBox[{"{", "583.23836877`", "}"}], ",", 
   RowBox[{"{", "75.416644291`", "}"}], ",", 
   RowBox[{"{", "0.96629502864`", "}"}], ",", 
   RowBox[{"{", "0.39797285797`", "}"}], ",", 
   RowBox[{"{", "0.049727297349`", "}"}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.731529622549986*^9, {3.7315297018390827`*^9, 3.7315297123119717`*^9}, 
   3.731530792237446*^9, 3.7315310983553143`*^9, 3.7315311425158777`*^9, 
   3.731531206071899*^9, 3.731531539698097*^9, 3.731532582923311*^9, 
   3.731578397106058*^9, 3.731582996425026*^9, 3.7316702608131647`*^9, 
   3.731671803710025*^9, 3.731671840614888*^9, 3.731803355049788*^9, 
   3.731837031240901*^9},
 CellLabel->
  "Out[100]=",ExpressionUUID->"e59bb34b-e18d-4ba1-a986-de4ba867a4bb"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{"\[Xi]02", "=", 
  RowBox[{"List", "/@", 
   RowBox[{
   "nistAPrioris$", "\[LeftDoubleBracket]", "2", 
    "\[RightDoubleBracket]"}]}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"(", 
   RowBox[{"certifiedSqrtP", "=", 
    RowBox[{"DiagonalMatrix", "@", 
     RowBox[{
     "nistAPrioris$", "\[LeftDoubleBracket]", "4", 
      "\[RightDoubleBracket]"}]}]}], ")"}], "//", "MatrixForm"}]}], "Input",
 CellChangeTimes->{{3.731529722869439*^9, 3.7315297627810717`*^9}, {
  3.731530800759638*^9, 3.7315308069089193`*^9}, {3.731531114071847*^9, 
  3.7315311544459248`*^9}, {3.731531219102021*^9, 3.731531237209278*^9}, {
  3.7315799330504847`*^9, 3.7315799367670527`*^9}},
 CellLabel->
  "In[101]:=",ExpressionUUID->"be8f6eaa-38d2-40cb-b095-2eb4cde90528"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", "1300", "}"}], ",", 
   RowBox[{"{", "1500", "}"}], ",", 
   RowBox[{"{", "500", "}"}], ",", 
   RowBox[{"{", "75", "}"}], ",", 
   RowBox[{"{", "1", "}"}], ",", 
   RowBox[{"{", "0.4`", "}"}], ",", 
   RowBox[{"{", "0.05`", "}"}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.73152976350299*^9, 3.731530807218573*^9, {3.731531133585031*^9, 
   3.7315311553217154`*^9}, {3.731531220968841*^9, 3.731531237872078*^9}, 
   3.731531544283957*^9, 3.731532584678794*^9, 3.731578398947666*^9, 
   3.731579937567919*^9, 3.7315829965936537`*^9, 3.731670260860086*^9, 
   3.731671803759075*^9, 3.731671840664843*^9, 3.731803355109212*^9, 
   3.731837031275154*^9},
 CellLabel->
  "Out[101]=",ExpressionUUID->"cdf131bd-ccbe-482f-afac-69ac71bdcbf3"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"4.6647963344`", "0.`", "0.`", "0.`", "0.`", "0.`", "0.`"},
     {"0.`", "39.571156086`", "0.`", "0.`", "0.`", "0.`", "0.`"},
     {"0.`", "0.`", "28.698696102`", "0.`", "0.`", "0.`", "0.`"},
     {"0.`", "0.`", "0.`", "5.567537027`", "0.`", "0.`", "0.`"},
     {"0.`", "0.`", "0.`", "0.`", "0.031333340687`", "0.`", "0.`"},
     {"0.`", "0.`", "0.`", "0.`", "0.`", "0.014984928198`", "0.`"},
     {"0.`", "0.`", "0.`", "0.`", "0.`", "0.`", "0.0065842344623`"}
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
 CellChangeTimes->{
  3.73152976350299*^9, 3.731530807218573*^9, {3.731531133585031*^9, 
   3.7315311553217154`*^9}, {3.731531220968841*^9, 3.731531237872078*^9}, 
   3.731531544283957*^9, 3.731532584678794*^9, 3.731578398947666*^9, 
   3.731579937567919*^9, 3.7315829965936537`*^9, 3.731670260860086*^9, 
   3.731671803759075*^9, 3.731671840664843*^9, 3.731803355109212*^9, 
   3.73183703128834*^9},
 CellLabel->
  "Out[102]//MatrixForm=",ExpressionUUID->"42eddfe0-9025-4fbb-bd7b-\
77c20ff461c0"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"nistDataAndPartialsStream$", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"#", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}], 
       ",", 
       RowBox[{"A$", "[", "#", "]"}]}], "}"}], "&"}], "/@", 
    "nistDataPoints$"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.731530575859921*^9, 3.731530602130723*^9}},
 CellLabel->
  "In[103]:=",ExpressionUUID->"2f1446d3-f5a8-4edc-9901-9382f8dfbae1"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"\[Xi]", "=", 
   RowBox[{"(", GridBox[{
      {"b1"},
      {"b2"},
      {"b3"},
      {"b4"},
      {"b5"},
      {"b6"},
      {"b7"}
     }], ")"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"P01", "=", 
   RowBox[{"IdentityMatrix", "[", "7", "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"\[CapitalLambda]01", "=", 
   RowBox[{"Inverse", "[", "P01", "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"P02", "=", 
   RowBox[{"IdentityMatrix", "[", "7", "]"}]}], ";", 
  RowBox[{"\[CapitalLambda]02", "=", 
   RowBox[{"Inverse", "[", "P02", "]"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.7315290764248753`*^9, 3.731529100690242*^9}, {
   3.731529276618257*^9, 3.731529282398251*^9}, {3.731529339552684*^9, 
   3.7315293702837257`*^9}, {3.731529409773993*^9, 3.731529433371642*^9}, 
   3.731529789622467*^9, {3.731531254888831*^9, 3.731531274335779*^9}, {
   3.731531319812131*^9, 3.7315313469231253`*^9}, {3.731531493311138*^9, 
   3.731531494530284*^9}, {3.7315315721061974`*^9, 3.731531633248666*^9}, {
   3.731532597279298*^9, 3.731532602925411*^9}, {3.7315784854659*^9, 
   3.731578486157859*^9}},
 CellLabel->
  "In[104]:=",ExpressionUUID->"fd55cbce-4aae-47cf-8ea7-f6d5e3b132ee"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "\[Xi]rules", "]"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"\[Xi]rules", "[", "numerical\[Xi]_", "]"}], ":=", 
  RowBox[{"Map", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"Apply", "[", 
      RowBox[{"Rule", ",", "#"}], "]"}], "&"}], ",", 
    RowBox[{"MapThread", "[", 
     RowBox[{"Join", ",", 
      RowBox[{"{", 
       RowBox[{"\[Xi]", ",", "numerical\[Xi]"}], "}"}]}], "]"}]}], 
   "]"}]}]}], "Input",
 CellChangeTimes->{{3.731531975852312*^9, 3.731532017978921*^9}},
 CellLabel->
  "In[108]:=",ExpressionUUID->"540961b9-bcf2-4b59-8a2c-636d3816a621"],

Cell["TODO: Fix rrls so it can handle this scenario", "Text",
 CellChangeTimes->{{3.731578498965782*^9, 
  3.7315785102365437`*^9}},ExpressionUUID->"dccbe074-3f38-4f74-99fa-\
85c2d9532358"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"ClearAll", "[", "rlsUpdate", "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"rlsUpdate", "[", "sqrtP\[CapitalZeta]_", "]"}], "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\[Xi]_", ",", "\[CapitalLambda]_"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"\[Zeta]_", ",", "a_"}], "}"}]}], "]"}], ":=", 
   "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"sP\[CapitalZeta]ia", "=", 
       RowBox[{"LinearSolve", "[", 
        RowBox[{"sqrtP\[CapitalZeta]", ",", "a"}], "]"}]}], "}"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"With", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"\[CapitalPi]", "=", 
         RowBox[{"(", 
          RowBox[{"\[CapitalLambda]", "+", 
           RowBox[{
            RowBox[{"sP\[CapitalZeta]ia", "\[Transpose]"}], ".", 
            "sP\[CapitalZeta]ia"}]}], ")"}]}], "}"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{"Print", "[", "\"\<a\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", "a", "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Print", "[", "\"\<\[Zeta]\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", "\[Zeta]", "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{"Print", "[", "\"\<sP\[CapitalZeta]ia\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", "sP\[CapitalZeta]ia", "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{
         "Print", "[", 
          "\"\<sP\[CapitalZeta]ia\[Transpose].sP\[CapitalZeta]ia\>\"", "]"}], 
         ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", 
           RowBox[{
            RowBox[{"sP\[CapitalZeta]ia", "\[Transpose]"}], ".", 
            "sP\[CapitalZeta]ia"}], "]"}], "]"}], ";", "\[IndentingNewLine]", 
         
         RowBox[{"Print", "[", "\"\<\[CapitalLambda].\[Xi]\>\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", 
           RowBox[{"\[CapitalLambda]", ".", "\[Xi]"}], "]"}], "]"}], ";", 
         "\[IndentingNewLine]", 
         RowBox[{
         "Print", "[", "\"\<sP\[CapitalZeta]ia\[Transpose].\[Zeta]\>\"", 
          "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", 
           RowBox[{
            RowBox[{"sP\[CapitalZeta]ia", "\[Transpose]"}], ".", "\[Zeta]"}], 
           "]"}], "]"}], ";", "\[IndentingNewLine]", 
         RowBox[{
         "Print", "[", 
          "\"\<sP\[CapitalZeta]ia\[Transpose].\[Zeta]+\[CapitalLambda].\[Xi]\>\
\"", "]"}], ";", 
         RowBox[{"Print", "[", 
          RowBox[{"MatrixForm", "[", 
           RowBox[{
            RowBox[{
             RowBox[{"sP\[CapitalZeta]ia", "\[Transpose]"}], ".", "\[Zeta]"}],
             "+", 
            RowBox[{"\[CapitalLambda]", ".", "\[Xi]"}]}], "]"}], "]"}], ";"}],
         "*)"}], "\[IndentingNewLine]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"LinearSolve", "[", 
          RowBox[{"\[CapitalPi]", ",", 
           RowBox[{"(", 
            RowBox[{
             RowBox[{
              RowBox[{"sP\[CapitalZeta]ia", "\[Transpose]"}], ".", 
              "\[Zeta]"}], "+", 
             RowBox[{"\[CapitalLambda]", ".", "\[Xi]"}]}], ")"}]}], "]"}], 
         ",", "\[CapitalPi]"}], "}"}]}], "]"}]}], "]"}]}], ";"}]}], "Input",
 CellChangeTimes->{
  3.731670467557962*^9, {3.731670725585148*^9, 3.7316708540785427`*^9}, {
   3.731671002378991*^9, 3.731671027603815*^9}, {3.7316710579163303`*^9, 
   3.7316711911932077`*^9}, {3.7316712651517897`*^9, 3.7316712831533422`*^9}, 
   3.731671773826447*^9},
 CellLabel->
  "In[110]:=",ExpressionUUID->"b0ae9a4e-5e3b-43e3-bbf0-5441c22aa721"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"rlsUpdate", "[", 
   RowBox[{"{", 
    RowBox[{"{", "1.0", "}"}], "}"}], "]"}], "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"\[Xi]01", ",", 
     RowBox[{"Inverse", "[", "P01", "]"}]}], "}"}], ",", 
   RowBox[{
   "nistDataAndPartialsStream$", "\[LeftDoubleBracket]", "1", 
    "\[RightDoubleBracket]"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.731661223566684*^9, 3.731661327169826*^9}},
 CellLabel->
  "In[112]:=",ExpressionUUID->"d013f766-a5f7-42ec-9b52-dcced2d67443"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"0.9997032690493594`", " ", 
       RowBox[{"(", 
        RowBox[{"1000.2967267865962`", "\[VeryThinSpace]", "+", 
         RowBox[{"1.`", " ", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"{", "1.`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "3.067`"}], "}"}], ",", 
             RowBox[{"{", "9.406489`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "28.849701763000002`"}], "}"}], ",", 
             RowBox[{"{", "247.120458`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "757.918444686`"}], "}"}], ",", 
             RowBox[{"{", "2324.535869851962`", "}"}]}], "}"}], ".", 
           "80.574`"}]}]}], ")"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"1.0009100738255476`", " ", 
       RowBox[{"(", 
        RowBox[{"999.091036213004`", "\[VeryThinSpace]", "+", 
         RowBox[{"1.`", " ", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"{", "1.`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "3.067`"}], "}"}], ",", 
             RowBox[{"{", "9.406489`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "28.849701763000002`"}], "}"}], ",", 
             RowBox[{"{", "247.120458`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "757.918444686`"}], "}"}], ",", 
             RowBox[{"{", "2324.535869851962`", "}"}]}], "}"}], ".", 
           "80.574`"}]}]}], ")"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0.9972088035781174`", " ", 
       RowBox[{"(", 
        RowBox[{"401.11873378271827`", "\[VeryThinSpace]", "+", 
         RowBox[{"1.`", " ", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"{", "1.`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "3.067`"}], "}"}], ",", 
             RowBox[{"{", "9.406489`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "28.849701763000002`"}], "}"}], ",", 
             RowBox[{"{", "247.120458`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "757.918444686`"}], "}"}], ",", 
             RowBox[{"{", "2324.535869851962`", "}"}]}], "}"}], ".", 
           "80.574`"}]}]}], ")"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"1.0085605994269713`", " ", 
       RowBox[{"(", 
        RowBox[{"39.663120206447964`", "\[VeryThinSpace]", "+", 
         RowBox[{"1.`", " ", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"{", "1.`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "3.067`"}], "}"}], ",", 
             RowBox[{"{", "9.406489`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "28.849701763000002`"}], "}"}], ",", 
             RowBox[{"{", "247.120458`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "757.918444686`"}], "}"}], ",", 
             RowBox[{"{", "2324.535869851962`", "}"}]}], "}"}], ".", 
           "80.574`"}]}]}], ")"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0.9266717116008094`", " ", 
       RowBox[{"(", 
        RowBox[{"0.730800890983002`", "\[VeryThinSpace]", "+", 
         RowBox[{"1.`", " ", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"{", "1.`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "3.067`"}], "}"}], ",", 
             RowBox[{"{", "9.406489`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "28.849701763000002`"}], "}"}], ",", 
             RowBox[{"{", "247.120458`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "757.918444686`"}], "}"}], ",", 
             RowBox[{"{", "2324.535869851962`", "}"}]}], "}"}], ".", 
           "80.574`"}]}]}], ")"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"1.2248978605183232`", " ", 
       RowBox[{"(", 
        RowBox[{"0.3019755658247517`", "\[VeryThinSpace]", "+", 
         RowBox[{"1.`", " ", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"{", "1.`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "3.067`"}], "}"}], ",", 
             RowBox[{"{", "9.406489`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "28.849701763000002`"}], "}"}], ",", 
             RowBox[{"{", "247.120458`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "757.918444686`"}], "}"}], ",", 
             RowBox[{"{", "2324.535869851962`", "}"}]}], "}"}], ".", 
           "80.574`"}]}]}], ")"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0.31023826150847555`", " ", 
       RowBox[{"(", 
        RowBox[{
         RowBox[{"-", "0.5942215181533763`"}], "+", 
         RowBox[{"1.`", " ", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"{", "1.`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "3.067`"}], "}"}], ",", 
             RowBox[{"{", "9.406489`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "28.849701763000002`"}], "}"}], ",", 
             RowBox[{"{", "247.120458`", "}"}], ",", 
             RowBox[{"{", 
              RowBox[{"-", "757.918444686`"}], "}"}], ",", 
             RowBox[{"{", "2324.535869851962`", "}"}]}], "}"}], ".", 
           "80.574`"}]}]}], ")"}]}], "}"}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"2.`", ",", 
       RowBox[{"-", "3.067`"}], ",", "9.406489`", ",", 
       RowBox[{"-", "28.849701763000002`"}], ",", "247.120458`", ",", 
       RowBox[{"-", "757.918444686`"}], ",", "2324.535869851962`"}], "}"}], 
     ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"-", "3.067`"}], ",", "10.406489`", ",", 
       RowBox[{"-", "28.849701763000002`"}], ",", "88.48203530712101`", ",", 
       RowBox[{"-", "757.918444686`"}], ",", "2324.535869851962`", ",", 
       RowBox[{"-", "7129.351512835969`"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"9.406489`", ",", 
       RowBox[{"-", "28.849701763000002`"}], ",", "89.48203530712101`", ",", 
       RowBox[{"-", "271.37440228694015`"}], ",", "2324.535869851962`", ",", 
       RowBox[{"-", "7129.351512835969`"}], ",", "21865.721089867915`"}], 
      "}"}], ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"-", "28.849701763000002`"}], ",", "88.48203530712101`", ",", 
       RowBox[{"-", "271.37440228694015`"}], ",", "833.3052918140454`", ",", 
       RowBox[{"-", "7129.351512835969`"}], ",", "21865.721089867915`", ",", 
       RowBox[{"-", "67062.1665826249`"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"247.120458`", ",", 
       RowBox[{"-", "757.918444686`"}], ",", "2324.535869851962`", ",", 
       RowBox[{"-", "7129.351512835969`"}], ",", "61069.520762129774`", ",", 
       RowBox[{"-", "187297.153177452`"}], ",", "574440.3687952453`"}], "}"}],
      ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"-", "757.918444686`"}], ",", "2324.535869851962`", ",", 
       RowBox[{"-", "7129.351512835969`"}], ",", "21865.721089867915`", ",", 
       RowBox[{"-", "187297.153177452`"}], ",", "574441.3687952453`", ",", 
       RowBox[{"-", "1.7618086110950173`*^6"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"2324.535869851962`", ",", 
       RowBox[{"-", "7129.351512835969`"}], ",", "21865.721089867915`", ",", 
       RowBox[{"-", "67062.1665826249`"}], ",", "574440.3687952453`", ",", 
       RowBox[{"-", "1.7618086110950173`*^6"}], ",", 
       "5.403468010228419`*^6"}], "}"}]}], "}"}]}], "}"}]], "Output",
 CellChangeTimes->{
  3.73167086428364*^9, {3.731671127730259*^9, 3.7316711418998404`*^9}, 
   3.731671196976906*^9, 3.731671287891903*^9, {3.731671781938895*^9, 
   3.7316718038445663`*^9}, 3.731671840848837*^9, 3.7318033552000933`*^9, 
   3.7318370313716288`*^9},
 CellLabel->
  "Out[112]=",ExpressionUUID->"9cda0d53-d70e-4060-bd5b-672b68efa101"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"Module", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
      "\[Xi]1", ",", "P1", ",", "\[Xi]2", ",", "P2", ",", "\[Xi]r1", ",", 
       "\[CapitalLambda]1"}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{
       RowBox[{"{", 
        RowBox[{"\[Xi]1", ",", "P1"}], "}"}], "=", "\[IndentingNewLine]", 
       RowBox[{"Fold", "[", 
        RowBox[{
         RowBox[{"kalmanUpdate", "[", 
          RowBox[{"{", 
           RowBox[{"{", 
            SuperscriptBox["10", 
             RowBox[{"2", "log\[Sigma]\[Zeta]"}]], "}"}], "}"}], "]"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"{", 
          RowBox[{"\[Xi]01", ",", 
           RowBox[{
            SuperscriptBox["10", 
             RowBox[{"2", "log\[Sigma]\[Xi]"}]], "P01"}]}], "}"}], ",", 
         "\[IndentingNewLine]", "nistDataAndPartialsStream$"}], "]"}]}], ";", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"\[Xi]2", ",", "P2"}], "}"}], "=", "\[IndentingNewLine]", 
       RowBox[{"Fold", "[", 
        RowBox[{
         RowBox[{"kalmanUpdate", "[", 
          RowBox[{"{", 
           RowBox[{"{", 
            SuperscriptBox["10", 
             RowBox[{"2", "log\[Sigma]\[Zeta]"}]], "}"}], "}"}], "]"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"{", 
          RowBox[{"\[Xi]01", ",", 
           RowBox[{
            SuperscriptBox["10", 
             RowBox[{"2", "log\[Sigma]\[Xi]"}]], "P01"}]}], "}"}], ",", 
         "\[IndentingNewLine]", "nistDataAndPartialsStream$"}], "]"}]}], ";", 
      "\[IndentingNewLine]", 
      RowBox[{"Show", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"ListPlot", "[", "nistDataPoints$", "]"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"Plot", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"nistModelPre$", "/.", 
              RowBox[{"\[Xi]rules", "@", "certified\[Xi]"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"nistModelPre$", "/.", 
              RowBox[{"\[Xi]rules", "@", "\[Xi]01"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"nistModelPre$", "/.", 
              RowBox[{"\[Xi]rules", "@", "\[Xi]02"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"nistModelPre$", "/.", 
              RowBox[{"\[Xi]rules", "@", "\[Xi]1"}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{"nistModelPre$", "/.", 
              RowBox[{"\[Xi]rules", "@", "\[Xi]2"}]}]}], "}"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"{", 
            RowBox[{"x", ",", 
             RowBox[{"-", "3.1"}], ",", "2.3"}], "}"}]}], "]"}]}], "}"}], 
       "]"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Grid", "[", 
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"Row", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"Button", "[", 
           RowBox[{"\"\<RESET\>\"", ",", "\[IndentingNewLine]", 
            RowBox[{
             RowBox[{"(", 
              RowBox[{
               RowBox[{"log\[Sigma]\[Xi]", "=", "3.0"}], ";", 
               RowBox[{"log\[Sigma]\[Zeta]", "=", "0.0"}]}], ")"}], "&"}]}], 
           "]"}], ",", "\[IndentingNewLine]", 
          RowBox[{"Button", "[", 
           RowBox[{"\"\<MAGIC\>\"", ",", "\[IndentingNewLine]", 
            RowBox[{
             RowBox[{"(", 
              RowBox[{
               RowBox[{"log\[Sigma]\[Xi]", "=", "4.16"}], ";", 
               RowBox[{"log\[Sigma]\[Zeta]", "=", "0.0"}]}], ")"}], "&"}]}], 
           "]"}]}], "}"}], "]"}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
           "log\[Sigma]\[Xi]", ",", "3.0", ",", 
            "\"\<\!\(\*SubscriptBox[\(log\), \(10\)]\) \!\(\*SqrtBox[\(P\)]\)\
\>\""}], "}"}], ",", 
          RowBox[{"-", "3"}], ",", "8", ",", 
          RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
        "]"}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"{", 
       RowBox[{"Control", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
           "log\[Sigma]\[Zeta]", ",", "0.0", ",", 
            "\"\<\!\(\*SubscriptBox[\(log\), \(10\)]\) \!\(\*SqrtBox[\(\
\[CapitalZeta]\)]\)\>\""}], "}"}], ",", 
          RowBox[{"-", "6"}], ",", "3", ",", 
          RowBox[{"Appearance", "\[Rule]", "\"\<Labeled\>\""}]}], "}"}], 
        "]"}], "}"}]}], "\[IndentingNewLine]", "}"}], "]"}]}], "]"}]], "Input",\

 CellChangeTimes->CompressedData["
1:eJwdxUsogwEAB/CvbeJEIULENAfW2gWZWVOYw7z2iDXCsmUPr2SJ7LvIlhzI
d9jmUdpOE0nbWjt43BBqzUJkuyBWX3FYs4N8f4dfvyrdlELPIgiilIE7bRm1
6ibZKpfqh7D/VTX6P6kwYr6kYxbXx7vm8MiAxobv3CISn3FCqzjH41/HP4bY
LebGlBGstRy3qZmzXQEZJnztK1hipx04fzGxhk2eFIWtg+ItLGgo28VFj1lR
M3OhUXKP1WbWEzbxiAQ+XJ62W5hzP5Y28EWq24UXDN9uPFmS9GLOVc8Rlu3U
BrCu3BjEX9uOMHY76yJYNBx7xmPW6zgOpqLvOHSq/cRiap7Gb028ND4n0+wJ
Zindx8EvM95irOntr8EFvgMhPpHzG/HDOLsZV2T2WrDIuVlJMSeI/Wqs5P4K
cDjvUoj/ACWt4h4=
  "],
 CellLabel->
  "In[113]:=",ExpressionUUID->"75fcbd46-a315-4c7c-8817-a2ceda0486e7"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`log\[Sigma]\[Zeta]$$ = 
    0., $CellContext`log\[Sigma]\[Xi]$$ = 3., Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`log\[Sigma]\[Xi]$$], 3., 
       "\!\(\*SubscriptBox[\(log\), \(10\)]\) \!\(\*SqrtBox[\(P\)]\)"}, -3, 
      8}, {{
       Hold[$CellContext`log\[Sigma]\[Zeta]$$], 0., 
       "\!\(\*SubscriptBox[\(log\), \(10\)]\) \
\!\(\*SqrtBox[\(\[CapitalZeta]\)]\)"}, -6, 3}, {
      Hold[
       Grid[{{
          Row[{
            Button[
            "RESET", ($CellContext`log\[Sigma]\[Xi]$$ = 
              3.; $CellContext`log\[Sigma]\[Zeta]$$ = 0.)& ], 
            Button[
            "MAGIC", ($CellContext`log\[Sigma]\[Xi]$$ = 
              4.16; $CellContext`log\[Sigma]\[Zeta]$$ = 0.)& ]}]}, {
          Manipulate`Place[1]}, {
          Manipulate`Place[2]}}]], Manipulate`Dump`ThisIsNotAControl}}, 
    Typeset`size$$ = {540., {171., 178.}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = 
    True, $CellContext`log\[Sigma]\[Xi]$7078$$ = 
    0, $CellContext`log\[Sigma]\[Zeta]$7079$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     2, StandardForm, 
      "Variables" :> {$CellContext`log\[Sigma]\[Zeta]$$ = 
        0., $CellContext`log\[Sigma]\[Xi]$$ = 3.}, "ControllerVariables" :> {
        Hold[$CellContext`log\[Sigma]\[Xi]$$, \
$CellContext`log\[Sigma]\[Xi]$7078$$, 0], 
        Hold[$CellContext`log\[Sigma]\[Zeta]$$, $CellContext`log\[Sigma]\
\[Zeta]$7079$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Module[{$CellContext`\[Xi]1$, $CellContext`P1$, $CellContext`\[Xi]2$, \
$CellContext`P2$, $CellContext`\[Xi]r1$, $CellContext`\[CapitalLambda]1$}, \
{$CellContext`\[Xi]1$, $CellContext`P1$} = Fold[
           $CellContext`kalmanUpdate[{{
             10^(2 $CellContext`log\[Sigma]\[Zeta]$$)}}], \
{$CellContext`\[Xi]01, 
            10^(2 $CellContext`log\[Sigma]\[Xi]$$) $CellContext`P01}, \
$CellContext`nistDataAndPartialsStream$]; {$CellContext`\[Xi]2$, \
$CellContext`P2$} = Fold[
           $CellContext`kalmanUpdate[{{
             10^(2 $CellContext`log\[Sigma]\[Zeta]$$)}}], \
{$CellContext`\[Xi]01, 
            10^(2 $CellContext`log\[Sigma]\[Xi]$$) $CellContext`P01}, \
$CellContext`nistDataAndPartialsStream$]; Show[{
           ListPlot[$CellContext`nistDataPoints$], 
           Plot[{
             ReplaceAll[$CellContext`nistModelPre$, 
              $CellContext`\[Xi]rules[$CellContext`certified\[Xi]]], 
             ReplaceAll[$CellContext`nistModelPre$, 
              $CellContext`\[Xi]rules[$CellContext`\[Xi]01]], 
             ReplaceAll[$CellContext`nistModelPre$, 
              $CellContext`\[Xi]rules[$CellContext`\[Xi]02]], 
             ReplaceAll[$CellContext`nistModelPre$, 
              $CellContext`\[Xi]rules[$CellContext`\[Xi]1$]], 
             ReplaceAll[$CellContext`nistModelPre$, 
              $CellContext`\[Xi]rules[$CellContext`\[Xi]2$]]}, \
{$CellContext`x, -3.1, 2.3}]}]], 
      "Specifications" :> {{{$CellContext`log\[Sigma]\[Xi]$$, 3., 
          "\!\(\*SubscriptBox[\(log\), \(10\)]\) \!\(\*SqrtBox[\(P\)]\)"}, -3,
          8, Appearance -> "Labeled", ControlPlacement -> 
         1}, {{$CellContext`log\[Sigma]\[Zeta]$$, 0., 
          "\!\(\*SubscriptBox[\(log\), \(10\)]\) \!\(\*SqrtBox[\(\
\[CapitalZeta]\)]\)"}, -6, 3, Appearance -> "Labeled", ControlPlacement -> 2}, 
        Grid[{{
           Row[{
             Button[
             "RESET", ($CellContext`log\[Sigma]\[Xi]$$ = 
               3.; $CellContext`log\[Sigma]\[Zeta]$$ = 0.)& ], 
             Button[
             "MAGIC", ($CellContext`log\[Sigma]\[Xi]$$ = 
               4.16; $CellContext`log\[Sigma]\[Zeta]$$ = 0.)& ]}]}, {
           Manipulate`Place[1]}, {
           Manipulate`Place[2]}}]}, "Options" :> {}, "DefaultOptions" :> {}],
     ImageSizeCache->{606., {271., 279.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{3.73166108644937*^9, 3.731670260941449*^9, 
  3.731671803898831*^9, 3.7316718409307756`*^9, 3.731803355241335*^9, 
  3.7318370314263067`*^9},
 CellLabel->
  "Out[113]=",ExpressionUUID->"e5fc4826-4991-415d-9004-0384bfd31d36"]
}, Open  ]],

Cell["\<\
We leave detailed examination of the covariances of this solution to another \
paper.\
\>", "Text",
 CellChangeTimes->{{3.7318033716349154`*^9, 
  3.731803399568852*^9}},ExpressionUUID->"513cde9e-93cf-41be-8691-\
ee862b17f15c"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Conclusion", "Chapter",
 CellChangeTimes->{{3.729196441150124*^9, 
  3.7291964428392887`*^9}},ExpressionUUID->"86809f6e-d10a-4415-bfb6-\
1622acbaa2d7"],

Cell["\<\
We have shown that Kalman folding (KAL) produces the same results as \
renormalized recurrent least squares (RLS) and maximum a-posteriori (MAP) for \
appropriate choices of covariances, i.e., regularization hyperparameters. We \
have further shown (numerically) that MAP produces the same estimates, though \
not covariances, when its hyperparameters are swapped and inverted. 

KAL and RLS offer significant advantages in space-time efficiency by avoiding \
storage and multiplication of large matrices. In all cases, we avoid matrix \
inverses by solving linear systems internally.\
\>", "Text",
 CellChangeTimes->{{3.7291964484304113`*^9, 3.729196613945616*^9}, 
   3.7292030970835457`*^9, {3.72968771341329*^9, 3.729687716858973*^9}, {
   3.729711791511696*^9, 3.72971179468015*^9}, {3.729799002121397*^9, 
   3.729799077001767*^9}, {3.731803410643422*^9, 
   3.7318034204878063`*^9}},ExpressionUUID->"71c98aaa-f00d-4a00-b47a-\
97d458816116"]
}, Open  ]]
}, Open  ]]
},
WindowSize->{1440, 851},
WindowMargins->{{0, Automatic}, {Automatic, 0}},
PrintingCopies->1,
PrintingStartingPageNumber->1,
PrintingPageRange->{1, Automatic},
TaggingRules->{
 "PaginationCache" -> {{2018, 2, 20, 19, 46, 39.675061`8.351092581673305}, {1,
     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
    1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3,
     4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 6, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 
    9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 11, 12, 12, 12, 12, 13, 14, 14, 
    15, 15, 17, 17, 19, 19, 19, 20}, Automatic}},
Magnification:>1.5 Inherited,
FrontEndVersion->"11.3 for Mac OS X x86 (32-bit, 64-bit Kernel) (March 5, \
2018)",
StyleDefinitions->FrontEnd`FileName[{$RootDirectory, "Users", "bbeckman"}, 
  "DefaultStyles.nb", CharacterEncoding -> "UTF-8"]
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{
 "c:1"->{
  Cell[1510, 35, 472, 7, 226, "Title",ExpressionUUID->"6f3cba05-b339-4654-99a4-829a31dbb3b1",
   CellTags->"c:1"]},
 "c:2"->{
  Cell[4853, 103, 272, 4, 101, "Chapter",ExpressionUUID->"ac34acab-a5c3-4ce8-a17e-2e0809ef5c38",
   CellTags->"c:2"]},
 "c:3"->{
  Cell[11872, 249, 228, 3, 101, "Chapter",ExpressionUUID->"60f0d5e4-c389-49f8-8a99-2be345d490c1",
   CellTags->"c:3"]},
 "c:4"->{
  Cell[23316, 515, 297, 4, 95, "Subchapter",ExpressionUUID->"44a54455-7a93-4f41-8b0d-0963fc34ef68",
   CellTags->"c:4"]},
 "c:5"->{
  Cell[25950, 582, 197, 3, 95, "Subchapter",ExpressionUUID->"433846fc-b9f7-4657-832d-cdc66c8f4802",
   CellTags->"c:5"]},
 "c:6"->{
  Cell[33266, 740, 268, 3, 95, "Subchapter",ExpressionUUID->"0d62cc58-4a7d-4ab1-afbb-f501bfb6ca94",
   CellTags->"c:6"]},
 "c:7"->{
  Cell[39958, 877, 228, 3, 95, "Subchapter",ExpressionUUID->"e91f2fba-5676-430d-9745-205c1814fa0e",
   CellTags->"c:7"]},
 "c:8"->{
  Cell[60494, 1313, 325, 4, 95, "Subchapter",ExpressionUUID->"ca281e5b-c608-485a-9d34-ff27451115a8",
   CellTags->"c:8"]},
 "c:9"->{
  Cell[74449, 1624, 218, 3, 101, "Chapter",ExpressionUUID->"f7c0e206-7d74-4627-a983-340eb9a5954e",
   CellTags->"c:9"]},
 "c:10"->{
  Cell[150605, 3289, 256, 3, 95, "Subchapter",ExpressionUUID->"fa5c3c19-9228-4e76-bd56-41d0e5fcc961",
   CellTags->"c:10"]},
 "c:11"->{
  Cell[161774, 3557, 299, 4, 101, "Chapter",ExpressionUUID->"a72d02c1-4d0c-4859-b900-7c456316807a",
   CellTags->"c:11"]},
 "c:12"->{
  Cell[180678, 3986, 195, 2, 95, "Subchapter",ExpressionUUID->"7d924a7d-213d-4b77-996e-4b77a2416acf",
   CellTags->"c:12"]},
 "c:13"->{
  Cell[188661, 4175, 461, 6, 101, "Chapter",ExpressionUUID->"919e5e5b-7d8b-4c5f-ab4c-0bcbe514a42c",
   CellTags->"c:13"]},
 "c:14"->{
  Cell[381902, 8226, 181, 2, 101, "Chapter",ExpressionUUID->"5c7c5664-b41c-4b04-8932-015a8fb21123",
   CellTags->"c:14"]},
 "c:15"->{
  Cell[383855, 8278, 241, 3, 95, "Subchapter",ExpressionUUID->"745a88e4-3128-451b-92f3-e1940cb4b2c0",
   CellTags->"c:15"]}
 }
*)
(*CellTagsIndex
CellTagsIndex->{
 {"c:1", 602781, 13163},
 {"c:2", 602907, 13166},
 {"c:3", 603036, 13169},
 {"c:4", 603166, 13172},
 {"c:5", 603298, 13175},
 {"c:6", 603430, 13178},
 {"c:7", 603562, 13181},
 {"c:8", 603694, 13184},
 {"c:9", 603827, 13187},
 {"c:10", 603959, 13190},
 {"c:11", 604095, 13193},
 {"c:12", 604229, 13196},
 {"c:13", 604365, 13199},
 {"c:14", 604499, 13202},
 {"c:15", 604633, 13205}
 }
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1510, 35, 472, 7, 226, "Title",ExpressionUUID->"6f3cba05-b339-4654-99a4-829a31dbb3b1",
 CellTags->"c:1"],
Cell[1985, 44, 417, 9, 103, "Text",ExpressionUUID->"f8a900e9-2e08-4795-8dd9-f13eab31aca1"],
Cell[CellGroupData[{
Cell[2427, 57, 206, 4, 101, "Chapter",ExpressionUUID->"c691a64c-109c-488d-abc8-7f93f0bcc661"],
Cell[2636, 63, 2180, 35, 469, "Text",ExpressionUUID->"5d23495e-5728-42d6-9934-6c2838298bd0"]
}, Open  ]],
Cell[CellGroupData[{
Cell[4853, 103, 272, 4, 101, "Chapter",ExpressionUUID->"ac34acab-a5c3-4ce8-a17e-2e0809ef5c38",
 CellTags->"c:2"],
Cell[5128, 109, 6707, 135, 840, "Text",ExpressionUUID->"5d1cffa9-8f1d-42f1-8975-2ad10bf3fb46"]
}, Open  ]],
Cell[CellGroupData[{
Cell[11872, 249, 228, 3, 101, "Chapter",ExpressionUUID->"60f0d5e4-c389-49f8-8a99-2be345d490c1",
 CellTags->"c:3"],
Cell[12103, 254, 1471, 25, 225, "Text",ExpressionUUID->"257c66c7-5f70-4622-9ebc-7929e4f16274"],
Cell[CellGroupData[{
Cell[13599, 283, 774, 11, 62, "ItemNumbered",ExpressionUUID->"ebd2fb63-b879-4d99-993d-f021c07b07e9"],
Cell[14376, 296, 738, 10, 62, "ItemNumbered",ExpressionUUID->"25af2013-58eb-435d-91ee-e15f90db485e"],
Cell[15117, 308, 737, 10, 62, "ItemNumbered",ExpressionUUID->"cf917ebf-e7b0-4c48-aca2-a22973e85a6b"],
Cell[15857, 320, 852, 13, 62, "ItemNumbered",ExpressionUUID->"e0b493a0-0397-4fab-ae3f-432a214c55a4"]
}, Open  ]],
Cell[16724, 336, 1038, 16, 103, "Text",ExpressionUUID->"e52f8176-4cc0-4ca1-aff7-64070f8c385c"],
Cell[CellGroupData[{
Cell[17787, 356, 165, 3, 95, "Subchapter",ExpressionUUID->"58114e63-81c6-462c-bbd6-d03045d0a7a0"],
Cell[17955, 361, 3159, 88, 225, "Text",ExpressionUUID->"4c44fa41-5e68-4119-bb8a-3a430d2406f7"],
Cell[21117, 451, 2162, 59, 161, "DisplayFormulaNumbered",ExpressionUUID->"dc4eebef-5104-4cd0-aefc-2b89d29cc5b5"]
}, Open  ]],
Cell[CellGroupData[{
Cell[23316, 515, 297, 4, 95, "Subchapter",ExpressionUUID->"44a54455-7a93-4f41-8b0d-0963fc34ef68",
 CellTags->"c:4"],
Cell[23616, 521, 1716, 38, 164, "Text",ExpressionUUID->"a05b652d-dbed-4dbe-b08e-e00ac5fb316c"],
Cell[25335, 561, 578, 16, 95, "Input",ExpressionUUID->"f62c0cce-ff47-4c98-9aad-0a450d6c5fa6"]
}, Open  ]],
Cell[CellGroupData[{
Cell[25950, 582, 197, 3, 95, "Subchapter",ExpressionUUID->"433846fc-b9f7-4657-832d-cdc66c8f4802",
 CellTags->"c:5"],
Cell[26150, 587, 1636, 38, 103, "Text",ExpressionUUID->"35ffa721-f0f8-44d8-87ab-ab6692b08760"],
Cell[CellGroupData[{
Cell[27811, 629, 1912, 42, 188, "Input",ExpressionUUID->"9af9d278-a60f-46e9-b91e-f8985ee51e42"],
Cell[29726, 673, 3491, 61, 80, "Output",ExpressionUUID->"77a40b6f-f8e2-4bce-b213-9af7e5ebb8b9"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[33266, 740, 268, 3, 95, "Subchapter",ExpressionUUID->"0d62cc58-4a7d-4ab1-afbb-f501bfb6ca94",
 CellTags->"c:6"],
Cell[33537, 745, 401, 10, 72, "Text",ExpressionUUID->"c286be14-3574-4e2f-aee0-88b3eca1df91"],
Cell[33941, 757, 1138, 27, 188, "Input",ExpressionUUID->"68458ec7-49df-48ae-ada3-aabe6fcd1144"],
Cell[CellGroupData[{
Cell[35104, 788, 1456, 28, 157, "Input",ExpressionUUID->"a06eade6-df5a-4a64-bc67-512ccb726142"],
Cell[36563, 818, 3346, 53, 80, "Output",ExpressionUUID->"436d67ee-52d5-4ffa-9dc6-b67b936d9261"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[39958, 877, 228, 3, 95, "Subchapter",ExpressionUUID->"e91f2fba-5676-430d-9745-205c1814fa0e",
 CellTags->"c:7"],
Cell[40189, 882, 1987, 57, 151, "Text",ExpressionUUID->"9648f90a-a626-4271-8be6-c25292b618eb"],
Cell[CellGroupData[{
Cell[42201, 943, 934, 21, 126, "Input",ExpressionUUID->"83aa8865-1d03-4f5f-8eee-bf94e902264f"],
Cell[43138, 966, 2831, 42, 63, "Output",ExpressionUUID->"7371cd1f-74e4-405f-8849-8eeebfdd8203"]
}, Open  ]],
Cell[45984, 1011, 397, 8, 72, "Text",ExpressionUUID->"5b048dbd-26e5-41a7-a5e0-f8f76a86b877"],
Cell[46384, 1021, 671, 15, 63, "Input",ExpressionUUID->"bccb08a3-bc86-406e-b91a-cb8f4590cb84"],
Cell[47058, 1038, 266, 6, 72, "Text",ExpressionUUID->"c9624449-1281-4c8f-b284-ffbdd9c15235"],
Cell[CellGroupData[{
Cell[47349, 1048, 266, 5, 63, "Input",ExpressionUUID->"1aa612f5-94a1-47e8-a61b-a5e1600171d0"],
Cell[47618, 1055, 1341, 30, 101, "Output",ExpressionUUID->"442c0a7d-af12-4093-984b-3832ff7b71f9"]
}, Open  ]],
Cell[48974, 1088, 767, 17, 133, "Text",ExpressionUUID->"bf371dfc-b470-4783-b2ee-dd6343a808a9"],
Cell[CellGroupData[{
Cell[49766, 1109, 1008, 25, 95, "Input",ExpressionUUID->"922b24d0-ae9a-4fbc-a366-23e6b3d1e168"],
Cell[50777, 1136, 9668, 171, 372, "Output",ExpressionUUID->"7191b8ee-db95-4b8f-ba2f-680b8219b491"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[60494, 1313, 325, 4, 95, "Subchapter",ExpressionUUID->"ca281e5b-c608-485a-9d34-ff27451115a8",
 CellTags->"c:8"],
Cell[60822, 1319, 2362, 55, 140, "Text",ExpressionUUID->"a9137087-d558-4777-9e56-9e100bfcc743"],
Cell[63187, 1376, 755, 17, 38, "DisplayFormulaNumbered",ExpressionUUID->"f8ba42d7-04ae-4e9e-8434-d4ba4a95557e"],
Cell[63945, 1395, 324, 6, 72, "Text",ExpressionUUID->"82e3ae29-29c1-416f-b544-fd3c6d827ad2"],
Cell[CellGroupData[{
Cell[64294, 1405, 397, 8, 63, "Input",ExpressionUUID->"986deba2-6cc4-4f3b-8665-91369b1c6aee"],
Cell[64694, 1415, 2627, 39, 63, "Output",ExpressionUUID->"a0eb4184-c32a-487d-a58d-6da7ae881ae8"]
}, Open  ]],
Cell[CellGroupData[{
Cell[67358, 1459, 175, 3, 50, "Subsection",ExpressionUUID->"2ff6d613-8b0c-4933-8790-78acf6a0ec5e"],
Cell[67536, 1464, 699, 20, 72, "Text",ExpressionUUID->"e17fdc0c-7b6b-46f1-bcac-cdcca86ed4bc"],
Cell[CellGroupData[{
Cell[68260, 1488, 304, 7, 63, "Input",ExpressionUUID->"06613afb-3b7f-49b3-b605-2e19ad87234f"],
Cell[68567, 1497, 2412, 36, 63, "Output",ExpressionUUID->"790b9497-fb5a-4b2b-a93c-5a71c49df922"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[71028, 1539, 168, 3, 50, "Subsection",ExpressionUUID->"68070156-b8f5-4f5d-a4c3-925e43fdf042"],
Cell[71199, 1544, 459, 10, 72, "Text",ExpressionUUID->"559740ea-7cb1-4970-ad69-ec06a4bf828a"],
Cell[CellGroupData[{
Cell[71683, 1558, 369, 8, 63, "Input",ExpressionUUID->"5e10efde-95ce-4c1d-bf2d-6e19aa756c02"],
Cell[72055, 1568, 918, 15, 63, "Output",ExpressionUUID->"f5ed7055-d859-4b44-9718-d614b99803ab"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[73022, 1589, 195, 3, 50, "Subsection",ExpressionUUID->"bc33d2c7-2d46-4ea7-a314-ca4d8b6355b9"],
Cell[73220, 1594, 1168, 23, 103, "Text",ExpressionUUID->"9094bcb8-aac9-4711-af2f-db10bec4f3de"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[74449, 1624, 218, 3, 101, "Chapter",ExpressionUUID->"f7c0e206-7d74-4627-a983-340eb9a5954e",
 CellTags->"c:9"],
Cell[74670, 1629, 938, 21, 72, "Text",ExpressionUUID->"0f205045-666c-467b-8341-2d65449ef1f1"],
Cell[75611, 1652, 1096, 28, 72, "DisplayFormulaNumbered",ExpressionUUID->"60ecaaeb-3b39-467a-9960-75dccfc81a5b"],
Cell[76710, 1682, 1281, 18, 72, "Text",ExpressionUUID->"05908300-c5e1-4295-8faf-8c5c1deee5ed"],
Cell[CellGroupData[{
Cell[78016, 1704, 1552, 26, 63, "Item",ExpressionUUID->"a370fb9a-10f0-4f59-807e-c414b3d01f79"],
Cell[79571, 1732, 1782, 34, 63, "Item",ExpressionUUID->"b7b431ff-ac19-4a02-91be-c1eeafd93b20"],
Cell[81356, 1768, 1608, 29, 63, "Item",ExpressionUUID->"55a754d6-6e23-4d10-96b6-2ec60d09bf0f"]
}, Open  ]],
Cell[CellGroupData[{
Cell[83001, 1802, 167, 3, 50, "Subsection",ExpressionUUID->"1b451674-a32b-4a68-8fc0-63501280f112"],
Cell[83171, 1807, 1571, 23, 72, "Text",ExpressionUUID->"3d8412f1-baec-4559-9817-5f73a37328f9"],
Cell[84745, 1832, 1961, 36, 45, "DisplayFormulaNumbered",ExpressionUUID->"049a87cf-3e93-4f73-a537-9755c620fece"],
Cell[86709, 1870, 1603, 22, 72, "Text",ExpressionUUID->"9cf10725-469b-4b70-8cad-99e63f4accc4"],
Cell[88315, 1894, 1799, 31, 38, "DisplayFormulaNumbered",ExpressionUUID->"6f4a34cf-6a11-49f5-b834-bc228fcdcabf"],
Cell[90117, 1927, 1896, 37, 72, "Text",ExpressionUUID->"eeff7d74-acd8-40b2-9a3c-62ffbb11d73b"],
Cell[92016, 1966, 2712, 57, 38, "DisplayFormulaNumbered",ExpressionUUID->"28e27674-dc73-48b5-a111-4a3c918e786b"],
Cell[94731, 2025, 5011, 108, 316, "Text",ExpressionUUID->"9845ca25-86c3-4f4a-850b-75e20bbba84f"]
}, Open  ]],
Cell[CellGroupData[{
Cell[99779, 2138, 173, 3, 50, "Subsection",ExpressionUUID->"52abf8d8-f1cf-4628-8ed0-a072dfee45a0"],
Cell[99955, 2143, 2305, 51, 74, "Text",ExpressionUUID->"241702ba-d389-4dde-a4d5-c59d9b478c61"],
Cell[CellGroupData[{
Cell[102285, 2198, 4005, 92, 378, "Input",ExpressionUUID->"dbaf9a17-ac84-4ad7-a492-c93ee24a7a98"],
Cell[106293, 2292, 3028, 61, 84, "Output",ExpressionUUID->"24c6abb8-494a-4e33-9d7f-aac19e57213c"]
}, Open  ]],
Cell[109336, 2356, 1320, 30, 103, "Text",ExpressionUUID->"c7441eff-d24d-462a-b81a-c02c0abdd45a"]
}, Open  ]],
Cell[CellGroupData[{
Cell[110693, 2391, 164, 3, 50, "Subsection",ExpressionUUID->"009547f9-cdd9-4b41-b0ac-a45b3bd11079"],
Cell[110860, 2396, 1097, 19, 133, "Text",ExpressionUUID->"45bb6a3c-6183-46fa-bcdc-67faf162b472"]
}, Open  ]],
Cell[CellGroupData[{
Cell[111994, 2420, 176, 3, 50, "Subsection",ExpressionUUID->"aea5d153-88f7-4013-8a0f-80206ab9b05f"],
Cell[112173, 2425, 2116, 53, 166, "Text",ExpressionUUID->"208256bd-b9ea-4b31-b13d-16c94d398ac7"]
}, Open  ]],
Cell[CellGroupData[{
Cell[114326, 2483, 166, 3, 50, "Subsection",ExpressionUUID->"d579222c-220c-48fb-943b-d078dfc110cf"],
Cell[114495, 2488, 1666, 42, 103, "Text",ExpressionUUID->"687c3b9e-097a-48df-bf2f-bb6be8805802"],
Cell[CellGroupData[{
Cell[116186, 2534, 323, 6, 63, "Input",ExpressionUUID->"bb0da3f3-13d8-45ee-82ab-26365a385f8b"],
Cell[116512, 2542, 2122, 34, 66, "Output",ExpressionUUID->"a6e8cbb0-f569-4ceb-a161-5224a5a74e35"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[118683, 2582, 176, 3, 50, "Subsection",ExpressionUUID->"3abb11b6-0e3e-4659-bfff-b6e4ed93daa0"],
Cell[118862, 2587, 3184, 79, 204, "Text",ExpressionUUID->"61d6dbe7-f587-4a2d-861d-5bd72462f329"],
Cell[CellGroupData[{
Cell[122071, 2670, 933, 21, 86, "Input",ExpressionUUID->"793b242f-6145-4465-9e12-baae777851b2"],
Cell[123007, 2693, 2733, 49, 101, "Output",ExpressionUUID->"3aed2fca-61d9-470b-9887-b3a6ce17b934"]
}, Open  ]],
Cell[CellGroupData[{
Cell[125777, 2747, 696, 18, 86, "Input",ExpressionUUID->"2d3810ad-710c-4b05-b9f7-2488b30acd79"],
Cell[126476, 2767, 1017, 25, 101, "Output",ExpressionUUID->"e6f377ca-44dc-408a-8637-e282960dea79"]
}, Open  ]],
Cell[127508, 2795, 638, 15, 103, "Text",ExpressionUUID->"a65871fd-2b75-46b8-b0d4-3b8f6cf602d8"],
Cell[128149, 2812, 596, 13, 72, "Text",ExpressionUUID->"8bce497b-a196-4551-ab1b-790b924da603"],
Cell[CellGroupData[{
Cell[128770, 2829, 460, 11, 63, "Input",ExpressionUUID->"cc83693c-dd45-4cb6-9a39-d3ca807546bd"],
Cell[129233, 2842, 2589, 47, 101, "Output",ExpressionUUID->"666dba50-fa79-4a35-9907-2943b983f97a"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[131871, 2895, 178, 3, 50, "Subsection",ExpressionUUID->"94984d4e-1d6a-4942-926c-766c72826662"],
Cell[132052, 2900, 2027, 52, 167, "Text",ExpressionUUID->"81328d03-7318-4e5a-a4c0-ded6f7e01d3c"],
Cell[CellGroupData[{
Cell[134104, 2956, 4734, 117, 537, "Input",ExpressionUUID->"c20f3ee8-263d-44b5-9904-457f4a2e4d56"],
Cell[138841, 3075, 11715, 208, 372, "Output",ExpressionUUID->"be59c8dc-daae-4b5e-883b-fe01505a9478"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[150605, 3289, 256, 3, 95, "Subchapter",ExpressionUUID->"fa5c3c19-9228-4e76-bd56-41d0e5fcc961",
 CellTags->"c:10"],
Cell[150864, 3294, 2004, 51, 164, "Text",ExpressionUUID->"e95f16a2-0a88-4102-b389-ba64fa309a2a"],
Cell[CellGroupData[{
Cell[152893, 3349, 3707, 89, 347, "Input",ExpressionUUID->"3f9feebb-e998-4c6f-bd9b-8bce5c193591"],
Cell[156603, 3440, 3043, 61, 84, "Output",ExpressionUUID->"0d1a8d3a-9a70-41e0-8f6b-b48487621732"]
}, Open  ]],
Cell[159661, 3504, 723, 14, 103, "Text",ExpressionUUID->"e26be4d4-88d8-4e26-b76a-6a0f143a5a31"]
}, Open  ]],
Cell[CellGroupData[{
Cell[160421, 3523, 167, 3, 95, "Subchapter",ExpressionUUID->"44cdee8b-206e-48f6-9264-a90ffd3d95c6"],
Cell[160591, 3528, 1134, 23, 135, "Text",ExpressionUUID->"f737cec4-37d1-4831-9d33-1965e8fe2119"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[161774, 3557, 299, 4, 101, "Chapter",ExpressionUUID->"a72d02c1-4d0c-4859-b900-7c456316807a",
 CellTags->"c:11"],
Cell[162076, 3563, 1138, 32, 103, "Text",ExpressionUUID->"e302ce55-543f-481c-9e13-79d56a4ae834"],
Cell[163217, 3597, 5483, 109, 194, "Text",ExpressionUUID->"a48f160e-1684-401e-a3aa-d4b6f371c2d7"],
Cell[168703, 3708, 1256, 29, 72, "DisplayFormulaNumbered",ExpressionUUID->"75e334be-e1b6-4c01-a995-dfe7294f9f8e"],
Cell[169962, 3739, 654, 13, 103, "Text",ExpressionUUID->"039c120f-4333-4106-885b-537fd523a4e5"],
Cell[CellGroupData[{
Cell[170641, 3756, 345, 7, 63, "Input",ExpressionUUID->"ec136c96-4375-44a8-a302-745bbc5d2137"],
Cell[170989, 3765, 2623, 56, 112, "Output",ExpressionUUID->"f56e37cc-355e-4860-8609-f02a5c0b53fa"]
}, Open  ]],
Cell[CellGroupData[{
Cell[173649, 3826, 2862, 72, 295, "Input",ExpressionUUID->"17701f33-3e3c-42dd-9c7b-fdb6f8f4b767"],
Cell[176514, 3900, 3893, 73, 84, "Output",ExpressionUUID->"0d66a248-f929-470a-a21e-fd007f981cc3"]
}, Open  ]],
Cell[180422, 3976, 231, 6, 72, "Text",ExpressionUUID->"268ca108-0db2-4d58-91c5-569aeb311acb"],
Cell[CellGroupData[{
Cell[180678, 3986, 195, 2, 95, "Subchapter",ExpressionUUID->"7d924a7d-213d-4b77-996e-4b77a2416acf",
 CellTags->"c:12"],
Cell[180876, 3990, 7736, 179, 386, "Text",ExpressionUUID->"c9c6ad4d-0286-4b98-a99a-c1a9553369dd"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[188661, 4175, 461, 6, 101, "Chapter",ExpressionUUID->"919e5e5b-7d8b-4c5f-ab4c-0bcbe514a42c",
 CellTags->"c:13"],
Cell[189125, 4183, 2918, 54, 316, "Text",ExpressionUUID->"6a6e19cf-bb4f-4ebf-92d0-5675f3aa2870"],
Cell[CellGroupData[{
Cell[192068, 4241, 195, 3, 95, "Subchapter",ExpressionUUID->"d04122b3-0bd9-4a07-8e16-0eb62f4778b6"],
Cell[CellGroupData[{
Cell[192288, 4248, 188, 3, 50, "Subsection",ExpressionUUID->"5e29a4bc-2b27-406e-b59f-74db2a413316"],
Cell[192479, 4253, 959, 25, 72, "Text",ExpressionUUID->"1f2ddae9-d226-4854-aaed-3e7270210e2d"],
Cell[CellGroupData[{
Cell[193463, 4282, 907, 18, 126, "Input",ExpressionUUID->"ca2e499b-f00f-4414-9609-b4647b6d10d6"],
Cell[194373, 4302, 2870, 59, 377, "Output",ExpressionUUID->"43aa32eb-add0-4f00-b462-427c4f36bac1"]
}, Open  ]],
Cell[197258, 4364, 1651, 30, 194, "Text",ExpressionUUID->"886d53e2-9c58-42a8-83ba-2c3c50e31a6d"],
Cell[198912, 4396, 1280, 33, 219, "Input",ExpressionUUID->"ea17c6c6-73e8-482d-9173-e74d40acfa12"],
Cell[200195, 4431, 1331, 24, 105, "Text",ExpressionUUID->"bcb70fe7-7930-4e10-aa29-d0c91f15c417"],
Cell[201529, 4457, 1571, 39, 250, "Input",ExpressionUUID->"f8159651-8cde-4010-a415-e872d295ae47"],
Cell[203103, 4498, 307, 5, 72, "Text",ExpressionUUID->"4a6f7e0c-c2e9-4cd8-970a-e86cf976b5a2"],
Cell[CellGroupData[{
Cell[203435, 4507, 2483, 55, 250, "Input",ExpressionUUID->"f2335999-3930-4868-b73a-70aff705e87c"],
Cell[205921, 4564, 51113, 860, 380, 14618, 266, "CachedBoxData", "BoxData", "Output",ExpressionUUID->"ed306d7c-bc07-49f6-9c49-a596a4eb766a"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[257083, 5430, 195, 3, 50, "Subsection",ExpressionUUID->"7a8821b4-9a07-46c9-98b4-e1b96d1ff277"],
Cell[257281, 5435, 555, 12, 72, "Text",ExpressionUUID->"584c671b-5ffb-410f-ae13-1b86b26deaf8"],
Cell[CellGroupData[{
Cell[257861, 5451, 1422, 36, 160, "Input",ExpressionUUID->"29309786-33e3-4d7f-b23c-35b3c9734d36"],
Cell[259286, 5489, 2766, 58, 141, "Output",ExpressionUUID->"b1e148c9-ab4d-4aad-bc54-438c5e043b47"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[262101, 5553, 226, 4, 50, "Subsection",ExpressionUUID->"cabf026b-cd3e-47dc-ac6b-00a40636e98f"],
Cell[262330, 5559, 737, 16, 72, "Text",ExpressionUUID->"a521c716-257a-46bb-93c0-0cb7e74cd04d"],
Cell[263070, 5577, 1012, 33, 77, "DisplayFormula",ExpressionUUID->"8ce8ed38-8005-420e-8673-a164985fab34"],
Cell[264085, 5612, 2587, 68, 225, "Text",ExpressionUUID->"77007d50-8c72-49e2-8ffc-25028cfd6d20"],
Cell[266675, 5682, 880, 34, 38, "DisplayFormula",ExpressionUUID->"ddc70e3c-e350-4b18-b0d8-0e84969e5977"],
Cell[267558, 5718, 3005, 77, 194, "Text",ExpressionUUID->"173108f7-73b5-47f1-ad97-5c2e132d79f4"],
Cell[CellGroupData[{
Cell[270588, 5799, 1590, 34, 66, "Item",ExpressionUUID->"fd6a76be-08c1-4926-a786-56d957ea6dbb"],
Cell[272181, 5835, 1825, 40, 64, "Item",ExpressionUUID->"8fd3a815-7a28-430b-901f-356c01956330"],
Cell[274009, 5877, 1075, 21, 64, "Item",ExpressionUUID->"88c4c2dd-b425-47ef-8c71-edb1850e2691"]
}, Open  ]],
Cell[275099, 5901, 1890, 41, 200, "Text",ExpressionUUID->"3308f821-1e8b-4ae5-b21a-329f44c14a1b"],
Cell[276992, 5944, 2321, 59, 130, "DisplayFormulaNumbered",ExpressionUUID->"23e476e6-a928-4d95-9eec-ebe62c08fd2e"],
Cell[279316, 6005, 311, 9, 72, "Text",ExpressionUUID->"0f3864f6-d0cf-4e57-bf7d-26b4de3792a9"],
Cell[279630, 6016, 2928, 83, 123, "DisplayFormulaNumbered",ExpressionUUID->"e134c690-45ab-4081-a08d-6622b7f509c1"]
}, Open  ]],
Cell[CellGroupData[{
Cell[282595, 6104, 173, 3, 50, "Subsection",ExpressionUUID->"20e5a4b4-841a-4943-8ffd-e4462ff9e392"],
Cell[282771, 6109, 531, 10, 72, "Text",ExpressionUUID->"c6bef0ca-8f63-4549-85c2-b7a696745332"],
Cell[CellGroupData[{
Cell[283327, 6123, 1621, 36, 188, "Input",ExpressionUUID->"119b0dce-ddb9-4f1a-b3bf-f2677c37d430"],
Cell[284951, 6161, 1867, 29, 63, "Output",ExpressionUUID->"c79c95ce-82e9-4c45-a4a9-a868f0ee1005"]
}, Open  ]],
Cell[286833, 6193, 165, 3, 72, "Text",ExpressionUUID->"1547d31a-8f58-4224-8c92-e4055e4c716b"],
Cell[287001, 6198, 696, 17, 126, "Input",ExpressionUUID->"fcd9ad29-609b-4b87-addc-958717781912"],
Cell[287700, 6217, 678, 12, 133, "Text",ExpressionUUID->"2e09cfb4-b1d0-4784-b6b6-471044a2ea96"],
Cell[CellGroupData[{
Cell[288403, 6233, 984, 23, 157, "Input",ExpressionUUID->"98a7f42f-5743-430d-a4cf-7e4a7c2d5065"],
Cell[289390, 6258, 3026, 53, 191, "Output",ExpressionUUID->"8f83364c-c8bb-4955-bb06-da2aeb97f709"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[292465, 6317, 174, 3, 50, "Subsection",ExpressionUUID->"12711458-3802-48cf-a8a9-c0133c3ac7ef"],
Cell[292642, 6322, 1513, 24, 194, "Text",ExpressionUUID->"779cd83e-6865-4894-b584-67ce2ba7c322"],
Cell[CellGroupData[{
Cell[294180, 6350, 3844, 86, 384, "Input",ExpressionUUID->"53ef4ef5-6a1a-4886-bac4-5d1d719b8c26"],
Cell[298027, 6438, 3766, 65, 191, "Output",ExpressionUUID->"a65c159a-0e00-43b1-be28-151913c25528"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[301842, 6509, 228, 4, 50, "Subsection",ExpressionUUID->"cbbfcbf3-b8c1-4ca7-90fa-0cea834ffd35"],
Cell[302073, 6515, 2769, 73, 286, "Text",ExpressionUUID->"e9fb215c-d438-48ee-a6e4-ea2f514ed2a7"],
Cell[304845, 6590, 7191, 165, 715, "Input",ExpressionUUID->"b8eef9f7-1a8b-45ed-9e41-c9550f1c3bd1"]
}, Open  ]],
Cell[CellGroupData[{
Cell[312073, 6760, 161, 3, 50, "Subsection",ExpressionUUID->"81e11b90-d12f-4788-9a5c-479a11b854de"],
Cell[312237, 6765, 3447, 81, 414, "Text",ExpressionUUID->"38dc6e9e-29df-4e27-8994-2e7124c48fb4"],
Cell[CellGroupData[{
Cell[315709, 6850, 13830, 296, 958, "Input",ExpressionUUID->"41b77482-27f2-4c90-b765-448121521c46"],
Cell[329542, 7148, 7711, 149, 615, "Output",ExpressionUUID->"17d03fd0-307c-4e11-8859-82aef3eead13"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[337314, 7304, 262, 4, 95, "Subchapter",ExpressionUUID->"8a090d5c-2e53-4773-be11-04b6147a0d55"],
Cell[337579, 7310, 1917, 33, 225, "Text",ExpressionUUID->"022dc5da-694c-4d7d-b66d-84c771de4860"],
Cell[CellGroupData[{
Cell[339521, 7347, 13464, 279, 677, "Input",ExpressionUUID->"c502f911-698b-4b59-b300-a3375e19d774"],
Cell[352988, 7628, 7270, 141, 615, "Output",ExpressionUUID->"ce685066-8dc7-4a07-b313-970b96fccad8"]
}, Open  ]],
Cell[CellGroupData[{
Cell[360295, 7774, 229, 4, 50, "Subsection",ExpressionUUID->"d4c02f95-4b36-4a00-abe3-96d6b2e858e1"],
Cell[360527, 7780, 2274, 46, 197, "Text",ExpressionUUID->"a2af6572-cbe8-4201-be03-067fcaddce09"],
Cell[CellGroupData[{
Cell[362826, 7830, 12296, 256, 914, "Input",ExpressionUUID->"f3eab681-e533-4cec-8155-72b04604e909"],
Cell[375125, 8088, 5400, 103, 398, "Output",ExpressionUUID->"349a2574-c09e-4c9c-9ffd-7e11fcdb7f7c"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[380574, 8197, 259, 4, 50, "Subsection",ExpressionUUID->"e6b7bebe-e457-4cf4-9ba3-0618afcaecde"],
Cell[380836, 8203, 1005, 16, 133, "Text",ExpressionUUID->"0baf8cfa-14b7-4fe0-93bb-e184e7fdd49d"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[381902, 8226, 181, 2, 101, "Chapter",ExpressionUUID->"5c7c5664-b41c-4b04-8932-015a8fb21123",
 CellTags->"c:14"],
Cell[382086, 8230, 1744, 44, 103, "Text",ExpressionUUID->"7d62442d-2662-4b69-bb4b-eb7121fd4b2b"],
Cell[CellGroupData[{
Cell[383855, 8278, 241, 3, 95, "Subchapter",ExpressionUUID->"745a88e4-3128-451b-92f3-e1940cb4b2c0",
 CellTags->"c:15"],
Cell[CellGroupData[{
Cell[384121, 8285, 167, 3, 50, "Subsection",ExpressionUUID->"9e2e803a-3851-417d-bf3f-1b356271afcd"],
Cell[384291, 8290, 1738, 40, 133, "Text",ExpressionUUID->"aca499ee-d424-47ba-91c1-6bb9f604563c"],
Cell[386032, 8332, 766, 20, 72, "DisplayFormulaNumbered",ExpressionUUID->"fbc1f348-e782-4ff1-90e1-ccf062fc867d"],
Cell[386801, 8354, 698, 18, 38, "DisplayFormulaNumbered",ExpressionUUID->"5d418c7f-7bc8-4633-91e0-275c4509b20d"],
Cell[387502, 8374, 907, 25, 72, "DisplayFormulaNumbered",ExpressionUUID->"0ea5cab6-cb7c-4a44-a0f5-bccb50c127c2"],
Cell[388412, 8401, 347, 7, 72, "Text",ExpressionUUID->"a48a2e34-f742-4913-8ca2-02d091ae3b19"],
Cell[388762, 8410, 653, 17, 72, "DisplayFormulaNumbered",ExpressionUUID->"133ba4e4-702d-47d3-ae43-f290227a85c1"],
Cell[389418, 8429, 616, 19, 49, "DisplayFormulaNumbered",ExpressionUUID->"2955cca1-e387-448b-bcdb-740aa86252c1"]
}, Open  ]],
Cell[CellGroupData[{
Cell[390071, 8453, 168, 3, 50, "Subsection",ExpressionUUID->"f7e8e836-c281-4b13-9f64-b689453a2045"],
Cell[390242, 8458, 3402, 73, 194, "Text",ExpressionUUID->"6d995139-a278-45a3-8244-07749a96e64b"],
Cell[CellGroupData[{
Cell[393669, 8535, 1866, 39, 129, "Input",ExpressionUUID->"28b65850-0064-473e-9482-c7728bf05d4a"],
Cell[395538, 8576, 8075, 212, 256, "Output",ExpressionUUID->"106b9f47-9363-47db-94f5-1f12265a592c"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[403662, 8794, 159, 3, 50, "Subsection",ExpressionUUID->"fc979955-7f91-4dd4-aac0-6bf050fb0365"],
Cell[403824, 8799, 387, 6, 72, "Text",ExpressionUUID->"8b75787c-e946-4efe-87fe-d79c56d3d80b"],
Cell[404214, 8807, 1859, 43, 157, "Input",ExpressionUUID->"48d3e8ca-9708-495b-a0e7-6ff895bff3ae"]
}, Open  ]],
Cell[CellGroupData[{
Cell[406110, 8855, 160, 3, 50, "Subsection",ExpressionUUID->"7f14bb9f-1bbf-482f-a2d0-e4e99dbf491f"],
Cell[406273, 8860, 306, 5, 72, "Text",ExpressionUUID->"b35de153-6b3f-47c6-abbc-f4605aa4ae33"],
Cell[406582, 8867, 3903, 70, 250, "Input",ExpressionUUID->"54f13db1-d65c-44c7-a28b-58b1ef97b0ff"]
}, Open  ]],
Cell[CellGroupData[{
Cell[410522, 8942, 339, 5, 50, "Subsection",ExpressionUUID->"6c94572c-7e03-4c46-8136-06d0c2475616"],
Cell[410864, 8949, 2060, 54, 143, "Text",ExpressionUUID->"5c514ede-5b30-4407-8784-9cc4422a30d9"],
Cell[CellGroupData[{
Cell[412949, 9007, 290, 5, 48, "Subsubsection",ExpressionUUID->"4168dfd3-c582-479d-8fe3-6e245ab90b08"],
Cell[413242, 9014, 1359, 31, 138, "Text",ExpressionUUID->"670c63d7-680c-413c-b1fe-67528e14a146"],
Cell[CellGroupData[{
Cell[414626, 9049, 12126, 213, 664, "Input",ExpressionUUID->"8c0807b6-1cc7-4f40-b93c-0ca462262062"],
Cell[426755, 9264, 4993, 90, 954, "Output",ExpressionUUID->"cbc6ff77-4055-438f-b672-1494d6ab9d88"]
}, Open  ]],
Cell[431763, 9357, 5484, 145, 492, "Text",ExpressionUUID->"9d415275-e924-4701-9e69-d3a0fa17870e"],
Cell[437250, 9504, 3453, 82, 453, "Input",ExpressionUUID->"0c528889-9a88-42b3-b34d-187b989c26be"],
Cell[CellGroupData[{
Cell[440728, 9590, 21198, 423, 1094, "Input",ExpressionUUID->"daf34d48-70c5-4161-9b91-805d3b5d8479"],
Cell[461929, 10015, 10779, 203, 689, "Output",ExpressionUUID->"2c728718-13f7-486a-8a98-0d07d9ef72ad"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[472757, 10224, 186, 3, 48, "Subsubsection",ExpressionUUID->"4336228a-36c1-403e-9e47-bdc1e8420710"],
Cell[472946, 10229, 1901, 55, 138, "Text",ExpressionUUID->"de36e4fe-9e51-407a-b8b5-d391384bf05d"],
Cell[CellGroupData[{
Cell[474872, 10288, 14013, 256, 590, "Input",ExpressionUUID->"f523199a-8693-49fb-9687-72bb3bdaf9af"],
Cell[488888, 10546, 6661, 134, 719, "Output",ExpressionUUID->"23f6e226-fcd8-4ace-9d5a-61ef17b63e02"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[495610, 10687, 223, 4, 50, "Subsection",ExpressionUUID->"0f5271c6-1a4d-43b6-add2-f90ac417363f"],
Cell[495836, 10693, 1513, 35, 138, "Text",ExpressionUUID->"88e0b2c9-5a0a-4814-9155-5e2b40ce58ec"],
Cell[497352, 10730, 202, 3, 63, "Input",ExpressionUUID->"d46e1f83-0d62-4aa9-a485-77b63b6e0000"],
Cell[CellGroupData[{
Cell[497579, 10737, 12097, 216, 452, "Input",ExpressionUUID->"e38ec606-c377-4c8f-9073-9d7aa5f8da17"],
Cell[509679, 10955, 4796, 100, 562, "Output",ExpressionUUID->"f1e1e0a9-d154-49f5-be60-0f1895183d8b"]
}, Open  ]],
Cell[514490, 11058, 1211, 30, 72, "Text",ExpressionUUID->"86f22a65-52af-43d7-9c9e-9a478716cfd4"],
Cell[515704, 11090, 1419, 35, 163, "Input",ExpressionUUID->"eb275326-2c0a-4c89-a365-8e286549f53e"],
Cell[517126, 11127, 2992, 80, 111, "Text",ExpressionUUID->"b6b03868-5043-45c1-b57b-2154f2462fdc"],
Cell[CellGroupData[{
Cell[520143, 11211, 18561, 374, 1068, "Input",ExpressionUUID->"c1abac75-c82f-4b71-8d8e-2ff33722210e"],
Cell[538707, 11587, 8484, 160, 615, "Output",ExpressionUUID->"379bab10-22e3-4332-96f6-1fa8f34b19bb"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[547264, 11755, 284, 4, 101, "Chapter",ExpressionUUID->"5af8943a-1d98-47e8-b4ff-da1344057eab"],
Cell[547551, 11761, 649, 15, 103, "Text",ExpressionUUID->"abe0b5d5-726c-4254-9d16-98a13687b90f"],
Cell[548203, 11778, 2049, 74, 77, "DisplayFormulaNumbered",ExpressionUUID->"8e4f2c5a-7da8-499f-a742-402cba9cce8a"],
Cell[550255, 11854, 466, 12, 72, "Text",ExpressionUUID->"a1c1052e-aa50-47f7-968e-ca0e07eccaf7"],
Cell[550724, 11868, 3213, 88, 2268, "Text",ExpressionUUID->"4cfa08b7-0988-4c0c-ba5f-0c0346e0ba24"],
Cell[553940, 11958, 607, 16, 133, "Text",ExpressionUUID->"1076e4c9-7c82-4536-8edd-64eb364990cf"],
Cell[554550, 11976, 1443, 22, 1211, "Input",ExpressionUUID->"169b56db-b515-4771-b03f-e2a9f1e04df3"],
Cell[CellGroupData[{
Cell[556018, 12002, 1046, 21, 157, "Input",ExpressionUUID->"e149a6d5-9ef6-4090-aeae-80012f977d84"],
Cell[557067, 12025, 2346, 57, 101, "Output",ExpressionUUID->"2dcf377e-829e-4126-a1d6-5cb846a46f85"]
}, Open  ]],
Cell[559428, 12085, 233, 6, 72, "Text",ExpressionUUID->"667c3c2c-592e-422c-baea-3c034932719c"],
Cell[559664, 12093, 280, 5, 63, "Input",ExpressionUUID->"2ce77940-b330-44d6-8d55-bc774893aee3"],
Cell[CellGroupData[{
Cell[559969, 12102, 873, 16, 95, "Input",ExpressionUUID->"6cbedc95-cf6d-4775-ad6e-7db918530cdb"],
Cell[560845, 12120, 827, 20, 86, "Output",ExpressionUUID->"a6e540d9-7636-4e9f-adcc-e234ac96fe22"]
}, Open  ]],
Cell[CellGroupData[{
Cell[561709, 12145, 337, 6, 63, "Input",ExpressionUUID->"cf5889c3-2420-4917-9118-7e67b1006b44"],
Cell[562049, 12153, 601, 12, 63, "Output",ExpressionUUID->"b20e743a-0ca1-4211-bb5e-d9ea44b7dcef"]
}, Open  ]],
Cell[CellGroupData[{
Cell[562687, 12170, 473, 8, 63, "Input",ExpressionUUID->"b69312e1-2f62-4d00-ad40-5968ae777c40"],
Cell[563163, 12180, 625, 12, 63, "Output",ExpressionUUID->"90857ecd-997f-4c67-bc6b-df38b712d05f"]
}, Open  ]],
Cell[563803, 12195, 229, 4, 63, "Input",ExpressionUUID->"0e67108f-6a82-4885-ae10-9fe12d7844b9"],
Cell[CellGroupData[{
Cell[564057, 12203, 329, 6, 63, "Input",ExpressionUUID->"ee944917-9e77-48c0-af5c-9b5b5d57192d"],
Cell[564389, 12211, 839, 20, 66, "Output",ExpressionUUID->"2d4b7162-21ee-49fb-b9d0-df276a185d0f"]
}, Open  ]],
Cell[CellGroupData[{
Cell[565265, 12236, 748, 21, 65, "Input",ExpressionUUID->"b29623ea-ed8e-4483-9efc-f8502196c9ac"],
Cell[566016, 12259, 702, 18, 66, "Output",ExpressionUUID->"2cfb4f65-5482-4b45-b30e-2bfba555b8cd"]
}, Open  ]],
Cell[566733, 12280, 615, 10, 63, "Input",ExpressionUUID->"dd573627-4eb1-4feb-a213-700e3593b95f"],
Cell[CellGroupData[{
Cell[567373, 12294, 889, 17, 250, "Input",ExpressionUUID->"97a58270-440a-416a-9abb-630a8d969805"],
Cell[568265, 12313, 1195, 27, 126, "Output",ExpressionUUID->"177ea6c9-6445-45ac-bc91-6c82dfd7892c"]
}, Open  ]],
Cell[CellGroupData[{
Cell[569497, 12345, 691, 15, 95, "Input",ExpressionUUID->"d7e92687-5f6e-42ff-9229-2ad97494578d"],
Cell[570191, 12362, 796, 17, 63, "Output",ExpressionUUID->"bf01628e-6401-48c5-8ee9-ae557b8bb6cb"],
Cell[570990, 12381, 867, 18, 80, "Output",ExpressionUUID->"e59bb34b-e18d-4ba1-a986-de4ba867a4bb"]
}, Open  ]],
Cell[CellGroupData[{
Cell[571894, 12404, 778, 18, 95, "Input",ExpressionUUID->"be8f6eaa-38d2-40cb-b095-2eb4cde90528"],
Cell[572675, 12424, 792, 18, 80, "Output",ExpressionUUID->"cdf131bd-ccbe-482f-afac-69ac71bdcbf3"],
Cell[573470, 12444, 1517, 32, 231, "Output",ExpressionUUID->"42eddfe0-9025-4fbb-bd7b-77c20ff461c0"]
}, Open  ]],
Cell[575002, 12479, 472, 13, 63, "Input",ExpressionUUID->"2f1446d3-f5a8-4edc-9901-9382f8dfbae1"],
Cell[575477, 12494, 1263, 33, 357, "Input",ExpressionUUID->"fd55cbce-4aae-47cf-8ea7-f6d5e3b132ee"],
Cell[576743, 12529, 626, 18, 95, "Input",ExpressionUUID->"540961b9-bcf2-4b59-8a2c-636d3816a621"],
Cell[577372, 12549, 189, 3, 72, "Text",ExpressionUUID->"dccbe074-3f38-4f74-99fa-85c2d9532358"],
Cell[577564, 12554, 3864, 96, 405, "Input",ExpressionUUID->"b0ae9a4e-5e3b-43e3-bbf0-5441c22aa721"],
Cell[CellGroupData[{
Cell[581453, 12654, 509, 14, 63, "Input",ExpressionUUID->"d013f766-a5f7-42ec-9b52-dcced2d67443"],
Cell[581965, 12670, 8020, 189, 527, "Output",ExpressionUUID->"9cda0d53-d70e-4060-bd5b-672b68efa101"]
}, Open  ]],
Cell[CellGroupData[{
Cell[590022, 12864, 5289, 133, 889, "Input",ExpressionUUID->"75fcbd46-a315-4c7c-8817-a2ceda0486e7"],
Cell[595314, 12999, 4909, 100, 606, "Output",ExpressionUUID->"e5fc4826-4991-415d-9004-0384bfd31d36"]
}, Open  ]],
Cell[600238, 13102, 237, 6, 72, "Text",ExpressionUUID->"513cde9e-93cf-41be-8691-ee862b17f15c"]
}, Open  ]],
Cell[CellGroupData[{
Cell[600512, 13113, 157, 3, 101, "Chapter",ExpressionUUID->"86809f6e-d10a-4415-bfb6-1622acbaa2d7"],
Cell[600672, 13118, 957, 16, 225, "Text",ExpressionUUID->"71c98aaa-f00d-4a00-b47a-97d458816116"]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature txpuP0pUUi00xBgqP4#e5dHl *)
