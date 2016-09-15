WebSocket = require "reconnecting-websocket"

window.WS = new WebSocket('ws://u88.cn:20032')

WS.onopen = ->
    @send "< auth"

WS.onmessage = (e)->
    console.log e.data

