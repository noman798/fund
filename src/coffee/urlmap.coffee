
require("../ms/body/view.coffee")

URL.map {
    "": ->
        V.BODY.HTML = """<ms-body :widget="{$id:'body',cached:'true'}"/>"""
    "/auth/new": ->
    "/auth/login": ->
        require("../ms/auth/login.coffee")
        V.BODY.HTML = """<ms-auth-login :widget="{$id:'authLogin',cached:'true'}"/>"""
}
