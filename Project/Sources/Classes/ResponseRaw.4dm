Class extends Response

Class constructor
	C_TEXT:C284($1)
	Super:C1705()
	This:C1470.rawData:=$1
	
Function doSend
	WEB SEND RAW DATA:C815(This:C1470.rawData)  // XXX support chunk?