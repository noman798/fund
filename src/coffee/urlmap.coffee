
URL.map {
    "/auth/new": ->
        V.body.main = "xx"
    "/auth/login": ->
        console.log "login"
}
