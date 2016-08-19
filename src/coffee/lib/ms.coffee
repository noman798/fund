
window.MS = (name, slm, defaults)->
    defaults.main = ""
    avalon.component('ms-'+name,{
        template: slm
        defaults: defaults
    })
