Class extends Response

Class constructor
	C_VARIANT:C1683($1)
	C_COLLECTION:C1488($2)
	C_OBJECT:C1216($3)
	Super:C1705()
	This:C1470.criterion:=$1
	This:C1470.responses:=$2
	This:C1470.builder:=$3
	
Function doSend  //override
	C_VARIANT:C1683($response)
	
	Case of 
		: (Value type:C1509(This:C1470.criterion)=Is boolean:K8:9)
			
			$response:=Choose:C955(Bool:C1537(This:C1470.criterion);This:C1470.responses[0];This:C1470.responses[1])
			
		Else   // expected num, let failed if not
			
			$response:=This:C1470.responses[Num:C11(This:C1470.criterion)]
			
	End case 
	
	Case of 
		: (Value type:C1509($response)#Is object:K8:27)
			$response:=cs:C1710.Response.new($response)
		: (OB Instance of:C1731($response;4D:C1709.Function))
			$response:=$response.call(This:C1470;This:C1470.context;This:C1470.builder)
	End case 
	
	If (Not:C34(OB Instance of:C1731($response;cs:C1710.Response)))
		$response:=cs:C1710.Response.new($response)
	End if 
	
	$response.doSend()