WS.import "auth", ->
    token = wilddog.auth().currentUser.getToken()
    console.log token
