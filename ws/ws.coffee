WebSocketServer = require('ws').Server
wss = new WebSocketServer(port: 20032)
wss.on 'connection', (ws) ->
    session = {

    }
    ws.on 'message', (message) ->
        pos = message.indexOf(' ')
        key = message.slice(0, pos)
        value = message.slice(pos+1,-1)

        console.log key, ">", value
        return
    ws.send 'something'
    return

