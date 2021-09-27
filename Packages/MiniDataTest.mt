(* Mathematica Test File *)
Test[IndexOfMaxs[{2, 3, 1}], 2, TestID->"MiniDataTest-20111218-X5O0P1"]
Test[IndexOfMaxs[{2, 3, 1}, # &], 2, TestID->"MiniDataTest-20111218-H6A0T2"]
Test[IndexOfMaxs[{2, 3, 1}, -# &], 3, TestID->"MiniDataTest-20111218-L4K6N7"]
Test[IndexOfMaxs[Range[1000]], 1000, TestID->"MiniDataTest-20111218-S7E4T3"]
Test[IndexOfMins[{2, 3, 1}], 3, TestID->"MiniDataTest-20111218-F3N5X6"]
Test[IndexOfMins[Range[1000], Sin], 344, TestID->"MiniDataTest-20111218-Z3C9S6"]
Test[IndexOfMins[Range[1000], (-#) &], 1000, TestID->"MiniDataTest-20111218-B6Y9Q9"]
Test[Block[{$IterationLimit = 4096}, IndexOfMins[{3, 2, 2, 1, 1, 3}]], 5, TestID->"MiniDataTest-20111218-S9P2V6"]
(* This next one takes a little while *)
Test[Block[{$IterationLimit = 20000}, IndexOfMins[Range[10000]]], 1, TestID->"MiniDataTest-20111218-G3P5G4"]

Test[IndexOfMaxs[{}, Sin], 0, TestID->"MiniDataTest-20111218-R3B2L2"]

Test[IndexOfMins[{}], 0, TestID->"MiniDataTest-20111218-P7B7H4"]
Test[IndexOfMaxs[{}], 0, TestID->"MiniDataTest-20120212-H6K7L5"]
Test[IndexOfMins[{}, Minus], 0, TestID->"MiniDataTest-20120212-R5E6Q0"]
Test[IndexOfMaxs[{}, Minus], 0, TestID->"MiniDataTest-20120212-O1P7P2"]

Test[IndexMins[{}], {0, Infinity}, TestID->"MiniDataTest-20120212-N6W4E9"]
Test[IndexMaxs[{}], {0, -Infinity}, TestID->"MiniDataTest-20120212-Z9Q3A6"]
Test[IndexMins[{}, Minus], {0, Infinity}, TestID->"MiniDataTest-20120212-B7A7G1"]
Test[IndexMaxs[{}, Minus], {0, -Infinity}, TestID->"MiniDataTest-20120212-Y7J5F5"]

Test[IndexMins[{1}], {1, 1}, TestID->"MiniDataTest-20120212-X3E3O2"]
Test[IndexMaxs[{1}], {1, 1}, TestID->"MiniDataTest-20120212-W1F1I7"]
Test[IndexMins[{1}, Minus], {1, -1}, TestID->"MiniDataTest-20120212-T1W6A6"]
Test[IndexMaxs[{1}, Minus], {1, -1}, TestID->"MiniDataTest-20120212-M5R3P1"]

Test[IndexMins[{1, 2, 3}], {1, 1}, TestID->"MiniDataTest-20120212-U1A5I8"]
Test[IndexMaxs[{1, 2, 3}], {3, 3}, TestID->"MiniDataTest-20120212-R7M3Z5"]
Test[IndexMins[{1, 2, 3}, Minus], {3, -3}, TestID->"MiniDataTest-20120212-L1H9T6"]
Test[IndexMaxs[{1, 2, 3}, Minus], {1, -1}, TestID->"MiniDataTest-20120212-T4M1R3"]

Test[ArgIndexMins[{}], {List, 0, Infinity}, TestID->"MiniDataTest-20120212-F4S7I1"]
Test[ArgIndexMaxs[{}], {List, 0, -Infinity}, TestID->"MiniDataTest-20120212-U5S3X6"]
Test[ArgIndexMins[{}, Minus], {List, 0, Infinity}, TestID->"MiniDataTest-20120212-B7A3T8"]
Test[ArgIndexMaxs[{}, Minus], {List, 0, -Infinity}, TestID->"MiniDataTest-20120212-T8N7Y0"]

Test[ArgIndexMins[{1}], {1, 1, 1}, TestID->"MiniDataTest-20120212-N9Q0J0"]
Test[ArgIndexMaxs[{1}], {1, 1, 1}, TestID->"MiniDataTest-20120212-K2T8I7"]
Test[ArgIndexMins[{1}, Minus], {1, 1, -1}, TestID->"MiniDataTest-20120212-X1Y2G3"]
Test[ArgIndexMaxs[{1}, Minus], {1, 1, -1}, TestID->"MiniDataTest-20120212-N3U6J5"]

Test[ArgIndexMins[{1, 2, 3}], {1, 1, 1}, TestID->"MiniDataTest-20120212-U6N9T4"]
Test[ArgIndexMaxs[{1, 2, 3}], {3, 3, 3}, TestID->"MiniDataTest-20120212-G3R2P7"]
Test[ArgIndexMins[{1, 2, 3}, Minus], {3, 3, -3}, TestID->"MiniDataTest-20120212-I3M5P1"]
Test[ArgIndexMaxs[{1, 2, 3}, Minus], {1, 1, -1}, TestID->"MiniDataTest-20120212-S2E4H1"]

Test[al2Av[32],	32,	TestID->"MiniDataTest-20111218-L3K8N2"]
Test[isAl[{}], True, TestID->"MiniDataTest-20120210-D1K1Z4"]
Test[isAl[], False, TestID->"MiniDataTest-20120212-E2M5R6"]
Test[isAv[al2Av[{}]], True,	TestID->"MiniDataTest-20120210-X5W8W7"]

Test[isAv[], False, TestID->"MiniDataTest-20120212-S2C8R7"]
Test[isAv[{}], False, TestID->"MiniDataTest-20120212-K2C9A2"]
Test[isAl[{{"foo", 42}}], True,	TestID->"MiniDataTest-20111218-P7Q0H2"]
Test[isAv@(al2Av@{{"foo", 42}}), True, TestID->"MiniDataTest-20111218-R3E2G0"]
Test[Head@al2Av@{{"foo", 42}}, Symbol, TestID->"MiniDataTest-20111218-T7R8H8"]

Test[isAs[], False, TestID->"MiniDataTest-20120212-J8E6B2"]
Test[isAs[{}], True, TestID->"MiniDataTest-20120212-V3W8Z2"]
Test[isAs[{{"foo", 42}}], True,	TestID->"MiniDataTest-20120212-J4L2A1"]
Test[isAs@(al2Av@{{"foo", 42}}), True, TestID->"MiniDataTest-20120212-I4Q2V6"]

Test[av2Al@al2Av[{}], {}, TestID->"MiniDataTest-20120212-X6V3X8"]

(* sample with nesting *)
anz = 
    {{"name", Unique[]}, 
     {"lon", 100}, 
     {"lat", 100}, 
     {"nest", {{"a", 1},
               {"b", 2}}}};
Test[isAl[anz],	True, TestID->"MiniDataTest-20120210-V9O8S1"]
Test[Sort@anz, av2Al@al2Av@anz, TestID->"MiniDataTest-20120210-J1K4V1"]
Test[alFromAv@avFromAl@anz, av2Al@al2Av@anz, TestID->"MiniDataTest-20120210-R5V3A2"]
Test[alFromPairsList[{}], {}, TestID->"MiniDataTest-20120212-Q0C5T8"]
Test[alFromPairsList[{{"a", 1}}], {{"a", 1}}, TestID->"MiniDataTest-20120212-K3N2K4"]
Test[alFromPairsList[{{"a", 1}, {"a", 2}}], {{"a", 2}}, TestID->"MiniDataTest-20120212-Z0S9L6"]


(* Try writing out an association vector explicitly *)
danz["name"] = lookup[anz, "name"];
danz["lat"]  = lookup[anz, "lat"];
danz["lon"] = 100;
ddanz["a"] = 1;
ddanz["b"] = 2;
danz["nest"] = ddanz;

Test[isAv[danz], True, TestID->"MiniDataTest-20120212-K1Y7A4"]
Test[av2Al[danz], Sort@anz, TestID->"MiniDataTest-20120212-M2V1C8"]


Test[(DownValues@Evaluate@al2Av@{{"foo", 42}})[[1, 1, 1, 1]], "foo", TestID->"MiniDataTest-20111218-A5Q9U8"]
Test[(DownValues@Evaluate@al2Av@{{"foo", 42}})[[1, 2]], 42, TestID->"MiniDataTest-20111218-L7A9P6"]
Test[(DownValues@Evaluate@al2Av@{{"foo", 42}})[[1, 1, 1]], 42, TestID->"MiniDataTest-20111218-G4J4J0"]

z = al2Av[{{"name", Unique[]}, {"lon", 100}, {"lat", 100}}]; 

(* Beware: this next test relies on non-contractural behavior of Unique. *)
Test[z["name"], $11, 
    (* This may change! It WILL change if you make new tests above this
       one that call Unique[].  But it may also change if MMA's version
       changes.  There are no guarantees. *)
	TestID->"MiniDataTest-20111218-I7V0L6"]

(* This next one relies on Unique[]'s returning something different from its prior call. *)
Test[equalAvs[z, al2Av@{{"name", Unique[]}, {"lon", 100}, {"lat", 100}}], 
	False, TestID->"MiniDataTest-20111218-H7Y1D4"]
Test[equalAvs[z, copyAv@z], True, TestID->"MiniDataTest-20111218-L0N6H9"]

(* Beware: this next test relies on non-contractural behavior of Unique. *)
Test[av2Al[z],
	{{"lat", 100}, {"lon", 100}, {"name", $11}}, (* Name not guaranteed to be $11! *)
	TestID->"MiniDataTest-20111218-G4R3J5"]

Test[av2Al[z] == as2Al[z], True, TestID->"MiniDataTest-20111218-M4J9P5"]

Test[getSchema[z], {"lat", "lon", "name"}, TestID->"MiniDataTest-20111218-G8X0X6"]
Test[ValueQ@getSchema[42], False, TestID->"MiniDataTest-20111218-L7J6N8"]
Test[av2Al@schemaAndRecord2Av[{"name", "lat", "lon"}, {Zark, 120, 130}],
	{{"lat", 120}, {"lon", 130}, {"name", Zark}},
	TestID->"MiniDataTest-20111218-E7R5O3"]

Test[av2Al@adjoin[z, {{"foo", 1}, {"lon", 200}}],
	{{"foo", 1}, {"lat", 100}, {"lon", 200}, {"name", $11}},
	TestID->"MiniDataTest-20111218-D5I8V6"]
Test[av2Al@adjoin[z, "lat", 200], {{"lat", 200}, {"lon", 100}, {"name", $11}},
	TestID->"MiniDataTest-20111218-Q3N7X5"]
Test[av2Al@adjoin[z, {{"lat", 200}, {"lon", 200}}],
	 {{"lat", 200}, {"lon", 200}, {"name", $11}},
	 TestID->"MiniDataTest-20120210-P3H1M6"]
Test[adjoin[av2Al@z, {{"lat", 200}, {"lon", 200}}],
	 {{"lat", 200}, {"lon", 200}, {"name", $11}},
	TestID->"MiniDataTest-20120210-V0L1V4"]

Test[adjoin[{}, "a", 1], {{"a", 1}}, TestID->"MiniDataTest-20120210-P0J8V5"]
Test[adjoin[{{"a", 1}}, {{"b", 2}}], {{"a", 1}, {"b", 2}}, TestID->"MiniDataTest-20120212-L6M0I8"]
Test[adjoin [{{"a", 1}}, {{"a", 2}}], {{"a", 2}}, TestID->"MiniDataTest-20120210-Z8H6R1"]

Test[conjoin[{}, "a", 1], {{"a", 1}}, TestID->"MiniDataTest-20120212-W9I2V9"]
Test[conjoin[{{"a", 1}}, {{"b", 2}}], {{"a", 1}, {"b", 2}}, TestID->"MiniDataTest-20120212-L7C5D4"]
Test[conjoin[{{"a", 1}}, {{"a", 2}}], {{"a", 1}}, TestID->"MiniDataTest-20120210-W6K8L1"]

Test[av2Al@conjoin[z, {{"foo", 1}, {"lon", 200}}],
	{{"foo", 1}, {"lat", 100}, {"lon", 100}, {"name", $11}},
	TestID->"MiniDataTest-20120210-A3O5W7"]

Test[containsKey[z, "foo"], False, TestID->"MiniDataTest-20120210-C4T4S7"]
Test[containsKey[conjoin[z, "foo", 1], "foo"], True, TestID->"MiniDataTest-20120210-C6Z9R6"]

Test[av2Al@conjoin[z, "lat", 200], av2Al@z,
	TestID->"MiniDataTest-20120210-D2X3G5"]
Test[av2Al@conjoin[z, {{"lat", 200}, {"lon", 200}}], av2Al@z,
	 TestID->"MiniDataTest-20120210-V8C2J1"]
Test[conjoin[av2Al@z, {{"lat", 200}, {"lon", 200}}], av2Al@z,
	TestID->"MiniDataTest-20120210-D7K4Z1"]

(* test that the original wasn't damaged by side-effect *)
Test[av2Al@z, {{"lat", 100}, {"lon", 100}, {"name", $11}}, 
	TestID->"MiniDataTest-20120210-P0S6C1"]

z2 = copyAv@z;
Test[av2Al@adjoin[adjoin[z, "lat", 200], z2], av2Al@z,
	TestID->"MiniDataTest-20111218-D7R8Z6"]
Test[av2Al@adjoin[z, z2], av2Al@z,
	TestID->"MiniDataTest-20111218-N1S7E8"]

(* tests of lookup *)
Test[fetchAttribute[{}, "a"], {"a", Null}, TestID->"MiniDataTest-20120212-W3S0F6"]
Test[fetchAttribute[al2Av@{}, "a"], {"a", Null}, TestID->"MiniDataTest-20120212-F8E3X7"]

Test[lookup[{}, Unique[]], Null, TestID->"MiniDataTest-20120212-T4V8Z6"]
Test[lookup[al2Av@{}, Unique[]], Null, TestID->"MiniDataTest-20120212-F3W6N6"]

Test[lookup[{{"a", 1}}, "a"], 1, TestID->"MiniDataTest-20120212-S2V0O5"]
Test[lookup[{{"a", 1}}, "b"], Null, TestID->"MiniDataTest-20120212-J9W2E4"]

Test[keys@anz, {"lat", "lon", "name", "nest"}, TestID->"MiniDataTest-20120212-F3B9R6"]

Test[MatchQ[sieve[anz, {}], {{{"lat", _}, {"lon", _}, {"name", _}, {"nest", _}}}], True, TestID->"MiniDataTest-20120213-O6W6F0"]
Test[sieve[{}, {}], {}, TestID->"MiniDataTest-20120213-X1A8W8"]
Test[MatchQ[sieve[anz, {"lat", "lon"}], {{{"lat", _}, {"lon", _}}, {{"name", _}, {"nest", _}}}], True, TestID->"MiniDataTest-20120213-C8A3M6"]