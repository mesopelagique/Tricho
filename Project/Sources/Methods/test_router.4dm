//%attributes = {"invisible":true,"preemptive":"capable"}

C_OBJECT:C1216($router)
$router:=tricho .router()

$router.get("/hello";Formula:C1597("Hello world"))

C_BOOLEAN:C305($handled)
$handled:=$router.handle("/hello";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129($handled;"Must be handled by class")

$handled:=$router.handle("/dayNumber";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled by class")

$handled:=$router.handle("/";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled by class")