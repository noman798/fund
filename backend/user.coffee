#! /usr/bin/coffee

CONFIG = require("./config")
wapi = require("./wapi.coffee")(CONFIG.WILDDOG.SITE, CONFIG.WILDDOG.KEY)


# fetchUser = (callback, end, begin=0) ->
#     wapi.get(
#         ".auth/users"
#         {
#             limit:5
#             start:begin
#         }
#         (error, res, body)->
#             body = JSON.parse(body)
#             userList = body.userList
#             begin += userList.length
#             if callback(userList)
#                 return
#             if begin < body.userCount
#                 fetchUser(callback, end, begin)
#             else
#                 end?()
#     )

Wilddog = require("wilddog")

DB = new Wilddog(wapi.url)

DB_USER_ID_EMAIL = DB.child("userIdEmail").ref()

_save = (user) ->
    if user.email
        data = {}
        data[user.userId] = user.email
        DB_USER_ID_EMAIL.update(data)

DB.authWithCustomToken(
    wapi.token()
    ->
        _userInit = (o)->
            wapi.get(
                ".auth/users/#{o.val()}"
                (error, res, body)->
                    console.log(JSON.parse(body))
            )

        userIdNew = DB.child('userIdNew').ref()
        userIdNew.on('child_added', _userInit)
        userIdNew.on('child_changed', _userInit)

)

