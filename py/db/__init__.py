from ztz.db.sync.q import QDb
from ztz.db.sync_patch import MongoClient
from config import CONFIG

MONGO_URL = "mongodb://%s:%s@%s:%s/?authMechanism=SCRAM-SHA-1" % (
    CONFIG.MONGO.USER,
    CONFIG.MONGO.PASSWORD,
    CONFIG.MONGO.HOST,
    CONFIG.MONGO.PORT
)
MONGO_DB = MongoClient(MONGO_URL)
DB = getattr(MONGO_DB, CONFIG.MONGO.DB)

Q = QDb(DB)

if __name__ == "__main__":
    pass
