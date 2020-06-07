Class constructor
	C_TEXT:C284($1;$2;$3;$4;$5;$6)
	This:C1470.path:=$1
	This:C1470.rawHTTP:=$2
	This:C1470.client:=New object:C1471("ip";$3)
	This:C1470.server:=New object:C1471("ip";$4)
	This:C1470.basicAuth:=New object:C1471("username";$5;"password";$6)
	
	If (Position:C15(" ";This:C1470.rawHTTP)>0)
		This:C1470.method:=Substring:C12(This:C1470.rawHTTP;1;Position:C15(" ";This:C1470.rawHTTP)-1)
	Else 
		This:C1470.method:=This:C1470.rawHTTP
	End if 
	
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
	$0:=WebGetHeaders 
	
Function bodyText
	C_TEXT:C284($0;$request)
	WEB GET HTTP BODY:C814($request)
	$0:=$request
	
Function bodyObject
	C_OBJECT:C1216($0)
	C_TEXT:C284($request)
	WEB GET HTTP BODY:C814($request)
	$0:=JSON Parse:C1218($request)
	
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
	
Function isSSLorTLS
	C_BOOLEAN:C305($0)
	$0:=WEB Is secured connection:C698
	