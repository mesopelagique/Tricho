
Class constructor
	C_OBJECT:C1216($1)
	  // ASSERT(OB Instance of($1;4D.Formula))
	This:C1470.formula:=$1
	
Function handle
	C_BOOLEAN:C305($0)
	C_OBJECT:C1216($1)
	$0:=This:C1470.formula.call(This:C1470;$1)