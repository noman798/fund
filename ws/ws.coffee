CONFIG = require("config.coffee")
co = require('co')

get_parameter_names = require('get-parameter-names')

WebSocketServer = require('ws').Server
wss = new WebSocketServer(
    port: CONFIG.PORT
)


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
    ws.on 'message', (message) ->
        [key, value] = split_n(message, " ", 2)
        switch key
            when "<" # import
                r = {}
                for v in value.split(" ")
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

                p = co(func.apply ws, JSON.parse(args))

                # p = new Promise (resolve, reject)->
                #     try
                #         result = func.apply session, JSON.parse(args)
                #     catch error
                #         reject error
                #         return
                #     if result and result.then and typeof(result.then) == 'function'
                #         result.then(resolve).catch(reject)
                #     else
                #         resolve result

                p.then (result)->
                    msg = "> #{msg_id}"
                    if result != null and result!= undefined and typeof(result) != "function"
                        msg += " #{JSON.stringify(result)}"
                    ws.send(msg)
                p.catch (error)->
                    ws.send("! #{msg_id} #{JSON.stringify(error)}")

        return
    return

