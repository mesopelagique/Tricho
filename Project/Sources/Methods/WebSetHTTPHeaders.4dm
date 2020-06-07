//%attributes = {"shared":true,"preemptive":"capable"}
C_OBJECT:C1216($1)
ARRAY TEXT:C222($anames;0)
ARRAY TEXT:C222($avalues;0)

C_LONGINT:C283($cpt)
$cpt:=1
C_TEXT:C284($key)
For each ($key;$1)
	$anames{$cpt}:=$key
	$avalues{$cpt}:=$1[$key]
	$cpt:=$cpt+1
End for each 

WEB SET HTTP HEADER:C660($anames;$avalues)