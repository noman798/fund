module.exports = ->
    $("#sB").click()
    wilddog.auth().signOut()
    window.$user = 0
    URL "/"
