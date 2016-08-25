
window.$ = require "jquery"
require './lib/baidu.coffee'
require '../scss/init.scss'

require "../js/avalon.modern.js"
require './lib/ms.coffee'

require("./lib/url.coffee")
require "./urlmap.coffee"


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
window.$user = wilddog.auth().currentUser
#window.$user = 0

$ ->
    $(document.body).on 'click', 'a', ->
        URL(@href)
        false

$ ->
    URL.init()
