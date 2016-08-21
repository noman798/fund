
# _setTransition = Slideout.prototype._setTransition
# _translateXTo = Slideout.prototype._translateXTo
# slideout.on('beforeclose', ->
#     document.querySelector('.fixed').classList.remove('fixed-open')
# )


# Slideout.prototype._setTransition = ->
#     _setTransition.call @

# Slideout.prototype._translateXTo = (n)->
#     _translateXTo.call @, n
Slideout = require "slideout"
Slideout.prototype._setTransition = ->
    @
Slideout.prototype._translateXTo = (n)->
    @panel.style.transform = ''
    @


MS 'body', require("./view.slm"), {
    main:""
    onReady: ->
        console.log "!!!1"
        topbar = $("#topbar")
        if $.user
            topbar.find(".slideoutBtnW").html """<div id=sB class=slideoutBtn><span/></div>"""
            $("#sB").click ->
                slideout.toggle()
        else
            topbar.css("text-align","center")
            V.body.main = require("../auth/auth.slm")

        slideout = new Slideout({
            panel : $id 'sP'
            menu : $id 'sM'
            tolerance : 70
            side : 'right'
        })


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
        console.log "!!!2"

    onDispose:->
        delete avalon.vmodels[@$id]

}

