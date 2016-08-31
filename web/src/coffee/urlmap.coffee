body = $ 'body'

_CACHE = 0
_pre  =  ''
_body = (html)->
    if html == _pre
        return
    _pre = html
    if not _CACHE
        body.html ''
    V.BODY.HTML = html

_render = (name, cache=1) ->
    hname = avalon.hyphen(name)
    file = "/"+hname.replace(/-/g,'/')
    if cache
        cache =",cached:'true'"
    else
        cache = ''
    MAP[file] = ->
        require("async-module!../ms#{file}.coffee") ->
            _body """<ms-#{hname} :widget="{$id:'#{name}'#{cache}}"/>"""
            _CACHE = cache

MAP = {
    "": ->
        if $user
            page = "body"
        else
            page = "auth"
        require("async-module!../ms/#{page}/init.coffee") ->
            _CACHE = 0
            _body """<ms-#{page} :widget="{$id:'#{page}'}"/>"""
            # _body """<ms-#{page}/>"""
            # _body """<ms-#{page} :widget="{$id:'#{page}',cached:'true'}"/>"""

}

_render 'authLogin'
_render 'authNew', 0
_render 'authReset', 0
_render 'authInit'

URL.map MAP

