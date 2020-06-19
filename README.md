# Tricho 🕷

[![language](https://img.shields.io/static/v1?label=language&message=4d&color=blue)](https://developer.4d.com/)
[![language-top](https://img.shields.io/github/languages/top/mesopelagique/Tricho.svg)](https://developer.4d.com/)
![code-size](https://img.shields.io/github/languages/code-size/mesopelagique/Tricho.svg)
[![release](https://img.shields.io/github/v/release/mesopelagique/Tricho.svg)](https://github.com/mesopelagique/Tricho/releases/latest)
[![license](https://img.shields.io/github/license/mesopelagique/Tricho)](LICENSE)

Helpers functions for web development and a web router:

```4d
$router:=tricho.router() 
$router.get("/hello";"Hello world")
$router.post("/get";Formula($2.download("path/of/file"))
...
```

## Utility methods

Mainly wrapper to use `C_OBJECT`

### HTTP Headers

- WebGetHTTPHeaders
- WebSetHTTPHeaders

### Variables

- WebGetVariables: return an object of variables

### Respond

- WebSendObject: send object or collection as JSON text (using `JSON Stringify`)
- WebSendFile: send a `File`

## Router

A router allow you define entry points to respond to HTTP requests.

Typically you provide the URL path, the HTTP method and the code to execute when matching.

### Create the rooter and add "route(s)"

```4d
$router:=tricho.router()
$router.get("/hello";"Hello world")
...
```

### Handle request

In `On Web Connection` you could handle all request using code:

```4d
$router.handle($1;$2;$3;$4;$5;$6)
```

### Register routes

#### Choose the HTTP method

You can choose one http method(GET, POST, PUT, ...) or all methods

```4d
$router.get("/hello";"This is a GET")
$router.post("/hello";"This is a POST")
$router.all("/hello";Formula("This is a "+$1.method))
```

#### Providing data or code to execute

Last parameters is the data to return to the HTTP client.

If you use a formula, 
- the code could be dynamic ie. executed each times
- you can call an other methods to manage response
- you receive a context/request object with some useful features (to get headers, variables, ...)

If you return 
- an object or a collection, it will be JSON stringifyed
- a `File`, it will be send as blob (or according to file extension)

#### Have parameters in route

You can define parameters in route using `:`, for instance to get the employee id

```4d
$router.get("/employee/:id";Formula(ProceedEmployeeData($1.params.id)))
```

then in HTTP client, you could access the resource using path `/employee/12`

#### Using a class (advanced use)

A class must conform to some parameters and functions, then you can register as follow

```4d
$router.register(cs.YourRoute.new()) 
```

The class must defined the `path` and `methods` attributes.

```4d
Class constructor
	This.methods:=New collection(HTTPMethod .GET)
	This.path:="/a/class/path"
```

and must define a function to return the data.

```4d
Function respond
	C_VARIANT($0)
	C_OBJECT($1) // $context
	$0:="Hello" // Return a String, an Object(JSON), 4D.File...
```

alteratively you can defined function by HTTP method if you do not defined `methods` attribute

```4d
Function get
	$0:="Hello"

Function post
	$0:=New object("success";True)
```

## Handler

`Handler` is an alternative to `Router`; it allow to register other methods to split and factorize your code used in `On Web Connection`

According to the request context (path, HTTP method, parameters) the handler must handle or not the request. If one handler respond, we stop.

### First create the handler

```4d
$handler:=tricho. handler()
```

> each time in `On Web Connection` or  only one time in `On Startup` for instance

### Then register some handlers

#### With formula which return `True` if request handled

```4d
$handler.register(Formula(MyMethodToRespond(This)))
```

### Using class

You can also use a class wich contains `handle` function which `True` if request handled.

```4d
Function handle
  If ($1.path="/dayNumber")
    WEB SEND TEXT(String(Day number(Current date)))
    $0:=True // handled
  Else
    $0:=False // ignore request
  End if
```

### Finally handle request

In  `On Web Connection`

```4d
If ($handler.handle($1;$2;$3;$4;$5;$6))
  // handled
Else
  // other code like http 404 if not handled
End if
```

## Ackowledgments

Router is inspired by numerous packages of different languages such as Flask for python, express for javascript, etc...

## Info

- Name come from [Trichobothria](https://en.m.wikipedia.org/wiki/Trichobothria)

[<img src="https://mesopelagique.github.io/quatred.png" alt="mesopelagique"/>](https://mesopelagique.github.io/)

