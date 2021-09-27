(* Mathematica Test File *)

Test[
	colinearPointAndParameter[{0,0},{1,0},{1/2,0}]
	,
	{{1/2,0},1/2}
	,
	TestID->"ParametricGeometryTest-20120402-A6M8N4"
]

Test[
	parametricLineSegment[{p1x,p1y},{p2x,p2y}][0]
	,
	{p1x,p1y}
	,
	TestID->"ParametricGeometryTest-20120402-R2M7W8"
]

Test[
	parametricLineSegment[{p1x,p1y},{p2x,p2y}][1]
	,
	{p2x,p2y}
	,
	TestID->"ParametricGeometryTest-20120402-X5Y2R0"
]

Test[
	parametricLineSegment[{p1x,p1y},{p2x,p2y}][1/2]//Simplify
	,
	({p1x,p1y}+{p2x,p2y})/2
	,
	TestID->"ParametricGeometryTest-20120402-J4P9N9"
]

Test[
	parametricPolyline[{{0,0},{1,0}}]["constantSpeed"][0]
	,
	{0,0}
	,
	TestID->"ParametricGeometryTest-20120402-L2W7X3"
]

Test[
	parametricPolyline[{{0,0},{1,0}}]["constantSpeed"][1]
	,
	{1,0}
	,
	TestID->"ParametricGeometryTest-20120402-J2K4L4"
]

Test[
	parametricPolyline[{{0,0},{1,0}}]["constantSpeed"][1/2]
	,
	{1/2,0}
	,
	TestID->"ParametricGeometryTest-20120402-X4R6V9"
]