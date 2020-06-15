C_OBJECT:C1216($router)
$router:=tricho .router()
$router.get("/hello";"Hello world")
$router.get("/hello/formula";Formula:C1597("Hello world by formula"))
$router.all("/date/today";Formula:C1597(String:C10(Current date:C33)))

$router.all("/employee/:id";Formula:C1597(String:C10($1.params.id)))
$router.get("/object/:id";Formula:C1597(New object:C1471("id";$1.params.id)))

$router.get("/index/";Folder:C1567(fk database folder:K87:14).folder("WebFolder").file("index.html"))

  // $router.get("/webfolder/:path";Formula(Folder(fk database folder).folder("WebFolder").folder($1.params.path)))

$router.register(cs:C1710._TestRoute.new())

$router.all("/method";Formula:C1597("This is a "+$1.method))

$router.all("/context";Formula:C1597($1))
$router.all("/headers";Formula:C1597($1.headers()))
$router.all("/var";Formula:C1597($1.variables()))


$router.all("/404";Formula:C1597($2.respond(404;"dimension 404")))
$router.all("/404JSON";Formula:C1597($2.respond(404;New object:C1471("error";"lost?"))))
$router.all("/redirect";Formula:C1597($2.redirect("https://4d.com")))
$router.post("/headerSup";Formula:C1597($2.respond(201;"created";New object:C1471("ID";Generate UUID:C1066))))

/*$childRooter:=tricho .router()
$childRooter.get("/hello";"Hello child")
$childRooter.get("/sub/hello";"Hello sub child")
$childRooter.path:="/child"

$router.register($childRooter)
*/

$router.handle($1;$2;$3;$4;$5;$6)
