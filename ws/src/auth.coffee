module.exports = {
    init:->
        console.log init
    test : {
        a: (b,c=1)->
            console.log(b,">>", c)
    }
}
