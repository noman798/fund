
URL.map {
    "/auth/new": ->
        V.BODY.HTML = """<ms-authLogin :widget="{$id:'authLogin',cached:'true'}"></ms-authLogin>"""
    "/auth/login": ->
        require("../component/auth/login.coffee")
        V.BODY.HTML = """<ms-authLogin :widget="{$id:'authLogin',cached:'true'}"></ms-authLogin>"""
}
