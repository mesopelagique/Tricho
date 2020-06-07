//%attributes = {"invisible":true,"preemptive":"capable"}


/*
C_OBJECT($1)  // file
C_TEXT($2)  // encoding type, see WEB SEND BLOB

ASSERT(OB Instance of($1;4D.Folder))

$html:="<ul>"

For each ($child;$1.files())
$html:=$html+"<li>"+$child.name+"</li>"
End for each 

$html:=$html+"</ul>"
WEB SEND TEXT($html)*/