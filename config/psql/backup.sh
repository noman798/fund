PREFIX=$(cd "$(dirname "$0")"; pwd)

BACKUP=/data/backup
DATE=`date +%w`

if [ $DATE -eq 2 ]; then
    psql=psql.full.sh
else
    psql=psql.sh
fi

$PREFIX/pg_rman/$psql
# sudo -H -u postgres borg init $BACKUP/psql_borg
sudo -H -u postgres borg create  --compression lzma,3 -v --stats $BACKUP/psql_borg::backup-`date +%Y-%m-%d` $BACKUP/psql
sudo -H -u postgres borg prune -v $BACKUP/psql_borg --prefix backup- --keep-daily=7 --keep-weekly=4 --keep-monthly=1200
sudo -H -u postgres b2upload --bucket psql-borg --directory /data/backup/psql_borg
