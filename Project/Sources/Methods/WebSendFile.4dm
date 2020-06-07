//%attributes = {}

C_OBJECT:C1216($1)  // file
C_TEXT:C284($2)  // encoding type, see WEB SEND BLOB

ASSERT:C1129(OB Instance of:C1731($1;4D:C1709.File))
If (Count parameters:C259>1)
	WEB SEND BLOB:C654($1.getContent();$2)
Else 
	WEB SEND BLOB:C654($1.getContent();$1.extension)
End if 