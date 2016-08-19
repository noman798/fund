

URL.map {
    "/auth/new": ->
    "/auth/login": ->
        require("../ms/auth/login.coffee")
        V.BODY.HTML = """<ms-login :widget="{$id:'login',cached:'true'}"/>"""
}
