WebSocketServer = require('ws').Server
wss = new WebSocketServer(port: 8080)
wss.on 'connection', (ws) ->
    session = {}
    ws.on 'message', (message) ->
        console.log 'received: %s', message
        return
    ws.send 'something'
    return

