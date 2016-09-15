WebSocket = require "reconnecting-websocket"

window.WS = new WebSocket('ws://u88.cn:20032')

WS.onopen = ->
    @send "< auth"

window.F = {}

call = (mod, args)->
    ->
        WS.send "> "+mod+" "+JSON.stringify(i for i in arguments)

load_mod = (mod)->
    r = {}
    for k, v of mod
        if typeof(v) == 'object'
            o = load_mod(v)
        else
            if v
                o = new Function(
                    """return function(#{v}){}"""
                )()
            else
                o = call(k)
        r[k] = o
    r

WS.onmessage = (e)->
    message = e.data
    pos = message.indexOf(' ')
    key = message.slice(0, pos)
    value = message.slice(pos+1)

    switch key
        when "<"
            $.extend F, load_mod(JSON.parse(value))

