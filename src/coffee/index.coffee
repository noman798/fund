
window.$ = require "jquery"

require "avalon2"


require "../component/view/view.coffee"
require '../scss/init.scss'

window.vm = avalon.define(
    $id: "APP",
)

Slideout = require "slideout"

slideout = new Slideout({
    panel : document.getElementById('panel')
    menu : document.getElementById('menu')
    # padding : 256
    tolerance : 70
    # side : 'right'
})
# slideout.on('beforeopen', ->
#     document.querySelector('.fixed').classList.add('fixed-open')
# )
# slideout.on('beforeclose', ->
#     document.querySelector('.fixed').classList.remove('fixed-open')
# )

$("#menuBtn").click ->
    slideout.toggle()

