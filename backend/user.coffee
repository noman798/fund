#! /usr/bin/coffee

wapi = require("./_wapi.coffee")
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
