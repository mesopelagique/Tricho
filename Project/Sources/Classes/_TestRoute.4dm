

Class constructor
	This:C1470.methods:=New collection:C1472(HTTPMethod .GET)
	This:C1470.path:="/readme"
	
Function respond
	C_VARIANT:C1683($0;$response)
	C_OBJECT:C1216($1)
	This:C1470.cmd:=Current method name:C684
	$0:=Folder:C1567(fk database folder:K87:14).file("README.md")
	
Function get
	C_VARIANT:C1683($0;$response)
	C_OBJECT:C1216($1)
	This:C1470.cmd:=Current method name:C684
	$0:=Folder:C1567(fk database folder:K87:14).file("README.md")