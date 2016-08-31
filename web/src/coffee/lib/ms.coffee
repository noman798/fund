window.MS = (name, slm, defaults)->
    onDispose = defaults.onDispose
    defaults.onDispose = ->
        onDispose?.call @
        delete avalon.vmodels[@$id]

    id = "ms-#{name}"
    avalon.component(id, {
        template: """<div id="#{id}">#{slm}</div>"""
        defaults: defaults
    })
