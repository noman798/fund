require "../../js/crossroads.js"

$ ->
    $(document.body).on 'click', 'a', ->
        false

    URL.init()

crossroads.bypassed.bind (url)->
    try
        require("async-module!url/#{url}.coffee")(
            (f) -> f()
        )
    catch
        URL '/'
        return

crossroads.shouldTypecast = true

_pre_url = 0
_pre_pre_url = 0

_track = (url)->
    _hmt.push(['_trackPageview', url])


window.URL = (url, title)->
    _track url
    history.pushState(null, title or document.title, url)
    if url.charAt(0) == "/"
        url = url.slice(1)
    URL.fire url.split("#")[0]

URL.history = {}

URL.remember = ->
    if _pre_pre_url != _pre_url and _pre_pre_url!=0
        _push _pre_url, _pre_pre_url

_push = (url, pre)->
    _history = URL.history
    if url not of _history
        _history[url] = []
    _history[url].push(pre)

_pop = (url) ->
    _history = URL.history
    if url of _history
        array = _history[url]
        if array.length == 1
            delete _history[url]
        return array.pop()


URL.back = (url)->
    path = _pop(url) or ''
    history.replaceState(null, undefined, "/"+path)
    _pre_url = path
    crossroads.resetState()


URL.fire = (url)->
    url = ""+url
    if url == _pre_url
        return
    _pre_pre_url = _pre_url
    _pre_url = url
    crossroads.parse url

URL.map = (url, callback)->
    if $.isPlainObject(url)
        obj = url
        for url, callback of obj
            crossroads.addRoute url, callback
    else
        crossroads.addRoute url, callback

fire = ->
    path = location.pathname.slice(1)
    URL.fire path

win = $(window)

URL.replace = (url , title)->
    _track url
    win.unbind 'popstate',fire
    history.replaceState(null, title or document.title, "/"+url)
    win.on 'popstate',fire

URL.init = ->
    fire()
    win.on "popstate", fire

    $("body").on("click", "a", ->
        if @hostname == location.hostname and not $(@).hasClass('jump')
            url = @pathname
            hash = @hash
            if hash
                url += hash
            URL url
            false
    )




