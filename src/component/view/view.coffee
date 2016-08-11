
avalon.component('ms-auth',{
    template:require("./view.slm")
    defaults: {
        onDispose:->
            delete avalon.vmodels[@$id]
    }
})



