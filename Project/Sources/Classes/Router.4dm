
Class constructor
	This:C1470.routes:=New collection:C1472()  // create a better structure with fast search by indexing by path+method?
	
Function get
	C_TEXT:C284($1)  // path
	C_OBJECT:C1216($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .GET;$1;$2))
	
Function post
	C_TEXT:C284($1)  // path
	C_OBJECT:C1216($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .POST;$1;$2))
	
Function getOrPost
	C_TEXT:C284($1)  // path
	C_OBJECT:C1216($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(New collection:C1472(HTTPMethod .GET;HTTPMethod .POST);$1;$2))
	
Function delete
	C_TEXT:C284($1)  // path
	C_OBJECT:C1216($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .DELETE;$1;$2))
	
Function put
	C_TEXT:C284($1)  // path
	C_OBJECT:C1216($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .PUT;$1;$2))
	
Function all
	C_TEXT:C284($1)  // path
	C_OBJECT:C1216($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .ALL;$1;$2))
	
Function register
	C_OBJECT:C1216($1)
	This:C1470.routes.push($1)
	
Function handle
	C_BOOLEAN:C305($0;$handled)
	C_TEXT:C284($1;$2;$3;$4;$5;$6)
	
	C_OBJECT:C1216($context)
	$context:=cs:C1710.Context.new($1;$2;$3;$4;$5;$6)
	
	$handled:=False:C215
	C_OBJECT:C1216($roote)
	$roote:=This:C1470._rootFor($context)
	If ($roote#Null:C1517)
		$roote.respond($context)
		$handled:=True:C214
	End if 
	
	$0:=$handled
	
Function _rootFor
	C_OBJECT:C1216($1)  // context
	