/*
The handler allow to register web handler to respond to request.
The first which return True will respond.
*/
Class constructor
	  // handlers
	This:C1470.handlers:=New collection:C1472()
	
Function register
	C_OBJECT:C1216($1)
	If (OB Instance of:C1731($1;4D:C1709.Function))
		This:C1470.handlers.push(cs:C1710._FormulaHandler.new($1))
	Else 
		
		ASSERT:C1129((($1.handle#Null:C1517) | (($1.accept#Null:C1517) & ($1.respond#Null:C1517)));"Not an handler class, add accept/respond functions or handle one")
		This:C1470.handlers.push($1)
	End if 
	
Function handle
	C_BOOLEAN:C305($0;$handled)
	C_TEXT:C284($1;$2;$3;$4;$5;$6)
	
	C_OBJECT:C1216($context)
	$context:=cs:C1710.Context.new($1;$2;$3;$4;$5;$6)
	
	$handled:=False:C215
	For each ($handler;This:C1470.handlers) Until ($handled)
		If ($handler.accept#Null:C1517)
			If ($handler.accept($context))
				$handler.respond($context)
				$handled:=True:C214
			End if 
		Else 
			If ($handler.handle($context))
				$handled:=True:C214
			End if 
		End if 
	End for each 
	$0:=$handled