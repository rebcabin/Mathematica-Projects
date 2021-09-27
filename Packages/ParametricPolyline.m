(* ::Package:: *)

(* ::Title:: *)
(*Parametric Resampling as a Method of Averaging Incommensurate Polylines*)


(* ::Subtitle:: *)
(*Brian Beckman, Eyal Ofek, Kenn Cartier, Manchun Yao, Julie Letchner*)


(* ::Subtitle:: *)
(*17 Dec 2010*)


(* ::Section:: *)
(*Subject of this Whitepaper*)


(* ::Text:: *)
(*This white paper concerns a method for averaging incommensurable polylines. That is, given two polylines, Subscript[P, 1] and Subscript[P, 2], which may not have the same number of interpolating points, that is, are incommensurable, find a third polyline that represents, in a sense to be defined, the average of the two original polylines. *)


(* ::Section:: *)
(*Preliminary Definitions*)


(* ::Text:: *)
(*Consider a discrete, ordered collection (a list) of n+1>1 points, not necessarily distinct, in Euclidean k-space \[DoubleStruckCapitalR]^k, labeled Subscript[p, i], i\[Element]{0, 1, 2, ..., n}. The set of n directed edges that connect each point to the next in the list is the polyline defined by the points. The points Subscript[p, i] are the interpolating points of the polyline. *)


(* ::Text:: *)
(*The polyline exists both geometrically, defining an uncountably infinite set of interstitial points between each adjacent pair in the interpolating-point list, and graph-theoretically, defining a discrete relation between each interpolating point and the next in the list, except for the last point.*)


(* ::Text:: *)
(*Speaking geometrically, the points interpolate the polyline, and the polyline interpolates the points. The edges constitute interstitial (or intersticial) line segments connecting adjacent points. Each line segment is an interstix, and the collection of segments are interstices. *)


(* ::Text:: *)
(*The entire polyline is parameterized when we assign a function p from the parameter space, that is, the real interval t\[Element][0, 1] (the numbers between 0, inclusive, and 1, inclusive) to points along the polyline, to both interpolating points and to interstitial points, such that:*)


(* ::Text:: *)
(*(1) The parameter begins at the beginning of the entire polyline and ends at the end of the entire polyline, that is, p(0)=Subscript[p, o] and p(1)=Subscript[p, n]*)


(* ::Text:: *)
(*(2) the parameter increases along the polyline, that is, when interpolating point Subscript[p, i]=p(Subscript[t, i]) precedes interpolating point Subscript[p, j]=p(Subscript[t, j]) in the original list, then parameter value Subscript[t, i] is less than or equal to parameter value Subscript[t, j], and equal only when the two points coincide, that is, when Subscript[p, i]=Subscript[p, j], and *)


(* ::Text:: *)
(*(3) the parameter increases smoothly and linearly in the interstices, that is, as t increases from Subscript[t, i] to Subscript[t, j] between two interpolating points Subscript[p, i]=p(Subscript[t, i]) and Subscript[p, j]=p(Subscript[t, j]), the Euclidean distance of p(t) from the starting point p(Subscript[t, i]) is proportional to the non-negative real number t-Subscript[t, i]. *)


(* ::Text:: *)
(*There are two common methods for defining the parameterization of a polyline: the constant-speed parameter and the constant-time parameter. The constant-speed parameter maintains a constant proportionality between the parameter value and the total, accumulated Euclidean distance along the polyline, that is, equal increments in the parameter map to equal increments in total Euclidean distance along the polyline; and the constant-time parameter divides the parameter space into n+1 equidistant parts, Subscript[t, i]=i/n, i\[Element]{0, 1, 2, ..., n} such that p(Subscript[t, i])=Subscript[p, i], that is, equal increments in the parameter move from one point to the next in the original list of interpolating points.*)


(* ::Text:: *)
(*The constant-speed parameter is the more useful of the two; the constant-time parameter is easier to understand and to define.*)


(* ::Text:: *)
(*These definitions extend to metric functions other than Euclidean, such as haversin distances on a spheroidal Earth model or to metric functions described on ellipsoidal Earths or Earths described by spherical harmonics or geometric meshes.*)


(* ::Section:: *)
(*Colinear Point and Parameter*)


(* ::Text:: *)
(*Given two distinct points in the plane, u and v, connect them with a line segment s and parameterize s with a standard parameter (meaning, generate a linear function f from the real interval [0.0, 1.0] to points along s from u to v such that f(0)=u and f(1)=v). Given another point, p, not generally on s, and find the point q on s such that the perpendicular from p to s contains q, and find the parameter value t such that f(t)=q. *)


(* ::Subsection:: *)
(*colinearPointAndParameter[*)
(*    startPoint,*)
(*    endPoint,*)
(*    observedPoint] ~~> {point, parameter}*)


(* ::Input:: *)
(*colinearPointAndParameter[*)
(*startPoint_, *)
(*endPoint_, *)
(*observedPoint_]:=*)
(*With[{*)
(*u=startPoint,*)
(*v=endPoint,*)
(*p=observedPoint},*)
(*Module[{q, t, (* point and distance to return *)*)
(*vu2=(v-u).(v-u), (* length squared *)*)
(*vcu=Det[{v,u}], (* cross product; enclosed, oriented area *)*)
(*dx,dy},*)
(*If[u==v,Throw[ToString[u] <> " and " <> ToString[v] <> " must not be equal."]];*)
(*{dx,dy}=v-u;*)
(*q=ConstantArray[0,2];*)
(*q[[1]]=If[vu2==0,0,(p[[1]] dx^2+dy(p[[2]] dx-vcu))/vu2];*)
(*q[[2]]=If[vu2==0,0,(p[[2]] dy^2+dx(p[[1]] dy+vcu))/vu2];*)
(*t=Sign[If[dy==0,(q[[1]]-u[[1]])/dx,(q[[2]]-u[[2]])/dy]]*)
(**If[vu2==0,0,Sqrt[(q-u).(q-u)/vu2]];*)
(*{q,t}]]*)


(* ::Text:: *)
(*The formula above is the result of solving the following equations:*)


