Class extends Response

Class constructor
	C_VARIANT:C1683($1)
	C_LONGINT:C283($2)
	C_OBJECT:C1216($3)
	Case of 
		: (Value type:C1509($1)=Is object:K8:27)
			ASSERT:C1129(OB Instance of:C1731($1;4D:C1709.File))
		: (Value type:C1509($1)=Is text:K8:3)
			// ok
		Else 
			ASSERT:C1129(False:C215;"Unsuppoted type for file response. need file or string:"+String:C10(Value type:C1509($1)))
	End case 
	Super:C1705($1;$2;$3)
	
Function doSend
	If (Value type:C1509(This:C1470.response)=Is text:K8:3)
		This:C1470.response:=This:C1470.context.router.rootFolder.file(This:C1470.response)// support path as string
	End if 
	// ok
	Super:C1706.doSend()
	