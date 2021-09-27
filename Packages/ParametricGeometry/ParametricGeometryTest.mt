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

(* Non-Euclidean test! *)

weightedWayPoints = {
  {0.510604773,{{-122.190498,47.533368},{-122.189469,47.533411}}},
    {0.590308463,{{-122.189469,47.533411},{-122.189512,47.534789}}},
      {0.108538082,{{-122.189512,47.534789},{-122.195472,47.534913}}},
        {0.344388984,{{-122.195472,47.534913},{-122.195982,47.532392}}},
          {0.658674332,{{-122.195982,47.532392},{-122.197618,47.53222}}},
            {0.835836749,{{-122.197618,47.53222},{-122.198492,47.532021}}},
              {0.822564093,{{-122.198492,47.532021},{-122.264249,47.463169}}},
                {0.100363519,{{-122.264249,47.463169},{-122.283352,47.463228}}},
                  {0.553301964,{{-122.283352,47.463228},{-122.2995,47.445047}}}};