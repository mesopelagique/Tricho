Class constructor
	C_VARIANT:C1683($1)
	If (Value type:C1509($1)=Is collection:K8:32)
		This:C1470.methods:=New collection:C1472($1)
	Else 
		This:C1470.methods:=New collection:C1472(String:C10($1))
	End if 
	C_TEXT:C284($2)
	This:C1470.path:=$2
	C_OBJECT:C1216($3)
	This:C1470.formula:=$3