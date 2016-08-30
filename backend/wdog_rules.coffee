USER_IS_ADMIN = "(root.hasChild('adminGroup') && root.child('adminGroup').child(auth.uid).val() == true)"

ADMIN_GROUP_RW = "(!root.hasChild('adminGroup')) || #{USER_IS_ADMIN}"

module.exports = \
{
    rules: {
        $read: false
        $write: false
        adminGroup: {
            $read: ADMIN_GROUP_RW
            $write: ADMIN_GROUP_RW
            # $validate : "newData.val().isBoolean()"
        }
        adminLog:{
            $read: USER_IS_ADMIN
            $write: USER_IS_ADMIN
        }
    }
}
