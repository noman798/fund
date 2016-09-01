#! /usr/bin/coffee

wapi = require("./wapi.coffee")(require("./config"))
console.log wapi.url

Wilddog = require("wilddog")

DB = new Wilddog(wapi.url)

DB.once('value', (o)->
    console.log o.val()
)

wapi.get(
    ".auth/users"
    {
        limit:1
        start:0
    }
    (error, res, body)->
        body = JSON.parse(body)
        console.log(body)
        process.exit()
)
