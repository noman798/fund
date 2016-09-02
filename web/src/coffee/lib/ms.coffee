window.MS = (name, slm, defaults)->
    onDispose = defaults.onDispose
    defaults.onDispose = ->
        onDispose?.call @
        delete avalon.vmodels[@$id]

    onReady = defaults.onReady
    defaults.onReady = ->
        onReady?.call @
        $(".macS").scrollbar()

    id = "ms-#{name}"
    avalon.component(id, {
        template: """<div class="ms" id="#{id}">#{slm}</div>"""
        defaults: defaults
    })
