

URL.map {
    "": ->
        V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"/>"""
    "/auth/new": ->
    "/auth/login": ->
        require("../ms/auth/login.coffee")
        V.BODY.HTML = """<ms-login :widget="{$id:'login',cached:'true'}"/>"""
}
