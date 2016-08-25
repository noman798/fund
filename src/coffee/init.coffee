
require './lib/baidu.coffee'
require '../scss/init.scss'

require "../js/avalon.modern.js"
require './lib/ms.coffee'

require("./lib/url.coffee")
require "./urlmap.coffee"

window.$ = require "jquery"

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

$ ->
    $(document.body).on 'click', 'a', ->
        URL(@href)
        false

$ ->
    URL.init()
