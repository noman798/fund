store = require 'store'

html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./_input.slm")+require("./login.slm")

MS 'auth-reset', html.html() , {
    title:"重置密码"
    account:''
    err:""
    onReady:->
        @account = store.get('account','')
    submit: (e)->
        e.preventDefault()
        elem = $(@$element)
        @err = ""
        account = $.trim @account
        if not (account and password)
            return
        wilddog.auth().signInWithEmailAndPassword(
            account
            password
        ).then(->
            window.$user = wilddog.auth().currentUser
            URL '/'
        ).catch (err) =>
            @err = "帐号或密码错误"

}


