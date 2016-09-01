#! /usr/bin/coffee

CONFIG = require("./config")
wapi = require("./wapi.coffee")(CONFIG.WILDDOG.SITE, CONFIG.WILDDOG.KEY)

Wilddog = require("wilddog")

DB = new Wilddog(wapi.url)

DB.once('value', (o)->
    console.log o.val()
)

begin = 0

wapi.get(
    ".auth/users"
    {
        limit:1
        start:begin
    }
    (error, res, body)->
        body = JSON.parse(body)
        begin += body.userList
        process.exit()

)
