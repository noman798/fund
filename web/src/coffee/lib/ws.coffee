WebSocket = require "reconnecting-websocket"
CONFIG = require "config.coffee"

window.WS = new WebSocket("ws://#{CONFIG.WS}")

_wait = (socket, callback, timeout=100) ->
    if socket.readyState == 1
        callback()
    else
        setTimeout(
            ->
                if socket.readyState == 1
                    callback()
                else
                    _wait socket, callback, Math.min(timeout+100, 1000)
            timeout
        )


_IMPORT = []

WebSocket.prototype.import = (name, callback)->
    self = @
    _wait self, ->
        result = []
        for i in name.split(" ")
            if not F[i]
                result.push i
        if result.length
            self.send("< "+result.join(' '))
            _IMPORT.push([result, callback])
        else
            callback()

window.F = {}

_ID = 1
_STACK = []

call = (mod, args)->
    ->
        r = $.Deferred()
        _STACK.unshift [++_ID, r]

        WS.send "> #{_ID} #{mod} "\
            + \
            JSON.stringify(i for i in arguments)

        r



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
    # for i in _IMPORT
    #     console.log i

WS.onmessage = (e)->
    message = e.data
    pos = message.indexOf(' ')
    key = message.slice(0, pos)
    value = message.slice(pos+1)

    switch key
        when "/"
            URL.fire value
        when "<"
            o = load_mod(JSON.parse(value))
            $.extend F, o
            _import = []
            for [li, resolve] in _IMPORT
                _li = []
                for mod, pos in li
                    if not o[mod]
                        _li.push mod
                if _li.length
                    _import.push([_li, resolve])
                else
                    resolve()
            _IMPORT = _import
        when ">", "!"
            pos = value.indexOf(" ")
            if pos > 0
                id = value.slice(0, pos)-0
                msg = value.slice(pos+1)
                msg = JSON.parse(msg)
                if not $.isArray(msg)
                    msg = [msg]
            else
                msg = undefined
                id = value - 0
            for i, pos in _STACK
                if i[0] == id
                    func = i[1]
                    func[if key==">" then 'resolve' else "reject"].apply(func, msg)
                    _STACK.splice(pos, 1)
                    break


