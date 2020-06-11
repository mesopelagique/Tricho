//%attributes = {"shared":true,"preemptive":"capable"}
C_OBJECT:C1216($0)
ARRAY TEXT:C222($anames;0)
ARRAY TEXT:C222($avalues;0)
WEB GET VARIABLES:C683($anames;$avalues)

$0:=New object:C1471()
C_LONGINT:C283($cpt)
For ($cpt;1;Size of array:C274($anames);1)
	If ($0[$anames{$cpt}]#Null:C1517)
		If (Value type:C1509($0[$anames{$cpt}])=Is collection:K8:32)
			$0[$anames{$cpt}].push($avalues{$cpt})
		Else 
			$0[$anames{$cpt}]:=New collection:C1472($0[$anames{$cpt}];$avalues{$cpt})
		End if 
	Else 
		$0[$anames{$cpt}]:=$avalues{$cpt}
	End if 
End for 