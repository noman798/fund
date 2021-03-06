window.$ = require "jquery"

window.store = require 'store'

require "js/jquery.scrollbar.js"
require "js/jquery.scrollbar.scss"

window.Slideout = require 'coffee/lib/slideout'

require 'coffee/lib/baidu_tongji'
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
require "./lib/ws.coffee"
require "./urlmap.coffee"
require "./lib/util.coffee"
require "./lib/jquery_ext.coffee"

COFNIG = require "../../config.coffee"

wApp = wilddog.initializeApp(
    authDomain: "#{COFNIG.WILDDOG}.wilddog.com",
    syncURL: "//#{COFNIG.WILDDOG}.wilddogio.com"
)
window.wDB = wilddog.sync()
window.$user = 0

require "./comm/auth.coffee"
