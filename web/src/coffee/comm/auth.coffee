WS.import "auth", ->
    token = wilddog.auth().currentUser.getToken()
    F.auth.init token
