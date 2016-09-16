module.exports = {
    init:->
        console.log init
    test : {
        a: (b,c=1)->
            r = b+c
            console.log(b,"+", c, "=", r)
            r
    }
}
