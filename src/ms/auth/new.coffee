
html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./new.slm")

MS 'auth-new', html.html(), {
    onReady:->
        $.getScript(
            "//cdn.wilddog.com/js/client/v2/wilddog-web-all.js"
            ->
                config = {
                    authDomain: "u88.wilddogapp.com",
                    databaseURL: "//u88.wilddogio.com"
                }
                defApp = wilddog.initializeApp(config)
                rootRef = wilddog.database().ref()
                email = "x@xx.com"
                pwd = "xxx22"
                wilddog.auth().signInWithEmailAndPassword(email,pwd).then((a, b) ->
                    console.info("login success->", a, b)
                    console.info("currentUser->",wilddog.auth().currentUser)
                ).catch (a, b) ->
                    console.info('login failed ->', a, b)
        )

    account:"xx"
    password:""
    submit: (e)->
        console.log @account
        console.log @password
        e.preventDefault()

}
