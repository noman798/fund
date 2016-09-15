get_parameter_names = require('get-parameter-names')

CONFIG = require("./config.coffee")

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
                    _mod = require("./src/#{value}.coffee")
                catch error
                    console.error error
                    break

                mod = {}
                for k , v of _mod
                    if CONFIG.DEBUG
                        func = get_parameter_names(v)
                    else
                        func = 0
                    mod[k] = func

                ws.session mod

            when ">" # call function
                console.log 'CALL'


        return
    ws.send 'something'
    return

