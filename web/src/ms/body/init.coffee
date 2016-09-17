require 'scss/util/_slideout'

admin = 0

MS 'body', require("slm/_main")+require('./sidebar.slm'), {
    admin : 0
    onReady: ->
        @admin = admin
        topbar = $("#topbar")
        topbar.find(".slideoutBtnW").html """<div id=sB class=slideoutBtn><span/></div>"""
        slideout = new Slideout({
            panel : $id 'sP'
            menu : $id 'sM'
            tolerance : 70
            side : 'right'
        })
        $("#sB").click(
            ->
                slideout.toggle()
        )

        slideout.on('open', ->
            $("body").on(
                'click.slideout'
                '#sP'
                ->
                    slideout.close()
            )
        )
        slideout.on('close', ->
            $("body").off(
                'click.slideout'
            )
        )
}

# _setTransition = Slideout.prototype._setTransition
# _translateXTo = Slideout.prototype._translateXTo
# slideout.on('beforeclose', ->
#     document.querySelector('.fixed').classList.remove('fixed-open')
# )


# Slideout.prototype._setTransition = ->
#     _setTransition.call @

# Slideout.prototype._translateXTo = (n)->
#     _translateXTo.call @, n
