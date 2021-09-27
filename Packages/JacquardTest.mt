(* Mathematica Test File *)

Test[
	splits[{1, 2}]
	,
	Zip[prefixes @ {1, 2}, postfixes @ {1, 2}]
	,
	TestID->"JacquardTest-20120314-V5T3V8"
]

Test[
	splits[{1}]
	,
	Zip[prefixes @ {1}, postfixes @ {1}]
	,
	TestID->"JacquardTest-20120314-E1A2J1"
]

Test[
	splits[{}]
	,
	{{{}, {}}}
	,
	TestID->"JacquardTest-20120314-D6E5N9"
]

Test[
	postfixes[{1, 2}]
	,
	{{1, 2}, {2}, {}}
	,
	TestID->"JacquardTest-20120314-E7M6X5"
]

Test[
	postfixes[{1}]
	,
	{{1},{}}
	,
	TestID->"JacquardTest-20120314-E9I6L8"
]

Test[
	postfixes[{}]
	,
	{{}}
	,
	TestID->"JacquardTest-20120314-U8U6X8"
]

Test[
	prefixes[{1, 2}]
	,
	{{}, {1}, {1,2}}
	,
	TestID->"JacquardTest-20120314-A0H8U8"
]

Test[
	prefixes[{1}]
	,
	{{},{1}}
	,
	TestID->"JacquardTest-20120314-A0R3L5"
]

Test[
	prefixes[{}]
	,
	{{}}
	,
	TestID->"JacquardTest-20120314-N3P4T1"
]

Test[
	Zip[{1, 2}, {a, b}]
	,
	{{1, a}, {2, b}}
	,
	TestID->"JacquardTest-20120314-Q1L4U7"
]

Test[
	Zip[{1, 2}, {a}, Plus]
	,
	{1+a}
	,
	TestID->"JacquardTest-20120314-Y1Q7O1"
]

Test[
	Zip[{1}, {a}, Plus]
	,
	{1+a}
	,
	TestID->"JacquardTest-20120314-D7T1S7"
]

Test[
	ValueQ @ Zip[1, 2]
	,
	False
	,
	TestID->"JacquardTest-20120314-L0R6R4"
]

Test[
	Zip[{}, {}]
	,
	{}
	,
	TestID->"JacquardTest-20120314-I6F3L4"
]

Test[
	Zip[{}, {1}]
	,
	{}
	,
	TestID->"JacquardTest-20120314-E6G5E6"
]

Test[
	Zip[{1}, {}]
	,
	{}
	,
	TestID->"JacquardTest-20120314-N3V0R7"
]

Test[SymbolQ[a], True, TestID->"JacquardTest-20120306-T2K6T6"]
Test[SymbolQ[Head[List[1, 2, 3]]], True, TestID->"JacquardTest-20120306-M5Z5Y0"]
Test[SymbolQ[Head[{}]], True, TestID->"JacquardTest-20120306-S1N5F8"]
Test[SymbolQ[Head], True, TestID->"JacquardTest-20120306-P9T3C7"]

Test[SymbolQ["a"], False, TestID->"JacquardTest-20120306-A0S0S3"]
Test[SymbolQ[1], False, TestID->"JacquardTest-20120306-T3S8C0"]
Test[SymbolQ[], False, TestID->"JacquardTest-20120306-R0G1U9"]
Test[SymbolQ[{1, 2, 3}], False, TestID->"JacquardTest-20120306-G3T4D6"]
Test[SymbolQ[1, 2, 3], False, TestID->"JacquardTest-20120306-B4S0U5"]

Test[KvpQ[{a, 1}], True, TestID->"JacquardTest-20120214-T2K6T6"]
Test[KvpQ[{"a", 1}], True, TestID->"JacquardTest-20120306-K0C5T4"]

Test[KvpQ[{}], False, TestID->"Test-20120207-T2K6T6"]
Test[KvpQ[{2, 1}], False, TestID->"JacquardTest-20120306-I4D7Y1"]
Test[KvpQ[{"a", 2, 1}], False, TestID->"JacquardTest-20120306-D9D0J6"]

