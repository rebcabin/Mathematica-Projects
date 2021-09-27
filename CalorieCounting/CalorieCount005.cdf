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
NotebookDataLength[    790827,      19862]
NotebookOptionsPosition[    771004,      19257]
NotebookOutlinePosition[    774593,      19379]
CellTagsIndexPosition[    773829,      19351]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["\<\
Symbolically Weaving in the Cloud with Jacquard\
\>", "Title",
 CellChangeTimes->{{3.5433472697937155`*^9, 3.5433472803627725`*^9}, {
   3.543497087314685*^9, 3.54349708844191*^9}, 3.553736099422689*^9, {
   3.5538643687980814`*^9, 3.5538643805042515`*^9}}],

Cell["\<\
or \"Why Symbolic Computing Matters\"\
\>", "Title",
 CellChangeTimes->{{3.553555019113377*^9, 3.5535550446465178`*^9}, 
   3.55373607793456*^9}],

Cell["\<\
Brian Beckman, Erik Meijer
REVIEW DRAFT 13 Aug 2012\
\>", "Subtitle",
 CellChangeTimes->{{3.54334808141787*^9, 3.543348093338062*^9}, {
  3.5535435790719748`*^9, 3.5535435802143908`*^9}, {3.553868543809453*^9, 
  3.5538685543905106`*^9}}],

Cell[CellGroupData[{

Cell["INTRODUCTION AND ABSTRACT", "Section",
 CellChangeTimes->{{3.543490786086527*^9, 3.543490788989527*^9}, {
  3.5434962552207155`*^9, 3.543496256780716*^9}, {3.5537359421626368`*^9, 
  3.553735947090057*^9}}],

Cell[TextData[{
 "We show plausible application code -- counting calories -- that a web \
developer might write using Jacquard, a term-rewriting system in pure \
JavaScript that runs both in the browser and in the server. We show how \
Jacquard\[CloseCurlyQuote]s ",
 StyleBox["symbolic computing",
  FontSlant->"Italic"],
 " makes the code ",
 StyleBox["shorter",
  FontSlant->"Italic"],
 ", more ",
 StyleBox["flexible",
  FontSlant->"Italic"],
 ", more ",
 StyleBox["robust",
  FontSlant->"Italic"],
 "; easier to ",
 StyleBox["create",
  FontSlant->"Italic"],
 ", to ",
 StyleBox["understand",
  FontSlant->"Italic"],
 ", to ",
 StyleBox["modify",
  FontSlant->"Italic"],
 ", and to ",
 StyleBox["reuse",
  FontSlant->"Italic"],
 " than the equivalent computation written in ordinary JavaScript. We \
motivate ",
 ButtonBox["Wolfram Research\[CloseCurlyQuote]s ",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://www.wolfram.com/mathematica/"], None},
  ButtonNote->"http://www.wolfram.com/mathematica/"],
 StyleBox[ButtonBox["Mathematica",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://www.wolfram.com/mathematica/"], None},
  ButtonNote->"http://www.wolfram.com/mathematica/"],
  FontSlant->"Italic"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["1"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{"www", ".", "wolfram", ".", "com"}], "/", "mathematica"}], 
         "/"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00002765"],
 "] as an ",
 ButtonBox["Integrated Development Environment (IDE)",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikipedia.org/wiki/Integrated_development_environment"], 
    None},
  ButtonNote->
   "http://en.wikipedia.org/wiki/Integrated_development_environment"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["2"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/",
            "Integrated_development"}], "_environment"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"0000381F"],
 "] for Jacquard expressions. "
}], "Text",
 CellChangeTimes->{{3.543489448856917*^9, 3.5434895271052155`*^9}, {
   3.543489558004305*^9, 3.5434896583593397`*^9}, {3.543489696785182*^9, 
   3.5434897117056737`*^9}, {3.5434898223437366`*^9, 
   3.5434898225617585`*^9}, {3.5434901071205273`*^9, 3.543490109879527*^9}, {
   3.543490314973527*^9, 3.543490324829527*^9}, {3.543497092867795*^9, 
   3.543497112720765*^9}, {3.5435005183273015`*^9, 3.5435005292383013`*^9}, {
   3.5435167922891517`*^9, 3.543516815467469*^9}, {3.543517097449665*^9, 
   3.5435171510430236`*^9}, {3.5435171907669954`*^9, 
   3.5435172204009585`*^9}, {3.5435251390440116`*^9, 
   3.5435251397480116`*^9}, {3.543543955419191*^9, 3.5435439615095396`*^9}, {
   3.553542952828911*^9, 3.5535429545262833`*^9}, {3.553543025607067*^9, 
   3.553543054635724*^9}, 3.5535431475231256`*^9, {3.553543850720503*^9, 
   3.5535438607661057`*^9}, {3.553734618369569*^9, 3.553734721514386*^9}, {
   3.5537348120730133`*^9, 3.553734845048362*^9}, {3.5537349572230053`*^9, 
   3.553734957223946*^9}, {3.553734996983789*^9, 3.553735004220722*^9}, {
   3.553735049007221*^9, 3.553735109061367*^9}, 3.553736917409227*^9, 
   3.553766665661021*^9, {3.5537676932540293`*^9, 3.5537677008692703`*^9}, {
   3.553767818292099*^9, 3.5537678231247463`*^9}, {3.553767856357368*^9, 
   3.5537678792505827`*^9}, {3.553767914899302*^9, 3.553768031142152*^9}, {
   3.553768079759573*^9, 3.553768079835754*^9}, {3.55376811092181*^9, 
   3.553768110997924*^9}, {3.553768314998106*^9, 3.5537683150742817`*^9}, {
   3.553768405446703*^9, 3.553768405567556*^9}, {3.553768444038539*^9, 
   3.553768444120682*^9}, {3.553768786348463*^9, 3.553768786426252*^9}, {
   3.553768837012477*^9, 3.5537688370846167`*^9}, {3.5537692294889708`*^9, 
   3.553769229566683*^9}, {3.553769267873508*^9, 3.553769267957082*^9}, {
   3.553769303351275*^9, 3.5537693034876833`*^9}, {3.5537694494433126`*^9, 
   3.5537694495234737`*^9}, {3.553769620895492*^9, 3.5537696209704437`*^9}, {
   3.553769906321075*^9, 3.5537699063910437`*^9}, {3.553770156667252*^9, 
   3.553770156746962*^9}, {3.553770415675831*^9, 3.553770415759657*^9}, {
   3.553770805499217*^9, 3.553770805579299*^9}, {3.553772595438017*^9, 
   3.553772595514083*^9}, {3.5537735618309507`*^9, 3.553773561974641*^9}, {
   3.5537736098230667`*^9, 3.5537736098958673`*^9}, {3.553783666533195*^9, 
   3.553783673583898*^9}, {3.553783867787415*^9, 3.553783867878215*^9}, {
   3.553799065462777*^9, 3.5537990655338984`*^9}, {3.553799108510713*^9, 
   3.553799108591894*^9}}],

Cell[TextData[{
 "Symbolic computation enables, amongst other capabilities, robust ",
 ButtonBox["units conversion",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://physics.nist.gov/Pubs/SP811/appenB.html"], None},
  ButtonNote->"http://physics.nist.gov/Pubs/SP811/appenB.html"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["3"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"physics", ".", "nist", ".", "gov"}], "/", "Pubs"}], "/",
            "SP811"}], "/", 
         RowBox[{"appenB", ".", "html"}]}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00003589"],
 "]. This lets our developer catch certain misleading bits of consumer \
information in a ",
 Cell[BoxData[
  FormBox[
   ButtonBox[
    RowBox[{"Nutrition", " ", "Facts", " ", "Label"}],
    BaseStyle->"Hyperlink",
    ButtonData->{
      URL[
      "http://www.fda.gov/Food/ResourcesForYou/Consumers/NFLPM/ucm274593.htm"]\
, None},
    ButtonNote->
     "http://www.fda.gov/Food/ResourcesForYou/Consumers/NFLPM/ucm274593.htm"],
    TraditionalForm]]],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["4"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{
               RowBox[{
                 RowBox[{"www", ".", "fda", ".", "gov"}], "/", "Food"}], "/", 
               "ResourcesForYou"}], "/", "Consumers"}], "/", "NFLPM"}], "/", 
         RowBox[{"ucm274593", ".", "htm"}]}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"000047E5"],
 "]. Such units conversions are not possible in JavaScript without a symbolic \
computing facility essentially equivalent to Jacquard\[CloseCurlyQuote]s \
method of ",
 ButtonBox["term rewriting",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://rewriting.loria.fr/"], None},
  ButtonNote->"http://rewriting.loria.fr/"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["5"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{"rewriting", ".", "loria", ".", "fr"}], "/"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00001EB5"],
 "]. We finally construct a Nutrition Facts Label on-the-fly from unit \
ingredients and a previously unknown recipe. This turns out to be a sum in a \
vector space with basis vectors spanning the Nutrition Facts Labels of \
ingredients. We demonstrate multilevel pattern-matching to make the code \
concise. We also motivate remote evaluation of expressions in this scenario: \
bringing the computation to the data can be much cheaper than bringing the \
data to the computation."
}], "Text",
 CellChangeTimes->{{3.543489448856917*^9, 3.5434895271052155`*^9}, {
   3.543489558004305*^9, 3.5434896583593397`*^9}, {3.543489696785182*^9, 
   3.5434897117056737`*^9}, {3.5434898223437366`*^9, 
   3.5434898225617585`*^9}, {3.5434901071205273`*^9, 3.543490109879527*^9}, {
   3.543490314973527*^9, 3.543490324829527*^9}, {3.543497092867795*^9, 
   3.543497112720765*^9}, {3.5435005183273015`*^9, 3.5435005292383013`*^9}, {
   3.5435167922891517`*^9, 3.543516815467469*^9}, {3.543517097449665*^9, 
   3.543517176460565*^9}, {3.543517229543873*^9, 3.54351726452137*^9}, {
   3.5435252756690116`*^9, 3.5435253084110117`*^9}, {3.5535431710808773`*^9, 
   3.553543198640067*^9}, {3.5535434304266863`*^9, 3.553543436130147*^9}, {
   3.553543497684866*^9, 3.553543497685707*^9}, {3.553733548283246*^9, 
   3.553733560598687*^9}, {3.553733708534915*^9, 3.553733725406501*^9}, {
   3.5537337643266277`*^9, 3.553733767511065*^9}, {3.553734759502413*^9, 
   3.5537347811901093`*^9}, {3.553735167269149*^9, 3.553735175844635*^9}, {
   3.553736259713982*^9, 3.553736264043817*^9}, {3.553736331402186*^9, 
   3.553736331403159*^9}, 3.553739876127345*^9, {3.55376671946626*^9, 
   3.553766736298057*^9}, {3.553766807746571*^9, 3.553766931124003*^9}, {
   3.553766961138114*^9, 3.55376703797771*^9}, {3.553767708109344*^9, 
   3.553767737127391*^9}, {3.5537680630789433`*^9, 3.553768111082312*^9}, {
   3.553768292390995*^9, 3.55376831520737*^9}, {3.553768405598393*^9, 
   3.5537684058359623`*^9}, {3.553768444125276*^9, 3.5537684442594547`*^9}, {
   3.5537687864596567`*^9, 3.55376878667752*^9}, {3.553768837121552*^9, 
   3.553768837335452*^9}, {3.5537692296026697`*^9, 3.553769229820072*^9}, {
   3.553769267993775*^9, 3.5537692682238092`*^9}, {3.55376930351723*^9, 
   3.5537693037380743`*^9}, {3.553769449556919*^9, 3.5537694497705097`*^9}, {
   3.553769621005303*^9, 3.5537696212231903`*^9}, {3.5537699064215107`*^9, 
   3.553769906645607*^9}, {3.5537701567808104`*^9, 3.553770157017332*^9}, {
   3.553770415792589*^9, 3.553770416009001*^9}, {3.553770805612237*^9, 
   3.553770805828539*^9}, {3.5537725955521584`*^9, 3.5537725957675743`*^9}, {
   3.553773562010607*^9, 3.553773562225647*^9}, {3.553773609930106*^9, 
   3.553773610145694*^9}, {3.553783666685485*^9, 3.553783673835209*^9}, {
   3.5537838679148083`*^9, 3.553783868146678*^9}, {3.553799065567356*^9, 
   3.553799065757762*^9}, {3.5537991086251*^9, 3.553799108843133*^9}, {
   3.5538642787637634`*^9, 3.553864291412763*^9}}],

Cell[TextData[{
 "We point out that symbolic computing is not exotic. Even though ordinary \
JavaScript programmers might not write symbolic-processing code every day, \
they use symbolic processing every time they edit, compile, interpret, or \
debug their code. Historically, symbolic computing has been a \
mission-critical, if invisible, part of real-world, multi-billion-dollar \
operating system kernels for tasks such as ",
 ButtonBox["network and driver configuration",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://www.redditmirror.cc/cache/websites/web.archive.org_84624/web.\
archive.org/web/20040603192757/research.microsoft.com/research/dtg/davidhov/\
pap.htm"], None},
  ButtonNote->
   "http://www.redditmirror.cc/cache/websites/web.archive.org_84624/web.\
archive.org/web/20040603192757/research.microsoft.com/research/dtg/davidhov/\
pap.htm"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["6"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{
               RowBox[{"www", ".", "redditmirror", ".", "cc"}], "/", 
               "cache"}], "/", "websites"}], "/", 
           RowBox[{"web", ".", "archive", ".", "org_"}]}], 
         RowBox[{
           RowBox[{
             RowBox[{
               RowBox[{
                 RowBox[{
                   RowBox[{
                    RowBox[{
                    RowBox[{"84624", "/", 
                    RowBox[{"web", ".", "archive", ".", "org"}]}], "/", 
                    "web"}], "/", "20040603192757"}], "/", 
                   RowBox[{"research", ".", "microsoft", ".", "com"}]}], "/", 
                 "research"}], "/", "dtg"}], "/", "davidhov"}], "/", 
           RowBox[{"pap", ".", "htm"}]}]}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00009BEE"],
 "] and ",
 ButtonBox["dynamic security policy evaluation",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://secpal.codeplex.com/"], None},
  ButtonNote->"http://secpal.codeplex.com/"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["7"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{"secpal", ".", "codeplex", ".", "com"}], "/"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00001EF6"],
 "]."
}], "Text",
 CellChangeTimes->{{3.5537348886226187`*^9, 3.5537348912864237`*^9}, 
   3.553735136739355*^9, {3.553735206931134*^9, 3.5537353225854893`*^9}, {
   3.553735434569192*^9, 3.553735434570157*^9}, {3.5537355933069983`*^9, 
   3.553735645054634*^9}, {3.553735747521345*^9, 3.553735749049904*^9}, {
   3.553736373175392*^9, 3.5537364998880787`*^9}, {3.553736597457369*^9, 
   3.553736611993626*^9}, {3.553767053200766*^9, 3.5537670622240334`*^9}, {
   3.553767104358918*^9, 3.553767182638425*^9}, {3.553767262132924*^9, 
   3.553767369753523*^9}, {3.553767402292897*^9, 3.553767453883477*^9}, {
   3.5537674955544643`*^9, 3.5537675338738213`*^9}, {3.553768367276905*^9, 
   3.553768405917495*^9}, {3.553768444034775*^9, 3.553768469218492*^9}, {
   3.55376878670862*^9, 3.553768786791238*^9}, {3.553768837372411*^9, 
   3.553768837465869*^9}, {3.553769229868864*^9, 3.553769229966065*^9}, {
   3.55376926825883*^9, 3.553769268339921*^9}, {3.553769303774448*^9, 
   3.5537693038544683`*^9}, {3.553769449809761*^9, 3.5537694498910313`*^9}, {
   3.553769621257341*^9, 3.553769621341014*^9}, {3.553769906695822*^9, 
   3.553769906776963*^9}, {3.553770157064823*^9, 3.553770157161145*^9}, {
   3.553770416045952*^9, 3.5537704161267443`*^9}, {3.5537708058625813`*^9, 
   3.553770805928791*^9}, {3.553772595803443*^9, 3.553772595885016*^9}, {
   3.553773562259576*^9, 3.553773562340024*^9}, {3.553773610179771*^9, 
   3.553773610263681*^9}, {3.553783666968018*^9, 3.553783674001523*^9}, {
   3.553783868180879*^9, 3.553783868278667*^9}, {3.553799065789227*^9, 
   3.553799065853331*^9}, {3.553799108874247*^9, 3.553799108943721*^9}, {
   3.553864315405763*^9, 3.5538643338107634`*^9}}],

Cell["\<\
The broader point is that symbolic computing is an under-appreciated \
technology, routinely applied \"under the radar\" for many decades but \
certainly ripe for much broader use in the mainstream cloud programming. \
\>", "Text",
 CellChangeTimes->{{3.5537348886226187`*^9, 3.5537348912864237`*^9}, 
   3.553735136739355*^9, {3.553735206931134*^9, 3.5537353225854893`*^9}, {
   3.553735434569192*^9, 3.553735434570157*^9}, {3.5537355933069983`*^9, 
   3.553735645054634*^9}, {3.553735747521345*^9, 3.553735749049904*^9}, {
   3.553736373175392*^9, 3.5537364998880787`*^9}, {3.553736597457369*^9, 
   3.553736611993626*^9}, {3.553767053200766*^9, 3.5537670622240334`*^9}, {
   3.553767104358918*^9, 3.553767182638425*^9}, {3.553767262132924*^9, 
   3.553767369753523*^9}, {3.553767402292897*^9, 3.553767453883477*^9}, {
   3.5537674955544643`*^9, 3.5537675338738213`*^9}, {3.553767570969123*^9, 
   3.553767572616742*^9}, {3.553767606374414*^9, 3.5537676135674057`*^9}, {
   3.553864347660968*^9, 3.5538643528824897`*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["ALICE CHECKS THE DATA", "Section",
 CellChangeTimes->{{3.543490767143527*^9, 3.543490795621527*^9}, {
  3.5434964074767156`*^9, 3.543496408716716*^9}, {3.5538644735705576`*^9, 
  3.5538644813203325`*^9}}],

Cell["\<\
Consider the following Nutrition Facts Label, mined at random from the web, \
which purports to record, for a hamburger patty, the nutritional component \
breakdown (fat / protein / carbs) and the calorie proportions for each \
component.\
\>", "Text",
 CellChangeTimes->{{3.5434882498291464`*^9, 3.5434882665321465`*^9}, {
  3.5434883420081463`*^9, 3.5434883520731463`*^9}, {3.5434884646111465`*^9, 
  3.5434884703941464`*^9}, {3.543488527175146*^9, 3.5434885517661467`*^9}, {
  3.543488710062146*^9, 3.5434887468841467`*^9}, {3.5434888072261467`*^9, 
  3.5434888310791464`*^9}, {3.543489097268941*^9, 3.5434890973650084`*^9}, {
  3.5434897948299856`*^9, 3.5434898056310654`*^9}, {3.5434907035145273`*^9, 
  3.543490712466527*^9}, {3.543500966970341*^9, 3.543500966971341*^9}, {
  3.5435440666025505`*^9, 3.5435440899628863`*^9}, {3.553543621719109*^9, 
  3.553543642197496*^9}, {3.5537676646161222`*^9, 3.553767680005641*^9}}],

Cell["\<\
Our developer, let\[CloseCurlyQuote]s call her Alice, wants to write some \
analytics over this data to find out if it\[CloseCurlyQuote]s accurate. Alice\
\[CloseCurlyQuote]s questions are the following:\
\>", "Text",
 CellChangeTimes->{{3.543489103009957*^9, 3.5434891146801205`*^9}, {
  3.543489808455348*^9, 3.543489813825885*^9}, {3.543489991485527*^9, 
  3.543490091457527*^9}, {3.5434907263375273`*^9, 3.543490734520527*^9}, {
  3.5434932315556417`*^9, 3.5434932436278486`*^9}, {3.543514830190962*^9, 
  3.5435148386308055`*^9}, {3.55354366136798*^9, 3.55354368172042*^9}}],

Cell[CellGroupData[{

Cell["\<\
Does the calorie total implied by the breakdown match the calorie count \
presented in the \[OpenCurlyDoubleQuote]amount per serving?\
\[CloseCurlyDoubleQuote]\
\>", "Item",
 CellChangeTimes->{{3.5435148887138133`*^9, 3.5435149285387955`*^9}, {
  3.5435442149530354`*^9, 3.5435442169761515`*^9}, {3.5535436944604197`*^9, 
  3.553543696652686*^9}, {3.553768532890092*^9, 3.5537685341203957`*^9}}],

Cell["\<\
Does the total weight implied by the breakdown match the total weight \
presented in the \[OpenCurlyDoubleQuote]serving size\[CloseCurlyDoubleQuote]?\
\>", "Item",
 CellChangeTimes->{{3.543514841366079*^9, 3.543514884248367*^9}, {
  3.553543706204752*^9, 3.5535437068184423`*^9}, {3.553768544647854*^9, 
  3.5537685610717163`*^9}}]
}, Open  ]],

Cell["\<\
Let's show what Alice might write in JavaScript, then show a Jacquard \
computation designed to produce the same result, and finally compare and \
contrast.\
\>", "Text",
 CellChangeTimes->{{3.543489103009957*^9, 3.5434891146801205`*^9}, {
  3.543489808455348*^9, 3.543489813825885*^9}, {3.543489991485527*^9, 
  3.543490091457527*^9}, {3.5434907263375273`*^9, 3.543490734520527*^9}, {
  3.5434932315556417`*^9, 3.5434932436278486`*^9}, {3.543514830190962*^9, 
  3.5435148359505377`*^9}, {3.5435442274907527`*^9, 3.543544245841802*^9}, {
  3.553737060041987*^9, 3.553737087146172*^9}}],

Cell[BoxData[
 GraphicsBox[
  TagBox[RasterBox[CompressedData["
1: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
MQBtMa2GOEileillrav8N7WJzObNm/aRZBx4XOfzjW36coHiJIhTfoJbin5N
rp97ld3i7pQn8psVrZ/UnNmU+TV3IAq9W4kAWzZ1uBLu4nDR2w3Iq8eo3XYu
vz4+YrP7TZs37SO9er7H9dk78ez3FZc8nyJUvDndNAvP6zh1P86e2Zj9NS/U
uUI84q6YZn30fwupN+zTRFYm3bzpm/StXbdzIrw80/DB/k3hlk9LFK8ky7/i
tL22+D99pcZG94knr79xTSbBryhoZjM8sq9AJetdojgpv2AuGGGaWso3SXDe
V8SmlmYSRC9up0UbsyZh4t/I6OrVnCnmSn9NZF2W65y7XdN8lqtER6Huz9vj
8mdcHzoulOSyeocXr+rryXTzpnRXprco0BTVfkyHD/dvKrfFy+drsDCi77vv
5RxVzv9RSe4gKkE/RFqLtYTJ3hhksv6OV1FSQSnXCGEfbw6b5lu4wmuC6YUg
28dzFSFIPkq3Eak5E8TP3ULJ10TUJbzOZ652eJVyUR7XFvdq0LI3Eq5VMUn6
XJzblWkJX3rCjcITGlljpSoOyuNFXEVeuOZLiknS2QS9nMlaFBopMtncBQli
ra1PtspRvkmCUW5BAQs79ZxpFsn7mHrKulDF5NdHXs9SXbwwmatNXKVclMep
WDApuZ2EaZrji1Rc1FccZlv4WhWvXz25y4zfEUq7E2EiQTt9NsHlfK4tmu+u
WClksrkLEqQWqjhNKs230IReqOJc7msZqCt9YY+abgio61mp4szVLqm4cIff
C1/FpiGW+gLfrbT863dHtn3e1730wLPh61S83Nt+c5oX3Xtuf8kv99Dk5VRI
MOoJJ7Wgu+jlZHMXMLi2YY86SYrIl7zCXrTzPeqCiqOKEOmkXDi6ldxCZ78m
8tdyDVO42uFVykV5nIqVUnaAWqsrq/ibHN0KeyrBx4XwfiOajG4R/aD57Dga
Qz7IlG4uV7JYb1SCywe+6pNBkrWM8SXKJktfQL+A8ehWkhSZb5Lg/CXY/TeJ
IQI/bKlHTeQe130tSNg0RvWrOZMWMapxcj3zdYlvLjKn+Cployz3Z6EjdWVc
/s6r51IVN8YjfjTBzOfHne7wV8Bp1s740OLS0a2GcL+fuI8extevX5+PLsPP
wWnWSNgcTHBzvISKAfhBLG2xHszDcS94jddHeZThQvJPq8mD7UWZPElvelNJ
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
fJ6i
    "], {{0, 405}, {322, 0}}, {0, 255},
    ColorFunction->RGBColor],
   BoxForm`ImageTag["Byte", ColorSpace -> "RGB", Interleaving -> True],
   Selectable->False],
  BaseStyle->"ImageGraphics",
  ImageSize->Automatic,
  ImageSizeRaw->{322, 405},
  PlotRange->{{0, 322}, {0, 405}}]], "Text",
 CellChangeTimes->{3.543521166353508*^9}],

Cell["\<\
The first step is to encode the NFL data in a JavaScript object. Alice is \
careful to keep the units of measure in comments for mental tracking and for \
informing other developers of this secret info:\
\>", "Text",
 CellChangeTimes->{{3.543490030371527*^9, 3.5434900350595274`*^9}, {
   3.5434901248565273`*^9, 3.543490130694527*^9}, 3.5434901994755273`*^9, {
   3.543491552239915*^9, 3.543491602673958*^9}, {3.543493254892975*^9, 
   3.543493256077093*^9}, {3.553737129960754*^9, 3.5537371335806293`*^9}, {
   3.553773001315814*^9, 3.553773003201996*^9}}],

Cell["\<\
var burgerNutritionFacts001 = 
{ 'Serving Size'       :   4   /* ounce */,
  'Amount per Serving' : 160   /* calorie */, 
  'Calories from Fat'  :  81.0 /* calorie */,
  'Saturated Fat'      :   4   /* gram */,
  'Cholesterol'        :  60   /* milligram */, 
  'Sodium'             :  70   /* milligram */,
  'Dietary Fiber'      :   0   /* gram */,
  'Sugars'             :   0   /* gram */,
  'Total Fat'          :   9   /* gram */,
  'Protein'            :  21   /* gram */,
  'Total Carbohydrate' :   0   /* gram */
};\
\>", "Program",
 CellChangeTimes->{{3.5434916272964196`*^9, 3.543491739185607*^9}, {
  3.5434919547047205`*^9, 3.5434919673747206`*^9}, {3.543523723133175*^9, 
  3.543523744715333*^9}}],

Cell[TextData[{
 "Alice chooses to preserve the spaces in the object keys such as \
\[OpenCurlyQuote]Serving Size\[CloseCurlyQuote] and \[OpenCurlyQuote]Total \
Fat\[CloseCurlyQuote] for direct correspondence to the data. She accepts that \
she ",
 ButtonBox["can\[CloseCurlyQuote]t later use dot notation with such keys",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://stackoverflow.com/questions/4968406/javascript-property-\
access-dot-notation-vs-brackets"], None},
  ButtonNote->
   "http://stackoverflow.com/questions/4968406/javascript-property-access-dot-\
notation-vs-brackets"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["8"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{
               RowBox[{"stackoverflow", ".", "com"}], "/", "questions"}], "/",
              "4968406"}], "/", "javascript"}], "-", "property", "-", 
         "access", "-", "dot", "-", "notation", "-", "vs", "-", 
         "brackets"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00004D0E"],
 "]. For uniformity of style, Alice will use only the square-bracket ",
 StyleBox["indexer",
  FontSlant->"Italic"],
 " notation everywhere. "
}], "Text",
 CellChangeTimes->CompressedData["
1:eJwdyE0og3EcwPGnsSbvdhplJS6rlYtG2VZmsa2ZejJ52YVYmmUHL2nsxmJN
KGtKbaTNzGYXIQyHldG8LRflYGH0HCxaDlj8f7/Dt099K3pNdD+LoqhyEvi0
L1gM6JmGqc58Byh30OfgalXiAuTO+ZPgBD/yBgr000VBoqXGKgJbu7NoUNp/
1gaWFVd/gyseQwY8csf6QkROYY8B3IlM5YSJ8ffDAjC9qW+sNTMNjGRGDspK
1pfAT2fKCb7GuWtNxMSGCPXVmX2g+LLLDz4IJSEwKn08AL3USQJ8GTpFeV+2
JCjT2dGF0R8GVNz9osZlcQZUpySokL3FbSbeaAOo66NDBBpVXeh2o0cL7u55
UX5l9hjIK2WjuVdhL/7bYzRmmLQqiM/XFtT6p/oD7To1mmdXsJXw75XovKD3
vYU4siNLgRrWLEdDbB+woWZT/bCWOBgVo2naNQ7qgm70H9SX6pw=
  "]],

Cell["\<\
The next step is to add up the weights of all the nutritional components. \
Alice knows that milligrams are tiny by comparison to grams, so she simply \
omits them in this first version, perhaps with a shade of concern that \
another programmer inheriting her code might erroneously put them back in. \
\>", "Text",
 CellChangeTimes->{{3.543491721303819*^9, 3.543491752385927*^9}, {
   3.543492170580721*^9, 3.543492183035721*^9}, {3.5434924053297205`*^9, 
   3.5434924221287208`*^9}, {3.5434927321687207`*^9, 3.543492771158721*^9}, {
   3.543493049858474*^9, 3.5434930863401213`*^9}, {3.5434931454870358`*^9, 
   3.5434931511746044`*^9}, {3.543493291599645*^9, 3.5434932991504*^9}, {
   3.5434946515807157`*^9, 3.5434946685387154`*^9}, {3.5435255008609047`*^9, 
   3.5435255011558456`*^9}, 3.5435443907280893`*^9, {3.553737941061749*^9, 
   3.553737996382864*^9}, {3.55373811459966*^9, 3.553738147658684*^9}, {
   3.553739066436283*^9, 3.5537390980705357`*^9}, {3.553769071404738*^9, 
   3.5537690908988047`*^9}}],

Cell["\<\
She at least takes the preventative of packaging the computation in a \
function, parameterized by the data object, for reuse on other nutrition \
blocks.\
\>", "Text",
 CellChangeTimes->{{3.543491721303819*^9, 3.543491752385927*^9}, {
   3.543492170580721*^9, 3.543492183035721*^9}, {3.5434924053297205`*^9, 
   3.5434924221287208`*^9}, {3.5434927321687207`*^9, 3.543492771158721*^9}, {
   3.543493049858474*^9, 3.5434930863401213`*^9}, {3.5434931454870358`*^9, 
   3.5434931511746044`*^9}, {3.543493291599645*^9, 3.5434932991504*^9}, {
   3.5434946515807157`*^9, 3.5434946685387154`*^9}, {3.5435255008609047`*^9, 
   3.5435255011558456`*^9}, 3.5435443907280893`*^9, {3.553737941061749*^9, 
   3.553737996382864*^9}, {3.55373811459966*^9, 3.553738147658684*^9}, {
   3.553739066436283*^9, 3.5537390980705357`*^9}, {3.5537391311067257`*^9, 
   3.553739144050207*^9}, {3.553769105246541*^9, 3.553769115258047*^9}}],

Cell["\<\
var addWeights001 = function(nutritionFacts) {
  return nutritionFacts['Total Fat'] + 
         nutritionFacts['Dietary Fiber'] + 
         nutritionFacts['Protein'] + 
         nutritionFacts['Total Carbohydrate'];
};

document.writeln(addWeights001(burgerNutritionFacts001));\
\>", "Program",
 CellChangeTimes->{{3.5434931167551627`*^9, 3.543493135093996*^9}, {
  3.5434944635407157`*^9, 3.5434944702847157`*^9}, {3.5435238226001205`*^9, 
  3.5435238337282333`*^9}}],

Cell["\<\
The result is 30. Alice knows this means grams, and she carries that mentally \
because she doesn\[CloseCurlyQuote]t have a convenient, straightforward way \
to carry it in her code. \
\>", "Text",
 CellChangeTimes->{{3.543493163175804*^9, 3.5434931676402507`*^9}, {
  3.5435256505509605`*^9, 3.543525651389793*^9}, {3.5535439746534357`*^9, 
  3.553544064186651*^9}}],

Cell[CellGroupData[{

Cell["ALICE\[CloseCurlyQuote]S DREAMS", "Subsection",
 CellChangeTimes->{{3.5435149909660378`*^9, 3.543515007606701*^9}}],

Cell["\<\
Alice takes a moment to reflect on the code she just wrote. Will it withstand \
criticism from other programmers? \
\>", "Text",
 CellChangeTimes->{{3.543515374049342*^9, 3.543515430764013*^9}, {
  3.553739325368431*^9, 3.5537394503765993`*^9}, {3.553769150673177*^9, 
  3.553769201615522*^9}}],

Cell[CellGroupData[{

Cell["Repetition Considered Harmful", "Subsubsection",
 CellChangeTimes->{{3.543493198546341*^9, 3.5434932115706434`*^9}}],

Cell[TextData[{
 ButtonBox["DRY (Don\[CloseCurlyQuote]t Repeat Yourself)",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikipedia.org/wiki/Don%27t_repeat_yourself"], None},
  ButtonNote->"http://en.wikipedia.org/wiki/Don%27t_repeat_yourself"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["9"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/",
            "Don"}], "%27", "t_repeat", "_yourself"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"000033FD"],
 "] is ",
 ButtonBox["programmer mantra",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://c2.com/cgi/wiki?DontRepeatYourself"], None},
  ButtonNote->"http://c2.com/cgi/wiki?DontRepeatYourself"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["10"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{"c2", ".", "com"}], "/", "cgi"}], "/", 
         RowBox[{"wiki", "?", "DontRepeatYourself"}]}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00002E07"],
 "] nowadays. Unecessary repetition in code just increases risk of programmer \
error.\nEven though Alice is careful to ",
 ButtonBox["align parts of the arithmetic expression vertically",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikipedia.org/wiki/Programming_style#Vertical_alignment"], 
    None},
  ButtonNote->
   "http://en.wikipedia.org/wiki/Programming_style#Vertical_alignment"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["11"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/",
            "Programming_style"}], "#", "Vertical_alignment"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00003920"],
 "], the repeated name of the object parameter in every term in the sum is \
striking. This seems to be gratuitous, useless repetition. If there were \
hundreds of properties, it would be oppressive. Can she get rid of the \
repetition? Suppose she could write"
}], "Text",
 CellChangeTimes->CompressedData["
1:eJxTTMoPSmViYGAQAWIQ7X5ohfa6tFeObEn9+iDaOeeZCTLdcqbaDkQfWL3b
BUQL3Z+Wsx5I31s5A0xbd3n6HgPS1ct2gGnfF9IP3KpeOdocmPAMRFd9+fMK
RKe8DHoPoo8y2v0F0SG1LmB6fe4aIXcgvefFJjDdGRdlBqKdqhPBtNj5ZaEg
uvzUWjD9R4e1DETvruUG0yqv9y0D0TtdjoFpWZa6Ng8gvSWlFUwX1fj8B9Ez
uoPBtPAHT1ZPIH2qOgBMl21OfucLpGV8vN+D6PjaLnY/IL1jwyQwPV/AtjgU
SJt9dwbTwsfnV4DoilnLwDQAcLmhOQ==
  "]],

Cell["\<\
var addWeights001 = function(nutritionFacts) {
  return nutritionFacts[
  \t'Total Fat' + 'Dietary Fiber' + 'Protein' + 'Total Carbohydrate\"];
};\
\>", "Program",
 CellChangeTimes->{{3.5434931167551627`*^9, 3.543493135093996*^9}, {
  3.5434934335578394`*^9, 3.5434934853120146`*^9}, {3.543494474716716*^9, 
  3.5434944827087154`*^9}, {3.5435155343383694`*^9, 3.5435155350094366`*^9}, {
  3.543523754596321*^9, 3.543523767305592*^9}}],

Cell[TextData[{
 "And ",
 StyleBox["why not",
  FontSlant->"Italic"],
 " have symbolic expressions inside the square brackets? The meaning is \
completely obvious. But she can\[CloseCurlyQuote]t make it work, and for \
multiple reasons."
}], "Text",
 CellChangeTimes->{{3.5434934985213356`*^9, 3.543493577188201*^9}, {
  3.543494706721716*^9, 3.5434947122487154`*^9}, {3.5434976040998683`*^9, 
  3.5434976260440626`*^9}, {3.543544506746725*^9, 3.543544508441822*^9}, {
  3.553769355804317*^9, 3.553769357364141*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["Alice\[CloseCurlyQuote]s First Dream", "Subsubsection",
 CellChangeTimes->{{3.553864519372137*^9, 3.553864524539654*^9}}],

Cell["\<\
Generally, it\[CloseCurlyQuote]s a benefit to have an infix operator for \
concatenating strings. Unfortunately, JavaScript overloaded the + operator \
instead of introducing a new one, and the expression\
\>", "Text",
 CellChangeTimes->{{3.5434936760810895`*^9, 3.543493708550336*^9}, {
  3.5434937441168923`*^9, 3.5434937643189125`*^9}, {3.5434947299757156`*^9, 
  3.5434947357917156`*^9}}],

Cell["\<\
nutritionFacts[
  \t'Total Fat' + 'Dietary Fiber' + 'Protein' + 'Total Carbohydrate']\
\>", "Program",
 CellChangeTimes->{{3.5434931167551627`*^9, 3.543493135093996*^9}, {
  3.5434934335578394`*^9, 3.5434934853120146`*^9}, {3.5434937754070215`*^9, 
  3.543493809825463*^9}, {3.543523768247686*^9, 3.543523770906952*^9}, {
  3.543523840473908*^9, 3.543523842833144*^9}}],

Cell["evaluates to", "Text",
 CellChangeTimes->{{3.5434937836398444`*^9, 3.543493785655046*^9}}],

Cell["\<\
nutritionFacts['Total FatDietary FiberProteinTotal Carbohydrate'] ~~>
undefined\
\>", "Program",
 CellChangeTimes->{{3.5434931167551627`*^9, 3.543493135093996*^9}, {
  3.5434934335578394`*^9, 3.5434934853120146`*^9}, {3.5434937754070215`*^9, 
  3.543493827649245*^9}, {3.5435238461534758`*^9, 3.5435238499378543`*^9}}],

Cell["\<\
Her dream code is syntactically legal, and completely wrong. She can\
\[CloseCurlyQuote]t write this.\
\>", "Text",
 CellChangeTimes->{{3.5434938339858785`*^9, 3.5434938849307156`*^9}, {
   3.5434947455597153`*^9, 3.5434947565027156`*^9}, 3.543497644996958*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell["Alice Regrets Whitespace ", "Subsubsection",
 CellChangeTimes->{{3.5434937156670475`*^9, 3.543493739772458*^9}, {
  3.543501239152557*^9, 3.5435012397606173`*^9}, {3.543515029815922*^9, 
  3.5435150404019804`*^9}}],

Cell[TextData[{
 "Alice continues to dream. If she hadn\[CloseCurlyQuote]t preserved space \
characters in the keys, but gone to ",
 ButtonBox["camelBack",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikipedia.org/wiki/CamelCase"], None},
  ButtonNote->"http://en.wikipedia.org/wiki/CamelCase"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["12"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/", 
         "CamelCase"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"000028BF"],
 "], she could have written"
}], "Text",
 CellChangeTimes->{{3.5434938886427155`*^9, 3.543493903709716*^9}, {
  3.5434941554607153`*^9, 3.5434941841397157`*^9}, {3.543515045809521*^9, 
  3.543515048449785*^9}, {3.5537694379136877`*^9, 3.5537694621766357`*^9}, {
  3.553769621624234*^9, 3.553769621672814*^9}, {3.55376990707895*^9, 
  3.553769907142445*^9}, {3.5537701574604177`*^9, 3.553770157510316*^9}, {
  3.553770416396463*^9, 3.553770416463921*^9}, {3.553770806232692*^9, 
  3.5537708063003063`*^9}, {3.553772596203493*^9, 3.553772596266068*^9}, {
  3.553773562644929*^9, 3.553773562706579*^9}, {3.553773610545779*^9, 
  3.553773610615225*^9}, {3.5537836674010067`*^9, 3.553783674450981*^9}, {
  3.553783868634119*^9, 3.553783868697927*^9}, {3.553799066156641*^9, 
  3.55379906620043*^9}, {3.553799109243081*^9, 3.553799109287689*^9}}],

Cell["\<\
var burgerNutritionFacts002 = 
{ ServingSize        :   4   /* ounce */,
  AmountPerServing   : 160   /* calorie */, 
  CaloriesFromFat    :  81.0 /* calorie */,
  SaturatedFat       :   4   /* gram */,
  Cholesterol        :  60   /* milligram */, 
  Sodium             :  70   /* milligram */,
  DietaryFiber       :   0   /* gram */,
  Sugars             :   0   /* gram */,
  TotalFat           :   9   /* gram */,
  Protein            :  21   /* gram */,
  TotalCarbohydrate  :   0   /* gram */
};

var addWeights002 = function(nutritionFacts) {
  return nutritionFacts.TotalFat + 
         nutritionFacts.DietaryFiber + 
         nutritionFacts.Protein + 
         nutritionFacts.TotalCarbohydrate;
};

document.writeln(addWeights002(burgerNutritionFacts002));\
\>", "Program",
 CellChangeTimes->{{3.5434931167551627`*^9, 3.543493135093996*^9}, {
  3.5434944030827155`*^9, 3.5434944559017153`*^9}, {3.5434947618477154`*^9, 
  3.5434947716457157`*^9}}],

Cell["The result is still 30. ", "Text",
 CellChangeTimes->{{3.543525884418015*^9, 3.543525890146015*^9}, {
   3.543572515696746*^9, 3.5435725441053705`*^9}, 3.5435727743295383`*^9}],

Cell["\<\
There is a cost in going to camelBack, however. There is more code to \
develop, test, build, manage, deploy, and maintain -- code that creates \
objects from strings retrieved from the internet, which must build camelBack \
symbols like \[OpenCurlyDoubleQuote]CaloriesFromFat\[CloseCurlyDoubleQuote] \
from standardized strings like \[OpenCurlyDoubleQuote]Calories from Fat.\
\[CloseCurlyDoubleQuote] Removing spaces isn\[CloseCurlyQuote]t enough: the \
internal word \[OpenCurlyDoubleQuote]from\[CloseCurlyDoubleQuote] must be \
capitalized. Her original decision to use string keys instead of camelBack \
completely avoided all that cost, but maybe it will be worth it if there is a \
way to get rid of the repetition in the object-access expression.\
\>", "Text",
 CellChangeTimes->{{3.5434947884767156`*^9, 3.5434949978827157`*^9}, {
  3.5434976617176294`*^9, 3.543497704375308*^9}, {3.5435155787558107`*^9, 
  3.5435155985187864`*^9}, {3.543572784744134*^9, 3.543572847108701*^9}, {
  3.5435728810256414`*^9, 3.5435728859399223`*^9}, {3.5435729585400743`*^9, 
  3.54357298800276*^9}, {3.553769510895152*^9, 3.5537695165917883`*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["Alice\[CloseCurlyQuote]s Second Dream", "Subsubsection",
 CellChangeTimes->{{3.5435011477404165`*^9, 3.5435011516198044`*^9}}],

Cell["\<\
So she imagines what she could write with the camelBack conversion. Her dream \
code would be:\
\>", "Text",
 CellChangeTimes->{{3.5434953044357157`*^9, 3.543495335905716*^9}, {
  3.543515641615096*^9, 3.5435156463425684`*^9}, {3.5435724926024246`*^9, 
  3.5435724929204426`*^9}}],

Cell["\<\
var addWeights002 = function (nutritionFacts) {
  return 
    nutritionFacts.(TotalFat + DietaryFiber + Protein + TotalCarbohydrate);
};\
\>", "Program",
 CellChangeTimes->{{3.5434953966797156`*^9, 3.5434954265817156`*^9}, {
  3.5435448161954246`*^9, 3.5435448228488054`*^9}}],

Cell["\<\
Now that\[CloseCurlyQuote]s sweet, but not syntactically legal ... unless ... \
the \[OpenCurlyDoubleQuote]with\[CloseCurlyDoubleQuote] statement!\
\>", "Text",
 CellChangeTimes->{{3.5434954106617155`*^9, 3.5434954457967157`*^9}}],

Cell["\<\
var addWeights002 = function (nutritionFacts) {
  with(nutritionFacts) {
    return TotalFat + Protein + DietaryFiber + TotalCarbohydrate;
  }
};

document.writeln(addWeights002(burgerNutritionFacts002));\
\>", "Program",
 CellChangeTimes->{{3.5434957595177155`*^9, 3.5434957729967155`*^9}}],

Cell["The result is still 30.", "Text",
 CellChangeTimes->{{3.5435259904610147`*^9, 3.5435259962840147`*^9}}],

Cell[TextData[{
 "Alas, this is not an acceptable solution. It has removed ",
 StyleBox["any",
  FontSlant->"Italic"],
 " reference to the object from the expression in the return statement, and \
thus rendered the expression fundamentally ambiguous. The value of the term ",
 StyleBox["TotalFat",
  FontSlant->"Italic"],
 " could come from the global environment, or from an outer nesting of local \
environments, or from outer ",
 StyleBox["with",
  FontSlant->"Italic"],
 " statements. There is no way to tell from local inspection of the \
expresion. This is too much exposure to scoping errors."
}], "Text",
 CellChangeTimes->{{3.5434957867317157`*^9, 3.5434958807747154`*^9}, {
  3.5434972086793303`*^9, 3.5434972248399467`*^9}, {3.5434972555860205`*^9, 
  3.5434973494864097`*^9}, {3.543515675513485*^9, 3.543515685321466*^9}, {
  3.543544866560305*^9, 3.543544930262949*^9}, {3.543572565220578*^9, 
  3.5435725675937138`*^9}}],

Cell[TextData[{
 "There has been much pain in the JavaScript community about the ",
 StyleBox["with",
  FontSlant->"Italic"],
 " statement. The ambiguity it injects outweights its superficial \
attractiveness. ",
 ButtonBox["The overall concensus is to avoid it",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://yuiblog.com/blog/2006/04/11/with-statement-considered-harmful/\
"], None},
  ButtonNote->
   "http://yuiblog.com/blog/2006/04/11/with-statement-considered-harmful/"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["13"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{
               RowBox[{
                 RowBox[{
                   RowBox[{"yuiblog", ".", "com"}], "/", "blog"}], "/", 
                 "2006"}], "/", "04"}], "/", "11"}], "/", "with"}], "-", 
         "statement", "-", "considered", "-", 
         RowBox[{"harmful", "/"}]}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00004D81"],
 "]."
}], "Text",
 CellChangeTimes->{{3.5434957867317157`*^9, 3.5434958807747154`*^9}, {
   3.5434972086793303`*^9, 3.5434972248399467`*^9}, {3.5434972555860205`*^9, 
   3.5434973174282045`*^9}, 3.543497356830144*^9, {3.543500037704624*^9, 
   3.5435000423120847`*^9}, {3.5435449517381773`*^9, 3.54354499601971*^9}, {
   3.553769612709462*^9, 3.5537696435741034`*^9}, {3.553769907177257*^9, 
   3.553769907242676*^9}, {3.5537701575487328`*^9, 3.553770157613565*^9}, {
   3.553770416491053*^9, 3.553770416542972*^9}, {3.5537708063281193`*^9, 
   3.553770806379517*^9}, {3.553772596303822*^9, 3.553772596366391*^9}, {
   3.553773562740096*^9, 3.5537735628082848`*^9}, {3.553773610641255*^9, 
   3.5537736106939383`*^9}, {3.5537836674988413`*^9, 
   3.5537836745514593`*^9}, {3.553783868727975*^9, 3.553783868795734*^9}, {
   3.55379906624329*^9, 3.553799066308826*^9}, {3.553799109325294*^9, 
   3.553799109373021*^9}}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["EXPRESSIONS MUST STAND ALONE", "Subsection",
 CellChangeTimes->{{3.543497366719133*^9, 3.543497392160677*^9}, {
  3.5435150767796183`*^9, 3.5435150831392536`*^9}}],

Cell["\<\
Can we remove any reference to the target object from the expression and NOT \
introduce ambiguity? It seems the only way would be to treat the expression \
itself as a standalone, first-class object, reserving ANY interpretation of \
the expression until it\[CloseCurlyQuote]s used. But that\[CloseCurlyQuote]s \
what symbolic computing means!\
\>", "Text",
 CellChangeTimes->{{3.5434973973521957`*^9, 3.5434974006975307`*^9}, {
  3.5434974552429843`*^9, 3.543497462259686*^9}, {3.5435000108947043`*^9, 
  3.543500091794032*^9}, {3.5435009136689005`*^9, 3.5435009151499004`*^9}, {
  3.543501481059699*^9, 3.543501511163699*^9}, {3.543515104924432*^9, 
  3.5435151198779273`*^9}, {3.5435157076997037`*^9, 3.5435157089868326`*^9}, {
  3.543545039057172*^9, 3.543545120888852*^9}, {3.543572613579344*^9, 
  3.543572626586088*^9}, {3.55376968026943*^9, 3.5537697542981453`*^9}}],

Cell["\<\
There is no native way in JavaScript to do this. The interpretation of all \
symbols must be known prior to run time. A symbol that does not have a value \
generates a deep exception -- an unrecoverable error -- an invalid program. \
In C#, Java, C++, and most other languages, unbound symbols don\
\[CloseCurlyQuote]t even compile. \
\>", "Text",
 CellChangeTimes->{{3.5435015192416987`*^9, 3.543501647979699*^9}, {
   3.543515132326172*^9, 3.5435151380237417`*^9}, 3.5435451798132224`*^9, 
   3.5435452106529865`*^9, {3.5435726455511727`*^9, 3.543572674190811*^9}, {
   3.553544359083794*^9, 3.5535443599639683`*^9}, {3.553769773113653*^9, 
   3.553769780553657*^9}}],

Cell[TextData[{
 "There is an analogy to lazy evaluation. JavaScript eagerly interprets all \
symbols, before they\[CloseCurlyQuote]re needed. Jacquard, and term-rewriting \
systems in general, only interpret them when they\[CloseCurlyQuote]re used. \
And even then, \.08a symbol without a binding to a value is ",
 StyleBox["not",
  FontSlant->"Italic"],
 " an error, it\[CloseCurlyQuote]s just the symbol itself as a first-class, \
atomic value. An expression that does not reduce further is an expression in \
so-called ",
 ButtonBox["normal form",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikipedia.org/wiki/Normal_form_(abstract_rewriting)"], 
    None},
  ButtonNote->"http://en.wikipedia.org/wiki/Normal_form_(abstract_rewriting)"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["14"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/",
            "Normal_form"}], "_", 
         RowBox[{"(", "abstract_rewriting", ")"}]}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00003C7D"],
 "]."
}], "Text",
 CellChangeTimes->{{3.553555348958777*^9, 3.553555464268373*^9}, {
  3.5535555081897907`*^9, 3.5535555631783524`*^9}, {3.553769810153117*^9, 
  3.553769910463037*^9}, {3.553770157643738*^9, 3.553770157683217*^9}, {
  3.55377041658041*^9, 3.553770416625285*^9}, {3.5537708064161167`*^9, 
  3.553770806463439*^9}, {3.553772596409009*^9, 3.553772596450253*^9}, {
  3.553773562840105*^9, 3.5537735628746777`*^9}, {3.553773610730772*^9, 
  3.553773610778047*^9}, {3.553783667598316*^9, 3.553783674636878*^9}, {
  3.553783868829145*^9, 3.553783868881662*^9}, {3.553799066350876*^9, 
  3.553799066390704*^9}, {3.553799109409812*^9, 3.5537991094564743`*^9}}],

Cell[CellGroupData[{

Cell["Rewriting Alice\[CloseCurlyQuote]s Dreams", "Subsubsection",
 CellChangeTimes->{{3.5435152610840464`*^9, 3.543515265931531*^9}}],

Cell["\<\
First, we rewrite Alice\[CloseCurlyQuote]s Second Dream: the version using \
camelBack symbols for keys because it makes the code look like code instead \
of weird arithmetic on strings. Later, we show the exact same code using \
string keys with internal whitespace, allowing Alice to get rid of her \
string-to-symbol conversion code, restoring her First Dream.\
\>", "Text",
 CellChangeTimes->{{3.543501087336377*^9, 3.5435011208657293`*^9}, {
  3.5435012817628174`*^9, 3.543501353382979*^9}, {3.543501819795699*^9, 
  3.5435018306126986`*^9}, {3.5435262290330153`*^9, 3.543526231589015*^9}, {
  3.543572734860281*^9, 3.5435727349392853`*^9}, {3.5435731190892577`*^9, 
  3.543573146875847*^9}, {3.553769981878133*^9, 3.553769990052834*^9}, {
  3.553773032321484*^9, 3.553773047592753*^9}}],

Cell["\<\
In the offing, we sneak in units of measure, and conclude this dream by \
showing what might be needed in ordinary JavaScript to include such a \
facility.\
\>", "Text",
 CellChangeTimes->{{3.543501369318572*^9, 3.543501403983699*^9}, {
  3.5435018488176985`*^9, 3.5435018505446987`*^9}, {3.5435152818781257`*^9, 
  3.5435152854864864`*^9}, {3.5535445015445547`*^9, 3.553544510200267*^9}}],

Cell[TextData[{
 "Take the nutrition data and write them as ",
 StyleBox["rules",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 ". A rule is a pair of a ",
 StyleBox["pattern",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " and a ",
 StyleBox["replacement",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 ". A rule tells the evaluator \[OpenCurlyDoubleQuote]if you can match the \
left-hand side,  replace it with the right-hand side, after substituting any \
values for pattern variables.\[CloseCurlyDoubleQuote] The patterns-and-rules \
sublanguage is similar to regular expressions familiar from JavaScript, \
Python, Perl, and text editors, except that it operates over other \
expressions in the language and not just on strings. It lets the programmer \
write rules that will match whole classes of richly structured expressions. \
It allows parts of a program to rewrite other parts of a program, to be a \
\[OpenCurlyDoubleQuote]compiler,\[CloseCurlyDoubleQuote] if you like, for \
other parts of the program. It lets the programmer effortlessly create ",
 ButtonBox["embedded domain-specific languages",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikipedia.org/wiki/Domain-specific_language"], None},
  ButtonNote->"http://en.wikipedia.org/wiki/Domain-specific_language"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["15"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/",
            "Domain"}], "-", "specific_language"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00003400"],
 "],  almost without being aware of it. The pattern-and-rule facility is \
extraordinarily powerful."
}], "Text",
 CellChangeTimes->{{3.543347679565689*^9, 3.543347680430775*^9}, {
   3.543356944646019*^9, 3.5433569524370193`*^9}, {3.5433570695270195`*^9, 
   3.543357171210019*^9}, {3.543500985989243*^9, 3.543501072079851*^9}, {
   3.543501865153699*^9, 3.543501897397699*^9}, {3.5435152969666348`*^9, 
   3.5435153190478425`*^9}, 3.5435262781990147`*^9, {3.5435731707952147`*^9, 
   3.5435733013366814`*^9}, 3.543573342274023*^9, {3.553544531928074*^9, 
   3.553544623827767*^9}, {3.5535446697896633`*^9, 3.5535448659618998`*^9}, {
   3.5535652385485907`*^9, 3.553565429549198*^9}, {3.553565509040647*^9, 
   3.553565556043178*^9}, {3.553627522879841*^9, 3.553627524319933*^9}, {
   3.553770025837439*^9, 3.5537700435712357`*^9}, {3.5537700937539263`*^9, 
   3.5537701611609097`*^9}, {3.553770416662644*^9, 3.5537704167329683`*^9}, {
   3.5537708064988747`*^9, 3.553770806568551*^9}, {3.5537725964885*^9, 
   3.55377259653541*^9}, {3.553773562907846*^9, 3.553773562976983*^9}, {
   3.553773610813798*^9, 3.5537736108832903`*^9}, {3.5537836676814127`*^9, 
   3.5537836747377043`*^9}, {3.553783868914554*^9, 3.553783868981228*^9}, {
   3.553799066423757*^9, 3.5537990664704847`*^9}, {3.5537991094960423`*^9, 
   3.5537991095563393`*^9}}],

Cell[TextData[{
 "A rule with only symbolic constants for patterns -- with no pattern \
variables on the left-hand side -- is equivalent to a JavaScript or JSON \
property, ",
 StyleBox["i.e.",
  FontSlant->"Italic"],
 ", key-value pair. Symbolic constants are trivial patterns that match only \
themselves.  "
}], "Text",
 CellChangeTimes->{{3.543347679565689*^9, 3.543347680430775*^9}, {
   3.543356944646019*^9, 3.5433569524370193`*^9}, {3.5433570695270195`*^9, 
   3.543357171210019*^9}, {3.543500985989243*^9, 3.543501072079851*^9}, {
   3.543501865153699*^9, 3.543501897397699*^9}, {3.5435152969666348`*^9, 
   3.5435153190478425`*^9}, 3.5435262781990147`*^9, {3.5435731707952147`*^9, 
   3.5435733013366814`*^9}, 3.543573342274023*^9, {3.553544531928074*^9, 
   3.553544623827767*^9}, {3.5535446697896633`*^9, 3.553544748578436*^9}, {
   3.553565563971002*^9, 3.553565582970561*^9}, {3.553770176031818*^9, 
   3.5537701854560738`*^9}}],

Cell[TextData[{
 "The fact that we can always represent an object as a list of rules reveals \
the deeper fact that ",
 StyleBox["objects are just functions from keys to values",
  FontSlant->"Italic"],
 ", a fact that is also obvious from realizing that objects are implemented \
as hash tables or search trees, other representations for functions from keys \
to values."
}], "Text",
 CellChangeTimes->{{3.543347679565689*^9, 3.543347680430775*^9}, {
   3.543356944646019*^9, 3.5433569524370193`*^9}, {3.5433570695270195`*^9, 
   3.543357171210019*^9}, {3.543500985989243*^9, 3.543501072079851*^9}, {
   3.543501865153699*^9, 3.543501897397699*^9}, {3.5435152969666348`*^9, 
   3.5435153190478425`*^9}, 3.5435262781990147`*^9, {3.5435731707952147`*^9, 
   3.5435733013366814`*^9}, {3.543573342274023*^9, 3.5435733471233006`*^9}, {
   3.543573382131303*^9, 3.5435734022654543`*^9}, {3.5435734737645435`*^9, 
   3.5435734910515327`*^9}, {3.5435735456896577`*^9, 
   3.5435735963545556`*^9}, {3.553565613921096*^9, 3.553565650496793*^9}, {
   3.55377023252747*^9, 3.553770243694129*^9}}],

Cell["\<\
Notice in the following that we do not comment out the units of measure: they\
\[CloseCurlyQuote]re just symbolic constants in normal form. Each line in the \
Nutrition-Fact Label is a product of a number and a constant representing a \
unit of measure.\
\>", "Text",
 CellChangeTimes->{{3.543501902446699*^9, 3.5435019888016987`*^9}, {
  3.5435153334722843`*^9, 3.5435153447274103`*^9}, {3.5435262974530153`*^9, 
  3.543526306325015*^9}, {3.5435763068145847`*^9, 3.5435763136039734`*^9}, {
  3.553565676329041*^9, 3.553565750310544*^9}}],

Cell[TextData[{
 "We use a pretty-print function from the Jacquard library to display this \
definition in an aligned grid. Notice that Jacquard and ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " do reduce the terms with zero coefficients:"
}], "Text",
 CellChangeTimes->{{3.543501902446699*^9, 3.5435019888016987`*^9}, {
  3.5435153334722843`*^9, 3.543515350519989*^9}, {3.553770269365243*^9, 
  3.553770329979642*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"burgerNutritionFacts", "=", 
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"ServingSize", "\[Rule]", 
       RowBox[{"4", " ", "ounce"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"AmountPerServing", "\[Rule]", " ", 
       RowBox[{"160", " ", "calorie"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"CaloriesFromFat", "\[Rule]", 
       RowBox[{"81.0", " ", "calorie"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"SaturatedFat", "\[Rule]", 
       RowBox[{"4", " ", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"Cholesterol", "\[Rule]", 
       RowBox[{"60", "milli", " ", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"Sodium", "\[Rule]", 
       RowBox[{"70", " ", "milli", " ", "gram"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"DietaryFiber", "\[Rule]", 
       RowBox[{"0", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"Sugars", "\[Rule]", 
       RowBox[{"0", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"TotalFat", "\[Rule]", 
       RowBox[{"9", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"Protein", "\[Rule]", 
       RowBox[{"21", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"TotalCarbohydrate", "\[Rule]", 
       RowBox[{"0", " ", "gram"}]}]}], "}"}]}], ")"}], "//", 
  "gridRules"}]], "Input",
 CellChangeTimes->{{3.5435010786895123`*^9, 3.543501079616605*^9}, 
   3.5435013631439548`*^9, {3.5435014069786987`*^9, 3.5435014546646986`*^9}, 
   3.543501993717699*^9}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"ServingSize"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"4"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"ounce"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"AmountPerServing"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"160"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"CaloriesFromFat"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"81.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"SaturatedFat"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"4"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"Cholesterol"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"60"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"milli"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"Sodium"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"70"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"milli"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"DietaryFiber"}
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
              {"0"}
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
              {"Sugars"}
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
              {"0"}
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
              {"TotalFat"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"9"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"Protein"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"21"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"TotalCarbohydrate"}
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
              {"0"}
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
 CellChangeTimes->{3.5435014569026985`*^9, 3.543501994714699*^9, 
  3.543521047856802*^9, 3.5435211785267253`*^9, 3.5435235544423075`*^9, 
  3.5435250180760117`*^9, 3.5435286103100147`*^9, 3.543578783402238*^9, 
  3.5535552328103333`*^9, 3.553601956445407*^9, 3.553619267854857*^9, 
  3.553772493118381*^9, 3.553785129401973*^9, 3.553785192717555*^9, 
  3.553789204578046*^9, 3.55386487983918*^9}]
}, Open  ]],

Cell[TextData[{
 "Now consider the following expression. Notice that it just evaluates to \
itself, after being reordered into \[OpenCurlyDoubleQuote]canonical order.\
\[CloseCurlyDoubleQuote] This happens to be alphabetical order in this case. \
Canonical order helps to test structural equality of expressions, needed for \
pattern matching, so Jacquard and ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " always do it by default. There is no difficulty here, since the order of \
terms in a sum does not matter."
}], "Text",
 CellChangeTimes->{{3.543502078533699*^9, 3.543502089484699*^9}, {
  3.543502121515699*^9, 3.543502231861699*^9}, {3.543515752775211*^9, 
  3.543515795783511*^9}, {3.543518192076319*^9, 3.543518211446382*^9}, {
  3.543526335780015*^9, 3.543526355141015*^9}, {3.5435763376423483`*^9, 
  3.5435764004999437`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"TotalFat", "+", "DietaryFiber", "+", "Protein", "+", 
  "TotalCarbohydrate"}]], "Input",
 CellChangeTimes->{{3.543502092398699*^9, 3.5435021185086985`*^9}}],

Cell[BoxData[
 RowBox[{"DietaryFiber", "+", "Protein", "+", "TotalCarbohydrate", "+", 
  "TotalFat"}]], "Output",
 CellChangeTimes->{3.543502136568699*^9, 3.543521047936802*^9, 
  3.5435211785907316`*^9, 3.5435235545133147`*^9, 3.5435250181470118`*^9, 
  3.543528610378015*^9, 3.543578783457241*^9, 3.553555232921341*^9, 
  3.553601956512197*^9, 3.553619267939455*^9, 3.553772493168809*^9, 
  3.553785129457377*^9, 3.553785192772215*^9, 3.553789204634222*^9, 
  3.553864879911187*^9}]
}, Open  ]],

Cell[TextData[{
 "What can we do with this expression? ",
 StyleBox["Apply the data to it",
  FontSlant->"Italic"],
 ", which we do with the ReplaceAll operation:"
}], "Text",
 CellChangeTimes->{{3.543502240125699*^9, 3.543502272259699*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ReplaceAll", "[", 
  RowBox[{
   RowBox[{
   "TotalFat", "+", "DietaryFiber", "+", "Protein", "+", 
    "TotalCarbohydrate"}], ",", "burgerNutritionFacts"}], "]"}]], "Input",
 CellChangeTimes->{{3.543502273765699*^9, 3.543502304155699*^9}}],

Cell[BoxData[
 RowBox[{"30", " ", "gram"}]], "Output",
 CellChangeTimes->{3.5435023046996984`*^9, 3.543521048015802*^9, 
  3.543521178662739*^9, 3.5435235545943227`*^9, 3.543525018218012*^9, 
  3.543528610447015*^9, 3.543578783511244*^9, 3.553555232954153*^9, 
  3.553601956578743*^9, 3.553619268000278*^9, 3.553772493220687*^9, 
  3.55378512952302*^9, 3.5537851928223047`*^9, 3.5537892047292767`*^9, 
  3.5538648799711933`*^9}]
}, Open  ]],

Cell[TextData[{
 "This means \[OpenCurlyDoubleQuote]30 times grams;\[CloseCurlyDoubleQuote] \
it\[CloseCurlyQuote]s a multiplication expression. Notice that ",
 StyleBox["gram",
  FontSlant->"Italic"],
 " gets carried along as a \
\[OpenCurlyDoubleQuote]dead\[CloseCurlyDoubleQuote] symbolic constant -- one \
in normal form, for which no further interpretation is available or desired. \
Not easy in JavaScript, but very valuable. It\[CloseCurlyQuote]s the kind of \
thing that would have saved a couple of billion dollars in the 1999 ",
 ButtonBox["crash of the Mars Climate Observer",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikipedia.org/wiki/Mars_Climate_Orbiter"], None},
  ButtonNote->"http://en.wikipedia.org/wiki/Mars_Climate_Orbiter"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["16"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/",
            "Mars_Climate"}], "_Orbiter"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"000031E9"],
 "]. "
}], "Text",
 CellChangeTimes->{{3.543502309082699*^9, 3.543502336696699*^9}, {
  3.543502425108699*^9, 3.5435024843536987`*^9}, {3.543515814593392*^9, 
  3.5435158160885415`*^9}, {3.543515883931325*^9, 3.543515883931325*^9}, {
  3.543576432827792*^9, 3.5435764617804484`*^9}, {3.543576507176045*^9, 
  3.5435765080290937`*^9}, {3.553770405905808*^9, 3.553770438593606*^9}, {
  3.553770806592997*^9, 3.553770806647295*^9}, {3.55377259656592*^9, 
  3.553772596617304*^9}, {3.5537735630072813`*^9, 3.5537735630753393`*^9}, {
  3.553773610914111*^9, 3.5537736109824247`*^9}, {3.553783667781247*^9, 
  3.5537836748375*^9}, {3.553783869012581*^9, 3.553783869082385*^9}, {
  3.55379906650869*^9, 3.5537990665745*^9}, {3.553799109595336*^9, 
  3.553799109663494*^9}}],

Cell[CellGroupData[{

Cell["quote", "Subitem",
 CellChangeTimes->{{3.543502551821699*^9, 3.543502568870699*^9}, {
  3.543515893115243*^9, 3.5435158992918606`*^9}}],

Cell[TextData[{
 StyleBox["Specifically, the flight system software on the Mars Climate \
Orbiter was written to calculate thruster performance using the metric unit \
Newtons (N), while the ground crew was entering course correction and \
thruster data using the Imperial measure Pound-force (lbf). This error has \
since been known as the ",
  FontSlant->"Italic"],
 ButtonBox["metric mixup",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://www.wired.com/science/discoveries/news/1999/09/31631"], None},
  ButtonNote->"http://www.wired.com/science/discoveries/news/1999/09/31631"],
 StyleBox[" and has been carefully avoided in all missions since by NASA.",
  FontSlant->"Italic"]
}], "SubitemParagraph",
 CellChangeTimes->{{3.5435025632946987`*^9, 3.5435025769806986`*^9}, {
  3.543515929965928*^9, 3.543515930509982*^9}, {3.553565870687641*^9, 
  3.553565870717208*^9}}],

Cell["end quote", "Subitem",
 CellChangeTimes->{{3.543502558069699*^9, 3.5435025593416986`*^9}}]
}, Open  ]],

Cell["\<\
We can do some things to shorten this. First, we can use the shorthand infix \
operator, \[OpenCurlyDoubleQuote]/.\[CloseCurlyDoubleQuote], instead of the \
direct call to ReplaceAll:\
\>", "Text",
 CellChangeTimes->{{3.543502339696699*^9, 3.5435023777426987`*^9}, {
  3.543526467382015*^9, 3.5435264721250153`*^9}, {3.543576538224821*^9, 
  3.5435765489484344`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
  "TotalFat", "+", "DietaryFiber", "+", "Protein", "+", "TotalCarbohydrate"}],
   "/.", "burgerNutritionFacts"}]], "Input",
 CellChangeTimes->{{3.543502391055699*^9, 3.5435023973996987`*^9}}],

Cell[BoxData[
 RowBox[{"30", " ", "gram"}]], "Output",
 CellChangeTimes->{3.5435023982706985`*^9, 3.543521048122802*^9, 
  3.543521178732746*^9, 3.54352355466433*^9, 3.5435250183000116`*^9, 
  3.543528610516015*^9, 3.5435787835582466`*^9, 3.553555232993864*^9, 
  3.553601956645319*^9, 3.553619268045602*^9, 3.553772493285838*^9, 
  3.5537851295988903`*^9, 3.5537851928904343`*^9, 3.553789204807357*^9, 
  3.553864880026199*^9}]
}, Open  ]],

Cell[TextData[{
 "This code is quite close to Alice\[CloseCurlyQuote]s Second Dream, except \
the object comes ",
 StyleBox["after",
  FontSlant->"Italic"],
 " the expression. That\[CloseCurlyQuote]s appropriate since we\
\[CloseCurlyQuote]re ",
 StyleBox["applying the object, as a collection of rules, to the expression",
  FontSlant->"Italic"],
 ". But it\[CloseCurlyQuote]s not an important limitation since we can design \
our own operators to write things in the opposite order should we prefer to \
imagine that the expression indexes the object. Let\[CloseCurlyQuote]s skip \
that dichotomy for now."
}], "Text",
 CellChangeTimes->{{3.5435024036296988`*^9, 3.543502415028699*^9}, {
  3.5435025994916987`*^9, 3.5435026732556987`*^9}, {3.5435210237518015`*^9, 
  3.5435210246058016`*^9}, {3.55359267952111*^9, 3.553592705607916*^9}, {
  3.5537706700628643`*^9, 3.5537706893148108`*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["The Computation is Just Another Expression", "Subsubsection",
 CellChangeTimes->{{3.5435030757031217`*^9, 3.5435030877675343`*^9}}],

Cell["We\[CloseCurlyQuote]ve alread seen that", "Text",
 CellChangeTimes->{{3.543576578234109*^9, 3.543576582769369*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"TotalFat", "+", "DietaryFiber", "+", "Protein", "+", 
  "TotalCarbohydrate"}]], "Input"],

Cell[BoxData[
 RowBox[{"DietaryFiber", "+", "Protein", "+", "TotalCarbohydrate", "+", 
  "TotalFat"}]], "Output",
 CellChangeTimes->{3.543503130475074*^9, 3.543521048186802*^9, 
  3.543521178798753*^9, 3.543523554734337*^9, 3.543525018369012*^9, 
  3.5435286105850153`*^9, 3.5435787836092496`*^9, 3.5535552330388527`*^9, 
  3.553601956710733*^9, 3.553619268114592*^9, 3.55377249333642*^9, 
  3.553785129678982*^9, 3.553785192959324*^9, 3.5537892048906116`*^9, 
  3.5538648800802045`*^9}]
}, Open  ]],

Cell["\<\
is an expression, just one that doesn\[CloseCurlyQuote]t have another value. \
But the application of rules \
\>", "Text",
 CellChangeTimes->{{3.543503115886157*^9, 3.5435031404568853`*^9}, {
  3.543576588673706*^9, 3.543576594666049*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
  "TotalFat", "+", "DietaryFiber", "+", "Protein", "+", "TotalCarbohydrate"}],
   "/.", "burgerNutritionFacts"}]], "Input"],

Cell[BoxData[
 RowBox[{"30", " ", "gram"}]], "Output",
 CellChangeTimes->{3.5435031433471737`*^9, 3.543521048255802*^9, 
  3.5435211788617587`*^9, 3.543523554805344*^9, 3.5435250184370117`*^9, 
  3.543528610656015*^9, 3.5435787836602526`*^9, 3.553555233071992*^9, 
  3.553601956760651*^9, 3.55361926817446*^9, 3.553772493403256*^9, 
  3.55378512977179*^9, 3.553785193026374*^9, 3.5537892049729424`*^9, 
  3.55386488013521*^9}]
}, Open  ]],

Cell[TextData[{
 "is also just another expression -- this time with a reduced value revealed \
by applying the ",
 StyleBox["burgerNutritionFacts",
  FontSlant->"Italic"],
 ". If we applied a different nutrition block, say this one for a chicken \
breast:"
}], "Text",
 CellChangeTimes->{{3.543503122494478*^9, 3.5435031650823474`*^9}, {
  3.5435033422750645`*^9, 3.543503357067544*^9}, {3.543576598595274*^9, 
  3.543576609411893*^9}, {3.553592756078411*^9, 3.553592772142119*^9}}],

Cell[BoxData[
 GraphicsBox[
  TagBox[RasterBox[CompressedData["
1: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
mlVKuQFqraBiAJpj7BcPQMUAtMhoi42UWmB0C4AW8Zq1ErYHE9weUDEAbTHb
Yt3bzrERHF4CAGiMUcVu5pYy5qzVBSoGoC3G0S2lz6YXQnEGLwEANEZoi4fV
EFAxAI0xzvoQQkpZuzdENHd8ZRLZ+1vpRXqy4CqOsBCoFNvW8jUAHpmh8o81
OJlBVhZQgheOHvBzP+pt8cbix5WvcxVvZpe+pryUDIDHJ/Y44J0TTS6K7He1
FXsao9ZCyd5xXMXxvPVoXls6kbxCxXEQcpacL2Zsi6dFX7/qbwEAdyFbSBWp
uNoQfwaebDvObLua8+6gipd1KMGzZF6/sSwBndwilFrUlUEWQhXPntacmKFi
8NDMVohoUe8wxJ/B3hBcCtuiZowdVHEgpvFj+PWiU8onGqnQ9SALQcLBNegt
gzYIVRycDJYh13rP83O39nrsqVXxYhgzM01ENBdtNUh0KVQMmoVQsa/Hs+et
7Zo89YulOe/2Kl/bop4VVfJPSqp4PQhx6Sda1KA9chUvVnCfipnorC22Ku77
/vrRrcAmxw5KBm8IaWM7j2gOGwZZYsvvAjG69QZbDJogU/EyrLWzRd1xZvvF
1hA/y25r9W71AWieqV+sdG/8W+OWVbw4YoKGwc9hfNM0LIZQAy2rGICfiNfs
aWhSW6BiAJpj7Bcz4RznuQ0i4AMTgMYYW9TcGuMTl0yoKl8fEgDwjdSo2EmY
2Wb1iYkdMzABAI/A+L64+21VzASH9zwAmmNsUQ/Aky0ALeI165xRS6l0bw+o
GIC2GFXcX+QwQn0zFQcbYZUnkO1ZQrk7YDYB9bBHkWBLzVJKmGQCDrCoZF53
H9bNnb4+rH65UGzYqOkGKk73vCvk5XDtrwpIqfiIR5FgcUd5f2qoGOxmnkE9
Oe250tdHx4Q9fLv6NiqmqnXRfcdy/fTJ/f/t7TW5lPL7MT/Okq0yh+CbKt72
KJLnLSuqTSnbQRPORkA1kyG40teH1lII1vf9reZuEY3QFfcdpIrDHaK3A8bL
uT6X59tnmIGkPV3jUSRfNx1HGT2EsDQS7GdpzV3p62NQsbXFt56BGXu3K7nv
oG0x6dInW7kcd3XDcKnojnkUWVFxnlm4KQB7IVfcHvL1oZSQku/19VHJWLVX
3HdENjFT00rATCr7VFzjUaTcoo5Hy4bwUDHYha9DaUU56uvDyljs9thTJGpO
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
AD+LGhVbQ8yctx4OFQPwgNSo2BpiN+tDu64xVAzAo1Gj4kv/rxIa74sBaJHR
FjMtufL7vEDFALTFrGItzeVyOZ/PUDEAbTGq2A1rnaFiAFpkXA1xkkoZKWWt
V3kAwMPgNcuFcRuQV49RAwAeh3HWh/kjpJPwjtGtfAeK3VuwHSNLOPJUX043
dbZZuiiNgjgVRri/ALfh9qlXOU09HPNInsB7trFPzZldid9yH7HYAzNxwZ6t
WW6EvzmM61PHhZJcVqnYb8r06+0tdbS7awu2Y+R3L/RUv1kTN3+vNOflGKHi
3fHmSQQey3Mf5sUzO5O/5Y3aysQ9aoXXrFG9lsZKuFLFn2Rh8i3YPknv08um
bJn7Xur6aBe2eOO2OUiQk/kvwjXwZIt/vcW7b0QFyTxrh9tPFSJMPWmn+1/S
noc/i9EGtyjfSnPJmL8s2+dnPd0swml3IBdbnkgUfHVTvPzHzEnreH73as6s
pkr/TGRZ5vtcqq55OvNdooNQ9fPr8ekLJiV3kzCtOa5S8bAZVPkXCbZgy/dW
e0kuGoOO7vKJ6+Nd2NZt8fz9clkcMNw9I0g5KVz4UMlqEBVheEVeiiWH2Q43
ZLThvnVJVFEulwBxG2+6Nk935Q4vEeY3grSPWwUhyL7KNwOqOROFL1Wh7Gci
yhLf5427Hd+lUpD72WKvYmuIpb5iZWLeLy7trTZfv9bDTa4nNLKEylUc5ScI
uIh85Z7PMWZRFyMMUiZLsWKkyGhLNyQKtVifYpGTdLMIk9TSDXZL+21tmEWy
HlO9rCtVTP585P1cK0twTeFuE3epFOR+KlZKuQFqra5V8aq+0mv2XV+r4uWn
J/eKChtCeXMijiSy05sRzudLtmiqXalSSntakTckii1WcR5Vnu6KCb1SxaXU
lzxQd/rKFjVtCKj7Waniwt1eU/FKDf8uvGa9r57bq3j57UjbF/zc78kmyPn1
dSqe63ZoTsuiey3tEvvhO01BSisRJi3hrBR0E3092tINjO5t3KLOoiLSJe9w
EGy7Rb2i4qQgRDw5V45uZVVo82cin5bLNSt3O75LpSB3tMVGSi12jW4RkPkn
Rrfilkr09cr1oRHNRreIdtB0dhiNITsya5XL5yzVGxXh/EWo+myQZMljeouK
0dI3MLrbyehWFhWZbhbh9CO4LXeJIYLw2rUWNZE68fssfa301ixBas7kWUxK
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
    "], {{0, 407}, {322, 0}}, {0, 255},
    ColorFunction->RGBColor],
   BoxForm`ImageTag["Byte", ColorSpace -> "RGB", Interleaving -> True],
   Selectable->False],
  BaseStyle->"ImageGraphics",
  ImageSize->Automatic,
  ImageSizeRaw->{322, 407},
  PlotRange->{{0, 322}, {0, 407}}]], "Text",
 CellChangeTimes->{{3.5435211032621994`*^9, 3.543521123535227*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"chickenNutritionFacts", "=", 
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"ServingSize", "\[Rule]", 
       RowBox[{"4", " ", "ounce"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"AmountPerServing", "\[Rule]", " ", 
       RowBox[{"130", " ", "calorie"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"CaloriesFromFat", "\[Rule]", 
       RowBox[{"9.0", " ", "calorie"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"SaturatedFat", "\[Rule]", 
       RowBox[{"0.4", " ", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"Cholesterol", "\[Rule]", 
       RowBox[{"68", "milli", " ", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"Sodium", "\[Rule]", 
       RowBox[{"77", " ", "milli", " ", "gram"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"DietaryFiber", "\[Rule]", 
       RowBox[{"0", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"Sugars", "\[Rule]", 
       RowBox[{"0.1", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"TotalFat", "\[Rule]", 
       RowBox[{"1", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"Protein", "\[Rule]", 
       RowBox[{"27", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"TotalCarbohydrate", "\[Rule]", 
       RowBox[{"0", " ", "gram"}]}]}], "}"}]}], ")"}], "//", 
  "gridRules"}]], "Input",
 CellChangeTimes->{{3.543503379815819*^9, 3.5435034363234687`*^9}}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"ServingSize"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"4"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"ounce"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"AmountPerServing"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"130"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"CaloriesFromFat"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"9.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"SaturatedFat"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"0.4`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"Cholesterol"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"68"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"milli"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"Sodium"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"77"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"milli"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"DietaryFiber"}
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
              {"0"}
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
              {"Sugars"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"0.1`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"TotalFat"}
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
              {"gram"}
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
              {"Protein"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
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
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"TotalCarbohydrate"}
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
              {"0"}
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
 CellChangeTimes->{3.543503437341571*^9, 3.5435210484068017`*^9, 
  3.543521178927766*^9, 3.543523554878351*^9, 3.5435250185060115`*^9, 
  3.543528610726015*^9, 3.5435787837332563`*^9, 3.553555233114012*^9, 
  3.55360195687716*^9, 3.553619268239542*^9, 3.5537724934617443`*^9, 
  3.553785129851369*^9, 3.553785193094623*^9, 3.553789205064604*^9, 
  3.553864880230219*^9}]
}, Open  ]],

Cell["then we would get a different result:", "Text",
 CellChangeTimes->{{3.5535927875009327`*^9, 3.553592797484159*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
  "TotalFat", "+", "DietaryFiber", "+", "Protein", "+", "TotalCarbohydrate"}],
   "/.", "chickenNutritionFacts"}]], "Input",
 CellChangeTimes->{{3.543503450825919*^9, 3.54350345403424*^9}}],

Cell[BoxData[
 RowBox[{"28", " ", "gram"}]], "Output",
 CellChangeTimes->{3.5435034551103473`*^9, 3.543521048483802*^9, 
  3.5435211790007725`*^9, 3.5435235549493585`*^9, 3.5435250185780115`*^9, 
  3.543528610804015*^9, 3.543578783779259*^9, 3.5535552331556892`*^9, 
  3.553601956927772*^9, 3.5536192682909927`*^9, 3.5537724935205183`*^9, 
  3.55378512992738*^9, 3.553785193175304*^9, 3.553789205141509*^9, 
  3.553864880296226*^9}]
}, Open  ]],

Cell[TextData[{
 "The main point here is that ",
 StyleBox["the expression for the sum of the weights ",
  FontSlant->"Italic"],
 "and",
 StyleBox[" the expression of the data object as a list of rules",
  FontSlant->"Italic"],
 " are independent, even of any parameters. We may reuse them separately and \
combine them in arbitrary ways. Alice\[CloseCurlyQuote]s original JavaScript \
code had this independence, too, but she had to package the expression in a \
function. She could not give the expression a completely independent \
existence from the data: the best she could do was parameterize the data, and \
that\[CloseCurlyQuote]s when she encountered her verbosity / repetition \
problem. Here, we don\[CloseCurlyQuote]t need a function and don\
\[CloseCurlyQuote]t need parameters. Getting rid of a function is good just \
because it shortens the code, and ",
 ButtonBox["shorter code is almost always better code",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://www.codinghorror.com/blog/2007/05/the-best-code-is-no-code-at-\
all.html"], None},
  ButtonNote->
   "http://www.codinghorror.com/blog/2007/05/the-best-code-is-no-code-at-all.\
html"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["17"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{
               RowBox[{
                 RowBox[{"www", ".", "codinghorror", ".", "com"}], "/", 
                 "blog"}], "/", "2007"}], "/", "05"}], "/", "the"}], "-", 
         "best", "-", "code", "-", "is", "-", "no", "-", "code", "-", "at", 
         "-", 
         RowBox[{"all", ".", "html"}]}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"0000514D"],
 "]. "
}], "Text",
 CellChangeTimes->{{3.5435034700658426`*^9, 3.543503605208356*^9}, {
  3.5435161627222013`*^9, 3.5435161718021092`*^9}, {3.5435265512500153`*^9, 
  3.5435265807440147`*^9}, {3.543576637631507*^9, 3.5435766845221887`*^9}, {
  3.553592812590695*^9, 3.553592861931723*^9}, {3.553592899825235*^9, 
  3.5535929034896317`*^9}, {3.553770760281111*^9, 3.553770820864435*^9}, {
  3.553771691075474*^9, 3.553771766064468*^9}, {3.553772596655192*^9, 
  3.553772596699821*^9}, {3.553773563107497*^9, 3.55377356316101*^9}, {
  3.553773611008996*^9, 3.5537736110497913`*^9}, {3.553783667882361*^9, 
  3.553783674919262*^9}, {3.553783869118876*^9, 3.553783869165102*^9}, {
  3.55379906662077*^9, 3.5537990666906233`*^9}, {3.553799109693081*^9, 
  3.553799109742646*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["Expressions are Values", "Subsubsection",
 CellChangeTimes->{{3.543526617445015*^9, 3.543526621141015*^9}}],

Cell["\<\
We can save the expression for the total weight in a variable\
\>", "Text",
 CellChangeTimes->{{3.543516252237152*^9, 3.5435162590138297`*^9}, {
  3.553592953864023*^9, 3.553592962598769*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"totalWeight", "=", 
  RowBox[{
  "TotalFat", "+", "DietaryFiber", "+", "Protein", "+", 
   "TotalCarbohydrate"}]}]], "Input",
 CellChangeTimes->{{3.54351626751468*^9, 3.543516270960024*^9}}],

Cell[BoxData[
 RowBox[{"DietaryFiber", "+", "Protein", "+", "TotalCarbohydrate", "+", 
  "TotalFat"}]], "Output",
 CellChangeTimes->{3.543516272373165*^9, 3.5435210485508018`*^9, 
  3.543521179066779*^9, 3.5435235550213656`*^9, 3.5435250186440115`*^9, 
  3.543528610872015*^9, 3.5435787838322625`*^9, 3.553555233190823*^9, 
  3.5536019569948063`*^9, 3.553619268351265*^9, 3.553772493587125*^9, 
  3.553785129995644*^9, 3.553785193256426*^9, 3.553789205226956*^9, 
  3.5538648803512316`*^9}]
}, Open  ]],

Cell[TextData[{
 "The symbol ",
 StyleBox["totalWeight",
  FontSlant->"Italic"],
 " has a value, namely the symbolic, normal-form expression we\
\[CloseCurlyQuote]ve been carrying along. Symbols can rewrite to other \
symbolic expressions; they need not reduce all the way to numbers. Let\
\[CloseCurlyQuote]s symbolically add the little milligram items to it:"
}], "Text",
 CellChangeTimes->{{3.543516276638592*^9, 3.543516327433671*^9}, {
  3.5435767009881306`*^9, 3.543576748059823*^9}, {3.553592986118806*^9, 
  3.5535929867260036`*^9}, {3.553771787231698*^9, 3.553771806622946*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"totalWeight", "+", "Cholesterol", "+", "Sodium"}]], "Input",
 CellChangeTimes->{{3.543516336075535*^9, 3.543516354875415*^9}}],

Cell[BoxData[
 RowBox[{"Cholesterol", "+", "DietaryFiber", "+", "Protein", "+", "Sodium", 
  "+", "TotalCarbohydrate", "+", "TotalFat"}]], "Output",
 CellChangeTimes->{3.543521048613802*^9, 3.5435211791287856`*^9, 
  3.5435235550943727`*^9, 3.5435250187130117`*^9, 3.543528610940015*^9, 
  3.543578783882265*^9, 3.553555233227366*^9, 3.553601957061886*^9, 
  3.553619268396594*^9, 3.553772493653503*^9, 3.5537851300606337`*^9, 
  3.553785193323258*^9, 3.55378920530797*^9, 3.5538648804062366`*^9}]
}, Open  ]],

Cell["And apply the data again:", "Text",
 CellChangeTimes->{{3.5435162127001987`*^9, 3.5435162400049286`*^9}, {
  3.5435163873396606`*^9, 3.543516393580285*^9}, {3.5435767583454113`*^9, 
  3.5435767617456055`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"totalWeight", "+", "Cholesterol", "+", "Sodium"}], "/.", 
  "burgerNutritionFacts"}]], "Input",
 CellChangeTimes->{{3.5435164035272794`*^9, 3.543516409174844*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"30", " ", "gram"}], "+", 
  RowBox[{"130", " ", "gram", " ", "milli"}]}]], "Output",
 CellChangeTimes->{3.5435164099079175`*^9, 3.543521048753802*^9, 
  3.543521179259799*^9, 3.5435235552363873`*^9, 3.5435250188480115`*^9, 
  3.5435286110080147`*^9, 3.5435787839312677`*^9, 3.553555233272561*^9, 
  3.5536019571279097`*^9, 3.553619268439152*^9, 3.553772493704213*^9, 
  3.5537851301302023`*^9, 3.553785193392194*^9, 3.5537892053890123`*^9, 
  3.5538648804602423`*^9}]
}, Open  ]],

Cell["\<\
We see we have incompatible units -- and, as an aside, that the evaluator \
canonically reordered \[OpenCurlyDoubleQuote]milli gram\
\[CloseCurlyDoubleQuote] to \[OpenCurlyDoubleQuote]gram milli.\
\[CloseCurlyDoubleQuote] That\[CloseCurlyQuote]s fine, since \
\[OpenCurlyDoubleQuote]gram milli\[CloseCurlyDoubleQuote] means \
\[OpenCurlyDoubleQuote]gram times milli,\[CloseCurlyDoubleQuote] and \
\[OpenCurlyDoubleQuote]times\[CloseCurlyDoubleQuote] is independent of order \
just like \[OpenCurlyDoubleQuote]plus.\[CloseCurlyDoubleQuote] \
\>", "Text",
 CellChangeTimes->{{3.5435164194298697`*^9, 3.543516479920918*^9}, {
  3.54351655814874*^9, 3.543516579301855*^9}, {3.543518359548609*^9, 
  3.5435184244016085`*^9}, {3.5435267022360153`*^9, 3.5435267157690153`*^9}, {
  3.543576770883128*^9, 3.5435768225900855`*^9}, {3.553771831094967*^9, 
  3.5537718552942333`*^9}}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Without Units, Exposed to Error", "Subsection",
 CellChangeTimes->{{3.553594534072153*^9, 3.553594547831295*^9}}],

Cell["\<\
The fundamental symbolic nature of the computation has caught this units \
incompatibility for us. In Alice\[CloseCurlyQuote]s first JavaScript \
solution, should could only have caught this by manually checking the \
calculation. We could have ended up with a horribly incorrect answer -- 160 \
grams -- and had no way to track it down other than by manual labor. \
\>", "Text",
 CellChangeTimes->{{3.5435164194298697`*^9, 3.543516479920918*^9}, {
  3.54351655814874*^9, 3.543516579301855*^9}, {3.543518359548609*^9, 
  3.543518442824609*^9}, {3.543526734945015*^9, 3.5435267546070147`*^9}, {
  3.5435768543479023`*^9, 3.5435769197056403`*^9}, {3.553594177376275*^9, 
  3.5535942491941023`*^9}, {3.553771981410421*^9, 3.553771993595333*^9}}],

Cell[TextData[{
 "In fact, we should look very suspiciously at this 160. Notice that the \
original nutrition block states that 160 is the ",
 StyleBox["number of calories",
  FontSlant->"Italic"],
 " in a serving. We find later that not only is this number off by nearly a \
factor of four, but that this numerical value 160 doesn\[CloseCurlyQuote]t \
arise from plausible calculations over other data in the nutrition block. \
There is only one instance of the number 160 to be found in this sample, and \
that\[CloseCurlyQuote]s from this wildly mistaken computation of adding grams \
to milligrams. "
}], "Text",
 CellChangeTimes->{{3.5435164194298697`*^9, 3.543516479920918*^9}, {
   3.54351655814874*^9, 3.543516579301855*^9}, {3.543518359548609*^9, 
   3.543518442824609*^9}, {3.543526734945015*^9, 3.5435267546070147`*^9}, {
   3.5435768543479023`*^9, 3.543577083993037*^9}, 3.5435772872656636`*^9, {
   3.553594308368773*^9, 3.55359432193631*^9}, {3.5535944182923403`*^9, 
   3.553594479850078*^9}, {3.553772016067727*^9, 3.553772111088066*^9}}],

Cell["\<\
It's a strong hypothesis that the original authors of the nutrition block \
added up the weights and got a wrong number, then compounded the error by \
putting the wrong number in the wrong slot.\
\>", "Text",
 CellChangeTimes->{{3.5435164194298697`*^9, 3.543516479920918*^9}, {
   3.54351655814874*^9, 3.543516579301855*^9}, {3.543518359548609*^9, 
   3.543518442824609*^9}, {3.543526734945015*^9, 3.5435267546070147`*^9}, {
   3.5435768543479023`*^9, 3.543577083993037*^9}, 3.5435772872656636`*^9, {
   3.553594308368773*^9, 3.55359432193631*^9}, {3.5535944182923403`*^9, 
   3.553594479850078*^9}, {3.553772016067727*^9, 3.553772111088066*^9}}],

Cell[CellGroupData[{

Cell["Robust Unit Conversions Close the Gap", "Subsubsection",
 CellChangeTimes->{{3.55359459788586*^9, 3.553594613813306*^9}, {
  3.5535948373155823`*^9, 3.553594849843296*^9}}],

Cell["\<\
However, with symbolic computing, we can easily write some new rules to \
convert our units to compatible forms:\
\>", "Text",
 CellChangeTimes->{{3.543516510210947*^9, 3.543516549468872*^9}, {
  3.5435770896983633`*^9, 3.5435771079544077`*^9}, {3.553772123543611*^9, 
  3.55377212378356*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"unitsConversions", "=", 
  RowBox[{"{", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"milli", " ", "gram"}], "\[Rule]", 
    RowBox[{"gram", "/", "1000.0"}]}], "\[IndentingNewLine]", 
   "}"}]}]], "Input",
 CellChangeTimes->{{3.5435165846163864`*^9, 3.5435166122251472`*^9}}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"gram", " ", "milli"}], "\[Rule]", 
   RowBox[{"0.001`", " ", "gram"}]}], "}"}]], "Output",
 CellChangeTimes->{3.543516613975322*^9, 3.5435210489078016`*^9, 
  3.5435211793278055`*^9, 3.543523555307394*^9, 3.543525018916012*^9, 
  3.543528611077015*^9, 3.543578783984271*^9, 3.553555233306321*^9, 
  3.553601957196013*^9, 3.553619268501275*^9, 3.553772493775044*^9, 
  3.553785130194727*^9, 3.553785193457768*^9, 3.5537892054556026`*^9, 
  3.553864880515248*^9}]
}, Open  ]],

Cell["\<\
applied, in series, to the expression that produces incompatible units\
\>", "Text",
 CellChangeTimes->{{3.5535949382163687`*^9, 3.553594979225127*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"totalWeight", "+", "Cholesterol", "+", "Sodium"}], "/.", 
   "\[IndentingNewLine]", "burgerNutritionFacts"}], "/.", 
  "\[IndentingNewLine]", "unitsConversions"}]], "Input",
 CellChangeTimes->{{3.5435166211380386`*^9, 3.5435166249344177`*^9}, {
  3.5435181388276443`*^9, 3.54351814057047*^9}}],

Cell[BoxData[
 RowBox[{"30.13`", " ", "gram"}]], "Output",
 CellChangeTimes->{3.5435166256684914`*^9, 3.5435210489738016`*^9, 
  3.543521179393812*^9, 3.5435235553784013`*^9, 3.5435250189830112`*^9, 
  3.543528611147015*^9, 3.543578784035274*^9, 3.5535552333398952`*^9, 
  3.5536019572607117`*^9, 3.553619268546134*^9, 3.553772493821989*^9, 
  3.553785130260954*^9, 3.5537851935255947`*^9, 3.55378920561782*^9, 
  3.5538648805722537`*^9}]
}, Open  ]],

Cell["produces a final, meaningful result.", "Text",
 CellChangeTimes->{{3.553594997509862*^9, 3.553595004941493*^9}}],

Cell[TextData[{
 "We see that we can easily compose ReplaceAll invocations in chains, and now \
we also see why canonicalizing is valuable. We wrote \
\[OpenCurlyDoubleQuote]milli gram\[CloseCurlyDoubleQuote] but ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " saw and matched \[OpenCurlyDoubleQuote]gram milli.\[CloseCurlyDoubleQuote] \
Without canonicalizing, our \[OpenCurlyDoubleQuote]milli gram\
\[CloseCurlyDoubleQuote] would not have matched ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 "\[CloseCurlyQuote]s \[OpenCurlyDoubleQuote]gram milli\
\[CloseCurlyDoubleQuote] and our rule would not have applied."
}], "Text",
 CellChangeTimes->{{3.543518144392088*^9, 3.5435181862259045`*^9}, {
  3.543518231643362*^9, 3.543518354188609*^9}, {3.543518452464609*^9, 
  3.543518467256609*^9}, {3.5435267817580147`*^9, 3.5435268099160147`*^9}, {
  3.5435771329708385`*^9, 3.543577138346146*^9}, {3.553772144343444*^9, 
  3.55377216341476*^9}}],

Cell[TextData[{
 "Now that the point about canonicalization is made, we can see that our ",
 StyleBox["unitsConversions",
  FontSlant->"Italic"],
 " rules are actually more restrictive than necessary. A milli anything is \
1/1000 of the same thing; we don\[CloseCurlyQuote]t need the \
\[OpenCurlyDoubleQuote]gram\[CloseCurlyDoubleQuote] at all. Let\
\[CloseCurlyQuote]s simplify the ",
 StyleBox["unitsConvsersions",
  FontSlant->"Italic"],
 ". Giving a new value -- a new list of rules -- to the variable ",
 StyleBox["unitsConversions",
  FontSlant->"Italic"],
 " just replaces the old value of the variable. In Jacquard and ",
 StyleBox["Mathematica,",
  FontSlant->"Italic"],
 " variables\.7fare mutable."
}], "Text",
 CellChangeTimes->{{3.5435166366725917`*^9, 3.54351669586051*^9}, {
   3.543516727285652*^9, 3.543516762199143*^9}, {3.543518480718609*^9, 
   3.5435185048096085`*^9}, 3.5435772096172223`*^9, {3.553595040093977*^9, 
   3.553595140081889*^9}, {3.553772193359317*^9, 3.553772193413864*^9}, {
   3.5537722490406313`*^9, 3.553772251919767*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"unitsConversions", "=", 
  RowBox[{"{", "\[IndentingNewLine]", 
   RowBox[{"milli", "\[Rule]", 
    RowBox[{"1", "/", "1000.0"}]}], "\[IndentingNewLine]", "}"}]}]], "Input",
 CellChangeTimes->{{3.5435165846163864`*^9, 3.5435166122251472`*^9}, {
  3.543516708573781*^9, 3.5435167157024937`*^9}}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"milli", "\[Rule]", "0.001`"}], "}"}]], "Output",
 CellChangeTimes->{3.543516613975322*^9, 3.543516717571681*^9, 
  3.5435210490418015`*^9, 3.543521179459819*^9, 3.543523555529416*^9, 
  3.5435250190970116`*^9, 3.5435286112180147`*^9, 3.5435787840852766`*^9, 
  3.553555233372267*^9, 3.553601957327901*^9, 3.553619268612042*^9, 
  3.5537724938880033`*^9, 3.5537851304782667`*^9, 3.553785193589014*^9, 
  3.553789205695504*^9, 3.553864880626259*^9}]
}, Open  ]],

Cell[TextData[{
 "Now, as with the earlier ",
 StyleBox["unitsConversion",
  FontSlant->"Italic"],
 ", we get a result in a single unit of measure in the weight dimension ",
 StyleBox["grams",
  FontSlant->"Italic"],
 "."
}], "Text",
 CellChangeTimes->{{3.543526845370015*^9, 3.543526867281015*^9}, {
  3.5435288477430153`*^9, 3.543528850790015*^9}, {3.553595175490377*^9, 
  3.553595204703589*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"totalWeight", "+", "Cholesterol", "+", "Sodium"}], "/.", 
   "\[IndentingNewLine]", "burgerNutritionFacts"}], "/.", 
  "\[IndentingNewLine]", "unitsConversions"}]], "Input",
 CellChangeTimes->{{3.5435166211380386`*^9, 3.5435166249344177`*^9}, {
  3.5435181246370635`*^9, 3.543518128388688*^9}}],

Cell[BoxData[
 RowBox[{"30.13`", " ", "gram"}]], "Output",
 CellChangeTimes->{3.5435166256684914`*^9, 3.5435167215740805`*^9, 
  3.543521049108802*^9, 3.5435211795948324`*^9, 3.5435235556074243`*^9, 
  3.5435250191670113`*^9, 3.543528611364015*^9, 3.5435787841342793`*^9, 
  3.553555233407076*^9, 3.5536019575162992`*^9, 3.553619268679093*^9, 
  3.5537724939550457`*^9, 3.553785130548245*^9, 3.553785193656139*^9, 
  3.553789205743384*^9, 3.5538648807492714`*^9}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["ALICE FINDS A FIB", "Subsection",
 CellChangeTimes->{{3.543517950277501*^9, 3.5435179554609833`*^9}, {
  3.543519196312719*^9, 3.543519209664054*^9}, {3.543526878168015*^9, 
  3.543526882344015*^9}}],

Cell["\<\
The original data block declared that a serving size is four ounces, and we \
added the total weight from components to a little over 30 grams. This doesn\
\[CloseCurlyQuote]t seem like four ounces. Let\[CloseCurlyQuote]s add another \
rule to our units conversions to get everything into ounces.\
\>", "Text",
 CellChangeTimes->{{3.543517959212608*^9, 3.5435180260979185`*^9}, {
  3.553772273347845*^9, 3.553772275740061*^9}}],

Cell["\<\
Ask Bing how many grams there are in an ounce (as an aside, one of us wrote \
the symbolic-processing software that Bing uses to answer such questions -- \
that software is a spiritual ancestor of Jacquard)\
\>", "Text",
 CellChangeTimes->{{3.5435186087466087`*^9, 3.543518612400609*^9}, {
  3.543518651390609*^9, 3.543518768808609*^9}, {3.5435192274328303`*^9, 
  3.5435192325213394`*^9}, {3.543526904088015*^9, 3.543526912391015*^9}, {
  3.5435773366774898`*^9, 3.543577385203265*^9}, {3.5535952367918367`*^9, 
  3.553595238870264*^9}, {3.553595276493532*^9, 3.553595276612694*^9}, {
  3.553772291491144*^9, 3.5537722949552393`*^9}}],

Cell[BoxData[
 GraphicsBox[
  TagBox[RasterBox[CompressedData["
1:eJzsvQecFFW+9+37Pp/3fZ577wbXHNfsSAZRd/eum+66u9e99y5776pIdggq
oICAoIhIUswiYlxFTGBgCYKKAZk8TAImMDnHjjPdE3qme0I/51RVV1c4VV3V
09PdM/P7+nforjp1zv+cOlX16/85VXXV/OX/M/9/nXXWWZf8P2ed9TvygX7+
8pskGAwGg8FgMNjwsrc/PQqDwWAwGAwGG162+ImdMBgMBoPBYLDhZY9vfx8G
g8FgMBgMNrzssRffg8FgMBgMBoPBYDAYDAaDwWBDaszQ3EeVfr+z8GXJkpez
XX6/35Z9UJLsYIrT7688rhfle6/Q5vcXfz6IOOHndX6/K+W92IcrwzKuifx1
H2mtoq13vFinieKi+tRDCdLq6DofaR+GviD2/lIfDrEw3jfFMcgZ7SSx9TD+
fKNnHuZxF/Hq6BwdkepO7DOt0Xw+r4vcgSM9DKN27MNgME3b8PIHatuRQwRb
/R7Jkj2V/uLKenLG2BFcSA9hW84hZg6Cvc9JuMPaCULa4XqqYd4fRA6xNeo/
qwW0lsdb9VV+kp4gcYk7jQ9m/8aXHeKv3eRyKV2+h7tW7hiqQk36pvKE2yOx
9TD+fKNnHtkZbEiqE+LoiFR3OsRLuA1qZ0LnM3RH6Ag79mGwEWRK6UWOVlfK
YbJQIifel381lI95i7mGGaxxP9LDPP3GvvrUT6Xz0gvKCDuNc1VzuhQdO44k
XGV9sbI/kF1QXxxjD+PPt8FLOAPVCXV0RKo7QcLBYDC2bdzxIcuSSvx+e87n
wtcj9X5n0Ss7Pk91+kuOCGle4SJ1e3dIvwoEN/ygyO73l+TQv8pVBu0I1TCp
HwSyOkIdC2b1QTBn0TFieyuDAxvS5fJVrtScQOY6VQjUQivDkMaVGGwoVfPS
z9I8JW4Y9lBoqIg7T/e4vzJJOwHnfA57L7Bdov64Uo+wuoTOKlkr8Z+DPUFj
1ytbz3h9aTtLak3zpP1fZy/IG4qruOhVcPNI7AuSm2z/csdmqtxDdv/Xa97o
+abRUcne5PdX8GDR6+0hjVZHcdBFvDohjw5D3cm4P4rlynzUDSvdpyRlBE6h
6sMwvBaGwWCRsc07P2LaJ1V+f1Uy//nVXBf/WbpQmcDvSvuQ2/ZDek6w5x4W
P7NXGbQv6oXN5VlxJdKz/SdBB4TPmo7xqwLJuJwVGWpWoeQLqT+Sr0ZMkYO0
UvRrcolkbTgeKr2iGQotMHjneR8C7akyriymh7ouBVdJk+mskrWSZqE6rWfM
Dqe18n6qdkpr0au6XZ0ul6URG43mSdMMdl8EfCMbBgrifSOZSz3UPzB1Wj4K
vmn2Cv6zZFu93m70oAv0BNNmrjraR0fo7mSyW8qWG29Y+fE1mFOo8jA0dzKB
wWCRtq2v7mHblw3+1jOv08+H01v9pV9qL3w1uZScYPMOy7b1N3xKPnx0xi5f
9XqeW1hl0GhW7vSPVFmxvnL+EGe49Mrl8s+cfUqv+Hxi7SqIH8I32lbklCgr
V2hGoehBecjlr1rFbRUB5wWvAihyk3sV9F/bJWaX4FtDZ5W0lbQK1Ws903tK
UrR0f+n3E6Eskr60qkFSqYjsi4BvNEMxH6G3yz3U6//s5o2Sb9q9QtmwOr3d
eKcNu0YGqxNsVY2jI2R3MuMPE2MNy+4AYZxCVYeh9HCDwWDRtydf28u2Pdyl
Zw/5nFIqfJAsDK7d+yR/utij2JYc3ZIP4ip1Yn0T0yuy0v8a3JYiLOeuAp8x
M9epAq2+X7mhSXuDE66fsV1NKR2kh+q6R9R5iR0JXEpETyTOS7/quKTTJfR6
i7QgjUJ1Ws9UBatTxM/2vCPk82fV9Fr5BjNDeVMHPrjTv6RX/89k+3SQ+0L0
7Qj36ylQQc6xoIfK6kv6f6jmHXLfQnXU4Cq9djZmewLtH52mFreSHR2hulM4
3TJopht28KdQvcMQBoPFwLa98bGGfZHR6i87+vG2o+TcVfymzsKjDcwfiDTZ
x8UOvzvjY0m26iX6RjPn0tMNuTyD+bC/vnnSLf4o3qdc3rCPmblOFQK1Vi00
Zallmm7orDLmoaIp5HlGwnml7av2B/yUFiT5quOSugPIdrHGKllB7EL1Ws9o
1bi2qk6VbE4zpPXle7tuPyHJHCe/oLWgiYlXtGi6rZjhoPZF0DdaU+6DUKLU
Q+3+r9u8UfFNr6PK92mI49GA0bLknWEImjrU0RGqO4XXLaUFmWrYQZ9CdQ9D
GAwWA3vmrU+17B81fsepr/5+yu2vSZMuJF9lC79uJBeCzE9YmXxSQg7/8q8l
S3QSM01Mr8hK66tOMppV4z+YmRv2ilbflP/SDdtK/v7WV5ltfml7PvNWWvkg
PVQ3snpJeM5r5CNxRuK8tC46LtEPch9ku1hjlawgjUJ1Ws/oblLuHf4QCOy7
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
aoq5hWUVZPPaUpoJl0PgL/eB37C6OvWg9Y0Zrc//yrX1RvumqY5tP2t74dfN
7z1QeTq9tKqutLKujHOAFsHlST9U1ZRUCZ+pV1yJZ4hjgksk8zpxLXWGX0VS
8kVXCI6VcRXkq1YaWBh0m08pX1ISaARSHPkg3YoYqfUZWhxNQ9unKtgy5GtF
dV11XV1DQ31TYz35W1vfUF3bUNdQ30y+1tPlzc31hJq6uqameuZuGiITJWhR
JAwSDgAAokl/Z6vr44csa69sXnhWBI1k2H5oo7QgcnqPznUk3iyaV2R9E/WG
1MYtzbz0HirhiJEPRMJl5tdW1dZX1NSXV9eV19AP1XWczmhsaGpqbOJUSF1D
Y01dY3VdQ009/drYRFaRfxrqiDipa+C2pRtqWnVteV0zyb8691jDNztqP9lg
fX+1bd/62uPvVJ0+UVHbVF7bQGSPmL5SvjmfOedVfQP1ijjQSFwiS4jnxIgP
5GsjXU69qq2vF2qk45K2SYqjuXHZ0s98ceRvTX09La2JuNLALRdagKwi6Um7
lVXX5Z2pSc+vOp5X9UVG1SffVx9Iqfo6q/LrExXHsiu+yqz6KrMiI78yu7CG
JGDupiEyont5eUz+FldW81/DNkg4AACIJt2lx7sy3rU99Jvmu6633DPFMneS
Ze5Ey4IJloXjub9qG9/CLbcuGUPMsngs/cD/XXaD9cEbrMvHWe6/yrHpNk/W
PpK5WBA5vUfnOhJvFs0rsr5RSaYyqYS7LDH17mdO5Z6hwqyqtqGGU0hEC1XV
NpZWNRSV1xWW1eWeqUvJq/k2u/ZIRu3h9JqvTtSm5FXnFVUXlNUXldeXVBK5
RYRcY31jU2090VSN1bXcX5VVUVHUUF3fVNXQUlBjba0saK0uLa5z0K1qG6pq
GhibcFnVUtFIvaqsbSTFFVXUny6tI7Lzu5zaQ6kVh1LKD6aUH06r/D63Nqeo
Nr+07kxFA0lGtuW3qmE5o2OkKeoCjVBcQeuYX1p7Ir/yu5yaz9MqSVmk0K8y
K9NP154qoWtJGtoCZJP6hvLqhuKKhtTTte9+Vbz27ZMznsm7bX3Oz1ZnjV2S
+au1GYnbcx58Pf/eHadXvJE/+/mcVW/mbnwvf94LJ5m7aVgYJBwAAESTgYpv
+l+6tzvxlp6FP+9Z8K89C3/Rs/iWniW39Cz+Wc8SpXmXcsuX3uJdMdX7EGcr
b/Q9NNVH/j48hdqayb6Hp3ofmeJ9dKz/41V9pw+KBZHTe8wvMaPciCpTmyjh
LpiT8tP5qYkv5ecUNdQ2NlUTtdPQXFffVFTe8GlK/aa9pYtfzf3r1uzfPJLz
rw9nTV1xgthND2XduPzEL1Zn//Hx3L9sPrlge+Gmj87s/br4ZCHZ1FJT30yu
6jV1zTX1TTUkN/JXag2NtQ3NNZyR4irrLVX1Vn4J0XXCVtIP3Ofquubahqa6
RurVR99VPfFB6cIdBf+xMfcXq7OIM7xL1KsVJ25emXXb+tw7tp1e+tqZpz4u
O5haXVbdQPKvrefy5/2RZq62hsbqetIItDiixD47Xv34e2fmv3TqL5vzSAvc
FGgB8vfmh7JuXZP9+8dy5rxQsP69og+/rSiqaKqoaXj3aOV9rxSRFhuzOOOK
+Wm8Tr54bupFc5Ivmpe6bndRWU3juvfP5Jc1HkqrXPb66cU7Ty199TRzNw0L
g4QDAIBo4nj4z5bpE4lZ5/7MOucm6/wbrQtupH/nT7UukNjCm6z33mxd9DPr
fbfYHrjJ9uBU2wNTrEsn2xZPsi2ZaHtwgm3ZBNuDE20PTLStGG97eLx12VW2
VWMdW34vFkRO7zG/xIxyYwoVXsJdKMyFS73r6ZPZhfU2m6W6ruGz5KoVb565
fUPO5GUnrrsv/cqFdKT1YjpxLvX82SnnBezCualk+aX3pF25IO26e9MmP5j+
u0ez792R/8G3ZcWVjRaLpaGpharBppb6gNU1NDdZWspqmg+kNez8vGrPsaqD
aXUffFu5++vyb3ObahubG5tb6hqbhcSNvMxrtlks1fUt+1JqV7x15t835E5Z
duLae9OJ7LwskXp1IadCz+eMfCBOkoWXzU+7amHaDfen37Qia9qW3M0fnfn2
VEtjC8mJuES9qpd4JbXq+ubGlpbmlpa0/IbNe0qJSrwxWFwaLY4UNJsaKetC
rizSepfPT024P33Sgxl/WJ9DWnIyd6vIBXPEZPSekUvm0ZtHyCaPv19c39yy
+aMi4sarh8ve/abiu9zahTtP66nK+DZIOAAAiCYtd06wzruF6DfL3JsCsu0m
agunCn8X3Wy99xYi6lpmj2+eeV3LnJ+2zLmM/LUuuN62mCi3G23LJ1upfptE
JdyKCbbV46yrx9oenmglH5ZfLRZETu8xv8SMciNaSG1CFI6TPUSBzN9ekFnY
+OF3FXOfP3nTQyeuXpRBlp8zI+nsu5N+fHfST+5OPn92MpFqNy7P/Nmq7F+s
zp66IuvqRennzEz50d1J/3JX0o+mJ5HPRNf9NDH1phUZf3sy9+WDlYXlTTZb
S32zra7J0tBsJQqqttFqd9gLKpvX7C6esvzEjctP/HrNiSnL0n+1NuvZzyrq
mqwWm62+yUoSk88NTeSbpbSmZdfRitnPnbyZepV+/uzU82al/GQm71jyT2Yk
Xz4/bczijCnLMicvyyQ6iiilc2Ymn313MnH7nJlJJDERdQn3p926Nmfxzvz9
afV1zXar1ULyr2+x8V41ch8aOD9bWx15pS2bPiz5/brshMUZVLLOSiEZktxI
iefNSiY+TFqWcfPKrAkPnrhiQdoFs1N+ND35B3cdP3dmMknJF3cO/ZxMGvBi
TiGThefO4v8mEcn3yK5im82WW9JEissuaSqrtZCKphY0MnfTsDBIOAAAiCbW
e35unXOzZe7NQf1GZJug34jdbJk3uWXm9ZZFN9oe+Xfn0zPats9vfWVx28vz
HU/cbn3gJsuiq61LEmzLJtuWTbI9NN768DhOwo23kQ8PT7CtmSQWRE7vMb/E
jHJraLaoTYzCXTA7mUiRPz2eO397/r8+fILIjx9OTz5/VvK5s5LJ2jFLMv5r
8+mH3ip57rOyXV9XfppUcyCtjti+5Nr3vql8+UDZI7uKiGCbsiyD5EZkHtmQ
yCoirojCWbA9/7OkaiKNbHYHkUlNLXYi54hGKqxsWfp64bkzk/7pb8dJ4v//
f76/amHakx+Xk5RE4DVRQWWz2hxWm/2bnIYHXyskupEIpB/elURcJe5dODf1
yoXpv1uXvfiVgs17St/6onzPsWri2CfHaz78rur1wxUbPyyd/xKpS/YVC4jk
Szl3NhVUP7jz+MVzk299JHfDB2WZRU02u7PJYm9stjVb7MRIoS1We7PVcTCt
dt6L+USn/eCuJFLoRXOJ7iLtk/qbR3MXvVL81CcVu45WfZJU/Y+U2o+P15DP
L/6jnHj4pw15Vy1MJymJZruEi8tdwg1SX5aYev39GZOXnbjlocxfrMqYsuLE
Lx/OemFfSVubkxhRbm2tTrvdQYrucDmZu2lYGCQcAABEE+ucW6yifptP9ZuF
E3IWTsVZ7plAxJvj8TtcH2725OzzNRT2tVn7ezr73Nbu00fcnz7jfHaGdeVU
y9IbiH6zSfQb+Uvl3JpxYkHk9B7zS8woN6JV1MZLODrMN4eOk/50ftrZM6j6
uvSeFG50NflnKzOXvFa041DlV9lNpbV2V1ur19PW3Ums1dPRSj74PK3dHY7a
Rsv3ebXvfFWx6u9Fv300m2R13uxkIl3OnUXjcreuyd6+v7yizup0Ookka2gh
+ThLaqyr3y65PDGVlHLlwrTzZiVNWpb58qEq4pXDScSe3eGwExX38fHav249
RXTUj6Yn8WOmRCKOW5I257lTT+4t/yy5Jr+CJHX2dDq9xJMu6hhxqaerlSix
7OKmj47VPPFh6X9vzb32XrrhJXTMN5UIuUvmpc3fXvhtbj0phZTUbKHijeTT
ZHW+923N7x/LPntGEhFjxD2iwchWv12Xs/79kn0p9XllJFVbT2cbKYJU39tF
inO5XaQ6liOZ9cSlPz2eR5wkcvFi+rQ94VaRf9+Q+9rhyo++q9xzrHLX19Xv
f1uVUVhvI+Va7RYbEY32FvrBwdxHw8Yg4QAAIIpQ/baAC7vNFwdPbxJU3D03
Wpf93PXR2l5rNZ94ILCV+KGv3d5+8Hnr+l9aV421Edkm6LdxltXjbGvH2tbf
IBZEJ8rE/BIzuq3FyjAhCjc7KDa4iW1EgKVce1/69GdOvXu0sqbJQbRKu7uV
SI4WIjOsRHgEjf9qtTta21p7PG2NFvu+5NoFLxdcfz8Xj5pHZGHqD+86fsWC
tE0flpTVWlrbnCQTkltpre2ht4ov5dTO5fNTiW4kzry4v5KsbW0lSs9hszs+
Tar7xWqqpi7ixnlJyivmp/7X5twX9pWcKm3qbG/t6mizO51E/IieSF0iirGr
s63V6Ug9Xb/h/TO3rs2+mIs3EpfOn51yzqykO57MJTKPeE5kI4H8/Uda482r
aBDyknto9Oz8WUTNpt797On9aQ12J9FsrSQhX5xYFlecnTQOEXJE4n6T25T4
UsE1i6hi5GcYnjsr5XePZu9PqXG7SA4u3u02F2lPp9qYu2lYmDEJV7It4ayz
EraVRO4kBqICdhwAcQc3WsoyouWW3dr57bskzUBvr5+XbQOidiMfOfroqu6T
x2zrbuPFG72XgQi5R8bZ14+xPTZWTE9O7zG/xIxyI5JGbYKEm8PdLDmPv1uB
jpxed1/6I7tLSmrtHe0uIoWsdifRaA5nm7OVbWQVMZLMZm8jEqWm0fbMZ1UT
HsgkEojkfHkinRhGPmz+qLimye5qayPZltfZV/695FKqcOhMtp/MSBq/NOOl
A1VEwbW1kUxcqQWWvz2Vf87MJP4uAOLYNYvS73ulILu4ud1NkrQFvGI7xrtE
crPanCQ9yfTzzMa/bj1Jhdmc5Mu4OCGp+INvFpfU0Gq62pwZhQ23b8wjxV3A
xSQvmEOjcHc+fSqvzO52t/HtwGfLLI4IMIvNSUQaqf7a3UU0CEmkIBeLO3tG
8s0rs4i6Iw4TKcjl08psSeZuGhYGCTeiwY4DIO7gZr4F71+wLOBCcItubkkc
2/nV2wO93gFetvX3dmcfbHv7AfsTf7Bv/M/Wv6/pOr57wNdD1gz09w/093Xn
fWldOcaycqx11XjrI2Ntj42htl4m4WJ+iRnlRpSD2kQJR3QLH4Ujds296c9+
VlHT1Op2u51trjaXq7XN5aTCyuVyuduIkYVtbfwSGk7ilhPjPpCv7o52t93p
evdo5dQVmdywLA3xnT87+aqFaR8ca7Q52ru73JUNjjW7lBJu+4EqZ6vL7XbZ
Wzue2Vd9KVWVdDyXn1S26u3i2ibikbvd3c4X3cY5xjsgOim6xC/hFtJNSM6p
Jfa/PnWaH1Hl3kmRfP39GYfS6/p73BUNrVs/rrw8MY2svZiLRp59d/IfH8/N
LbW4XO1k81YuW5q52BSSv9yHNrLK0er2dLrKai13PZ1/CZ0ZmMLXkSi6hS8X
VjU4vB43JwKF3Hg/Azkz9tFwMUg4AACIJvL7T+mHlvk3WuZNan17lY8bPx0Y
6O911Lt2P2Rf+xvrAxMt919jue8667IptrW3Ol+601uVwwfm+jxu14GttvXj
rWuvs60XQnD2x8aIBZHTe8wvMaPcmDEfSRQulRvySyaSY+27ZRX1zp4uIpOo
YHNJzO1qd1Fzu1TL3YHlbXSbdk9nu93RumVPWcL96efMpAKG6CWS+e/W5R47
2Tww0FVe51zzbumliannCBIuedyS9Jf2VzqpBGrPKWmZ/dzpH0w/Lsi/WSm/
eyzr8In6AW8n8UrtgzvkEios27u6OnYcouFBUtNLuEeRENvwYTnJM7fU+pfN
py6YnXwBEV3zUkmJ192XuunDM12d7Z3t7VyhjPzFv2JxRGKS9ESZfZzSMHnZ
CW4KH1XI/H2syQVOX3enk8pKQfsp/NSKc8a/QcIBAEA0kQyeTuVmwd1kSZxi
XTTFU5TW3+cbGBjobW1ufWuJZfG4lkXXWh+YYHtosm3FFNsD4y0PXtuy5DLH
C3f1VBf4uVict6XS/vjNtoevtG8Yb3t0jG39GPsmWRQu5peYUW5tfABNbqKE
u4R71hnRM79dl5Ne7Oj2dLrdJEG7uz0coyLO3U7Ez6kK25wXCs7nRBF/X8A5
M5K2fVLR5emoanQ+vItKOGkUbsehamebu9/XeSCt/nePZpOF/EDkeTNTlv/9
TGm9w9PVQaN05l2iWsnd7ulqP3ay5T82njz77iT+lg0i2GY8d6qsoe3bPOv4
BzLoQ9vmCCG4P6zP/TK7sbOTSL/2NrehQvlS+L+l9a7/efL0+dwjRGggbmbS
+bOT3/2uweki+XEi0M1uumFqJiXcgWlnCagEHZfmLPVqlfzj8pAs0NSHNCFd
Hsw5kEpS1rQDqm1YXoilSDYV17I84JYpMmcXk7DtgHR7YcNAOYHFmo6FU015
Zppeymum1wKha2m4MfU8Ydaf0fxm3ZY6qm4NWdH4IQJijqjfLFwsriVxasv8
qbYnbvc2Vw8QYdbX2537ZcvCq61LJ1mJclsxybZsIn1+yKoJ1jUTbI/e2HLv
xe1fvNLv7aHRuh6P9Y1Z1kcTbOsSrOvHOjaNbd0yXiyInN5jfokZ5UYFg8rE
2xk40ZJ09cK0pz6psDo7erq7XK6O9o7OjrCsvYPIng6iAEk+rx2uHLckjXs8
WuoldFZY0szn8otrnM0296p3Si4JDqQen/BA5s7DNW2ujoG+7je/qp2y/MT5
s5Iv5qJw58xM3vZpha2VaJwON8k9DJeErTryKhxzXyw4d1ZwePfPG7PySlu+
ONF47b1p3KS7lMsSU354V9L0p08XVDvaaSuImxuqOPdfZ3VTx5LXiq9YkErD
evek8PeoPr+/osnu6vZ0udzsDJm7aViYGQk3bZr0KqySaSqEi6niCi1cbnX1
UzBlwrZt0xSZKguT56SEIYfUa9U+cF6ytRE7J3lBCQkJkqW6jpmuplxYKVYy
d5ykkua2DKsxjbaY2LoGJJxOWYz1kv3G3FpH8wIw9Ej1m3XBTS33TLHcN9X5
xv29tho/DcE1tX+y1Xr/WOvyibblnH4jH1byzw8Zb10z0bLsSte7y3wtlQNU
wnU5v9pm3TjF8ci1ji0THFvHtm2SSbiYX2JGu7GiRuJDRS5LpPeNjn8g89CJ
Fpe70+Ppam/v7OzsEq1D8tmIUTXS3jHQ2/1lVuPv12UTDUbvSphLbyL49SPZ
3+S1ONo6Hn6nVDEXbufhalK6z9vz0sHqcUvpg4Uv4V4JQeTli/srqIDjdI5m
obr+kLVdnV0F1c6FOwovmCMMpJIifvNIVkZh03e5TWOXZF7EDa1enkgfPPLf
W0/lljk6aKZdOoWqCqJJyYfyxvb7dp65Yn4qd3MElXAXzkl+6WCVxeHu9njc
7YwMSVHhhT3jwUxIuLNUMiJwKRREheTKKFsiC2iJ11S2wJPCFHsMN4Svcp/E
JQoloPBDwwttBSdsp5YQCnmjzEzTsbCqqZkZy1tDLaBgMI3JzkuzexiUcDo7
TtV4irSqGDBEHIgl/OAp/zg4C/08wfbAZNd7j/Q5mwf8fm9dftvri6wPjrc+
ONG6jJNwq4h+o/csUBW3ZoJl+XWtO2f0lKWSrAa83V1fvWHffLNz3TWtWyba
to61b5ENpMb8EjPKjRnzGbuEGzqcSx8E9+PpSbesyjpeaCVCgkq4zs6OLmqc
8BFM+lX8zCdTpuzsbO/o9Hq70oqsf3vq1I/vTuLF2PmzUyYvy9yf3uhq73xk
d+llkoFUPgpHlnd3d28/WE1vaOXuOyBb/WRG8ksHqtycfOPEFNsT5lfBQ24r
QlFN66KXi84PROGIYJu64kRyoT27rPXnq7OIyqKC9p7UH08//suHc/alNfl6
urpoa3Ro1VfhSTtXDvn/dFXrnzfmcTel0vAj+XDhnJSPkpvaqSSkjcN2PtzI
Z8zNjITTGg1lagjptVSiOuhifuRRsrGG/lDlK78+i0sYm6tH3dTbyrKXZxRK
wbFGb+USTksjMIYDTVYzEIQzNCKo1kJGxZ+uz6ayCtk9jEg4rbJ0oqVau0J/
iByAIScQhZvasmCq9b4bacBt6ZS2d1f3OhrpRDhblfvDtZbFNxAJR/SbdRX3
8N5V4sN7J1oeuNL190Rf/SkahfN2t3+50/7MzdZ119ieGOfYOs6+WXY7Q8wv
MaPdOhmmiMLdsvJEVnFLd7enp6eb6LjO7i5iXd0eT7eHyCrygf/KG/ns4Vbx
yfiv/Cq60EOEjKe3tye31DLzmbwf3U1V4sVz6U0NRJvtS23q6PSseVd2RypZ
/uqRandnV4+358WDVeMfyBSjcJyEq6QyjIhLj0ftiZaTwQQeupakKalrve+V
ovO4sWN6B+6clEnLThzPtzbaXbNfOEVfLTGbPgmESM0rF6at211KSuvp8XR4
qNbqUtXXIym9i6t1R1eXr7fb3dG1+9v6GxZn/HB6Ev984PNmJd+4PCuv3Onv
97o6qUr2SJqR95N4yNxNQ2ZdnBkNMOpbuLczSJZoyCil7OA/0k/k8iku0LsE
q9bpX+v1B/9CbSvVkjpOMVfJctKcWKfhmOlq6o8cansWsgUYm4bbmFqNw1xs
bC6cwU1DVsGEAAZgSAgOpN43xfbAZOv9E61LJzu2z+q11/npTQq9nvRPLfdd
S9+CunoCP35qe1iQcLY1k6zLL+r48pkBr5ck7u3utO1/xPbUJMem6+1PjicS
jphYEJVwUbmOxJtF94qsZ10sfr46iwgMIlcuS0z7wZ3HiaL7MqeZiCtvD6fA
OGXiCagj6Vel8UiWdHGhqIG+nq/zmv64IZtosEs4CUcE2y/XZH2XZ3F3eNbu
Zki4dg0Jt/1gFRdI89D/xELlbghOqpzh/aH/dntK69z3vXLmvNnJQQn34Ikv
sy0DA97Xv6i7nBv35F5bn0Jc+sXq7M9PNJNCvVRcdenVnWpL2mZEwnm93acq
Xbc9lss/pOUy7rF4P12Q+viH5VZHB2kTLs4pz4H339PN3E1DBB/369IIXZq1
6Eg4UR8JCk6MhOhGRExqG/WtFqqxP13VEZ6sVOWkMa9OO/BmWqnK89TVJGFL
uME2Zsg1MZZwCMOB2EH12/ybLPdPsS2ZZF0ymZhl8QTL0hu8lTl+7nG+vsYS
25O3W1eNsxLltmYiffPpwzT+Rj7Y193Q8uK/dZYdpxkNDPR12J0v/dG24RrH
k+PsW8banxzreG6CWBA5vUfnOhJvFj90s5jzfN5196adyz304+y7k65ZlPb8
/jKHq72/z9vZ1c1pIkIPZ4HPnh5GRj0eLkmPsAlN00NyGOj3vflV7bgl6bwu
upiLbs18Lv9MbavD1bn2XelA6nFOwtVwApLOhZsgl3Av7q8k3YOKME+34ENP
j8Q3zjG+dLJc9JFP6enxcMvJipK69nt3Fp83O0kcSJ28LOtQZovf319a71pA
p8mlEIFHlC35QOz363O/z7eQBunr9RLZSSrV1UUELs2QU1/UH9JUxDMiPkkR
vb09mSWOOS8UXcK9C4x7KRi9aeL2Dblnatp8Xs4dsZW4hgp4K3E7Koi6lxm6
NGsRkHChR8r8gehbiTiAymu3bbpjWua0DUNcmVQdgobTGdo1PJCqGnPWdiw8
CafKLbR+MpPt4BtTo7Ky9NKBVP15d/p9T3cgFfE2EG/Qp4jcR5TbJN5sSydb
iYS7P6H9wNN9bRai4Qb6ensqsu3P/FfL0ssty66k8bdVY60PXWNd9VPrxl91
nTzS7yOX6d7+ni5P1seOrZPsT1xj3zKeqDjHsxPscgkXnetIvFn0rseh8LDs
w2P1NyzO/Oc7j/90Pv+m1OTb1mcX1bYSuUIlXA+PlzP1ZwnCYmEVr6zIl+pm
96JXzpw3Uwh5XTaf3pH67L5qT4+vwdrx6O4yxVy4V4/UUh3kZUi47QerqfLh
MhcK8nol/kgcI8u9Us/oX24juqK03r1o55nzxSgcNxfui6yWgYF+UuMTpY47
njp1zowk+jKvBWncY+KS/7Qh762vamtbOvwDveRnTX8vzYfzpJtvo/4+H1k+
0Oe1tXZ8ltp4x7bT/KNaSO2IkPvR9OO/XZfzRZaFpOz19YjNGvBZ9JZ+YO6m
ITL+X4/YPwZHJCRcyPnqYvqEBNk23H2b2uGQMCScJLlizpjR0BZ3363OZd/Y
7Qx6E+iVk9nMVZOhIdUzFZlZmZZwg2tMZWY63UOuQRUNamSmnLKjKW52kLUW
7mcAscZ6/xROuXH6jRdyD060PXSjddUUz6lvBuizQvpIMm/N6Y6vdra9utCy
6dctT9zaun2m67N13SVpAz3dJAVJ4Gsqad1+u33LGNumGxxPjbc/O8Hx3ARF
FC4615F4I5pX5BDX6x6GNdg67ngq7+y7jweeXUZvH9i0p8Lp9vj9vW4a9KLC
R05QeUiXeXmF5PXSkJynu89HBdaz+6rGLM7g301AxBL5cOvanKR8O+kStS3t
694LRuHOnkHnyO08Utvl6SZ5qCXcjs9ruTl6VDpJSpX+5UWQl9dwQZd4rRdQ
fqX17YteKb5AIuFueijrqxwLfUC1h9Y2qcA298UCIsB+cCdplhT+PVmTH8xY
+lrxB983ZBbbK5tcba52kmevr5dkSVqp3tqeU+b4OKlh7a6SW9dkX8DdE0H+
/sudx4kU/OvW04cyW7h68S3XLWs1mQz1MnfTUBnfNYLh00FlFxEJx37QBWMD
ZVxOcwAwmCKcgVTWkJkh1RHaJ0lNNGprYNBT5pjpKBw7O50HoAxuIDXsxgyV
m2IMW7qGe3yNQbcZu0OSmr2zEJkDsYSINxp5WyroN9uySdZlky33jWl97T5v
Yym9SaG3h381an+Px1dT1Hnyi468w96KXJ+jUczE11jiem+R/YnrbZvG2J8a
R8Xb8xPs6ihcVK4jcWexLj/oiLdHbV5f94G0+ptXZHIvERAkzbilGW9+Vefu
6vYP9AaiXoqYm1ce6Qri8dC/ZMOOrp7PUptuXpl19t1czvPos92umJ/6ztd1
TndXf39vo10RhUsevzTz1cM1XV00b7WEe/lQDe0lXOyLUbAYxpLEtALCiC7q
5oJwRFeWNbjvVUbhiISzkj7e3unhAmW+UxXOte+W3rwq69J7Un5w1/HzZ1Px
SVTfhAfS//vJUyvfLnnlYMW739Z/+H3ze981vHqkdv0HZdOfPT11eeYFs5LP
mSHcgnrlwvRfP5K9/M3i1CJHf6/PwzdNtzQ0KBovQxk7aGgtGKdUOhSGRUjC
+ZUXS60HrCrDJXoXU/MjjDIpINw1YWjCld4yTddEPaB+tK8yCx3HwhlIVQgT
7ZDSIG5nGHxjqj3R9ji4mmZi1m0Tj/aFfAMxh85/C+q3KdYHx1kWX+N8IbG3
pcbPv/90QPJuezlkeX+X21ue4XpvoW3txY4nJ9ifHMcH3+zPjHe8MNHx0kQx
MTm9R+c6EncW6/IljngZ5vW5O73bPqu+YXE60R4Xz025mD7tNmXCAxk7Pq+x
tVI55e/39vloHlQF8qEsr48zbn91k4VeTlv1+HzegT5ff7/X0tr1wfGmW1ae
oI9fo3cxpBANduXCtDW7Sq2t7QMDJM/eFmfnuvfKJFE4OpD62pFaj4eqGSLh
FLczvPx5DT8YKnQRMegmicP5hP+4tT7OaBWFRT6fj8izimbXfa8VnScfSD2a
ayE9mpvL5u329Ph7va0dXYeyWua/XDhhWeYVC1L4W0qJHP3h9CSiRYnDlyWm
XbUw9aqFaZeRfObQRwHzjwvmlfCFc5InPnjinaO1XSQ3fy83E5G2lq9H8M3L
C0rBfNQ5+kFjNw2RiVHVYLwyfDMm4UYLYU6ewpwrAIBhbJx+o7ZsMtVvS662
P3O7ty6ffzUDSdDntnmyD/RUZvsctX3ttr7ONmpum89Z72s43fn9Tufzv7Gv
v9rx1GQ6/+15Gnkj4o38tb8wwbFjklgQOb1H5zoSbxbVK7KuscNWXNPbXd3b
Pq2+7t40fnr/JfPovLirF6YuffVMdqmzo7M7oDK8vZwKkhJYQtd6uulIYHFd
62Pv0Vejcq9eFV4Pes2itGVvFlucXf19vUQpkZ7V7Oh6dHfw0b4/nnF84oM0
+sdLnRcPVE2QP9p3x6FaT3c3L958GgQ0nC/gkU9QRlTDCVG48ibXva+eOX9W
knQglZNw/URuccn5iXNUkTrcnmMFtnW7i257LCfh/owr5qcSV8mGfJxNME62
XZ5IP/AvXb2IPjsl5apFRLKWna5y0RFUsZ+LvokeenkPBa2pFWAcUryBv4Mx
SDgJRp6Tpk6jczcBAAAosS2ZbOPHT5dPti65zvHsf3rKT9DIW38/DbL5vJ3f
v2Ndfq1l9diWN+50HVzf+f0bHcfecu9/omX3XPvmSfbHr7FvHevYysXfnp8o
xN9enmjfPtFGPjwvj8JF5ToSbxY/qKa0yea2uTq6PzjWePPKrAtmJ1/EqTga
kZuXOnV55qPvFqUV2hwuoq08RGL09vb6RD3iJfqNKo+ubh/J4USJbcve8l8/
knvpPF680fl1582iMb2nP6u0uzx9nEDiA1NqCUeSvfElN+GNk3Dj1RJOGIbU
qYt2JWUSrug8uYT7ipNwRFuK6XmNRdQpaR13p6fR3plZ7CRNtHlP5cIdhdO2
nrp948l/f+Ik+fu3p04tea3o0ffK7ng6/7r7Mi6YzbUeZz+dn3rLyhM7D9e2
uj2BtvbyKjEeEH9CKYOCYRkkHEdwJC7kPHczU9EAAECJbelk+s7TlVMti652
Pndnd1U2HTsNhOC6Uj+2rp5iWzPB9tgY+/qxtsfGcn/H2B8fyz/2zU7+bhnr
2Dae12/cLLiJxOjtDC9OdO6cLBZEo3BRuY7Em8UPWpErXlEM9Pd293hTCu33
7Sy6ZlEakUxEipw/J4UoumsWpU5dceLOp/O3fFz6WWp9apH9ZKWjsMZVUO3K
KbWnFNoOZjQ/82nZzOfzf746+1oayqMPmrtwDn2u2mWJqTOfPfVFVou7o8ff
38uHxDzdXtLDLM6u9R+UEZFz/hw6xnrurKQpyzP/frSuu9tLROKOz2smLaOv
u7p8fuqliannz0p+5XBNN73bwKdfF506kr99vt6KFveSN85cxL1F69J7iNzi
o3A20us9XBROQT89FvqI0fihp8fh7m62e+osXTUtHVUt7eRvraWz2dFpbe1q
sHV9kdMy54V84jAfgSTq9LxZyWMWp2/8qNzp9gSDhXGGMigYlkHCcajuMzWS
GvINAGAeqt+WT7StmGJZmuDev41OZOrr6/f1kFWd37xteXiqdfVY+2Njbetv
sD92g/WR622PX2/flGDbmODYMsaxdax9M9Fvgflvz463PTvesWOS44UJ9ucn
OHdOcrwiG0iNznUk3ix+YOu6Xh+Nqvl8RBzRJ2YM9JY3uvckNc/fXjhleQZR
OGfPSP6XO5P+9/98f87MpITFab9ck/WnDXn/ufnkX7ac/q8tp/+8Me+PG/J+
9UjO2CVEgyX/0x3H/+nO42fPSLp4LtUtM57N3/1dQ0m9y0cf/tzXIzQH0Yq+
AX9/o61j2Rv0tgJ62+bslP/9t+NXL0p76UCVp9tHxN62T6uuWphOlORPZib/
ZEby/zvt2LP7qnvELFTwA7riZ/6fXklCHxcxJBKurLF91gsF//t/6L2iPyb5
z0i+7t60Q5kW8tOly9Ojypbmy+tx8pV7qEg/Nw9UYf289fX6SAM+94/KcUsy
uEfh0Xd1/Wj68RsWp794oKqjq4ek8IqVUHjIfYmmqo8skHAAABBNqH6jEu5G
y+Kr2g9tE5e709+3bPildfnVtsfHCyG4dWNsT4x1bhnfumU8//5TB9FvT4+n
+u1ZOn5KZ8G9Msnx4kT7SxMdnH5TSLhYX2FGO0xdx0mfoIojiagUIUKu3v3R
8ca1u0r/9tTJf12TOWZxxuWJqUTw/K+/fn/Wf3wn2H8SO0Y//OXYD++ir5FK
uD/jllUn/rr11Kq3S3d/W3+qspWIMbL3+cwDwoqXi33W1q6nPq24ZeWJWx46
8dt1OTc9dOL2jbnvf19P1hIh9PbR+tsey5m6IvNXa7N/tSZ78rJMkiE/Dsms
Cy+HpJXyKebtCXK1t7al89Hd5TeuyLh1beYvH876xcOZf9mcm5TPReG6lTn3
ivnwWo7ejkD893l6vILRWzm8ZDtiXXQqIGnAAXdH98uHqq9ZlH4efccrfZPX
T2Yk3bTixNd5FqJC+/p6+eFUhYe9ymmGwwxIOAAAiCa2h6bYHpxkXTnJsvxa
x1N/6vjqdU/uVx2HX7Zs/E3Lqmvs68cR8WYl4m3dmNYN3JjpFqLixtm3jHFw
8Tc7P2b6wgT7y9wtDLx+20HE20THK5Odr04VCzIShQNDSy/D+nr7iKrp6+sT
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
VNNNIZEKAAAAAMCbx/8Bn9U6qw==
    "], {{0, 282}, {833, 0}}, {0, 255},
    ColorFunction->RGBColor],
   BoxForm`ImageTag["Byte", ColorSpace -> "RGB", Interleaving -> True],
   Selectable->False],
  BaseStyle->"ImageGraphics",
  ImageSize->Automatic,
  ImageSizeRaw->{833, 282},
  PlotRange->{{0, 833}, {0, 282}}]], "Text",
 CellChangeTimes->{3.5435268943760147`*^9}],

Cell[TextData[{
 "Now capture this in our ",
 StyleBox["unitsConversions ",
  FontSlant->"Italic"],
 "rule block:"
}], "Text",
 CellChangeTimes->{{3.543518777823609*^9, 3.5435187910386086`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"unitsConversions", "=", 
  RowBox[{"{", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"milli", "\[Rule]", 
     RowBox[{"1", "/", "1000.0"}]}], ",", "\[IndentingNewLine]", 
    RowBox[{"gram", "\[Rule]", 
     RowBox[{"ounce", "/", "28.35"}]}]}], "\[IndentingNewLine]", 
   "}"}]}]], "Input",
 CellChangeTimes->{{3.543518028164712*^9, 3.543518041545374*^9}, {
  3.5435180910734205`*^9, 3.543518105352992*^9}}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"milli", "\[Rule]", "0.001`"}], ",", 
   RowBox[{"gram", "\[Rule]", 
    RowBox[{"0.03527336860670194`", " ", "ounce"}]}]}], "}"}]], "Output",
 CellChangeTimes->{3.5435181066498623`*^9, 3.543521049246802*^9, 
  3.5435211797398467`*^9, 3.54352355576044*^9, 3.5435250193180113`*^9, 
  3.543528611433015*^9, 3.5435787841832824`*^9, 3.553555233439*^9, 
  3.553601957566348*^9, 3.553619268748551*^9, 3.5537724940217857`*^9, 
  3.553785130631673*^9, 3.5537851938118973`*^9, 3.553789205825696*^9, 
  3.553864880805277*^9}]
}, Open  ]],

Cell["and apply it to the data again", "Text",
 CellChangeTimes->{{3.543577413153864*^9, 3.543577425881592*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"totalOunces", "=", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"totalWeight", "+", "Cholesterol", "+", "Sodium"}], "/.", 
    "\[IndentingNewLine]", "burgerNutritionFacts"}], "/.", 
   "\[IndentingNewLine]", "unitsConversions"}]}]], "Input",
 CellChangeTimes->{{3.5435166211380386`*^9, 3.5435166249344177`*^9}, {
   3.5435191814482327`*^9, 3.543519183703458*^9}, {3.5435208521108017`*^9, 
   3.5435208585348015`*^9}, 3.543521015703802*^9}],

Cell[BoxData[
 RowBox[{"1.0627865961199294`", " ", "ounce"}]], "Output",
 CellChangeTimes->{3.5435166256684914`*^9, 3.5435167215740805`*^9, 
  3.5435181162499027`*^9, 3.5435208595088015`*^9, 3.543521049316802*^9, 
  3.543521179802853*^9, 3.5435235558284464`*^9, 3.5435250193850117`*^9, 
  3.543528611503015*^9, 3.543578784233285*^9, 3.553555233473287*^9, 
  3.5536019576111298`*^9, 3.553619268806864*^9, 3.553772494163015*^9, 
  3.55378513071425*^9, 3.553785193871748*^9, 3.553789205887578*^9, 
  3.5538648808602824`*^9}]
}, Open  ]],

Cell["\<\
Whoa! The NFL reports that a serving size is 4 ounces, but adding up the \
weights of the ingredients yields only 1 ounce. So, even if we believed the \
reported 160 calories in the NFL, could that be for 1 ounce? If so, the real \
calories for 4 ounces would be over 600. \
\>", "Text",
 CellChangeTimes->{{3.543518521357609*^9, 3.5435185900246086`*^9}, {
   3.5535953304370127`*^9, 3.553595333530757*^9}, 3.553595392170847*^9, {
   3.553595699256315*^9, 3.553595951760886*^9}, {3.553627557610653*^9, 
   3.553627584529002*^9}, 3.553772329731883*^9}],

Cell[TextData[{
 "There is certainly strong incentive to fib, here. No one wants to eat a \
1-ounce burger patty, so maybe just report a reasonable size like 4 ounces. \
That's rather standard for a serving of meat, no? But no one will eat a \
600-calorie burger patty, so let's just report the calories for 1 ounce. It ",
 StyleBox["could",
  FontSlant->"Italic"],
 " be the result of a cascade of honest mistakes, and we've certainly seen \
that they're all-too-easy without symbolic computing. But it's perhaps even \
more plausible that there is some willful malfeasance going on. "
}], "Text",
 CellChangeTimes->{{3.543518521357609*^9, 3.5435185900246086`*^9}, {
   3.5535953304370127`*^9, 3.553595333530757*^9}, 3.553595392170847*^9, {
   3.553595699256315*^9, 3.553595951760886*^9}, {3.553627557610653*^9, 
   3.553627584529002*^9}, {3.553772329731883*^9, 3.5537724123444147`*^9}}],

Cell["\<\
Let\[CloseCurlyQuote]s check the calories in detail. The NFL reports 81.0 \
calories from fat in a serving, but it incorrectly reports that a serving has \
9 grams of fat; it should be closer to 36 grams. Does the advertised \
\[OpenCurlyDoubleQuote]81 calories\[CloseCurlyDoubleQuote] pertain to the \
advertized serving of four ounces or to the implied serving of one ounce?\
\>", "Text",
 CellChangeTimes->{{3.543518521357609*^9, 3.5435185900246086`*^9}, {
   3.5535953304370127`*^9, 3.553595333530757*^9}, 3.553595392170847*^9, {
   3.553595699256315*^9, 3.5535957173902187`*^9}, {3.553595964262035*^9, 
   3.553595995830583*^9}}],

Cell["Let's ask Bing how many calories there are in a gram of fat:", "Text",
 CellChangeTimes->{{3.5435188603876085`*^9, 3.5435189159126816`*^9}, {
  3.543519262043291*^9, 3.543519287195806*^9}}],

Cell[BoxData[
 GraphicsBox[
  TagBox[RasterBox[CompressedData["
1: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
phbUVNbUV9TUl1fXVVTXIymvqi+rrC+trCutrD9TVVeGpLquvKYOJSivri+r
qi9FUsn9raor5U5WVKHb68uxEk6D+Jc74G+srU0/aH9tevuzv/Rsu8G5eYpr
+087nvtV6zv3V5/OLK9pKK9uqOAMwFlwOvFBTV1ZjXCMreJyPIMME0xCyhuk
q9gY/hJKyWddJRhWwRWQL1q5eDJiNp9SfqZMdALKDh2QdyFBpT6Ds8NpsH9q
Ip5BH6tqG2obGpqaGluaG9Hf+sam2vqmhqbGVvSxEZ9vbW1EqGtoaGlptFCJ
lkUiqCWxECB4AAAAEE/0d7d7PlppW3dF68KzYihIYeehTWRGqHuPzziSbBLP
EVlDUBVIfMO4jF2afcndmOAhQQeI4GUX1tfUN1bVNVbWNlTW4YPaBo6FNDe1
tDS3cByloam5rqG5tqGprhF/bG5Bl9A/TQ2IujQ0cffiG5lSW1/Z0Ir01+Yf
a/p6Z/3HG+3vrnHs21B//K2a0yeq6lsq65sQKZLSV8tv55VzVjU2YauQAc3I
JHQGWY4E2YA+NuPz2Kr6xkahRBomsYXIDmvj1OJjPjv0t66xEefWgkxp4s4L
HkCXUHrkt4rahoIzdZmFNccLaj7Pqvn4u9oDaTVf5VR/daLqWG7Vl9k1X2ZX
ZRVW5xbXoQQWKtGyIFbMk2f0t7S6lv9oWYDgAQAAQDwRKD/uy3rbsfLXrXde
Z7t7sm3ORNucCbYF420Lx3F/1TKujTtvXzIaiW3xGHzA/112vf2B6+3Lx9ru
u9K1+VZ/zj6kXMoIde/xGUeSTeI5ImsIqgJMyUwKSfAunZd+11On8s9g2lZT
31TH8SfElGrqm8trmkoqG4orGvLPNKQV1H2TW38kq/5wZt2XJ+rTCmoLSmqL
KhpLKhvLqhEZQzSvubG5pb4RMa7m2nrur0pqMGVqqm1sqWlqK6qzt1cXtdeW
lza48F31TTV1TZRbOFX1mFJiq6rrm1F2JVWNp8sbECn9Nq/+UHrVobTKg2mV
hzOqv8uvzyupLyxvOFPVhJKhe/m76mjGaAhyRYPohNIqXMbC8voThdXf5tV9
llGN8kKZfpldnXm6/lQZvorSYA+gWxqbKmubSqua0k/Xv/1l6bo3T05/quDW
DXk/XZMzZkn2L9dlzduR98CrhffsPL3itcJZz+atfj1/0zuFc587aaESk0SA
4AEAAEA8MVD1df8L9wTm3dyz8Gc9C/6tZ+HPexbf3LPk5p7FP+1ZopTgUu78
0puDK6YEV3Ky6obQyikh9PfByVjWTgo9OCX40OTgw2PCH63uO31Qygh17wkf
YkayoCpArMysSATv/NlpP5mfPu+FwrySpvrmllrEhZpaGxpbSiqbPklr3Pxh
+eKX8/+6LffXD+X924M5U1acQHLjypwblp/4+ZrcPzya/5ctJxfsKN78wZkP
vyo9WYxutdU1tqIxv66hta6xpQ5pQ39JaWqub2qt4wRlV91oq2m082cQ6xPu
Ig+449qG1vqmloZmbNUH39Y89l75wp1Ff96U//M1OcgY3iRs1YoTN63KuXVD
/u3bTy995cwTH1UcTK+tqG1C+usbOf28PaRytTQ11zYiJ+DsEE/79Hjto++c
mf/Cqb9sKUAeuFH0APp708qcW9bm/u6RvNnPFW14p+T9b6pKqlqq6prePlp9
70slyGOjF2ddPj+DZ9EXzUm/cHbqhXPT1+8pqahrXv/umcKK5kMZ1ctePb14
16mlL5+2UIlJIkDwAAAAIJ5wPfgn27QJSOxzfmqffaN9/g32BTfgv/On2BcQ
svBG+z032Rf91H7vzY77b3Q8MMVx/2T70kmOxRMdSyY4HhjvWDbe8cAEx/0T
HCvGOR4cZ192pWP1GNfW30kZoe494UPMSBZUBVp0hSE8wbtAWIOXfueTJ3OL
Gx0OW21D06epNSteP3PbxrxJy05ce2/mFQvxHO5FeMFe+nmz0s4V5YI56ej8
JXdnXLEg49p7MiY9kPnbh3Pv2Vn43jcVpdXNNputqaUNc8WWtkZRGppaW2xt
FXWtBzKadn1Ws/dYzcGMhve+qd7zVeU3+S31za3NrW0Nza1C4maeBLY6bLba
xrZ9afUr3jjzHxvzJy87cc09mYiUXjoPW3UBx1HP4wQdICPRyUvnZ1y5MOP6
+zJvXJEzdWv+lg/OfHOqrbkNaUImYasaCatIqW1sbW5ra21ryyhs2rK3HHHI
GyLZZeDsUEazsKC8LuDyQt67bH76qPsyJz6Q9fsNeciTk7gNLOfPlpLhnSwX
z8VbWtAtj75b2tjatuWDEmTGy4cr3v666tv8+oW7TluoxCQRIHgAAAAQT7Td
Md4+92bE7mxzbhRJ3Y1YFk4R/i66yX7PzYjytc0a1zrj2rbZP2mbfSn6a19w
nWMx4nU3OJZPsmN2NxETvBXjHWvG2teMcTw4wY4Oll8lZYS694QPMSNZUBUg
LmRWhAgeR4oQP5m/oyi7uPn9b6vmPHvyxpUnrlqUhc6fMz3l7LtSfnhXyo/u
Sj1vVioicjcsz/7p6tyfr8mdsiLnqkWZ58xI+8FdKf96Z8oPpqWgY8T6fjIv
/cYVWX97PP/Fg9XFlS0OR1tjq6OhxdbUakf8qr7Z7nQ5i6pb1+4pnbz8xA3L
T/xq7YnJyzJ/uS7n6U+rGlrsNoejscWOEqPjphb0yVZe17b7aNWsZ07ehK3K
PG9W+rkz0340gzcs9UfTUy+bnzF6cdbkZdmTlmUjloV41DkzUs++KxWZfc6M
FJQYUb5R92Xcsi5v8a7C/RmNDa1Ou92G9De2OXirmrmDJs7O9nZXQXnb5vfL
frc+d9TiLExoZ6YhhUgbyvHcmanIhonLsm5alTP+gROXL8g4f1baD6alfu/O
4z+ekYpS8tmdg49TkQMv4vgzOvnjmfzfFEQIH9pd6nA48staUHa5ZS0V9TZU
0PSiZguVmCQCBA8AAADiCfvdP7PPvsk256YIu0OkTmB3SG6yzZ3UNuM626Ib
HA/9h/vJ6R075re/tLjjxfmux26z33+jbdFV9iWjHMsmOZZNdKwcZ39wLEfw
xjnQwYPjHWsnShmh7j3hQ8xIFlQFTa02syJF8M6flYqIyh8fzZ+/o/DfHjyB
yMn3p6WeNzP1xzNT0dXRS7L+a8vplW+UPfNpxe6vqj9JqTuQ0YBkX2r9O19X
v3ig4qHdJYjOTV6WhbQhEohuRKQLUS/EfxbsKPw0pRYRJ4fThUhUS5sTkT3E
oIqr25a+WvzjGSn//LfjKPH//Z/vrlyY8fhHlSglon8tmG457A6X3eH8Oq/p
gVeKEatE9On7d6YgU5F5F8xJv2Jh5m/X5y5+qWjL3vI3Pq/ce6wWGfbx8br3
v6159XDVpvfL57+AypJ7+QJECNN+PAvTre/dcfyiOam3PJS/8b2K7JIWh9Pd
YnM2tzpabU4kKNM2u7PV7jqYUT/3+ULE4r53ZwrK9MI5iJUh/6T/+uH8RS+V
PvFx1e6jNR+n1P4jrf6j43Xo+Pl/VCIL/7ix4MqFmSglYnQXczG9i7np70vn
pV93X9akZSduXpn989VZk1ec+MWDOc/tK+vocCNBvK6j3e10ulDWXR63hUpM
EgGCBwAAAPGEffbNdondzcfszsbRPBvH8Wx3j0fUzvXo7Z73t/jz9oWaivs6
7P093X1ee+D0Ee8nT7mfnm5fNcW29HrE7hwEu0N/MdlbO1bKCHXvCR9iRrLg
KkAUxaTwBA9PIM7GM7A/mZ9x9nTMzS65O42bt0396arsJa+U7DxU/WVuS3m9
09PRHvR3BLqRtPu72tFByN8e6HLVN9u+K6h/68uq1X8v+c3DuUjVubNSEbH5
8Uwc07tlbe6O/ZVVDXa3240IW1Mb0uMuq7OvebPssnnpKJcrFmacOzNl4rLs
Fw/VIKtcbkQFnS6XE3G8j47X/3XbKcSyfjAthZ+NRQRy7JKM2c+cevzDyk9T
6wqrUFJ3T7c7iCzxYcOQST2+dsTTcktbPjhW99j75f+9Lf+ae/CNF+PZ5HRE
8y6emzF/R/E3+Y0oF5RTqw1TO6Snxe5+55u63z2Se/b0FETVkHmIoaG7frM+
b8O7ZfvSGgsqUKqOnu4OlAUqftCHsvN4Pag4tiPZjcikPz5agIxEZPIi/HZB
YQPLf2zMf+Vw9QffVu89Vr37q9p3v6nJKm50oHztTpsDUUpnGz5wWajBJBIg
eAAAABBHYHa3gAvZzZemZW8UON7dN9iX/czzwbpeey2feEC8Szro63R2HnzW
vuEX9tVjHIjUCexurG3NWMe6MY4N10sZ4SU4CR9iRrCgKmjjeIIpESJ4syJU
hFtQh+hZ2jX3Zk576tTbR6vrWlyIyXR62xEhaUMkxI5oSUT4j3anq72jvcff
0Wxz7kutX/Bi0XX3cbGsuYg0pn//zuOXL8jY/H5ZRb2tvcONlCBt5fWOlW+U
XsJxocvmpyNWiYx5fn81utrejnigy+F0fZLS8PM1mGtdyM0go5SXz0//ry35
z+0rO1Xe0t3Z7uvqcLrdiBpJlpAmIT7p6+5od7vSTzdufPfMLetyL+Jilcik
82alnTMz5fbH8xEJRJYjUomA/v4jo/mm1TiAefHdOPJ23kzEddPvevr0/owm
pxsxunaUkM9OyovLzomcg2geIsBf57fMe6Ho6kWYT/IrG388M+23D+fuT6vz
epAGD292hwf5060WC5WYJGKM4JVtH3XWWaO2l8WshxuZiNKNg1cLUL8aODD1
LAFTD1hLAADIwM3D0gQxvWW3dH/zNkoz0Nsb5kndgMTs0CGHPnwpcPKYY/2t
PLXDOywQzXtorHPDaMcjY6T0qHtP+BAzkgXXtdNlVgSCN5vb4DmX30OB52Sv
vTfzoT1lZfXOrk4PIkp2pxsxOJe7w91OF3QJCUrmcHYgAlPX7Hjq05rx92cj
goQ0XzYPL0hDB1s+KK1rcXo6OpDaygbnqr+XXYL5D15B96PpKeOWZr1woAbx
u44OpMSTXmT72xOF58xI4fcmIMOuXpR570tFuaWtnV6UpEO0im4YbxLSZne4
UXqk9LPs5r9uO4lp2+zUS7kYIyr4A6+XltXhYno63FnFTbdtKkDZnc/FM8+f
jSN4dzx5qqDC6fV28H7g1VKzQ/TM5nAjCoeKv25PCQ5gIqLIxfHOnp5606oc
xP2QwYgocnraqZ60UIlJIkDw4gggeEMPEfbGcJBuAhKco4EGjnRwK+4iuyps
C7jw3aKb2uaN6f7yzYHe4ABP6vp7A7kHO9683/nY752b/rP972t9x/cMhHrQ
lYH+/oH+vkDBF/ZVo22rxthXj7M/NMbxyGgsG2QEL+FDzEgWVAWIOZgVieAh
VsNH8JBcfU/m059W1bW0e71ed4enw+Np7/C4Me3yeDzeDiToZEcHfwaHorjz
SLgD9NHb1el1uj1vH62esiKbm/DF4cHzZqVeuTDjvWPNDldnwOetbnKt3a0k
eDsO1LjbPV6vx9ne9dS+2ksw58QzxfxittVvlta3IIu8nd5OPusOzjDeAMlI
yST+DHcS34I0p5c5//rEaX6ulvv9jtTr7ss6lNnQ3+Otamrf9lH1ZfMy0NWL
uEjm2Xel/uHR/Pxym8fTiW5v59Ri5ZIriL/cQQe65Gr3+rs9FfW2O58svBiv
SEzjy4j43sIXi2uaXEG/l6OIgjbeTlGz6RpMHgGCF0eAG4ccuCrTomS6CWTg
2CAQvJEO+Z5ZfNA2/wbb3Intb64OcTOzAwP9va5Gz56VznW/tt8/wXbf1bZ7
r7Uvm+xYd4v7hTuCNXl8UK/P7/Uc2ObYMM6+7lrHBiF853xktJQR6t4TPsSM
ZEFVwAqvaQgRwUvnJhNTESFZ93ZFVaO7x4dIFKZzHkK8nk4PFq9Hdd4rnu/A
93T6uzudrvateytG3Zd5zgxMbxCbQsp/uz7/2MnWgQFfZYN77dvll8xLP0cg
eKljl2S+sL/ajQlSZ15Z26xnTn9v2nGBHM5M++0jOYdPNA4Eu5FVahu8umcw
7ez0+bp2HsKhRVTSi7mXqyDZ+H4l0plfbv/LllPnz0o9H1Gyuekox2vvTd/8
/hlfd2d3ZyeXKUW/9FfKDhFQlB7xto/SmiYtO8EtHcT8md97m1rkDgW63Zh0
CsxQYaeFSkwSAYIXR4Abhxx0q8xcnQLBA4RlU7RTuNV3N9rmTbYvmuwvyejv
Cw0MDPS2t7a/scS2eGzbomvs9493rJzkWDHZcf842wPXtC251PXcnT21RWEu
jhdsq3Y+epPjwSucG8c5Hh7t2DDauVkWwUv4EDOSBVVBBx9eMyMSwbuYe7cb
Yju/WZ+XWeoK+Lu9XpSg09tpRTDF83YianSqyjH7uaLzOMrE71Y4Z3rK9o+r
fP6ummb3g7sxwSMjeDsP1bo7vP2h7gMZjb99OBed5Kc4z52RtvzvZ8obXX5f
F47wmTcJMylvp9/Xeexk2583nTz7rhR+Iwmic9OfOVXR1PFNgX3c/Vn4JXWz
hfDd7zfkf5Hb3N2NiGFnh9dQpnwu/N/yRs//PH76PO6lKDiINyPlvFmpb3/b
5PYgfRxF9NJdN0TFJMGLzEepxjQ+lKG+rBoBOR3ECeYQiRPi8xHNYioiL8Vo
SUyY0XMhbpWu0izQnkwjs1El0rVB32kRA8QUouns29UulBuiF4YS7tdylL4z
9MkOmXrU9gNkmdRF1tFvpYVQy87Uruk/VgK6wfKMgOWNYEjszsbF8drmTWmb
P8Xx2G3B1toBRNv6egP5X7QtvMq+dKId8boVEx3LJuA3oqweb1873vHwDW33
XNT5+Uv9wR4c6evx21+baX94lGP9KPuGMa7NY9q3jpMyQt17woeYkSyoCjBh
MCnSJguO0qRctTDjiY+r7O6unoDP4+nq7OrusiSdXYgUdSF+iPS8crh67JIM
7nVw6Rfj1WgpM54pLK1ztzq8q98quzgyRXt8/P3Zuw7XdXi6BvoCr39ZP3n5
ifNmpl7ERfDOmZG6/ZMqRztiQF1epN2CScJdXQVVrjnPF/14ZmTi+E+bcgrK
2z4/0XzNPRncYr+0S+elff/OlGlPni6qdXViL0i3Gyo49193bUvXkldKL1+Q
jkOCd6fx+2qf3V/V4vQE/D6Pl67QQiUmiZgheFOnjjqLNnIpxy7FGKbgJcLo
p8muIilHbd+uHEWVmck1KUEfXhVX1TZohFoomiIJ9W3QNjeiik88alREhYHb
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
iTueLNz6Ufmn6Y3pJc6T1a7iOk9RrSev3JlW7DiY1frUJxUzni382Zrca3AY
EL9Y74LZ+D1yl85Ln/H0qc9z2rxdPeH+Xj6c5g8EUfuzuX0b3qtAFOi82Xj2
9sczUyYvz/770YZAIIgo5M7P6iYuwz8cdtn89EvmpZ83M/Wlw3UBvAcCW2ut
jOhvX6i3qs275LUzF3K/R3bJ3YiM8RE8B3om/FwET4F+/KT0IcGxR3+Pyxto
dfobbL66tq6atk70t97W3erqtrf7mhy+z/PaZj9XiAzmo5eIu547M3X04sxN
H1S6vX7JFss1NUhQBhQtCRA8DqoNnoDBgeFlgQDAsAVmd8snOFZMti0d5d2/
HS+R6uvrD+GAT/fXb9oenGJfM8b5yBjHhuudj1xvf+g6x6PXOTePcmwa5do6
2rVtjHMLYnfiurunxzmeHufaOdH13Hjns+Pduya6XpJN0cZnHEk2SRKELUXw
Qr0hHJELhRB1wu8AGeitbPbuTWmdv6N48vIsxH/Onp76r3ek/NP/fHfOjJRR
izN+sTbnjxsL/nPLyb9sPf1fW0//aVPBHzYW/PKhvDFLEENL/efbj//zHcfP
np5y0RzMaqY/Xbjn26ayRk8I88++HsFZiEmGBsL9zY6uZa/hzQ54q+mstH/6
2/GrFmW8cKDGHwghKrj9k5orF2YinvmjGak/mp76v6Yee3pfbY+kQgV+qlg6
5v/pJRKGuGgjIngVzZ0znyv6p//B+1t/iPRPT732noxD2Tb0tcfn71GpxXp5
Lo8+cq9J6edWpyqkn5e+3hBy4DP/qB67JIt79R/+1bMfTDt+/eLM5w/UdPl6
UIqgVAiFhdyH2NL+eAIIHgAAAMQTmN1hgneDbfGVnYe2S+e9me/aNv7Cvvwq
x6PjhPDd+tGOx8a4t45r3zqO/51ZF2J3T47D7O5pPDOLV9+9NNH1/ATnCxNc
HLtTELxEjzAjGmFLETyOGEU4XhATxX5M8xq9HxxvXre7/G9PnPy3tdmjF2dd
Ni8d0aH//dfvzvrzt4L8J5Jj+OAvx75/J/5BrlH3Zd28+sRft51a/Wb5nm8a
T1W3I6rGG4aUi7SLJ5N99nbfE59U3bzqxM0rT/xmfd6NK0/ctin/3e8a0VVE
k9482njrI3lTVmT/cl3uL9fmTlqWjRTyM5xBWgSPJ0tkoUKK9YICme2tb+t+
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
Nauo88Qd/imYa8WZPHFVMNXTZFmjcQns48EbPWb3TLB9NWbBiYTGUdrdEbKW
wUwuKfBGbflVLdGdQxqT3wxXG7lc+A+pG9AWeNZgrkzrk7MUIvLgjQLPHmKG
wFudg7YFl9KPDJyNwEunWBV4/S5/mw160RVrsndHD/2w0Pgv5cGEwDOBwOMQ
l5o/B287SrXNezL97M2jNQFPJNSP0n6cJ+PNyYnhXbW+wxF4vZFvrPHZHmOb
lNmPZws8IavYZn15gfcgFrd6emwayRV+Pzblj0lN3/EI9uOgTf2l9CMD1yfw
xhyjG11b4FlRQeC1g5ppAoHHyayinb+K0UlbZbGERr1EvxoePOF5CwTeqIis
BaokR+ZaktEG14OXHqI1PXjWGhajfOxVtFN2aqtoz1Lg1d/4cKdeGqM3H5k2
4bznK/ozC/z1fvvuKxPKCxru+Zblc0STtcabd4zIrVfpOLvlD3/TVy2ks+PZ
Zt4Ffp6WNj9MYlNvZzDfuWDnTr3TQXSx/RtB75WR9NUMRtYMsxuKvSrwpu7T
6kczry6ICjZ1l03LuTWsM7OTGy+YT3bhn+QdqdV5+0UeUT/a9MQ59cSNyigG
p1AMi6O03Nz5dzxRIN4dd1690XDLokfSb3D4o7RvZZYPZrpArK+Lyjl4n8s1
sXgfPBJy0ja91HFUVnbfPDLlrMzoGwVMJPCcpbuc6FVlhlJiswFpgLYhWq7x
opHWXXbmwFY561PnKvCsdwROzy7fSm56W6YZ1onICClg7T/94vyWLwlRJcEu
V6/WqUbOXoKk3iHKlaL9OtFkdsIX9DAtoF/vpMMY6trIQs0knSNVNqQ2CNlM
3rLkaA5tdqLYaw4QohLkjbDe1WW/Eiso2Npd9i2f3w9H3xTnJsdvnKjac1Zq
dZ48gk55ysy3PHFBmThR0bzzl1m578+rPmVu7vw7nisQL8VI4KVvmZ163OB4
PxgWVmb5cKQKxFe2beXsNxrgPBkXepwp17YYtug1+QuNCzzxVMsHlv/S5JfO
nZ2t8FSDb6sbcYXyARDnomjPEpGrYYP5pB/MViCVFIOfzE5L60kXwxjlF5lb
35RJ8zXiN3sfROWXdB7C/orZiWKvCDx+pf5WHRlrK1gVXWj5+DdNwk/OkrVG
6rU6P90116qtdanMTSTwrDLxoyJX7P7cbEoBmPou9ZT5uXPveLJAEk8BvXif
W0ZalaDBOVRlbikQI+MLyjlqNMBZ8vTxMRifPXmuTOCJn5lbrtn4F+vCGyXw
bNeEG5PuQN0G1r/E66GSkWt5ZdvgtHt7Zse8SiO1di2nU6YaTDJ07dwha/Pr
wiA0Oyp2TwnMwVw3rfgNUiUuWDNrseXRY2P/onLvI1cLlTpfs8o9WK+iOZeO
HVUvP+6LG7iuKAJ1ET2kGRkeyHXrjudyveCWZRscP2secWVeo0DayjlqNMC5
MYyQnrH7bnt1Ak93RWxAZTitfpxJVhV41V/muuvPCzwzcitLN4YNiwRewtEQ
iBmio8WCAp1T3cY6Aq/ahZE/76nrJS3wUmZHxb6Vfgm7TMwLZRCzzLMF6wq8
0ACuOKPkGtRCrc5XrTKTYHncW+Dx3widfU/DG5HHb04CSYEX5M6648kCOaDA
cx7JbIPjZ42Trcz7FkhzOYeNBgDgwKQ8ePosf7TZKKw982ZtD95SgZf04PGo
9xJ4+3jwoq7ksB680j8TlZX34CXNrjT1nsAzC0spKnZCxZMv2KQHT8XeDUry
XtFObmWBl+g6X8iDN5pMXXfkWxB/2oPnMN/x7CUn4MFzjXGyRslX5n0LxDEm
iBYePACOiVBs0w80W+DZbrl9BF4wjScSeGqETs5Haoo8aFQbBd6C7IgceIlv
hYoxNJUzRytvkvypfntLrlQdFklT9yMZs6O+rD/raQGjqFQBmJlqtdAzMrK8
FDcp9iC5FrVQq/NxeSoDjbgaBV4U1axzyeS7W8dTnXnKkrlbcEmUoje5bsEt
8ytEYEzi7L6V2U7FmpToGdPw09V/TgEA6yMGvLo2OOHBM3z8CwWe0SJRF48n
8ITKdDVDGDkXL3xqc10HOua1ZscwoDSL6se4yLboVpwyyZvEvg5Rqlniprg3
jAnMThS7i+sAmOISIcwL8gXr3LVUhWE6yEmuRS1U63y2PJurqF8mblRTTnmF
sW8vvUluWm7u/DueK5BIvrKY2gWe90jmGpwoazMNlTlZIE7GF5Wz32gAAF6C
WeNtnH3wnqzAc+h5KHCJwJvPGmrSE3jOTlneL1wduWxsuNCd4mgXeK3ZYdmS
6ZODRbwEmsrbqSxrko5TNsXMHrYPnu5HTLOTxa7EAs2mU4bzFexniN2bZAvW
v2um5Z7vw02uabwvUefd8rQKK11FwzJxnq+tuIeh74bUivqPDq+2mFYkCiRI
cY532PiuVeAFj2SiwalkzYoqrszJAnEyvrScnUbDf5jjEs76IQEAEiHTTpGw
lwer8TRMjwcnAOo8uDx2tfoK63R5H1a4H6931fOS8trnWnDe2GOuJ92xo7N7
EaDvTgjUeXB53G+urYVxXuOVeD8CBB5YiNR4p/7QobM7NHr6HTguqPPg4rg6
fVde4MVf+5Xz40GkAQAAAACcHOPLT8VrILrXsHJ1x7x80ykt8NhQL/UBlrem
fnweT/2HvJa8+9V7oS0AAAAAAKgx6rHKaKwxhvv+K7m8iLTiDKSf4hgcX9Yw
S0R+rU4CGg8AAAAAYAmpMdZBmwkV139llxcJN2i/2SNnn2XXSjN4igC8PF/+
+O1337z67u2vL3ztmvz87rtv3p37hJNdYX744193fzy9reclE0aSLKVzL8xz
tx8A0EjTJDo2/KqEmREVfcWqet0qDW+5/q7o3azgBIHAOxGe3r768edcXg6a
33MvzHO3HwDQyOIhWi3qqGdvhE7wK3PwpoTItXT2HQQeOAlORaTtwyX06b/+
OGQBAm9Pzt1+AEAr9iKLXq3JmXWj3Bq+Dussmj14ocBLbr4Hzpu/fPjwTe+T
6Xl6+4r0O7ve/NWHf/jHfQP0I3qCPtj44QG6S/QpLfDGI8Pn9Ycv04mu6+yO
/PJ2PPVnee1ff3k9JfHtL38hiQ/Xls+UqS6t1x+e5hT5VV6Eu9gmM3ap9336
L3MkrH8nBcJjoMGmryJmCbVnzoWXSl+S757mvHenvph27mrLVJ7TDbKM/H9F
mDiPqpRIydD6YBVFhbkoduXwREtM1ZMvMjlV/Wgd6CP5wr8KomrjVIZaTQMA
nC+T98zbJkWor9GbpwVeag6eLfCmFJmGxBy8C6XrAUtHNvaGoyTotN+uf9k/
gJEi1VGkJ2XdK9UnQuBRfSh7fy7SdjHza3USxcJe65qnSj8+JsFFbJ+dojD7
kCXC3pJZvhZF8UVdxSLsg40FGAg8RzmLmPuQoz1eKpN6mQ2bi6v/Wop9moDH
DIuMnI+HeRSlxH4gFIGq81UVeEZNkwKP1cBa9Qs/VEhPxeVWG6cyhDUNAHDu
VDY6tifIWV67+ipaR+BhFe1V0XUis/vi3Y9vx952cCZ8WSMAY+xYmQoagw1/
CxVHXSW8a2Zdv3uWXSs9gSRFfoopVSbbylkidZiI7cyeLRFOG+U32xoyeC7P
SDs5vh3vlJ+KyJ31ddYbhvLMCLxKHh2nZe/cm+oPtSQ9Rix+bkT1pF79SuDy
+2IwW0jimXy1mbIWXQIAuAjCV5WROXI7PUak2oJ98ByBt+UaD+ruouEDf93w
UN9VcaGyXwBCZjYdc5go9WXEMHbWs3eL9v40vOX6ExcaDhkmLXomfULErQrs
KR/+VUdej8GXNzo27zgXFaK4zK9lAt62WeAtySOn3LgGgcc9kyQSJvC8srKq
H/PTCgesV9XtapOvDLqCAQAAADl2Hfc47WqcUtV1KHR0bP8AM15vWOKxB9QM
kUZjGJ0zveuDDX5t+bXOmN3YpRpnZw8e72SZwIsU4xKB5wq5pMCz9ECQSlbg
9RPwjBHSRQKvnscOckfe/trqwdP1xPADs7KqVb8FAs+pNlFl8C4BAAAA2hiG
gX7d/dvrmV6t/byTTKyf3S/ATODBE16a4es82tvkwQsFXjzmxTTbNIgZCDyv
/70sD948AW+7gsDLePAiw9by4OmzQfUTAs8azJUGQOABAAA4Hl238vbdj2RO
0YfX30qNtF+AGTEHb3a+CfU1ulO0wEvNwbMFnjmJnTsGmZPKnqXGVgcHSiMn
8PLz01xRJBNdMAevLvDmCXhbLfBqRi6YZ6iG+NUihTXm4M31JFH9Fgi8ZLVh
at+5BAAAAGiFd3bUd7FagBlrnDSYIGd57eqraB2B17iK1u7fg1W0Y/w16SK+
uitMe5PGYhzNqwk8YQ/ZBidcRVsVeGQC3paLusjIWas0rxQ2XHav+NqcmsCT
Ne3bD+EPgXr1WyLwgrXSnsDzahoAAADQSi9LyG4Yygu0XwC+297W3QePzblS
PrS2ffAcgbflGo/ngms8vg2au4WdFBJsiW5K4PEC8bbmG7aqswSeLN5F++Bt
w690Ah4pQ+KPUkaKMK17/YmMlFmdtnh2qe+D98UKbFe/jMAj9yKqNuF4vV/T
AAAAALAa3sQ2cFakZmCuyIJqg5oGAAAAvBjods8Svu+N7SA9JBB4AAAAwCmD
bvc0YcP04kO3zj6GuttC4AEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAgBPi/v2nm9e7z+PdZ37i4bk//un24+8vZszTx8ch0f7zfM9Oft3M
p17UqgqloByzq/x+92bZhQeN6ugMeVklI13N2Ty0Js0+J1Tf2qg/Nfyh+7RX
Zf782+37r/yQKMxqhH14GUkbfZumGrTBvNf7Rg4AAOfCCQs83ikPjfNpdbiG
Emg3DwLPZC2BN5ZJUuCtqXaOj6ifluZZL8tjPFQ+8Wc2NoPZDIEHAAB7c8oC
jyYdnDoSrroz1GkqnrPTD6fPfI8ytyOUOv3nzW9Phzd6PYr7LjR7HYE3aTki
n8a2RR+J7IHAAwCAdThRgffm8dboGp43709G4JGRWSIeyIhYVgxA4B2GqQK/
eUwJPOpu4veuPCNNuv0EsESXZnro9sqakVb/LMinoOqYhcADAIB1aBZ47lBp
ESpzk66PVH7CzwLv/W+8I+ijevPbnSnw5EgQywvNIHVWlO7M8XJU9G3gGuoi
jAuNW+gIvHBImmRqlpSbBzMq5mnU2ZEOnJQuZTO7RIH3Ee4MoIYJszMSnSqB
8e4/kTLJXz5ksKpepnLwJ6qxG+Tcgv5cdLvHwF0q5DfCmKj9q8HHryS0qMsz
ZQubrMDzM5VPa0WBF9SlJoHHjJ9PGXYOBWW0PJG1lV98TurMgDnMGIA80RCr
AACfJoFntOSk4So9xdQqTo3bFDnp3SyIwPvKWunSkN5rgSfXOCR6Hx7GLAG3
WETWMnKoYqGhyuJytgN0Z1VU5iSoOB6pD5PZmeXBoIUmX2tJTmjCaukpgacu
T3pxcwKv2Y/q3ILq7bbKwfnENseVZGWBF2Yqn9YQMrxxGYFXqUtpgWfei7EC
qGpj/FwdisUtN/30sQofpT7V/w0vW/Ijru0pAABcIb7+UQ3I1MhLRVfCjA1a
aVq1O6K0eF6TSAUeazz7v3epKIEnW13thyEZHBtP+Yu4WEWaypp+yw1+5SxU
0qJazlamrKjcmEs8MpuxF4skYYnhUhQlEiOM/rFQS4hnRNiZGwTPCbwWxU7s
d2+BW6Rzt669dvJIULsSlaR1iNbTb5mnLJNWYgLeNiPwqnWp0qaVyJU9JZuk
WTAyKH+IuWtGuFVysU8l9USzMB45s3mhV83jD3+Y+eHRPKxP7/jbT9/LQ+Mx
zvc//c1PkJzcHedBu8h49HEwHt7Ml2WfyBgPwpIKcmcVxmCCzsHVkxd4llPL
VhTDJWPH+v5ZHAmcJEzgkZ/bUx9dVyCqo5kyOHfxMoz6bV6df9gg8KrXypY8
Uc5bJXStYIZw5Tmd+6x4YWONobi4wOOG9arG3EDD7Z60wFMDnQcXeJbnUNWr
igtF3u5J4GlHtzriZzBTSdYTeNVM1dPSCy4cqgKvXpdyAm8oZHMvJj4xYDjT
VfLHu4/UZRdXQnX24flG6vxa6oYLUQ/3Y+7uedBJkFmB9Cpl/MrPOJd+//33
WgJpyTcHoSmUSEiKqwk8P1+2XZY90/cpWJw761qdAmgQeHanI9w1tBkff94+
zDqt2shz/Ta1kHI+ldOr8iGPBoHn5CJoORcKPNNC0S+3lLPULTwqZyxVC3JT
z6egSfDCDLa4sSzRaIFHQ56QwPNjNm+3TihzJGOt8p0eRODZT1klrQZfU03g
JepSaojWmT5Hr5V/T7NATRdfkFb6LElRyzn9FKy4VyQ4NEoszcKoJvCG81Im
WZpsTsQSVbMMWlHgBfmiVwlbbM1Hjsa545IO8s4nPQcv7lPYWGrf5kyNz/Qz
s74jGddvPIY+3WhsqNIRkwz6/odZWFa6xZYRvYqFTQJvLD3nrrUKPNe2UA45
s8gCgZexRPLCAm8qOtMnlqtXA5Xb/QICT6312H8Vbe0pi9NKrnPpqQm8RF1a
S+CRWSKT23B26/WZqjk59xV4sZyDwDsjLNfWSEXgFV0jRFEogWwBpcNFkeUE
XpAvepWOxzJvPl4TeLOsq2T1yllJ4Ik55MVx1wdmrrxwNFDoN+0DDGY0yWHH
JoFHp8TUJgr2VFbR2hO5bQv38eClBF7GKScduZWRUx7GGqI1PHht3s4XFnh8
eoAmU68mw6LbfboevJQr0nnK4rTiuWqcnAevPklvDYE3Pct94KF8iq6LJxhA
4AENmarGFIk1B28SN8KrxU9wCUQ8WXXNWJn1VwnGEvfyVdASzDVvOhHmjh6R
I9eAkRZ4sYtDLP4ypt4NR5J7rtILh33M+Cw+OR3dWAnSKPDKhY+b95WJgjIh
c6ndlNO6hd7KiMwcvFDg5fr3XVSW/U72rY5JvMLAElQLJgu9tMAL9sFjCicW
ePXbvYrAyz2Mawm8xFO216xUnbW68zyqS7lVtNVZcCWqN7/dU2fd6NazdkPS
Uells2xReXUOHgTeRVIUUWIOHhdHNKS1DIFproRTkCWzfJGFky87D6F5TODl
FCjkXUTDNimZhXt8Sg8ft617k5wBX+OIs97Q2CEqK/C8yUUuuTdZ1C3cZxVt
KPC0m1EYo9flZZcPWzu6RALPWkFZmZf14gIv8yaL6i2o3+5VBN5BVtFWBV60
D9vLCbx6XUpuk1JbxzrF/Hj7xro7yX1seHKy/lRW0ULgXS6z7AnUmOVDs2ap
yVUHzhy3v80z2A4h8Jyk9x6idZfIBmaAnhX3wRsx1mbqDfFs3ElEausVY4hW
fJoF3oIXFvgar7LXVijwGvbBiwWeN3WqllCUfT/LXGnYI9fyE9SHIwi8bUXj
ZXZKrN7ulQRe5mE8xBBtsp4bT9ZKQ7SuPWLry333wWOX2M2g5X8zy9+OPLUP
HgTehWCIuOmQL/D0mdlnJcUNV0GWhJqHeNcTeFG+6FXWgg+VYLDIwtZ4EHg1
9nyThdUpuOO21bZI9TVqBwnDKtpO0o3f/dFMr+MzPFoJ5KxvncfYQqdwwnLO
Cjx20Mla3X6BjpCNN/mCqmaJEfilBd6A0k6GWvC3wo5v92oCryN+GNd8VVnl
KeugFcl419uKAm8b16U13mQhE6KFI+YkFMw6ucKbLFqOgJOlV1dijURtFa11
YhJB9iw1LvHkooQDbJMS5EuZrDLXsk2KJfEg8EAe69c6AOAFSQo8AM4PZ99h
cy3DH354sMcxi4Jy1pkyFXSMjY7D3U9yBeIYJHMHgVfBHnbBBx988MHnfD7H
7kkAAOA0aV1eAQA4EPDgAQAAWAtjEwwAwDGAwAMAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAALAawbvu9oghfNHx3vYefmfD8U3HRkEMuc2WEH9j
MrtqcUbwfmUAAAAAVNByQb56pD0G+daRNXlRgaezMKrZTNZUGfADEHgAAAAA
OBSePMtLCDv0oWTICwq8H36QL2rpUu+O1nNmvJBvy7UzBB4AAAAADoUn8My3
IJtvfrMFB1c4dKhSvP74h8d5jFe+Zc69hH5TYYY33z3O1wvrnJgN6+Wr+Prv
P/H8slHYYpn78r3Hx8c5riG4KGPylQ/wljCsvIcgu6+ZOwUAAOAYdNvpbx6O
bcVVgKKesYdof1AyRJ0JYhBH2Zgv+8ImtNEz8SWjDf3VVPaMX4ousoIFMVOK
POUKb/hG88sjmM7Y/jtdQJHAE3HMuZjTHzJKslm5UwAAAI4BVAc4AvYSiVnV
CIeSs+zAnINHlIezvICfmiVN5ZL+L2UNl1f0FAkaxEwppkix211KovBGSzOj
qDWB5w7hlsi5cM3cKQAAAMcAAg8cAUOLDJqPusZsRcWChwrRWMVR0za1S7ST
bDqiT00RRjFvvbhmoSricB11awg8cRtE5N9/r8eXq3cKAADAMegF3sffbst7
z5nYe3i+KcdvP/7eH+IvZe4DTJfcv/908+a3Jxr95y7mzcP8XvUuns92ct3l
xvFBgs4xDKe6wOTd0E8fH81XRZM4H+8+Pnf/fh7iHL7ujj/fB6nn7ScHZTGy
jESZCu2vl8kZYWoRNfg5yi57WlmsZmwXYVXg1S4xxBU9xQ1iAs+LmTLHPim8
Kftc4Jk5X2OIdorHmoP3h3GSoc5mdKcAAAAcg0EkDLKnl0nlby7e+mC9gurC
FBXXh5+EVqf9ig4sjLKHxj9rqv4r0VdFoTEzPAs788Zrh6S1yOnVUQkzitVJ
4DEt6qaetH/UgSU6rntpUbPyNItd2N9UJueDKc+4QJmmntmqISHwvNNpD56+
pOLBCwReRvuQ2EeFt/tPjcv6Os5fZPGDVKqRwBPXSYFpjTdHdwoAAMAx6KTC
rMpmoaLU2sMzUVajnNgpkM3751EpddcqmdFHKOK3kutdap+36nhgIdFLftLK
QzgLPJI7P/Wk/UxtekiBZ2VKhG8tk7PB9eCJVanfu6N+NdEU7AcSjU7WLmmY
gydmzSVWH1Dp1iu8n9hQbW0OXtM2Kd5ERC/jcvmKWDsb3CkAAADHQMzBK1+1
ZjCUVa9AHnbHe21jihwRT/x1oIwL89FMw+DJwUWdijwebs8DHaJ1FJFIPWv/
4FKLNZ4eojVPJaxqvfz08Obg6R1LIp9aqCiE4BLOKNN5lbqksoqWLdW1V9Gy
mJXJfEzU3KaEx6Ycn8Z+KnqjY7V62HRjOn47ca/iOwUAAOAYpAUeV1bjVLRO
Vo2OJjEpbiQt8MroZy+TlLfKFjNFwo32cOj474gv8NzUGwRqPzuxbQ6eeSph
1WUIPH+FxEg4az8z7Gnv6BaOTqYuIdZLJ9hP8/XCIebErIJwqca+1fbBM+yT
5UozMgcbdgWkClZdbCg/XmrQdwAAcFIs8OCNHrP7sq6h11dfzVlwWYEUBQvE
zKAt+VDmRN6DF6S+wAPJxoIpjQJvYZlcEPMEtHMgs8ThUjmvOwUAAFeBJxX8
OXjbQWw8b4rfrNd7j8YsuG1aIAkxptZ3OGKmN/KNNT6r02KLEXicQeqLBJ6j
uBoF3sIyuRzOTDVcscA7szsFAABXQTwAaqyinb/y9bYplZXy4I27fxR5GYmZ
YRBTj88OxKtoA+fYHGeDQCX6Vnw1LG/14DWUySVwjpO6rlPgneOdAgCAqyCU
CsY+eCNMO4m1pZQlc/DKjD57vpzWZtEOIWQfuef72ScWzMHjqec9eKSsnE1L
9pmD11ImAAAAAABnzbjQI0dqMxMAAAAAAHBMnj4+euOzaoKc2PsOAAAAAACc
GMM7JmL3HRs2xSAmAAAAAAAAh+B+c+Oxue/PbjCOvi9OMd5vTrBsn+5uh9t/
exfOtujyNARJV5JD5ZfU4VoCu6CVIH3+m+1sztpUaGbpzYXrXNWaVOVmnhxH
eTSWJXrk4q1UCW3d8IAbx7pYvNjo8QvtFM7xMQEgT/eUixp+oc/yS+N24qdX
tulmrrk9PFR+6U+U0KBRuh5A4C3I2jKBt4jz67mO8mgsTfS0BZ6uzt1vnM2G
mzzlIVMIp9lw7c35PSYAtACBdyjOTOAl3XEnJfASpkDgnQsQeG3JR2bL+nzf
abt73tTPLT8E3rHNAOBAeALvrgza8ef6aT5ML+sbkLsNDe6ElFBXjGyRFkRI
A1UtN3/ospOpnPpZ4JHzGP8nP92d3H0dbsf9HFLk1C0EP+NecRv5tK57orbc
uUO0XvEKWzO3+x/MkvGyWqJm0w6svEUd1FAT7sxiFzntv/7PSl2sVYm6wCNj
anqkbI7euQX0TmXrxqpPYmRnpRJaMVqVtM0wI3dW6CAGt3h9U6MYZrllVbB7
8iWqSB5cuNwPvjv2JJHGz2vw3SHa1O3ieWDfEqXNc1qt8Ol2Mn0fAbgEHIHH
m17jb/6lv0T8OrRDMmirwUMtilAINtKwOJcbP3TJiVRO4yxEHjzVZHZfSutD
tSNvVy2r/IyrxFmLbZoSX2EKvLi4WNueud1mycwYAs+YVEpL0+gcOGPAehZq
Iq2ezYzAG8zx+lnzeXTvVK5urPwk+nYuqITankn3Jg1LPqSVGOwHwTc1G4Mr
8BrbFoa8VlU70RJZN8sOnqkAtFfhPvT5zJ4VKbh8//sIwIXgCLz50NxBKHc2
b4qE6nFCioRkA02fveYIwy7XvFz/1Jz6jnROoyyEJpK/p7ugGjpyf3yr6u39
1rjTc3zO9crDSfpUmZGguEiwhtutOgQGa/fHb6LdJt1RtXTMYjeysE0UeqZK
hAJPajC/qKfIgzuVqhtrP4luG9JeCXWK9vG4EmYeUj+G6EEITfVjcHTUlleS
prZF2UKkEPV6yoNhg29W3VxTPDdb8/S/+f7vWZHyTfSC+wjApeAIPKPB0Q2t
3RTEIR3GTtlpwbIR8o6eHU5Y7us7N6f5LGyNg6zhIT9r2VVpqypNvo65mil9
2OyOFxRXrayMkrEikGeMkbwGgWcXe7PAy2TT7xRvb1W+nB8F9GvtTiU0XtVm
EW3BfxINOxdUQrfpWGRYkLsghqh4w4NBDFzqOHo+YbYHi5+6s6Yfkp4/0Kyl
mV5AWjzL1HvlQ9yzIlWKer/7eAjsV5J578Ma/hjfjnrjvvOLvruWHcduw2Ck
TeAZOALPC6kSn04GP1HTEZp9fHy50eTkc5rPglm2pGjJD2vdvc9DUn4hWBlX
BaNbt6Bvda4wBV6quBrKSpeMLkc58mIWTF7g6U5hocBLZNOtGzc3ajJ8QuCF
d2pbrxvrP4lpgVctT0/itxiWyp0fQ6146zYYMSQEXmPbYhSceoTMg60CL1MB
Sgq7BEevdHFOz83uHhUpuHz/+7g6vbpjL7UfhVkk8KbXrfbKzfibvjmCHQ9e
XAuujX08eN4lyadGPG+VbqX5MewfdMf3Zdge/pZXoZuzYF4+tnvWT2x2RSIX
ZsYpL+nBM6NoKytVMkYe6dg16R3YuRf34KWy6dYNa/iqLvDyrolU3VjhSUwL
vMN58FpzF8SQLN5KDI2/IJrbFiPNXQJ0LHa6kh9sFXipVmjIH3XdkW97V6Sm
ovYiazBjH36/e8PlVqf34jfa83d+zW8E894Fpo7jnbBgIC/wolbF/REaYVxU
68jayFhezm5okHROG7JgHuxL/5bcATUZjLRA+UIwQ64wB8+ZOJQrrrayUiWj
4y2mjBquhBzlHhd4lUY8P/WxVRXb2awIvHieWEY4qQx59uVt9i838K5aeQ5e
yrBs7vwYssWbbyHlo2RUsOa2xUqzXxwrf7ncbjaG6NNfzcJJt0K9iNywyXe3
/rhwkIc9OyNhUvIxWQ/5wlYp2PwhWnVcRzUwK0Y/UXCdNAg8+TgQb0DQfImQ
ImnWgIheujlC0RXIDtO9fExbCK9MTluyYJk46g/RvAuxMkXiWuVnXCXOrbW1
1wxLkeWPXRIXlyda4rKSJWNkRXrwzNEectJvyaNip5mj/kCnlFPZrNcNYkJC
4AV3KlM3Vn8SA/UVVkLzDvEU3QlVrmG13Hm/rmjW/AchMNWPgdU3p4I1ty1W
wenfSMYvniaBl6wAk8280EjAPStStqgX3cc1MbRWTchFAo8LuQH+Qli8GRbM
tAi8rZjNE7q8nJBemM6GQDEmI+R9PctXdDnXUU05bcrCVjcqovyHVt3ZhDDK
hZ9xr3xEr+/1FyyDuX3wpI+zJNZWVu7kqzla3jVPSfOT87lxwMrIaqXY51Ib
tuSahZdV2IlsZsT/VClTAk+mSzf4StSNtZ/EyE5Pcwf9LUvR/1XiGebnTiYa
ZM0t3sBUtx4NlY3LeVXBEjfFHcCebZFm6oNtAq+SR5ld63dSpqwqtlUu3/8+
rsZRPHgAgFPgaZiETL4mR0AuHlEyK0aL8gVHJ/z9Ai6Iyhw8b65dfW7eVgcA
AJwQUsVA4BUOpO+29xt0q+D4QOBdD+4q2k773bz57Wn6uyLwxCra/pI+Kn58
e//+E3x6ABwTc5IZBN62Nv1uP6DvwEkAgXdV2PvgbcuOKIO0q87N68jsg4cl
tAAAAAAAAAAAAAAAAAAAAAAAAMALQhftV0bsd0GbJ4bdbxovyW3u1GpEbkfQ
Y057W2ve3bzNxqolueg+YnbRi/LSRR5WsGu4/8dtMQAAIIRujhU2x3Rz17bo
T6ANzJhxbFPXF3grsqBwrqGDPzFOqshPypiDcOwWAwAAQtTO4h4QeAcGAg/s
yUkV+UkZcxCO3WIAAIAL3+fbfOMTf3UOH8plAb33AkjnoLN9PUFvnE43eLdt
r+3wz45Tu8eDlqmm+Y69OlhgybBxuioy9RoFmahfdAteM5F+vcde91G8Y8J6
5US0rf18athN4t4vHFnO6mtlu3wur/k7TWhOjMozHia3dYxsDttdzV+zYeJH
7jwFmQ35o6KzaqO+s/qnx1gi4ftcuDHJp8kJliyBStZYzop5Ig/9q1PDpoy8
QUym6jYF0pKFT2JcXsY9Ukm01MxsAwgAOEUMgcdFm9mcDYfEEa8RMF5OxDoS
owmTAs94gaDoceaY6gKPhuCvzdGvv2FSz27i3BxFlthxibdDWm9SNItOfzEF
npsjtzBlPhfcx9v5LZupso2N5KVrdn9OsSfySDck497q+UxceZR+tW33PLWV
yPVTEN16kTGv6FRttO+sNLncWv27yTYm+TT5wdwSqFxivfJNmqeeEvMHTr21
CZsCasl+T2LGMN+YdM3MNoAAgBOGD9EO30QzyJoG/hPU/Cajp72Wevmhbjak
wFM/P4OxkarA639N86bW8v4py+wUgxxFlgRvr3TeV+YnpOQC6U5yOUoNNC28
j9NvBkMdGHH7p8zCMcrRKfZMHkniuz83m1JTmL6LKo+oqPFXS0I3RG7JLufH
Q1R0osDdO6v9m1Ib1eph4mlKV4w5rQWX2OYpLb+14jQMTjwUwsg9n8SMYZXm
IlEzk7cMAHDScIFXYP45S+AV8ceCONG7ngu3pzNF11Y0hV4fEXvwZM7NtLRi
MU2NctRiiRebr+IirWuKzChHXmHKSBfcx9tb9TKKwJLgVFA4np3sa1Mee611
X3w55h0LKo8ukPirbYgfeaBazTKJii40e+vUZ7eCOcYkn6ZaFXVKIHdJWFbs
Z4Tzq6HS2uSbgn2fxIRhgTHJmpm8ZQCA00YIPK7bAoFnjdHGHjyjiXD7zprA
k+lnBCHLxnCR58GzSsHIX5SjZQJPN6qOwCvxOGfM/jfIkVmYZr7a7uPNqJTk
UJltSXBKF06bwMvksTjRnobX347fnCj8yqOLKCfwspGnbr2I1yu6msATHjHp
3BGPVSDwEk9TFCwQeKlLKmVF4nMGImutTb4p2PdJTBgWGNMg8BK3DABw2jCB
J1wH7JwzDMuagrDDXdODp02oD4zW2rfQ32Vy1h48B1KY8vCC+2iMUQWWBKdW
EHjVPI6JUNcd+ZauPJWQOW9wQuC1ePCWCjx6ZAzrPJ5NHjyTKFjag+ddUimr
Qdn5+k5cZ4/t5pqCfZ/ERPhDePDAOjz+8AfKD4/8FP2ejK1csuDyo3OONp8Z
VMSNGo5PyBMCj0tB4fmLO9yGuVtNAs/2LmytNtaIz0zLl2GM9MQbV/iJyLy5
UpVJNTRCEs2CHHkhF95HWncSljQUjtMFecWeS6gLLybf3d6y5yFTeRYJvHzk
3q8Vo5Dso6YLbgrq39k+8IZeESkcpx4G5CtG4udSTbvyUpG3Omdn8qFINmK1
LDSETzcX7tfWpEGCXtxJSfeH73/622qxn5tYOkebzwzTg2c65snJXXBjhLbe
4apuy2pEEgJP9O7zV9psU5ej2ScKkcoiFb2i+2vazVHNEo0lr/kPf7vomKks
TywtN0duYcp8LriP/AeAUTRbXrbuqbhwRCHqYk/lcSo+Xpi8TgSVZz0PXhg5
+erfehmzU3SqNoZ3dkzB8YsFxiSfJj9YrgSiS4ycqZ8Cjr5zK0/yoZCW7Pck
ZgzzjUnXzGwDCNJYauZvP32/lsQ5R7F0jjafGVYnNuk6fnI+xxx+vrqb45eu
vtoVdQ8e06LSP1EyYPzWJkZ3V9GGS5jKs+f/nHVzVLFEMrSud+wG5BLimcrt
g2f13NFtWXYfRffDRaldtvapauFYxUSKPZVH00rpU7Urz94CLx+5Iav0rZfx
OkVn1cbgzlqKz6lg0T54wd1zgiVLILhE5IxVjRKLL2CcypN7KAxLGp9E1xMd
1WrTmJaambhl9ALvbzBQ1XJE7Yxh5/Hczs3XH+Qju+4QLR0JJmnuDn//008/
qNHhOVFz8JieEQ7HfEIs+vFYb/NPOl9hor6dAICzBD3GYlB0JlrgnbKDamce
buG5M4ghV5FIgTfpmqJouPoTl5C/6dE+8KSP/DFhIT/JaDKLQUeXS0if7b8M
JUKzafytT5h2AgDOFaiUxaDotroQ5PDnieu7nb0nbR5IYrmxClLgzfrI+tqH
NAVe7z3j0oqGsef8uYOl6hImJJMJeeny4zxfdqIY1AXg8oBKWQyKboBPMBbj
kic+vwz67uKYpJ7lDxN+KvdrbRVtGUBNrLR13ItamplDzXFC7ui0sKd8jRKt
uEEBAAAAAI4OGWNcTeCxyXrKseZrI2+WnEFbQt0p03EYCDw30dgNCgAAAADw
cnherNlbtZLAi67NDnDOU+j8Qd2GhPb34FXtBAAAAAA4Ao7KMddG7CPwDNG0
YDPkxKS3hoSiOXiGwFtiJzhxfn733TfvzneeyZc/fvvhj3/dbv/6y+tX332z
+3z7y1+WxPP0dr9C6IrxFf38+LNh6ndvf+XHJrNfqbtATr3+8GW285VIyLrW
TGvi1x+/edUX2uXTlcOufNyiONS1AIATga0ZnY+UA4fw4I2DnUYShm32qgix
wmM2uSUhHsl0pSfw/ESTqzfAyXHmAm8neDop1eViobTr2LsQOjFAZJiThFAL
vYQrV/XKbbKhP1UCd6e8yPtopZg00poZJCIE3kGvBQCcEGJ6mVR7a8/B6+In
KjL0dzHTUjvPNSXk7oNnCbwg0cBOcMKct8D79cfB+D1zsXchdKrJVwKz242G
+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

    "], {{0, 765}, {843, 0}}, {0, 255},
    ColorFunction->RGBColor],
   BoxForm`ImageTag["Byte", ColorSpace -> "RGB", Interleaving -> True],
   Selectable->False],
  BaseStyle->"ImageGraphics",
  ImageSize->Automatic,
  ImageSizeRaw->{843, 765},
  PlotRange->{{0, 843}, {0, 765}}]], "Text",
 CellChangeTimes->{3.543526994379015*^9}],

Cell["\<\
This time, we have to go down the results page to find the answers, but we \
have two that agree. There are about 9 calories per gram of fat, and that\
\[CloseCurlyQuote]s good enough for us to find out whether the original \
information in the nutrition label pertains to the advertised \
\[OpenCurlyDoubleQuote]Serving Size\[CloseCurlyDoubleQuote] of four ounces or \
to the implied serving size of one ounce.\
\>", "Text",
 CellChangeTimes->{{3.543519050232112*^9, 3.5435191694860363`*^9}, {
  3.543519335719658*^9, 3.543519369063992*^9}, {3.5435774670229454`*^9, 
  3.5435775193069353`*^9}, {3.553596012973114*^9, 3.553596031124516*^9}, {
  3.553772449038525*^9, 3.5537724501912947`*^9}}],

Cell[TextData[{
 "Write a new expression and chain some new rules to keep careful track, \
inline this time (meaning we don\[CloseCurlyQuote]t need to assign these \
rules to a variable). Extract just the ",
 StyleBox["TotalFat",
  FontSlant->"Italic"],
 " from the label data, convert those grams to grams of fat, then convert the \
grams of fat to calories:"
}], "Text",
 CellChangeTimes->{{3.5435193715992455`*^9, 3.543519391273213*^9}, {
  3.543519459220007*^9, 3.5435194865417385`*^9}, {3.5435270555520153`*^9, 
  3.543527096605015*^9}, {3.5435775280354347`*^9, 3.5435775385880384`*^9}, {
  3.553596040460918*^9, 3.55359606951462*^9}, {3.5537725283255653`*^9, 
  3.553772531741194*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"TotalFat", "/.", "\[IndentingNewLine]", "burgerNutritionFacts"}], 
   "/.", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{"gram", "\[Rule]", 
     RowBox[{"gram", " ", "fat"}]}], "}"}]}], "/.", "\[IndentingNewLine]", 
  RowBox[{"{", 
   RowBox[{
    RowBox[{"gram", " ", "fat"}], "\[Rule]", 
    RowBox[{"9", " ", "calorie"}]}], "}"}]}]], "Input",
 CellChangeTimes->{{3.5435193971017957`*^9, 3.543519430181103*^9}, {
  3.5435194900800924`*^9, 3.543519503577442*^9}}],

Cell[BoxData[
 RowBox[{"81", " ", "calorie"}]], "Output",
 CellChangeTimes->{{3.5435194081088963`*^9, 3.543519430979183*^9}, 
   3.5435195052436085`*^9, 3.543521049481802*^9, 3.54352117997187*^9, 
   3.543523556005464*^9, 3.5435250195730114`*^9, 3.5435286115780153`*^9, 
   3.543578784283288*^9, 3.553555233505578*^9, 3.553601957678712*^9, 
   3.553619268914762*^9, 3.553772494206106*^9, 3.553785130798855*^9, 
   3.553785193939752*^9, 3.553789205955388*^9, 3.5538648809142876`*^9}]
}, Open  ]],

Cell[TextData[{
 "Ok, looks like the nutrition label reports the number of calories from fat \
in the ",
 StyleBox["implied",
  FontSlant->"Italic"],
 " serving size of around 1 ounce."
}], "Text",
 CellChangeTimes->{{3.543520983806802*^9, 3.5435210028468018`*^9}, {
  3.5435775542439337`*^9, 3.5435775618193674`*^9}, {3.553596081090721*^9, 
  3.553596081881918*^9}, {3.553772965571978*^9, 3.553772968564826*^9}}],

Cell[TextData[{
 "We need different conversions for different nutritional components: \
carbohydrates and proteins. A little searching gives us ",
 ButtonBox["this page",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://answers.yahoo.com/question/index?qid=20060927203122AAv1MpR"], 
    None},
  ButtonNote->
   "http://answers.yahoo.com/question/index?qid=20060927203122AAv1MpR"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["18"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{
         RowBox[{"http", ":"}], "//", 
         RowBox[{
           RowBox[{
             RowBox[{"answers", ".", "yahoo", ".", "com"}], "/", "question"}],
            "/", 
           RowBox[{"index", "?", "qid"}]}]}], "=", 
       RowBox[{"20060927203122", "AAv1MpR"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00003F86"],
 "], which we encode in rules as"
}], "Text",
 CellChangeTimes->{{3.5435195249115753`*^9, 3.54351955576066*^9}, {
  3.5435195921703005`*^9, 3.5435196488139644`*^9}, {3.553596111682316*^9, 
  3.553596112861734*^9}, {3.553772575931807*^9, 3.553772596783884*^9}, {
  3.55377356319103*^9, 3.5537735632258043`*^9}, {3.5537736110809793`*^9, 
  3.5537736111285267`*^9}, {3.553783667969174*^9, 3.5537836749867477`*^9}, {
  3.553783869199394*^9, 3.553783869249645*^9}, {3.553799066728407*^9, 
  3.5537990667921133`*^9}, {3.55379910977669*^9, 3.553799109823119*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{"fatRules", "=", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"gram", "\[Rule]", 
      RowBox[{"gram", " ", "fat"}]}], ",", 
     RowBox[{
      RowBox[{"gram", " ", "fat"}], "\[Rule]", 
      RowBox[{"9", " ", "calorie"}]}]}], "}"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"proteinRules", "=", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"gram", "\[Rule]", 
      RowBox[{"gram", " ", "protein"}]}], ",", 
     RowBox[{
      RowBox[{"gram", " ", "protein"}], "\[Rule]", 
      RowBox[{"4", " ", "calorie"}]}]}], "}"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"carbRules", "=", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"gram", "\[Rule]", 
      RowBox[{"gram", " ", "carbs"}]}], ",", 
     RowBox[{
      RowBox[{"gram", " ", "carbs"}], "\[Rule]", 
      RowBox[{"4", " ", "calorie"}]}]}], "}"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.543519664024485*^9, 3.5435197502211037`*^9}, {
  3.5536018680821877`*^9, 3.55360192556285*^9}}],

Cell["and apply as follows", "Text",
 CellChangeTimes->{{3.543519759026984*^9, 3.543519766539736*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{
    RowBox[{"TotalFat", "/.", "burgerNutritionFacts"}], "//.", "fatRules"}], 
   ")"}], "+", "\[IndentingNewLine]", 
  RowBox[{"(", 
   RowBox[{
    RowBox[{"Protein", "/.", "burgerNutritionFacts"}], "//.", 
    "proteinRules"}], ")"}], "+", "\[IndentingNewLine]", 
  RowBox[{"(", 
   RowBox[{
    RowBox[{"TotalCarbohydrate", "/.", "burgerNutritionFacts"}], "//.", 
    "carbRules"}], ")"}]}]], "Input",
 CellChangeTimes->{{3.543519768702952*^9, 3.5435198736594467`*^9}}],

Cell[BoxData[
 RowBox[{"165", " ", "calorie"}]], "Output",
 CellChangeTimes->{{3.5435197872948112`*^9, 3.543519835701651*^9}, 
   3.5435198744225225`*^9, 3.5435210496198015`*^9, 3.543521180105883*^9, 
   3.543523556151479*^9, 3.5435250197120113`*^9, 3.543528611721015*^9, 
   3.5435787844462976`*^9, 3.5535552336569443`*^9, {3.55360193419654*^9, 
   3.5536019577728243`*^9}, 3.553619269014852*^9, 3.553772494299953*^9, 
   3.553785130928091*^9, 3.553785194063499*^9, 3.5537892060777903`*^9, 
   3.553864880985295*^9}]
}, Open  ]],

Cell[TextData[{
 "Notice the operator \[OpenCurlyDoubleQuote]//.\[CloseCurlyDoubleQuote], \
shorthand for ",
 StyleBox["ReplaceRepeated",
  FontSlant->"Italic"],
 ", because we must keep applying the rewrite rules until nothing changes any \
more. The /. ",
 StyleBox["ReplaceAll",
  FontSlant->"Italic"],
 " operator just applies rules once."
}], "Text",
 CellChangeTimes->{{3.5435198869697776`*^9, 3.543519955637644*^9}, {
  3.543527151235015*^9, 3.5435271720340147`*^9}, {3.543577586858799*^9, 
  3.5435776072369647`*^9}, {3.553601965770178*^9, 3.553601975408662*^9}, {
  3.5537726156353073`*^9, 3.553772635931169*^9}}],

Cell[TextData[{
 StyleBox["Not only does the implied serving size underreport the declared \
weight by a factor of four, but it underreports the actual calories in the \
underreported weight by 5 calories",
  FontSlant->"Italic"],
 ". "
}], "Text",
 CellChangeTimes->{{3.5435198823693175`*^9, 3.5435198826253433`*^9}, {
   3.543519960029083*^9, 3.5435200336974487`*^9}, {3.543520065666645*^9, 
   3.5435200889169703`*^9}, 3.5435201335344315`*^9, {3.5435212274916215`*^9, 
   3.5435212396138334`*^9}, {3.5435776157994547`*^9, 
   3.5435776169885225`*^9}, {3.553772665346223*^9, 3.553772668337638*^9}}],

Cell["\<\
This is why we suspect that the reported 160 calories in a serving is really \
the result of incorrectly adding 30 grams (the implied weight, not the \
declared weight of 4 ounces) to 130 milligrams (the reported weight of the \
small stuff). Doing the arithmetic on the implied calories results in 165, \
not 160.\
\>", "Text",
 CellChangeTimes->{{3.5435776200256968`*^9, 3.5435777182903166`*^9}, {
  3.553772691353581*^9, 3.553772694121667*^9}}],

Cell[TextData[{
 "Let's compute the calories in an actual serving of 4 ounces and ",
 StyleBox["then",
  FontSlant->"Italic"],
 " decide whether we want to eat the burger. This time, we won\
\[CloseCurlyQuote]t ",
 StyleBox["ReplaceRepeated",
  FontSlant->"Italic"],
 " because we want the fat and protein separated"
}], "Text",
 CellChangeTimes->{{3.5435198823693175`*^9, 3.5435198826253433`*^9}, {
   3.543519960029083*^9, 3.5435200336974487`*^9}, {3.543520065666645*^9, 
   3.5435200889169703`*^9}, 3.5435201335344315`*^9, {3.543520251140191*^9, 
   3.5435202741814947`*^9}, {3.553772734104712*^9, 3.55377273435233*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"calorieBreakdown", "=", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"(", 
    RowBox[{
     RowBox[{"TotalFat", "/.", "burgerNutritionFacts"}], "/.", "fatRules"}], 
    ")"}], "+", "\[IndentingNewLine]", 
   RowBox[{"(", 
    RowBox[{
     RowBox[{"Protein", "/.", "burgerNutritionFacts"}], "/.", 
     "proteinRules"}], ")"}], "+", "\[IndentingNewLine]", 
   RowBox[{"(", 
    RowBox[{
     RowBox[{"TotalCarbohydrate", "/.", "burgerNutritionFacts"}], "/.", 
     "carbRules"}], ")"}]}]}]], "Input",
 CellChangeTimes->{{3.5435202365407314`*^9, 3.54352023942902*^9}, {
   3.543520392853361*^9, 3.543520403222398*^9}, 3.543520464084483*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{"9", " ", "fat", " ", "gram"}], "+", 
  RowBox[{"21", " ", "gram", " ", "protein"}]}]], "Output",
 CellChangeTimes->{3.5435202400380807`*^9, 3.543520404605536*^9, 
  3.543521049693802*^9, 3.5435211801698895`*^9, 3.5435235562224855`*^9, 
  3.543525019777012*^9, 3.543528611798015*^9, 3.5435787845003004`*^9, 
  3.553555233690217*^9, 3.553601957824944*^9, 3.553619269066389*^9, 
  3.553772494338264*^9, 3.553785130982751*^9, 3.5537851941251163`*^9, 
  3.553789206139083*^9, 3.5538648810393*^9}]
}, Open  ]],

Cell["\<\
Divide by the total weight to get separated grams per ounce\
\>", "Text",
 CellChangeTimes->{{3.5435202996620426`*^9, 3.54352030193427*^9}, {
   3.543520361481224*^9, 3.5435203864187174`*^9}, {3.5435212563265047`*^9, 
   3.543521259629835*^9}, 3.553627623407111*^9}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"calorieBreakdown", "/", "totalOunces"}]], "Input",
 CellChangeTimes->{{3.5435204107421494`*^9, 3.5435204527443495`*^9}, {
  3.5435208814858017`*^9, 3.543520884260802*^9}, {3.543523531595023*^9, 
  3.5435235419870625`*^9}, {3.5435247606470118`*^9, 3.5435247696230116`*^9}}],

Cell[BoxData[
 FractionBox[
  RowBox[{"0.940922668436774`", " ", 
   RowBox[{"(", 
    RowBox[{
     RowBox[{"9", " ", "fat", " ", "gram"}], "+", 
     RowBox[{"21", " ", "gram", " ", "protein"}]}], ")"}]}], 
  "ounce"]], "Output",
 CellChangeTimes->{
  3.5435203455436306`*^9, 3.5435204337234473`*^9, 3.543520886043802*^9, 
   3.543521049762802*^9, 3.5435211802378964`*^9, {3.543523534794343*^9, 
   3.543523556292493*^9}, {3.5435247632820115`*^9, 3.5435247703040113`*^9}, 
   3.5435250198470116`*^9, 3.5435286118680153`*^9, 3.543578784549303*^9, 
   3.5535552337279377`*^9, 3.5536019578989553`*^9, 3.553619269115671*^9, 
   3.553772494404841*^9, 3.553785131046331*^9, 3.5537851941914473`*^9, 
   3.553789206186878*^9, 3.5538648810933056`*^9}]
}, Open  ]],

Cell["\<\
Multiply by ServingSize, retrieved from the original block, and apply just \
the calorie rules:\
\>", "Text",
 CellChangeTimes->{{3.5435204738061447`*^9, 3.5435205014743776`*^9}, {
  3.543520616880836*^9, 3.543520618648659*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"calorieRules", "=", 
   RowBox[{"{", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{
      RowBox[{"gram", " ", "fat"}], "\[Rule]", 
      RowBox[{"9", "calorie"}]}], ",", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"gram", " ", "protein"}], "\[Rule]", 
      RowBox[{"4", "calorie"}]}], ",", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"gram", " ", "carbs"}], "\[Rule]", 
      RowBox[{"4", "calorie"}]}]}], "}"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.543520622657258*^9, 3.543520704205103*^9}, 
   3.553627638864071*^9}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"4", " ", "ounce", " ", "*", " ", 
    RowBox[{"calorieBreakdown", "/", "totalOunces"}]}], ")"}], "/.", 
  "calorieRules"}]], "Input",
 CellChangeTimes->{{3.543520516601865*^9, 3.5435205818983345`*^9}, {
  3.5435206928562374`*^9, 3.5435206959659266`*^9}, {3.543520894438802*^9, 
  3.543520929595802*^9}, {3.5435212775046225`*^9, 3.543521281152987*^9}}],

Cell[BoxData[
 RowBox[{"621.0089611682708`", " ", "calorie"}]], "Output",
 CellChangeTimes->{{3.543520563376187*^9, 3.5435205826142626`*^9}, {
   3.5435206966798553`*^9, 3.54352070573195*^9}, 3.543520901516802*^9, 
   3.543521049979802*^9, 3.5435211803709097`*^9, 3.5435235564295063`*^9, 
   3.5435250199840117`*^9, 3.5435286120080147`*^9, 3.5435787846483088`*^9, 
   3.553555233822648*^9, 3.553601958030856*^9, 3.5536192692815228`*^9, 
   3.553772494515126*^9, 3.553785131170403*^9, 3.5537851943158092`*^9, 
   3.553789206310184*^9, 3.553864881163313*^9}]
}, Open  ]],

Cell["\<\
Uh, oh. That is a different story. Perhaps the salad with lemon would be a \
better lunch.\
\>", "Text",
 CellChangeTimes->{{3.5435207105784655`*^9, 3.5435207180577173`*^9}, {
   3.5435209069948015`*^9, 3.543520924337802*^9}, {3.5435212872155933`*^9, 
   3.543521287271599*^9}, 3.553772850309524*^9}],

Cell["\<\
We note in passing that the burger NFL does not report any weight or calories \
from carbs, but the expressions we wrote are general and would handle other \
nutrition fact labels that do have carbs.\
\>", "Text",
 CellChangeTimes->{{3.553772797342209*^9, 3.553772878980307*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["WITH STRING KEYS", "Subsection",
 CellChangeTimes->{{3.543521566756544*^9, 3.5435215705569243`*^9}, {
  3.55377311887856*^9, 3.553773120502441*^9}}],

Cell["\<\
It\[CloseCurlyQuote]s equally possible to do the entire scheme above using \
strings with embedded spaces for keys instead of using symbols in camelBack. \
Consider the following:\
\>", "Text",
 CellChangeTimes->{{3.543521598846753*^9, 3.5435216460724754`*^9}, {
  3.553772890876157*^9, 3.553772895995453*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"burgerNutritionFacts", "=", 
    RowBox[{"{", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"\"\<Serving Size\>\"", "\[Rule]", 
       RowBox[{"4", " ", "ounce"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"\"\<Amount per Serving\>\"", "\[Rule]", " ", 
       RowBox[{"160", " ", "calorie"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"\"\<Calories from Fat\>\"", "\[Rule]", 
       RowBox[{"81.0", " ", "calorie"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"\"\<Saturated Fat\>\"", "\[Rule]", 
       RowBox[{"4", " ", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"\"\<Cholesterol\>\"", "\[Rule]", 
       RowBox[{"60", "milli", " ", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"\"\<Sodium\>\"", "\[Rule]", 
       RowBox[{"70", " ", "milli", " ", "gram"}]}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"\"\<Dietary Fiber\>\"", "\[Rule]", 
       RowBox[{"0", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"\"\<Sugars\>\"", "\[Rule]", 
       RowBox[{"0", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"\"\<Total Fat\>\"", "\[Rule]", 
       RowBox[{"9", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"\"\<Protein\>\"", "\[Rule]", 
       RowBox[{"21", "gram"}]}], ",", "\[IndentingNewLine]", 
      RowBox[{"\"\<Total Carbohydrate\>\"", "\[Rule]", 
       RowBox[{"0", " ", "gram"}]}]}], "}"}]}], ")"}], "//", 
  "gridRules"}]], "Input",
 CellChangeTimes->{{3.5435216485487227`*^9, 3.5435217194078083`*^9}, {
   3.5435218274136076`*^9, 3.543521830685935*^9}, 3.5536276639227247`*^9}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"\<\"Serving Size\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"4"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"ounce"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"Amount per Serving\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"160"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"Calories from Fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"81.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"Saturated Fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"4"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"Cholesterol\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"60"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"milli"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"Sodium\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"70"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"milli"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"Dietary Fiber\"\>"}
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
              {"0"}
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
              {"\<\"Sugars\"\>"}
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
              {"0"}
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
              {"\<\"Total Fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"9"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"Protein\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"21"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"Total Carbohydrate\"\>"}
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
              {"0"}
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
 CellChangeTimes->{
  3.5435217784107075`*^9, {3.5435218180486712`*^9, 3.5435218344123077`*^9}, 
   3.5435235565965233`*^9, 3.543525020053012*^9, 3.543528612079015*^9, 
   3.543578784701312*^9, 3.5535552338661213`*^9, 3.553601958120915*^9, 
   3.553619269366868*^9, {3.553627657778104*^9, 3.553627666385934*^9}, 
   3.553772494559512*^9, 3.553785131237185*^9, 3.553785194377098*^9, 
   3.5537892063598948`*^9, 3.5538648812613225`*^9}]
}, Open  ]],

Cell["And our first computation as follows:", "Text",
 CellChangeTimes->{{3.543521726565524*^9, 3.543521734957363*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
  "\"\<Total Fat\>\"", "+", "\"\<Dietary Fiber\>\"", "+", "\"\<Protein\>\"", 
   "+", "\"\<Total Carbohydrate\>\""}], "/.", 
  "burgerNutritionFacts"}]], "Input",
 CellChangeTimes->{{3.543521737517619*^9, 3.543521776313498*^9}, {
  3.5435218109409604`*^9, 3.5435218414200077`*^9}}],

Cell[BoxData[
 RowBox[{"30", " ", "gram"}]], "Output",
 CellChangeTimes->{3.5435217807439413`*^9, 3.5435218118110476`*^9, 
  3.543521842388105*^9, 3.54352355666753*^9, 3.543525020206012*^9, 
  3.543528612147015*^9, 3.543578784751315*^9, 3.5535552339130983`*^9, 
  3.5536019581801243`*^9, 3.553619269412198*^9, 3.553627672215222*^9, 
  3.553772494602261*^9, 3.553785131293084*^9, 3.5537851944246597`*^9, 
  3.553789206423173*^9, 3.553864881328329*^9}]
}, Open  ]],

Cell[TextData[{
 "All the rest can be done similarly. This works because Jacquard and ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " do not overload + for string concatenation, but rather use a primitive ",
 StyleBox["StringJoin",
  FontSlant->"Italic"],
 " function and a different infix operator, namely <>."
}], "Text",
 CellChangeTimes->{{3.5435218484107075`*^9, 3.5435219120380692`*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["ALICE USES JACQUARD", "Subsection",
 CellChangeTimes->{{3.5435200472738066`*^9, 3.5435200533694158`*^9}}],

Cell["\<\
We hope that the advantages of automated arithmetic over symbolic units and \
dimensions are obvious at this point.\
\>", "Text",
 CellChangeTimes->{{3.5435207819688015`*^9, 3.5435208308868017`*^9}, {
  3.543527310931015*^9, 3.5435273123870153`*^9}, {3.553627688060416*^9, 
  3.5536276884040737`*^9}}],

Cell[CellGroupData[{

Cell["An Exercise", "Subsubsection",
 CellChangeTimes->{{3.5435232763203955`*^9, 3.5435232797923956`*^9}}],

Cell["\<\
We leave it as an exercise to the reader to reproduce the computations above \
in native JavaScript, including at least some of the symbolic manipulation of \
units of measure. It will take you quite a lot of code just to catch errors, \
and if you go all the way to doing arithmetic with units, you will have \
implemented a decent fraction of the core capability of a general \
symbolic-computing system. Our suggestion is to begin with a version of the \
nutrition-facts data block similar to the following:\
\>", "Text",
 CellChangeTimes->{{3.5435207499575267`*^9, 3.543520778049802*^9}, {
  3.5435213002078924`*^9, 3.5435214057334437`*^9}, {3.5435219199508605`*^9, 
  3.5435219412479897`*^9}, {3.543528854680015*^9, 3.543528855926015*^9}}],

Cell["\<\
var burgerNutritionFacts003 = 
{ 'Serving Size'       : [  4,   'ounce'     ],
  'Amount per Serving' : [160,   'calorie'   ],
  'Calories from Fat'  : [ 81.0, 'calorie'   ],
  'Saturated Fat'      : [  4,   'gram'      ],
  'Cholesterol'        : [ 60,   'milli gram'],
  'Sodium'             : [ 70,   'milli gram'],
  'Dietary Fiber'      : [  0,   'gram'      ],
  'Sugars'             : [  0,   'gram'      ],
  'Total Fat'          : [  9,   'gram'      ],
  'Protein'            : [ 21,   'gram'      ],
  'Total Carbohydrate' : [  0,   'gram'      ]
};\
\>", "Program",
 CellChangeTimes->{{3.5435214536752377`*^9, 3.5435215364975185`*^9}, {
  3.5435237763304944`*^9, 3.5435237938052416`*^9}, {3.543523870346895*^9, 
  3.543523871954056*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["Just Use It", "Subsubsection",
 CellChangeTimes->{{3.543523285024396*^9, 3.543523291111396*^9}}],

Cell[TextData[{
 "Alice doesn\[CloseCurlyQuote]t want to do this exercise because she has \
access to Jacquard APIs in JavaScript. Assume that we have a JavaScript \
object ",
 StyleBox["jqd",
  FontSlant->"Italic"],
 " whose methods are those APIs (documented elsewhere). She does her \
computations as follows. Starting with her original JavaScript object for the \
nutrition facts, she gets a rules form:"
}], "Text",
 CellChangeTimes->{{3.543521547267596*^9, 3.5435215553804073`*^9}, {
  3.5435219464725122`*^9, 3.543521976569522*^9}, {3.5435221542195005`*^9, 
  3.543522198828039*^9}, {3.5435241849390116`*^9, 3.5435242237530117`*^9}, {
  3.5435242758470116`*^9, 3.5435242758870115`*^9}, {3.553773187909218*^9, 
  3.553773190389098*^9}}],

Cell["\<\
var burgerRules = jqd.RulesFromObject(burgerNutritionFacts001);\
\>", "Program",
 CellChangeTimes->{{3.543522241109811*^9, 3.5435222755203695`*^9}, {
   3.5435227796573954`*^9, 3.5435227857213955`*^9}, {3.5435228719003954`*^9, 
   3.543522872868396*^9}, 3.5435232967753954`*^9, {3.5435242423490114`*^9, 
   3.5435242683840113`*^9}}],

Cell["\<\
She now gets a symbolic form of the weight-extraction expression:\
\>", "Text",
 CellChangeTimes->{{3.543522290030918*^9, 3.543522357670396*^9}}],

Cell["\<\
var totalWeight = jqd.Expression('\"Total Fat\" + \"Dietary Fiber\" + \
\"Protein\" + \"Total Carbohydrate\"');\
\>", "Program",
 CellChangeTimes->{{3.5435223634943953`*^9, 3.5435224628253956`*^9}, {
  3.5435225846433954`*^9, 3.543522600130396*^9}, {3.543523300847396*^9, 
  3.5435233015993958`*^9}, {3.543523877346595*^9, 3.543523891250985*^9}, {
  3.5435242430360117`*^9, 3.543524285230012*^9}, {3.543527746205015*^9, 
  3.543527801091015*^9}, {3.553627754355187*^9, 3.55362777399364*^9}}],

Cell["Next, she applies the object to the expression", "Text",
 CellChangeTimes->{{3.5435227401243954`*^9, 3.5435227654893956`*^9}}],

Cell["\<\
var burgerImpliedWeight = jqd.ReplaceAll(totalWeight, burgerRules);
// or jqd.Expression('totalWeight /. burgerRules')
console.logJacquardFullForm(burgerImpliedWeight)\
\>", "Program",
 CellChangeTimes->{{3.5435228043203955`*^9, 3.5435229070753956`*^9}, {
   3.5435229720563955`*^9, 3.5435229733033953`*^9}, 3.5435233073833957`*^9, {
   3.5435242450210114`*^9, 3.5435242689110117`*^9}, {3.543527819323015*^9, 
   3.5435278365600147`*^9}}],

Cell["which produces the following on the console", "Text",
 CellChangeTimes->{{3.5435229096983957`*^9, 3.5435229149703956`*^9}}],

Cell["Times[30, gram]", "Program",
 CellChangeTimes->{{3.543522924250396*^9, 3.5435229489443955`*^9}}],

Cell["She now encodes her unit conversions", "Text",
 CellChangeTimes->{{3.543523035741396*^9, 3.5435230412043953`*^9}}],

Cell["\<\
var unitConversions = jqd.RulesFromObject({
  milli : 1/1000.0, 
  gram  : jqd.Expression('ounce / 28.35')});\
\>", "Program",
 CellChangeTimes->{{3.5435230512673955`*^9, 3.543523192156396*^9}, {
  3.543523321351001*^9, 3.543523328582724*^9}, {3.5435242456760116`*^9, 
  3.543524305989012*^9}, {3.543527851200015*^9, 3.543527866991015*^9}}],

Cell["and applies them", "Text",
 CellChangeTimes->{{3.5435231959963956`*^9, 3.5435231979643955`*^9}}],

Cell["\<\
var totalOunces = jqd.Expression(
  'totalWeight + \"Cholesterol\" + \"Sodium\" /.
      burgerRules /. 
    unitConversions');
console.logJacquardFullForm(totalOunces);\
\>", "Program",
 CellChangeTimes->{{3.5435232095233955`*^9, 3.5435232589293957`*^9}, {
  3.5435233375196176`*^9, 3.5435234495888233`*^9}, {3.543523897924652*^9, 
  3.5435239020530653`*^9}, {3.5435242468840113`*^9, 3.5435242695330114`*^9}, {
  3.5435243147090116`*^9, 3.5435243152920113`*^9}, {3.543527877175015*^9, 
  3.543527964938015*^9}, {3.553627799968964*^9, 3.553627817168297*^9}}],

Cell["Producing", "Text",
 CellChangeTimes->{{3.5435234527811427`*^9, 3.5435234538292475`*^9}}],

Cell["Times[1.0627866, ounce]", "Program",
 CellChangeTimes->{{3.543523463534218*^9, 3.543523477038568*^9}}],

Cell[TextData[{
 "Side stepping the intermediate, exploratory computation with ",
 StyleBox["ReplaceRepeated",
  FontSlant->"Italic"],
 ", she creates more components of  the computation:"
}], "Text",
 CellChangeTimes->{{3.543523596676531*^9, 3.543523602389102*^9}, {
   3.5435239901118703`*^9, 3.543524014521311*^9}, 3.543528170216015*^9, {
   3.5435282674270153`*^9, 3.543528278115015*^9}, {3.543577882482708*^9, 
   3.54357788461983*^9}, {3.553627833528969*^9, 3.553627834007536*^9}}],

Cell["\<\
var fatRules     = jqd.Expression('gram -> gram fat');
var proteinRules = jqd.Expression('gram -> gram protein');
var carbRules    = jqd.Expression('gram -> gram carbs');

var calorieBreakdown = jqd.Expression('
  (TotalFat          /. burgerNutritionFacts /. fatRules) +
  (Protein           /. burgerNutritionFacts /. proteinRules) +
  (TotalCarbohydrate /. burgerNutritionFacts /. carbRules)');

var calorieRules = jqd.Expression('calorieRules = {
  gram fat     -> 9 calorie,
  gram protein -> 4 calorie,
  gram carbs   -> 4 calorie}');\
\>", "Program",
 CellChangeTimes->{{3.5435236142532883`*^9, 3.54352362787065*^9}, {
  3.5435236605939217`*^9, 3.5435237015620184`*^9}, {3.5435239037482347`*^9, 
  3.5435239864004993`*^9}, {3.5435240199628553`*^9, 3.5435241637640114`*^9}, {
  3.5435242491610117`*^9, 3.543524268277012*^9}, {3.5435243248210115`*^9, 
  3.5435243952400117`*^9}, {3.543527990411015*^9, 3.543528147641015*^9}, {
  3.543528179616015*^9, 3.5435282479020147`*^9}, {3.543577876588371*^9, 
  3.5435779131864643`*^9}, {3.553627843295912*^9, 3.5536278775830517`*^9}}],

Cell["And finishes up with this:", "Text",
 CellChangeTimes->{{3.543524413048012*^9, 3.543524423711012*^9}}],

Cell["\<\
console.logJacquardInputForm(jqd.Quotient(calorieBreakdown, totalOunces));\
\>", "Program",
 CellChangeTimes->{{3.543524431902012*^9, 3.5435247351440115`*^9}, 
   3.5435249496130114`*^9, {3.543528301747015*^9, 3.543528350263015*^9}, {
   3.543528456323015*^9, 3.543528456913015*^9}}],

Cell["producing", "Text",
 CellChangeTimes->{{3.543524742119012*^9, 3.5435247431110115`*^9}}],

Cell["(0.940922668436774*(9*fat*gram + 21*gram*protein))/ounce", "Program",
 CellChangeTimes->{{3.5435247783260117`*^9, 3.5435247813090115`*^9}, {
  3.5435283536070147`*^9, 3.543528354639015*^9}, {3.543528461458015*^9, 
  3.543528508071015*^9}}],

Cell["and, playing with various options", "Text",
 CellChangeTimes->{{3.543524805796012*^9, 3.5435248060040116`*^9}, {
  3.543528539189015*^9, 3.543528545077015*^9}}],

Cell["\<\
console.logJacquardFullForm(
  jqd.ReplaceAll(
    jqd.Expression('4 ounce * calorieBreakdown/totalOunces'),
    calorieRules));\
\>", "Program",
 CellChangeTimes->{{3.5435248261230116`*^9, 3.5435248818000116`*^9}, {
  3.5435249268300114`*^9, 3.543524945317012*^9}, {3.543528536319015*^9, 
  3.543528593731015*^9}, {3.5536278973832607`*^9, 3.553627904310177*^9}}],

Cell["producing", "Text",
 CellChangeTimes->{{3.5435248859600115`*^9, 3.5435248870320115`*^9}}],

Cell["Times[621.008961,calorie]", "Program",
 CellChangeTimes->{{3.5435249032790117`*^9, 3.5435249217660117`*^9}}]
}, Open  ]]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["CREATING NFL\[CloseCurlyQuote]S ON-THE-FLY", "Section",
 CellChangeTimes->{{3.553773204646352*^9, 3.553773215364349*^9}}],

Cell[TextData[{
 "We spent the first half of this paper demonstrating that NFLs mined off the \
web are untrustworthy, as an exhibition of basic technique in symbolic \
computing. Now, we change philosophy altogether and pursue a different \
agenda: using mined NFLs to generated new NFLs from recipes. Imagine an app \
that can OCR a recipe from an image of its text or even deduce a recipe from \
recognition of an image of a dish at a restaurant or market. Now suppose that \
the app could immediately report an NFL even if it has never seen the recipe \
before. This is a much more adventurous use of symbolic computing, involving \
metarules that write rules that rewrite expressions; vector-space operations \
like canonicalization and normalization; and monadic operators like ",
 StyleBox["SelectMany", "Code"],
 " and ",
 StyleBox["Fold", "Code"],
 ". "
}], "Text",
 CellChangeTimes->{{3.553788778790607*^9, 3.5537889860874243`*^9}, {
  3.553867448032886*^9, 3.553867463216404*^9}, {3.5538675463977213`*^9, 
  3.5538676463627167`*^9}, {3.553867700030083*^9, 3.55386780160924*^9}, {
  3.5538678585299315`*^9, 3.5538679491369915`*^9}, {3.553868190856161*^9, 
  3.553868219241999*^9}, {3.5538682602961044`*^9, 3.553868433535426*^9}}],

Cell["\<\
To be clear, the following does not present technology for OCR or for \
recognizing images of meals -- that's the imagineering part. We show below \
just the technology for synthesizing NFLs given recipes. \
\>", "Text",
 CellChangeTimes->{{3.553788778790607*^9, 3.5537889860874243`*^9}, {
  3.553867448032886*^9, 3.553867463216404*^9}, {3.5538675463977213`*^9, 
  3.5538676463627167`*^9}, {3.553867700030083*^9, 3.55386780160924*^9}, {
  3.5538678585299315`*^9, 3.5538679491369915`*^9}, {3.553868190856161*^9, 
  3.553868219241999*^9}, {3.5538682602961044`*^9, 3.5538684371937923`*^9}}],

Cell[CellGroupData[{

Cell["Mom\[CloseCurlyQuote]s Secret Recipe", "Subsection",
 CellChangeTimes->{{3.5538646471139097`*^9, 3.5538646522584243`*^9}}],

Cell["\<\
This following is your mom\[CloseCurlyQuote]s secret recipe for Pasta \
Primavera. It doesn\[CloseCurlyQuote]t have a published Nutrition Facts \
Label. Can we compute one on-the-fly?\
\>", "Text",
 CellChangeTimes->{{3.5535409252897463`*^9, 3.553540948056746*^9}, {
  3.553781976731471*^9, 3.553781995936749*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"myRecipe", "=", 
   RowBox[{"{", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"1.0", " ", "Tablespoon", " ", "\"\<olive oil\>\""}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"16.0", " ", "Ounce", " ", "\"\<zucchini\>\""}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"3.5", " ", "Teaspoon", " ", "\"\<salt\>\""}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"1.5", " ", "Pound", " ", "\"\<eggplant\>\""}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"1.0", " ", "\"\<onion\>\""}], ",", "\[IndentingNewLine]", 
     RowBox[{"2.0", " ", "\"\<bell pepper\>\""}], ",", "\[IndentingNewLine]", 
     RowBox[{"14.5", " ", "Ounce", " ", "\"\<stewed tomato\>\""}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"0.5", " ", "Teaspoon", " ", "\"\<black pepper\>\""}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"0.5", " ", "Teaspoon", " ", "\"\<dried basil\>\""}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"0.5", " ", "Teaspoon", " ", "\"\<sugar\>\""}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"12.0", " ", "Ounce", " ", "\"\<pasta\>\""}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"0.25", " ", "Cup", " ", "\"\<parmesan cheese\>\""}]}], "}"}]}], 
  ";"}]], "Code",
 InitializationCell->False,
 CellChangeTimes->{{3.5443620540864058`*^9, 3.544362219111907*^9}, {
   3.5443684706175194`*^9, 3.5443684766695194`*^9}, {3.5443685871715193`*^9, 
   3.5443686086105194`*^9}, {3.544372018764181*^9, 3.5443720425355577`*^9}, {
   3.5443745690292053`*^9, 3.544374596102913*^9}, {3.544374756734974*^9, 
   3.5443747834076414`*^9}, 3.5443907471010656`*^9, {3.544390783275066*^9, 
   3.544390872118066*^9}, {3.5447286544053726`*^9, 3.5447286575893726`*^9}, {
   3.546629022248646*^9, 3.5466290336626463`*^9}}],

Cell["\<\
The recipe is expressed as symbolic multiplications -- products of numerical \
quantities, symbolic units of measure, and strings that name the ingredients. \
We will use patterns and rules to reduce this to an NFL in a sequence of \
rewrites: first, convert everything to a weight in grams; then, mine the web \
for unit NFLs, one for each ingredient; then multiply each unit ingredient by \
the quantity in the recipe; then add the NFLs component-wise. You will \
recognize this as constructing a vector in NFL space wherein the basis \
vectors are the unit ingredients.\
\>", "Text",
 CellChangeTimes->{{3.553541119670106*^9, 3.553541204090547*^9}, {
  3.553782008239954*^9, 3.553782234160693*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["Mining Density Facts", "Subsection",
 CellChangeTimes->{{3.553864697636962*^9, 3.553864701592357*^9}}],

Cell["\<\
Some of the ingredients are expressed as volumes: Tablespoon, Teaspoon, Cup. \
Let\[CloseCurlyQuote]s mine some density facts from the web:\
\>", "Text",
 CellChangeTimes->{{3.5537822517598658`*^9, 3.553782304753305*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"density", "[", "\"\<olive oil\>\"", "]"}], " ", "=", " ", 
   RowBox[{
    RowBox[{"Mean", "[", 
     RowBox[{"{", 
      RowBox[{"6.68", ",", "7.67"}], "}"}], "]"}], " ", "*", " ", 
    RowBox[{"Pound", " ", "/", " ", "Gallon"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"density", "[", "\"\<salt\>\"", "]"}], " ", "=", " ", 
   RowBox[{"5.69", " ", 
    RowBox[{"Gram", " ", "/", " ", "Teaspoon"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"density", "[", "\"\<black pepper\>\"", "]"}], " ", "=", " ", 
   RowBox[{"2.1", " ", 
    RowBox[{"Gram", " ", "/", " ", "Teaspoon"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"density", "[", "\"\<dried basil\>\"", "]"}], " ", "=", " ", 
   RowBox[{"1.0", " ", 
    RowBox[{"Gram", " ", "/", " ", "Teaspoon"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"density", "[", "\"\<sugar\>\"", "]"}], " ", "=", " ", 
   RowBox[{"4.2", " ", 
    RowBox[{"Gram", " ", "/", " ", "Teaspoon"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"density", "[", "\"\<parmesan cheese\>\"", "]"}], " ", "=", " ", 
   RowBox[{"88", " ", 
    RowBox[{"Gram", " ", "/", " ", "Cup"}]}]}], ";"}]}], "Code",
 InitializationCell->False,
 CellChangeTimes->{{3.54438388322441*^9, 3.544383948586946*^9}, {
   3.5443839933904257`*^9, 3.5443840561547017`*^9}, {3.5443841005651426`*^9, 
   3.544384117055791*^9}, {3.544384175978683*^9, 3.5443841762507105`*^9}, {
   3.5443910263040657`*^9, 3.5443910566860657`*^9}, {3.5443911059160657`*^9, 
   3.5443911067470655`*^9}, {3.544451638851782*^9, 3.5444516545239153`*^9}, 
   3.544531335073104*^9, 3.5447276705999327`*^9, {3.544729411517495*^9, 
   3.544729415844928*^9}, {3.5447538320897217`*^9, 3.5447538703279095`*^9}, 
   3.546629010113646*^9, {3.546629055373646*^9, 3.546629100304646*^9}, {
   3.548695590412958*^9, 3.548695595813958*^9}, {3.5498987387381067`*^9, 
   3.5498987408302345`*^9}, {3.553782324305854*^9, 3.553782346223418*^9}}],

Cell["\<\
Here, we represent the facts as a lookup table just for variety. This is very \
similar to the way we would write it in JavaScript. This could also be \
represented as a list of replacement rules as we have been doing all along, \
and, indeed, it is internally. Since we don\[CloseCurlyQuote]t need to apply \
these rules to expressions, but only need to look up the values corresponding \
to each ingredient, we can write them in a form more familiar to the \
JavaScript programmer in this case. \
\>", "Text",
 CellChangeTimes->{{3.5535413531934557`*^9, 3.553541407668903*^9}, {
  3.553782371458651*^9, 3.553782550704871*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Converting Density Facts to the Recipe\[CloseCurlyQuote]s Volume Units\
\>", "Subsection",
 CellChangeTimes->{{3.553864675995798*^9, 3.553864693292527*^9}}],

Cell[TextData[{
 "Given a target volume measure and a density fact, the following is a rule \
to rewrite the density fact in the form of Grams per unit of the target \
volume measure. The rule is written in functional notation with a patten on \
the left and a replacement to the right of the definition operator ",
 StyleBox[":=", "Code"],
 ". The pattern will match any expression of the form ",
 Cell[BoxData[
  FormBox[
   RowBox[{"g", "[", 
    RowBox[{"t", ",", " ", 
     RowBox[{"d", " ", "*", " ", 
      RowBox[{"w", " ", "/", " ", "v"}]}]}], "]"}], TraditionalForm]],
  FormatType->"TraditionalForm"],
 ", where ",
 Cell[BoxData[
  FormBox["g", TraditionalForm]],
  FormatType->"TraditionalForm"],
 " is the literal symbol ",
 StyleBox["gramPerTargetVolumeFromDensity", "Code"],
 ", ",
 Cell[BoxData[
  FormBox["t", TraditionalForm]],
  FormatType->"TraditionalForm"],
 " is the pattern variable ",
 StyleBox["targetVolume_", "Code"],
 ", which will match any expression, ",
 Cell[BoxData[
  FormBox["d", TraditionalForm]],
  FormatType->"TraditionalForm"],
 " is a number, ",
 Cell[BoxData[
  FormBox["w", TraditionalForm]],
  FormatType->"TraditionalForm"],
 " is the pattern variable ",
 StyleBox["weight_", "Code"],
 ", which will match any expression, and ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]],
  FormatType->"TraditionalForm"],
 " is the pattern variable ",
 StyleBox["volume_", "Code"],
 ", which will match any expression. The replacement is ",
 StyleBox["(d * Convert[weight, Gram]) / Convert[volume, targetVolume]", 
  "Code"],
 ", wherein the appearances of the pattern variables without their \
underscores will be substituted by their values from the pattern match, and ",
 StyleBox["Gram", "Code"],
 " is a symbolic constant. ",
 StyleBox["Convert", "Code"],
 " rewrites to a more generalized form of the units conversion operators we \
used above in Alice\[CloseCurlyQuote]s task, and its definition will be \
omitted here for brevity. We\[CloseCurlyQuote]ve also transitioned to \
capitalized names for units of measure in keeping with standard practice in \
international standards. "
}], "Text",
 CellChangeTimes->{{3.553541420829219*^9, 3.5535414771838536`*^9}, {
  3.5537825632091103`*^9, 3.553783057742498*^9}, {3.553783222590746*^9, 
  3.553783257402886*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"gramPerTargetVolumeFromDensity", "[", "\[IndentingNewLine]", 
   RowBox[{"targetVolume_", ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"d_", "?", "NumberQ"}], " ", "*", " ", 
     RowBox[{"weight_", "/", "volume_"}]}]}], "]"}], ":=", 
  "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"(", 
    RowBox[{"d", "*", 
     RowBox[{"Convert", "[", 
      RowBox[{"weight", ",", "Gram"}], "]"}]}], ")"}], "/", 
   RowBox[{"Convert", "[", 
    RowBox[{"volume", ",", "targetVolume"}], "]"}]}]}]], "Input",
 CellChangeTimes->{{3.544372844767008*^9, 3.5443729744140415`*^9}, {
   3.544373018176665*^9, 3.5443732274228926`*^9}, {3.5443733213308926`*^9, 
   3.544373325595893*^9}, {3.5443733780798926`*^9, 3.5443734087978926`*^9}, 
   3.5443735646148925`*^9, {3.5443737002118926`*^9, 3.5443737254688926`*^9}, {
   3.5443737845798926`*^9, 3.544373843319893*^9}, {3.5443739317318926`*^9, 
   3.5443739472908926`*^9}, {3.5443740785021577`*^9, 3.544374109367244*^9}, {
   3.544374952753574*^9, 3.544374958226121*^9}, {3.544375018484146*^9, 
   3.5443750235486526`*^9}, {3.5443751694202385`*^9, 
   3.5443751753498316`*^9}, {3.544386894041546*^9, 3.5443869071499233`*^9}, {
   3.544531292731119*^9, 3.5445313049951177`*^9}, {3.5445417998467007`*^9, 
   3.544541802725989*^9}, {3.5445465489764476`*^9, 3.5445465857150984`*^9}, {
   3.5447298104909935`*^9, 3.544729824923437*^9}, {3.544885181302472*^9, 
   3.5448851862994723`*^9}, {3.546629200692646*^9, 3.546629236667646*^9}, {
   3.548695409684958*^9, 3.548695415308958*^9}, {3.548695463298958*^9, 
   3.5486954732929583`*^9}, 3.553782577857584*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Converting Quantified Densities into Weights\
\>", "Subsection",
 CellChangeTimes->{{3.553864728782076*^9, 3.553864745063704*^9}}],

Cell[TextData[{
 "The next rule matches the pattern of a numerical quantity times an \
ingredient name times a volume from an explicit list of symbolic constants, \
and will produce a rule to rewrite this quantified volume ingredient as a \
weight in ",
 StyleBox["Grams", "Code"],
 ". Note that this is a meta-rule: a rule producing a new rule. There is an \
additional catch-all rule that rewrites anything that does not match that \
pattern into the emtpy list, ",
 StyleBox["{}", "Code"],
 ". The reason for this catch all is that we are going to run this over the \
recipe through ",
 StyleBox["SelectMany", "Code"],
 ", the composition of ",
 StyleBox["map", "Code"],
 " and ",
 StyleBox["flatten-once", "Code"],
 ", also known as ",
 ButtonBox["flatmap, concatmap, and bind",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikibooks.org/wiki/Haskell/Understanding_monads"], None},
  ButtonNote->"http://en.wikibooks.org/wiki/Haskell/Understanding_monads"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["19"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"en", ".", "wikibooks", ".", "org"}], "/", "wiki"}], "/",
            "Haskell"}], "/", "Understanding_monads"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"000035D7"],
 "]: ",
 ButtonBox["the mother of all monadic operators",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://community.bartdesmet.net/blogs/bart/Default.aspx?PageIndex=2"]\
, None},
  ButtonNote->
   "http://community.bartdesmet.net/blogs/bart/Default.aspx?PageIndex=2"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["20"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{
         RowBox[{"http", ":"}], "//", 
         RowBox[{
           RowBox[{
             RowBox[{
               RowBox[{"community", ".", "bartdesmet", ".", "net"}], "/", 
               "blogs"}], "/", "bart"}], "/", 
           RowBox[{"Default", ".", 
             RowBox[{"aspx", "?", "PageIndex"}]}]}]}], "=", "2"}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"000048B7"],
 "]. The definition of this utility function is omitted for brevity."
}], "Text",
 CellChangeTimes->{{3.5535414982889643`*^9, 3.5535415641015444`*^9}, {
  3.5537831626205273`*^9, 3.553783212535033*^9}, {3.5537832649464006`*^9, 
  3.553783542158533*^9}, {3.553783606906815*^9, 3.5537838091405993`*^9}, {
  3.553783867783228*^9, 3.553783948927845*^9}, {3.553799066826982*^9, 
  3.5537990669554358`*^9}, {3.5537991098601933`*^9, 3.5537991099956417`*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"weightRuleFromQuantifiedIngredientVolume", "[", 
    RowBox[{
     RowBox[{"quantity_", "?", "NumberQ"}], "   ", "*", "   ", "ingredient_", 
     "   ", "*", 
     RowBox[{"volume", ":", 
      RowBox[{"(", 
       RowBox[{
       "Teaspoon", "|", "Tablespoon", "|", "Cup", "|", "FluidOunce", "|", 
        "Pint", "|", "Gallon"}], ")"}]}]}], "]"}], ":=", " ", 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"ingredient", "*", "volume"}], " ", 
    StyleBox["\[Rule]",
     FontSize->36,
     Background->RGBColor[0.88, 1, 0.88]], "\[IndentingNewLine]", 
    RowBox[{"ingredient", "*", 
     RowBox[{"gramPerTargetVolumeFromDensity", "[", 
      RowBox[{"volume", ",", "\[IndentingNewLine]", 
       RowBox[{"density", "[", "ingredient", "]"}]}], "]"}], "*", 
     "volume"}]}]}], ";"}], "\n", 
 RowBox[{
  RowBox[{"weightRuleFromQuantifiedIngredientVolume", "[", "___", "]"}], ":=", 
  RowBox[{"{", "}"}]}]}], "Input",
 CellChangeTimes->{{3.5443761551167984`*^9, 3.544376347594044*^9}, {
   3.5443835577508664`*^9, 3.544383567438835*^9}, {3.5443924123064775`*^9, 
   3.544392418695755*^9}, {3.5445313853461*^9, 3.54453140875459*^9}, {
   3.54454664764571*^9, 3.544546662616715*^9}, {3.5447299767546186`*^9, 
   3.5447300022161646`*^9}, 3.5447300334762897`*^9, 3.544730696745364*^9, 
   3.5448855752011414`*^9, {3.546629278356646*^9, 3.546629287084646*^9}, {
   3.5474911879954276`*^9, 3.5474911941974277`*^9}, 3.5486953492349577`*^9, {
   3.5486954535099583`*^9, 3.548695455633958*^9}, {3.548695613173958*^9, 
   3.548695616272958*^9}, {3.548695706225958*^9, 3.5486957227209578`*^9}, 
   3.553783158352597*^9}],

Cell["\<\
Here are all the volume-to-weight fules from the original recipe. \
\>", "Text",
 CellChangeTimes->{{3.5535415771888533`*^9, 3.553541632420376*^9}, {
  3.5537839633165607`*^9, 3.5537840470076933`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"volumeRules", "=", 
    RowBox[{"SelectMany", "[", 
     RowBox[{"myRecipe", ",", "weightRuleFromQuantifiedIngredientVolume"}], 
     "]"}]}], ")"}], "//", "gridRules"}]], "Input",
 CellChangeTimes->{{3.5443767318664675`*^9, 3.544376750833364*^9}, {
  3.5443836744545355`*^9, 3.5443836868717775`*^9}, {3.544386363259926*^9, 
  3.544386366096938*^9}, {3.544387062438284*^9, 3.5443870928282843`*^9}, {
  3.544730054429385*^9, 3.544730057858728*^9}}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"olive oil\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Tablespoon"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"12.71297890625`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"olive oil\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"salt\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Teaspoon"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"5.69`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"salt\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"black pepper\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Teaspoon"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"2.1`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"black pepper\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"dried basil\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Teaspoon"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"1.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"dried basil\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"sugar\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Teaspoon"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"4.2`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"sugar\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"parmesan cheese\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Cup"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
          TagBox[GridBox[{
             {
              StyleBox[
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"88"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"parmesan cheese\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
 CellChangeTimes->{3.544730058785821*^9, 3.544731886880829*^9, 
  3.544732070689208*^9, 3.54473519147954*^9, 3.544878403985588*^9, 
  3.544884216681058*^9, 3.5466309413999915`*^9, 3.5466311332689915`*^9, 
  3.5466312029849916`*^9, 3.5474881045464277`*^9, 3.5475546778981276`*^9, 
  3.548694987671451*^9, 3.5486950408967733`*^9, 3.548695165030958*^9, 
  3.5486953722339582`*^9, 3.548695620998958*^9, 3.548695725209958*^9, 
  3.5498987791750555`*^9, 3.549904308094781*^9, 3.549904389503056*^9, 
  3.550931368002735*^9, 3.5509315134747353`*^9, 3.550931572387735*^9, 
  3.550931614683235*^9, 3.5535400958527718`*^9, 3.553785131637233*^9, 
  3.553785194643422*^9, 3.553789206733469*^9, 3.5538648814943457`*^9}]
}, Open  ]],

Cell["\<\
We hope that the brevity, clarity, and flexibility of the rule - and - \
replacement paradigm has by now impressed you. The equivalent in JavaScript \
or C # would be a very considerable amount of code.\
\>", "Text",
 CellChangeTimes->{{3.553784050241888*^9, 3.5537840587324657`*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Converting Itemized Ingredients to Weights\
\>", "Subsection",
 CellChangeTimes->{{3.5538647527994776`*^9, 3.553864774296627*^9}}],

Cell[TextData[{
 "Let us do likewise for ingredients expressed as whole items: mine the web \
for typical weights and convert the ingredient lines into rules for \
converting their units and identifiers into weights. The technique will be \
exactly as above: using a rule-pruducing rule and ",
 StyleBox["SelectMany", "Code"],
 ": "
}], "Text",
 CellChangeTimes->{{3.553784078249112*^9, 3.5537841790070343`*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"wholeItemWeight", "[", "\"\<onion\>\"", "]"}], "=", 
   RowBox[{
    RowBox[{"(", 
     RowBox[{"1.0", "/", "3"}], ")"}], "Pound"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"wholeItemWeight", "[", "\"\<bell pepper\>\"", "]"}], "=", 
   RowBox[{"0.5", 
    RowBox[{"Pound", "/", "4"}]}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.544387208533284*^9, 3.544387255917284*^9}, {
  3.544391130305066*^9, 3.544391168415066*^9}, {3.544392315430066*^9, 
  3.544392315656066*^9}, {3.544546764611312*^9, 3.544546770626109*^9}, {
  3.546629627639928*^9, 3.546629645211685*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"weightRuleFromQuantifiedWholeItemIngredient", "[", 
    RowBox[{"_", "  ", "*", "  ", "_String", "  ", "*", "  ", "_Symbol"}], 
    "]"}], "=", 
   RowBox[{"{", "}"}]}], ";"}], "\n", 
 RowBox[{
  RowBox[{
   RowBox[{
   "weightRuleFromQuantifiedWholeItemIngredient", "[", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"_", "?", "NumberQ"}], "  ", "*", "  ", "ingredient_"}], " ", 
    RowBox[{"(*", " ", 
     RowBox[{"do", " ", "match", " ", "a", " ", "pair"}], " ", "*)"}], "]"}], 
   ":=", "\[IndentingNewLine]", 
   RowBox[{"(*", " ", 
    RowBox[{"generate", " ", "the", " ", "following", " ", "rule"}], " ", 
    "*)"}], "\[IndentingNewLine]", 
   RowBox[{"ingredient", 
    StyleBox["\[Rule]",
     FontSize->36,
     Background->RGBColor[0.88, 1, 0.88]], 
    RowBox[{"ingredient", "*", 
     RowBox[{"wholeItemWeight", "[", "ingredient", "]"}]}]}]}], ";"}], "\n", 
 RowBox[{
  RowBox[{
   RowBox[{"weightRuleFromQuantifiedWholeItemIngredient", "[", "___", "]"}], 
   "=", 
   RowBox[{"{", "}"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.547554704237761*^9, 3.54755477343468*^9}, {
  3.553784187608062*^9, 3.5537841910481653`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"wholeItemRules", "=", 
    RowBox[{"SelectMany", "[", 
     RowBox[{"myRecipe", ",", "weightRuleFromQuantifiedWholeItemIngredient"}],
      "]"}]}], ")"}], "//", "gridRules"}]], "Input",
 CellChangeTimes->{{3.544387407004284*^9, 3.544387443379284*^9}, 
   3.5443903347825484`*^9, {3.5443921217640657`*^9, 3.5443921440230656`*^9}, {
   3.5443921874290657`*^9, 3.5443922328110657`*^9}, {3.544392382290066*^9, 
   3.5443923868823934`*^9}, {3.5447301743873796`*^9, 3.544730179613902*^9}}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"\<\"onion\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"0.3333333333333333`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"onion\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Pound"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"bell pepper\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"0.125`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"\<\"bell pepper\"\>"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Pound"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
 CellChangeTimes->{
  3.544730180479989*^9, 3.5447318872688675`*^9, 3.544732070880227*^9, 
   3.5447351915685453`*^9, 3.5448784040985994`*^9, 3.5448843456893387`*^9, 
   3.5466312031129913`*^9, 3.5474881049864273`*^9, {3.547554678065144*^9, 
   3.547554695306868*^9}, 3.5475547816214986`*^9, 3.548694987817466*^9, 
   3.5486950410307865`*^9, 3.548695165154958*^9, 3.548695390104958*^9, 
   3.5486957361169577`*^9, 3.5498987622773657`*^9, 3.549904308139786*^9, 
   3.5499043895500603`*^9, 3.550931368046735*^9, 3.550931513520735*^9, 
   3.550931572430735*^9, 3.5509316147282352`*^9, 3.5535400959087667`*^9, 
   3.5537851317995167`*^9, 3.553785194848589*^9, 3.553789206843254*^9, 
   3.5538648815943556`*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Converting the Recipe to Weights\
\>", "Subsection",
 CellChangeTimes->{{3.553864788096007*^9, 3.553864800097207*^9}}],

Cell["\<\
Now, let\[CloseCurlyQuote]s apply the all the rules we just created from the \
original recipe and the mined volume and whole item facts to the original \
recipe to produce a copy of the recipe with all items as weights: \
\>", "Text",
 CellChangeTimes->{{3.553784214332418*^9, 3.553784321849042*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{
    RowBox[{"myRecipe", "/.", "volumeRules"}], "/.", "wholeItemRules"}], 
   ")"}], "//", "gridRules"}]], "Input",
 CellChangeTimes->{{3.5466319253602386`*^9, 3.5466319558652887`*^9}}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"12.71297890625`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"olive oil\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"16.`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"zucchini\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Ounce"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"19.915000000000003`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"salt\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"1.5`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"eggplant\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Pound"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"0.3333333333333333`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"onion\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Pound"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"0.25`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"bell pepper\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Pound"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"14.5`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"stewed tomato\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Ounce"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"1.05`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"black pepper\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"0.5`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"dried basil\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"2.1`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"sugar\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"12.`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"pasta\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Ounce"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"22.`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"parmesan cheese\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
       FrameStyle->GrayLevel[0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {
           RGBColor[1, 0.9, 0.8], {
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
 CellChangeTimes->{{3.5466319218488874`*^9, 3.5466319277794805`*^9}, {
   3.548695397038958*^9, 3.5486954197459583`*^9}, 3.548695737684958*^9, {
   3.549898768066945*^9, 3.5498987849866366`*^9}, 3.549904308166788*^9, 
   3.549904389585064*^9, 3.550931368073735*^9, 3.550931513668735*^9, 
   3.5509315725407352`*^9, 3.5509316147552347`*^9, 3.553540095953762*^9, 
   3.553785131856366*^9, 3.553785194897683*^9, 3.5537892068895073`*^9, 
   3.5538648816823645`*^9}]
}, Open  ]],

Cell["\<\
and then convert all such weights to Grams by mapping a function over the \
result above:\
\>", "Text",
 CellChangeTimes->{{3.5537843267519608`*^9, 3.55378434739003*^9}, {
  3.5538648042816253`*^9, 3.553864805162713*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{" ", 
  RowBox[{
   RowBox[{"(", 
    RowBox[{"recipeInGrams", "=", "\[IndentingNewLine]", 
     RowBox[{"Map", "[", 
      RowBox[{
       RowBox[{"Function", "[", "\[IndentingNewLine]", 
        RowBox[{"ingredient", ",", "\[IndentingNewLine]", 
         RowBox[{"Convert", "[", 
          RowBox[{"ingredient", ",", "Gram"}], "]"}]}], "]"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"myRecipe", "/.", "volumeRules"}], "/.", "wholeItemRules"}]}],
       "]"}]}], ")"}], "//", "gridRules"}]}]], "Input",
 CellChangeTimes->{{3.5447307679703646`*^9, 3.5447308306703644`*^9}, {
  3.548696269294615*^9, 3.548696279830668*^9}}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"12.71297890625`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"olive oil\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"453.592`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"zucchini\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"19.915000000000003`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"salt\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"680.3879999999999`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"eggplant\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"151.19733333333332`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"onion\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"113.398`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"bell pepper\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"411.06775`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"stewed tomato\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"1.05`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"black pepper\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"0.5`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"dried basil\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"2.1`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"sugar\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"340.19399999999996`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"pasta\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
          StyleBox[
           TagBox[GridBox[{
              {"Times"}
             },
             AutoDelete->False,
             GridBoxAlignment->{"Columns" -> {{Left}}},
             
             GridBoxItemSize->{
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
            "Grid"],
           StripOnInput->False,
           FontWeight->Bold],
          StripOnInput->False,
          LineColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`],
          
          FrontFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          BackFaceColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          
          GraphicsColor->RGBColor[
           0.33333333333333337`, 0, 0.33333333333333337`],
          FontWeight->Bold,
          FontColor->RGBColor[0.33333333333333337`, 0, 0.33333333333333337`]], 
         StyleBox[
          TagBox[GridBox[{
             {"22.`"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"\<\"parmesan cheese\"\>"}
            },
            AutoDelete->False,
            GridBoxAlignment->{"Columns" -> {{Left}}},
            
            GridBoxItemSize->{
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
           "Grid"],
          StripOnInput->False,
          FontWeight->Bold], 
         StyleBox[
          TagBox[GridBox[{
             {"Gram"}
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
       FrameStyle->GrayLevel[0],
       GridBoxAlignment->{"Columns" -> {{Left}}},
       GridBoxBackground->{"Columns" -> {
           RGBColor[1, 0.9, 0.8], {
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
 CellChangeTimes->{{3.544730773674364*^9, 3.544730814238364*^9}, 
   3.5447318873638773`*^9, 3.544732071029242*^9, 3.5447351916135473`*^9, 
   3.5448784041516047`*^9, 3.5448843567362204`*^9, 3.5466309416499915`*^9, 
   3.546631133479992*^9, 3.546631203177992*^9, 3.547488105091428*^9, 
   3.5475546781131487`*^9, 3.5486949879694805`*^9, 3.5486950413598194`*^9, 
   3.5486951652929583`*^9, 3.5486957456289577`*^9, 3.549898794602598*^9, 
   3.5499043081967916`*^9, 3.5499043896180677`*^9, 3.550931368117735*^9, 
   3.5509315141007347`*^9, 3.5509315726407347`*^9, 3.550931614774235*^9, 
   3.553540096004757*^9, 3.553785131948761*^9, 3.553785194965407*^9, 
   3.553789206941382*^9, 3.553864881850381*^9}]
}, Open  ]],

Cell["\<\
Just for fun, let\[CloseCurlyQuote]s see how much Pasta Primavera the recipe \
produces. We\[CloseCurlyQuote]ll do so with another pattern that strips out \
the string identifier, keeping only the quantity and the weight, adding it \
all up, and converting the result to pounds. \
\>", "Text",
 CellChangeTimes->{{3.5537843593819733`*^9, 3.55378448651371*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Convert", "[", 
  RowBox[{
   RowBox[{"Apply", "[", 
    RowBox[{"Plus", ",", 
     RowBox[{"Cases", "[", 
      RowBox[{"recipeInGrams", ",", 
       RowBox[{
        RowBox[{"q_", "*", "_String", "*", "u_Symbol"}], "\[Rule]", 
        RowBox[{"q", " ", "u"}]}]}], "]"}]}], "]"}], ",", "Pound"}], 
  "]"}]], "Input",
 CellChangeTimes->{{3.544446109883408*^9, 3.544446110584408*^9}, {
  3.544735658524254*^9, 3.544735660020339*^9}, {3.544884393011835*^9, 
  3.544884393683835*^9}}],

Cell[BoxData[
 RowBox[{"4.868064388789007`", " ", "Pound"}]], "Output",
 CellChangeTimes->{{3.544446115357408*^9, 3.5444461178544083`*^9}, 
   3.544447937415754*^9, 3.544448129777988*^9, 3.5444564862063885`*^9, 
   3.544456685884389*^9, 3.544456740877389*^9, {3.5444567772813888`*^9, 
   3.544456805797389*^9}, 3.544458735397184*^9, {3.544459872494031*^9, 
   3.5444599017166586`*^9}, {3.544459936198778*^9, 3.544459943124441*^9}, 
   3.544531126165187*^9, 3.5445315793660707`*^9, 3.54453190891057*^9, 
   3.544538513111477*^9, 3.5445419605257206`*^9, 3.5445460408875237`*^9, 
   3.544546699613314*^9, {3.5445468520903716`*^9, 3.5445468687033715`*^9}, 
   3.5445605462000003`*^9, 3.544560873043559*^9, 3.5447308457203646`*^9, 
   3.544731887548896*^9, 3.54473207120826*^9, 3.544735191701553*^9, 
   3.5447356610994005`*^9, 3.54487840420061*^9, {3.5448843738580456`*^9, 
   3.544884394389835*^9}, 3.548695758067958*^9, 3.5498988042695065`*^9, 
   3.5499043082247944`*^9, 3.5499043896510706`*^9, 3.550931368146735*^9, 
   3.550931514189735*^9, 3.550931572669735*^9, 3.550931614792235*^9, 
   3.5535400960367537`*^9, 3.5537851320122337`*^9, 3.553785195027725*^9, 
   3.553789206985909*^9, 3.553864881915388*^9},
 Background->RGBColor[0.88, 1, 0.88]]
}, Open  ]],

Cell["\<\
The recipe produces almost five pounds. Let\[CloseCurlyQuote]s assume it\
\[CloseCurlyQuote]s designed to serve six. \
\>", "Text",
 CellChangeTimes->{{3.553784490679582*^9, 3.553784510603777*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Mining NFLs for the Ingredients\
\>", "Subsection",
 CellChangeTimes->{{3.553864821994396*^9, 3.553864832661463*^9}}],

Cell["\<\
Next, let\[CloseCurlyQuote]s create a constructor that will build an NFL \
object as a list of rules, from facts mined off the web. As a side effect, we \
will keep a list of names of the NFLs and a lookup table that can retrieve \
any NFL given its name. This will help us below when we write the code to \
perform the vector sum from the recipe. Note the style of this constructor \
could be improved considerably. Its parameter list is purely positional; it \
does not leverage pattern-matching to be robust against mistakes in the order \
of arguments. We present it this way just to show an example of ordinary \
procedural programming in Jacquard.\
\>", "Text",
 CellChangeTimes->{{3.553784519868849*^9, 3.5537846279621687`*^9}, {
   3.553785222159253*^9, 3.553785225110817*^9}, 3.553788658911065*^9, {
   3.5537959987475767`*^9, 3.553796132203883*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{"nflNames", "=", 
   RowBox[{"{", "}"}]}], ";"}], "\n", 
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{
    "name_", ",", "\n", "servingSize_", ",", "totalCalories_", ",", 
     "fatCalories_", ",", "\[IndentingNewLine]", "totalFat_", ",", 
     "totalFatPercent_", ",", "saturatedFat_", ",", "\n", 
     "saturatedFatPercent_", ",", "transFat_", ",", "\[IndentingNewLine]", 
     "cholesterol_", ",", "cholesterolPercent_", ",", "sodium_", ",", "\n", 
     "sodiumPercent_", ",", "totalCarbohydrates_", ",", "\n", 
     "totalCarbohydratesPercent_", ",", "dietaryFiber_", ",", "\n", 
     "dietaryFiberPercent_", ",", "sugars_", ",", "protein_", ",", "\n", 
     "proteinPercent_", ",", "vitaminAPercent_", ",", "\n", 
     "vitaminCPercent_", ",", "calciumPercent_", ",", "ironPercent_"}], "]"}],
    ":=", "\n", 
   RowBox[{"(", 
    RowBox[{
     RowBox[{"AppendTo", "[", 
      RowBox[{"nflNames", ",", "name"}], "]"}], ";", "\n", 
     RowBox[{
      RowBox[{"nfls", "[", "name", "]"}], "=", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"\"\<name\>\"", "\[Rule]", "name"}], ",", 
        RowBox[{"\"\<serving size\>\"", "\[Rule]", "servingSize"}], ",", "\n", 
        RowBox[{"\"\<total calories\>\"", "\[Rule]", "totalCalories"}], ",", 
        RowBox[{"\"\<fat calories\>\"", "\[Rule]", "fatCalories"}], ",", "\n", 
        RowBox[{"\"\<total fat\>\"", "\[Rule]", "totalFat"}], ",", 
        RowBox[{"\"\<% daily total fat\>\"", "\[Rule]", "totalFatPercent"}], 
        ",", "\n", 
        RowBox[{"\"\<saturated fat\>\"", "\[Rule]", "saturatedFat"}], ",", 
        "\n", 
        RowBox[{
        "\"\<% daily saturated fat\>\"", "\[Rule]", "saturatedFatPercent"}], 
        ",", "\n", 
        RowBox[{"\"\<trans fat\>\"", "\[Rule]", "transFat"}], ",", 
        RowBox[{"\"\<cholesterol\>\"", "\[Rule]", "cholesterol"}], ",", "\n", 
        RowBox[{
        "\"\<% daily cholesterol\>\"", "\[Rule]", "cholesterolPercent"}], ",",
         "\n", 
        RowBox[{"\"\<sodium\>\"", "\[Rule]", "sodium"}], ",", 
        RowBox[{"\"\<% daily sodium\>\"", "\[Rule]", "sodiumPercent"}], ",", 
        "\n", 
        RowBox[{
        "\"\<total carbohydrates\>\"", "\[Rule]", "totalCarbohydrates"}], ",",
         "\n", 
        RowBox[{
        "\"\<% daily carbohydrates\>\"", "\[Rule]", 
         "totalCarbohydratesPercent"}], ",", "\n", 
        RowBox[{"\"\<dietary fiber\>\"", "\[Rule]", "dietaryFiber"}], ",", 
        "\n", 
        RowBox[{
        "\"\<%daily dietary fiber\>\"", "\[Rule]", "dietaryFiberPercent"}], 
        ",", "\n", 
        RowBox[{"\"\<sugars\>\"", "\[Rule]", "sugars"}], ",", 
        RowBox[{"\"\<protein\>\"", "\[Rule]", "protein"}], ",", "\n", 
        RowBox[{"\"\<% daily protein\>\"", "\[Rule]", "proteinPercent"}], ",",
         "\n", 
        RowBox[{"\"\<vitamin A\>\"", "\[Rule]", "vitaminAPercent"}], ",", 
        RowBox[{"\"\<vitamin C\>\"", "\[Rule]", "vitaminCPercent"}], ",", 
        "\n", 
        RowBox[{"\"\<calcium\>\"", "\[Rule]", "calciumPercent"}], ",", 
        RowBox[{"\"\<iron\>\"", "\[Rule]", "ironPercent"}]}], "}"}]}]}], 
    ")"}]}], ";"}]}], "Code",
 InitializationCell->False,
 CellChangeTimes->{{3.5444519771587067`*^9, 3.5444519919801893`*^9}, {
   3.544456412207389*^9, 3.544456419523389*^9}, 3.544884438129367*^9, 
   3.548695829895958*^9, {3.553784633648183*^9, 3.553784785941805*^9}}],

Cell["\<\
Let\[CloseCurlyQuote]s demonstrate this constructor on one ingredient, \
inspecting the resulting object\
\>", "Text",
 CellChangeTimes->{{3.553784803792807*^9, 3.553784821551076*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"createNutritionFactsLabel", "[", 
   RowBox[{"\"\<olive oil\>\"", ",", 
    RowBox[{"216", " ", "Gram"}], ",", 
    RowBox[{"1910", " ", "Calorie"}], ",", 
    RowBox[{"1910", " ", "Calorie"}], ",", 
    RowBox[{"216", " ", "Gram"}], ",", 
    RowBox[{"332", " ", "Percent"}], ",", 
    RowBox[{"30", " ", "Gram"}], ",", 
    RowBox[{"149", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
    RowBox[{"0", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"4", " ", "Milli", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", "\[IndentingNewLine]", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"7", " ", "Percent"}]}], "]"}], "//", "gridRules"}]], "Input",
 CellChangeTimes->{{3.5447309643203645`*^9, 3.544730968898364*^9}, {
   3.548695781697958*^9, 3.5486957833379583`*^9}, {3.548695813440958*^9, 
   3.548695816617958*^9}, 3.549904265201522*^9, 3.549904348114783*^9, {
   3.553784826775584*^9, 3.553784830640869*^9}}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"\<\"name\"\>"}
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
              {"\<\"olive oil\"\>"}
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
              {"\<\"serving size\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"216"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"total calories\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"1910"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"fat calories\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"1910"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"total fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"216"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily total fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"332"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"saturated fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"30"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily saturated fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"149"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"trans fat\"\>"}
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
              {"0"}
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
              {"\<\"cholesterol\"\>"}
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
              {"0"}
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
              {"\<\"% daily cholesterol\"\>"}
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
              {"0"}
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
              {"\<\"sodium\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"4"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Milli"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily sodium\"\>"}
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
              {"0"}
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
              {"\<\"total carbohydrates\"\>"}
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
              {"0"}
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
              {"\<\"% daily carbohydrates\"\>"}
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
              {"0"}
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
              {"\<\"dietary fiber\"\>"}
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
              {"0"}
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
              {"\<\"%daily dietary fiber\"\>"}
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
              {"0"}
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
              {"\<\"sugars\"\>"}
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
              {"0"}
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
              {"\<\"protein\"\>"}
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
              {"0"}
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
              {"\<\"% daily protein\"\>"}
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
              {"0"}
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
              {"\<\"vitamin A\"\>"}
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
              {"0"}
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
              {"\<\"vitamin C\"\>"}
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
              {"0"}
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
              {"\<\"calcium\"\>"}
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
              {"0"}
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
              {"\<\"iron\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
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
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
 CellChangeTimes->{3.553785132160141*^9, 3.55378519515681*^9, 
  3.553789207075631*^9, 3.5538648820524015`*^9}]
}, Open  ]],

Cell["\<\
Let\[CloseCurlyQuote]s run the others for side-effect, but save space by not \
presenting the results:\
\>", "Text",
 CellChangeTimes->{{3.553784986582541*^9, 3.553785042088628*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{"createNutritionFactsLabel", "[", 
   RowBox[{"\"\<zucchini\>\"", ",", 
    RowBox[{"124", " ", "Gram"}], ",", 
    RowBox[{"20", " ", "Calorie"}], ",", 
    RowBox[{"2", " ", "Calorie"}], ",", "\[IndentingNewLine]", 
    RowBox[{"0", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
    RowBox[{"0", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"12", " ", "Milli", " ", "Gram"}], ",", 
    RowBox[{"1.0", " ", "Percent"}], ",", 
    RowBox[{"4", " ", "Gram"}], ",", 
    RowBox[{"1.0", " ", "Percent"}], ",", 
    RowBox[{"1.0", " ", "Gram"}], ",", 
    RowBox[{"5", " ", "Percent"}], ",", " ", 
    RowBox[{"2", " ", "Gram"}], ",", 
    RowBox[{"2", " ", "Gram"}], ",", 
    RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
    RowBox[{"5", " ", "Percent"}], ",", 
    RowBox[{"35", " ", "Percent"}], ",", " ", 
    RowBox[{"2", " ", "Percent"}], ",", 
    RowBox[{"2", " ", "Percent"}]}], "]"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]}], "Input",
 CellChangeTimes->{{3.5444347314111977`*^9, 3.544434776067752*^9}, {
   3.544434862438692*^9, 3.5444348698791175`*^9}, {3.5444349151697083`*^9, 
   3.544434921688081*^9}, {3.544434974944127*^9, 3.544434994648254*^9}, {
   3.5444351659130497`*^9, 3.544435237330135*^9}, {3.5444479199880114`*^9, 
   3.544447920414054*^9}, {3.544448072911302*^9, 3.5444480732153325`*^9}, {
   3.544451204671461*^9, 3.5444512090397716`*^9}, {3.5444587450291843`*^9, 
   3.544458749108184*^9}, 3.5447311682303643`*^9, {3.5486957906019583`*^9, 
   3.548695804316958*^9}, {3.549898842312054*^9, 3.5498988473865614`*^9}, 
   3.549904269962998*^9, 3.549904353353307*^9, {3.553784977672594*^9, 
   3.553784997449019*^9}, 3.553789187555407*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<salt\>\"", ",", 
     RowBox[{"1.", " ", "Cup"}], ",", 
     RowBox[{"0", " ", "Calorie"}], ",", 
     RowBox[{"0", " ", "Calorie"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"113174", " ", "Milli", " ", "Gram"}], ",", 
     RowBox[{"4716", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", " ", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"7", " ", "Percent"}], ",", 
     RowBox[{"5", " ", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444347314111977`*^9, 3.544434776067752*^9}, {
   3.544434862438692*^9, 3.5444348698791175`*^9}, {3.5444349151697083`*^9, 
   3.544434921688081*^9}, {3.544434974944127*^9, 3.544434994648254*^9}, {
   3.5444351659130497`*^9, 3.544435237330135*^9}, {3.5444353001437273`*^9, 
   3.5444353299994354`*^9}, {3.544435364303397*^9, 3.5444354262719417`*^9}, {
   3.5444463370794077`*^9, 3.5444463764734077`*^9}, {3.5444479212221346`*^9, 
   3.544447921664179*^9}, {3.5444480734603567`*^9, 3.544448073699381*^9}, {
   3.54445121617091*^9, 3.5444512196509542`*^9}, {3.544458759028184*^9, 
   3.544458763019184*^9}, {3.544459839956981*^9, 3.5444598411760893`*^9}, 
   3.5447311801423645`*^9, 3.5447313973153644`*^9, 3.5499042734693484`*^9, {
   3.549904355565528*^9, 3.5499043599639673`*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<eggplant\>\"", ",", 
     RowBox[{"82", " ", "Gram"}], ",", 
     RowBox[{"20", " ", "Calorie"}], ",", 
     RowBox[{"1.0", " ", "Calorie"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"2", " ", "Milli", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"5", " ", "Gram"}], ",", 
     RowBox[{"2", " ", "Percent"}], ",", 
     RowBox[{"3", " ", "Gram"}], ",", 
     RowBox[{"11", "Percent"}], ",", 
     RowBox[{"2", "Gram"}], ",", 
     RowBox[{"1.0", "Gram"}], ",", 
     RowBox[{"2", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", "Percent"}], ",", 
     RowBox[{"3", "Percent"}], ",", 
     RowBox[{"1.0", "Percent"}], ",", 
     RowBox[{"1.0", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444347314111977`*^9, 3.544434776067752*^9}, {
   3.544434862438692*^9, 3.5444348698791175`*^9}, {3.5444349151697083`*^9, 
   3.544434921688081*^9}, {3.544434974944127*^9, 3.544434994648254*^9}, {
   3.5444351659130497`*^9, 3.544435237330135*^9}, {3.544435469825433*^9, 
   3.544435618004908*^9}, {3.544447922263239*^9, 3.544447922664279*^9}, {
   3.5444480739534063`*^9, 3.5444480742164326`*^9}, {3.5444512257567854`*^9, 
   3.5444512281024885`*^9}, {3.544458785707184*^9, 3.544458794818184*^9}, 
   3.5447311952773647`*^9, 3.5499042743284345`*^9, 3.5499043644434156`*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<onion\>\"", ",", 
     RowBox[{"160", " ", "Gram"}], ",", 
     RowBox[{"64", " ", "Calorie"}], ",", 
     RowBox[{"1.0", " ", "Calorie"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"6", " ", "Milli", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"15", " ", "Gram"}], ",", 
     RowBox[{"5", " ", "Percent"}], ",", 
     RowBox[{"3", " ", "Gram"}], ",", 
     RowBox[{"11", "Percent"}], ",", 
     RowBox[{"7", "Gram"}], ",", 
     RowBox[{"2.0", "Gram"}], ",", 
     RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", "Percent"}], ",", 
     RowBox[{"20", "Percent"}], ",", 
     RowBox[{"4", "Percent"}], ",", 
     RowBox[{"2", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444347314111977`*^9, 3.544434776067752*^9}, {
   3.544434862438692*^9, 3.5444348698791175`*^9}, {3.5444349151697083`*^9, 
   3.544434921688081*^9}, {3.544434974944127*^9, 3.544434994648254*^9}, {
   3.5444351659130497`*^9, 3.544435237330135*^9}, {3.544435469825433*^9, 
   3.544435618004908*^9}, {3.544435853353369*^9, 3.544435946694708*^9}, {
   3.544447730200034*^9, 3.544447731576172*^9}, {3.544447923218334*^9, 
   3.544447923528365*^9}, {3.54444807449346*^9, 3.544448074784489*^9}, {
   3.5444512461459*^9, 3.544451248225524*^9}, {3.5444588034331837`*^9, 
   3.5444588070101843`*^9}, 3.544731203252364*^9, 3.549904275046506*^9, 
   3.5499043655865297`*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<bell pepper\>\"", ",", 
     RowBox[{"186", " ", "Gram"}], ",", 
     RowBox[{"50", " ", "Calorie"}], ",", 
     RowBox[{"3.0", " ", "Calorie"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"1.0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"4", " ", "Milli", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"12", " ", "Gram"}], ",", 
     RowBox[{"4", " ", "Percent"}], ",", 
     RowBox[{"2", " ", "Gram"}], ",", 
     RowBox[{"7", "Percent"}], ",", 
     RowBox[{"2", "Gram"}], ",", 
     RowBox[{"2", "Gram"}], ",", 
     RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"7", "Percent"}], ",", 
     RowBox[{"569", "Percent"}], ",", 
     RowBox[{"2", "Percent"}], ",", 
     RowBox[{"5", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444347314111977`*^9, 3.544434776067752*^9}, {
   3.544434862438692*^9, 3.5444348698791175`*^9}, {3.5444349151697083`*^9, 
   3.544434921688081*^9}, {3.544434974944127*^9, 3.544434994648254*^9}, {
   3.5444351659130497`*^9, 3.544435237330135*^9}, {3.544435469825433*^9, 
   3.544435618004908*^9}, {3.544435962400606*^9, 3.544436084622597*^9}, {
   3.544447924046417*^9, 3.544447924617474*^9}, {3.5444480750985208`*^9, 
   3.544448075451556*^9}, {3.544451273473096*^9, 3.5444512769931517`*^9}, {
   3.5444588149701843`*^9, 3.544458817530184*^9}, 3.5447312184193645`*^9, 
   3.5499042758045783`*^9, 3.5499043678447556`*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<stewed tomato\>\"", ",", 
     RowBox[{"101", " ", "Gram"}], ",", 
     RowBox[{"80", " ", "Calorie"}], ",", 
     RowBox[{"24.0", " ", "Calorie"}], ",", "\[IndentingNewLine]", 
     RowBox[{"3", " ", "Gram"}], ",", 
     RowBox[{"4", " ", "Percent"}], ",", 
     RowBox[{"1.0", " ", "Gram"}], ",", 
     RowBox[{"3", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"460", " ", "Milli", " ", "Gram"}], ",", 
     RowBox[{"19", " ", "Percent"}], ",", 
     RowBox[{"13", " ", "Gram"}], ",", 
     RowBox[{"4", " ", "Percent"}], ",", 
     RowBox[{"2", " ", "Gram"}], ",", 
     RowBox[{"7", "Percent"}], ",", 
     RowBox[{"0", "Gram"}], ",", 
     RowBox[{"2", "Gram"}], ",", 
     RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"13", "Percent"}], ",", 
     RowBox[{"31", "Percent"}], ",", 
     RowBox[{"3", "Percent"}], ",", 
     RowBox[{"6", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444467130367193`*^9, 3.544446812922707*^9}, {
   3.544447925209533*^9, 3.544447925683581*^9}, {3.5444480758896*^9, 
   3.544448076259637*^9}, {3.5444512836191387`*^9, 3.544451288849707*^9}, {
   3.544458827688184*^9, 3.5444588316241837`*^9}, {3.5447312255403643`*^9, 
   3.5447312268123646`*^9}, 3.54990427652065*^9, 3.549904369454917*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<black pepper\>\"", ",", 
     RowBox[{"1.", " ", "Tablespoon"}], ",", 
     RowBox[{"16", " ", "Calorie"}], ",", 
     RowBox[{"2", " ", "Calorie"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"3", " ", "Milli", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"4", " ", "Gram"}], ",", 
     RowBox[{"1.", " ", "Percent"}], ",", 
     RowBox[{"2", " ", "Gram"}], ",", 
     RowBox[{"7", " ", "Percent"}], ",", " ", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"1.", " ", "Gram"}], ",", 
     RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"2", " ", "Percent"}], ",", 
     RowBox[{"3", " ", "Percent"}], ",", 
     RowBox[{"10", " ", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444469503904066`*^9, 3.5444470470184064`*^9}, {
   3.5444479263156443`*^9, 3.5444479267646885`*^9}, {3.544448076721683*^9, 
   3.5444480771547265`*^9}, {3.5444512937021627`*^9, 
   3.5444513057687817`*^9}, {3.544458841696184*^9, 3.544458845751184*^9}, {
   3.5444645395334425`*^9, 3.5444645415645585`*^9}, {3.5444646114005423`*^9, 
   3.5444646253973427`*^9}, 3.5447312330913644`*^9, 3.549904277188695*^9, 
   3.5499043729782686`*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<dried basil\>\"", ",", 
     RowBox[{"1.", " ", "Teaspoon"}], ",", 
     RowBox[{"1.0", " ", "Calorie"}], ",", 
     RowBox[{"0", " ", "Calorie"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"1.0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"1.0", " ", "Percent"}], ",", 
     RowBox[{"1.0", " ", "Percent"}], ",", 
     RowBox[{"1.0", " ", "Percent"}], ",", 
     RowBox[{"1.0", " ", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444470732404065`*^9, 3.5444471263504066`*^9}, {
   3.544447927307743*^9, 3.5444479277417865`*^9}, {3.5444480776337743`*^9, 
   3.5444480780668173`*^9}, {3.544451320340152*^9, 3.544451330047063*^9}, 
   3.544458904765184*^9, {3.544458935019184*^9, 3.544458972452223*^9}, 
   3.5447312379063644`*^9, 3.549904277883709*^9, 3.5499043742063913`*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<sugar\>\"", ",", 
     RowBox[{"2", " ", "Gram"}], ",", 
     RowBox[{"11", " ", "Calorie"}], ",", 
     RowBox[{"0", " ", "Calorie"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"3", " ", "Gram"}], ",", 
     RowBox[{"1.00", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"3", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"7", " ", "Percent"}], ",", 
     RowBox[{"5", " ", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444471573884068`*^9, 3.5444472399604063`*^9}, {
   3.5444479283318453`*^9, 3.5444479288228946`*^9}, {3.5444480785928698`*^9, 
   3.5444480790509157`*^9}, {3.5444513376243353`*^9, 3.544451341913622*^9}, {
   3.544458983037281*^9, 3.5444590050854855`*^9}, 3.5447312430903645`*^9, 
   3.549904278831801*^9, 3.549904376002571*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<pasta\>\"", ",", "\[IndentingNewLine]", 
     RowBox[{"128", " ", "Gram"}], ",", 
     RowBox[{"369", " ", "Calorie"}], ",", 
     RowBox[{"25", " ", "Calorie"}], ",", "\[IndentingNewLine]", 
     RowBox[{"3", " ", "Gram"}], ",", 
     RowBox[{"5", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"2", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"93", " ", "*", "Milli", "*", " ", "Gram"}], ",", 
     RowBox[{"31", " ", "Percent"}], ",", 
     RowBox[{"33", " ", "Milli", " ", "Gram"}], ",", 
     RowBox[{"1.0", " ", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"70", " ", "Gram"}], ",", 
     RowBox[{"23", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"14", " ", "Gram"}], ",", 
     RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"1.0", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"2", " ", "Percent"}], ",", 
     RowBox[{"24", " ", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444471573884068`*^9, 3.5444472399604063`*^9}, {
   3.5444473224604063`*^9, 3.544447414384406*^9}, {3.5444479294619584`*^9, 
   3.544447929895002*^9}, {3.544448079576968*^9, 3.5444480801410246`*^9}, {
   3.5444513483155413`*^9, 3.544451352228715*^9}, {3.544459027838761*^9, 
   3.5444590329052677`*^9}, 3.544731248363364*^9, 3.5499042798569036`*^9, 
   3.549904377250696*^9, {3.550931353400735*^9, 3.550931359583735*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"createNutritionFactsLabel", "[", 
    RowBox[{"\"\<parmesan cheese\>\"", ",", 
     RowBox[{"100", " ", "Gram"}], ",", 
     RowBox[{"431", " ", "Calorie"}], ",", 
     RowBox[{"251", " ", "Calorie"}], ",", 
     RowBox[{"29", "Gram"}], ",", 
     RowBox[{"44", "Percent"}], ",", 
     RowBox[{"17", "Gram"}], ",", 
     RowBox[{"86", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"88", "Milli", "*", "Gram"}], ",", 
     RowBox[{"29", "Percent"}], ",", 
     RowBox[{"1529", "Milli", " ", "Gram"}], ",", 
     RowBox[{"64", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"4", " ", "Gram"}], ",", 
     RowBox[{"1.00", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Gram"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"1", " ", "Gram"}], ",", "\[IndentingNewLine]", 
     RowBox[{"38", " ", "Gram"}], ",", 
     RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
     RowBox[{"9", " ", "Percent"}], ",", 
     RowBox[{"0", " ", "Percent"}], ",", 
     RowBox[{"111", " ", "Percent"}], ",", 
     RowBox[{"5", " ", "Percent"}]}], "]"}], ";"}], 
  RowBox[{"(*", " ", 
   RowBox[{"//", "gridRules"}], " ", "*)"}]}]], "Input",
 CellChangeTimes->{{3.5444471573884068`*^9, 3.5444472399604063`*^9}, {
   3.5444474571584063`*^9, 3.5444475474994063`*^9}, {3.544447930446057*^9, 
   3.544447930919104*^9}, {3.5444480807330837`*^9, 3.544448081270138*^9}, {
   3.544451362526804*^9, 3.5444513699610333`*^9}, {3.5444590547444515`*^9, 
   3.544459060778054*^9}, {3.54456090866387*^9, 3.5445609193956494`*^9}, 
   3.544731253002364*^9, {3.549904212538947*^9, 3.54990422867587*^9}, 
   3.549904379108882*^9, {3.550931346707735*^9, 3.550931349322735*^9}}],

Cell["\<\
We\[CloseCurlyQuote]ll add an ingredient that doesn\[CloseCurlyQuote]t appear \
in the recipe just to test that it\[CloseCurlyQuote]s ignored in the \
preparation of the final result:\
\>", "Text",
 CellChangeTimes->{{3.553785059807049*^9, 3.553785103826569*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"createNutritionFactsLabel", "[", 
   RowBox[{"\"\<strange extra ingredient\>\"", ",", 
    RowBox[{"100", " ", "Gram"}], ",", 
    RowBox[{"431", " ", "Calorie"}], ",", 
    RowBox[{"251", " ", "Calorie"}], ",", 
    RowBox[{"29", "Gram"}], ",", 
    RowBox[{"44", "Percent"}], ",", 
    RowBox[{"17", "Gram"}], ",", 
    RowBox[{"86", "Percent"}], ",", 
    RowBox[{"0", " ", "Gram"}], ",", "\[IndentingNewLine]", 
    RowBox[{"88", "Gram"}], ",", 
    RowBox[{"29", "Percent"}], ",", 
    RowBox[{"1529", "Milli", " ", "Gram"}], ",", 
    RowBox[{"64", "Percent"}], ",", "\[IndentingNewLine]", 
    RowBox[{"4", " ", "Gram"}], ",", 
    RowBox[{"1.00", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Gram"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"1", " ", "Gram"}], ",", "\[IndentingNewLine]", 
    RowBox[{"38", " ", "Gram"}], ",", 
    RowBox[{"0", "Percent"}], ",", "\[IndentingNewLine]", 
    RowBox[{"9", " ", "Percent"}], ",", 
    RowBox[{"0", " ", "Percent"}], ",", 
    RowBox[{"111", " ", "Percent"}], ",", 
    RowBox[{"5", " ", "Percent"}]}], "]"}], ";"}]], "Input",
 CellChangeTimes->{{3.549904294723444*^9, 3.549904299208893*^9}, 
   3.5499043804874525`*^9}],

Cell["\<\
At this point, we have a recipe as a list of ingredients in grams with \
numerical coefficients. We also have a database of NFLs that give all the \
components of the label per service size. \
\>", "Text",
 CellChangeTimes->{{3.553788692011469*^9, 3.553788765516765*^9}, {
  3.5537890207583113`*^9, 3.5537890331969547`*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Converting all Densities and Weights into Grams\
\>", "Subsection",
 CellChangeTimes->{{3.5538650080530005`*^9, 3.5538650211973143`*^9}}],

Cell["\<\
The next step is to make a rule to canonicalize the units in an NFL, that is, \
to convert anything that should be a weight into Grams. \
\>", "Text",
 CellChangeTimes->{{3.553789280527834*^9, 3.553789381751562*^9}, {
  3.5537894303207827`*^9, 3.553789560238097*^9}, {3.5537895979888763`*^9, 
  3.553789762264189*^9}, {3.553789793628272*^9, 3.553789819051572*^9}, {
  3.553789859493311*^9, 3.5537898743050327`*^9}, {3.5537899288979597`*^9, 
  3.5537901775035353`*^9}, {3.553790378650127*^9, 3.5537903794299*^9}, {
  3.553795408319847*^9, 3.553795455742179*^9}, {3.553796153964326*^9, 
  3.553796645314426*^9}, {3.553796682414055*^9, 3.5537967571667747`*^9}, {
  3.553797140464788*^9, 3.553797146497984*^9}, {3.553797191742551*^9, 
  3.553797210008583*^9}, {3.5537974271543283`*^9, 3.553797433758664*^9}, {
  3.553864936481844*^9, 3.5538649577099667`*^9}, {3.5538649885230474`*^9, 
  3.553864997538949*^9}}],

Cell[TextData[{
 "The following takes an NFL and maps a function over a transform of the NFL. \
The NFL is a list of rules, and the transform will also be a list of rules. \
The transform does a ",
 StyleBox["ReplaceAll", "Code"],
 " with a pattern that matches original rule lines in the NFL and specifies a \
new rule to write out. The pattern will match any rule line in the NFL of the \
form ",
 Cell[BoxData[
  FormBox[
   RowBox[{"k", " ", "\[Rule]", " ", 
    RowBox[{"n", " ", "*", " ", "v"}]}], TraditionalForm]]],
 ", where ",
 Cell[BoxData[
  FormBox["k", TraditionalForm]]],
 " is the pattern variable ",
 StyleBox["keyWithVolume_", "Code"],
 ", ",
 Cell[BoxData[
  FormBox["n", TraditionalForm]]],
 " is a numerical amount, and ",
 Cell[BoxData[
  FormBox["v", TraditionalForm]]],
 " is a volume chosen from an explicit list of known volumes. The overall \
rule in the transform will rewrite that matched rule line into one with \
densities transformed into weights per unit volume with a weight unit driven \
by the density fact, as before. Finally, the function mapped over the \
transformed rule lines will map the given weights into Grams. "
}], "Text",
 CellChangeTimes->{{3.553789280527834*^9, 3.553789381751562*^9}, {
  3.5537894303207827`*^9, 3.553789560238097*^9}, {3.5537895979888763`*^9, 
  3.553789762264189*^9}, {3.553789793628272*^9, 3.553789819051572*^9}, {
  3.553789859493311*^9, 3.5537898743050327`*^9}, {3.5537899288979597`*^9, 
  3.5537901775035353`*^9}, {3.553790378650127*^9, 3.5537903794299*^9}, {
  3.553795408319847*^9, 3.553795455742179*^9}, {3.553796153964326*^9, 
  3.553796645314426*^9}, {3.553796682414055*^9, 3.5537967571667747`*^9}, {
  3.553797140464788*^9, 3.553797146497984*^9}, {3.553797191742551*^9, 
  3.553797210008583*^9}, {3.5537974271543283`*^9, 3.553797433758664*^9}, {
  3.553864936481844*^9, 3.5538649577099667`*^9}, {3.5538649885230474`*^9, 
  3.553864997538949*^9}}],

Cell[TextData[{
 "We have emphasized the rule arrows to emphasize the fact that there are \
three uses of rule here: one for the input rule, ",
 Cell[BoxData[
  FormBox["\[Rule]", TraditionalForm]]],
 "; one for the interior (meta-) rule that rewrites the input rule into the \
output rule, written ",
 Cell[BoxData[
  FormBox["\[RuleDelayed]", TraditionalForm]]],
 "; and one for the output rule, another instance of ",
 Cell[BoxData[
  FormBox["\[Rule]", TraditionalForm]]],
 ". The interior rule is a ",
 StyleBox["RuleDelayed", "Code"],
 " -- that's the meaning of the strange colon-arrow. It tells the evaluator \
to delay evaluation of the right-hand side until rule-application time so \
that the density lookup will not be done too early. The normal evaluation \
time for the right-hand sides of Rules is at rule-definition time, and that \
is often fine. In this case, however, it would cause the density lookup to be \
done on an input of ",
 StyleBox["\"name\"/.nfl", "Input"],
 ", which would not reduce. "
}], "Text",
 CellChangeTimes->{{3.553789280527834*^9, 3.553789381751562*^9}, {
   3.5537894303207827`*^9, 3.553789560238097*^9}, {3.5537895979888763`*^9, 
   3.553789762264189*^9}, {3.553789793628272*^9, 3.553789819051572*^9}, {
   3.553789859493311*^9, 3.5537898743050327`*^9}, {3.5537899288979597`*^9, 
   3.5537901775035353`*^9}, {3.553790378650127*^9, 3.5537903794299*^9}, {
   3.553795408319847*^9, 3.553795455742179*^9}, {3.553796153964326*^9, 
   3.553796645314426*^9}, {3.553796682414055*^9, 3.5537967571667747`*^9}, {
   3.553797140464788*^9, 3.553797146497984*^9}, {3.553797191742551*^9, 
   3.553797210008583*^9}, {3.5537974271543283`*^9, 3.553797433758664*^9}, {
   3.553864936481844*^9, 3.5538649577099667`*^9}, 3.5538649885230474`*^9}],

Cell[BoxData[
 RowBox[{
  RowBox[{"canonicalizeUnits", "[", "nfl_", "]"}], ":=", 
  "\[IndentingNewLine]", 
  RowBox[{"Map", "[", 
   RowBox[{
    RowBox[{"Function", "[", 
     RowBox[{"rule", ",", 
      RowBox[{
       RowBox[{"rule", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}],
        "\[Rule]", 
       RowBox[{"Quiet", "[", 
        RowBox[{"N", "@", 
         RowBox[{"Convert", "[", 
          RowBox[{
           RowBox[{
           "rule", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}], 
           ",", "Gram"}], "]"}]}], "]"}]}]}], "]"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"(", 
     RowBox[{"nfl", "/.", 
      RowBox[{"{", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"keyWithVolume_", 
          StyleBox["\[Rule]",
           FontSize->36,
           Background->RGBColor[0.88, 1, 0.88]], "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"amount_", "?", "NumberQ"}], "*", 
           RowBox[{"volume", ":", 
            RowBox[{"(", 
             RowBox[{
             "Teaspoon", "|", "Tablespoon", "|", "Cup", "|", "FluidOunce", 
              "|", "Pint", "|", "Gallon"}], ")"}]}]}]}], ")"}], 
        "\[IndentingNewLine]", "\[IndentingNewLine]", 
        StyleBox["\[RuleDelayed]",
         FontSize->36,
         Background->RGBColor[1, 0.9, 1]], "\[IndentingNewLine]", 
        RowBox[{"keyWithVolume", 
         StyleBox["\[Rule]",
          FontSize->36,
          Background->RGBColor[0.88, 1, 0.88]], 
         RowBox[{
         "amount", "  ", "*", "  ", "volume", "  ", "*", " ", 
          "\[IndentingNewLine]", 
          RowBox[{"gramPerTargetVolumeFromDensity", "[", 
           RowBox[{"volume", ",", 
            RowBox[{"density", "[", 
             RowBox[{"\"\<name\>\"", "/.", "nfl"}], "]"}]}], "]"}]}]}]}], 
       "}"}]}], ")"}]}], "]"}]}]], "Input",
 CellChangeTimes->{{3.544457150162998*^9, 3.5444571864986315`*^9}, {
   3.5444573233863187`*^9, 3.544457342993356*^9}, {3.5444573756243563`*^9, 
   3.544457377911356*^9}, {3.5444574350613565`*^9, 3.5444575019383564`*^9}, {
   3.544457679405922*^9, 3.5444577319081717`*^9}, {3.544457770840064*^9, 
   3.5444578335303326`*^9}, {3.544457976954674*^9, 3.544457980249003*^9}, {
   3.544458101200097*^9, 3.5444581114571223`*^9}, {3.5444582079257684`*^9, 
   3.544458217725748*^9}, {3.544458658448184*^9, 3.544458712658184*^9}, {
   3.544459563646378*^9, 3.5444596802851458`*^9}, {3.544459866302432*^9, 
   3.544459866614463*^9}, {3.5444599772985773`*^9, 3.5444600095325584`*^9}, {
   3.544461134278672*^9, 3.544461140877672*^9}, {3.5444613062386723`*^9, 
   3.5444613249566717`*^9}, {3.544463218225037*^9, 3.5444632475817094`*^9}, 
   3.54446330039272*^9, {3.5445320472870703`*^9, 3.5445320662050705`*^9}, {
   3.5445385411024756`*^9, 3.5445385538774757`*^9}, {3.5445420276093974`*^9, 
   3.5445420372883587`*^9}, {3.5445468949253716`*^9, 
   3.5445468966943717`*^9}, {3.544560869612589*^9, 3.5445608953948517`*^9}, {
   3.5447315003733644`*^9, 3.5447315410993643`*^9}, {3.5448846331777754`*^9, 
   3.5448847078945894`*^9}, {3.5448847746509724`*^9, 
   3.5448848210179725`*^9}, {3.544885035206972*^9, 3.544885069670472*^9}, {
   3.546630302160373*^9, 3.546630308049962*^9}, {3.5466331404363403`*^9, 
   3.5466333455182543`*^9}, {3.553789390894649*^9, 3.553789412128549*^9}}],

Cell["\<\
Make new a new list to contain the canonicalized NFLs (notice this does not \
transform the NFLs in the source lookup table / database; we do that in \
another step below, preferring to operate on lists to take advantage of \
functional-programming techniques). Suppress the output with semicolon, as it \
is lengthy; during development, it is useful to inspect it.\
\>", "Text",
 CellChangeTimes->{{3.5537974514603653`*^9, 3.553797510974886*^9}, {
  3.553797589947756*^9, 3.553797644898404*^9}, {3.553797689329752*^9, 
  3.553797718630374*^9}, {3.553798225875944*^9, 3.553798235434214*^9}, {
  3.553798265924383*^9, 3.5537983012805223`*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"canonicalizedNfls", "=", 
    RowBox[{"Map", "[", 
     RowBox[{"canonicalizeUnits", ",", 
      RowBox[{"Map", "[", 
       RowBox[{
        RowBox[{"Function", "[", 
         RowBox[{"name", ",", 
          RowBox[{"nfls", "[", "name", "]"}]}], "]"}], ",", "nflNames"}], 
       "]"}]}], "]"}]}], ")"}], ";"}]], "Input",
 CellChangeTimes->{{3.5445459966771035`*^9, 3.544546014459882*^9}, {
   3.5445460458620214`*^9, 3.544546048263262*^9}, {3.544546101472582*^9, 
   3.5445461674671807`*^9}, {3.5445462270071344`*^9, 
   3.5445462603524685`*^9}, {3.544549454640689*^9, 3.5445494616163664`*^9}, 
   3.5445605834457245`*^9, 3.5445607747348514`*^9, {3.544731958780018*^9, 
   3.5447319757247124`*^9}, {3.5498994005864253`*^9, 3.549899401693425*^9}, {
   3.553797560768853*^9, 3.553797584367794*^9}, {3.553797649627561*^9, 
   3.553797686595821*^9}}],

Cell["\<\
Inspect one of these to see that any quantity that would be a weight is now \
in Grams.\
\>", "Text",
 CellChangeTimes->{{3.5538649116323595`*^9, 3.5538649295361495`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"First", "[", "canonicalizedNfls", "]"}], "//", 
  "gridRules"}]], "Input",
 CellChangeTimes->{{3.5538648880420003`*^9, 3.5538648990340996`*^9}}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"\<\"name\"\>"}
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
              {"\<\"olive oil\"\>"}
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
              {"\<\"serving size\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"216.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"total calories\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"1910.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"fat calories\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"1910.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"total fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"216.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily total fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"332.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"saturated fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"30.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily saturated fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"149.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"trans fat\"\>"}
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
              {"0.`"}
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
              {"\<\"cholesterol\"\>"}
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
              {"0.`"}
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
              {"\<\"% daily cholesterol\"\>"}
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
              {"0.`"}
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
              {"\<\"sodium\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"0.004`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily sodium\"\>"}
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
              {"0.`"}
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
              {"\<\"total carbohydrates\"\>"}
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
              {"0.`"}
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
              {"\<\"% daily carbohydrates\"\>"}
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
              {"0.`"}
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
              {"\<\"dietary fiber\"\>"}
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
              {"0.`"}
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
              {"\<\"%daily dietary fiber\"\>"}
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
              {"0.`"}
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
              {"\<\"sugars\"\>"}
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
              {"0.`"}
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
              {"\<\"protein\"\>"}
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
              {"0.`"}
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
              {"\<\"% daily protein\"\>"}
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
              {"0.`"}
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
              {"\<\"vitamin A\"\>"}
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
              {"0.`"}
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
              {"\<\"vitamin C\"\>"}
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
              {"0.`"}
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
              {"\<\"calcium\"\>"}
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
              {"0.`"}
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
              {"\<\"iron\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"7.`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
 CellChangeTimes->{3.553864900518248*^9}]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Normalizing the Unit NFLs: All Quantities per Gram\
\>", "Subsection",
 CellChangeTimes->{{3.5538650368458796`*^9, 3.5538650621664114`*^9}}],

Cell[TextData[{
 "Calculate the ",
 StyleBox["norm",
  FontWeight->"Bold",
  FontSlant->"Italic"],
 " of each NFL, that is, its serving size in Grams. Introduce two bits of \
space-saving syntax: ",
 StyleBox["&", "Input"],
 " is a unary postfix operator that denotes its argument (on its left) to be \
a pure function with one argument called ",
 StyleBox["#", "Input"],
 "; ",
 StyleBox["/@", "Input"],
 " is a binary infix operator that maps the function in its left-hand \
argument over the list in its right-hand argument:"
}], "Text",
 CellChangeTimes->{{3.553797756076758*^9, 3.5537979636616087`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"norms", "=", 
  RowBox[{
   RowBox[{"(", 
    RowBox[{
     RowBox[{
      RowBox[{"\"\<serving size\>\"", "/", "Gram"}], "/.", "#"}], "&"}], 
    ")"}], "/@", "canonicalizedNfls"}]}]], "Input",
 CellChangeTimes->{{3.5445462804884815`*^9, 3.54454632347478*^9}, {
  3.544546388694301*^9, 3.544546412815713*^9}, {3.5445469233583717`*^9, 
  3.5445469957703714`*^9}, {3.5445470501043715`*^9, 3.5445470582753716`*^9}, {
  3.54454866527376*^9, 3.5445486666088934`*^9}}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
  "216.`", ",", "124.`", ",", "273.12`", ",", "82.`", ",", "160.`", ",", 
   "186.`", ",", "101.`", ",", "6.299999999999999`", ",", "1.`", ",", "2.`", 
   ",", "128.`", ",", "100.`", ",", "100.`"}], "}"}]], "Output",
 CellChangeTimes->{{3.5445463161320457`*^9, 3.5445463245798903`*^9}, {
   3.5445463911485467`*^9, 3.5445464140488367`*^9}, 3.54454670483527*^9, 
   3.544546857337372*^9, {3.5445469139423714`*^9, 3.5445469258503714`*^9}, {
   3.5445469683193717`*^9, 3.544546996528372*^9}, 3.5445470591783714`*^9, 
   3.5445472275703716`*^9, 3.5445486673379664`*^9, 3.5445494632303667`*^9, 
   3.544560548009181*^9, 3.544560874634082*^9, 3.5447315981963644`*^9, 
   3.544731889608102*^9, 3.544731995344674*^9, 3.544732072882427*^9, 
   3.5447351926616077`*^9, 3.5448784051987085`*^9, 3.544885264763106*^9, 
   3.5466309426029916`*^9, 3.546631134578992*^9, 3.5466312042739916`*^9, 
   3.5474881072634277`*^9, 3.5475546789812355`*^9, 3.548694989693653*^9, 
   3.5486950438030634`*^9, 3.5486951667599583`*^9, 3.549899015938393*^9, 
   3.549904308894861*^9, 3.5499043902881346`*^9, 3.550931368499735*^9, 
   3.550931514497735*^9, 3.550931572969735*^9, 3.550931615091235*^9, 
   3.5535400964977074`*^9, 3.553785132888506*^9, 3.553785195833398*^9, 
   3.553789207868534*^9, 3.5537979816144667`*^9, 3.553864882517448*^9}]
}, Open  ]],

Cell[TextData[{
 "Now a function (pattern and replacement rule) to scale an NFL; with one bit \
of logic to ignore the special ",
 StyleBox["name", "Input"],
 " line in every NFL:"
}], "Text",
 CellChangeTimes->{{3.553797997592153*^9, 3.553798063225881*^9}, {
  3.553798746306313*^9, 3.553798750674226*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"scaleNfl", "[", 
   RowBox[{"nfl_", ",", "scalar_"}], "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"Map", "[", 
   RowBox[{
    RowBox[{"Function", "[", 
     RowBox[{"line", ",", 
      RowBox[{"If", "[", 
       RowBox[{
        RowBox[{
         RowBox[{
         "line", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}], 
         "===", "\"\<name\>\""}], ",", "\[IndentingNewLine]", "line", ",", 
        RowBox[{"(*", " ", 
         RowBox[{"skip", " ", "the", " ", "name", " ", "line"}], " ", "*)"}], 
        "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{
         "line", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}], 
         "\[Rule]", 
         RowBox[{
          RowBox[{
          "line", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}], "*",
           "scalar"}]}]}], "]"}]}], "]"}], ",", "nfl"}], "]"}]}]], "Input",
 CellChangeTimes->{{3.5445495750783663`*^9, 3.544549594410366*^9}, {
   3.5445497551543665`*^9, 3.544549814856366*^9}, 3.5445606578671656`*^9, {
   3.5447316141773643`*^9, 3.5447316202313643`*^9}, 3.544885515465208*^9}],

Cell[TextData[{
 "Now normalize the NFLs by applying ",
 StyleBox["scaleNfl ", "Input"],
 "pairwise over the ",
 StyleBox["canonicalizedNfls", "Input"],
 " and the norms. The following uses ",
 StyleBox["MapThread", "Input"],
 ", which is usually known as ",
 StyleBox["Zip", "Input"],
 " in functional programming:"
}], "Text",
 CellChangeTimes->{{3.5537980848154488`*^9, 3.5537981495771627`*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"normalizedNfls", "=", 
   RowBox[{"MapThread", "[", 
    RowBox[{"scaleNfl", ",", 
     RowBox[{"{", 
      RowBox[{"canonicalizedNfls", ",", 
       RowBox[{"1", "/", "norms"}]}], "}"}]}], "]"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.5445470090193715`*^9, 3.5445470310083714`*^9}, 
   3.5445472458223715`*^9, {3.544548622177451*^9, 3.544548688468079*^9}, {
   3.5445490647527037`*^9, 3.5445490791201406`*^9}, {3.544549127905019*^9, 
   3.544549163452573*^9}, {3.544549203140541*^9, 3.5445493420694327`*^9}, {
   3.5445498221613665`*^9, 3.5445498400063667`*^9}, 3.544560601351515*^9, {
   3.5445606648338623`*^9, 3.544560665769956*^9}, 3.544560766887067*^9}],

Cell["\<\
Now put the normalized NFLs into a new lookup structure, this time in the \
familiar form of a list of rules that map the name in the NFL to the full NFL:\
\>", "Text",
 CellChangeTimes->{{3.5537983111196003`*^9, 3.553798404857971*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"normalizedNflsObj", "=", 
   RowBox[{"Map", "[", 
    RowBox[{
     RowBox[{"Function", "[", 
      RowBox[{"nfl", ",", " ", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"\"\<name\>\"", "/.", "nfl"}], ")"}], "\[Rule]", "nfl"}]}], 
      "]"}], ",", "normalizedNfls"}], "]"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.549900161286873*^9, 3.549900255869609*^9}}],

Cell["\<\
Now a function (pattern and replacement rule) that will match any ingredient \
line in a recipe, look up its corresponding NFL, and scale the NFL by the \
numerical coefficient of the ingredient:\
\>", "Text",
 CellChangeTimes->{{3.553798486312933*^9, 3.553798559256466*^9}, {
  3.5537987606333103`*^9, 3.553798761776744*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Scaling a Unit NFL from an Ingredient\[CloseCurlyQuote]s Coefficient\
\>", "Subsection",
 CellChangeTimes->{{3.5538650814633408`*^9, 3.553865097407935*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"scaledNflFromIngredient", "[", 
   RowBox[{
    RowBox[{"qtty_", "?", "NumberQ"}], " ", "*", " ", "name_String", " ", "*",
     " ", "Gram"}], "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"If", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"(", 
      RowBox[{"name", "/.", "normalizedNflsObj"}], ")"}], "===", "name"}], 
    ",", 
    RowBox[{"(*", " ", 
     RowBox[{"ingredient", " ", 
      RowBox[{"wasn", "'"}], "t", " ", "in", " ", "DB"}], " ", "*)"}], 
    "\[IndentingNewLine]", 
    RowBox[{"{", "}"}], ",", 
    RowBox[{"(*", " ", 
     RowBox[{
     "SelectMany", " ", "will", " ", "flatten", " ", "this", " ", "out"}], 
     " ", "*)"}], "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{"scaleNfl", "[", 
      RowBox[{
       RowBox[{"name", "/.", "normalizedNflsObj"}], ",", "qtty"}], "]"}], 
     "}"}]}], "]"}]}]], "Input",
 CellChangeTimes->{{3.5499025989119186`*^9, 3.5499027299006157`*^9}, {
   3.549902918634075*^9, 3.549902918984082*^9}, {3.5499029689105115`*^9, 
   3.5499029819455986`*^9}, {3.5499030138520885`*^9, 3.549903029239545*^9}, {
   3.5499030886573277`*^9, 3.549903198853896*^9}, {3.549903231537269*^9, 
   3.5499032448225975`*^9}, {3.549903369589917*^9, 3.549903448746191*^9}, {
   3.54990348555826*^9, 3.549903549086542*^9}, 3.55379843792797*^9}],

Cell[TextData[{
 "Apply this function to the recipe using ",
 StyleBox["SelectMany", "Input"],
 ", which will flatten out any empty NFLs returned from ingredients that are \
not in the database. This is only one option for handling that kind of error, \
but it is expressed concisely."
}], "Text",
 CellChangeTimes->{{3.553798564968198*^9, 3.553798664416408*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"(", 
   RowBox[{"scaledNfls", "=", 
    RowBox[{"SelectMany", "[", 
     RowBox[{"recipeInGrams", ",", "scaledNflFromIngredient"}], "]"}]}], 
   ")"}], ";"}]], "Input",
 CellChangeTimes->{{3.5499027739030957`*^9, 3.5499027925157547`*^9}, {
  3.5499029920315523`*^9, 3.5499029985016823`*^9}, {3.5499033041578817`*^9, 
  3.5499033052599926`*^9}, {3.549903348188285*^9, 3.54990334873934*^9}, {
  3.549903463695113*^9, 3.5499035025428085`*^9}, {3.5499041573375506`*^9, 
  3.5499041680356207`*^9}, {3.553798678229871*^9, 3.553798692815089*^9}}],

Cell["\<\
Write a function (pattern and replacement rule) that adds any two NFLs \
pointwise, in the manner of vectors, throwing an exception in case of error:\
\>", "Text",
 CellChangeTimes->{{3.553798726605629*^9, 3.553798736763363*^9}, {
  3.553798769856146*^9, 3.553798845743588*^9}, {3.553798946143341*^9, 
  3.553798958030714*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Final Vector Sum Yields the New NFL\
\>", "Subsection",
 CellChangeTimes->{{3.5538651050076947`*^9, 3.5538651207452683`*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"sumNfls", "[", 
   RowBox[{"nfl1_", ",", "nfl2_"}], "]"}], ":=", "\[IndentingNewLine]", 
  RowBox[{"MapThread", "[", 
   RowBox[{
    RowBox[{"Function", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"line1", ",", "line2"}], "}"}], ",", "\[IndentingNewLine]", 
      RowBox[{"If", "[", 
       RowBox[{
        RowBox[{
         RowBox[{
         "line1", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}], "===", 
         RowBox[{
         "line2", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}]}], 
        ",", 
        RowBox[{"(*", " ", 
         RowBox[{
          RowBox[{"don", "'"}], "t", " ", "add", " ", "up", " ", "dimensions",
           " ", "that", " ", 
          RowBox[{"don", "'"}], "t", " ", "match"}], " ", "*)"}], 
        "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{
          RowBox[{
          "line1", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}], 
          "\[Rule]", 
          RowBox[{"(", 
           RowBox[{
            RowBox[{
            "line1", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}], 
            "+", 
            RowBox[{
            "line2", "\[LeftDoubleBracket]", "2", "\[RightDoubleBracket]"}]}],
            ")"}]}], "//", "Chop"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Throw", "[", "\"\<foo\>\"", "]"}]}], "]"}]}], "]"}], ",", 
    "   ", 
    RowBox[{"{", 
     RowBox[{"nfl1", ",", "nfl2"}], "}"}]}], "]"}]}]], "Input",
 CellChangeTimes->{{3.5445499196553664`*^9, 3.5445499504003663`*^9}, {
  3.544550558212366*^9, 3.5445506481593666`*^9}, {3.544550716653366*^9, 
  3.5445507208903666`*^9}, {3.5445609554798207`*^9, 3.5445609866524663`*^9}, {
  3.544885330920687*^9, 3.5448853344970126`*^9}, {3.5448854940027943`*^9, 
  3.5448855084105587`*^9}, {3.544885734829488*^9, 3.5448857357405787`*^9}}],

Cell[TextData[{
 "Finally, ",
 StyleBox["Fold", "Input"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["21"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/",
            "Fold_"}], 
         RowBox[{"(", 
           RowBox[{"higher", "-", "order_function"}], ")"}]}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00003F1E"],
 "] [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["22"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{
         RowBox[{"http", ":"}], "//", 
         RowBox[{
           RowBox[{
             RowBox[{
               RowBox[{"reference", ".", "wolfram", ".", "com"}], "/", 
               "mathematica"}], "/", "ref"}], "/", 
           RowBox[{"Fold", ".", 
             RowBox[{"html", "?", "q"}]}]}]}], "=", 
       RowBox[{
         RowBox[{
           RowBox[{"Fold", "&"}], "lang"}], "=", "en"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00005794"],
 "] this binary function over the scaled NFLs of the recipe; scale the entire \
result by 1/6 to get one serving; drop the name line via ",
 StyleBox["Rest", "Input"],
 " and display:"
}], "Text",
 CellChangeTimes->{{3.553798850502964*^9, 3.553798927904039*^9}, {
  3.553798963637426*^9, 3.553798973516822*^9}, {3.55379905111768*^9, 
  3.5537991101564074`*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"scaleNfl", "[", 
    RowBox[{
     RowBox[{"Fold", "[", 
      RowBox[{"sumNfls", ",", 
       RowBox[{"First", "[", "scaledNfls", "]"}], ",", 
       RowBox[{"Rest", "[", "scaledNfls", "]"}]}], "]"}], ",", 
     RowBox[{"1", "/", "6"}]}], "]"}], "//", "Rest"}], "//", 
  "gridRules"}]], "Input",
 CellChangeTimes->{{3.5445506545893664`*^9, 3.5445506802043667`*^9}, {
  3.544560720068385*^9, 3.5445607313405123`*^9}, {3.544732118830022*^9, 
  3.544732120550194*^9}, {3.5447361818431854`*^9, 3.544736192548798*^9}, {
  3.553798813158079*^9, 3.55379881468583*^9}}],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         StyleBox[
          StyleBox[
           TagBox[GridBox[{
              {"\<\"serving size\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"368.0191770399304`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"total calories\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"309.7227754282057`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"fat calories\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"58.4133383964233`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Calorie"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"total fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"6.546034824927805`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily total fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"9.89978751878877`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"saturated fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"1.595944872921537`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily saturated fat\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"7.535844268046053`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"trans fat\"\>"}
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
              {"0"}
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
              {"\<\"cholesterol\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"0.04442203385416666`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily cholesterol\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"14.795122395833332`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"sodium\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"1.7696469454839738`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily sodium\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"73.60005705961223`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"total carbohydrates\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"53.54329899723965`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily carbohydrates\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"17.71026658906363`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"dietary fiber\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"6.846302669108374`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"%daily dietary fiber\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"25.730092505835948`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"sugars\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"5.852507655826558`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"protein\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"12.099675916059592`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Gram"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"% daily protein\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"2.76580487804878`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"vitamin A\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"13.434190447951046`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"vitamin C\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"107.62081444028549`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"calcium\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"11.903093730966084`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
              {"\<\"iron\"\>"}
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
               StyleBox[
                TagBox[GridBox[{
                   {"Times"}
                  },
                  AutoDelete->False,
                  GridBoxAlignment->{"Columns" -> {{Left}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                 "Grid"],
                StripOnInput->False,
                FontWeight->Bold],
               StripOnInput->False,
               
               LineColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               FrontFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               BackFaceColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               
               GraphicsColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`],
               FontWeight->Bold,
               
               FontColor->RGBColor[
                0.33333333333333337`, 0, 0.33333333333333337`]], 
              StyleBox[
               TagBox[GridBox[{
                  {"19.675200109592765`"}
                 },
                 AutoDelete->False,
                 GridBoxAlignment->{"Columns" -> {{Left}}},
                 
                 GridBoxItemSize->{
                  "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
                "Grid"],
               StripOnInput->False,
               FontWeight->Bold], 
              StyleBox[
               TagBox[GridBox[{
                  {"Percent"}
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
            FrameStyle->GrayLevel[0],
            GridBoxAlignment->{"Columns" -> {{Left}}},
            GridBoxBackground->{"Columns" -> {
                RGBColor[1, 0.9, 0.8], {
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
 CellChangeTimes->{3.5447321214492836`*^9, 3.5447351928506184`*^9, 
  3.5447361934488497`*^9, 3.5448784053677254`*^9, 3.549904182265015*^9, 
  3.5499043090808797`*^9, 3.5499043904691525`*^9, 3.550931368737735*^9, 
  3.550931514787735*^9, 3.550931573245735*^9, 3.550931615257235*^9, 
  3.5535400967696805`*^9, 3.5537851335276527`*^9, 3.5537851961986322`*^9, 
  3.55378920824925*^9, 3.553798815560775*^9, 3.553864882788475*^9}]
}, Open  ]],

Cell["\<\
Voil\[AGrave] -- a new, synthetic, NFL generated on the fly from an arbitrary \
recipe.\
\>", "Text",
 CellChangeTimes->{{3.5537991273277683`*^9, 3.5537991370846663`*^9}, {
  3.553799334274791*^9, 3.553799360559143*^9}}],

Cell["\<\
It is important to emphasize again that since the expressions that constitute \
the entire computation are just structured data, it is not necessary to \
download the ingredients database to a client. \
\>", "Text",
 CellChangeTimes->{{3.5538644150947104`*^9, 3.5538644530005007`*^9}, {
  3.553867397686852*^9, 3.5538674184789305`*^9}}]
}, Open  ]]
}, Open  ]],

Cell["\<\
SYMBOLIC COMPUTING FOR REASONING\
\>", "Section",
 CellChangeTimes->{{3.5537732220282917`*^9, 3.553773231307466*^9}}],

Cell[CellGroupData[{

Cell["SUMMARY", "Section",
 CellChangeTimes->{{3.543517871083434*^9, 3.5435178730510406`*^9}}],

Cell[CellGroupData[{

Cell["The Essence of Symbolic Computing", "Subsection",
 CellChangeTimes->{{3.5435172737692947`*^9, 3.5435172794368615`*^9}}],

Cell["\<\
Symbolic computing is a general style, methodology, and technology. Any \
program that manipulates symbols as opposed to just manipulating numbers is a \
symbolic program. Symbolic programs are not exotic: we use them every day. \
Parsers, interpreters, compilers, regular-expression libraries; \
stream-editing programs like Perl, Sed, and Awk, macro processors like m4 and \
t4; templating programs, schema validators, redirectors, routers, all do \
symbolic computing. Even the seemingly arcane: constraint solvers or \
reasoning over dependency chains is actually completely mundane: it\
\[CloseCurlyQuote]s embedded in commercial operating-system kernels and \
network-security layers.\
\>", "Text",
 CellChangeTimes->{{3.543500103962249*^9, 3.543500275707422*^9}, {
   3.543500388520702*^9, 3.543500498901739*^9}, {3.5435005468783016`*^9, 
   3.543500618834302*^9}, {3.543516830002923*^9, 3.5435169060815296`*^9}, {
   3.5435173119811153`*^9, 3.5435173237562933`*^9}, {3.543517372398157*^9, 
   3.5435174185527716`*^9}, {3.5435174902759438`*^9, 3.54351773041481*^9}, {
   3.543517801358382*^9, 3.543517841651322*^9}, {3.5435779376838655`*^9, 
   3.5435779465473723`*^9}, {3.553627923091592*^9, 3.553628014371537*^9}, 
   3.553628061571259*^9, {3.553773240940786*^9, 3.553773333539963*^9}, {
   3.5538651332865224`*^9, 3.5538651445586495`*^9}, {3.553865175333727*^9, 
   3.5538652344886417`*^9}, {3.553867201842225*^9, 3.5538673402539015`*^9}}],

Cell["\<\
Though symbolic programs are not exotic, they are specialized; often they are \
tools as opposed to application-layer solutions. You may use them every day, \
but you might not write them every day. One message here is to encourage you \
to use symbolic methods more often in your own programs. Symbolic computing \
for robust units of measure is a no-brainer. There are many other uses: \
greatly reducing the size and complexity of programs via pattern-matching and \
rules processing; reasoning over knowledge; analysis and optimization of \
queries; dynamic scripting; many more.\
\>", "Text",
 CellChangeTimes->{{3.543500103962249*^9, 3.543500275707422*^9}, {
  3.543500388520702*^9, 3.543500498901739*^9}, {3.5435005468783016`*^9, 
  3.543500618834302*^9}, {3.543516830002923*^9, 3.5435169060815296`*^9}, {
  3.5435173119811153`*^9, 3.5435173237562933`*^9}, {3.543517372398157*^9, 
  3.5435174185527716`*^9}, {3.5435174902759438`*^9, 3.54351773041481*^9}, {
  3.543517801358382*^9, 3.543517841651322*^9}, {3.5435779376838655`*^9, 
  3.5435779465473723`*^9}, {3.553627923091592*^9, 3.553628014371537*^9}, {
  3.553628061571259*^9, 3.553628314556294*^9}, {3.553773358551553*^9, 
  3.553773420343198*^9}, {3.5538652421694098`*^9, 3.5538652429684896`*^9}}],

Cell[TextData[{
 "Term-rewriting is a particular method of symbolic computing. It is almost \
universally used in theorem provers, model checkers, and computer algebra \
systems. It has many properties that make it suitable for more general \
computation. In particular, functional programming, object-oriented \
programming, logic programming, and even ordinary imperative programming are \
easy to embed in term-rewriting. This is a point that Wolfram Research makes \
very explicit in their documentation of ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 ", and one of the reasons why we chose to make Jacquard compatible with a \
subset of ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 ". "
}], "Text",
 CellChangeTimes->{{3.543500103962249*^9, 3.543500275707422*^9}, {
  3.543500388520702*^9, 3.543500498901739*^9}, {3.5435005468783016`*^9, 
  3.543500618834302*^9}, {3.543516830002923*^9, 3.5435169060815296`*^9}, {
  3.5435173119811153`*^9, 3.5435173237562933`*^9}, {3.543517372398157*^9, 
  3.5435174185527716`*^9}, {3.5435174902759438`*^9, 3.54351773041481*^9}, {
  3.543517801358382*^9, 3.543517846948262*^9}, {3.543577971587805*^9, 
  3.5435779727718725`*^9}, {3.553628331474745*^9, 3.5536283674750767`*^9}}],

Cell[TextData[{
 "The essence of symbolic computing is treating expressions as independent, \
standalone objects, available at run time for manipulation and application. \
In ordinary programming languages like C# and JavaScript, the only way to \
manipulate expressions at run time is via ",
 ButtonBox["reflection",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikipedia.org/wiki/Reflection_(computer_programming)"], 
    None},
  ButtonNote->
   "http://en.wikipedia.org/wiki/Reflection_(computer_programming)"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["23"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{
             RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/",
            "Reflection_"}], 
         RowBox[{"(", "computer_programming", ")"}]}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00003C5F"],
 "] or ",
 ButtonBox["metacircular evaluation",
  BaseStyle->"Hyperlink",
  ButtonData->{
    URL["http://en.wikipedia.org/wiki/Metacircular_Interpreter"], None},
  ButtonNote->"http://en.wikipedia.org/wiki/Metacircular_Interpreter"],
 " [",
 ButtonBox[Cell[TextData[StyleBox[ButtonBox["24"],
  FontVariations->{"CompatibilityType"->"Superscript"}]], "Citation",
  Editable->False,
  TaggingRules->{NoteData -> RowBox[{
       RowBox[{"http", ":"}], "//", 
       RowBox[{
         RowBox[{
           RowBox[{"en", ".", "wikipedia", ".", "org"}], "/", "wiki"}], "/", 
         "Metacircular_Interpreter"}]}]}],
  BaseStyle->"Hyperlink",
  ButtonData->"00002F30"],
 "]. These techniques make code generation available at run time, but it is \
often so much work that it\[CloseCurlyQuote]s not worth it; your programs \
become miniature compilers or interpreters. Programmers often work around the \
lack by just writing more application code. "
}], "Text",
 CellChangeTimes->{{3.543500103962249*^9, 3.543500275707422*^9}, {
  3.543500388520702*^9, 3.543500498901739*^9}, {3.5435005468783016`*^9, 
  3.543500618834302*^9}, {3.543516830002923*^9, 3.5435169060815296`*^9}, {
  3.5435173119811153`*^9, 3.5435173237562933`*^9}, {3.543517372398157*^9, 
  3.5435174185527716`*^9}, {3.543517479931909*^9, 3.5435174841553316`*^9}, {
  3.5435177522512054`*^9, 3.543517780020651*^9}, {3.543527459638015*^9, 
  3.543527460459015*^9}, {3.543578005845764*^9, 3.5435781550682993`*^9}, {
  3.553773551747957*^9, 3.5537735739561768`*^9}, {3.553773609819214*^9, 
  3.553773611295331*^9}, {3.553783668133897*^9, 3.553783675234722*^9}, {
  3.553783869452057*^9, 3.553783869583436*^9}, {3.553799067073526*^9, 
  3.553799067204713*^9}, {3.553799110192648*^9, 3.5537991103253*^9}}],

Cell[TextData[{
 "Term-rewriting systems like Jacquard take an entirely different approach \
and treat expressions on exactly the same footing as other data. The tools \
for manipulating data transparently manipulate expressions, ",
 StyleBox["i",
  FontSlant->"Italic"],
 ".",
 StyleBox["e",
  FontSlant->"Italic"],
 "., programs. The fundamental unity of code and data is nothing new, it\
\[CloseCurlyQuote]s just not in the daily vocabulary of the ordinary, \
workaday programmer stuck in a world where programs are always compiled in \
isolated sessions and executed in other sessions and environments. The gap \
between analyzing a program and executing a program is unbridgeable. \
Term-rewriting build the bridge."
}], "Text",
 CellChangeTimes->{{3.543500103962249*^9, 3.543500275707422*^9}, {
  3.543500388520702*^9, 3.543500498901739*^9}, {3.5435005468783016`*^9, 
  3.543500618834302*^9}, {3.543516830002923*^9, 3.5435169060815296`*^9}, {
  3.5435173119811153`*^9, 3.5435173237562933`*^9}, {3.543517372398157*^9, 
  3.543517405271444*^9}, {3.553628399865836*^9, 3.553628472048452*^9}, {
  3.553637235149007*^9, 3.5536374334071712`*^9}, {3.553773645489991*^9, 
  3.5537736725613194`*^9}, {3.553773703287594*^9, 3.5537737271360064`*^9}}]
}, Open  ]],

Cell[CellGroupData[{

Cell["Advantages of Symbolic Computing", "Subsection",
 CellChangeTimes->{{3.5435169256234837`*^9, 3.543516933116233*^9}, 
   3.5435172927381916`*^9}],

Cell[TextData[{
 "Advantage number 1 is in coding applications as transformations of \
expressions. With term-rewriting in particular, ",
 StyleBox["calculating an answer",
  FontSlant->"Italic"],
 " means ",
 StyleBox["rewriting expressions",
  FontSlant->"Italic"],
 ". This separates expressions that represent computations from the \
expressions that represent data objects. That's the same desideratum that \
gives rise to the \[OpenCurlyDoubleQuote]with\[CloseCurlyDoubleQuote] \
statement of JavaScript. However, the ambiguity introduced via \"with\" \
outweighs the advantage of separation of concerns in that case. Jacquard's \
solution is to invert the code: treat expressions as first-class; treat data \
as rewrite rules. This inversion allows developers to manipulate expressions \
and objects-as-rules independently. This technique is illustrated in a very \
concise application for converting arbitrary recipes into Nutrition Fact \
Labels."
}], "Text",
 CellChangeTimes->{{3.5434898488243847`*^9, 3.5434899672155275`*^9}, {
   3.543490222051527*^9, 3.543490309919527*^9}, 3.5434903503475275`*^9, {
   3.5434906679325275`*^9, 3.543490693315527*^9}, {3.5434910583893485`*^9, 
   3.543491062102091*^9}, {3.543491112173103*^9, 3.5434911665989857`*^9}, {
   3.5434939569427156`*^9, 3.5434939855167155`*^9}, {3.5434940221477156`*^9, 
   3.543494107223716*^9}, {3.5434959013257155`*^9, 3.5434960384547157`*^9}, {
   3.5434962841867156`*^9, 3.5434963235607157`*^9}, {3.5434966871561537`*^9, 
   3.5434967259097757`*^9}, {3.5435006326923018`*^9, 
   3.5435006594963017`*^9}, {3.5435007234633017`*^9, 
   3.5435007858973017`*^9}, {3.5435008279798436`*^9, 3.543500830474093*^9}, {
   3.5435169640733285`*^9, 3.5435170296368837`*^9}, {3.543527524089015*^9, 
   3.543527530712015*^9}, {3.5435782147777143`*^9, 3.543578290793062*^9}, {
   3.553628536742715*^9, 3.5536285391750927`*^9}, {3.553637462128427*^9, 
   3.553637663970305*^9}, {3.5537737633832197`*^9, 3.553773770631858*^9}, {
   3.5537738138289347`*^9, 3.553773877205545*^9}, {3.553799813662781*^9, 
   3.553799885982924*^9}}],

Cell["\<\
The sophisticated JavaScript programmer packages expressions in functions and \
gains some independence from data access that way, but Jacquard removes \
unnecessary intermediary functions and gives direct access to expressions. \
That opens up scenarios like partial evaluation not available without \
symbolic computing.\
\>", "Text",
 CellChangeTimes->{{3.5434898488243847`*^9, 3.5434899672155275`*^9}, {
   3.543490222051527*^9, 3.543490309919527*^9}, 3.5434903503475275`*^9, {
   3.5434906679325275`*^9, 3.543490693315527*^9}, {3.5434910583893485`*^9, 
   3.543491062102091*^9}, {3.543491112173103*^9, 3.5434911665989857`*^9}, {
   3.5434939569427156`*^9, 3.5434939855167155`*^9}, {3.5434940221477156`*^9, 
   3.543494107223716*^9}, {3.5434959013257155`*^9, 3.5434962325567155`*^9}, {
   3.5434967767470226`*^9, 3.5434968268560505`*^9}, {3.5434968712814865`*^9, 
   3.5434970803052835`*^9}, 3.5434971556623516`*^9, {3.543527596110015*^9, 
   3.5435276258360147`*^9}, {3.5435784085657983`*^9, 3.543578415645203*^9}}],

Cell["\<\
Advantage number 2 is in symbolic arithmetic, for instance, to track units of \
measure, but also to rearrange expressions for optimality, simplicity, or \
other concerns and remote them for data affinity or privacy. Our sample \
application includes information in grams, milligrams, ounces, calories, and \
percentages. It is much too easy to make a mistake like adding milligrams to \
grams, or multiplying by percentages instead of by fractions. With ordinary \
JavaScript, the developer can only track units of measure mentally while \
writing the code or externally on paper or in comments. A sophisticated \
JavaScript programmer might record units of measure in strings and use string \
matching to detect errors. This is half way to symbolic computing, but \
includes no ability to do arithmetic.\
\>", "Text",
 CellChangeTimes->{{3.5434898488243847`*^9, 3.5434899672155275`*^9}, {
  3.543490222051527*^9, 3.543490309919527*^9}, {3.5434903503475275`*^9, 
  3.543490643197527*^9}, {3.5434911810498753`*^9, 3.543491281889882*^9}, {
  3.5434941236867156`*^9, 3.543494127405716*^9}, {3.54349665986897*^9, 
  3.543496660213073*^9}, {3.5435008365176973`*^9, 3.5435008406671124`*^9}, {
  3.543527640747015*^9, 3.543527678337015*^9}, {3.5435784319841375`*^9, 
  3.5435784764576817`*^9}, {3.553637705945009*^9, 3.553637746056694*^9}, {
  3.553773928716004*^9, 3.553773966882104*^9}}],

Cell["\<\
Jacquard's symbolic arithmetic can perform routine conversions automatically \
and brings mistakes to the surface where they are easy to correct without \
backtracking through external mental or paper processes.\
\>", "Text",
 CellChangeTimes->{{3.5434898488243847`*^9, 3.5434899672155275`*^9}, {
  3.543490222051527*^9, 3.543490309919527*^9}, {3.5434903503475275`*^9, 
  3.543490643197527*^9}, {3.5434911810498753`*^9, 3.5434912535280466`*^9}, {
  3.543496642849866*^9, 3.543496649954996*^9}, {3.5435008675488*^9, 
  3.543500871869232*^9}, {3.5435784931566367`*^9, 3.543578510283616*^9}}],

Cell["\<\
Advantage number 3 is in deep integration with reasoning over knowledge, as \
illustrated in the example of network configuration in an operating system.\
\>", "Text",
 CellChangeTimes->{{3.553799902980401*^9, 3.553799949288302*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"<<", "\"\<Jacquard`\>\""}], ";", 
  RowBox[{"<<", "\"\<Units`\>\""}], ";"}]], "Input",
 CellOpen->False,
 InitializationCell->True,
 CellChangeTimes->{{3.543348208721599*^9, 3.5433482150572324`*^9}, {
  3.5537851706052856`*^9, 3.553785177556411*^9}}],

Cell[TextData[{
 "\t",
 StyleBox["1",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "www",
 ".",
 "wolfram",
 ".",
 "com",
 "/",
 "mathematica",
 "/"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00002765"],

Cell[TextData[{
 "\t",
 StyleBox["2",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Integrated_development",
 "_environment"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"0000381F"],

Cell[TextData[{
 "\t",
 StyleBox["3",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "physics",
 ".",
 "nist",
 ".",
 "gov",
 "/",
 "Pubs",
 "/",
 "SP811",
 "/",
 "appenB",
 ".",
 "html"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00003589"],

Cell[TextData[{
 "\t",
 StyleBox["4",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "www",
 ".",
 "fda",
 ".",
 "gov",
 "/",
 "Food",
 "/",
 "ResourcesForYou",
 "/",
 "Consumers",
 "/",
 "NFLPM",
 "/",
 "ucm274593",
 ".",
 "htm"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"000047E5"],

Cell[TextData[{
 "\t",
 StyleBox["5",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "rewriting",
 ".",
 "loria",
 ".",
 "fr",
 "/"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00001EB5"],

Cell[TextData[{
 "\t",
 StyleBox["6",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "www",
 ".",
 "redditmirror",
 ".",
 "cc",
 "/",
 "cache",
 "/",
 "websites",
 "/",
 "web",
 ".",
 "archive",
 ".",
 "org_",
 "84624",
 "/",
 "web",
 ".",
 "archive",
 ".",
 "org",
 "/",
 "web",
 "/",
 "20040603192757",
 "/",
 "research",
 ".",
 "microsoft",
 ".",
 "com",
 "/",
 "research",
 "/",
 "dtg",
 "/",
 "davidhov",
 "/",
 "pap",
 ".",
 "htm"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00009BEE"],

Cell[TextData[{
 "\t",
 StyleBox["7",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "secpal",
 ".",
 "codeplex",
 ".",
 "com",
 "/"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00001EF6"],

Cell[TextData[{
 "\t",
 StyleBox["8",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "stackoverflow",
 ".",
 "com",
 "/",
 "questions",
 "/",
 "4968406",
 "/",
 "javascript",
 "-",
 "property",
 "-",
 "access",
 "-",
 "dot",
 "-",
 "notation",
 "-",
 "vs",
 "-",
 "brackets"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00004D0E"],

Cell[TextData[{
 "\t",
 StyleBox["9",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Don",
 "%27",
 "t_repeat",
 "_yourself"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"000033FD"],

Cell[TextData[{
 "\t",
 StyleBox["10",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "c2",
 ".",
 "com",
 "/",
 "cgi",
 "/",
 "wiki",
 "?",
 "DontRepeatYourself"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00002E07"],

Cell[TextData[{
 "\t",
 StyleBox["11",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Programming_style",
 "#",
 "Vertical_alignment"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00003920"],

Cell[TextData[{
 "\t",
 StyleBox["12",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "CamelCase"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"000028BF"],

Cell[TextData[{
 "\t",
 StyleBox["13",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "yuiblog",
 ".",
 "com",
 "/",
 "blog",
 "/",
 "2006",
 "/",
 "04",
 "/",
 "11",
 "/",
 "with",
 "-",
 "statement",
 "-",
 "considered",
 "-",
 "harmful",
 "/"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00004D81"],

Cell[TextData[{
 "\t",
 StyleBox["14",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Normal_form",
 "_",
 "(",
 "abstract_rewriting",
 ")"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00003C7D"],

Cell[TextData[{
 "\t",
 StyleBox["15",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Domain",
 "-",
 "specific_language"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00003400"],

Cell[TextData[{
 "\t",
 StyleBox["16",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Mars_Climate",
 "_Orbiter"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"000031E9"],

Cell[TextData[{
 "\t",
 StyleBox["17",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "www",
 ".",
 "codinghorror",
 ".",
 "com",
 "/",
 "blog",
 "/",
 "2007",
 "/",
 "05",
 "/",
 "the",
 "-",
 "best",
 "-",
 "code",
 "-",
 "is",
 "-",
 "no",
 "-",
 "code",
 "-",
 "at",
 "-",
 "all",
 ".",
 "html"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"0000514D"],

Cell[TextData[{
 "\t",
 StyleBox["18",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "answers",
 ".",
 "yahoo",
 ".",
 "com",
 "/",
 "question",
 "/",
 "index",
 "?",
 "qid",
 "=",
 "20060927203122",
 "AAv1MpR"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00003F86"],

Cell[TextData[{
 "\t",
 StyleBox["19",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikibooks",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Haskell",
 "/",
 "Understanding_monads"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"000035D7"],

Cell[TextData[{
 "\t",
 StyleBox["20",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "community",
 ".",
 "bartdesmet",
 ".",
 "net",
 "/",
 "blogs",
 "/",
 "bart",
 "/",
 "Default",
 ".",
 "aspx",
 "?",
 "PageIndex",
 "=",
 "2"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"000048B7"],

Cell[TextData[{
 "\t",
 StyleBox["21",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Fold_",
 "(",
 "higher",
 "-",
 "order_function",
 ")"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00003F1E"],

Cell[TextData[{
 "\t",
 StyleBox["22",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "reference",
 ".",
 "wolfram",
 ".",
 "com",
 "/",
 "mathematica",
 "/",
 "ref",
 "/",
 "Fold",
 ".",
 "html",
 "?",
 "q",
 "=",
 "Fold",
 "&",
 "lang",
 "=",
 "en"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00005794"],

Cell[TextData[{
 "\t",
 StyleBox["23",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Reflection_",
 "(",
 "computer_programming",
 ")"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00003C5F"],

Cell[TextData[{
 "\t",
 StyleBox["24",
  FontVariations->{"CompatibilityType"->"Superscript"}],
 "\t",
 "http",
 ":",
 "//",
 "en",
 ".",
 "wikipedia",
 ".",
 "org",
 "/",
 "wiki",
 "/",
 "Metacircular_Interpreter"
}], "Reference",
 Editable->False,
 TaggingRules->{ReferenceNoteData -> ""},
 CellTags->"00002F30"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
},
AutoGeneratedPackage->None,
WindowSize->{1262, 1436},
WindowMargins->{{0, Automatic}, {-1, Automatic}},
PrintingCopies->1,
PrintingPageRange->{Automatic, Automatic},
PrintingOptions->{"Magnification"->1.,
"PaperOrientation"->"Portrait",
"PaperSize"->{612, 792}},
Magnification:>FEPrivate`If[
  FEPrivate`Equal[FEPrivate`$VersionNumber, 6.], 1.5, 1.5 Inherited],
FrontEndVersion->"8.0 for Microsoft Windows (64-bit) (October 6, 2011)",
StyleDefinitions->FrontEnd`FileName[{"Creative"}, "NaturalColor.nb", 
  CharacterEncoding -> "WindowsANSI"]
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{
 "00001EB5"->{
  Cell[763874, 18697, 271, 17, 36, "Reference",
   CellTags->"00001EB5"]},
 "00001EF6"->{
  Cell[764727, 18771, 272, 17, 36, "Reference",
   CellTags->"00001EF6"]},
 "00002E07"->{
  Cell[765749, 18849, 302, 20, 36, "Reference",
   CellTags->"00002E07"]},
 "00002F30"->{
  Cell[770650, 19232, 314, 20, 36, "Reference",
   CellTags->"00002F30"]},
 "00002765"->{
  Cell[762549, 18597, 290, 19, 36, "Reference",
   CellTags->"00002765"]},
 "000028BF"->{
  Cell[766393, 18895, 299, 20, 36, "Reference",
   CellTags->"000028BF"]},
 "00003C5F"->{
  Cell[770309, 19207, 338, 23, 36, "Reference",
   CellTags->"00003C5F"]},
 "00003C7D"->{
  Cell[767083, 18950, 342, 24, 36, "Reference",
   CellTags->"00003C7D"]},
 "00003F1E"->{
  Cell[769570, 19146, 343, 25, 36, "Reference",
   CellTags->"00003F1E"]},
 "00003F86"->{
  Cell[768514, 19065, 351, 25, 36, "Reference",
   CellTags->"00003F86"]},
 "000031E9"->{
  Cell[767755, 19000, 315, 21, 36, "Reference",
   CellTags->"000031E9"]},
 "000033FD"->{
  Cell[765419, 18824, 327, 23, 36, "Reference",
   CellTags->"000033FD"]},
 "00003400"->{
  Cell[767428, 18976, 324, 22, 36, "Reference",
   CellTags->"00003400"]},
 "000035D7"->{
  Cell[768868, 19092, 328, 22, 36, "Reference",
   CellTags->"000035D7"]},
 "00003589"->{
  Cell[763173, 18641, 326, 24, 36, "Reference",
   CellTags->"00003589"]},
 "0000381F"->{
  Cell[762842, 18618, 328, 21, 36, "Reference",
   CellTags->"0000381F"]},
 "00003920"->{
  Cell[766054, 18871, 336, 22, 36, "Reference",
   CellTags->"00003920"]},
 "00004D0E"->{
  Cell[765002, 18790, 414, 32, 36, "Reference",
   CellTags->"00004D0E"]},
 "00004D81"->{
  Cell[766695, 18917, 385, 31, 36, "Reference",
   CellTags->"00004D81"]},
 "000047E5"->{
  Cell[763502, 18667, 369, 28, 36, "Reference",
   CellTags->"000047E5"]},
 "000048B7"->{
  Cell[769199, 19116, 368, 28, 36, "Reference",
   CellTags->"000048B7"]},
 "0000514D"->{
  Cell[768073, 19023, 438, 40, 36, "Reference",
   CellTags->"0000514D"]},
 "00005794"->{
  Cell[769916, 19173, 390, 32, 36, "Reference",
   CellTags->"00005794"]},
 "00009BEE"->{
  Cell[764148, 18716, 576, 53, 53, "Reference",
   CellTags->"00009BEE"]}
 }
*)
(*CellTagsIndex
CellTagsIndex->{
 {"00001EB5", 771661, 19276},
 {"00001EF6", 771751, 19279},
 {"00002E07", 771841, 19282},
 {"00002F30", 771931, 19285},
 {"00002765", 772021, 19288},
 {"000028BF", 772111, 19291},
 {"00003C5F", 772201, 19294},
 {"00003C7D", 772291, 19297},
 {"00003F1E", 772381, 19300},
 {"00003F86", 772471, 19303},
 {"000031E9", 772561, 19306},
 {"000033FD", 772651, 19309},
 {"00003400", 772741, 19312},
 {"000035D7", 772831, 19315},
 {"00003589", 772921, 19318},
 {"0000381F", 773011, 19321},
 {"00003920", 773101, 19324},
 {"00004D0E", 773191, 19327},
 {"00004D81", 773281, 19330},
 {"000047E5", 773371, 19333},
 {"000048B7", 773461, 19336},
 {"0000514D", 773551, 19339},
 {"00005794", 773641, 19342},
 {"00009BEE", 773731, 19345}
 }
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1257, 32, 267, 5, 98, "Title"],
Cell[1527, 39, 155, 4, 98, "Title"],
Cell[1685, 45, 248, 6, 60, "Subtitle"],
Cell[CellGroupData[{
Cell[1958, 55, 212, 3, 113, "Section"],
Cell[2173, 60, 4933, 110, 158, "Text"],
Cell[7109, 172, 5470, 110, 231, "Text"],
Cell[12582, 284, 4187, 85, 131, "Text"],
Cell[16772, 371, 1033, 15, 68, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[17842, 391, 210, 3, 113, "Section"],
Cell[18055, 396, 938, 14, 68, "Text"],
Cell[18996, 412, 589, 9, 42, "Text"],
Cell[CellGroupData[{
Cell[19610, 425, 405, 7, 42, "Item"],
Cell[20018, 434, 341, 6, 42, "Item"]
}, Open  ]],
Cell[20374, 443, 595, 10, 68, "Text"],
Cell[20972, 455, 17179, 287, 629, "Text"],
Cell[38154, 744, 568, 9, 68, "Text"],
Cell[38725, 755, 721, 17, 315, "Program"],
Cell[39449, 774, 1869, 43, 105, "Text"],
Cell[41321, 819, 1024, 15, 93, "Text"],
Cell[42348, 836, 923, 14, 68, "Text"],
Cell[43274, 852, 478, 12, 208, "Program"],
Cell[43755, 866, 377, 7, 68, "Text"],
Cell[CellGroupData[{
Cell[44157, 877, 121, 1, 54, "Subsection"],
Cell[44281, 880, 304, 6, 42, "Text"],
Cell[CellGroupData[{
Cell[44610, 890, 122, 1, 39, "Subsubsection"],
Cell[44735, 893, 2898, 71, 168, "Text"],
Cell[47636, 966, 444, 9, 122, "Program"],
Cell[48083, 977, 516, 11, 69, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[48636, 993, 127, 1, 39, "Subsubsection"],
Cell[48766, 996, 402, 7, 68, "Text"],
Cell[49171, 1005, 379, 7, 79, "Program"],
Cell[49553, 1014, 96, 1, 42, "Text"],
Cell[49652, 1017, 328, 6, 79, "Program"],
Cell[49983, 1025, 271, 5, 42, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[50291, 1035, 220, 3, 39, "Subsubsection"],
Cell[50514, 1040, 1568, 32, 54, "Text"],
Cell[52085, 1074, 967, 26, 509, "Program"],
Cell[53055, 1102, 182, 2, 42, "Text"],
Cell[53240, 1106, 1148, 16, 144, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[54425, 1127, 132, 1, 39, "Subsubsection"],
Cell[54560, 1130, 290, 6, 42, "Text"],
Cell[54853, 1138, 286, 7, 122, "Program"],
Cell[55142, 1147, 240, 4, 42, "Text"],
Cell[55385, 1153, 301, 9, 186, "Program"],
Cell[55689, 1164, 109, 1, 42, "Text"],
Cell[55801, 1167, 934, 19, 122, "Text"],
Cell[56738, 1188, 2042, 45, 81, "Text"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[58829, 1239, 169, 2, 54, "Subsection"],
Cell[59001, 1243, 885, 13, 93, "Text"],
Cell[59889, 1258, 679, 11, 93, "Text"],
Cell[60571, 1271, 1928, 40, 106, "Text"],
Cell[CellGroupData[{
Cell[62524, 1315, 134, 1, 39, "Subsubsection"],
Cell[62661, 1318, 802, 12, 93, "Text"],
Cell[63466, 1332, 399, 7, 68, "Text"],
Cell[63868, 1341, 3105, 60, 207, "Text"],
Cell[66976, 1403, 942, 17, 103, "Text"],
Cell[67921, 1422, 1085, 18, 103, "Text"],
Cell[69009, 1442, 548, 9, 102, "Text"],
Cell[69560, 1453, 428, 9, 103, "Text"],
Cell[CellGroupData[{
Cell[70013, 1466, 1537, 32, 534, "Input"],
Cell[71553, 1500, 33482, 952, 669, "Output"]
}, Open  ]],
Cell[105050, 2455, 846, 15, 141, "Text"],
Cell[CellGroupData[{
Cell[105921, 2474, 180, 3, 87, "Input"],
Cell[106104, 2479, 484, 8, 85, "Output"]
}, Open  ]],
Cell[106603, 2490, 241, 6, 64, "Text"],
Cell[CellGroupData[{
Cell[106869, 2500, 264, 6, 87, "Input"],
Cell[107136, 2508, 428, 7, 85, "Output"]
}, Open  ]],
Cell[107579, 2518, 1989, 40, 159, "Text"],
Cell[CellGroupData[{
Cell[109593, 2562, 141, 2, 33, "Subitem"],
Cell[109737, 2566, 884, 17, 87, "SubitemParagraph"],
Cell[110624, 2585, 96, 1, 33, "Subitem"]
}, Open  ]],
Cell[110735, 2589, 377, 7, 63, "Text"],
Cell[CellGroupData[{
Cell[111137, 2600, 226, 5, 87, "Input"],
Cell[111366, 2607, 428, 7, 85, "Output"]
}, Open  ]],
Cell[111809, 2617, 892, 17, 142, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[112738, 2639, 137, 1, 58, "Subsubsection"],
Cell[112878, 2642, 121, 1, 63, "Text"],
Cell[CellGroupData[{
Cell[113024, 2647, 112, 2, 87, "Input"],
Cell[113139, 2651, 487, 8, 85, "Output"]
}, Open  ]],
Cell[113641, 2662, 249, 5, 63, "Text"],
Cell[CellGroupData[{
Cell[113915, 2671, 158, 4, 87, "Input"],
Cell[114076, 2677, 426, 7, 85, "Output"]
}, Open  ]],
Cell[114517, 2687, 482, 10, 103, "Text"],
Cell[115002, 2699, 17379, 289, 948, "Text"],
Cell[CellGroupData[{
Cell[132406, 2992, 1437, 30, 534, "Input"],
Cell[133846, 3024, 33448, 951, 666, "Output"]
}, Open  ]],
Cell[167309, 3978, 121, 1, 63, "Text"],
Cell[CellGroupData[{
Cell[167455, 3983, 224, 5, 87, "Input"],
Cell[167682, 3990, 432, 7, 85, "Output"]
}, Open  ]],
Cell[168129, 4000, 2603, 54, 235, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[170769, 4059, 113, 1, 58, "Subsubsection"],
Cell[170885, 4062, 202, 4, 63, "Text"],
Cell[CellGroupData[{
Cell[171112, 4070, 214, 5, 87, "Input"],
Cell[171329, 4077, 490, 8, 85, "Output"]
}, Open  ]],
Cell[171834, 4088, 587, 11, 103, "Text"],
Cell[CellGroupData[{
Cell[172446, 4103, 150, 2, 87, "Input"],
Cell[172599, 4107, 497, 7, 85, "Output"]
}, Open  ]],
Cell[173111, 4117, 215, 3, 63, "Text"],
Cell[CellGroupData[{
Cell[173351, 4124, 198, 4, 87, "Input"],
Cell[173552, 4130, 502, 9, 85, "Output"]
}, Open  ]],
Cell[174069, 4142, 882, 14, 102, "Text"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[175000, 4162, 119, 1, 81, "Subsection"],
Cell[175122, 4165, 752, 11, 139, "Text"],
Cell[175877, 4178, 1054, 17, 180, "Text"],
Cell[176934, 4197, 657, 10, 102, "Text"],
Cell[CellGroupData[{
Cell[177616, 4211, 178, 2, 58, "Subsubsection"],
Cell[177797, 4215, 303, 6, 63, "Text"],
Cell[CellGroupData[{
Cell[178125, 4225, 302, 7, 169, "Input"],
Cell[178430, 4234, 513, 10, 85, "Output"]
}, Open  ]],
Cell[178958, 4247, 162, 3, 63, "Text"],
Cell[CellGroupData[{
Cell[179145, 4254, 340, 7, 169, "Input"],
Cell[179488, 4263, 438, 7, 85, "Output"]
}, Open  ]],
Cell[179941, 4273, 118, 1, 63, "Text"],
Cell[180062, 4276, 954, 18, 141, "Text"],
Cell[181019, 4296, 1063, 22, 144, "Text"],
Cell[CellGroupData[{
Cell[182107, 4322, 318, 6, 169, "Input"],
Cell[182428, 4330, 487, 8, 85, "Output"]
}, Open  ]],
Cell[182930, 4341, 399, 11, 64, "Text"],
Cell[CellGroupData[{
Cell[183354, 4356, 341, 7, 169, "Input"],
Cell[183698, 4365, 463, 7, 85, "Output"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[184222, 4379, 205, 3, 81, "Subsection"],
Cell[184430, 4384, 437, 7, 102, "Text"],
Cell[184870, 4393, 645, 10, 102, "Text"],
Cell[185518, 4405, 40995, 677, 613, "Text"],
Cell[226516, 5084, 194, 6, 64, "Text"],
Cell[CellGroupData[{
Cell[226735, 5094, 435, 10, 210, "Input"],
Cell[227173, 5106, 566, 11, 85, "Output"]
}, Open  ]],
Cell[227754, 5120, 112, 1, 63, "Text"],
Cell[CellGroupData[{
Cell[227891, 5125, 478, 9, 210, "Input"],
Cell[228372, 5136, 521, 8, 85, "Output"]
}, Open  ]],
Cell[228908, 5147, 561, 9, 102, "Text"],
Cell[229472, 5158, 888, 14, 180, "Text"],
Cell[230363, 5174, 644, 10, 102, "Text"],
Cell[231010, 5186, 195, 2, 42, "Text"],
Cell[231208, 5190, 99098, 1630, 912, "Text"],
Cell[330309, 6822, 702, 11, 93, "Text"],
Cell[331014, 6835, 691, 13, 69, "Text"],
Cell[CellGroupData[{
Cell[331730, 6852, 520, 13, 140, "Input"],
Cell[332253, 6867, 482, 7, 57, "Output"]
}, Open  ]],
Cell[332750, 6877, 413, 9, 43, "Text"],
Cell[333166, 6888, 1477, 33, 80, "Text"],
Cell[334646, 6923, 1006, 31, 113, "Input"],
Cell[335655, 6956, 102, 1, 42, "Text"],
Cell[CellGroupData[{
Cell[335782, 6961, 524, 14, 113, "Input"],
Cell[336309, 6977, 517, 8, 57, "Output"]
}, Open  ]],
Cell[336841, 6988, 622, 14, 70, "Text"],
Cell[337466, 7004, 600, 11, 70, "Text"],
Cell[338069, 7017, 457, 8, 93, "Text"],
Cell[338529, 7027, 623, 13, 70, "Text"],
Cell[CellGroupData[{
Cell[339177, 7044, 665, 16, 140, "Input"],
Cell[339845, 7062, 526, 9, 57, "Output"]
}, Open  ]],
Cell[340386, 7074, 276, 5, 42, "Text"],
Cell[CellGroupData[{
Cell[340687, 7083, 296, 4, 58, "Input"],
Cell[340986, 7089, 744, 15, 78, "Output"]
}, Open  ]],
Cell[341745, 7107, 238, 5, 63, "Text"],
Cell[341986, 7114, 580, 15, 210, "Input"],
Cell[CellGroupData[{
Cell[342591, 7133, 403, 8, 87, "Input"],
Cell[342997, 7143, 556, 8, 85, "Output"]
}, Open  ]],
Cell[343568, 7154, 310, 6, 63, "Text"],
Cell[343881, 7162, 289, 5, 102, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[344207, 7172, 154, 2, 81, "Subsection"],
Cell[344364, 7176, 320, 6, 63, "Text"],
Cell[CellGroupData[{
Cell[344709, 7186, 1608, 31, 534, "Input"],
Cell[346320, 7219, 33600, 952, 669, "Output"]
}, Open  ]],
Cell[379935, 8174, 119, 1, 63, "Text"],
Cell[CellGroupData[{
Cell[380079, 8179, 316, 7, 87, "Input"],
Cell[380398, 8188, 450, 7, 85, "Output"]
}, Open  ]],
Cell[380863, 8198, 400, 9, 105, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[381300, 8212, 111, 1, 81, "Subsection"],
Cell[381414, 8215, 311, 6, 63, "Text"],
Cell[CellGroupData[{
Cell[381750, 8225, 106, 1, 39, "Subsubsection"],
Cell[381859, 8228, 754, 11, 119, "Text"],
Cell[382616, 8241, 759, 17, 315, "Program"]
}, Open  ]],
Cell[CellGroupData[{
Cell[383412, 8263, 102, 1, 39, "Subsubsection"],
Cell[383517, 8266, 742, 14, 94, "Text"],
Cell[384262, 8282, 342, 6, 57, "Program"],
Cell[384607, 8290, 155, 3, 42, "Text"],
Cell[384765, 8295, 501, 8, 79, "Program"],
Cell[385269, 8305, 132, 1, 42, "Text"],
Cell[385404, 8308, 448, 8, 100, "Program"],
Cell[385855, 8318, 129, 1, 42, "Text"],
Cell[385987, 8321, 102, 1, 57, "Program"],
Cell[386092, 8324, 120, 1, 42, "Text"],
Cell[386215, 8327, 350, 7, 100, "Program"],
Cell[386568, 8336, 102, 1, 42, "Text"],
Cell[386673, 8339, 568, 11, 143, "Program"],
Cell[387244, 8352, 95, 1, 42, "Text"],
Cell[387342, 8355, 108, 1, 57, "Program"],
Cell[387453, 8358, 487, 9, 43, "Text"],
Cell[387943, 8369, 1090, 21, 315, "Program"],
Cell[389036, 8392, 108, 1, 42, "Text"],
Cell[389147, 8395, 293, 5, 57, "Program"],
Cell[389443, 8402, 93, 1, 42, "Text"],
Cell[389539, 8405, 245, 3, 57, "Program"],
Cell[389787, 8410, 166, 2, 42, "Text"],
Cell[389956, 8414, 373, 8, 122, "Program"],
Cell[390332, 8424, 95, 1, 42, "Text"],
Cell[390430, 8427, 114, 1, 57, "Program"]
}, Open  ]]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[390605, 8435, 127, 1, 113, "Section"],
Cell[390735, 8438, 1239, 20, 170, "Text"],
Cell[391977, 8460, 597, 9, 68, "Text"],
Cell[CellGroupData[{
Cell[392599, 8473, 128, 1, 54, "Subsection"],
Cell[392730, 8476, 324, 6, 68, "Text"],
Cell[393057, 8484, 1772, 34, 398, "Code",
 InitializationCell->False],
Cell[394832, 8520, 711, 11, 144, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[395580, 8536, 108, 1, 54, "Subsection"],
Cell[395691, 8539, 231, 4, 42, "Text"],
Cell[395925, 8545, 2086, 49, 209, "Code",
 InitializationCell->False],
Cell[398014, 8596, 638, 10, 119, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[398689, 8611, 166, 3, 54, "Subsection"],
Cell[398858, 8616, 2305, 58, 249, "Text"],
Cell[401166, 8676, 1627, 29, 140, "Input"]
}, Open  ]],
Cell[CellGroupData[{
Cell[402830, 8710, 140, 3, 54, "Subsection"],
Cell[402973, 8715, 2756, 66, 182, "Text"],
Cell[405732, 8783, 1664, 35, 230, "Input"],
Cell[407399, 8820, 211, 4, 42, "Text"],
Cell[CellGroupData[{
Cell[407635, 8828, 499, 10, 86, "Input"],
Cell[408137, 8840, 37408, 1020, 292, "Output"]
}, Open  ]],
Cell[445560, 9863, 294, 5, 68, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[445891, 9873, 140, 3, 54, "Subsection"],
Cell[446034, 9878, 412, 8, 93, "Text"],
Cell[446449, 9888, 641, 16, 86, "Input"],
Cell[447093, 9906, 1192, 31, 203, "Input"],
Cell[CellGroupData[{
Cell[448310, 9941, 536, 10, 86, "Input"],
Cell[448849, 9953, 9290, 252, 136, "Output"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[458188, 10211, 128, 3, 54, "Subsection"],
Cell[458319, 10216, 311, 5, 68, "Text"],
Cell[CellGroupData[{
Cell[458655, 10225, 236, 6, 58, "Input"],
Cell[458894, 10233, 25748, 786, 358, "Output"]
}, Open  ]],
Cell[484657, 11022, 231, 5, 42, "Text"],
Cell[CellGroupData[{
Cell[484913, 11031, 674, 16, 167, "Input"],
Cell[485590, 11049, 26023, 789, 358, "Output"]
}, Open  ]],
Cell[511628, 11841, 370, 6, 68, "Text"],
Cell[CellGroupData[{
Cell[512023, 11851, 505, 13, 58, "Input"],
Cell[512531, 11866, 1246, 18, 57, "Output"]
}, Open  ]],
Cell[513792, 11887, 207, 4, 42, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[514036, 11896, 127, 3, 54, "Subsection"],
Cell[514166, 11901, 869, 13, 144, "Text"],
Cell[515038, 11916, 3437, 71, 803, "Code",
 InitializationCell->False],
Cell[518478, 11989, 194, 4, 42, "Text"],
Cell[CellGroupData[{
Cell[518697, 11997, 1392, 30, 167, "Input"],
Cell[520092, 12029, 52241, 1521, 782, "Output"]
}, Open  ]],
Cell[572348, 13553, 192, 4, 42, "Text"],
Cell[572543, 13559, 1960, 39, 194, "Input"],
Cell[574506, 13600, 2034, 40, 194, "Input"],
Cell[576543, 13642, 1794, 37, 194, "Input"],
Cell[578340, 13681, 1879, 39, 194, "Input"],
Cell[580222, 13722, 1844, 38, 194, "Input"],
Cell[582069, 13762, 1569, 34, 194, "Input"],
Cell[583641, 13798, 1677, 36, 194, "Input"],
Cell[585321, 13836, 1596, 34, 194, "Input"],
Cell[586920, 13872, 1605, 34, 221, "Input"],
Cell[588528, 13908, 1772, 35, 248, "Input"],
Cell[590303, 13945, 1764, 36, 221, "Input"],
Cell[592070, 13983, 273, 5, 42, "Text"],
Cell[592346, 13990, 1231, 28, 194, "Input"],
Cell[593580, 14020, 334, 6, 68, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[593951, 14031, 147, 3, 54, "Subsection"],
Cell[594101, 14036, 916, 14, 42, "Text"],
Cell[595020, 14052, 1926, 39, 172, "Text"],
Cell[596949, 14093, 1768, 32, 171, "Text"],
Cell[598720, 14127, 3342, 70, 387, "Input"],
Cell[602065, 14199, 652, 10, 93, "Text"],
Cell[602720, 14211, 900, 19, 58, "Input"],
Cell[603623, 14232, 181, 4, 42, "Text"],
Cell[CellGroupData[{
Cell[603829, 14240, 179, 4, 58, "Input"],
Cell[604011, 14246, 51781, 1507, 782, "Output"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[655841, 15759, 150, 3, 54, "Subsection"],
Cell[655994, 15764, 608, 16, 95, "Text"],
Cell[CellGroupData[{
Cell[656627, 15784, 487, 11, 58, "Input"],
Cell[657117, 15797, 1353, 20, 57, "Output"]
}, Open  ]],
Cell[658485, 15820, 307, 7, 43, "Text"],
Cell[658795, 15829, 1125, 27, 140, "Input"],
Cell[659923, 15858, 398, 11, 70, "Text"],
Cell[660324, 15871, 696, 13, 58, "Input"],
Cell[661023, 15886, 246, 4, 68, "Text"],
Cell[661272, 15892, 406, 11, 58, "Input"],
Cell[661681, 15905, 336, 6, 68, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[662054, 15916, 166, 3, 54, "Subsection"],
Cell[662223, 15921, 1323, 31, 140, "Input"],
Cell[663549, 15954, 363, 7, 69, "Text"],
Cell[663915, 15963, 574, 11, 58, "Input"],
Cell[664492, 15976, 337, 6, 68, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[664866, 15987, 135, 3, 54, "Subsection"],
Cell[665004, 15992, 1849, 45, 167, "Input"],
Cell[666856, 16039, 1600, 44, 81, "Text"],
Cell[CellGroupData[{
Cell[668481, 16087, 609, 14, 58, "Input"],
Cell[669093, 16103, 78587, 2199, 942, "Output"]
}, Open  ]],
Cell[747695, 18305, 230, 5, 42, "Text"],
Cell[747928, 18312, 346, 6, 68, "Text"]
}, Open  ]]
}, Open  ]],
Cell[748301, 18322, 127, 3, 113, "Section"],
Cell[CellGroupData[{
Cell[748453, 18329, 94, 1, 66, "Section"],
Cell[CellGroupData[{
Cell[748572, 18334, 125, 1, 54, "Subsection"],
Cell[748700, 18337, 1459, 21, 144, "Text"],
Cell[750162, 18360, 1268, 18, 144, "Text"],
Cell[751433, 18380, 1232, 22, 146, "Text"],
Cell[752668, 18404, 2787, 59, 156, "Text"],
Cell[755458, 18465, 1245, 22, 145, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[756740, 18492, 150, 2, 54, "Subsection"],
Cell[756893, 18496, 2088, 34, 172, "Text"],
Cell[758984, 18532, 1030, 15, 93, "Text"],
Cell[760017, 18549, 1393, 20, 170, "Text"],
Cell[761413, 18571, 599, 9, 68, "Text"],
Cell[762015, 18582, 243, 4, 68, "Text"],
Cell[762261, 18588, 285, 7, 28, "Input",
 CellOpen->False,
 InitializationCell->True],
Cell[762549, 18597, 290, 19, 36, "Reference",
 CellTags->"00002765"],
Cell[762842, 18618, 328, 21, 36, "Reference",
 CellTags->"0000381F"],
Cell[763173, 18641, 326, 24, 36, "Reference",
 CellTags->"00003589"],
Cell[763502, 18667, 369, 28, 36, "Reference",
 CellTags->"000047E5"],
Cell[763874, 18697, 271, 17, 36, "Reference",
 CellTags->"00001EB5"],
Cell[764148, 18716, 576, 53, 53, "Reference",
 CellTags->"00009BEE"],
Cell[764727, 18771, 272, 17, 36, "Reference",
 CellTags->"00001EF6"],
Cell[765002, 18790, 414, 32, 36, "Reference",
 CellTags->"00004D0E"],
Cell[765419, 18824, 327, 23, 36, "Reference",
 CellTags->"000033FD"],
Cell[765749, 18849, 302, 20, 36, "Reference",
 CellTags->"00002E07"],
Cell[766054, 18871, 336, 22, 36, "Reference",
 CellTags->"00003920"],
Cell[766393, 18895, 299, 20, 36, "Reference",
 CellTags->"000028BF"],
Cell[766695, 18917, 385, 31, 36, "Reference",
 CellTags->"00004D81"],
Cell[767083, 18950, 342, 24, 36, "Reference",
 CellTags->"00003C7D"],
Cell[767428, 18976, 324, 22, 36, "Reference",
 CellTags->"00003400"],
Cell[767755, 19000, 315, 21, 36, "Reference",
 CellTags->"000031E9"],
Cell[768073, 19023, 438, 40, 36, "Reference",
 CellTags->"0000514D"],
Cell[768514, 19065, 351, 25, 36, "Reference",
 CellTags->"00003F86"],
Cell[768868, 19092, 328, 22, 36, "Reference",
 CellTags->"000035D7"],
Cell[769199, 19116, 368, 28, 36, "Reference",
 CellTags->"000048B7"],
Cell[769570, 19146, 343, 25, 36, "Reference",
 CellTags->"00003F1E"],
Cell[769916, 19173, 390, 32, 36, "Reference",
 CellTags->"00005794"],
Cell[770309, 19207, 338, 23, 36, "Reference",
 CellTags->"00003C5F"],
Cell[770650, 19232, 314, 20, 36, "Reference",
 CellTags->"00002F30"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature pvTwQ3bL1tn0#AKBwXbSnan4 *)
