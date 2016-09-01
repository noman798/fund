USER_IS_ADMIN = "(root.child('adminGroup').child(auth.uid).val() == true)"

ADMIN_GROUP_RW = "(!root.hasChild('adminGroup')) || #{USER_IS_ADMIN}"

module.exports = \
{
    rules: {
        _read: false
        _write: false
        adminGroup: {
            _read: ADMIN_GROUP_RW
            _write: ADMIN_GROUP_RW
            $item:{
                _validate : "newData.isBoolean()"
            }
        }
        adminLog:{
            _read: USER_IS_ADMIN
            _write: USER_IS_ADMIN
        }
        userIdEmail:{
            _read:USER_IS_ADMIN
            _write:false
            _indexOn: ".value"
        }
        userIdNew:{
            _write: "$user_id == auth.uid"
            _read: "$user_id == auth.uid"
            $item:{
                _validate : "(newData.val() > (now-60000)) && (newData.val() < (now+60000))"
            }
        }
    }
}
