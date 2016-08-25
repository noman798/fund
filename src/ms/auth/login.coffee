store = require 'store'

html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./_input.slm")+require("./login.slm")

MS 'auth-login', html.html() , {
    title:"登录"
    account:""
    password:""
    err:""
}


