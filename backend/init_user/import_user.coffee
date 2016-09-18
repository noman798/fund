user_json = require "./user.json"

total = 0
for [user_id, user_name, user_mail, li] in user_json
    count = 0
    for line in li
        count += line[1]
    console.log user_id, user_name, count
    total += count

console.log total
