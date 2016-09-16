from ztz.db.sync.q import QDb
from ztz.db.sync_patch import MongoClient
from config import CONFIG

MONGO_DB = MongoClient(CONFIG.MONGO.HOST + ":" + str(CONFIG.MONGO.PORT))
DB = getattr(MONGO_DB, CONFIG.MONGO.DB)
DB.authenticate(CONFIG.MONGO.USER, CONFIG.MONGO.PASSWORD, mechanism='SCRAM-SHA-1')

Q = QDb(DB)

if __name__ == "__main__":
    pass
