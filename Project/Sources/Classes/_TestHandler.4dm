Function handle
	C_BOOLEAN:C305($0)
	C_OBJECT:C1216($1)
	If ($1.path="/dayNumber")
		WEB SEND TEXT:C677(String:C10(Day number:C114(Current date:C33)))
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
	