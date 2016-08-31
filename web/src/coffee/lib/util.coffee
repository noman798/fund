$.extend(
    window
    {
        $id : (id)->
            document.getElementById(id)
        $login : (func)->
            ->
                if not $user
                    URL "/"
                    return
                func.apply @, arguments


    }
)


