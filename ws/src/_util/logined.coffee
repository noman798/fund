module.exports = (func)->
    ->
        if @ID
            return func.apply(@, arguments)
        else
            @send "/ auth/login"
            return 0
