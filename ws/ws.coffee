get_parameter_names = require('get-parameter-names')

WebSocketServer = require('ws').Server
wss = new WebSocketServer(port: 20032)


wss.on 'connection', (ws) ->
    session = {

    }
    ws.on 'message', (message) ->
        pos = message.indexOf(' ')
        key = message.slice(0, pos)
        value = message.slice(pos+1)

        switch key
            when "<" # import
                try
                    mod = require("./src/#{value}.coffee")
                catch error
                    console.error error
                    break
                for k , v of mod
                    console.log k, v, get_parameter_names(v)

            when ">" # call function
                console.log 'CALL'


        return
    ws.send 'something'
    return

