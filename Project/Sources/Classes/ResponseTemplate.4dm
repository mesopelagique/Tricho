Class extends Response

Class constructor
	C_VARIANT:C1683($1)// file or text
	C_LONGINT:C283($2)
	C_OBJECT:C1216($3)
	C_OBJECT:C1216($4)
/*C_OBJECT($5)*/
	Super:C1705($1;$2;$3)
	This:C1470.data:=$4// data to process
/*This.context:=$5 to choose template engine? */
	
	If (Value type:C1509(This:C1470.response)=Is object:K8:27)
		If (OB Instance of:C1731(This:C1470.response.getText;4D:C1709.Function))// less restrictive thn file
			This:C1470.response:=This:C1470.response.getText()
		End if 
	End if 
	
	This:C1470.response:=cs:C1710.Template4DTag.new().render(This:C1470.response;This:C1470.data)
	
Function doSend
	Super:C1706.doSend()
	