COFNIG = {
    WILDDOG:{
        KEY : "J7iGBi11S8fuT3fzdfBRbCkh8Jql6mmx4JhY13gZ"
        DB : "u88"
    }
}
Wilddog = require("wilddog")
WilddogTokenGenerator = require("wilddog-token-generator")
request = require('request')

tokenGenerator = new WilddogTokenGenerator(COFNIG.WILDDOG.KEY)

token = tokenGenerator.createToken({uid: "0"}, {admin:true,expires: new Date().getTime() + 100000000})

URL = "https://#{COFNIG.WILDDOG.DB}.wilddogio.com/"

request(
    """#{URL}.auth/users.json?auth=#{token}&orderBy="createTime"&limitToLast=1&limit=1&start=0"""
    (error, response, body) ->
        body = JSON.parse(body)
        user = body.userList.pop()
        console.log user.userId, user.email
        process.exit()
)

# DB = new Wilddog()
# DB.authWithCustomToken(
#     token
#     ->
#         DB.child('.auth').on('value', (o)->
#             console.log o.val()
#         )
# )

