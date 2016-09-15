Promise = require("bluebird")

WebSocket = require "reconnecting-websocket"

window.WS = new WebSocket('ws://u88.cn:20032')

WS.onopen = ->
    @send "< auth"

window.F = {}

_ID = 0

call = (mod, args)->
    ->
        WS.send "> #{++_ID} #{mod} "\
            + \
            JSON.stringify(i for i in arguments)

window._F = {}

load_mod = (mod, prefix='')->
    r = {}
    if prefix
        prefix += "."

    for k, v of mod
        path = prefix+k
        if typeof(v) == 'object'
            o = load_mod(v, path)
        else
            o = call(path)
            if v
                _F[path] = o
                o = new Function(
                    """return function(#{v})\n{return _F['#{path}'].apply(this,arguments)}"""
                )()
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
        when ">"
            id = 0

