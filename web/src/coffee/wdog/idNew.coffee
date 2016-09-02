 module.exports = (callback, user)->
     user = user or $user
     userIdNew = wDB.ref("userIdNew")
     data = {}
     data[user.uid] = user.email
     userIdNew.update(
         data
         callback
     )
