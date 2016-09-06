PREFIX=$(cd "$(dirname "$0")"; pwd)
sudo cp $PREFIX/pg_rman.ini /data/backup/psql/pg_rman.ini
sudo chown postgres:postgres /data/backup/psql/pg_rman.ini -R
