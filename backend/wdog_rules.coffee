module.exports = \
{
    "rules": {
        ".read": true,
        ".write": true,
        "admin": {
            ".read": true,
            ".write": "0 == auth.uid"
        }
    }
}