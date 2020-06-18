
Class constructor
	C_VARIANT:C1683($1)
	C_LONGINT:C283($2)
	C_OBJECT:C1216($3)
	This:C1470.response:=$1
	This:C1470.code:=$2
	This:C1470.headers:=$3
	
Function doSend
	  // Manage headers (and code)
	If (This:C1470.headers=Null:C1517)
		This:C1470.headers:=New object:C1471()
	End if 
	
	C_COLLECTION:C1488($headerEntries)
	$headerEntries:=OB Entries:C1720(This:C1470.headers)
	
	If (This:C1470.code#Null:C1517)
		If (This:C1470.code>0)
			$headerEntries.push(New object:C1471("key";"X-STATUS";"value";String:C10(This:C1470.code)))
		End if 
	End if 
	
	If (This:C1470.headers["Content-type"]=Null:C1517)
		Case of 
			: (Value type:C1509(This:C1470.response)=Is object:K8:27)
				Case of 
					: (OB Instance of:C1731(This:C1470.response;cs:C1710.Response))
					: (OB Instance of:C1731(This:C1470.response;4D:C1709.File))
					Else 
						$headerEntries.push(New object:C1471("key";"Content-type";"value";"application/json"))
				End case 
			: (Value type:C1509(This:C1470.response)=Is collection:K8:32)
				$headerEntries.push(New object:C1471("key";"Content-type";"value";"application/json"))
		End case 
	End if 
	
	If ($headerEntries.length>0)
		ARRAY TEXT:C222($headerFields;$headerEntries.length)
		ARRAY TEXT:C222($headerValues;$headerEntries.length)
		C_LONGINT:C283($cpt)
		$cpt:=1
		C_OBJECT:C1216($headerEntry)
		For each ($headerEntry;$headerEntries)
			$headerFields{$cpt}:=$headerEntry.key
			$headerValues{$cpt}:=$headerEntry.value
			$cpt:=$cpt+1
		End for each 
		WEB SET HTTP HEADER:C660($headerFields;$headerValues)
	End if 
	
	  // send data
	Case of 
		: (Value type:C1509(This:C1470.response)=Is text:K8:3)
			WEB SEND TEXT:C677(This:C1470.response)
		: (Value type:C1509(This:C1470.response)=Is object:K8:27)
			Case of 
				: (OB Instance of:C1731(This:C1470.response;cs:C1710.Response))
					This:C1470.response.doSend()  // reponse in reponse
				: (OB Instance of:C1731(This:C1470.response;4D:C1709.File))
					WebSendFile (This:C1470.response)
/*: (OB Instance of(This.response;4D.Folder))
WebSendFolderIndex(This.response)*/
				Else 
					WebSendObject (This:C1470.response)
			End case 
		: (Value type:C1509(This:C1470.response)=Is collection:K8:32)
			WebSendObject (This:C1470.response)
		Else 
			  // TODO ERROR 404 ? if not return 404 is returned by 4d
	End case 
	
/******************
Builder functions
******************/
	
/* set the status code */
Function status
	C_OBJECT:C1216($0)
	C_LONGINT:C283($1)
	This:C1470.code:=$1
	$0:=This:C1470  // builder pattern
	
/* set the data to send */
Function data
	C_OBJECT:C1216($0)
	C_VARIANT:C1683($1)
	This:C1470.response:=$1
	$0:=This:C1470  // builder pattern
	
/* set all headers as key/value object*/
Function headers
	C_OBJECT:C1216($0)
	C_OBJECT:C1216($1)
	This:C1470.headers:=$1
	$0:=This:C1470  // builder pattern
	
/* set one header */
Function header
	C_OBJECT:C1216($0)
	C_TEXT:C284($1;$2)
	If (This:C1470.headers=Null:C1517)
		This:C1470.headers:=New object:C1471()
	End if 
	This:C1470.headers[$1]:=$2
	$0:=This:C1470  // builder pattern
	
/* add one cookie to send in headers */
Function cookie
	C_OBJECT:C1216($0)
	C_TEXT:C284($1;$2)
	
	Case of 
		: (This:C1470.headers=Null:C1517)
			This:C1470.headers:=New object:C1471("Set-Cookie";"")
		: (This:C1470.headers["Set-Cookie"]=Null:C1517)
			This:C1470.headers["Set-Cookie"]:=""
	End case 
	
	If (Length:C16(This:C1470.headers["Set-Cookie"])>0)
		This:C1470.headers["Set-Cookie"]:=This:C1470.headers["Set-Cookie"]+"; "
	End if 
	If (Count parameters:C259>1)
		This:C1470.headers["Set-Cookie"]:=This:C1470.headers["Set-Cookie"]+$1+":"+$2
	Else 
		This:C1470.headers["Set-Cookie"]:=This:C1470.headers["Set-Cookie"]+$1
	End if 
	$0:=This:C1470
	
/* just return the response without any change */
Function end
	C_OBJECT:C1216($0)
	$0:=This:C1470  // builder pattern
	
/*
send status with standard error message for the passed HTTP code
	
$2.sendStatus(200)  // equivalent to $2.status(200).send('OK')
$2.sendStatus(403)  // equivalent to $2.status(403).send('Forbidden')
$2.sendStatus(404)  // equivalent to $2.status(404).send('Not Found')
$2.sendStatus(500)  // equivalent to $2.status(500).send('Internal Server Error')
*/
Function sendStatus
	C_OBJECT:C1216($0)
	C_LONGINT:C283($1)
	This:C1470.status:=$1
	This:C1470.response:=HTTPStatusCode [String:C10($1)]
	$0:=This:C1470
	
Function attachment
	C_OBJECT:C1216($0)
	C_TEXT:C284($1)
	If (Count parameters:C259>0)
		This:C1470.header("Content-Disposition";"attachment; filename=\""+$1+"\"")
		
		  // This.header("Content-Type";"") // TODO content type according to file name extension
		
	Else 
		This:C1470.header("Content-Disposition";"attachment")
	End if 
	$0:=This:C1470
	
/******************
Factory functions
******************/
	
/*
response with http code: data, (code, headers)
*/
Function send
	C_LONGINT:C283($2)
	C_VARIANT:C1683($1)
	C_OBJECT:C1216($3)  // optionnal
	C_OBJECT:C1216($0)
	$0:=cs:C1710.Response.new($1;$2;$3)
	
/*
redirect to an url
*/
Function redirect
	C_OBJECT:C1216($0)
	C_TEXT:C284($1)
	  // XXX maybe copy data from headers
	$0:=cs:C1710.ResponseRedirect.new($1)
	
Function sendFile
	C_OBJECT:C1216($0)
	C_VARIANT:C1683($1)
	$0:=cs:C1710.ResponseFile.new($1;This:C1470.code;This:C1470.headers)
	
/* Send a File but will downloaded */
Function download
	C_OBJECT:C1216($0)
	C_OBJECT:C1216($1)
	C_TEXT:C284($2)  //opt file name
	If (Count parameters:C259>1)
		$0:=cs:C1710.ResponseFile.new($1;This:C1470.code;This:C1470.headers).attachment($2)
	Else 
		$0:=cs:C1710.ResponseFile.new($1;This:C1470.code;This:C1470.headers).attachment($1.fullName)
	End if 
	
/* send raw */
Function sendRawData
	C_OBJECT:C1216($0)
	C_TEXT:C284($1)
	$0:=cs:C1710.ResponseRaw.new($1)  // WEB SEND RAW DATA (
	
Function _format
	C_OBJECT:C1216($0;$1;$2)
	$0:=cs:C1710.ResponseFormat.new($1;$2;This:C1470)  // according to header, send a sub response. html, json; text; xml