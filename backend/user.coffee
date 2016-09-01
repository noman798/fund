wapi = require("./_wapi.coffee")
wapi.get(
    ".auth/users"
    (error, res, body)->
        body = JSON.parse(body)
        console.log(body)
        process.exit()
)
