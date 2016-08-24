
html = $ """<div>#{require("./_base.slm")}</div>"""
html.find('.txt').html require("./new.slm")

MS 'auth-new', html.html(), {
    title:"注册"
    account:""
    password:""
    err:""
    submit: (e)->
        e.preventDefault()
        wilddog.auth().createUserWithEmailAndPassword(@account, @password).then((user)->
            console.info("user created.", user)
        ).catch (err) =>
            @err = tip = {
                invalid_arguments:"请输入密码"
                authentication_disabled:"请输入邮箱"
                email_already_in_use:"邮箱已注册"
                invalid_email:"邮箱无效"
            }[err.code] or err.message
            elem = $(@$element)
            elem.find('input').removeClass('err')
            elem.find("#auth#{if tip.indexOf("邮箱") >= 0 then "Account" else "Password"}").addClass('err').focus().one(
                'change'
                ->
                    $(@).removeClass('err')
            )

}
