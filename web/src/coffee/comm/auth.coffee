
wilddog.auth().onAuthStateChanged (user) ->
    _user = $user

    window.$user = user

    if (not _user and user) or (not user and _user) or (user and user.uid != _user.uid)
        URL.fire(location.pathname)

    if not user
        return

    WS.import "auth", ->
        token = wilddog.auth().currentUser.getToken()
        F.auth.init token

    if not user.displayName
        URL "/auth/user"
