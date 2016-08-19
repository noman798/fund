
URL.map {
    "/auth/new": ->
        V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"></ms-body>"""
    "/auth/login": ->
        V.BODY.HTML = """<ms-authLogin :widget="{$id:'authLogin',cached:'true'}"></ms-authLogin>"""
}
