//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($0;$router)

$router:=tricho.router()
$router.strict:=False:C215
$router.get("/";"Root")
$router.get("/hello";"Hello world")
$router.get("/hello/formula";Formula:C1597("Hello world by formula"))
$router.all("/date/today";Formula:C1597(String:C10(Current date:C33)))
$router.get("/:id";Formula:C1597(String:C10($1.params.id)))

$router.all("/employee/:id";Formula:C1597(String:C10($1.params.id)))
$router.get("/object/:id";Formula:C1597(New object:C1471("id";$1.params.id)))

$router.get("/index/";Folder:C1567(fk database folder:K87:14).folder("WebFolder").file("index_.html"))

// $router.get("/webfolder/:path";Formula(Folder(fk database folder).folder("WebFolder").folder($1.params.path)))

$router.register(cs:C1710._TestRoute.new())

$router.all("/method";Formula:C1597("This is a "+$1.method))

$router.all("/context";Formula:C1597($1))
$router.all("/headers";Formula:C1597($1.headers()))
$router.all("/var";Formula:C1597($1.variables()))


$router.all("/404";Formula:C1597($2.status(404).send("dimension 404")))
$router.all("/404JSON";Formula:C1597($2.status(404).send(New object:C1471("error";"lost?"))))

$router.all("/404ImagePath";Formula:C1597($2.status(404).sendFile("404.png")))
$router.all("/404Image";Formula:C1597($2.status(404).sendFile(Folder:C1567(fk resources folder:K87:11).file("404.png"))))
$router.all("/404Text";Formula:C1597($2.status(404).sendFile(Folder:C1567(fk resources folder:K87:11).file("404.txt"))))
$router.all("/404Html";Formula:C1597($2.status(404).sendFile(Folder:C1567(fk resources folder:K87:11).file("404.html"))))
$router.all("/404ImageD";Formula:C1597($2.status(200).download(Folder:C1567(fk resources folder:K87:11).file("404.png"))))
$router.all("/404TextD";Formula:C1597($2.status(200).download(Folder:C1567(fk resources folder:K87:11).file("404.txt"))))
$router.all("/404TextT";Formula:C1597($2.status(200).download(Folder:C1567(fk resources folder:K87:11).file("404.txt");"renamed.txt")))

$router.all("/404HtmlD";Formula:C1597($2.status(200).download(Folder:C1567(fk resources folder:K87:11).file("404.html"))))
$router.all("/attachment";Formula:C1597($2.status(200).attachment("a.txt").send("new file content")))

$router.all("/redirect";Formula:C1597($2.redirect("https://4d.com")))
$router.all("/headerSup";Formula:C1597($2.send("created";201;New object:C1471("ID";Generate UUID:C1066))))

$router.get("/format";Formula:C1597($2.format($1;New object:C1471(\
"text/plain";Formula:C1597($2.header("Content-type";"text/plain").send("hey"));\
"text/html";Formula:C1597($2.send("<p>hey</p>"));\
"application/json";Formula:C1597($2.send(New object:C1471("message";"hey")));\
"application/xml";Formula:C1597($2.header("Content-type";"application/xml").send("<root></root>"));\
"default";Formula:C1597($2.status(406).send("Not Acceptable"))\
))))

$router.get("/textplain";"hey")
$router.get("/template";Formula:C1597($2.status(202).render("Name: <!--#4DEVAL $1.firstname --> <b><!--#4DEVAL $1.lastname --></b>";\
New object:C1471("firstname";"eric";"lastname";"mesopelagique"))))
$router.get("/template/file";Formula:C1597($2.status(202).render(Folder:C1567(fk resources folder:K87:11).file("template.html");\
New object:C1471("firstname";"phimage";"lastname";"mesopelagique";"menu";New collection:C1472("Home";"Info";"Contact")))))

$router.get("/router.http";Formula:C1597($2.status(200).attachment("router.http").send($router.restClientHTTP($1))))

C_OBJECT:C1216($childRooter)
$childRooter:=tricho.router()
$childRooter.get("/";" child?")
$childRooter.get("/hello";"Hello child")
$childRooter.get("/sub/hello";"Hello sub child")
$childRooter.get("/testvar/:hello";Formula:C1597(String:C10($1.params.hello)))
$childRooter.path:="/child"

$router.register($childRooter)

//$childRooter.get("/:thing";Formula($1.params.thing))
//$router.use("/user/:thing"; $childRooter)


$0:=$router