(* Mathematica Raw Program *)

BeginPackage["XmlProcessing`", {"MiniData`"}];

	matchDoc::usage = "matchDoc[XMLObject[\"Document\"][decl, elt, unk]] returns an association-list representation of a matching XML Document, else False."
	matchDecl::usage = "matchDecl[XMLObject[\"Declaration\"][version_, encoding_]] returns an association-list representation of a matching XML Declaration, else False."
	matchElt::usage = "matchElt[XMLElement[tag_, attrs_, content_]] returns an association-list representation of a matching XML Element, else False."

	getDocRootEltAList::usage = "getDocRootEltAList[XMLObject] gets an association-list representation of an XML Document."
	getEltALists::usage = "getEltALists[tag, XMLObject] gets a flattened list of association-list representations of all elements matching the given tag."

	Begin["`Private`"]
	
		matchDoc[XMLObject["Document"][decl_, elt_, unk_]] := 
			{{"elt", elt}, {"decl", decl}, {"unk", unk}} ;
		matchDoc[_] := False;
		
		matchDecl[XMLObject["Declaration"][version_, encoding_]] := 
			{{"version", version}, {"encoding", encoding}};
		matchDecl[_] := False;
		
		matchElt[XMLElement[tag_, attrs_, content_]] := 
			{{"tag", tag}, {"content", content}, {"attrs", attrs}};
		matchElt[_] := False;
	
		getEltsHelper[tagh_, objh_] := 
			Module[{elt = matchElt[objh], submatches},
				If[elt =!= False,
					submatches = Flatten[
						Select[ (* filter out empty lists returned by lookup *)
							Select[ (* filter out non-elements *)
								getEltsHelper[tagh, #] & /@ lookup[elt, "content"],
								# =!= False &],
							# =!= {} &],
						1];
					If[lookup[elt, "tag"] === tagh,
						Join[{elt}, submatches],
						submatches],
					{}]]
		
		getEltALists[tag_, obj_] := getEltsHelper[tag, obj]
		
		getDocRootEltAList[obj_] := Module[{doc = matchDoc[obj]},
		   If[doc =!= False,
		    lookup[doc, "elt"],
		    False]];
	    
	End[]

EndPackage[];