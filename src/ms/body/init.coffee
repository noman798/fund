# _setTransition = Slideout.prototype._setTransition
# _translateXTo = Slideout.prototype._translateXTo
# slideout.on('beforeclose', ->
#     document.querySelector('.fixed').classList.remove('fixed-open')
# )


# Slideout.prototype._setTransition = ->
#     _setTransition.call @

# Slideout.prototype._translateXTo = (n)->
#     _translateXTo.call @, n

require 'scss/lib/_slideout'
require 'scss/util/_slideout'

Slideout = require "slideout"
Slideout.prototype._setTransition = ->
    @
Slideout.prototype._translateXTo = (n)->
    @panel.style.transform = ''
    @


MS 'body', require("slm/_main")+"<div id=sM/>", {
    onReady: ->
        topbar = $("#topbar")
        topbar.find(".slideoutBtnW").html """<div id=sB class=slideoutBtn><span/></div>"""

        slideout = new Slideout({
            panel : $id 'sP'
            menu : $id 'sM'
            tolerance : 70
            side : 'right'
        })
        ("#sB").click ->
            slideout.toggle()


        slideout.on('open', ->
            if $(window).width() < 800
                $("#sP").one(
                    'click.slideout', ->
                        slideout.close()
                )
        )
        slideout.on('close', ->
            $("#sP").unbind(
                'click.slideout'
            )
        )
}

