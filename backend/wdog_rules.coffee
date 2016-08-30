USER_IS_ADMIN = "root.child('adminGroup').child(auth.uid).val() == true"

ADMIN_GROUP_RW = "#{USER_IS_ADMIN} || (!root.hasChild('adminGroup'))"


module.exports = \
{
    rules: {
        $read: false
        $write: false
        adminGroup: {
            $read: ADMIN_GROUP_RW
            $write: ADMIN_GROUP_RW
            $validate : "newData.isNumber() && newData.val().isBoolean()"
        }
        adminLog:{
            $read: USER_IS_ADMIN
            $write: USER_IS_ADMIN
        }
    }
}
