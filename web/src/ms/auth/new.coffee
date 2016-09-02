html = $ require("./_base.coffee")
html.find('.txt').html require("./_input.slm")+require("./new.slm")

MS 'auth-new', html.html(), {
    title:"注册"
    account:""
    password:""
    err:""
    submit: (e)->
        e.preventDefault()
        elem = $(@$element)
        self = @
        @err = ""

        account = $.trim @account
        password = $.trim @password
        if not (account and password)
            return
        wilddog.auth().createUserWithEmailAndPassword(
            account, password
        ).then((user)->
            store.set('account', account)
            userIdNew = wDB.ref("userIdNew")
            data = {}
            data[user.uid] = user.email
            userIdNew.update(
                data
                (o,err)->
                    elem.find('.authBk').html require("./new_done.slm")
            )
        ).catch (err) ->
            code = err.code
            _tiper = ->
                console.log err.code
                self.err = tip = {
                    invalid_arguments:"请输入密码"
                    authentication_disabled:"请输入邮箱"
                    email_already_in_use:"邮箱已注册"
                    invalid_email:"邮箱无效"
                    password_character_error:"密码应由数字和字母组成"
                    password_length_error:"密码长度为6到16位"
                }[code] or err.message
                elem.find('input').removeClass('err')
                elem.find(
                    "#auth#{if tip.indexOf("邮箱") >= 0 then "Account" else "Password"}"
                ).addClass('err').focus().one(
                    'change'
                    ->
                        $(@).removeClass('err')
                )
            if code == "email_already_in_use"
                wilddog.auth().signInWithEmailAndPassword(
                    self.account
                    self.password
                ).then(->
                    window.$user = wilddog.auth().currentUser
                    URL '/'
                ).catch(err) -> _tiper()
            else
                _tiper()

}
