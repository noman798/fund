CONFIG = require "../config.coffee"
Wilddog = require("wilddog")
DB = new Wilddog("https://#{CONFIG.WILDDOG.SITE}.wilddogio.com/")

DB.on('value', (o)->
    console.log o.val()
)
# wApp = wilddog.initializeApp(
    # authDomain: "#{CONFIG.WILDDOG.DB}.wilddog.com",
    # databaseURL: "//#{CONFIG.WILDDOG.DB}.wilddogio.com"
# )
# DB = wilddog.database().ref()

# window.$user = wilddog.auth().currentUser

