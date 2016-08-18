
avalon.component('ms-auth',{
    template:require("./view.slm")
    defaults: {
        onReady: ->
            $("#topbar").css("text-align","center")
        onDispose:->
            delete avalon.vmodels[@$id]
    }
})



