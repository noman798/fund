html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./login.slm")

MS 'auth-login', html.html() , {
    onReady:->
    title:"登录"

}


