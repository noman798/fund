#! /usr/bin/coffee

wapi = require("./wapi.coffee")

CONFIG = require "../config.coffee"
Wilddog = require("wilddog")
DB = new Wilddog("https://#{CONFIG.WILDDOG.SITE}.wilddogio.com/")

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
