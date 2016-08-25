
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


wName = "u88"
wApp = wilddog.initializeApp(
    authDomain: "#{wName}.wilddog.com",
    databaseURL: "//#{wName}.wilddogio.com"
)
wDB = wilddog.database().ref()
window.$user = 0 and wilddog.auth().currentUser


require("./lib/url.coffee")
require "./urlmap.coffee"

$ ->
    URL.init()
