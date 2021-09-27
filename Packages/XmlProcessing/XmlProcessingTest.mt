(* Mathematica Test File *)

x = XMLObject["Document"][
 {XMLObject["Declaration"]["Version" -> "1.0", "Encoding" -> "iso-8859-1"]}, 
 XMLElement["feed", {}, 
  {XMLElement["lipsum", {}, {"Lorem ipsum \
dolor sit amet, consectetur adipiscing elit. \
Donec id condimentum ipsum. Sed nec purus \
augue. Ut in neque vestibulum est fringilla \
tincidunt nec sit amet elit. Aliquam \
porttitor odio tempor enim viverra nec mattis \
elit rutrum. Phasellus vehicula iaculis \
tincidunt. Maecenas vitae magna nisi. In hac \
habitasse platea dictumst. Ut aliquam euismod \
mauris quis auctor. Proin diam risus, laoreet \
vel blandit sit amet, tempus ac magna."}], 
   XMLElement["generated", {}, 
    {"Generated 1 paragraph, 67 words, 441 bytes of Lorem Ipsum"}], 
   XMLElement["donatelink", {}, 
    {"http://www.lipsum.com/donate"}], 
   XMLElement["creditlink", {}, 
    {"http://www.lipsum.com/"}], 
   XMLElement["creditname", {}, 
    {"James Wilson"}]}], {}];

Test[
	getEltALists["creditlink", getDocRootEltAList[x]]
	,
	{{{"tag", "creditlink"}, 
	  {"content", {"http://www.lipsum.com/"}}, 
      {"attrs", {}}
    }}
	,
	TestID->"XmlProcessingTest-20111218-X5S7I5"
]

y = XMLObject["Document"][
 {XMLObject["Declaration"]["Version" -> "1.0", "Encoding" -> "UTF-8"]}, 
 XMLElement["table", 
  {{"http://www.w3.org/2000/xmlns/", 
     "xmlns"} -> "http://query.yahooapis.com/\
v1/schema/table.xsd", "https" -> "false"}, 
  {XMLElement["meta", {}, 
    {XMLElement["author", {}, 
      {"Brian Cantoni"}], XMLElement[
      "description", {}, {"Generate random \
Lorem Ipsum text from lipsum.com. Parameters: \
amount=number of things to fetch; what: \
paras, words, bytes, or lists; start: set to \
\"no\" to not start all strings with Lorem \
Ipsum."}], XMLElement["documentationURL", {}, 
      {"http://www.lipsum.com/"}], 
     XMLElement["sampleQuery", {}, 
      {"select * from {table} where \
amount='5' and what='paras';"}]}], 
   XMLElement["bindings", {}, 
    {XMLElement["select", {"itemPath" -> "", 
       "produces" -> "XML"}, 
      {XMLElement["urls", {}, 
        {XMLElement["url", {}, {}]}], 
       XMLElement["inputs", {}, 
        {XMLElement["key", {"id" -> "amount", 
           "type" -> "xs:string", 
           "paramType" -> "query"}, {}], 
         XMLElement["key", {"id" -> "what", 
           "type" -> "xs:string", 
           "paramType" -> "query"}, {}], 
         XMLElement["key", {"id" -> "start", 
           "type" -> "xs:string", 
           "paramType" -> "query", 
           "default" -> "yes"}, {}]}], 
       XMLElement["execute", {}, 
        {"var q = y.query('select * from html \
where \
url=\"http://www.lipsum.com/feed/http?amount=\
' + amount + '&what=' + what + '&start=' + \
start + '\" and \
xpath=\\'//div[@id=\"lipsum\"]//p\\''); if \
(q.results) { response.object = q.results; }"}\
]}]}]}], {}]

Test[
	lookup[matchDoc[x], "decl"][[1]] // matchDecl
	,
	{{"version", "Version" -> "1.0"}, 
     {"encoding", "Encoding" -> "iso-8859-1"}}
	,
	TestID->"XmlProcessingTest-20111218-S2V6R2"
]

Test[
	getEltALists["key", getDocRootEltAList@y]
	,
	{{{"tag", "key"}, {"content", {}}, 
      {"attrs", {"id" -> "amount", 
                 "type" -> "xs:string", 
                 "paramType" -> "query"}}}, 
     {{"tag", "key"}, {"content", {}}, 
      {"attrs", {"id" -> "what", 
      	         "type" -> "xs:string", 
                 "paramType" -> "query"}}}, 
     {{"tag", "key"}, {"content", {}}, 
      {"attrs", {"id" -> "start", 
    	         "type" -> "xs:string", 
    	         "paramType" -> "query", "default" -> "yes"}}
     }}
	,
	TestID->"XmlProcessingTest-20111218-Z4I5X1"
]

z = XMLObject["Document"][
  {XMLObject["Declaration"][
    "Version" -> "1.0",
    "Encoding" -> "utf-8"]},
  XMLElement[
  	"feed", 
  	{}, 
  	{
		XMLElement[
			"sub", 
			{}, 
			{
				XMLElement["sub", {}, {"L2 contents"}],
				"L1 contents"
			}],
  		"feed contents"
  	}],
  {XMLObject["Comment"]["foo comment"], 
   XMLObject["Comment"]["bar comment"], 
   XMLObject["ProcessingInstruction"]["qux Processing Instruction"]}];
  
  Test[
	ExportString[z,"XML"]
	,
	"<?xml version='1.0' encoding='utf-8'?>\r\n\
<feed><sub><sub>L2 contents</sub>L1 contents</sub>feed contents</feed>\r\n\
<!--foo comment-->\r\n\
<!--bar comment-->\r\n\
<?qux Processing Instruction?>\r\n"
	,
	TestID->"XmlProcessingTest-20111218-G6R2H9"
]

Test[
	getEltALists["sub", getDocRootEltAList[z]]
	,	
	{{{"tag", "sub"}, 
      {"content", {XMLElement["sub", {}, {"L2 contents"}], "L1 contents"}}, 
	  {"attrs", {}}}, 
     {{"tag", "sub"}, 
      {"content", {"L2 contents"}}, 
      {"attrs", {}}}}
	,
	TestID->"XmlProcessingTest-20111218-J5J7W1"
]

Test[
	getDocRootEltAList[{}]
	,	
	False
	,
	TestID->"XmlProcessingTest-20111218-G5O2D1"
]

Test[
	getEltALists["foo", getDocRootEltAList[x]]
	,
	{}
	,
	TestID->"XmlProcessingTest-20111218-T0S3T5"
]