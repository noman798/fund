
require("../ms/auth/login.coffee")
URL.map {
    "/auth/new": ->
        require("../ms/auth/login.coffee")
        V.BODY.HTML = """<ms-authLogin :widget="{$id:'authLogin',cached:'true'}"/>"""
    "/auth/login": ->
        console.log "login"
        console.log "login2"
        V.BODY.HTML = """<ms-authLogin :widget="{$id:'authLogin',cached:'true'}"/>"""
}
