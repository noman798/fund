#! /usr/bin/coffee

CONFIG = require("./config")
wapi = require("./wapi.coffee")(CONFIG.WILDDOG.SITE, CONFIG.WILDDOG.KEY)


fetchUser = (callback, end, begin=0) ->
    console.log begin
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
            for i in userList
                callback(i)
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
        DB_EMAIL_ID = DB.child("email_id").ref()

        fetchUser(
            (user)->
                if user.email
                    data = {}
                    data[user.userId] = user.email
                    DB_EMAIL_ID.update(data)
            ->
                process.exit()
        )
)