Test[pairsQ[{}], True, TestID->"JacquardTest-20120305-T2K6T6"]

(* This is true because an empty list is an empty list of kvps. *)
Test[KvpsQ[{}], True, TestID->"JacquardTest-20120306-I2X2U0"]
(* This is false because {} is not a Kvp. *)
Test[KvpsQ[{{}}], False, TestID->"JacquardTest-20120306-G0H9F8"]

Test[RulesQ[{}], True, TestID->"JacquardTest-20120306-F6S5L7"]
Test[RulesQ[{a->1, b->2}], True, TestID->"JacquardTest-20120306-M3M1B3"]
Test[RulesQ[{{a,1}}], False, TestID->"JacquardTest-20120306-G4O6P3"]

Test[RulessQ[{}], True,	TestID->"JacquardTest-20120306-J1Q3Y0"]
Test[RulessQ[{{c->3}}], True,	TestID->"JacquardTest-20120306-A5B6P5"]
Test[RulessQ[{{a->1, b->2},{c->3}}], True,	TestID->"JacquardTest-20120306-S2K0K9"]

testExpr[x_] := expressionFromRules @ rulesFromExpression @ x === x


ClearAll[foo];
clearTemps[] :=
	( ClearAll /@ CharacterRange["a", "z"];
	  ClearAll /@ "$"<># & /@ CharacterRange["a", "z"]; );
clearTemps[];
	  
Test[testExpr[""], True, TestID->"JacquardTest-20120308-Q8E6I2"]
Test[testExpr["foo"], True, TestID->"JacquardTest-20120309-D8C8L7"]
Test[testExpr[foo], True, TestID->"JacquardTest-20120309-L8S5H3"]
Test[testExpr[12], True, TestID->"JacquardTest-20120309-J7R7X0"]
Test[testExpr[0], True, TestID->"JacquardTest-20120309-E3S7S5"]
Test[testExpr[-12], True, TestID->"JacquardTest-20120309-X5M0G2"]
Test[testExpr[3.14], True, TestID->"JacquardTest-20120309-U1A3A2"]
Test[testExpr[2.72 + 3.14 I], True, TestID->"JacquardTest-20120309-B7W3G2"]
Test[testExpr[Infinity], True, TestID->"JacquardTest-20120309-E7Z4F9"]
Test[testExpr[-Infinity], True, TestID->"JacquardTest-20120309-B2T0G1"]
Test[testExpr[Indeterminate], True, TestID->"JacquardTest-20120309-F1H4D4"]
Test[testExpr[RandomReal[]], True, TestID->"JacquardTest-20120309-S7W6U1"]
Test[testExpr[RandomComplex[]], True, TestID->"JacquardTest-20120309-S4Z7G1"]
Test[testExpr[RandomInteger[2^64 - 1]], True, TestID->"JacquardTest-20120309-K3T5N3"]
Test[testExpr[{}], True, TestID->"JacquardTest-20120309-A1O2O7"]
Test[testExpr[{1,2,3}], True, TestID->"JacquardTest-20120309-Q7I5J2"]
Test[testExpr[{1,"a",b}], True, TestID->"JacquardTest-20120309-T6L4H3"]
Test[testExpr[f], True, TestID->"JacquardTest-20120309-T3J4Z2"]
Test[testExpr[f[b]], True, TestID->"JacquardTest-20120309-Q3T1S8"]
Test[testExpr[f[1,2,3]], True, TestID->"JacquardTest-20120309-K9F5A3"]
Test[testExpr[f[1,"a",b]], True, TestID->"JacquardTest-20120309-U4W1U0"]
Test[testExpr[f[{}]], True, TestID->"JacquardTest-20120309-R8E6S3"]
Test[testExpr[f[{1,2,3}]], True, TestID->"JacquardTest-20120309-T7B4L1"]
Test[testExpr[f[{1,"a",b}]], True, TestID->"JacquardTest-20120309-O6C7C9"]
Test[testExpr[f[a]], True, TestID->"JacquardTest-20120309-G0B2G1"]
Test[testExpr[f[a][b]], True, TestID->"JacquardTest-20120309-D7E4L3"]
Test[testExpr[f[a][1,2,3]], True, TestID->"JacquardTest-20120309-O1G4F4"]
Test[testExpr[f[a][1,"a",b]], True, TestID->"JacquardTest-20120309-H4T1B0"]
Test[testExpr[f[a][{}]], True, TestID->"JacquardTest-20120309-X2V3U8"]
Test[testExpr[f[a][{1,2,3}]], True, TestID->"JacquardTest-20120309-C9J0N6"]
Test[testExpr[f[a][{1,"a",b}]], True, TestID->"JacquardTest-20120309-T2T6F6"]
Test[testExpr[Plus@@{}], True, TestID->"JacquardTest-20120309-P3Z1F1"]
Test[testExpr[Plus@@{1,2,3}], True, TestID->"JacquardTest-20120309-F4M9E2"]
Test[testExpr[Plus@@{1,"a",b}], True, TestID->"JacquardTest-20120309-T6Y7X8"]
Test[testExpr[a + b * c], True, TestID->"JacquardTest-20120309-P7G7G1"]


testSet = {"",  "foo",  foo,  12,  0, -12, 3.14, 2.72 + 3.14 I, 
  Infinity, -Infinity, Indeterminate, RandomReal[], RandomComplex[], 
  RandomInteger[{-2^64, 2^64 - 1}],
  {}, {1,2,3}, {1,"a",b},
  f, f[b], f[1,2,3], f[1,"a",b],
  f[{}], f[{1,2,3}], f[{1,"a",b}],
  f[a][b], f[a][1,2,3], f[a][1,"a",b],
  f[a][{}], f[a][{1,2,3}], f[a][{1,"a",b}],
  Plus@@{}, Plus@@{1,2,3}, Plus@@{1,"a",b},
  a + b * c};

Test[
	And @@ testExpr /@ testSet
	,
	True
	,
	TestID->"JacquardTest-20120309-W0T0K5"
]

testJsonTrip[expr_] :=
 With[{$file = Environment["USERPROFILE"] <>
     "\\AppData\\Local\\Temp\\test.json",
   canon = Function[x,
     If[MatchQ[x, {___, "args" -> _, ___}], Sort@x, x]],
   rules = rulesFromExpression@expr},
  Export[$file, rules, "JSON"];
  If[Import[$file, "JSON"] === canon //@ rules,
   (* Then *) True,
   (* Else *) {$Failed, {
     "Import" -> Import[$file, "JSON"],
     "Rules" -> canon //@ rules}}]]

testJsonViaString[expr_] :=
 With[{
   canon = Function[x,
     If[MatchQ[x, {___, "args" -> _, ___}], Sort@x, x]],
   rules = rulesFromExpression@expr},
  With[{export = ExportString[rules, "JSON"]},
   If[ImportString[export, "JSON"] === canon //@ rules,
    (*Then*)True,
    (*Else*){$Failed, {
      "Import" -> ImportString[export, "JSON"],
      "Rules" -> canon //@ rules}}]]]
      
            
Test[testJsonViaString[""], True, TestID->"JacquardTest-20120309-K0L4N3"]
Test[testJsonViaString["foo"], True, TestID->"JacquardTest-20120309-Q8L5S5"]
Test[testJsonViaString[foo], True, TestID->"JacquardTest-20120309-F7T2V2"]
Test[testJsonViaString[12], True, TestID->"JacquardTest-20120309-S3O9C8"]
Test[testJsonViaString[0], True, TestID->"JacquardTest-20120309-V2S0U8"]
Test[testJsonViaString[-12], True, TestID->"JacquardTest-20120309-L5L6B0"]
Test[testJsonViaString[3.14], True, TestID->"JacquardTest-20120309-E7L0U4"]
Test[testJsonViaString[2.72 + 3.14 I], True, TestID->"JacquardTest-20120309-D1P8H0"]
Test[testJsonViaString[Infinity], True, TestID->"JacquardTest-20120309-O5J8E3"]
Test[testJsonViaString[-Infinity], True, TestID->"JacquardTest-20120309-M2H9A5"]
Test[testJsonViaString[Indeterminate], True, TestID->"JacquardTest-20120309-O5I6X3"]
Test[testJsonViaString[RandomReal[]], True, TestID->"JacquardTest-20120309-N9H3W6"]
Test[testJsonViaString[RandomComplex[]], True, TestID->"JacquardTest-20120309-D9Y8N5"]
Test[testJsonViaString[RandomInteger[2^64 - 1]], True, TestID->"JacquardTest-20120309-G3M7L7"]
Test[testJsonViaString[{}], True, TestID->"JacquardTest-20120309-M5P8U8"]
Test[testJsonViaString[{1,2,3}], True, TestID->"JacquardTest-20120309-K2V5P0"]
Test[testJsonViaString[{1,"a",b}], True, TestID->"JacquardTest-20120309-F3K2Z5"]
Test[testJsonViaString[f], True, TestID->"JacquardTest-20120309-V5L5L1"]
Test[testJsonViaString[f[b]], True, TestID->"JacquardTest-20120309-N6N5D3"]
Test[testJsonViaString[f[1,2,3]], True, TestID->"JacquardTest-20120309-K4R7X3"]
Test[testJsonViaString[f[1,"a",b]], True, TestID->"JacquardTest-20120309-C1D2V7"]
Test[testJsonViaString[f[{}]], True, TestID->"JacquardTest-20120309-U6C2J8"]
Test[testJsonViaString[f[{1,2,3}]], True, TestID->"JacquardTest-20120309-J0C8A6"]
Test[testJsonViaString[f[{1,"a",b}]], True, TestID->"JacquardTest-20120309-B6Y0B3"]
Test[testJsonViaString[f[a]], True, TestID->"JacquardTest-20120309-B4V9Q5"]
Test[testJsonViaString[f[a][b]], True, TestID->"JacquardTest-20120309-Z2U1J0"]
Test[testJsonViaString[f[a][1,2,3]], True, TestID->"JacquardTest-20120309-X9N3X7"]
Test[testJsonViaString[f[a][1,"a",b]], True, TestID->"JacquardTest-20120309-D9W0B1"]
Test[testJsonViaString[f[a][{}]], True, TestID->"JacquardTest-20120309-F3J3K1"]
Test[testJsonViaString[f[a][{1,2,3}]], True, TestID->"JacquardTest-20120309-F5N7H9"]
Test[testJsonViaString[f[a][{1,"a",b}]], True, TestID->"JacquardTest-20120309-J3M3A1"]
Test[testJsonViaString[Plus@@{}], True, TestID->"JacquardTest-20120309-J9O8Q6"]
Test[testJsonViaString[Plus@@{1,2,3}], True, TestID->"JacquardTest-20120309-C8T4D0"]
Test[testJsonViaString[Plus@@{1,"a",b}], True, TestID->"JacquardTest-20120309-M5J0I6"]
Test[testJsonViaString[a + b * c], True, TestID->"JacquardTest-20120309-J5Z4X8"]

testHeldExpr[x_] := expressionFromRules @ rulesFromHeldExpression @ x === x

Test[testHeldExpr[""], True, TestID->"JacquardTest-20120311-N9W2K3"]
Test[testHeldExpr["foo"], True, TestID->"JacquardTest-20120311-O2V2L4"]
Test[testHeldExpr[foo], True, TestID->"JacquardTest-20120311-O7Y2U8"]
Test[testHeldExpr[12], True, TestID->"JacquardTest-20120311-G4W9W7"]
Test[testHeldExpr[0], True, TestID->"JacquardTest-20120311-O6H3T7"]
Test[testHeldExpr[-12], True, TestID->"JacquardTest-20120311-Z1M1C2"]
Test[testHeldExpr[3.14], True, TestID->"JacquardTest-20120311-H3S2S3"]
Test[testHeldExpr[2.72 + 3.14 I], True, TestID->"JacquardTest-20120311-F1B9J9"]
Test[testHeldExpr[Infinity], True, TestID->"JacquardTest-20120311-S0Q1M3"]
Test[testHeldExpr[-Infinity], True, TestID->"JacquardTest-20120311-G5N7S3"]
Test[testHeldExpr[Indeterminate], True, TestID->"JacquardTest-20120311-M6K0Y6"]
Test[testHeldExpr[RandomReal[]], True, TestID->"JacquardTest-20120311-U5H6I3"]
Test[testHeldExpr[RandomComplex[]], True, TestID->"JacquardTest-20120311-U5Z3D3"]
Test[testHeldExpr[RandomInteger[2^64 - 1]], True, TestID->"JacquardTest-20120311-X8B4E5"]
Test[testHeldExpr[{}], True, TestID->"JacquardTest-20120311-E4V1H5"]
Test[testHeldExpr[{1,2,3}], True, TestID->"JacquardTest-20120311-X5V8F9"]
Test[testHeldExpr[{1,"a",b}], True, TestID->"JacquardTest-20120311-C5F6V6"]
Test[testHeldExpr[f], True, TestID->"JacquardTest-20120311-C2J8F2"]
Test[testHeldExpr[f[b]], True, TestID->"JacquardTest-20120311-P1W2Q2"]
Test[testHeldExpr[f[1,2,3]], True, TestID->"JacquardTest-20120311-Q0H0E3"]
Test[testHeldExpr[f[1,"a",b]], True, TestID->"JacquardTest-20120311-X6F5F7"]
Test[testHeldExpr[f[{}]], True, TestID->"JacquardTest-20120311-D1D2M0"]
Test[testHeldExpr[f[{1,2,3}]], True, TestID->"JacquardTest-20120311-K1S9Q6"]
Test[testHeldExpr[f[{1,"a",b}]], True, TestID->"JacquardTest-20120311-T7Z1I9"]
Test[testHeldExpr[f[a]], True, TestID->"JacquardTest-20120311-V0T7Y1"]
Test[testHeldExpr[f[a][b]], True, TestID->"JacquardTest-20120311-V5I9E4"]
Test[testHeldExpr[f[a][1,2,3]], True, TestID->"JacquardTest-20120311-J1N0L3"]
Test[testHeldExpr[f[a][1,"a",b]], True, TestID->"JacquardTest-20120311-K1C8C2"]
Test[testHeldExpr[f[a][{}]], True, TestID->"JacquardTest-20120311-B4A7W5"]
Test[testHeldExpr[f[a][{1,2,3}]], True, TestID->"JacquardTest-20120311-Q4C3X2"]
Test[testHeldExpr[f[a][{1,"a",b}]], True, TestID->"JacquardTest-20120311-A2Q5B5"]
Test[testHeldExpr[Plus@@{}], True, TestID->"JacquardTest-20120311-J6N7J3"]
Test[testHeldExpr[Plus@@{1,2,3}], True, TestID->"JacquardTest-20120311-K7E5V5"]
Test[testHeldExpr[Plus@@{1,"a",b}], True, TestID->"JacquardTest-20120311-R1J1M7"]
Test[testHeldExpr[a + b * c], True, TestID->"JacquardTest-20120311-E9I7T6"]



Test[captive[""], "", TestID->"JacquardTest-20120311-V8Z7Y5"]
Test[captive["foo"], "foo", TestID->"JacquardTest-20120311-W3E6T6"]
Test[captive[foo], foo, TestID->"JacquardTest-20120311-A8C9C0"]
Test[captive[12], 12, TestID->"JacquardTest-20120311-C7R2U0"]
Test[captive[0], 0, TestID->"JacquardTest-20120311-A7P9D2"]
Test[captive[-12], -12, TestID->"JacquardTest-20120311-J2J9C1"]
Test[captive[3.14], 3.14, TestID->"JacquardTest-20120311-N6L1I2"]
Test[captive[2.72 + 3.14 I], {Plus, 2.72, {Times, 3.14, I}}, TestID->"JacquardTest-20120311-C0F5M1"]
Test[captive[Infinity], {DirectedInfinity, 1}, TestID->"JacquardTest-20120311-P1F7C7"]
Test[captive[-Infinity], {Times, -1, {DirectedInfinity, 1}}, TestID->"JacquardTest-20120311-Q3V8V6"]
Test[captive[Indeterminate], Indeterminate, TestID->"JacquardTest-20120311-Z2H6G5"]
Test[captive[{}], {List}, TestID->"JacquardTest-20120311-I2I9G6"]
Test[captive[{1,2,3}], {List, 1, 2, 3}, TestID->"JacquardTest-20120311-Z6O4J8"]
Test[captive@(Exp[-1/t^2]), {Exp, {Times, -1, {Power, {Power, t, 2}, -1}}}, TestID->"JacquardTest-20120311-H6W7P4"] 
Test[captive[{1,"a",b}], {List, 1, "a", b}, TestID->"JacquardTest-20120311-O3G5K5"]
Test[captive[f], f, TestID->"JacquardTest-20120311-G4L7V5"]
Test[captive[f[b]], {f, b}, TestID->"JacquardTest-20120311-A6K6G5"]
Test[captive[f[1,2,3]], {f, 1, 2, 3}, TestID->"JacquardTest-20120311-T8X4J9"]
Test[captive[f[1,"a",b]], {f, 1, "a", b}, TestID->"JacquardTest-20120311-T7Z0U4"]
Test[captive[f[{}]], {f, {List}}, TestID->"JacquardTest-20120311-C9J8T5"]
Test[captive[f[{1,2,3}]], {f, {List, 1, 2, 3}}, TestID->"JacquardTest-20120311-O9A7M6"]
Test[captive[f[{1,"a",b}]], {f, {List, 1, "a", b}}, TestID->"JacquardTest-20120311-W6K4Z5"]
Test[captive[f[a]], {f, a}, TestID->"JacquardTest-20120316-H7M8C7"]
Test[captive[f[a][b]], {{f, a}, b}, TestID->"JacquardTest-20120316-X4T9O7"]
Test[captive[f[a][1,2,3]], {{f, a}, 1, 2, 3}, TestID->"JacquardTest-20120316-T7A7A5"]
Test[captive[f[a][1,"a",b]], {{f, a}, 1, "a", b}, TestID->"JacquardTest-20120316-G8Y2H3"]
Test[captive[f[a][{}]], {{f, a}, {List}}, TestID->"JacquardTest-20120316-L7E3U2"]
Test[captive[f[a][{1,2,3}]], {{f, a}, {List, 1, 2, 3}}, TestID->"JacquardTest-20120316-V6Z8L1"]
Test[captive[f[a][{1,"a",b}]], {{f, a}, {List, 1, "a", b}}, TestID->"JacquardTest-20120316-D7W1C0"]
Test[captive[Plus@@{}], {Apply, Plus, {List}}, TestID->"JacquardTest-20120316-B5Z8Q0"]
Test[captive[Plus@@{1,2,3}], {Apply, Plus, {List, 1, 2, 3}}, TestID->"JacquardTest-20120316-T7F3I8"]
Test[captive[Plus@@{1,"a",b}], {Apply, Plus, {List, 1, "a", b}}, TestID->"JacquardTest-20120316-I9V4L2"]
Test[captive[a + b * c], {Plus, a, {Times, b, c}}, TestID->"JacquardTest-20120316-X9J8U6"]

Test[
	captive[bicycle=vehicle[2*wheel]]
	,
	{Set, bicycle, {vehicle, {Times, 2, wheel}}}
	,
	TestID->"JacquardTest-20120319-C5R4E5"
]
	