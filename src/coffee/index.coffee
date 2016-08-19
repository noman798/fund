require "../component/body/view.coffee"

V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"></ms-body>"""

URL.map {
    "/auth/new": ->
        V.body.main = "xx"
    "/auth/login": ->
        console.log "login"
}
$ ->
    URL.init()
