
CONFIG = require('./config.coffee')
Wilddog = require("wilddog")
WilddogTokenGenerator = require("wilddog-token-generator")
request = require('request')

tokenGenerator = new WilddogTokenGenerator(CONFIG.WILDDOG.KEY)

token = tokenGenerator.createToken({uid: 0}, {
    admin:true,expires: new Date().getTime() + 100000000
})

URL = "https://#{CONFIG.WILDDOG.DB}.wilddogio.com/"

request.get(
    """#{URL}.settings/rules.json?auth=#{token}"""
    (error, response, body) ->
        body = JSON.parse(body)
        body = JSON.stringify(body, null, 4)
        console.log body
)


# request(
#     """#{URL}.auth/users.json?auth=#{token}&orderBy="createTime"&limitToLast=1&limit=1&start=2"""
#     (error, response, body) ->
#         body = JSON.parse(body)
#         user = body.userList.pop()
#         console.log user.userId, user.email
#         process.exit()
# )

# DB = new Wilddog()
# DB.authWithCustomToken(
#     token
#     ->
#         DB.child('.auth').on('value', (o)->
#             console.log o.val()
#         )
# )

