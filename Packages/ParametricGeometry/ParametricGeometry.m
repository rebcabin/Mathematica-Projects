(* ::Package:: *)

(* Mathematica Raw Program *)

BeginPackage["ParametricGeometry`", {"MiniData`"}];

  colinearPointAndParameter::usage = "colinearPointAndParameter[start, end, obs] returns a pair consisting of the orthogonal projection of point \"obs\" on the 2-dimensional line segment \"start\"-to-\"end\" and of the parameter value t corresponding to that point, that is, the fractional distance of the projected point along the line segment.  Each of \"start\" and \"end\" must be 2-lists of Real coordinates.";
  normalFromSegment2D::usage = "normalFromSegment2D[p1, p2, optionalMetricFunction] produces a normal vector at the midpoint of the segment implied by the given points. Alternative metrics, such as Haversin distance, may be supplied."
  parametricLineSegment::usage = "parametricLineSegment[p1, p2] produces a linear function of the parameter t that produces p1 for t = 0 and p2 for t = 1."
  parametricPolyline::usage = "parametricPolyline[points_List, metricFunction_: EuclideanDistance] produces an object with constantSpeed and constantTime parametric functions, along with other attributes; inspect the attributes via \"DownValues\".";
  manipulatePolyline::usage = "manipulatePolyline[parametricPolyline] produces an interactive animation for a 2D parametric polyline";
  Begin["`Private`"];
  
    (* This version uses Euclidean metric implicit in the inner product *)
    colinearPointAndParameter[
      u:{u1_,u2_}, 
      v:{v1_,v2_}, 
      p:{p1_,p2_}] :=
      With[{t=(p-u).(v-u)/((v-u).(v-u))},
           {u + t(v-u), t}]
    
    normalFromSegment2D[
        p1:{p1x_,p1y_}, 
        p2:{p2x_,p2y_}, 
        metricFunction_: EuclideanDistance] :=
     (* TODO: Assert valid inputs *)
     Module[{dx, dy, d, n, midPoint},
      {dx, dy} = p2 - p1;
      midPoint = p1 + {dx, dy}/2;
      d = {-dy, dx};
      n = d/metricFunction[d, {0, 0}];
      {midPoint, n + midPoint}]
      
    parametricLineSegment[p1_, p2_] := Function[{t}, p1 + t (p2 - p1)];

    intervalsFromPoints[pts_List] := 
      MapThread[List, {Drop[pts, -1], Drop[pts, 1]}];
      
    segmentLengths[points_List, metricFunction_: EuclideanDistance] := 
      MapThread[metricFunction, Transpose@intervalsFromPoints@points];
  
    arcLength[points_List, metricFunction_: EuclideanDistance] := 
      Plus @@ segmentLengths[points, metricFunction];    
      
    cumulativeArcLengths[
        points_List, 
        metricFunction_: EuclideanDistance] := 
      Rest[FoldList[Plus, 0, segmentLengths[points, metricFunction]]];

    (* If there is just one arc length in our list of arc lengths, then \
    we've found the segment id: *)

    findSegmentIndexHelper[{a_}, _, j_] := j;

    (* If the parameter is less than the left'most cumulative arc length \
    in our list' then we found the segment id. Otherwise' the parameter \
    lies somewhere to the right of the node on the right of the arc \
    length at the first position in our list, and we search to the right \
    tail'recursively. *)

    findSegmentIndexHelper[{a_, as___}, tA_, j_] :=
      If[a > tA, j, findSegmentIndexHelper[{as}, tA, j + 1]];

    (* Must multiply t by the total' cumulative arc length. *)

    findSegmentIndex[arclengths_, t_] := 
      findSegmentIndexHelper[arclengths, t*Last[arclengths], 1];

    parametricPolyline[
        points_List, 
        metricFunction_: EuclideanDistance,
        pointsAccessor_: Part] :=
      Module[{lengths, as, A, k, residualT, left, right, n, nm1t, result},
        If[Length@points < 2, Throw["must have at least 2 points"]];
        If[metricFunction == Null, Throw["must supply a distance function"]];
        (* in text this is n+1 *)
        n = Length[points];
        (* List of point-to-point lengths *)
        lengths = segmentLengths[points, metricFunction]; 
        (* List of cumulative lengths *)
        as = cumulativeArcLengths[points, metricFunction];
        A = Last[as];(* Total length of curve *)
        result["cumulativeArcLengths"] = as;
        result["segmentLengths"] = lengths;
        result["totalLength"] = A;
        result["distanceTraveled"] = Function[t, t A];
        result["remainingDistance"] = Function[t, (1-t)A];
        result["constantSpeed"] = 
          Function[t,
          k = findSegmentIndex[as, t];
          residualT = (t*A - If[k == 1, 0, as[[k - 1]]])/lengths[[k]];
          left = pointsAccessor[points, k];
          right = pointsAccessor[points, k + 1];
          left + residualT*(right - left)];
        result["constantTime"] = 
          Function[t,
          nm1t = (n - 1)*t; (* n in the write-up *)
          k = Floor[nm1t];
          residualT = (nm1t - k);
          left = pointsAccessor[points, k + 1];
          right = If[k < n - 1, pointsAccessor[points, k + 2], left];
          left + residualT*(right - left)];
        result]

	manipulatePolyline[pp_] :=
	 Module[{constantGraphic =
	    ParametricPlot[pp["constantSpeed"][u], {u, 0, 1}]},
	  Manipulate[Show[
	    constantGraphic,
	    Graphics[{
	      Text["Red: const speed", {0.75, 0.75}],
	      Text["Blue: const time", {0.75, 0.70}],
	      {PointSize[0.03],
	       {Red, Point[pp["constantSpeed"][t]]},
	       {Blue, Point[pp["constantTime"][t]]}}}]],
	   {t, 0, 1, Appearance -> "Open"}]]
   
     End[];
  
EndPackage[];
