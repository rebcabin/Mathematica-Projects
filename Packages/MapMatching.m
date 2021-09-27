

(* Mathematica Raw Program *)

BeginPackage["MapMatching`", {"MiniData`"}, {"XmlProcessing`"}];

	HaversinDistance::usage = "HaversinDistance[{lo1, la1}, {lo2, la2}] computes the great-circle distance on the unit sphere between the given {longitude, latitude} points in decimal degrees.";
	HaversinHeading::usage = "HaversinHeading[{lo1, la1}, {lo2, la2}] computes the heading in the tangent plane of point {lo1, la1} of the great circle connecting {lo1, la1} and {lo2, la2}, where both points are longitude-latitude pairs in decimal degrees; 0 North, 90 East, 180 South, 270 West.";
	
	nodesFromLeg::usage = "nodesFromLeg[leg] retrieves nodes from leg data";
	idFromLeg::usage = "idFromLeg[leg] retrieves the leg id from OSM leg data";
	idFromNode::usage = "idFromNode[node] retrieves the node id from OSM leg data";
    directionalityFromLeg::usage = "directionalityFromLeg[leg] produces the directionality of a given leg data";
    lengthMetersFromLeg::usage = "produces the length of the leg in meters";
    haversinIntegratedLengthMetersFromLeg::usage = "produces the length of the leg in meters by integrating the internal segments.";
	idStartNodeAndEndNodeFromLeg::usage = "idStartNodeAndEndNodeFromLeg[leg] fetches the id and nodes from an leg";
	idDirectionalityStartNodeAndEndNodeFromLeg::usage = "idDirectionalityStartNodeAndEndNodeFromLeg[leg] fetches the id directionality, and nodes from an leg";
    idDirectionalityStartNodeIdAndEndNodeIdFromLeg::usage = "retrieves ids and directionality from leg."
	idsFromIdAndNodePair::usage = "idsFromIdAndNodePair[idAndNodePair] fetches ids from a triple of a leg id and a pair of nodes";

    lonLatFromNode::usage = "extracts a {lon, lat} pair, in decimal degrees, from a node.";
	lonLatsFromNodes::usage = "lonLatsFromNodes[nodes] produces lon-lat pairs, in decimal degrees, from a list of nodes";
	lonLatsFromLeg::usage = "lonLatsFromLeg[leg] produces all lon-lat pairs, in decimal degrees, for all the points in a leg, including intermediate geometry points";
	
	isLongitude::usage = "tests whether its input is a number between -180 and 180 inclusive.";
	isLatitude::usage = "tests whether its input is a number between -90 and 90 inclusive.";
	isBb::usage = "tests whether its input is a structure of the form {{minLon, maxLon}, {minLat, maxLat}}, with mins strictly less than lats; the unique zeroBb bounding box is also admitted.";
	bbFromPoints::usage = "bbFromPoints[points] produces the bounding box from a list of points in a form suitable for PlotRange";
	bbFromLeg::usage = "bbFromLeg[leg] produces the bounding box of all points in a leg in a form suitable for PlotRange";
	minLonFromBb::usage = "produces the minimum longitude from a bounding-box structure.";
	maxLonFromBb::usage = "produces the maximum longitude from a bounding-box structure.";
	minLatFromBb::usage = "produces the minimum latitude from a bounding-box structure.";
	maxLatFromBb::usage = "produces the maximum latitude from a bounding-box structure.";
	bbHull::usage = "bbHull[bb1, bb2] produces the hull surrounding a pair of bounding boxes; bbHull[bbs] produces the hull of a list of bounding boxes";
	bbIntersection::usage = "bbIntersection[bb1, bb2] produces the intersection of a pair of bounding-box structures, and zeroBb if they don't intersect; bbIntersection[bbs_List] produces the intersection of a List of bounding-box structures.";
	bbLonLatsFromBb::usage = "bbLonLatsFromBb[bb] produces a sequence of lon-lats (not called a polyline, here) from a bb in a form suitable for ListPlot";
	zeroBb::usage = "bbHull[bb, zeroBb] == zeroBb for any bb";

	earthRadius::usage = "Average radius of the Earth mean Spheroid";
	EarthHaversinDistance::usage = "Haversin Distance on the Earth mean Spheroid";
	EarthHaversinDistanceMeters::usage = "Unitless version of Haversin distance on the Earth mean Spheroid";
	
	deltaLonDegreesFromHaversinDistanceMetersAndLatDegrees::usage = "delta...[<k> meter, <lat>], where meter is a literal symbol, produces the longitude increment necessary to produce a k-meter displacement along the great circle connecting two endpoints at the same, specified latitude on the Earth geoid";
	deltaLonDegreesFromDistanceMetersForConstantLat::usage = "delta...[<k> meter, <lat>], where meter is a literal symbol, produces the longitude increment necessary to produce a k-meter displacement along the constant-latitude little circle of the specified latitude on the Earth geoid";
	deltaLatDegreesFromDistanceMeters::usage = "delta...[<k> meter], where meter is a literal symbol, produces the latitude increment necessary to produce a k-meter displacement along a constant-longitude meridian on the Earth geoid";

	constantLonDistanceIncrement::usage = "const...[deltaLatDegree] produces the distance on the Earth geoid effected by a latitude increment";
	constantLatDistanceIncrement::usage = "const...[deltaLonDegree, latDegree] produces the distance on the Earth geoid effected by a longitude increment at the given latitude";
	
	meter::usage = "a symbolic constant representing the meter unit for the length dimension";
	
	Pairwise::usage = "Pairwise[binaryFunction, list] maps the binaryFunction over adjacent members of the list taken two at a time";
	
	Begin["`Private`"];
	
		Pairwise[f2_, list_List] :=
		 If[Length[list] >= 2,
		  MapThread[f2, {Drop[list, -1], Drop[list, 1]}],
		  (* else *) {}]

		deltaLonDegreesFromDistanceMetersForConstantLat[k_ meter, latDegree_] :=
			(k Sec[(\[Pi] latDegree)/180])/(35375 \[Pi]);
			
		deltaLonDegreesFromHaversinDistanceMetersAndLatDegrees[k_ meter, latDegree_] := 
			N[360/\[Pi]*ArcSin[Sec[(\[Pi] latDegree)/180]*Sin[k/12735000]]]

		deltaLatDegreesFromDistanceMeters[dist_ meter] :=
		    dist/12735000*360/\[Pi]
 
		constantLatDistanceIncrement[deltaLonDegree_, latDegree_] :=
			earthRadius*\[Pi]/180*deltaLonDegree*Cos[latDegree * \[Pi]/180];
	
		constantLonDistanceIncrement[deltaLatDegree_] :=
        	N@earthRadius*\[Pi]/180*deltaLatDegree
 	
 	    earthRadius = 6367500 meter;
		EarthHaversinDistance = earthRadius*HaversinDistance[#1, #2] &;
		EarthHaversinDistanceMeters = earthRadius*HaversinDistance[#1, #2]/meter &;

		bbLonLatsFromBb[bb_] := Module[{
		   minlon = bb[[1, 1]], maxlon = bb[[1, 2]], minlat = bb[[2, 1]], 
		   maxlat = bb[[2, 2]]},
		  {{minlon, minlat}, {maxlon, minlat}, {maxlon, maxlat}, {minlon, 
		    maxlat}, {minlon, minlat}}]

		minLonFromBb = Function[bb, bb[[1, 1]]];
		maxLonFromBb = Function[bb, bb[[1, 2]]];
		minLatFromBb = Function[bb, bb[[2, 1]]];
		maxLatFromBb = Function[bb, bb[[2, 2]]];

		isLongitude[x_?NumberQ] := x >= -180 && x <= 180;
		isLongitude[_] := False;
		
		isLatitude[x_?NumberQ] := x >= -90 && x <= 90;
		isLatitude[_] := False;
		
		isBb[bb : {
		    {minLon_?NumberQ, maxLon_?NumberQ},
		    {minLat_?NumberQ, maxLat_?NumberQ}}] :=
		 bb === zeroBb ||
		  (isLongitude[minLon] && isLongitude[maxLon] &&
		    isLatitude[minLat] && isLatitude[maxLat] &&
		    minLon < maxLon && minLat < maxLat)
    
		bbHull[bbs_List] := 
		  {{Min[minLonFromBb/@bbs], Max[maxLonFromBb/@bbs]},
		   {Min[minLatFromBb/@bbs], Max[maxLatFromBb/@bbs]}};

    	bbHull[bb1_, bb2_] := bbHull[{bb1, bb2}];

		(* -- old implementations
		bbHull[bbs_List] := Fold[bbHull, zeroBb, bbs]; 

		bbHull[bb1_, bb2_] :=
		  {{Min[bb1[[1, 1]], bb2[[1, 1]]], Max[bb1[[1, 2]], bb2[[1, 2]]]},
		   {Min[bb1[[2, 1]], bb2[[2, 1]]], Max[bb1[[2, 2]], bb2[[2, 2]]]}};
		*)
		
		bbIntersection[bbs_List] :=
		 Module[{minLon, maxLon, minLat, maxLat},
		  minLon = Max[minLonFromBb /@ bbs];
		  maxLon = Min[maxLonFromBb /@ bbs];
		  minLat = Max[minLatFromBb /@ bbs];
		  maxLat = Min[maxLatFromBb /@ bbs];
		  (* Must account for zero-width or zero-height bbs: they're OK *)
		  If[minLon > maxLon || minLat > maxLat,
		   zeroBb,
		   {{minLon, maxLon}, {minLat, maxLat}}]];
		
		bbIntersection[bb1_, bb2_] := bbIntersection[{bb1, bb2}];

		zeroBb = {{Infinity, -Infinity}, {Infinity, -Infinity}}

		bbFromLeg[leg_] := bbFromPoints[lonLatsFromLeg@leg];

		bbFromPoints[lls_] := With[{
		   lons = #[[1]] & /@ lls,
		   lats = #[[2]] & /@ lls},
		  {{Min[lons], Max[lons]}, {Min[lats], Max[lats]}}]
  
  		h[x_] := Sin[((x \[Pi])/180)/2]^2;
		
		q[{lo1_, la1_}, {lo2_, la2_}] := 
			h[la2 - la1] + Cos[(la1 \[Pi])/180] Cos[(la2 \[Pi])/180] h[lo2 - lo1];
		
		HaversinDistance[{lo1_, la1_}, {lo2_, la2_}] :=  
			2*ArcSin@Sqrt@q[{lo1, la1}, {lo2, la2}];
		
		HaversinHeading[{xlon1_, xlat1_}, {xlon2_, xlat2_}] := Module[{
		    degree, lat1, lon1, lat2, lon2},
		   degree = \[Pi]/180.0;
		   lat1 = degree xlat1;
		   lon1 = degree xlon1;
		   lat2 = degree xlat2;
		   lon2 = degree xlon2;
		   Mod[ArcTan[
		     Cos[lat1] Sin[lat2] - Sin[lat1] Cos[lat2] Cos[lon2 - lon1],
		     Sin[lon2 - lon1] Cos[lat2]], 2.0 \[Pi]]] 180./\[Pi];
		
		nodesFromLeg[leg_] := 
		 getEltALists["node", #] & /@ lookup[leg, "content"] // Flatten[#, 1]&
		  
		idFromLeg[leg_] := 
		 ToExpression["id"/.lookup[leg, "attrs"]];
		 
		idFromNode[node_] :=
		  ToExpression["id"/.lookup[node,"attrs"]];
		
		lengthMetersFromLeg[leg_] :=
		  ToExpression["lengthmeters"/.lookup[leg, "attrs"]];
		
	    haversinIntegratedLengthMetersFromLeg[leg_]:=
	     Plus@@Pairwise[EarthHaversinDistanceMeters, lonLatsFromLeg[leg]];

		directionalityFromLeg[leg_] :=
		 "directionality"/.lookup[leg, "attrs"];
		
		idStartNodeAndEndNodeFromLeg[leg_] := 
		  With[{nodes = nodesFromLeg@leg},
		  { idFromLeg@leg, 
		    First@nodes, 
		    Last@nodes }];
		  
		idDirectionalityStartNodeAndEndNodeFromLeg[leg_] := 
		  With[{nodes = nodesFromLeg@leg},
		  { idFromLeg@leg, 
		    directionalityFromLeg@leg, 
		    First@nodes, 
		      Last@nodes }];
		  
		idDirectionalityStartNodeIdAndEndNodeIdFromLeg[leg_] := 
		With[{nodes = nodesFromLeg@leg},
		  { idFromLeg@leg, 
		    directionalityFromLeg@leg, 
		    idFromNode@First@nodes, 
		    idFromNode@Last@nodes }];
		  
		idsFromIdAndNodePair[idAndNodePair_] := Prepend[
		  ToExpression /@ (idFromNode /@ idAndNodePair[[2 ;; 3]]),
		    idAndNodePair[[1]]];
		
		lonLatFromNode[node_] := 
		  With[{attrs = lookup[#, "attrs"] & @ node},
  		    {ToExpression["lon"/.attrs], ToExpression["lat"/.attrs]}];
		
		lonLatsFromNodes[nodes_] := lonLatFromNode/@nodes;
(*		lonLatsFromNodes[nodes_] := 
		  Transpose@
		    With[{attrs = lookup[#, "attrs"] & /@ nodes},
  		      {ToExpression["lon"/.attrs], ToExpression["lat"/.attrs]}];
*)
		
		lonLatsFromLeg[leg_] := leg // nodesFromLeg // lonLatsFromNodes;
	
	End[];

EndPackage[];