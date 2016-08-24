
html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./new.slm")

MS 'auth-new', html.html(), {
    account:""
    password:""
    submit: (e)->
        wilddog.auth().createUserWithEmailAndPassword(@account, @password).then((user)->
            console.info("user created.", user)
        ).catch((err, more) ->
            console.info("create user failed.", err.code, more)
        )

        e.preventDefault()
        # wilddog.auth().signInWithEmailAndPassword(email,pwd).then((a, b) ->
        #     console.info("login success->", a, b)
        #     console.info("currentUser->",wilddog.auth().currentUser)
        # ).catch (a, b) ->
        #     console.log(a.code)
        #     console.log(a, typeof(a))
        #     console.info('login failed ->',  b, "!!")
    # onReady:->

}
