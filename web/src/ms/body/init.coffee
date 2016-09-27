require 'scss/util/_slideout'


MS 'body', require("slm/_main")+require('./sidebar.slm'), {
    admin : 0
    onReady: ->
        $(".MAIN").html require("./index.slm")
        WS.auth_import "user", ->
            F.user.share().then (share_now, li)->
                console.log share_now
                for [kind, n, time, txt] in li
                    console.log [kind, n, time, txt]



        self = @
        WS.auth ->
            F.auth.is_admin().then(
                (_admin)->
                    self.admin = _admin
            )
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
