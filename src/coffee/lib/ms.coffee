
window.MS = (name, slm, defaults)->
    avalon.component('ms-'+name,{
        template: slm
        defaults: defaults
    })
