require '../scss/comm.scss'

require "avalon2"


avalon.component('ms-view',{
    template:"""<div class="view"><slot name="content" /></div>"""
    defaults: {
        content: ""
    }
})


window.vm = avalon.define(
    $id: "app",
    name: "司徒正美",
    array: [11,22,33]
)
