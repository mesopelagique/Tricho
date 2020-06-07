# Tricho 🕷

Helpers functions to develop web with 4D

## Utility methods

Mainly wrapper to use `C_OBJECT`

### Headers

- WebGetHTTPHeaders
- WebSetHTTPHeaders

### Variables

- WebGetVariables: return an object of variables

### Sends

- WebSendObject: send object as JSON text

## Handler

`Handler` allow to register multiple other methods in `On Web Connection` to split and factorize your code.

According to the request context (path, HTTP method, parameters) the handler must handle or not the request.

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
    $0:=False // ignoe request
  End if
```

### Finnaly handle request

In  `On Web Connection`

```4d
If ($handler.handle($1;$2;$3;$4;$5;$6))
  // handled
Else
  // other code like http 404 if not handled
End if
```
