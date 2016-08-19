require "../ms/body/view.coffee"
require "./urlmap.coffee"

V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"/>"""

$ ->
    URL.init()
