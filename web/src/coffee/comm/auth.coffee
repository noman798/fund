WS.import "auth", ->
    token = wilddog.auth().currentUser.getToken()
    F.auth.init token

wilddog.auth().onAuthStateChanged (user) ->
    window.$user = user
    if not user
        return
    if not user.displayName
        URL "/auth/user"

