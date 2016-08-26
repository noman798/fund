
window.MS = (name, slm, defaults)->
    console.log slm
    onDispose = defaults.onDispose
    defaults.onDispose = ->
        onDispose?.call @
        delete avalon.vmodels[@$id]

    avalon.component('ms-'+name,{
        template: "<div>#{slm}</div>"
        defaults: defaults
    })
