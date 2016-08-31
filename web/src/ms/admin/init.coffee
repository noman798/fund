html = $ """<div><style>#{require("./init.scss")}</style>#{require("slm/_topbar")}#{require("./init.slm")}</div>"""
MS 'admin-init', html.html(), {
    slogo:"管理后台"
    loading:0
    q:""
    submit: (e)->
        e.preventDefault()
        q = $.trim @q
        console.log q
        if not q
            $(@$element).find('input').focus()
            return
        @loading = 1
}
