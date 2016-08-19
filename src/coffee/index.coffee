require "../ms/body/view.coffee"

V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"/>"""

require "./urlmap.coffee"

$ ->
    URL.init()
