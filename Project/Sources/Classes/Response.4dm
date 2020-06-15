
Class constructor
	C_VARIANT:C1683($1)
	C_LONGINT:C283($2)
	C_OBJECT:C1216($3)
	This:C1470.response:=$1
	This:C1470.code:=$2
	This:C1470.headers:=$3
	
Function send
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
					This:C1470.response.send()
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
	
/*
response with error code
*/
Function respond
	C_LONGINT:C283($1)
	C_VARIANT:C1683($2)
	C_OBJECT:C1216($3)  // optionnal
	C_OBJECT:C1216($0)
	$0:=cs:C1710.Response.new($2;$1;$3)
	
Function redirect
	C_OBJECT:C1216($0)
	C_TEXT:C284($1)
	$0:=cs:C1710.ResponseRedirect.new($1)