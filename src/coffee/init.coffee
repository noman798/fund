
require '../scss/init.scss'

window.$ = require "jquery"

require "avalon2"


window.V = avalon.vmodels

avalon.define(
    $id: "body"
    html:""
)

window.$id = (id)->
    document.getElementById(id)

require("./index.coffee")

