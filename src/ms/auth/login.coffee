MS 'auth-login', require("./login.slm"), {
    onReady:->
        $(@$element).find('.close').click ->
            URL ""
}


