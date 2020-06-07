
Class constructor
	C_VARIANT:C1683($1)
	This:C1470.response:=$1
	
Function send
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