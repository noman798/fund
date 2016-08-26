body = $ 'body'

_CACHE = 0

_body = (html)->
    if not _CACHE
        body.html ''
    V.BODY.HTML = html

MAP = {
    "": ->
        if $user
            page = "body"
        else
            page = "auth"

        require("async-module!../ms/#{page}/init.coffee") ->
            # _body """<ms-#{page} :widget="{$id:'#{page}',cached:'true'}"/>"""
            _body """<ms-#{page} :widget="{$id:'#{page}'}"/>"""
    "/auth/logout":->
        wilddog.auth().signOut()
        $('html').removeClass('slideout-open')
        window.$user = 0
        URL "/"
}

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

_render 'authLogin'
_render 'authNew', 0
_render 'authReset', 0


URL.map MAP
