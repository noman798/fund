koa = require('koa')
route = require('koa-route')
websockify = require('koa-websocket')

app = websockify(koa())

app.ws.use(route.all('/test/:id', (next) ->
    @websocket.send('Hello World')
    @websocket.on('message', (message) ->
        console.log(message)
    )
    yield next
))

app.listen(3000)

