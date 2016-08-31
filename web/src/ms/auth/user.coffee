
store = require 'store'

html = $ require("./_base.coffee")
html.find('.txt').html require('./_name.slm')

MS 'auth-user', html.html(), {
    slogo:"个人资料"
    name:""
    onReady: ->
        name = $user.displayName
        if name
            @name = name
        else
            $(".slideoutBtn").remove()
            $("#topbar").css("text-align":'center')
    submit: (e)->
        e.preventDefault()
        if not @name
            return
        console.log @name
}
