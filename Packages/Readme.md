```mathematica
IndexOfMaxs::usage = "IndexOfMaxs[<list>,<transformFn>] --> <integerIndex>";
IndexOfMins::usage = "IndexOfMins[<list>,<transformFn>] --> <integerIndex>";

IndexMaxs::usage = "IndexMaxs[<list>,<transformFn>] --> {<integerIndex>,<MaxValue>}";
IndexMins::usage = "IndexMins[<list>,<transformFn>] --> {<integerIndex>,<MinValue>}";

isAl::usage = "isAl[<object>] --> <bool> or non-reduce";
isAv::usage = "isAv[<object>] --> <bool> or non-reduce";

al2Av::usage = "al2Av[<aList>] --> <aVec>";
av2Al::usage = "av2Al[<aVec>] --> <aList>";

lookup::usage = "lookup[<alist|aVec>,<key>] --> <value>, <avec>[<key>] --> <value>";
lookupWithDefault::usage = "lookupWithDefault[<alist|aVec>,<key>,<default>] --> <value> or <default>";

containsKey::usage = "containsKey[<aList|aVec>,<key>] --> <bool>";
removeKey::usage = "removeKey[<aList|aVec>,<key>] --> <aList> or <aVec>";

fetchAttribute::usage = "fetchAttribute[<aList|aVec>,<key> --> {<key>,<value>}";

adjoin::usage = "adjoin[<aList|aVec>,<key>,<value>] --> <aList|aVec>; adjoin[<aList1|aVec1>,<aList|aVec>] --> <aList|aVec>";

getSchema::usage = "getSchema[<aList|aVec>] --> {<key>, ...}";

schemaAndRecord2Al::usage = "schemaAndRecord2Al[<schema>,<record>] --> <aList>";
schemaAndRecord2Av::usage = "schemaAndRecord2Av[<schema>,<record>] --> <aVec>";

equalAvs::usage = "equalAvs[<aVec>,<aVec>] --> bool";

copyAv::usage = "copyAv[<aVec>] --> <aVec>";

sieve::usage = "sieve[<aList|aVec>,<keyList>] --> {<aVec(matchingKeys)>,<aVec(notMatchingKeys)>}";
```