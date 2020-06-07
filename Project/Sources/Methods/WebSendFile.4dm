//%attributes = {"shared":true,"preemptive":"capable"}

C_OBJECT:C1216($1)  // file
C_TEXT:C284($2)  // encoding type, see WEB SEND BLOB

ASSERT:C1129(OB Instance of:C1731($1;4D:C1709.File))
C_BLOB:C604($blob)
$blob:=$1.getContent()  // Need a var to work properly...
If (Count parameters:C259>1)
	WEB SEND BLOB:C654($blob;$2)
Else 
	WEB SEND BLOB:C654($blob;$1.extension)  // text with text/plain
End if 