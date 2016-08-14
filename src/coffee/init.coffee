
require '../scss/init.scss'

window.$ = require "jquery"

require "avalon2"

require "../component/view/view.coffee"

window.vm = avalon.define(
    $id: "APP",
)

window.$id = (id)->
    document.getElementById(id)

