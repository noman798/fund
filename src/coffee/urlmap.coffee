require("../ms/body/view.coffee")


MAP = {
    "": ->
        V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"></ms-body>"""
}

_render = (name) ->
    hname = avalon.hyphen(name)
    MAP["/"+hname.replace(/-/g,'/')] = ->
        V.BODY.HTML = """<ms-#{hname} :widget="{$id:'#{name}',cached:'true'}"/>"""


require "../ms/auth/login.coffee"
_render 'authLogin'

require "../ms/auth/new.coffee"
_render 'authNew'


URL.map MAP
