
Class constructor
	This:C1470.routes:=New object:C1471()// list of routes
	This:C1470.errorHandlers:=New object:C1471()// errorcode: route (used for 404 for instance)
	This:C1470.rootFolder:=Folder:C1567(fk resources folder:K87:11;*)// web root folder instead? (do not work with star)
	This:C1470.strict:=False:C215// Enable strict routing. | Disabled by default, “/foo” and “/foo/” are treated the same by the router.
	
	This:C1470.methods:=New collection:C1472()// aggregate methods from routes
	
/* Respond to a GET request with matching path/$1 and return response produced by $2 */
Function get
	C_TEXT:C284($1)// path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod.GET;$1;$2))
	
/* Respond to a POST request with matching path/$1 and return response produced by $2 */
Function post
	C_TEXT:C284($1)// path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod.POST;$1;$2))
	
/* Respond to a GET or POST request with matching path/$1 and return response produced by $2 */
Function getOrPost
	C_TEXT:C284($1)// path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(New collection:C1472(HTTPMethod.GET;HTTPMethod.POST);$1;$2))
	
/* Respond to a DELETE request with matching path/$1 and return response produced by $2 */
Function delete
	C_TEXT:C284($1)// path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod.DELETE;$1;$2))
	
/* Respond to a PUT request with matching path/$1 and return response produced by $2 */
Function put
	C_TEXT:C284($1)// path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod.PUT;$1;$2))
	
/* Respond to a request with matching path/$1 and return response produced by $2 */
Function all
	C_TEXT:C284($1)// path
	C_VARIANT:C1683($2)
	This:C1470.register(cs:C1710._FormulaRoute.new(HTTPMethod.ALL;$1;$2))// XXX maybe not all, limit to ?
	
