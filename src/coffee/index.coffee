
window.$ = require "jquery"

require "avalon2"


require "../component/view/view.coffee"
require '../scss/init.scss'

window.vm = avalon.define(
    $id: "APP",
)

$id = (id)->
    document.getElementById(id)

Slideout = require "slideout"

slideout = new Slideout({
    panel : $id 'sP'
    menu : $id 'sM'
    tolerance : 70
    side : 'right'
})
# slideout.on('beforeopen', ->
#     document.querySelector('.fixed').classList.add('fixed-open')
# )
# slideout.on('beforeclose', ->
#     document.querySelector('.fixed').classList.remove('fixed-open')
# )

$("#sB").click ->
    slideout.toggle()

Slideout.prototype._setTransition = Slideout.prototype._translateXTo = -> @
