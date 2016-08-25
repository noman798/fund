store = require 'store'

html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./_input.slm")+require("./login.slm")

MS 'auth-login', html.html() , {
    title:"登录"
    account:""
    password:""
    err:""
    submit: (e)->
        e.preventDefault()
        elem = $(@$element)
        console.log store.get('account'),"!!"
}


