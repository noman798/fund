_auth = Signal()
WS.auth = (func)->
    _auth.bind func

WS.auth_import = (mod, func) ->
    WS.auth ->
        WS.import mod, func


wilddog.auth().onAuthStateChanged (user) ->
    _user = $user

    window.$user = user

    if (not _user and user) or (not user and _user) or (user and user.uid != _user.uid)
        URL.fire(location.pathname)

    if not user
        return

    WS.import "auth", ->
        token = wilddog.auth().currentUser.getToken()
        F.auth.init(token).then ->
            _auth.send()
            WS.auth = (func)->
                func()

    if not user.displayName
        URL "/auth/user"
