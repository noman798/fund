PREFIX=$(cd "$(dirname "$0")"; pwd)

BACKUP=/data/backup
DATE=`date +%w`

sudo -H -u postgres pg_dumpall -p 30009 > /data/backup/psql/data.sql

sudo -H -u postgres borg create  --compression lzma,3 -v --stats $BACKUP/psql_borg::backup-`date +%Y-%m-%d` $BACKUP/psql
sudo -H -u postgres borg prune -v $BACKUP/psql_borg --prefix backup- --keep-daily=7 --keep-weekly=4 --keep-monthly=1200
sudo -H -u postgres rclone sync $BACKUP/psql_borg/ b2:tzol-backup/psql_borg
sudo -H -u postgres rsync $BACKUP/psql_borg dev@u88.vc:/home/dev/backup -avz
