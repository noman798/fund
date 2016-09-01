#! /usr/bin/coffee

CONFIG = require("./config")
wapi = require("./wapi.coffee")(CONFIG.WILDDOG.SITE, CONFIG.WILDDOG.KEY)


fetchUser = (callback, end, begin=0) ->
    wapi.get(
        ".auth/users"
        {
            limit:5
            start:begin
        }
        (error, res, body)->
            body = JSON.parse(body)
            userList = body.userList
            begin += userList.length
            if callback(userList)
                return
            if begin < body.userCount
                fetchUser(callback, end, begin)
            else
                end()
    )

Wilddog = require("wilddog")

DB = new Wilddog(wapi.url)

DB.authWithCustomToken(
    wapi.token()
    ->
        DB.child('userIdNew').on('child_added', (o)->
            console.log o
        )
        false
        return
        DB_USER_ID_EMAIL = DB.child("userIdEmail").ref()

        fetchUser(
            (userList)->
                if user.email
                    data = {}
                    data[user.userId] = user.email
                    DB_USER_ID_EMAIL.update(data)
                false
            ->
                process.exit()
        )
)

