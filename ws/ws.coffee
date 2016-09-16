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


split_n = (str, split, n)->
    r = []
    n = n - 1
    while r.length < n
        pos = str.indexOf(split)
        if pos < 0
            break
        key = str.slice(0, pos)
        str = str.slice(pos+1)
        r.push(key)
    r.push(str)
    r

_MOD = {}
wss.on 'connection', (ws) ->
    session = {

    }
    ws.on 'message', (message) ->
        [key, value] = split_n(message, " ", 2)
        switch key
            when "<" # import
                r = {}
                for v in value.split(",")
                    try
                        mod = require("./src/#{v}.coffee")
                    catch error
                        console.error error
                        break
                    _MOD[v] = mod
                    r[v] = dump_mod(mod)
                ws.send "< "+JSON.stringify(r)

            when ">" # call function
                [msg_id, mod, args] =  value.split(" ",3)
                func = _MOD
                for i in mod.split(".")
                    func = func[i]
                func.apply ws, JSON.parse(args)



        return
    return

