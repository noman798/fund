get_parameter_names = require('get-parameter-names')

CONFIG = require("./config.coffee")

WebSocketServer = require('ws').Server
wss = new WebSocketServer(port: 20032)


dump_mod = (mod)->
    r = {}
    for k , v of mod
        if typeof(v) == 'object'
            func = dump_mod(v)
        else
            if CONFIG.DEBUG
                func = get_parameter_names(v).join(",")
            else
                func = 0
        r[k] = func
    r


wss.on 'connection', (ws) ->
    session = {

    }
    ws.on 'message', (message) ->
        pos = message.indexOf(' ')
        key = message.slice(0, pos)
        value = message.slice(pos+1)

        switch key
            when "<" # import
                r = {}
                for v in value.split(",")
                    try
                        mod = require("./src/#{v}.coffee")
                    catch error
                        console.error error
                        break
                    r[v] = dump_mod(mod)
                ws.send "< "+JSON.stringify(r)

            when ">" # call function
                console.log 'CALL'


        return
    return

