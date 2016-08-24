require("../ms/body/view.coffee")


MAP = {
    "": ->
        V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"></ms-body>"""
}

_render = (name) ->
    hname = avalon.hyphen(name)
    file = "/"+hname.replace(/-/g,'/')
    MAP[file] = ->
        require("bundle!../ms#{file}.coffee") ->
            V.BODY.HTML = """<ms-#{hname} :widget="{$id:'#{name}',cached:'true'}"/>"""

_render 'authLogin'
_render 'authNew'


URL.map MAP
