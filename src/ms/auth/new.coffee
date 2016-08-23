
html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./new.slm")

MS 'auth-new', html.html(), {
    onReady:->
        $(@$element).find('.close').click ->
            URL ""
        config = {
            authDomain: "u88.wilddogapp.com",
            databaseURL: "//u88.wilddogio.com"
        }
        defApp = wilddog.initializeApp(config)
        rootRef = wilddog.database().ref()
    account:"xx"
    password:""
    submit: (e)->
        console.log @account
        console.log @password
        e.preventDefault()

}
