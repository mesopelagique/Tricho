//%attributes = {"shared":true,"preemptive":"capable"}
/*
Send object or collection to web
*/
C_VARIANT:C1683($1)
C_BOOLEAN:C305($2;$pretty)
$pretty:=False:C215
If (Count parameters:C259>1)
	$pretty:=Bool:C1537($2)
End if 
If ($pretty)
	WEB SEND TEXT:C677(JSON Stringify:C1217($1;*))
Else 
	WEB SEND TEXT:C677(JSON Stringify:C1217($1))
End if 