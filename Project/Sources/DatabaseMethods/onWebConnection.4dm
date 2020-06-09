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


$router.handle($1;$2;$3;$4;$5;$6)
