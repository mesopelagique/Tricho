//%attributes = {"invisible":true,"preemptive":"capable"}

C_OBJECT:C1216($router;$route)
$router:=tricho .router()

$router.get("/hello";Formula:C1597("Hello world"))

C_BOOLEAN:C305($handled)
$handled:=$router.handle("/hello";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129($handled;"Must be handled by class")

$handled:=$router.handle("/dayNumber";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled by class")

$handled:=$router.handle("/";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled by class")


$handled:=$router.handle("/readme";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled by class")

$route:=cs:C1710._TestRoute.new()
$router.register($route)

$handled:=$router.handle("/readme";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129($handled;"Must be handled by class")
ASSERT:C1129($route.cmd="_TestRoute.respond";"must respond with respond function")

$handled:=$router.handle("/readme";"POST path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled if POST by class")

$router.unregister($route)

$handled:=$router.handle("/readme";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled by class after unregister")

$route.methods:=Null:C1517  // must respond using get() function
$route.respond:=Null:C1517
$router.register($route)

$handled:=$router.handle("/readme";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129($handled;"Must be handled by class")
ASSERT:C1129($route.cmd="_TestRoute.get";"must respond with respond function")

$handled:=$router.handle("/readme";"POST path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled if POST by class")