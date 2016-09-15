get_parameter_names = require('get-parameter-names')

CONFIG = require("./config.coffee")

WebSocketServer = require('ws').Server
wss = new WebSocketServer(port: 20032)


json_mod = (mod)->
    mod = {}
    for k , v of _mod
        if typeof(v) == 'object'
            mod[k] = json_mod(v)
        else
            if CONFIG.DEBUG
                func = get_parameter_names(v)
            else
                func = 0
            mod[k] = func
    mod


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

                ws.send JSON.stringify(json_mod(mod))

            when ">" # call function
                console.log 'CALL'


        return
    ws.send 'something'
    return

