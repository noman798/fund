cd /data/backup/psql
pg_rman=/usr/lib/postgresql/9.5/bin/pg_rman
sudo -u postgres $pg_rman backup -B /data/backup/psql --pgdata=/data/psql -b full -p 30009
sudo -u postgres $pg_rman validate -B /data/backup/psql 
