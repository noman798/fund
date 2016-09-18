uuid = require('uuid')
base64url = require('base64url')
wilddog = require "wilddog"
config = {
    authDomain: "u88.wilddog.com",
    syncURL: "https://u88.wilddogio.com"
}
wilddog.initializeApp(config)
password = base64url(uuid.parse(uuid.v4()))

mail = "zsp.042@gmail.com"
wilddog.auth().createUserWithEmailAndPassword(mail, password).then((user) ->
    wdog_id = "0000"+user.uid
    mail = user.email
    name = user.email.split("@")[0]
    console.info 'user created.', wdog_id, mail, name
).catch (err) ->
    console.info 'create user failed.', err


