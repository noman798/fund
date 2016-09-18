module.exports = (func)->
    if @ID
        return func.apply(@, arguments)
    else
        @send "/ auth/login"
        0
