MS 'auth', require("./init.slm"), {
    main:require("../auth/auth.slm")
    onReady: ->
        topbar = $("#topbar")
        topbar.css("text-align","center")
}

