set -e
master=$1

$1/status || ( echo "Master {$1} environ is down?" ; exit 1 ) >&2

rc=0
__workdir/status &>/dev/null || rc=$?

test $rc -gt 0 || ( echo 'Cannot setup replication when server is running {__workdir}' ; exit 1 ) >&2

$1/backup -D __workdir/dt || ( echo "Backup of master failed {$?}" ; exit 1 ) >&2

(
echo "listen_addresses=''"
echo "unix_socket_directories='__datadir'"
echo "fsync=off"
echo "full_page_writes=off"
echo wal_level=replica
echo max_wal_size=400MB
echo max_wal_senders=16
echo wal_keep_size=128MB
) >> __datadir/postgresql.conf

sed -i "s/`#'log_statement = 'none'/log_statement = 'all'/" __datadir/postgresql.conf

# echo "primary_conninfo = 'host=$1/dt user = $USER'"

# touch __datadir/standby.signal

# remove master's log created by baclup
test ! -f __datadir/.s.PGSQL.5432.lock || rm __datadir/.s.PGSQL.5432.lock
# remove master's logs
rm -r __datadir/log/*

__workdir/start

__workdir/status
