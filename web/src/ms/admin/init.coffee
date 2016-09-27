require("./init.scss")

html = $ """<div>#{require("slm/_topbar")}#{require("./init.slm")}</div>"""
MS 'admin', html.html(), {
    onReady: ->
        WS.login_import "admin", ->
            F.admin.user_share().then (total, li)->
                for [id, name, mail, share] in li
                    console.log id, name, mail, share
                console.log total, li

    slogo:"管理后台"
    loading:0
    q:""
    submit: (e)->
        e.preventDefault()
        q = $.trim @q
        if not q
            $(@$element).find('input').focus()
            return
        @loading = 1
}
