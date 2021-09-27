(* Mathematica Test File *)

Test[
	HaversinDistance[{0,0},{1,0}]
	,
	\[Pi]/180
	,
	TestID->"MapMatchingTest-20111219-H8K1M6"
]



Test[
	HaversinDistance[{0,0},{-1,0}]
	,
	\[Pi]/180
	,
	TestID->"MapMatchingTest-20111219-K2S0A9"
]



Test[
	HaversinDistance[{0,0},{0,1}]
	,
	\[Pi]/180
	,
	TestID->"MapMatchingTest-20111219-U0M8U5"
]



Test[
	HaversinDistance[{0,0},{0,-1}]
	,
	\[Pi]/180
	,
	TestID->"MapMatchingTest-20111219-O3H0H9"
]



Test[
	HaversinDistance[{0,n},{0,n-1}]
	,
	\[Pi]/180
	,
	TestID->"MapMatchingTest-20111220-U6H8J2"
]



Test[
	HaversinDistance[{anyLon, anyLat},{anyLon, anyLat+45}]/(2\[Pi])
	,
	1/8
	,
	TestID->"MapMatchingTest-20111219-R7O4D6"
]



Test[
	HaversinDistance[{anyLon, anyLat},{anyLon, anyLat+45}]
	,
	HaversinDistance[{anyLon, anyLat+45},{anyLon, anyLat}]
	,
	TestID->"MapMatchingTest-20111219-U2X7Q7"
]



Test[
	Simplify[HaversinDistance[{a, b},{c, d}]==HaversinDistance[{c, d},{a, b}]]
	,
	True
	,
	TestID->"MapMatchingTest-20111219-V6A3U7"
]



Test[
	earthRadius
	,
	6367500 meter
	,
	TestID->"MapMatchingTest-20111220-B7H5N9"
]



Test[
	deltaLonDegreesFromHaversinDistanceMetersAndLatDegrees[10 meter, 47.0]
	,
	0.00013193813729884534
	,
	TestID->"MapMatchingTest-20111220-I8E0Z0"
]



Test[
	deltaLonDegreesFromDistanceMetersForConstantLat[10 meter, 47.0]
	,
	0.00013193813729882976
	,
	TestID->"MapMatchingTest-20111220-H1Y6T3"
]