require 'scss/util/_slideout'

admin = 0
wilddog.auth().onAuthStateChanged (user) ->
    if not user
        return

    wDB.child('adminGroup').child(user.uid).on(
        'value'
        (o) ->
            V.body.admin = admin = 1
            if not o.val()
                data = {}
                data[$user.uid] = true
                wDB.child('adminGroup').set(data)
        ->
            V.body?.admin = admin = 0
    )

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
