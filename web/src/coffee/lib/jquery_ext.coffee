
$.extend(
    html : ->
        r = []
        _ = (o) -> r.push o
        _.html = -> r.join ''
        _
)
