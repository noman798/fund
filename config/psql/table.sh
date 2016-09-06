PREFIX=$(cd "$(dirname "$0")"; pwd)
cd $PREFIX
pg_dump -p30009 -h127.0.0.1 -U u88 -s u88 > table.sql
