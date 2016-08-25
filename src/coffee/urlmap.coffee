require("../ms/body/view.coffee")

body = $ 'body'

MAP = {
    "": ->
        body.html ''
        V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"></ms-body>"""
}

_render = (name, cache=1) ->
    hname = avalon.hyphen(name)
    file = "/"+hname.replace(/-/g,'/')
    if cache
        cache =",cached:'true'"
    else
        cache = ''
    MAP[file] = ->
        require("bundle!../ms#{file}.coffee") ->
            body.html ''
            V.BODY.HTML = """<ms-#{hname} :widget="{$id:'#{name}'#{cache}}"/>"""

_render 'authLogin'
_render 'authNew', 0


URL.map MAP
