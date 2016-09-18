uuid = require('uuid')
user_json = require "./user.json"
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

insert = (name, mail)->
    password = base64url(uuid.parse(uuid.v4()))
    wilddog.auth().createUserWithEmailAndPassword(mail, password).then((user) ->
        wdog_id = "0000"+user.uid
        mail = user.email
        wilddog.auth().signInWithEmailAndPassword(
            mail
            password
        ).then (user)->
            user.updateProfile(
                displayName:name
            ).then ->
                console.info 'NEW', wdog_id, mail, user.displayName
                PG.raw(
                    "INSERT INTO public.user (wdog_id, mail, name) VALUES (?, ?, ?) ON CONFLICT (wdog_id) DO UPDATE SET mail = ?, name = ? RETURNING id"
                    [
                        wdog_id
                        mail
                        name
                        mail
                        name
                    ]
                ).then (id)->
                    console.log id

    ).catch (err) ->
        console.info 'create user failed.', err


for [user_id, user_name, user_mail, li] in user_json
    insert(user_name, user_mail)
