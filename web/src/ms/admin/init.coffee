require("./init.scss")

html = $ """<div>#{require("slm/_topbar")}#{require("./init.slm")}</div>"""
MS 'admin', html.html(), {
    onReady: ->
        elem = $(@$element)
        WS.login_import "admin", ->
            F.admin.user_share().then (sum, li)->
                for [id, name, mail, share] in li
                    console.log id, name, mail, share
                console.log sum, li
                _ = $.html()
                elem.find(".userLi").html _.html()
                elem.find(".sum .num").text sum
    # .bar
    #   .I.I-cash
    #   | 云梦
    #   b.mail manx@xpure.foxmail
    #   .tip
    #     span.ml4  2239922.3


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
