Class constructor
	C_TEXT:C284($1;$2;$3;$4;$5;$6)
	This:C1470.relativeReference:=$1// https://tools.ietf.org/html/rfc3986#section-4.2
	If (Position:C15("?";This:C1470.relativeReference)>0)
		This:C1470.path:=Substring:C12(This:C1470.relativeReference;1;Position:C15("?";This:C1470.relativeReference)-1)
	Else 
		If (Position:C15("#";This:C1470.relativeReference)>0)
			This:C1470.path:=Substring:C12(This:C1470.relativeReference;1;Position:C15("#";This:C1470.relativeReference)-1)
		Else 
			This:C1470.path:=This:C1470.relativeReference
		End if 
	End if 
	
	This:C1470.rawHTTP:=$2
	This:C1470.client:=New object:C1471("ip";$3)
	This:C1470.server:=New object:C1471("ip";$4)
	This:C1470.basicAuth:=New object:C1471("username";$5;"password";$6)
	
	If (Position:C15(" ";This:C1470.rawHTTP)>0)
		This:C1470.method:=Substring:C12(This:C1470.rawHTTP;1;Position:C15(" ";This:C1470.rawHTTP)-1)
	Else 
		This:C1470.method:=This:C1470.rawHTTP
	End if 
	