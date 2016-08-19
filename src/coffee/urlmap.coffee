
URL.map {
    "/auth/new": ->
        require("../ms/auth/login.coffee")
        V.BODY.HTML = """<ms-authLogin :widget="{$id:'authLogin',cached:'true'}"></ms-authLogin>"""
    "/auth/login": ->
        console.log "login"
        require("../ms/auth/login.coffee")
        console.log "login2"
        V.BODY.HTML = """<ms-authLogin :widget="{$id:'authLogin',cached:'true'}"></ms-authLogin>"""
}
