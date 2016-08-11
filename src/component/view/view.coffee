
avalon.component('ms-view',{
    template:require("./view.slm")
    defaults: {
        content: ""
        onDispose:->
            delete avalon.vmodels[@$id]
    }
})



