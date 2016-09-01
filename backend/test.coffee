
CONFIG = require('./config.coffee')
Wilddog = require("wilddog")
WilddogTokenGenerator = require("wilddog-token-generator")
request = require('request')

tokenGenerator = new WilddogTokenGenerator(CONFIG.WILDDOG.KEY)

token = tokenGenerator.createToken({uid: "0"}, {admin:true,expires: new Date().getTime() + 100000000})

URL = "https://#{CONFIG.WILDDOG.SITE}.wilddogio.com/"

path = """#{URL}.auth/users.json?auth=#{token}&limit=1&start=0"""
console.log path
request.get(
    path
    (error, response, body) ->
        body = JSON.parse(body)
        console.log body
        console.log error
        process.exit()
)

# DB = new Wilddog()
