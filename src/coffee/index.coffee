require "../component/body/view.coffee"

V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"></ms-body>"""

URL.map {
    "/auth/new": ->
        console.log "new"
    "/auth/login": ->
        console.log "login"
}
$ ->
    URL.init()
