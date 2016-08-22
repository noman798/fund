
require './lib/baidu.coffee'
require './lib/ms.coffee'
require '../scss/init.scss'

window.$ = require "jquery"

$ ->
    $(document.body).on 'click', 'a', ->
        URL(@href)
        false

require "../js/avalon.modern.js"
avalon.config({debug: __DEBUG__})


window.V = avalon.vmodels

avalon.define(
    $id: "BODY"
    HTML:""
)

window.$id = (id)->
    document.getElementById(id)

require("./lib/url.coffee")
require("./index.coffee")

