MS 'auth', require("slm/_main.slm"), {
    onReady: ->
        $(@$element).find('.MAIN').html require("../auth/auth.slm")
        topbar = $("#topbar")
        topbar.css("text-align","center")
}

