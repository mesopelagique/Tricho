//%attributes = {"shared":true,"preemptive":"capable"}
C_OBJECT:C1216($0)
ARRAY TEXT:C222($anames;0)
ARRAY TEXT:C222($avalues;0)
WEB GET VARIABLES:C683($anames;$avalues)

$0:=New object:C1471()
C_LONGINT:C283($cpt)
For ($cpt;1;Size of array:C274($anames);1)
	$0[$anames{$cpt}]:=$avalues{$cpt}
End for 