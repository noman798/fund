require 'scss/util/_slideout'
require './index.scss'
require "scss/util/_bar"

USER_SHARE_LOG_KIND = require("coffee/const/user_share_log_kind")

MS 'body', require("slm/_main")+require('./sidebar.slm'), {
    admin : 0
    onReady: ->
        elem = $(@$element)
        elem.find(".MAIN").html require("./index.slm")
        elem.find('.bar .name').text $user.displayName
        WS.auth_import "user", ->
            F.user.share().then (share_now, li)->
                elem.find(".bar .num").text share_now.toFixed(2)
                _ = $.html()

                li.reverse()

                sum = 0
                for [kind, n, time, txt], pos in li
                    sum += n
                    li[pos].push sum

                li.reverse()
                for [kind, n, time, txt, sum] in li
                    _ """<div class=bar>#{USER_SHARE_LOG_KIND[kind]} <b class=n>#{n.toFixed(2)}</b> 份额<b class="arrow">➙</b> <b class=sum>#{sum}</b><div class=tip><span class=ml4>#{$.isotime time}</span></div></div>"""

                elem.find(".shareLog").html _.html()



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
