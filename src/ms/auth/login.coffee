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
        account = $.trim @account
        password = $.trim @password
        if not (account and password)
            return
        wilddog.auth().signInWithEmailAndPassword(
            account
            password
        ).then(->
            window.$user = wilddog.auth().currentUser
            URL '/'
        ).catch (err) =>
            if err.code == "invalid_password"
                @err = "帐号或密码错误"

}


