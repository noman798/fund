
window.MS = (name, slm, defaults)->
    avalon.component('ms-'+name,{
        template: "<div>#{slm}</div>"
        defaults: defaults
    })
