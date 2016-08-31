
store = require 'store'

html = $ require("./_base.coffee")
html.find('.txt').html ""

MS 'auth-user', html.html(), {
    slogo:"个人资料"
    onReady: ->
        if not $user.name
            $(".slideoutBtn").remove()
            $("#topbar").css("text-align":'center')
}
