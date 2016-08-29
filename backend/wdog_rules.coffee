GROUP_ADMIN = "root.child('group').child('auth.uid').val() == true"

GROUP_ADMIN_RW = "#{GROUP_ADMIN} || (!root.hasChildren(['group','admin']))"


module.exports = \
{
    rules: {
        ".read": true,
        ".write": true,
        group:
            admin: {
                ".read": GROUP_ADMIN_RW
                ".write": GROUP_ADMIN_RW
                ".validate" : "newData.isNumber() && newData.val().isBoolean()"
            }
    }
}
