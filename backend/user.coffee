#! /usr/bin/coffee

CONFIG = require("./config")
wapi = require("./wapi.coffee")(CONFIG.WILDDOG.SITE, CONFIG.WILDDOG.KEY)

Wilddog = require("wilddog")

DB = new Wilddog(wapi.url)

DB.once('value', (o)->
    console.log o.val()
)

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
            for i in userList
                callback(i)
            if begin < body.userCount
                fetchUser(callback, end, begin)
            else
                end()
    )

fetchUser(
    (user)->
        console.log user
    ->
        process.exit()
)
