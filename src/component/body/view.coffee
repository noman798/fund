
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

window.Page = (name, slm, defaults)->
    defaults.main = ""
    avalon.component('ms-'+name,{
        template: slm
        defaults: defaults
    })

Page 'body', require("./view.slm"), {
    onReady: ->
        topbar = $("#topbar")
        if 1
            topbar.find(".slideoutBtnW").html """<div id=sB class=slideoutBtn><span/></div>"""
            $("#sB").click ->
                slideout.toggle()
        else
            V.auth.main = require("./auth.slm")
            $("#topbar").css("text-align","center")

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

    onDispose:->
        delete avalon.vmodels[@$id]

}

