user_json = require "./user.json"


begin = 9007199254740992
begin_line = 0

total = 0
for [user_id, user_name, user_mail, li] in user_json
    count = 0
    for line in li
        console.log line
        time = new Date(line[4]).getTime()
        if time < begin
            begin = time
            begin_line = [user_id, line]

        count += line[1]
    console.log user_id, user_name, count
    total += count

console.log total
console.log begin_line
