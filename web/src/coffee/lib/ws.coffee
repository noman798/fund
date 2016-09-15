WebSocket = require "reconnecting-websocket"

window.WS = new WebSocket('ws://u88.cn:20032')

WS.onopen = ->
    @send "< auth"

window.F = {}

load_mod = (mod)->
    r = {}
    for k, v of _mod
        _mod[func_name] = new Function("""return function (/* #{func_args} */){return _Py.#{cls_name}.#{func_name}.apply(this,arguments)}""")()


WS.onmessage = (e)->
    message = e.data
    pos = message.indexOf(' ')
    key = message.slice(0, pos)
    value = message.slice(pos+1)

    switch key
        when "<"
            $.extend F, load_mod(JSON.parse(value))

