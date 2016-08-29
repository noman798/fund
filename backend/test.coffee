COFNIG = {
    WILDDOG:{
        KEY : "J7iGBi11S8fuT3fzdfBRbCkh8Jql6mmx4JhY13gZ"
        DB : "u88"
    }
}
Wilddog = require("wilddog")
DB = new Wilddog("https://#{COFNIG.WILDDOG.DB}.wilddogio.com/")

DB.set(
    test:{ '.sv':'timestamp' }
).then (o)->
    process.exit()
# wApp = wilddog.initializeApp(
    # authDomain: "#{COFNIG.WILDDOG.DB}.wilddog.com",
    # databaseURL: "//#{COFNIG.WILDDOG.DB}.wilddogio.com"
# )
# DB = wilddog.database().ref()

# window.$user = wilddog.auth().currentUser

