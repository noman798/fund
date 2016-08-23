html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./new.slm")


MS 'auth-new', html.html(), {
    onReady:->
        $(@$element).find('.close').click ->
            URL ""
    account:"xx"
    password:""
    submit: ->
        console.log @account
        console.log @password
        false

}


