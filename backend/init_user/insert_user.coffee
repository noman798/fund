uuid = require('uuid')
base64url = require('base64url')
wilddog = require "wilddog"

process.env.NODE_PATH += (":"+__dirname+"/../../ws/src/")
require('module').Module._initPaths()

PG = require "pg.coffee"

config = {
    authDomain: "u88.wilddog.com",
    syncURL: "https://u88.wilddogio.com"
}
wilddog.initializeApp(config)

module.exports = (mail)->
    password = base64url(uuid.parse(uuid.v4()))
    wilddog.auth().createUserWithEmailAndPassword(mail, password).then((user) ->
        wdog_id = "0000"+user.uid
        mail = user.email
        name = user.email.split("@")[0]
        console.info 'NEW', wdog_id, mail, name

        PG.raw(
            "INSERT INTO public.user (wdog_id, mail, name) VALUES (?, ?, ?) ON CONFLICT (wdog_id) DO UPDATE SET mail = ?, name = ? RETURNING id"
            [
                wdog_id
                mail
                name
                mail
                name
            ]
        )

    ).catch (err) ->
        console.info 'create user failed.', err


