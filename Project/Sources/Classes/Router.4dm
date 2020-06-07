
Class constructor
	This:C1470.routes:=New object:C1471()
	
Function get
	C_TEXT:C284($1)  // path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .GET;$1;$2))
	
Function post
	C_TEXT:C284($1)  // path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .POST;$1;$2))
	
Function getOrPost
	C_TEXT:C284($1)  // path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(New collection:C1472(HTTPMethod .GET;HTTPMethod .POST);$1;$2))
	
Function delete
	C_TEXT:C284($1)  // path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .DELETE;$1;$2))
	
Function put
	C_TEXT:C284($1)  // path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .PUT;$1;$2))
	
Function all
	C_TEXT:C284($1)  // path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod .ALL;$1;$2))
	
Function register
	C_OBJECT:C1216($1)
	C_OBJECT:C1216($pool)
	$pool:=This:C1470.routes
	C_TEXT:C284($route)
	$route:=$1.path
	If (Position:C15("/";$1.path)#1)
		$route:="/"+$route
	End if 
	
	C_COLLECTION:C1488($routes)
	$routes:=Split string:C1554($route;"/")
	C_TEXT:C284($method;$r)
	
	For each ($r;$routes)
		If (Position:C15(":";$r)=1)
			$r:=":"
		End if 
		If ($pool[$r]=Null:C1517)
			$pool[$r]:=New object:C1471()
		End if 
		$pool:=$pool[$r]
	End for each 
	
	For each ($method;$1.methods)
		$pool["__"+$method+"__"]:=$1
	End for each 
	
	
Function _routeForContext
	C_OBJECT:C1216($0)  // root
	C_OBJECT:C1216($1)  // context
	
	C_COLLECTION:C1488($paths)
	$paths:=Split string:C1554($1.path;"/")
	
	C_OBJECT:C1216($pool)
	$pool:=This:C1470.routes
	
	C_TEXT:C284($p)
	For each ($p;$paths) Until ($pool=Null:C1517)
		Case of 
			: ($pool[$p]#Null:C1517)
				$pool:=$pool[$p]
			: ($pool[":"]#Null:C1517)  // manage var
				$pool:=$pool[":"]
			Else 
				$pool:=Null:C1517
		End case 
	End for each 
	
	If ($pool#Null:C1517)
		  //If ($pool["__"+$1.method+"__"]#Null)
		$0:=$pool["__"+$1.method+"__"]
		  //End if
	End if 
	
Function handle
	C_BOOLEAN:C305($0;$handled)
	C_TEXT:C284($1;$2;$3;$4;$5;$6)
	
	C_OBJECT:C1216($context)
	$context:=cs:C1710.Context.new($1;$2;$3;$4;$5;$6)
	
	$handled:=False:C215
	C_OBJECT:C1216($route)
	$route:=This:C1470._routeForContext($context)
	If ($route#Null:C1517)
		$context.params:=This:C1470._extractParams($context.path;$route.path)  //OPTI: do it only if there is var in root
		
		C_VARIANT:C1683($response)
		$response:=$route.respond($context)
		
		Case of 
			: (Value type:C1509($response)#Is object:K8:27)
				$response:=cs:C1710.Response.new($response)
			: (Not:C34(OB Instance of:C1731($response;cs:C1710.Response)))
				$response:=cs:C1710.Response.new($response)
		End case 
		
		  // ASSERT(OB Instance of($response;cs.Response))
		$response.send()
		
		$handled:=True:C214
	End if 
	
	$0:=$handled
	
Function _extractParams
	C_OBJECT:C1216($0;$result)
	C_TEXT:C284($1;$2;$el)
	C_COLLECTION:C1488($t1;$t2)
	$t1:=Split string:C1554($1;"/")
	$t2:=Split string:C1554($2;"/")
	
	$result:=New object:C1471()
	
	C_LONGINT:C283($i)
	$i:=0
	For each ($el;$t2)
		If (Position:C15(":";$el)=1)
			$result[Substring:C12($el;2)]:=$t1[$i]  //TODO decodeURIComponent for extracted parameters
		End if 
		$i:=$i+1
	End for each 
	
	$0:=$result
	