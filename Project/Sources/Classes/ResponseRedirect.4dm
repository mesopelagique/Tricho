Class extends Response

Class constructor
	C_TEXT:C284($1)
	Super:C1705()
	This:C1470.url:=$1
	
Function send
	WEB SEND HTTP REDIRECT:C659(This:C1470.url)