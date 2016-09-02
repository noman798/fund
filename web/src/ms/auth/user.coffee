
html = $ require("./_base.coffee")
html.find('.txt').html require('./_name.slm')

MS 'auth-user', html.html(), {
    slogo:"个人资料"
    err:""
    name:""
    onReady: $login ->
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
        self = @
        $user.updateProfile(
            displayName: name
        ).then(
            (user)->
                require("async-module!coffee/wdog/idNew.coffee") (func) ->
                    func(
                        ->
                            $user.displayName = name
                            URL "/"
                    )
            (err)->
                message = {
                    "display_name_length_error":"名字最多十六字"
                }[err.code] or err.message
                self.err = message
        )
}
