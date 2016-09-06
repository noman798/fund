PREFIX=$(cd "$(dirname "$0")"; pwd)

BACKUP=/data/backup
DATE=`date +%w`

if [ $DATE -eq 2 ]; then
    psql=psql.full.sh
else
    psql=psql.sh
fi


/usr/lib/postgresql/9.5/bin/pg_dump -p 30009 -s u88 > psql.sql

$PREFIX/pg_rman/$psql
# sudo -H -u postgres borg init $BACKUP/psql_borg
sudo -H -u postgres borg create  --compression lzma,3 -v --stats $BACKUP/psql_borg::backup-`date +%Y-%m-%d` $BACKUP/psql
sudo -H -u postgres borg prune -v $BACKUP/psql_borg --prefix backup- --keep-daily=7 --keep-weekly=4 --keep-monthly=1200
sudo -H -u postgres rclone sync /data/backup/psql_borg/ b2:tzol-backup/psql_borg
sudo -H -u postgres rsync $BACKUP/psql dev@u88.vc:/home/dev/backup -avz
