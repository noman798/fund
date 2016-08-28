window.$ = require "jquery"
window.Slideout = require 'coffee/lib/slideout'

require 'coffee/lib/baidu'
require 'scss/init'

require "js/avalon"

avalon.config({debug: __DEBUG__})
window.V = avalon.vmodels

avalon.define(
    $id: "BODY"
    HTML:""
)

require './lib/ms.coffee'
require "./lib/url.coffee"
require "./urlmap.coffee"
require "./lib/util.coffee"

wName = "u88"
wApp = wilddog.initializeApp(
    authDomain: "#{wName}.wilddog.com",
    databaseURL: "//#{wName}.wilddogio.com"
)
wDB = wilddog.database().ref()
window.$user = wilddog.auth().currentUser

$ ->
    $(document.body).on 'click', 'a', ->
        URL(@href)
        false

    URL.init()