(* ::Input:: *)
(*Solve[{*)
(*(* equation 1 -- orthogonal projection *)*)
(*(q-p).(v-u)==0,*)
(*(* equation 2 -- q lies on the u->v line *)*)
(*Det[{(q-u),(v-u)}]==0*)
(*}/.{*)
(*u->{u1,u2},*)
(*v->{v1,v2},*)
(*p->{p1,p2},*)
(*q->{q1,q2}},*)
(*{q1,q2}]//FullSimplify*)


(* ::Subsubsection:: *)
(*Visualization*)


(* ::Input:: *)
(*Module[{lowLim={-1.8,-1.8},hiLim={1.8,1.8},*)
(*q,t},*)
(*Manipulate[*)
(*{q,t}=colinearPointAndParameter[u,v,p];*)
(*Show[*)
(*ListLinePlot[{u,v},*)
(*PlotRange->{{-2,2},{-2,2}},*)
(*AspectRatio->1],*)
(*ListLinePlot[{q,p}],*)
(*Graphics[{*)
(*Text["u",u+{0,0.15}],*)
(*Text["p",p+{0,0.15}],*)
(*Text["v",v+{0,0.15}],*)
(*Text["q",q+{0,0.15}],*)
(*Text["vu slope: "<>If[v[[1]]-u[[1]]==0,*)
(*"Infinity",*)
(*ToString@((v[[2]]-u[[2]])/(v[[1]]-u[[1]]))],*)
(*{-1.25,1.9}],*)
(*Text["qu slope: "<>If[q[[1]]-u[[1]]==0,*)
(*"Infinity",*)
(*ToString@((q[[2]]-u[[2]])/(q[[1]]-u[[1]]))],*)
(*{-1.25,1.8}],*)
(*Text["t: "<>ToString@t,*)
(*{-1.25,1.7}],*)
(*Red,Disk[q,0.06]*)
(*}]],*)
(*{{u,{-1,-0.5}},lowLim,hiLim,Locator},*)
(*{{v,{1,0.75}},lowLim,hiLim,Locator},*)
(*{{p,{-0.75,0.6}},lowLim,hiLim,Locator}*)
(*]]*)


(* ::Text:: *)
(*Another, simpler solution to the problem comes from noting that (p-u).(v-u) is ||p-u||||v-u||cos(\[Theta]), and ||p-u||cos(\[Theta])/||v-u|| is the value of the parameter. So, the paramters is t=(p-u).(v-u)/||v-u||^2=(p-u).(v-u)/(v-u).(v-u). The point q is the result of the vector sum u+t(v-u). *)


(* ::Text:: *)
(*In the following visualization, if these two solutions ever differ, the points will separate into a red one and a blue one.*)


(* ::Input:: *)
(*Module[{lowLim={-1.8,-1.8},hiLim={1.8,1.8},*)
(*q,t,q2},*)
(*Manipulate[*)
(*{q,t}=colinearPointAndParameter[u,v,p];*)
(*q2=(p-u).(v-u)/(v-u).(v-u) (v-u)+u;*)
(*Show[*)
(*ListLinePlot[{u,v},*)
(*PlotRange->{{-2,2},{-2,2}},*)
(*AspectRatio->1],*)
(*ListLinePlot[{q,p}],*)
(*Graphics[{*)
(*Text["u",u+{0,0.15}],*)
(*Text["p",p+{0,0.15}],*)
(*Text["v",v+{0,0.15}],*)
(*Text["q",q+{0,0.15}],*)
(*Text["vu slope: "<>If[v[[1]]-u[[1]]==0,*)
(*"Infinity",*)
(*ToString@((v[[2]]-u[[2]])/(v[[1]]-u[[1]]))],*)
(*{-1.25,1.9}],*)
(*Text["qu slope: "<>If[q[[1]]-u[[1]]==0,*)
(*"Infinity",*)
(*ToString@((q[[2]]-u[[2]])/(q[[1]]-u[[1]]))],*)
(*{-1.25,1.8}],*)
(*Text["t: "<>ToString@t,*)
(*{-1.25,1.7}],*)
(*Red,Disk[q,0.06],*)
(*Blue,Disk[q2,0.06]*)
(*}]],*)
(*{{u,{-1,-0.5}},lowLim,hiLim,Locator},*)
(*{{v,{1,0.75}},lowLim,hiLim,Locator},*)
(*{{p,{-0.75,0.6}},lowLim,hiLim,Locator}*)
(*]]*)


(* ::Subsubsection:: *)
(*Symbolic Solution*)


(* ::Text:: *)
(*P is the point off the line. Q is the point to solve for, on the line. u is the beginning of the line (parameter value 0), v is the end of the line (parameter value 1).*)


(* ::Input:: *)
(*p={p1,p2};q={q1,q2};v={v1,v2};u={u1,u2};*)


(* ::Text:: *)
(*Segment q-to-p must be perpendicular to segment u-to-v*)


(* ::Input:: *)
(*eqn1=(p-q).(v-u)==0*)


(* ::Text:: *)
(*The slope of segment u-to-v is the same as the slope of segment u-to-q (colinearity)*)


(* ::Input:: *)
(*eqn2=(v2-u2)(q1-u1)==(q2-u2)(v1-u1)*)


(* ::Input:: *)
(*soln1=Solve[{eqn1,eqn2},q]//FullSimplify*)


(* ::Text:: *)
(*Suppose I just want the distance, (p-q)^2?*)


(* ::Input:: *)
(*(({p1-q1, p2-q2}.{p1-q1, p2-q2})/.soln1[[1]])//FullSimplify*)


(* ::Text:: *)
(*Or, just by inspection, [(p-u)\[Cross](v-u)]^2/(v-u)^2*)


(* ::Input:: *)
(*(Det@{{p1,p2}-{u1,u2},{v1,v2}-{u1,u2}})^2/({v1,v2}-{u1,u2}).({v1,v2}-{u1,u2})//FullSimplify*)


(* ::Text:: *)
(*Auxilliary definitions*)


(* ::Input:: *)
(*vu2=(v-u).(v-u)*)


(* ::Input:: *)
(*vcu=Det[{v,u}]*)


(* ::Input:: *)
(*dx=(v1-u1);dy=(v2-u2);*)


(* ::Text:: *)
(*Now check that our manually derived formulas match Mathematica's *)


(* ::Input:: *)
(*(p1 dx^2+dy(p2 dx-vcu))/vu2==soln1[[1,1,2]]//FullSimplify*)


(* ::Input:: *)
(*(p2 dy^2+dx(p1 dy+vcu))/vu2==soln1[[1,2,2]]//FullSimplify*)


(* ::Input:: *)
(*(q2-u2)/(q1-u1)/.soln1//FullSimplify*)


(* ::Text:: *)
(*This next test doesn't converge (reasons unknown)*)


(* ::Input:: *)
(*(* Sign[(q2-u2)/(v2-u2)]==Sign[(q1-u1)/(v1-u1)]/.soln1//FullSimplify *)*)


(* ::Input:: *)
(*Remove[p,q,u,v,eqn1,eqn2,soln1,vu2,vcu,dx]*)


(* ::Text:: *)
(*Some experiments with latitude and longitude:*)


(* ::Input:: *)
(*lats={47.6054733,*)
(*47.6046983,*)
(*47.60389,*)
(*47.6031383,*)
(*47.6026733,*)
(*47.602565,*)
(*47.60255,*)
(*47.6025383,*)
(*47.602565};*)
(*lons={-122.1431116,*)
(*-122.14309,*)
(*-122.1430966,*)
(*-122.1430583,*)
(*-122.1429516,*)
(*-122.1431266,*)
(*-122.1436616,*)
(*-122.1445083,*)
(*-122.1454233};*)
(*ps =Reverse/@MapThread[List,{lats,lons}]*)


(* ::Input:: *)
(*star=Reverse@{47.605,-122.1451}*)


(* ::Input:: *)
(*ListPlot[ps~Append~star,*)
(*PlotRange->{{-122.146,-122.142},{47.602,47.606}}]*)


(* ::Input:: *)
(*colinearPointAndParameter[ps[[1]],ps[[2]],star]*)


(* ::Input:: *)
(*(star-ps[[1]]).(ps[[2]]-ps[[1]])/(ps[[2]]-ps[[1]]).(ps[[2]]-ps[[1]])*)


(* ::Section:: *)
(*Parametric Line Segment*)


(* ::Text:: *)
(*Given two points, a standard parametric line segment between them is a function of a single real parameter, t, that produces points in Euclidean n-space along the line between the two points, such that when t is zero, the function produces the first point and that when t is one, the function produces the second point. Negative values of t extend points along the line away from the second point, that is, produce points "to the left of" the first point; and values of t greater than one produce points along the line in the direction away from the first point, that is, produce points "to the right of" the second point. *)


(* ::Text:: *)
(*The following definition works in any number of dimensions:*)


(* ::Input:: *)
(*parametricLineSegment[p1_,p2_]:=Function[{t},p1+t(p2-p1)]*)


(* ::Section:: *)
(*Parametric Polyline*)


(* ::Subsection::Closed:: *)
(*intervalsFromPoints[points]*)
(*segmentLengths[points, metricFunction]*)
(*arcLength[points, metricFunction]*)
(*cumulativeArcLengths[points, metricFunction]*)


(* ::Text:: *)
(*IntervalsFromPoints, given a list of n+1>1 points, produces the list of n ordered point pairs, representing the parametric segments between them (the intersticial segments or the interstices)*)


(* ::Input:: *)
(*intervalsFromPoints[pts_List]:=MapThread[List,{Drop[pts,-1],Drop[pts,1]}]*)


(* ::Text:: *)
(*SegmentLengths, given a list of n+1 points and a metricFunction (usually EuclideanDistance), produces the list of n  intersticial lengths *)


(* ::Input:: *)
(*segmentLengths[points_List, metricFunction_:EuclideanDistance]:=MapThread[metricFunction,Transpose@intervalsFromPoints@points]*)


(* ::Text:: *)
(*ArcLength produces the entire length of the polyline connecting n points*)


(* ::Input:: *)
(*arcLength[points_List,metricFunction_:EuclideanDistance]:=Plus@@segmentLengths[points, metricFunction]*)


(* ::Text:: *)
(*CumulativeArcLengths produces the list of n "lengths so far" for all insterstices:*)


(* ::Input:: *)
(*cumulativeArcLengths[points_List,metricFunction_:EuclideanDistance]:=Rest[FoldList[Plus,0,segmentLengths[points,metricFunction]]]*)


(* ::Subsubsection:: *)
(*Unit Tests*)


(* ::Input:: *)
(*ten2pts=RandomReal[{0,1},{10,2}]*)


(* ::Input:: *)
(*tt=intervalsFromPoints[ten2pts]*)


(* ::Input:: *)
(*ds=MapThread[EuclideanDistance,Transpose@tt]*)


(* ::Input:: *)
(*Plus@@ds*)


(* ::Input:: *)
(*arcLength[ten2pts, EuclideanDistance]*)


(* ::Input:: *)
(*segmentLengths[ten2pts,EuclideanDistance]*)


(* ::Input:: *)
(*FoldList[Plus,0,segmentLengths[ten2pts,EuclideanDistance]]*)


(* ::Input:: *)
(*cumulativeArcLengths[ten2pts,EuclideanDistance]*)


(* ::Input:: *)
(*Remove[ds,tt,ten2pts];*)


(* ::Subsection::Closed:: *)
(*findSegmentIndex[arcLengths, parameter]*)


(* ::Subsubsection:: *)
(*Searching for the "Bucket" that contains the parameter by arcLength*)


(* ::Text:: *)
(*The "bucket" is the 1-based index of the interstitial segment in the polyline. A polyline connecting n+1 points labeled 0 through n has n intersticial segments labeled 1 through n. The label of the interstix is equal to the label of its second or right-hand point. *)


(* ::Text:: *)
(*TBD: Walker's "method of aliases" may apply here, yielding a constant-time, O(n)-space lookup function from parameter to segment index. *)


(* ::Text:: *)
(*Algo 1 (Walker's): Imagine a histogram with the interstices labeling the horizontal buckets and the segment lengths along the vertical axis representing the "counts" in each bucket. Discretize the segment lengths and Walker's algorithm applies immediately. *)


(* ::Text:: *)
(*If discretizing the segment is not acceptable, we may still do better than the obvious linear or binary searches as follows:*)


(* ::Text:: *)
(*Algo 2: Divide the polyline into ten equal spans in cumulative arc length and divide the parameter range into ten, corresponding, left-closed subranges: [0, 0.1), [0.1, 0.2), ..., [0.9, 1.0). Make an array of length ten, and record in each slot of the array the following information: each of the equal spans either contains a vertex point or does not; if a span does not contain a vertex point, record the index of the sole segment that covers the span in the corresponding slot of the array; if a span does contain a vertex, recursively apply the algorithm, subdividing the span into ten equal spans, etc. This effectively indexes the segments with a 10-way tree index. *)


(* ::Text:: *)
(*NOT YET IMPLEMENTED. The following is a simple linear search. The problem is also amenable to binary search:*)


(* ::Text:: *)
(*Given a list, as, of cumulative arc lengths, and a parameter value, t, in [0..1), return the 1-based index of the intersticial segment that contains the parameter value. *)


(* ::Input:: *)
(*(* If there is just one arc length in our list of arc lengths, then we've found the segment id: *)*)
(*findSegmentIndexHelper[{a_},_,j_]:=j;*)
(*(* If the parameter is less than the left'most cumulative arc length in our list' then we found the segment id. Otherwise' the parameter lies somewhere to the right of the node on the right of the arc length at the first position in our list, and we search to the right tail'recursively. *)*)
(*findSegmentIndexHelper[{a_,as___},tA_,j_]:=*)
(*If[a>tA,j,findSegmentIndexHelper[{as},tA,j+1]];*)
(*(* Must multiply t by the total' cumulative arc length. *)*)
(*findSegmentIndex[arclengths_,t_]:=findSegmentIndexHelper[arclengths,t*Last[arclengths],1];*)


(* ::Subsubsection:: *)
(*Unit Testing*)


(* ::Text:: *)
(*This sometimes shows a diagonal "riser" on one of the stair steps. The reason is unknowns and the question has been sent to the community forums.*)


(* ::Input:: *)
(*With[{lengths=cumulativeArcLengths[RandomReal[1,{12,2}]]},*)
(*Plot[findSegmentIndex[lengths,t],{t,-0.5,1.5}]]*)


(* ::Text:: *)
(*This form does not have the plotting anomaly (thanks to Daniel Lichtblau for a clear answer to the problem)*)


(* ::Input:: *)
(*With[{lengths=cumulativeArcLengths[RandomReal[1,{12,2}]]},*)
(*ListPlot[Table[findSegmentIndex[lengths,t],{t,-0.5,1.5,.004}],Joined->True]]*)


(* ::Text:: *)
(*Expect this next expression to produce the empty list.*)


(* ::Input:: *)
(*Module[{foo, lengths,tests},*)
(*foo:=*)
(*(lengths=cumulativeArcLengths[RandomReal[1,{12,2}]];*)
(*tests=Table[findSegmentIndex[lengths,t],{t,0,1,.0001}];*)
(*Select[tests,#1!=Floor@#1&]);*)
(*Select[Table[foo,{10}],#1!={}&]]*)


(* ::Subsection:: *)
(*parametricPolyline[points, metricFunction]*)


(* ::Text:: *)
(*Take a list of points and return a JSON-like record containing the cumulative arc lengths, segments lengths, total length, and closures from t in [0..1] to points, one where t is proportional to cumulative length along the curve (the constant-speed natural parameter), one where t spends the same amount of "time" in each segment (the constant-time natural parameter):*)


(* ::Text:: *)
(*The metricFunction is a parameter because we may want parametricPolylines over Euclidean distances or over Haversin distances, etc.*)


(* ::Input:: *)
(*parametricPolyline[points_List, metricFunction_:EuclideanDistance]:=*)
(*Module[{lengths,as,A,k,residualT,left,right,n,nm1t},*)
(*If[Length@points<2,Throw["must have at least 2 points"]];*)
(*If[metricFunction==Null,Throw["must supply a distance function"]];*)
(*n=Length[points];(* in text this is n+1 *)*)
(*lengths = segmentLengths[points, metricFunction]; (* List of point-to-point lengths *)*)
(*as=cumulativeArcLengths[points, metricFunction]; (* List of cumulative lengths *)*)
(*A=Last[as];(* Total length of curve *)*)
(*{{"cumulativeArcLengths",as},*)
(*{"segmentLengths", lengths},*)
(*{"totalLength", A},*)
(*{"constantSpeed",*)
(*Function[{t},*)
(*k=findSegmentIndex[as,t];*)
(*residualT=(t*A-If[k==1,0,as[[k-1]]])/lengths[[k]];*)
(*left=points[[k]];*)
(*right=points[[k+1]];*)
(*left+residualT*(right-left)]},*)
(*{"constantTime", *)
(*Function[{t},*)
(*nm1t=(n-1)*t; (* n in the write-up *)*)
(*k=Floor[nm1t];*)
(*residualT=(nm1t-k);*)
(*left=points[[k+1]];*)
(*right=If[k<n-1,points[[k+2]],left];*)
(*left+residualT*(right-left)]}}]*)


(* ::Text:: *)
(*Need this for looking up values from key-value pairs such as produced by parametricPolyline:*)


(* ::Input:: *)
(*Needs["MiniData`","Documents\\MMA\\Packages\\MiniData.m"]*)


(* ::Subsubsection:: *)
(*Testing Parametric Polyline*)


(* ::Text:: *)
(*The following works in 2D and in 3D*)


(* ::Input:: *)
(*Remove[foo]*)


(* ::Input:: *)
(*manipulatePolyline[*)
(*points_,*)
(*graphicsFunc_,*)
(*plotFunc_,*)
(*dim_,*)
(*constantSpeedFunction_,*)
(*constantTimeFunction_,*)
(*experimentalListLinePlot_Symbol:False]:=*)
(*Module[{constantGraphic = If[*)
(*experimentalListLinePlot&&dim==2,*)
(*ListLinePlot[points,PlotMarkers->Automatic],*)
(*plotFunc[constantSpeedFunction[u],{u,0,1}]]},*)
(*Manipulate[Show[*)
(*constantGraphic,*)
(*graphicsFunc[{*)
(*Text["Red: const speed",*)
(*If[dim==3,{0.25,0.25,0.75},{0.75,0.75}]],*)
(*Text["Blue: const time",*)
(*If[dim==3,{0.25,0.25,0.55},{0.75,0.70}]],*)
(*{PointSize[0.03],*)
(*{Red,Point[constantSpeedFunction[t]]},*)
(*{Blue,Point[constantTimeFunction[t]]}}}]],*)
(*{t,0,1,Appearance->"Open"}]]*)


(* ::Input:: *)
(*plotPolylineFromPoints[points_, dim_:2]:=*)
(*Module[{ppl=parametricPolyline[points]},*)
(*manipulatePolyline[*)
(*points,*)
(*If[dim==3,Graphics3D,If[dim==2,Graphics,Throw["dim must be 2 or 3, not "<>ToString@dim]]],*)
(*If[dim==3,ParametricPlot3D,ParametricPlot],*)
(*dim,*)
(*lookup[ppl,"constantSpeed"],*)
(*lookup[ppl,"constantTime"],*)
(*True]];*)


(* ::Input:: *)
(*closePolypoints[points_]:=Append[points,First[points]]*)


(* ::Input:: *)
(*plotRandomPolyline[n_,d_:2]:=plotPolylineFromPoints[closePolypoints@RandomReal[1,{n,d}],d];*)


(* ::Text:: *)
(*Note: This occasionally produces non-reducing results, which are very difficult to debug. Undiagnosed.*)


(* ::Input:: *)
(*plotRandomPolyline[8]*)


(* ::Text:: *)
(*Note: This occasionally produces non-reducing results, which are very difficult to debug. Undiagnosed.*)


(* ::Input:: *)
(*(* plotRandomPolyline[4,3] *)*)


(* ::Input:: *)
(*plotAndPoints2D[ppl_,t_,rg_]:=Module[{*)
(*cSpeed=lookup[ppl,"constantSpeed"],*)
(*cTime=lookup[ppl,"constantTime"]},*)
(*{ParametricPlot[cSpeed[u],{u,0,1},*)
(*PlotRange->{rg,rg},*)
(*AspectRatio->1,*)
(*Axes->True],*)
(*Graphics[{*)
(*Text["Red: const speed",{0.75,0.75}],*)
(*Text["Blue: const time",{0.75,0.70}],*)
(*{PointSize[0.03],*)
(*{Red,Point[cSpeed[t]]},*)
(*{Blue,Point[cTime[t]]}}}]}]*)


(* ::Input:: *)
(*Manipulate[*)
(*Show[plotAndPoints2D[parametricPolyline[*)
(*closePolypoints@cpts],*)
(*t,*)
(*{-0.02,1.02}]],*)
(*{{cpts,RandomReal[1,{6,2}]},*)
(*{0,0},*)
(*{1,1},*)
(*Locator,*)
(*LocatorAutoCreate->{2,12}},*)
(*{t,0,1,Appearance->"Open"}]*)


(* ::Section:: *)
(*Local Normals in 2D*)


(* ::Text:: *)
(*A normal vector is normalized to length 1 and located at the midpoint between the two points, oriented COUNTERCLOCKWISE*)


(* ::Subsection:: *)
(*normalFromSegment2D[p1,p2,metricFunction]*)


(* ::Text:: *)
(*This delivers a pair consisting of the tail and the head of the vector.*)


(* ::Input:: *)
(*normalFromSegment2D[p1_,p2_,metricFunction_:EuclideanDistance]:=*)
(*(* Assert valid inputs (TODO) *)*)
(*Module[{dx,dy,d,n,midPoint},*)
(*{dx,dy}=p2-p1;*)
(*midPoint=p1+{dx,dy}/2;*)
(*d={-dy,dx};*)
(*n=d/metricFunction[d,{0,0}];*)
(*{midPoint,n+midPoint}]*)


(* ::Input:: *)
(*plotSegmentAndNormal[p1_,p2_,n_]:={*)
(*ListPlot[{p1,p2},*)
(*PlotRange->{{-1.02,2.02},{-1.02,2.02}},*)
(*AspectRatio->1,*)
(*Axes->True],*)
(*Graphics[{*)
(*{Blue,Arrow[{p1,p2}],*)
(*Text[ToString[EuclideanDistance@@{p2,p1}],*)
(*p1+(p2-p1)/2+{0,0.05}]},*)
(*{Red,Arrow[n],*)
(*Text[ToString[EuclideanDistance@@n],*)
(*n[[1]]+(n[[2]]-n[[1]])/2-{0.05,0}]}}]}*)


(* ::Input:: *)
(*Module[{*)
(*ps=RandomReal[1,{2,2}],*)
(*n,*)
(*lowLim={-0.98,-0.98},*)
(*hiLim={1.98,1.98}},*)
(*Manipulate[*)
(*n=normalFromSegment2D[p1,p2,EuclideanDistance];*)
(*Show[plotSegmentAndNormal[p1,p2,n]],*)
(*{{p1,ps[[1]]},lowLim,hiLim,Locator},*)
(*{{p2,ps[[2]]},lowLim,hiLim,Locator}]]*)


(* ::Section:: *)
(*Vertex Normals*)


(* ::Text:: *)
(*But see Torsten Langer, Alexander G. Belyaev, and Hans-Peter Seidel. 2005. Asymptotic analysis of discrete normals and curvatures of polylines. In Proceedings of the 21st spring conference on Computer graphics (SCCG '05). ACM, New York, NY, USA, 229-232. DOI=10.1145/1090122.1090160 http://doi.acm.org/10.1145/1090122.1090160, for some optimality considerations. This paper considers  the circle through three points as the optimal estimator for the tangent at the midpoint.*)


(* ::Text:: *)
(*http://shuisman.com/?p=361*)


(* ::Input:: *)
(*\[Alpha]Mat={{p1x,p1y,1},{p2x,p2y,1},{p3x,p3y,1}}*)


(* ::Input:: *)
(*\[Beta]Mat={{p1.p1,p1y,1},{p2.p2,p2y,1},{p3.p3,p3y,1}}*)


(* ::Input:: *)
(*\[Gamma]Mat={{p1.p1,p1x,1},{p2.p2,p2x,1},{p3.p3,p3x,1}}*)


(* ::Input:: *)
(*\[Delta]Mat={{p1.p1,p1x,p1y},{p2.p2,p2x,p2y},{p3.p3,p3x,p3y}}*)


(* ::Input:: *)
(*CircleFrom3Points[p1:{p1x_,p1y_},p2:{p2x_,p2y_},p3:{p3x_,p3y_}]:=Module[{\[Alpha],\[Beta],\[Gamma],\[Delta],x0,y0,r0},*)
(*\[Alpha]={{p1x,p1y,1},{p2x,p2y,1},{p3x,p3y,1}}//Det;*)
(*\[Beta]={{p1.p1,p1y,1},{p2.p2,p2y,1},{p3.p3,p3y,1}}//Det;*)
(*\[Gamma]={{p1.p1,p1x,1},{p2.p2,p2x,1},{p3.p3,p3x,1}}//Det;*)
(*\[Delta]={{p1.p1,p1x,p1y},{p2.p2,p2x,p2y},{p3.p3,p3x,p3y}}//Det;*)
(*If[\[Alpha]==0.,Print["points are collinear, \[Alpha] set to 10^-30"];\[Alpha]=10^-30];*)
(*x0=0.5\[Beta]/\[Alpha];*)
(*y0=-0.5\[Gamma]/\[Alpha];*)
(*r0=Sqrt[x0^2+y0^2+\[Delta]/\[Alpha]];*)
(*{{x0,y0},r0}]*)


(* ::Input:: *)
(*Manipulate[Graphics[{Circle@@CircleFrom3Points@@p},PlotRange->{{-1,1},{-1,1}}],{{p,{{-0.3,-0.7},{-0.7,0.2},{0.8,0}}},{-1,-1},{1,1},Locator}]*)


(* ::Text:: *)
(*As a sideline, it is interesting to compute the normal at a vertex as the weighted mean of the segment-midpoint normals to its left and right. But see Torsten Langer, Alexander G. Belyaev, and Hans-Peter Seidel. 2005. Asymptotic analysis of discrete normals and curvatures of polylines. In Proceedings of the 21st spring conference on Computer graphics (SCCG '05). ACM, New York, NY, USA, 229-232. DOI=10.1145/1090122.1090160 http://doi.acm.org/10.1145/1090122.1090160, for some optimality considerations. This paper considers  the circle through three points as the optimal estimator for the tangent at the midpoint.*)


(* ::Subsection:: *)
(*centralVertexNormal[threePoints, metricFunction]*)


(* ::Input:: *)
(*centralVertexNormal[{pL_,p_,pR_}, metricFunction_:EuclideanDistance]:=*)
(*Module[{*)
(*dL=metricFunction[pL,p],*)
(*dR=metricFunction[p,pR],*)
(*nL=normalFromSegment2D[pL,p],*)
(*nR=normalFromSegment2D[p,pR],*)
(*dirL,dirR,dir},*)
(*dirL=nL[[2]]-nL[[1]];*)
(*dirR=nR[[2]]-nR[[1]];*)
(*dir=(dL dirL+dR dirR)/Norm[dL dirL+dR dirR];*)
(*{p,p+dir}]*)


(* ::Input:: *)
(*plotTripleAndNormals[p1_,p_,p2_,n1_,n_,n2_]:={*)
(*ListLinePlot[{{p1,p},{p,p2}},*)
(*PlotRange->{{-1.02,2.02},{-1.02,2.02}},*)
(*AspectRatio->1,*)
(*Axes->True],*)
(*Graphics[{*)
(*{Green,Arrow[{p1,p}]},*)
(*{Green,Arrow[{p,p2}]},*)
(*{Blue,Arrow[n1]},*)
(*{Blue,Arrow[n2]},*)
(*{Red,Arrow[n]}}]}*)


(* ::Input:: *)
(*Module[{*)
(*ps=RandomReal[1,{3,2}],*)
(*n1,n,n2,*)
(*lowLim={-0.98,-0.98},*)
(*hiLim={1.98,1.98}},*)
(*Manipulate[*)
(*n1=normalFromSegment2D[p1,p,EuclideanDistance];*)
(*n=centralVertexNormal[{p1,p,p2},EuclideanDistance];*)
(*n2=normalFromSegment2D[p,p2,EuclideanDistance];*)
(*Show[plotTripleAndNormals[p1,p,p2,n1,n,n2]],*)
(*{{p1,ps[[1]]},lowLim,hiLim,Locator},*)
(*{{p,ps[[2]]},lowLim,hiLim,Locator},*)
(*{{p2,ps[[3]]},lowLim,hiLim,Locator}]]*)


(* ::Text:: *)
(*For each segment in a parametric polyline, plonk down the normals. But which orientation? Measure local curvature and point "outwards" (that's an approximation of the local Frenet frame). We'll get to that via splines, later. In the meantime,*)


(* ::Subsection:: *)
(*midpointNormals[points, metricFunction]*)
(*midpointNormalParameters[cumulativeLengths]*)


(* ::Text:: *)
(*Delivers a list of {tail, head} pairs. *)


(* ::Input:: *)
(*midpointNormals[*)
(*points_,*)
(*metricFunction_:EuclideanDistance]:=*)
(*MapThread[*)
(*normalFromSegment2D[#1,#2,metricFunction]&,Transpose@intervalsFromPoints@points]*)


(* ::Text:: *)
(*The following delivers the "constant-speed" parameters for each midpoint in the polyline.*)


(* ::Input:: *)
(*midpointNormalParameters[cumeLens_]:=Module[{mpNmlTs,l,totLen},*)
(*l=Length[cumeLens];*)
(*totLen=cumeLens[[l]];*)
(*mpNmlTs=ConstantArray[0,l];*)
(*mpNmlTs[[1]]=cumeLens[[1]]/(2totLen);*)
(*For[i=2,i<=l,i++,mpNmlTs[[i]]=(cumeLens[[i-1]]+(cumeLens[[i]]-cumeLens[[i-1]])/2)/totLen];*)
(*mpNmlTs];*)


(* ::Subsubsection:: *)
(*Unit Testing*)


(* ::Text:: *)
(*For simulation, make the noise much larger, 50x*)


(* ::Input:: *)
(*ptJitter2D[d\[Theta]_]:={*)
(*Random[NormalDistribution[0,d\[Theta]]],*)
(*Random[NormalDistribution[0,d\[Theta]]]};*)
(*paramJitter[s_,d\[Theta]_]:=Module[{*)
(*j=Random[NormalDistribution[0,d\[Theta]]],*)
(*splus},*)
(*splus=s+j;*)
(*If[splus<0,s,*)
(*If[splus>1,s,splus]]];*)
(*Options[fuzzLine]=*)
(*{FixedEndpoints->False,*)
(*p1->{0,0},*)
(*p2->{1,1},*)
(*PointMax->1,*)
(*KJitter->100,*)
(*NPoints->12};*)
(*fuzzLine[OptionsPattern[]]:=Module[{*)
(*m = OptionValue[PointMax],*)
(*q1,q2,*)
(*kj=OptionValue[KJitter]/10000,*)
(*\[Delta]},*)
(*If[OptionValue[FixedEndpoints],*)
(*q1=OptionValue[p1];*)
(*q2=OptionValue[p2],*)
(*q1=RandomReal[OptionValue[PointMax],2];*)
(*q2=RandomReal[OptionValue[PointMax],2]];*)
(*\[Delta]=EuclideanDistance[q2,q1];*)
(*(*Print@{p1,p2,EuclideanDistance[p1,p2]};*)*)
(*Table[*)
(*parametricLineSegment[q1,q2]*)
(*[paramJitter[s,kj]]+\[Delta] ptJitter2D[kj],*)
(*{s,0,1,1/(OptionValue[NPoints]-1)}]];*)


(* ::Input:: *)
(*rPoints=fuzzLine[FixedEndpoints->True]*)


(* ::Input:: *)
(*sPoints=fuzzLine[PointMax->10,KJitter->500,NPoints->12]*)


(* ::Input:: *)
(*plotPolylineFromPoints@sPoints*)


(* ::Input:: *)
(*midpointNormals[sPoints]*)


(* ::Input:: *)
(*Module[{*)
(*ps=fuzzLine[*)
(*FixedEndpoints->True,*)
(*p1->{0.5,0.5},*)
(*p2->{9.5,9.5},*)
(*KJitter->500,*)
(*NPoints->10],*)
(*nmls},*)
(*Manipulate[*)
(*nmls=midpointNormals[cpts];*)
(*Show[plotAndPoints2D[*)
(*parametricPolyline@cpts,*)
(*t,*)
(*{-1,11}],*)
(*Graphics[{Blue,Arrow/@nmls}]],*)
(*{{cpts,ps},*)
(*(*{0,0},*)
(*{1,1},*)*)
(*Locator,*)
(*LocatorAutoCreate->{2,12}},*)
(*{t,0,1,Appearance->"Open"}]]*)


(* ::Section:: *)
(*Resampling the Polyline*)


(* ::Subsection:: *)
(*resamplePolyline[points, nSamples, metricFunction]*)


(* ::Input:: *)
(*resamplePolyline[*)
(*points_,*)
(*nSamples_,*)
(*metricFunction_:EuclideanDistance]:=*)
(*Module[{*)
(*ppl=parametricPolyline[points,metricFunction],*)
(*cSpeed},*)
(*cSpeed=lookup[ppl,"constantSpeed"];*)
(*Table[cSpeed[t],{t,0,1,1/(nSamples-1)}]]*)


(* ::Subsection:: *)
(*lirp[parm1, datum1, parm2, datum2, parm3] *)


(* ::Text:: *)
(*Linear interpolation, "lirp" for short.*)


(* ::Input:: *)
(*lirp[parm1_,datum1_,parm2_,datum2_,parm3_]:=*)
(*If[parm2===parm1,Throw["cannot interpolate when input parameters are equal!"],*)
(*datum1+(datum2-datum1)/(parm2-parm1) (parm3-parm1)]*)


(* ::Subsection:: *)
(*localNormal[*)
(*    cumulativeArcLengths, *)
(*    constantSpeedParametricPolyline,*)
(*    midPointNormals, *)
(*    midPointNormalParameters,*)
(*    parameter]*)
(*    *)
(*localNormals[*)
(*    points, *)
(*    parameters, *)
(*    metricFunction: EuclideanDistance]*)


(* ::Text:: *)
(*Produces a vector normal to the given polyline at the given parameter value by linearly interpolating the midpoint normals.*)


(* ::Input:: *)
(*localNormal[*)
(*cumeLens_, (* cumulative lengths *)*)
(*cSpeed_,(* constant-speed polyline *)*)
(*mpNmls_,(* midpoint normal vectors *)*)
(*mpNmlTs_, (* midpoint normal parameters *)*)
(*t_]:= (* a particular parameter value *)*)
(*Module[{*)
(*(* the 1-based index where "t" lives: *)*)
(*k=findSegmentIndex[cumeLens,t],(* probable place to speed this up *)*)
(*l=Length@mpNmls, (* how many midpoint normals *)*)
(*totLen=Last@cumeLens,*)
(*n1,n2, (* normal to the left and normal to the right *)*)
(*t1,t2, (* parameter to the left and parameter to the right *)*)
(*tm, (* mean parameter *)*)
(*tm1,tm2, (*  *)*)
(*dir1,dir2, (*  *)*)
(*p, (*  *)*)
(*dir}, (*  *)*)
(*If[l<2,Throw["must have at least 2 segments, not "<>ToString[l]]];*)
(*If[Length@cumeLens=!=l,Throw["number of cumulative arc lengths must be the same as the number of midpoint normals: "<>ToString[Length@cumeLens]<>" != "<>ToString[l]]];*)
(*(* the parameter of the vertex to my left *)*)
(*t1=If[k==1,0,cumeLens[[k-1]]/totLen];*)
(*(* the parameter of the vertex to my right *)*)
(*t2=cumeLens[[k]]/totLen;*)
(*(* the mean parameter of my segment *)*)
(*tm=t1+(t2-t1)/2;*)
(*(* Print["tm: "<>ToString[tm]]; *)*)
(*(* the normal vector closest to my left, as a {tail, head} pair *)*)
(*n1=*)
(*If[k==1,mpNmls[[1]],*)
(*If[k==l,mpNmls[[k-1]],*)
(*If[t<tm,mpNmls[[k-1]],mpNmls[[k]]]]];*)
(*(* and its parameter *)*)
(*tm1=*)
(*If[k==1,mpNmlTs[[1]],*)
(*If[k==l,mpNmlTs[[k-1]],*)
(*If[t<tm,mpNmlTs[[k-1]],mpNmlTs[[k]]]]];*)
(*(* the normal vector closest to my right, as a {tail, head} pair *)*)
(*n2=*)
(*If[k==1,mpNmls[[2]],*)
(*If[k==l,mpNmls[[l]],*)
(*If[t<tm,mpNmls[[k]],mpNmls[[k+1]]]]];*)
(*(* and its parameter *)*)
(*tm2=*)
(*If[k==1,mpNmlTs[[2]],*)
(*If[k==l,mpNmlTs[[l]],*)
(*If[t<tm,mpNmlTs[[k]],mpNmlTs[[k+1]]]]];*)
(*(* Print["n1: "];Print[n1];*)
(*Print["n2: "];Print[n2]; *)*)
(*(* subtract the tails from the heads to get directions *)*)
(*dir1=n1[[2]]-n1[[1]];*)
(*dir2=n2[[2]]-n2[[1]];*)
(*(*Print["mpNmlTs: ",mpNmlTs];*)
(*Print["dir1, dir2: "]; Print[{dir1, dir2}];*)
(*Print["{k,l,t1,t,tm,t2}:"]; Print[{k,l,t1,t,tm,t2}];*)
(*Print["{k,l,tm1,t,tm,tm2}:"]; Print[{k,l,tm1,t,tm,tm2}];*)*)
(*dir=lirp[tm1,dir1,tm2,dir2,t];*)
(*dir=dir/Norm[dir];*)
(*(* Print["dir: "];Print[dir]; *)*)
(*p=cSpeed[t];*)
(*(*Print["p: "];*)
(*Print[p];*)
(*Print["p+dir: "];*)
(*Print[p+dir]; *)*)
(*{p,p+dir}]*)


(* ::Text:: *)
(*Produces a list of normal vectors (as {tail, head} pairs) to the polyline implied by the given points at the positions implied by the given parameters.*)


(* ::Input:: *)
(*localNormals[*)
(*points_,*)
(*parameters_,*)
(*metricFunction_:EuclideanDistance]:=*)
(*Module[{ppl=parametricPolyline[points,metricFunction],*)
(*cumes},*)
(*Map[localNormal[*)
(*cumes=lookup[ppl,"cumulativeArcLengths"],*)
(*lookup[ppl,"constantSpeed"],*)
(*midpointNormals[points, metricFunction], *)
(*midpointNormalParameters[cumes],*)
(*#]&,*)
(*parameters]]*)


(* ::Subsubsection:: *)
(*Unit Tests*)


(* ::Input:: *)
(*points=RandomReal[1,{6,2}]*)


(* ::Input:: *)
(*cumes=cumulativeArcLengths[points]*)


(* ::Input:: *)
(*mpnmlts=midpointNormalParameters[cumes]*)


(* ::Input:: *)
(*cspeed=lookup[parametricPolyline[points],"constantSpeed"];*)


(* ::Input:: *)
(*mpnmls=midpointNormals[points]*)


(* ::Input:: *)
(*samps=Table[t,{t,0,1,1/11.}]*)


(* ::Input:: *)
(*localNormal[cumes,cspeed,mpnmls,mpnmlts,0]*)


(* ::Input:: *)
(*Map[localNormal[cumes,cspeed,mpnmls,mpnmlts,#]&,samps]*)


(* ::Input:: *)
(*Remove[points,cumes,cspeed,mpnmls,mpnmlts,samps]*)


(* ::Subsubsection:: *)
(*Visualization*)


(* ::Input:: *)
(*Module[{*)
(*ps=fuzzLine[*)
(*FixedEndpoints->True,*)
(*p1->{0.5,0.5},*)
(*p2->{9.5,9.5},*)
(*KJitter->500,*)
(*NPoints->10],*)
(*(*RandomReal[1,{6,2}]*)*)
(*ppl,nmls,nmlTs,cumes},*)
(*Manipulate[*)
(*ppl=parametricPolyline[cpts];*)
(*cumes=lookup[ppl,"cumulativeArcLengths"];*)
(*nmls=midpointNormals[cpts];*)
(*nmlTs=midpointNormalParameters[cumes];*)
(*Show[*)
(*ListLinePlot[cpts,AspectRatio->1],*)
(*(*plotAndPoints2D[ppl,t,{-0.02,10.02}],*)*)
(*Graphics[{Blue,Arrow/@nmls}],*)
(*Graphics[{Red,*)
(*Arrow@localNormals[*)
(*cpts,*)
(*Range[0,1,1/49]]}]],*)
(*{{cpts,ps},*)
(*Locator,*)
(*LocatorAutoCreate->{2,12}}]]*)


(* ::Text:: *)
(*Contrast the scheme above, where the vertx normal is computed as the weighted average of the midpoint normals to its left and right*)


(* ::Input:: *)
(*Module[{ps=RandomReal[1,{3,2}],ppl,nmls,nmlTs,*)
(*cumes, lengths,totalLength,ratio2,cvn},*)
(*Manipulate[*)
(*ppl=parametricPolyline[cpts];*)
(*cumes=lookup[ppl,"cumulativeArcLengths"];*)
(*lengths=lookup[ppl,"segmentLengths"];*)
(*totalLength=lookup[ppl,"totalLength"];*)
(*nmls=midpointNormals[cpts];*)
(*nmlTs=midpointNormalParameters[cumes];*)
(*ratio2=Norm[cpts[[2]]-cpts[[1]]]/(Norm[cpts[[2]]-cpts[[1]]]+Norm[cpts[[3]]-cpts[[2]]]);*)
(*cvn=centralVertexNormal[cpts];*)
(*Show[*)
(*ListLinePlot[cpts,AspectRatio->1,*)
(*PlotRange->{{-1.02,2.02},{-1.02,2.02}}],*)
(*(*plotAndPoints2D[ppl,t,{-0.02,10.02}],*)*)
(*Graphics[{Text[*)
(*"Length: "<>ToString[totalLength]<>*)
(*", midPointLength: "<>ToString[lengths[[1]]]<>*)
(*", ratio: "<>ToString[lengths[[1]]/totalLength]<>*)
(*", ratio2: "<>ToString[ratio2],*)
(*{0.5,1.8}]}],*)
(*Graphics[{Blue,Arrow@nmls}],*)
(*Graphics[{Red,Arrow@localNormals[cpts,{ratio2}]}],*)
(*Graphics[{Green,Arrow@cvn}]],*)
(*{{cpts,ps},*)
(*Locator,*)
(*LocatorAutoCreate->{2,12}}]]*)


(* ::Section:: *)
(*Intersection of Vector with Line*)


(* ::Subsection:: *)
(*intersectionPointAndParameters[Tail, Head, ULine, VLine]*)


(* ::Text:: *)
(*Given a vector as a list of two points {tail, head} and a parametric line segment between two points {U, V}, return the point of intersection of the extension of the vector and the extension of the line segment, and the normalized [0,1] parameter value, s, of the point along the vector and the normalized [0,1] parameter value, t, along the extended line segment. We need the parameter values to tell whether the point is inside the segment and within the body of the vector, or on which side of the vector it lies.*)


(* ::Text:: *)
(*In some sense, this is the inverse of "Colinear Point and Parameter," where we are given a point off the line and drop a perpendicular to the line. Here, we are given a direction, implied by the vector.*)


(* ::Subsubsection:: *)
(*Symbolic Solution*)


(* ::Text:: *)
(*Given: T, tail of the vector; H, the head; U, the beginning point of the line; V, the ending point; solve for *)


(* ::Text:: *)
(*	* Q, the point of intersection of the extension of the vector with the extension of the line segment*)


(* ::Text:: *)
(*	* s, the parameter of Q along the vector*)


(* ::Text:: *)
(*	* t, the parameter of Q along the line*)


(* ::Input:: *)
(*T={T1,T2};H={H1,H2};U={U1,U2};V={V1,V2};Q={Q1,Q2};*)


(* ::Text:: *)
(*If the denominators are non-zero, i.e:*)


(* ::Input:: *)
(*eqn2=((Q2-H2)/(Q1-H1)==(T2-H2)/(T1-H1));*)


(* ::Input:: *)
(*eqn3=((Q2-U2)/(Q1-U1)==(V2-U2)/(V1-U1));*)


(* ::Input:: *)
(*(soln1=Solve[{eqn2,eqn3},Q])//FullSimplify*)


(* ::Text:: *)
(*Figure out s and t:*)


(* ::Text:: *)
(*If H1!=T1:*)


(* ::Input:: *)
(*(soln2=Solve[(Q1==T1+s(H1-T1)),s])*)


(* ::Text:: *)
(*else:*)


(* ::Input:: *)
(*(soln3=Solve[(Q2==T2+s(H2-T2)),s])*)


(* ::Text:: *)
(*If U1!=V1:*)


(* ::Input:: *)
(*(soln4=Solve[(Q1==U1+t(V1-U1)),t])*)


(* ::Text:: *)
(*else*)


(* ::Input:: *)
(*(soln5=Solve[(Q2==U2+t(V2-U2)),t])*)


(* ::Text:: *)
(*If the denominators are zero:*)


(* ::Input:: *)
(*eqz2=((Q1-H1)/(Q2-H2)==(T1-H1)/(T2-H2));*)


(* ::Input:: *)
(*eqz3=((Q1-U1)/(Q2-U2)==(V1-U1)/(V2-U2));*)


(* ::Input:: *)
(*(solz1=Solve[{eqz2,eqz3},Q])//FullSimplify*)


(* ::Text:: *)
(*Oh, look: it's the same as soln1:*)


(* ::Input:: *)
(*soln1==solz1*)


(* ::Text:: *)
(*And any way you cut it produces the same result, so we're solid:*)


(* ::Input:: *)
(*Solve[{eqn2,eqz3},Q]==Solve[{eqz2,eqn3},Q]*)


(* ::Input:: *)
(*Remove[T,H,U,V,Q,eqn1,eqn2,eqn3,soln1,soln2,soln3,soln4,soln5,eqz2,eqz3,solz1]*)


(* ::Subsubsection:: *)
(*Numerical Function*)


(* ::Input:: *)
(*intersectionPointAndParameters[{T_,H_},{U_,V_}]:=Module[{*)
(*Q,dvu,dht,detTH,detVU,s,t},*)
(*detTH=Det[{T,H}];(* H2 T1 - H1 T2 *)*)
(*detVU=Det[{V,U}];(* U2 V1 - U1 V2 *)*)
(*dvu=V-U;*)
(*dht=H-T;*)
(*Q={dvu[[1]]detTH+dht[[1]]detVU,*)
(*-T[[2]](H[[1]]dvu[[2]]+detVU)+*)
(*H[[2]](T[[1]]dvu[[2]]+detVU)}/(dht[[2]]dvu[[1]]-dht[[1]]dvu[[2]]);*)
(*s=If[H[[1]]!=T[[1]],(Q[[1]]-T[[1]])/(H[[1]]-T[[1]]),(Q[[2]]-T[[2]])/(H[[2]]-T[[2]])];*)
(*t=If[U[[1]]!=V[[1]],(Q[[1]]-U[[1]])/(V[[1]]-U[[1]]),(Q[[2]]-U[[2]])/(V[[2]]-U[[2]])];*)
(*{{"intersectionPoint",Q},*)
(*{"vectorParameter",s},*)
(*{"lineSegmentParameter",t}}]*)


(* ::Subsubsection:: *)
(*Visualization*)


(* ::Input:: *)
(*Module[{*)
(*lowLim={-1.8,-1.8},*)
(*hiLim={1.8,1.8},*)
(*ipts,Q,s,t},*)
(*Manipulate[*)
(*ipts=intersectionPointAndParameters[{T,H},{U,V}];*)
(*Q=lookup[ipts,"intersectionPoint"];*)
(*s=lookup[ipts,"vectorParameter"];*)
(*t=lookup[ipts,"lineSegmentParameter"];*)
(*Show[*)
(*ListLinePlot[{U,V},*)
(*PlotRange->{{-2,2},{-2,2}},*)
(*AspectRatio->1,*)
(*ColorFunction->Function[{x,y},Green]],*)
(*Graphics[{*)
(*Red,Arrow[{T,H}],*)
(*Blue,Line[{H,Q}],Disk[Q,0.06],*)
(*Text["s: "<>ToString@s,Q-{0,0.15}],*)
(*Text["t: "<>ToString@t,Q-{0,0.30}],*)
(*Black,*)
(*Text["U",U+{0,0.15}],*)
(*Text["T",T+{0,0.15}],*)
(*Text["H",H+{0,0.15}],*)
(*Text["V",V+{0,0.15}]*)
(*} ]],*)
(*{{U,{-1,-0.5}},lowLim,hiLim,Locator},*)
(*{{V,{1,0.75}},lowLim,hiLim,Locator},*)
(*{{T,{-1.6,1.2}},lowLim,hiLim,Locator},*)
(*{{H,{-0.75,0.6}},lowLim,hiLim,Locator} ]]*)


(* ::Subsection:: *)
(*intersectionSegmentAndParameters[*)
(*    vector, -- {tail, head}: the vector to intersect with a polyline*)
(*    points, -- the n+1 points defining the polyline*)
(*    ] ~~> Record: {*)
(*        foundSegment,*)
(*        vector,*)
(*        intersectionPoint, *)
(*        vectorParameter, *)
(*        lineSegmentParameter}*)


(* ::Input:: *)
(*?adjoin*)


(* ::Input:: *)
(*intersectionSegmentAndParameters[*)
(*vector_List,*)
(*points_List]:=*)
(*Module[{*)
(*ivals=intervalsFromPoints[points],*)
(*ipp,lsp,found*)
(*},*)
(*(* Start from the left of the list and look for a parameter value t between 0 and 1 *)*)
(*found=Select[ivals,( *)
(*ipp=intersectionPointAndParameters[vector,#];*)
(*lsp=lookup[ipp,"lineSegmentParameter"];*)
(*lsp>=0&&lsp<=1*)
(*)&,*)
(*1(* Get just the first one (potential bias?) *)];*)
(*adjoin[ipp,{*)
(*{"foundSegment",If[found!={},found[[1]],found]},*)
(*{"vector",vector}}]*)
(*]*)


(* ::Subsubsection:: *)
(*Unit Testing*)


(* ::Input:: *)
(*ps1=fuzzLine[*)
(*FixedEndpoints->True,*)
(*p1->{0.5,0.5}+{0.25,-0.25},*)
(*p2->{9.5,9.5}+{0.25,-0.25},*)
(*KJitter->500,*)
(*NPoints->10]*)


(* ::Input:: *)
(*ps2=fuzzLine[*)
(*FixedEndpoints->True,*)
(*p1->{0.5,0.5}-{0.25,-0.25},*)
(*p2->{9.5,9.5}-{0.25,-0.25},*)
(*KJitter->500,*)
(*NPoints->11]*)


(* ::Input:: *)
(*ppl1=parametricPolyline[ps1];*)
(*cumes=lookup[ppl1,"cumulativeArcLengths"];*)
(*nmls=midpointNormals[ps1];*)
(*nmlTs=midpointNormalParameters[cumes];*)


(* ::Input:: *)
(*Length[nmls]*)


(* ::Input:: *)
(*nmls[[1]]*)


(* ::Input:: *)
(*intersectionSegmentAndParameters[*)
(*nmls[[1]],*)
(*ps2]*)


(* ::Input:: *)
(*lookup[intersectionSegmentAndParameters[*)
(*nmls[[1]],*)
(*ps2],"foundSegment"]//MatrixForm*)


(* ::Input:: *)
(*lookup[intersectionSegmentAndParameters[*)
(*nmls[[1]],*)
(*ps2],"vector"]//MatrixForm*)


(* ::Input:: *)
(*lookup[intersectionSegmentAndParameters[*)
(*nmls[[1]],*)
(*ps2],"vector"][[2]]*)


(* ::Input:: *)
(*intersectionSegmentAndParameters[*)
(*#,*)
(*ps2]&/@nmls//TableForm*)


(* ::Input:: *)
(*Remove[ps1,ps2,ppl1,cumes,nmls,nmlTs]*)


(* ::Section:: *)
(*Averaging Two Incommensurable Polylines*)


(* ::Text:: *)
(*Imagine two polylines, called incommensurable because they have a different number of points.*)


(* ::Subsubsection:: *)
(*Visualization*)


(* ::Input:: *)
(*Module[{*)
(*ps1=fuzzLine[*)
(*FixedEndpoints->True,*)
(*p1->{0.5,0.5}+{0.25,-0.25},*)
(*p2->{9.5,9.5}+{0.25,-0.25},*)
(*KJitter->500,*)
(*NPoints->10],*)
(*ps2=fuzzLine[*)
(*FixedEndpoints->True,*)
(*p1->{0.5,0.5}-{0.25,-0.25},*)
(*p2->{9.5,9.5}-{0.25,-0.25},*)
(*KJitter->500,*)
(*NPoints->11],*)
(*ppl1,nmls,nmlTs,cumes},*)
(*ppl1=parametricPolyline[ps1];*)
(*cumes=lookup[ppl1,"cumulativeArcLengths"];*)
(*nmls=midpointNormals[ps1];*)
(*nmlTs=midpointNormalParameters[cumes];*)
(*Show[*)
(*ListLinePlot[*)
(*{ps1,ps2},*)
(*AspectRatio->1],*)
(*Graphics[{Blue,Arrow/@nmls}]*)
(*]]*)


(* ::Input:: *)
(*Module[{*)
(*ps1=fuzzLine[*)
(*FixedEndpoints->True,*)
(*p1->{0.5,0.5}+{0.5,-0.5},*)
(*p2->{9.5,9.5}+{0.5,-0.5},*)
(*KJitter->500,*)
(*NPoints->10],*)
(*ps2=fuzzLine[*)
(*FixedEndpoints->True,*)
(*p1->{0.5,0.5}-{0.5,-0.5},*)
(*p2->{9.5,9.5}-{0.5,-0.5},*)
(*KJitter->500,*)
(*NPoints->11],*)
(*ppl1,nmls,nmlTs,cumes,resampNormals,*)
(*nSamp=50,*)
(*isps,*)
(*avgs},*)
(*ppl1=parametricPolyline[ps1];*)
(*cumes=lookup[ppl1,"cumulativeArcLengths"];*)
(*nmls=midpointNormals[ps1];*)
(*nmlTs=midpointNormalParameters[cumes];*)
(*resampNormals=localNormals[ps1,Range[0,1,1/(nSamp-1)]];*)
(*isps=Select[*)
(*intersectionSegmentAndParameters[#,ps2]&/@resampNormals,*)
(*lookup[#,"foundSegment"]!={}&];*)
(*avgs=Function[isp,Module[{*)
(*ip=lookup[isp,"intersectionPoint"],*)
(*v=lookup[isp,"vector"]},*)
(*(* in general, do a weighted average below *)*)
(*(v[[1]]+ip)/2]]/@isps;*)
(*(*Print[avgs];*)*)
(*Show[*)
(*ListLinePlot[*)
(*{ps1,ps2},*)
(*AspectRatio->1],*)
(*Function[isp,Module[{*)
(*ip=lookup[isp,"intersectionPoint"],*)
(*v=lookup[isp,"vector"]},*)
(*Graphics[{*)
(*Green,*)
(*Disk[ip,0.06],*)
(*Line[{v[[2]],ip}]}]]*)
(*]/@isps,*)
(*Graphics[{Black,Line@avgs}],*)
(*Graphics[{Blue,Line/@nmls}],*)
(*Graphics[{Red,Line/@resampNormals}]*)
(*]]*)


(* ::Section:: *)
(*More Sophisticated Normals*)


(* ::Text:: *)
(*Asymptotic Analysis of Discrete Normals and Curvatures of Polylines*)
(*Torsten Langer, Alexander G. Belyaev, Hans-Peter Seidel*)
(*Max-Planck-Institut f\[DoubleDot]ur Informatik, Computer Graphics Group*)


(* ::Text:: *)
(*Abstract*)
(*Accurate estimations of geometric properties of a smooth curve from its discrete approximation are important for many computer graphics and computer vision applications. To assess and improve the quality of such an approximation, we assume that the curve is known in general form. Then we can represent the curve by a Taylor series expansion and compare its geometric properties with the corresponding discrete approximations. In turn we can either prove convergence of these approximations towards the true properties as the edge lengths tend to zero, or we can get hints on how to eliminate the error. In this paper, we propose and study discrete schemes for estimating tangent and normal vectors as well as for estimating curvature and torsion of a smooth 3D curve approximated by a polyline. Thereby we make some interesting findings about connections between (smooth) classical curves and certain estimation schemes for polylines. *)
(*CR Categories: I.3.5 [Computer Graphics]: Computational Geometry and Object Modeling;*)
(*Keywords: error analysis, discrete approximation, tangent vector, normal vector, Frenet frame, curvature, torsion, polyline*)


(* ::Subsection:: *)
(*Frenet Frame for arbitrary space curve*)


(* ::Input:: *)
(*ClearAll[triangles\[Alpha], triangles]*)


(* ::Subsection:: *)
(*triangles[points_]*)


(* ::Text:: *)
(*triangles\[Alpha] is a helper function for triangles*)


(* ::Text:: *)
(*triangles is a function from a list of points to a "sliding window" sequence of triangles. The number of triangles is no more than two less than the number of points. Colinear subsequences of points are collapsed. *)


(* ::Text:: *)
(*With just two points and a list of triangles, return the list of triangles.*)


(* ::Input:: *)
(*triangles\[Alpha][{_,_},ts_]:=ts;*)


(* ::Text:: *)
(*At the end of a list of points, when there are just two left, return the list of triangles. *)


(* ::Input:: *)
(*triangles\[Alpha][{_,_,{}},ts_]:=ts;*)


(* ::Text:: *)
(**)


(* ::Text:: *)
(*Test whether three points are colinear within machine floating-point precision (big TODO: make this exact using "exact determinants;" see http://blogs.mathworks.com/loren/2009/07/15/computational-geometry-in-matlab-r2009a-part-i/ for example).*)


(* ::Input:: *)
(*areColinear[p1_,p2_,p3_]:=(Chop[Cross[(p2-p1),(p3-p2)]]=={0.,0.,0.});*)


(* ::Text:: *)
(*The recursive case for the triangle helper, throwing away the middle point of any colinear sub-sequence.*)


(* ::Input:: *)
(*triangles\[Alpha][{p1_,p2_,ps___},ts_]:=*)
(*Module[{p3},*)
(*p3=First[{ps}];*)
(*If[areColinear[p1,p2,p3],*)
(*triangles\[Alpha][Join[{p1,p3},Rest[{ps}]],ts],*)
(*triangles\[Alpha][Join[{p2,p3},Rest[{ps}]],Append[ts,{p1,p2,p3}]]]];*)


(* ::Text:: *)
(*Here is the function to call at the top level*)


(* ::Input:: *)
(*triangles[ps_]:=triangles\[Alpha][ps,{}];*)


(* ::Text:: *)
(*Test it*)


(* ::Input:: *)
(*Remove[helix];*)


(* ::Input:: *)
(*helix[t_]:= {2 Cos[t], 2Sin[t],t^2/39};*)


(* ::Input:: *)
(*hiPitchHelix[t_]:={2 Cos[t], 2Sin[t],t^2}*)


(* ::Input:: *)
(*helixSample[n_]:=Table[helix[t],{t,0,20,20.0/(n-1)}];*)


(* ::Input:: *)
(*triangles[helixSample[12]]*)


(* ::Input:: *)
(*Graphics3D[Polygon/@triangles[helixSample[18]]]*)


(* ::Text:: *)
(*A couple more test-helper functions;*)


(* ::Input:: *)
(*ran3:=RandomReal[{0,1},3];*)


(* ::Input:: *)
(*ranTriangle:={ran3,ran3,ran3};*)


(* ::Subsection:: *)
(*Frenet Frame*)


(* ::Text:: *)
(*Given three points, approximate the tangent or T vector as the secant vector, that is, the unit vector that points in the direction from the first point to the third point, and locate that secant vector at the second point. Define the binormal B as the unit vector that lies in the plane of the triangle and points "inward" from the second point, that is, toward the secant line. Define the normal vector N so that the triple (T, N, B) form a right-handed set. This convention sends the normal upward if the points are counted with the right hand in the clockwise direction, and that is the opposite of the usual right-handed convention for oriented triangles in the 2D plane, in which normals are upward counting points counterclockwise.*)


(* ::Input:: *)
(*frenetFromTriangle[{p1_,p2_,p3_}]:=*)
(*Module[{t,n,b},*)
(*t=Normalize[p3-p1];*)
(*n=Normalize@Cross[(p3-p2),(p2-p1)];*)
(*b=Normalize@Cross[t,n];*)
(*{t,n,b}]*)


(* ::Text:: *)
(*Display an oriented triangle in a canonical fashion, with the first point represented by a RED bullet, second by a GREEN bullet, and third by a BLUE bullet, and locate the frenet frame at the second bullet (so that its tangent vector T doesn't get overlayed and obscured by the p1->p3 leg of the triangle.*)


(* ::Subsubtitle:: *)
(*Arrow3D*)


(* ::Text:: *)
(*Useful visual object, not supplied with Mathematica system (roll this up)*)


(* ::Input:: *)
(*Options[Arrow3D]={*)
(*HeadScaling3D->Relative,*)
(*HeadLength3D->0.10,*)
(*HeadWidth3D->0.5,*)
(*HeadSegments3D->10};*)
(*Arrow3D[base:{_,_,_},tip:{_,_,_},___]/;base==tip:=Point[base];*)
(*Arrow3D[base:{_,_,_},tip:{_,_,_},opts___?OptionQ]:=*)
(*Module[{length,halfwidth,polys,scaletype,scale,anOrthogonalVector,normalize,rotationmatrix,mycone},*)
(*anOrthogonalVector[norm:{_,_,_}]:=*)
(*	Block[{pos,a,b,v1},*)
(*		pos=If[VectorQ[norm,NumberQ],Abs[N[norm]],norm];*)
(*		pos=Sort[Transpose[{pos,Range[3]}]];*)
(*		{pos,a,b}=Map[Last,pos];*)
(*		v1=ReplacePart[{0,0,0},-Part[norm,a],b];*)
(*		ReplacePart[v1,Part[norm,b],a]];*)
(*normalize[vec_]:=vec/Sqrt[vec.vec];*)
(*rotationmatrix[axis_,\[Theta]_]:=*)
(*	Module[{n1,n2,n3},*)
(*		{n1,n2,n3}=normalize[axis]//N;*)
(*		{{n1^2+(1-n1^2)Cos[\[Theta]],n1 n2(1-Cos[\[Theta]])+n3 Sin[\[Theta]],n1 n3(1-Cos[\[Theta]])-n2 Sin[\[Theta]]},{n1 n2(1-Cos[\[Theta]])-n3 Sin[\[Theta]],n2^2+(1-n2^2)Cos[\[Theta]],n2 n3(1-Cos[\[Theta]])+n1 Sin[\[Theta]]},{n1 n3(1-Cos[\[Theta]])+n2 Sin[\[Theta]],n2 n3(1-Cos[\[Theta]])-n1 Sin[\[Theta]],n3^2+(1-n3^2)Cos[\[Theta]]}}//N*)
(*		];*)
(*mycone[vec_,tipp_,polys_,halfwidth_,length_]:=*)
(*	Block[{norm=normalize[anOrthogonalVector[vec]],\[Theta],\[CapitalDelta]\[Theta]=2\[Pi]/polys,nvec=normalize[vec]},*)
(*		Table[Polygon[{tipp,tipp+halfwidth (norm.rotationmatrix[vec, \[Theta]])-length nvec,tipp+halfwidth (norm.rotationmatrix[vec, \[Theta]+\[CapitalDelta]\[Theta]])-length nvec}],{\[Theta],0,2\[Pi]-\[CapitalDelta]\[Theta],\[CapitalDelta]\[Theta]}]//N];*)
(**)
(*scaletype=HeadScaling3D/.{opts}/.Options[Arrow3D];*)
(*length=HeadLength3D/.{opts}/.Options[Arrow3D];*)
(*halfwidth=(HeadWidth3D/.{opts}/.Options[Arrow3D])/2;*)
(*polys=HeadSegments3D/.{opts}/.Options[Arrow3D];*)
(*polys=Max[2,polys];*)
(*scale=If[scaletype===Relative,Sqrt[(tip-base).(tip-base)],scaletype];*)
(*length=length*scale;*)
(*halfwidth=length*halfwidth;*)
(**)
(*{Line[{base,base+0.999(tip-base)}],mycone[tip-base,tip,polys,halfwidth,length]}]*)


(* ::Input:: *)
(*Graphics3D[Arrow3D[{0,0,0},{1,1,1}]]*)


(* ::Subsubtitle:: *)
(*Test-Patterns: xcube, wcube; s3p, s3q*)


(* ::Input:: *)
(*o3=ConstantArray[0,3];*)


(* ::Input:: *)
(*c3[constant_]:=ConstantArray[constant,3]*)


(* ::Input:: *)
(*x3={1,0,0};y3={0,1,0};z3={0,0,1};a3={1,1,1};*)


(* ::Input:: *)
(*axesLabel3={"x","y","z"};*)


(* ::Input:: *)
(*vcube=*)
(*Translate[*)
(*{Style[{*)
(*Polygon[{o3,x3,a3-z3,y3}],*)
(*Polygon[{z3,a3-y3,a3,a3-x3}]},*)
(*FaceForm[Blue,Yellow]],*)
(*Style[{*)
(*Polygon[Reverse[{y3,a3-z3,a3,a3-x3}]],Polygon[Reverse[{o3,x3,a3-y3,z3}]]},*)
(*FaceForm[Green,Magenta]],*)
(*Style[{*)
(*Polygon[{o3,y3,a3-x3,z3}],*)
(*Polygon[{x3,a3-z3,a3,a3-y3}]},*)
(*FaceForm[Red,Cyan]]*)
(*},c3[-.5]];*)


(* ::Input:: *)
(*s3p=Show[Graphics3D[{Opacity[0.80],#1},*)
(*FaceGrids->All,*)
(*Axes->True,*)
(*AxesLabel->axesLabel3 (*,Lighting->"Neutral"*),*)
(*RotationAction->"Clip"],*)
(*ImageSize->Automatic]&;*)


(* ::Input:: *)
(*s3q=Show[Graphics3D[{Opacity[0.80],#1},*)
(*FaceGrids->All,*)
(*Axes->True,*)
(*AxesLabel->axesLabel3 ,*)
(*Lighting->"Neutral",*)
(*RotationAction->"Clip"],*)
(*ImageSize->Automatic]&;*)


(* ::Input:: *)
(*s3p[vcube]*)


(* ::Input:: *)
(*s3q[vcube]*)


(* ::Input:: *)
(*vcubePlus=Translate[vcube,a3/2.];*)


(* ::Input:: *)
(*x2pols={Style[{*)
(*Polygon[Reverse[*)
(*{{1,1,0},{2.5,6,0},{3,6,0},{3,4+1/3,0},{2,1,0}}/12.]],Polygon[Reverse[*)
(*{{4,1,0},{3,4+1/3,0},{3,6,0},{3.5,6,0},{5,1,0}}/12.]],Polygon[Reverse[*)
(*{{3,6,0},{2.5,6,0},{1,11,0},{2,11,0},{3,7+2/3,0}}/12.]],*)
(*Polygon[Reverse[*)
(*{{3,6,0},{3,7+2/3,0},{4,11,0},{5,11,0},{3.5,6,0}}/12.]]},*)
(*FaceForm[Black,White]]};*)


(* ::Input:: *)
(*s3p[x2pols]*)


(* ::Input:: *)
(*y2pols={Style[{*)
(*Polygon[Reverse[*)
(*{{2.5,1,0},{2.5,6,0},{3.5,6,0},{3.5,1,0}}/12.]],*)
(*Polygon[Reverse[*)
(*{{3,6,0},{2.5,6,0},{1,11,0},{2,11,0},{3,7+2/3,0}}/12.]],Polygon[Reverse[*)
(*{{3,6,0},{3,7+2/3,0},{4,11,0},{5,11,0},{3.5,6,0}}/12.]]},*)
(*FaceForm[Black,White]]};*)


(* ::Input:: *)
(*s3p[y2pols]*)


(* ::Input:: *)
(*z2pols={Style[{*)
(*Polygon[Reverse[*)
(*{{1,1,0},{1.3,2,0},{5,2,0},{5,1,0}}/12.]],*)
(*Polygon[Reverse[*)
(*{{1.3,2,0},{3.7,10,0},{4.7,10,0},{2.3,2,0}}/12.]],Polygon[Reverse[*)
(*{{1,11,0},{5,11,0},{4.7,10,0},{1,10,0}}/12.]]},*)
(*FaceForm[Black,White]]};*)


(* ::Input:: *)
(*s3p[z2pols]*)


(* ::Input:: *)
(*Rotate3[shape_,phi_,theta_,psi_]:=*)
(*Rotate[Rotate[Rotate[shape,*)
(*Pi-phi,z3],*)
(*theta,x3],*)
(*Pi-psi,z3]*)


(* ::Input:: *)
(*combp=Join[#1,{Translate[#2,{0.5,0,0}]}]&;*)


(* ::Input:: *)
(*xy2p=combp[x2pols,y2pols];*)


(* ::Input:: *)
(*s3p[{x2pols,Translate[y2pols,{0.5,0,0}]}]*)


(* ::Input:: *)
(*yz2p=combp[y2pols,z2pols];*)


(* ::Input:: *)
(*zx2p=combp[z2pols,x2pols];*)


(* ::Input:: *)
(*face2labels=*)
(*Translate[*)
(*{Translate[Rotate3[zx2p,Pi,Pi/2,0], x3],Translate[Rotate3[zx2p,Pi,Pi/2,0],{1,1,0}],Rotate3[yz2p,0,-Pi/2,-Pi/2],Translate[Rotate3[yz2p,0,-Pi/2,-Pi/2],x3],xy2p,Translate[xy2p,z3]},c3[-.5]];*)


(* ::Input:: *)
(*s3p[xy2p]*)


(* ::Subsection:: *)
(*oriented cuboid*)


(* ::Input:: *)
(*wcube=Chop[Join[{Scale[vcube,c3[0.99],o3]},{face2labels}]];*)


(* ::Input:: *)
(*s3p[wcube]*)


(* ::Input:: *)
(*s3q[wcube]*)


(* ::Input:: *)
(*wcubePlus=Translate[wcube,a3/2.];*)


(* ::Input:: *)
(*thing3={Style[{*)
(*Style[Line[{o3,x3}],Red],*)
(*Style[Line[{o3,y3}],Green],*)
(*Style[Line[{o3,z3}],Blue],*)
(*Style[Line[{o3,-x3}],Cyan],*)
(*Style[Line[{o3,-y3}],Magenta],*)
(*Style[Line[{o3,-z3}],Yellow]},*)
(*Thickness[0.010]]};*)


(* ::Text:: *)
(*Discovered that nested lists may push and pop graphical attributes. This style seems to be a viable alternative to calling Style everywhere.*)


(* ::Input:: *)
(*thing4={Thickness[0.010],{*)
(*{Red,Line[{o3,x3}]},*)
(*{Green,Line[{o3,y3}]},*)
(*{Blue,Line[{o3,z3}]},*)
(*{Cyan,Line[{o3,-x3}]},*)
(*{Magenta,Line[{o3,-y3}]},*)
(*{Yellow,Line[{o3,-z3}]}}*)
(*};*)


(* ::Input:: *)
(*xcube=Join[{Scale[thing4,c3[2],o3]},{wcube}];*)


(* ::Input:: *)
(*s3q[xcube]*)


(* ::Input:: *)
(*xcubePlus=Translate[xcube,a3/2.];*)


(* ::Subsubtitle:: *)
(*Canonical Display of a Triangle*)


(* ::Input:: *)
(*canonDpyTriangle[r_]:=*)
(*Module[{f},*)
(*f=frenetFromTriangle[r];*)
(*{Polygon[r],*)
(*Array[Arrow[Tube[{r[[2]],r[[2]]+f[[#]]}]]&,3],*)
(*Style[Point[r[[1]]],Red,PointSize[Large]],*)
(*Style[Point[r[[2]]],Green,PointSize[Large]],*)
(*Style[Point[r[[3]]],Blue,PointSize[Large]]*)
(*}]*)


(* ::Input:: *)
(*Graphics3D[canonDpyTriangle[ranTriangle]]*)


(* ::Text:: *)
(*The frenet frame returned by the above functions is the matrix of direction cosines of the frame vectors with respect to the world frame. Thus, it is the orthogonal rotation matrix of the world frame into the frenet frame. Do a few tests of its orthogonality:*)


(* ::Input:: *)
(*Module[{f=frenetFromTriangle[ranTriangle]},*)
(*{Chop[f.Transpose[f]],*)
(*Det[f]}]*)


(* ::Text:: *)
(*Convert the frenet frame into a twist vector, whose direction is unchanged by the rotation from world-to-frenet, and whose magnitude represents the angle of twist in the right-hand sense.*)


(* ::Text:: *)
(*First, need a test whether a vector (or, just a list of numbers) is real within machine precision. Need this to find the real eignenvector of the frenet matrix.*)


(* ::Input:: *)
(*AllReal[ps_]:=And@@(Chop[Im[#]]==0.&/@ps)*)


(* ::Text:: *)
(*Given a frenet frame, find the real eigenvector, that is, the vector whose direction is unchanged by the rotation:*)


(* ::Text:: *)
(*We observed that when the determinant of the matrix of eigenvectors is +I, the eigenvector flips on its axis, giving us a bogus rotation transform. The following includes is a hack to fix it.*)


(* ::Input:: *)
(*evf[frenet_]:=*)
(*Module[{evs,d,fudge},*)
(*evs=Eigenvectors[frenet];*)
(*d=Chop[Im[Det[evs]]];*)
(*fudge=-d;*)
(*fudge*Select[evs,AllReal][[1]]]*)


(* ::Input:: *)
(*evf[frenetFromTriangle[ranTriangle]]*)


(* ::Text:: *)
(*Twice the cosine of the angle of twist is the trace of the matrix less one (think of ({*)
(* {1, 0, 0},*)
(* {0, cos(\[Theta]), -sin(\[Theta])},*)
(* {0, sin(\[Theta]), cos(\[Theta])}*)
(*})):*)


(* ::Input:: *)
(*ang[frenet_]:=ArcCos[(Tr[frenet]-1)/2.];*)


(* ::Text:: *)
(*Here's a little test function (of no arguments) that will generate a random triangle, locate our test-pattern cuboid on it, and render the mess in a 3D box. The red vector is the eigenvector of the frenet-frame matrix, that is, the vector about which we rotate the test-pattern cuboid from its original orientation to align it with the frenet frame:*)


(* ::Input:: *)
(*Remove[\[Zeta]1]*)


(* ::Input:: *)
(*\[Zeta]1[r_:ranTriangle]:=Module[{f,e,\[Theta],o,rf,sf,tf},*)
(*o=r[[2]];*)
(*f=frenetFromTriangle[r];*)
(*e=evf[f];*)
(*\[Theta]=ang[f];*)
(*sf=ScalingTransform[ConstantArray[1/6.,3]];*)
(*rf=RotationTransform[\[Theta],e];*)
(*Sow[\[Theta]]Sow[e];*)
(*tf=TranslationTransform[o];*)
(*s3p[*)
(*{GeometricTransformation[xcube,Composition[tf,sf,rf]],*)
(*canonDpyTriangle[r],*)
(*Style[Arrow[Tube[{o,o+e}]],Red]*)
(*}]]*)


(* ::Input:: *)
(*\[Zeta]1[]*)


(* ::Text:: *)
(*Here is a "natural" transformation function given a triangle r for placing the test-pattern cuboid on the triangle. We derived this by experimentation with the function above. This transformation places the cuboid at the second (GREEN) point of the triangle, then orients its x axis so that it points halfway between the extention of the p1->p2 leg and the p2->p3 leg of the triangle. The alternative to this orientation would be parallel to the p1->p3 axis, as in \[Zeta]1 above. However, the orientation choice here seems a little more aesthetic. We achieve this orientation choice by first UNDOING the p1->p3 angle implicit in the frenet frame; the undoing is in the term ArcCos[r31.r21] in exang, then DOING the half-angle in the term -ArcCos[r32.r21]/2 in exang.*)


(* ::Input:: *)
(*naturalTf[r_,scaleFactor_:1.0]:=Module[{f,e,\[Theta],rf,sf,tf,r2f,exang,r31,r32,r21},*)
(*f=frenetFromTriangle[r];*)
(*e=evf[f];*)
(*\[Theta]=ang[f];*)
(*sf=ScalingTransform[ConstantArray[scaleFactor,3]];*)
(*rf=RotationTransform[\[Theta],e];*)
(*tf=TranslationTransform[r[[2]]];*)
(*r31=Normalize[r[[3]]-r[[1]]];*)
(*r32=Normalize[r[[3]]-r[[2]]];*)
(*r21=Normalize[r[[2]]-r[[1]]];*)
(*exang=ArcCos[r31.r21]-ArcCos[r32.r21]/2;*)
(*r2f=RotationTransform[exang,y3];*)
(*Composition[tf,sf,rf,r2f]];*)


(* ::Text:: *)
(*Here's a little function for showing any triangle under the "natural" transformation above:*)


(* ::Input:: *)
(*\[Zeta]2[r_,rgx_:1.5,rgy_:1.5,rgz_:1.5]:=Module[{f,e,o},*)
(*o=r[[2]];*)
(*f=frenetFromTriangle[r];*)
(*e=evf[f];*)
(*Graphics3D[*)
(*{GeometricTransformation[xcube,naturalTf[r,1./6]],*)
(*canonDpyTriangle[r],*)
(*Style[Arrow[Tube[{o,o+e}]],Red]},*)
(*FaceGrids->All,*)
(*Axes->True,*)
(*AxesLabel->axesLabel3,*)
(*RotationAction->"Clip",*)
(*PlotRange->{{-rgx,rgx},{-rgy,rgy},{-rgz,rgz}}*)
(*]]*)


(* ::Text:: *)
(*Here is an interactive test:*)


(* ::Input:: *)
(*Module[{t,rt=ranTriangle},*)
(*Manipulate[*)
(*t={{0,0,0},{r Cos[\[Theta]],r Sin[\[Theta]],0},{1,0,z}};*)
(*\[Zeta]2[t],{{r,1},0,2},{{\[Theta],Pi/2},0,4Pi},{{z,0},-1,1}]]*)


(* ::Text:: *)
(*Now plunk down test-pattern cuboids at every vertex of a discretized helix:*)


(* ::Input:: *)
(*Show[\[Zeta]2[#,2,2,4]&/@triangles[helixSample[18]]]*)


(* ::Text:: *)
(*Plunk down random-height bare cuboids at every vertex of a discretized helix:*)


(* ::Input:: *)
(*TfFromMatrix=LinearFractionalTransform;*)


(* ::Input:: *)
(*TfIdentity[dim_]:=TfFromMatrix[IdentityMatrix[dim+1]];*)


(* ::Text:: *)
(*Predefined in MMA *)


(* ::Input:: *)
(*\[Zeta]3[r_,sizing_:TfIdentity[3],thing_:Cuboid[-a3/2.,a3/2]]:=*)
(*Graphics3D[*)
(*{GeometricTransformation[thing,Composition[naturalTf[r],sizing]],Line[r]*)
(*}]*)


(* ::Input:: *)
(*\[Zeta]4[n_]:=Show[*)
(*MapThread[\[Zeta]3 [#1,ScalingTransform[{1,#2,1}],vcube]&, {triangles[helixSample[n]],*)
(*Table[Log[1+3RandomReal[]],{i,1,n-2}]}*)
(*]]*)


(* ::Input:: *)
(*\[Zeta]4[24]*)


(* ::Input:: *)
(*\[Zeta]5[n_]:=Show[*)
(*MapThread[\[Zeta]3 [#1,*)
(*Composition[*)
(*TranslationTransform[{0,-#2/2,0}],*)
(*ScalingTransform[{*)
(*0.65EuclideanDistance[#1[[3]],#1[[1]]],*)
(*#2,0.1}]*)
(*],vcube]&, *)
(*{triangles[helixSample[n]],*)
(*Table[Log[1+7RandomReal[]],{i,1,n-2}]}*)
(*]]*)


(* ::Input:: *)
(*\[Zeta]5[18]*)
