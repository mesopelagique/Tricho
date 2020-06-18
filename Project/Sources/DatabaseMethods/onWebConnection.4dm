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


$router.all("/404";Formula:C1597($2.status(404).send("dimension 404")))
$router.all("/404JSON";Formula:C1597($2.status(404).send(New object:C1471("error";"lost?"))))

$router.all("/404Image";Formula:C1597($2.status(404).sendFile(Folder:C1567(fk resources folder:K87:11).file("404.png"))))
$router.all("/404Text";Formula:C1597($2.status(404).sendFile(Folder:C1567(fk resources folder:K87:11).file("404.txt"))))
$router.all("/404Html";Formula:C1597($2.status(404).sendFile(Folder:C1567(fk resources folder:K87:11).file("404.html"))))
$router.all("/404ImageD";Formula:C1597($2.status(200).download(Folder:C1567(fk resources folder:K87:11).file("404.png"))))
$router.all("/404TextD";Formula:C1597($2.status(200).download(Folder:C1567(fk resources folder:K87:11).file("404.txt"))))
$router.all("/404TextT";Formula:C1597($2.status(200).download(Folder:C1567(fk resources folder:K87:11).file("404.txt");"renamed.txt")))
$router.all("/404HtmlD";Formula:C1597($2.status(200).download(Folder:C1567(fk resources folder:K87:11).file("404.html"))))

$router.all("/redirect";Formula:C1597($2.redirect("https://4d.com")))
$router.all("/headerSup";Formula:C1597($2.send("created";201;New object:C1471("ID";Generate UUID:C1066))))

$router.get("/format";Formula:C1597($2._format($1;New object:C1471(\
"text/plain";Formula:C1597($2.send("hey"));\
"text/html";Formula:C1597($2.send("<p>hey</p>"));\
"application/json";Formula:C1597($2.send(New object:C1471("message";"hey")));\
"default";Formula:C1597($2.status(406).send("Not Acceptable"))\
))))

$router.get("/routes";Formula:C1597(JSON Stringify:C1217($router)))

/*$childRooter:=tricho .router()
$childRooter.get("/hello";"Hello child")
$childRooter.get("/sub/hello";"Hello sub child")
$childRooter.path:="/child"

$router.register($childRooter)
*/

$router.handle($1;$2;$3;$4;$5;$6)
