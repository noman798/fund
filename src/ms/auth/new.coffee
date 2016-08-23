_bind = avalon.bind


html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./new.slm")

console.log html.html()

MS 'auth-new', html.html(), {
    onReady:->
        $(@$element).find('.close').click ->
            URL ""
    account:"xx"
    password:""
    submit: (e)->
        console.log @account
        console.log @password
        e.preventDefault()

}
