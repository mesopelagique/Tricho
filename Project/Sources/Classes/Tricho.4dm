/*
Create a web Handler
*/
Function handler
	C_OBJECT:C1216($0)
	$0:=cs:C1710.Handler.new()
	
/*
Create a web Rooter
*/
Function router
	C_OBJECT:C1216($0)
	$0:=cs:C1710.Router.new()
	
/*
Return the framework class store. Use at your own risk.
*/
Function cs
	C_OBJECT:C1216($0)
	$0:=cs:C1710