

Class constructor
	This:C1470.methods:=New collection:C1472(HTTPMethod .GET)
	This:C1470.path:="/readme"
	
Function respond
	C_VARIANT:C1683($0;$response)
	C_OBJECT:C1216($1)
	
	$response:=This:C1470.formula
	If (Value type:C1509($response)=Is object:K8:27)
		If (OB Instance of:C1731($response;4D:C1709.Function))
			$response:=$response.call(This:C1470;$1)
		End if 
	End if 
	
	$0:=Folder:C1567(fk database folder:K87:14).file("README.md")