
store = require 'store'

html = $ require("./_base.coffee")
html.find('.txt').html require('./_name.slm')

MS 'auth-user', html.html(), {
    slogo:"个人资料"
    name:""
    onReady: ->
        if not $user
            URL "/"
        name = $user.displayName
        if name
            @name = name
        else
            $(".slideoutBtn").remove()
            $("#topbar").css("text-align":'center')
    submit: (e)->
        e.preventDefault()
        name = $.trim @name
        if not name
            return

        $user.updateProfile(
            displayName: name
        ).then(
            (user)->
                $user.displayName = name
                URL "/"
            (err)->
                console.log err.code
        )
}
