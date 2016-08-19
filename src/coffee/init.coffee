
require './lib/baidu.coffee'
require './lib/ms.coffee'
require '../scss/init.scss'

window.$ = require "jquery"

$(document.body).on 'click', 'a', ->
    URL(@href)
    false

require "avalon2"


window.V = avalon.vmodels

avalon.define(
    $id: "BODY"
    html:""
)

window.$id = (id)->
    document.getElementById(id)

require("./lib/url.coffee")
require("./index.coffee")
