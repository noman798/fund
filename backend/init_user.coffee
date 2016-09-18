uuid = require('uuid')
base64url = require('base64url')
wilddog = require "wilddog"
config = {
    authDomain: "u88.wilddog.com",
    syncURL: "https://u88.wilddogio.com"
}
wilddog.initializeApp(config)
password = base64url(uuid.parse(uuid.v4()))

console.log password
mail = "z@x.com"
wilddog.auth().createUserWithEmailAndPassword(mail, password).then((user) ->
    console.info 'user created.', user
).catch (err) ->
    console.info 'create user failed.', err


