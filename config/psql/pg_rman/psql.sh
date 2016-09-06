cd /data/backup/psql
pg_rman=/usr/lib/postgresql/9.5/bin/pg_rman
sudo -u postgres $pg_rman backup -B /data/backup/psql --pgdata=/data/psql  -p 30009 --compress-data --progress
sudo -u postgres $pg_rman validate -B /data/backup/psql 
