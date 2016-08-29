COFNIG = {
    WILDDOG:{
        KEY : "J7iGBi11S8fuT3fzdfBRbCkh8Jql6mmx4JhY13gZ"
        DB : "u88"
    }
}
Wilddog = require("wilddog")
WilddogTokenGenerator = require("wilddog-token-generator")
request = require('request')

request(
    'http://www.baidu.com'
    (error, response, body) ->
        if not error and response.statusCode == 200
            console.log(body)
            process.exit()
)

tokenGenerator = new WilddogTokenGenerator(COFNIG.WILDDOG.KEY)

token = tokenGenerator.createToken({uid: "0"}, {admin:true,expires: new Date().getTime() + 100000000})
DB = new Wilddog("https://#{COFNIG.WILDDOG.DB}.wilddogio.com/")
DB.authWithCustomToken(
    token
    ->
        DB.child('.auth').on('value', (o)->
            console.log o.val()
        )
)

