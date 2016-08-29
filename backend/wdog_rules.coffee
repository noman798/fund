USER_IS_ADMIN = "root.child('group').child('admin').child(auth.uid).val() == true"

GROUP_ADMIN_RW = "#{USER_IS_ADMIN} || (!root.hasChildren(['group','admin']))"


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
        admin_log:{
            ".read": USER_IS_ADMIN
            ".write": USER_IS_ADMIN
        }
    }
}
