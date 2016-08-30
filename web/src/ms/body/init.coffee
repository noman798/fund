require 'scss/util/_slideout'

wDB.child('adminGroup').child($user.uid).on(
    'value'
    (o) ->
        if not o.val()
            data = {}
            data[$user.id] = true
            wDB.child('adminGroup').set(data)
    (err) ->
        console.log err
)

MS 'body', require("slm/_main")+require('./sidebar.slm'), {
    onReady: ->
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

# _setTransition = Slideout.prototype._setTransition
# _translateXTo = Slideout.prototype._translateXTo
# slideout.on('beforeclose', ->
#     document.querySelector('.fixed').classList.remove('fixed-open')
# )


# Slideout.prototype._setTransition = ->
#     _setTransition.call @

# Slideout.prototype._translateXTo = (n)->
#     _translateXTo.call @, n
