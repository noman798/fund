require("../ms/body/view.coffee")

body = $ 'body'


_CACHE = 0

_body = (html)->
    if not _CACHE
        body.html ''
    V.BODY.HTML = html

MAP = {
    "": ->
        _body """<ms-body :widget="{$id:'body',cached:'true'}"></ms-body>"""
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
            _body """<ms-#{hname} :widget="{$id:'#{name}'#{cache}}"/>"""
            _CACHE = cache

_render 'authLogin'
_render 'authNew', 0


URL.map MAP
