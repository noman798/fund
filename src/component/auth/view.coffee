
avalon.component('ms-auth',{
    template:require("../slm/auth.slm")
    defaults: {
        onReady: ->
            $("#topbar").css("text-align","center")
        onDispose:->
            delete avalon.vmodels[@$id]
    }
})



