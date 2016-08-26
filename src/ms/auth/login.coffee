store = require 'store'

html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./_input.slm")+require("./login.slm")

MS 'auth-login', html.html() , {
    title:"登录"
    account:''
    password:""
    err:""
    onReady:->
        @account = store.get('account','')
    submit: (e)->
        e.preventDefault()
        elem = $(@$element)
        @err = ""
        account = @account

        wilddog.auth().signInWithEmailAndPassword(
            @account
            @password
        ).then(->
            window.$user = wilddog.auth().currentUser
            URL '/'
        ).catch (err) ->
            #TODO 
            console.log err.code

}


