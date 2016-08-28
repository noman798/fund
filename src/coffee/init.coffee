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

COFNIG = require "../../config.coffee"

wApp = wilddog.initializeApp(
    authDomain: "#{COFNIG.WILDDOG}.wilddog.com",
    databaseURL: "//#{COFNIG.WILDDOG}.wilddogio.com"
)
wDB = wilddog.database().ref()
window.$user = wilddog.auth().currentUser

$ ->
    $(document.body).on 'click', 'a', ->
        false

    URL.init()