/*
Register a route
*/
Function register
	C_OBJECT:C1216($1)
	C_OBJECT:C1216($pool)
	$pool:=This:C1470.routes
	C_TEXT:C284($route)
	$route:=$1.path
	If (Position:C15("/";$route)#1)
		$route:="/"+$route
	End if 
	
	C_COLLECTION:C1488($routes)
	If (This:C1470.strict)
		$routes:=Split string:C1554($route;"/")
	Else 
		$routes:=Split string:C1554($route;"/";sk ignore empty strings:K86:1)
	End if 
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
	C_COLLECTION:C1488($methods)
	$methods:=$1.methods
	If ($methods=Null:C1517)
		If (OB Instance of:C1731($1.all;4D:C1709.Function))
			$methods:=HTTPMethod.ALL// XXX maybe do a copy to avoid change
		Else 
			$methods:=New collection:C1472()
			If (OB Instance of:C1731($1.get;4D:C1709.Function))
				$methods.push(HTTPMethod.GET)
			End if 
			If (OB Instance of:C1731($1.post;4D:C1709.Function))
				$methods.push(HTTPMethod.POST)
			End if 
			If (OB Instance of:C1731($1.put;4D:C1709.Function))
				$methods.push(HTTPMethod.PUT)
			End if 
			If (OB Instance of:C1731($1.delete;4D:C1709.Function))
				$methods.push(HTTPMethod.DELETE)
			End if 
			If (OB Instance of:C1731($1.delete;4D:C1709.Function))
				$methods.push(HTTPMethod.PATCH)
			End if 
			If (OB Instance of:C1731($1.head;4D:C1709.Function))
				$methods.push(HTTPMethod.HEAD)
			End if 
			If (OB Instance of:C1731($1.options;4D:C1709.Function))
				$methods.push(HTTPMethod.OPTIONS)
			End if 
		End if 
		
	End if 
	
	For each ($method;$methods)
		$pool["__"+$method+"__"]:=$1
		
		If (This:C1470.methods.indexOf($method)<0)
			This:C1470.methods.push($method)
		End if 
	End for each 
	
/* register rooter with passed path */
Function use
	C_TEXT:C284($1)
	C_OBJECT:C1216($2)
	$2.path:=$1
	This:C1470.register($2)
	
/*
Unregister a route, using object(path, methods) or path
*/
Function unregister
	C_VARIANT:C1683($1)
	C_COLLECTION:C1488($2;$methods)
	C_TEXT:C284($route)
	If (Value type:C1509($1)=Is object:K8:27)
		$route:=$1.path
	Else 
		$route:=String:C10($1)// failed is not convertible
	End if 
	
	If (Position:C15("/";$route)#1)
		$route:="/"+$route
	End if 
	C_COLLECTION:C1488($routes)
	$routes:=Split string:C1554($route;"/")
	
	C_OBJECT:C1216($pool)
	$pool:=This:C1470.routes
	C_TEXT:C284($method;$r)
	For each ($r;$routes) Until ($pool=Null:C1517)
		If (Position:C15(":";$r)=1)
			$r:=":"
		End if 
		
		If ($pool[$r]#Null:C1517)
			$pool:=$pool[$r]
		Else 
			$pool:=Null:C1517// break
		End if 
	End for each 
	
	If ($pool#Null:C1517)
		If (Value type:C1509($1)=Is object:K8:27)
			$methods:=$1.methods
		End if 
		If (Count parameters:C259>1)
			$methods:=$2
		End if 
		If ($methods=Null:C1517)
			$methods:=HTTPMethod.ALL
		End if 
		For each ($method;$methods)
			OB REMOVE:C1226($pool;"__"+$method+"__")
		End for each 
	End if 
	
Function _poolForContext
	C_OBJECT:C1216($0)// root
	C_OBJECT:C1216($1)// context
	
	C_COLLECTION:C1488($paths)
	If (This:C1470.strict)
		$paths:=Split string:C1554($1.path;"/")
	Else 
		$paths:=Split string:C1554($1.path;"/";sk ignore empty strings:K86:1)
	End if 
	C_OBJECT:C1216($pool;$childPool)
	$pool:=This:C1470.routes
	
	C_TEXT:C284($p)
	For each ($p;$paths) Until ($pool=Null:C1517)
		Case of 
			: ($pool[$p]#Null:C1517)
				$pool:=$pool[$p]
			: ($pool[":"]#Null:C1517)// manage var
				$pool:=$pool[":"]
			: (OB Instance of:C1731($pool["__"+$1.method+"__"];cs:C1710.Router))// manage var
				$childPool:=$pool["__"+$1.method+"__"]._poolForContext($1.popClone())// Maybe break here
			Else 
				$pool:=Null:C1517
		End case 
	End for each 
	
	If ($childPool#Null:C1517)
		$pool:=$childPool
	End if 
	
	$0:=$pool
	
/*
find a route according to context object
*/
Function _routeForContext
	C_OBJECT:C1216($0)// root
	C_OBJECT:C1216($1)// context
	C_OBJECT:C1216($pool)
	$pool:=This:C1470._poolForContext($1)
	
	If ($pool#Null:C1517)
		//If ($pool["__"+$1.method+"__"]#Null)
		$0:=$pool["__"+$1.method+"__"]
		//End if
		
	Else 
		$0:=This:C1470.errorHandlers["404"]// if no route, 404 handler if defined
	End if 
	
/*
Function errorHandler
C_LONGINT($1)
C_VARIANT($2)
	
If(Value type($2)=Is object)
	
If(OB Instance of($2;4D.Function))
This.errorHandlers[String($1)]:=cs._FormulaRoute.new(HTTPMethod .ALL;$2)
Else 
This.errorHandlers[String($1)]:=cs._FormulaRoute.new(HTTPMethod .ALL;$1;$2)
End if
Else 
	
End if */
	
/*
Handle the request data. same parameters as on web connexion
*/
Function handle
	C_BOOLEAN:C305($0)
	C_TEXT:C284($1;$2;$3;$4;$5;$6)
	
	C_OBJECT:C1216($context)
	$context:=cs:C1710.Request.new($1;$2;$3;$4;$5;$6)
	$0:=This:C1470._handleContext($context)
	
Function _handleContext
	C_BOOLEAN:C305($0;$handled)
	C_OBJECT:C1216($1;$context)
	$handled:=False:C215
	$context:=$1
	C_OBJECT:C1216($route)
	$route:=This:C1470._routeForContext($context)
	
	If ($route#Null:C1517)
		$context.params:=This:C1470._extractParams($context.path;$route.path)//OPTI: do it only if there is var in root
		$context.route:=$route
		$context.router:=This:C1470
		C_VARIANT:C1683($response)
		If ($route.respond=Null:C1517)
			If ($route[Lowercase:C14($context.method)]#Null:C1517)
				$response:=$route[Lowercase:C14($context.method)]($context;cs:C1710.Response.new())
			End if 
		Else 
			$response:=$route.respond($context;cs:C1710.Response.new())
		End if 
		
		Case of 
			: (Value type:C1509($response)#Is object:K8:27)
				$response:=cs:C1710.Response.new($response)
			: (Not:C34(OB Instance of:C1731($response;cs:C1710.Response)))
				$response:=cs:C1710.Response.new($response)
		End case 
		
		// ASSERT(OB Instance of($response;cs.Response))
		$response.context:=$context
		$response.doSend()
		
		$handled:=True:C214
	End if 
	
	$0:=$handled
	
/*
private: extract parameters from two path
*/
Function _extractParams
	C_OBJECT:C1216($0;$result)
	C_TEXT:C284($1;$2;$el)
	C_COLLECTION:C1488($t1;$t2)
	$t1:=Split string:C1554($1;"/";sk ignore empty strings:K86:1)
	$t2:=Split string:C1554($2;"/";sk ignore empty strings:K86:1)
	If ($t1.length>$t2.length)
		// maybe sub rooter, inject missing path (maybe better its to receive a parameter to check or make extract in sub rooter)
		While ($t1.length#$t2.length)
			$t2.insert(0;"")
		End while 
	End if 
	
	$result:=New object:C1471()
	
	C_LONGINT:C283($i)
	$i:=0
	For each ($el;$t2)
		If (Position:C15(":";$el)=1)
			$result[Substring:C12($el;2)]:=$t1[$i]//TODO decodeURIComponent for extracted parameters
		End if 
		$i:=$i+1
	End for each 
	
	$0:=$result
	
Function respond
	C_VARIANT:C1683($0;$response)
	C_OBJECT:C1216($1)
	
	$0:=This:C1470._handleContext($1.popClone())
	
Function restClientHTTP
	C_TEXT:C284($0;$result)
	C_OBJECT:C1216($1;$context)
	$context:=$1
	
	$result:="@hostname="+$context.server.ip+"\n"\
		+"@port="+String:C10($context.port())+"\n"\
		+"@baseURL="+$context.protocol()+"://{{hostname}}:{{port}}\n\n"
	
	C_TEXT:C284($path)
	For each ($path;This:C1470.routes)
		$result:=$result+This:C1470._restClientHTTPR(This:C1470.routes[$path])+"\n"
	End for each 
	$0:=$result
	
Function _restClientHTTPR
	C_OBJECT:C1216($1;$route)
	C_TEXT:C284($0;$result)
	$result:=""
	$route:=$1
	If ($route.methods#Null:C1517)
		C_TEXT:C284($method)
		For each ($method;$route.methods)
			$result:=$result+"###\n"
			$result:=$result+$method+" {{baseURL}}"+$route.path+"\n"
		End for each 
	Else 
		C_BOOLEAN:C305($done)
		$done:=False:C215
		C_TEXT:C284($path)
		For each ($path;$route) Until ($done)
			$result:=$result+This:C1470._restClientHTTPR($route[$path])
			$done:=Position:C15("__";$path)=1// if indexed by method do only one times, les .methods do the job?
		End for each 
	End if 
	$0:=$result