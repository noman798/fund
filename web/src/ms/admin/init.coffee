require("./init.scss")
require("scss/util/_bar")

html = $ """<div>#{require("slm/_topbar")}#{require("./init.slm")}</div>"""
MS 'admin', html.html(), {
    onReady: ->
        elem = $(@$element)
        WS.auth_import "admin", ->
            F.admin.user_share().then (sum, li)->

                _ = $.html()
                share_sum = 0
                li.sort (a,b)->
                    b[3] - a[3]

                for [id, name, mail, share] in li
                    share_sum += share
                    _ """<div class=bar><div class="I I-cash"></div>#{$.escape name}<b class=mail>#{$.escape mail}</b><div class=tip><span class=ml4>#{share.toFixed(2)}</span></div></div>"""

                elem.find(".userLi").html _.html()

                elem.find(".sum .num").text sum
                if Math.abs(sum - share_sum) > 1
                    alert "数据库异常：份额合计 user_share_sum #{sum} 与 用户的share挨个加 #{share_sum} 对不上 ！！！"


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
