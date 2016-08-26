store = require 'store'

html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./reset.slm")

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
        if not account
            return
        wilddog.auth().sendPasswordResetEmail(
            account
        ).then(->
            #TODO
        ).catch (err) =>
            @err = "帐号不存在"

}


