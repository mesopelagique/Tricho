//%attributes = {}
C_OBJECT:C1216($0)
If (_HTTPMethod=Null:C1517)
	_HTTPMethod:=New object:C1471(\
		"GET";"GET";"POST";"POST";\
		"HEAD";"HEAD";"PUT";"PUT";\
		"DELETE";"DELETE";"PATCH";"PATCH";"OPTIONS";"OPTIONS";\
		"ALL";New collection:C1472("GET";"POST";"DELETE";"PUT";"PATCH";"HEAD";"OPTIONS"))
End if 
$0:=_HTTPMethod
