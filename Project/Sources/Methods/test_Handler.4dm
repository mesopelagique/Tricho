//%attributes = {"invisible":true}
C_OBJECT:C1216($handler)
C_BOOLEAN:C305($handled)

  //$handler:=cs.Handler.new()
$handler:=tricho .handler()

$handler.register(Formula:C1597(False:C215))

$handled:=$handler.handle("path";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled, if not handler which return true")

  // test with catch? to check if passed
  // $handler.register(Formula(Asserted(False;"must not be handled")))
  // $handled:=$handler.handle("path";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null;Null)

$handler.register(Formula:C1597(Asserted:C1132($1#Null:C1517;"handled")))
$handled:=$handler.handle("path";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129($handled;"Must be handled with context")

$handler.register(Formula:C1597(ASSERT:C1129(False:C215;"Must not be executed handler")))
$handled:=$handler.handle("path";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129($handled;"Must be handled but not passing in last one")

  // HANDLER class

$handler:=tricho .handler()
$handler.register(Formula:C1597(False:C215))
$handler.register(cs:C1710._TestHandler.new())

$handled:=$handler.handle("path";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129(Not:C34($handled);"Must not be handled, wrong path")

$handled:=$handler.handle("/dayNumber";"GET path\nHeader: value";"0.0.0.0";"2.2.2.2";Null:C1517;Null:C1517)
ASSERT:C1129($handled;"Must be handled by class")