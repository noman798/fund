
html = $ """<div>#{require("slm/_topbar")}#{require("./init.slm")}</div>"""
MS 'admin-init', html.html(), {
    slogo:"管理后台"
    submit: (e)->
        e.preventDefault()
}
