Class extends Response

Class constructor
	C_OBJECT:C1216($1)
	C_OBJECT:C1216($2)
	C_OBJECT:C1216($3)
	Super:C1705()
	This:C1470.context:=$1
	This:C1470.responses:=$2
	This:C1470.builder:=$3
	
	
Function doSend  //override
	C_TEXT:C284($format)
	$format:=This:C1470.context.header("Accept")
	
	C_VARIANT:C1683($response)
	If (Length:C16(String:C10($format))>0)
		
		$response:=This:C1470.responses[$format]  // maybe do a search to find more appropriate one to be less restrictive (like text for text/plain , html for text/html)
		
	End if 
	
	If ($response=Null:C1517)
		$response:=This:C1470.responses["default"]  // maybe a default one
	End if 
	
	Case of 
		: (Value type:C1509($response)#Is object:K8:27)
			$response:=cs:C1710.Response.new($response)
		: (Not:C34(OB Instance of:C1731($response;cs:C1710.Response)))
			$response:=cs:C1710.Response.new($response)
		: (OB Instance of:C1731($response;4D:C1709.Function))
			$response:=$response.call(This:C1470;This:C1470.context;This:C1470.builder)
			
	End case 
	
	$response.doSend()