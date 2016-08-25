html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./login.slm")

MS 'auth-login', html.html() , {
    title:"登录"
    onReady:->
        console.log "login !!"
}


