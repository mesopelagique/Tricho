Class constructor
	C_VARIANT:C1683($1)
	If (Value type:C1509($1)=Is collection:K8:32)
		This:C1470.methods:=$1
	Else 
		This:C1470.methods:=New collection:C1472(String:C10($1))
	End if 
	C_TEXT:C284($2)
	This:C1470.path:=$2
	C_VARIANT:C1683($3)
	This:C1470.formula:=$3
	
Function respond
	C_VARIANT:C1683($0;$response)
	C_OBJECT:C1216($1)
	
	$response:=This:C1470.formula
	If (Value type:C1509($response)=Is object:K8:27)
		If (OB Instance of:C1731($response;4D:C1709.Function))
			$response:=$response.call(This:C1470;$1;cs:C1710.Response.new())
		End if 
	End if 
	
	$0:=$response