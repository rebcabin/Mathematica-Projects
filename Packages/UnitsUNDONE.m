(* ::Package:: *)

(* ::Section:: *)
(*PREP*)


(* ::Input:: *)
(*ClearAll[meter,kilogram,second,ampere,kelvin,candela,mole]*)


(* ::Input:: *)
(*ClearAll[inch,foot,yard,mile,furlong,micron,statuteMile,nauticalMile,parsec,lightYear,astronomicalUnit]*)


(* ::Input:: *)
(*ClearAll[mileRules,meterRules,lengthRules,areaRules,dryVolumeRules,liquidVolumeRules,invertRule,pluckInverseRule,extractSecondaryUnits]*)


(* ::Text:: *)
(*rational numbers represent exact conversions*)


(* ::Section:: *)
(*LENGTH*)


(* ::Input:: *)
(*meterRules={*)
(*inch->254meter/10000,*)
(*foot->3048meter/10000,*)
(*yard->9144meter/10000,*)
(*mile->1609344meter/1000,*)
(*micron->meter/1000000,*)
(*nauticalmile->1852meter,*)
(*parsec->3.08567782 10^15 meter,*)
(*lightYear->9.4607304724808 10^15 meter,*)
(*astronomicalUnit->1.49597871464 10^11 meter*)
(*};*)
(*mileRules={*)
(*statuteMile->mile,*)
(*furlong->mile/8*)
(*}/.meterRules;*)
(*lengthRules=meterRules~Join~mileRules*)


(* ::Section:: *)
(*AREA*)


(* ::Text:: *)
(*TODO: hectare, acre*)


(* ::Section:: *)
(*DRY VOLUME*)


(* ::Input:: *)
(*ClearAll[peck,bushel,dryGallon,dryQuart,dryPint,liter,dryVolumeRules]*)


(* ::Input:: *)
(*dryVolumeRules={*)
(*peck->bushel/4,*)
(*dryGallon->bushel/8,*)
(*dryQuart->dryGallon/4,*)
(*dryPint->dryQuart/2,*)
(*bushel->2140.42inch^3,*)
(*liter->meter^3/1000}*)


(* ::Input:: *)
(*14dryPint//.dryVolumeRules/.lengthRules*)


(* ::Text:: *)
(*TODO: Invert these*)


(* ::Section:: *)
(*LIQUID VOLUME*)


(* ::Input:: *)
(*ClearAll[minim,fluidDram,fluidOunce,gill,liquidPint,liquidQuart,gallon,measure,milliliter,teaspoon,tablespoon,liquidVolumeRules]*)


(* ::Input:: *)
(*liquidVolumeRules = {*)
(*minim->fluidOunce/480,*)
(*fluidDram->fluidOunce/8,*)
(*fluidOunce->gallon/128,*)
(*gill->4fluidOunce,*)
(*liquidPint->gallon/8,*)
(*liquidQuard->gallon/4,*)
(*gallon->231inch^3,*)
(*milliliter->meter^3/1000000,*)
(*teaspoon->fluidOunce/6,*)
(*tablespoon->fluidOunce/2*)
(*};*)


(* ::Input:: *)
(*27teaspoon//.liquidVolumeRules/.lengthRules//N*)


(* ::Text:: *)
(*TODO: invert these*)


(* ::Text:: *)
(*TODO: include cups*)


(* ::Section:: *)
(*UTILITIES*)


(* ::Subsection:: *)
(*extractSecondaryUnits[ rules ]*)


(* ::Input:: *)
(*extractSecondaryUnits[rules_]:=#[[1]]&/@rules*)


(* ::Input:: *)
(*extractSecondaryUnits[lengthRules]*)


(* ::Subsection:: *)
(*invertRule[ unit, rule ]*)


(* ::Input:: *)
(*invertRule[unit_,rule_]:=Solve[Equal@@Reverse@rule,unit][[1,1]]*)


(* ::Input:: *)
(*invertRule[meter,#]&/@lengthRules*)


(* ::Subsection:: *)
(*pluckInverseRule[ primaryUnit, secondaryUnit, rules ]*)


(* ::Input:: *)
(*pluckInverseRule[primaryUnit_,secondaryUnit_,rules_]:=*)
(*Cases[*)
(*invertRule[primaryUnit,#]&/@rules,*)
(*it:(primaryUnit->Times[_,secondaryUnit])->it][[1]]*)


(* ::Input:: *)
(*pluckInverseRule[meter,inch,lengthRules]*)


(* ::Input:: *)
(*pluckInverseRule[meter,#,lengthRules]&/@extractSecondaryUnits[lengthRules]*)


(* ::Input:: *)
(*42000inch^2/.lengthRules*)


(* ::Input:: *)
(*42meter^2/.pluckInverseRule[meter,inch,lengthRules]//N*)
