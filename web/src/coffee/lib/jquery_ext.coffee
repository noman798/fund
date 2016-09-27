
$.extend {
    escape : avalon.escapeHtml
    html : ->
        r = []
        _ = (o) -> r.push o
        _.html = -> r.join ''
        _
    isotime : (timestring) ->
        date = new Date(timestring * 1000)
        hour = date.getHours()
        minute = date.getMinutes()
        hour = "0" + hour  if hour < 9
        minute = "0" + minute  if minute < 9
        result = [date.getMonth() + 1, date.getDate()]
        now = new Date()
        full_year = date.getFullYear()
        result.unshift full_year  unless now.getFullYear() is full_year
        result.join("-") + " " + [hour, minute].join(":")
}
