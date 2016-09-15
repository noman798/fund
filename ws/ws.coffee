WebSocketServer = require('ws').Server
wss = new WebSocketServer(port: 20032)


wss.on 'connection', (ws) ->
    session = {

    }
    ws.on 'message', (message) ->
        pos = message.indexOf(' ')
        key = message.slice(0, pos)
        value = message.slice(pos+1)

        if key == "login"
            session.user_id = value
        console.log key, ">", value, session
        return
    ws.send 'something'
    return

