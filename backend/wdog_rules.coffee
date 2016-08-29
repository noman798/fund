GROUP_ADMIN = "root.child('group').child('auth.uid').val() == true"


module.exports = \
{
    rules: {
        ".read": true,
        ".write": true,
        group:
            admin: {
                ".read": true
                ".write": "#{GROUP_ADMIN} || (!root.hasChildren(['group','admin']))"
                ".validate" : "newData.isNumber() && newData.val().isBoolean()"
            }
    }
}
