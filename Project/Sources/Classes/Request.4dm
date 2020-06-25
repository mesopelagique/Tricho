Class extends Context

Class constructor
	C_TEXT:C284($1;$2;$3;$4;$5;$6)
	Super:C1705($1;$2;$3;$4;$5;$6)
	
/*
Return the web variables as object.
See WEB GET VARIABLES.
*/
Function variables
	C_OBJECT:C1216($0)
	$0:=WebGetVariables
	
/*
Return the http headers variables as object.
See WEB GET HTTP HEADER.
*/
Function headers
	// alt: parse raw http if defined?
	C_OBJECT:C1216($0)
	If (This:C1470._headers=Null:C1517)
		This:C1470._headers:=WebGetHTTPHeaders
	End if 
	$0:=This:C1470._headers
	
/* check if has a specific header */
Function hasHeader
	C_TEXT:C284($1)
	C_BOOLEAN:C305($0)
	C_OBJECT:C1216($headers)
	$headers:=This:C1470.headers()
	$0:=($headers[$1]#Null:C1517) | ($headers[Lowercase:C14($1)]#Null:C1517)  // 4D seems to change case of headers....
	
/* get a specific header value */
Function header
	C_TEXT:C284($1;$2)
	C_VARIANT:C1683($0)
	C_OBJECT:C1216($headers)
	$headers:=This:C1470.headers()
	$0:=$headers[$1]
	Case of 
		: ($0=Null:C1517)  // must not occur if string?
			$0:=$headers[Lowercase:C14($1)]
		: (Length:C16($0)=0)
			$0:=$headers[Lowercase:C14($1)]
	End case 
	
/* Extract user and password from auth header */
Function authBasic
	// from header, could be found also in basicAuth var from context parsd by 4d
	C_OBJECT:C1216($0)
	$0:=New object:C1471("success";False:C215)
	
	C_TEXT:C284($header)
	$header:=This:C1470.header("Authorization")
	
	C_LONGINT:C283($pos)
	$pos:=Position:C15("Basic ";$header)
	If ($pos=1)
		$header:=Substring:C12($header;$pos+6)
		
		C_BLOB:C604($tmpBlob)
		BASE64 DECODE:C896($header;$tmpBlob)
		$header:=BLOB to text:C555($tmpBlob;UTF8 C string:K22:15)
		
		$pos:=Position:C15(":";$header)
		If ($pos>0)
			$0.success:=True:C214
			$0.username:=Substring:C12($header;1;$pos-1)
			$0.password:=Substring:C12($header;$pos+1)
			
		Else 
			
			$0.error:="Not a valid basic auth"
			
		End if 
	Else 
		
		$0.error:="Not a basic auth"
		
	End if 
	
/* Extract token from auth header */
Function authBearer
	C_OBJECT:C1216($0)
	$0:=New object:C1471("success";False:C215)
	
	C_TEXT:C284($header)
	$header:=This:C1470.header("Authorization")
	
	C_LONGINT:C283($pos)
	$pos:=Position:C15("Bearer ";$header)
	If ($pos=1)
		
		$0.token:=Substring:C12($header;$pos+7)
		$0.success:=Length:C16($0.token)>0
	Else 
		$pos:=Position:C15("Token ";$header)
		If ($pos=1)
			$0.token:=Substring:C12($header;$pos+6)
			$0.success:=Length:C16($0.token)>0
		End if 
		
	End if 
	
	// Checks if the specified content types are acceptable, based on the request’s Accept HTTP header field. The method
Function _accepts
	C_BOOLEAN:C305($0)
	$0:=True:C214  // TODO
	
/* Return the body text of the request */
Function bodyText
	C_TEXT:C284($0;$request)
	WEB GET HTTP BODY:C814($request)
	$0:=$request
	
/* If JSON return an object for the body */
Function bodyObject
	C_OBJECT:C1216($0)
	C_TEXT:C284($request)
	WEB GET HTTP BODY:C814($request)
	$0:=JSON Parse:C1218($request)
	
/* return the body as data */
Function bodyData
	C_BLOB:C604($0;$request)
	WEB GET HTTP BODY:C814($request)
	$0:=$request
	
Function bodyPart
	C_COLLECTION:C1488($0)
	C_TEXT:C284($vPartName;$vPartMimeType;$vPartFileName;$vDestinationFolder)
	C_BLOB:C604($vPartContentBlob)
	C_LONGINT:C283($cpt)
	$0:=New collection:C1472()
	For ($cpt;1;WEB Get body part count:C1211)  //for each part
		WEB GET BODY PART:C1212($cpt;$vPartContentBlob;$vPartName;$vPartMimeType;$vPartFileName)
		$0.push(New object:C1471("name";$vPartName;"content";$vPartContentBlob;"mimeType";$vPartMimeType;"filename";$vPartFileName))
	End for 
	
Function bodyTextPart
	C_COLLECTION:C1488($0)
	C_TEXT:C284($vPartName;$vPartMimeType;$vPartFileName;$vDestinationFolder;$vPartContentText)
	C_LONGINT:C283($cpt)
	$0:=New collection:C1472()
	For ($cpt;1;WEB Get body part count:C1211)  //for each part
		WEB GET BODY PART:C1212($cpt;$vPartContentText;$vPartName;$vPartMimeType;$vPartFileName)
		$0.push(New object:C1471("name";$vPartName;"content";$vPartContentText;"mimeType";$vPartMimeType;"filename";$vPartFileName))
	End for 
	
Function bodyPartCount
	C_LONGINT:C283($0)
	$0:=WEB Get body part count:C1211
	
Function serverInfo
	C_OBJECT:C1216($0)
	$0:=WEB Get server info:C1531
	
Function sessionID
	C_TEXT:C284($0)
	$0:=WEB Get current session ID:C1162
	
/* is secure connection ? */
Function secure
	C_BOOLEAN:C305($0)
	$0:=WEB Is secured connection:C698
	
/* http procotol used */
Function protocol
	C_TEXT:C284($0)
	$0:=Choose:C955(This:C1470.secure();"https";"http")
	
/* the port used */
Function port
	C_LONGINT:C283($0)
	C_OBJECT:C1216($info)
	$info:=WEB Get server info:C1531
	$0:=Choose:C955(This:C1470.secure();$info.options.webHTTPSPortID;$info.options.webPortID)
	
/* ajax request ? */
Function xhr
	C_BOOLEAN:C305($0)
	$0:=This:C1470.hasHeader("X-Requested-With")
	
Function popClone
	C_OBJECT:C1216($0)
	C_TEXT:C284($path)
	$path:=This:C1470.relativeReference
	C_LONGINT:C283($pos)
	$pos:=Position:C15("/";$path;2)
	If ($pos>1)
		$path:=Substring:C12($path;$pos)  // remove first path element
	Else 
		$path:="/"
	End if 
	
	$0:=cs:C1710.Request.new($path;This:C1470.rawHTTP;This:C1470.client.ip;This:C1470.server.ip;This:C1470.basicAuth.username;This:C1470.basicAuth.password)