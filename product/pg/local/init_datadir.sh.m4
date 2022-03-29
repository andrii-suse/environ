[ -d __datadir ] || mkdir __datadir

initdb --auth-local=peer -N __datadir -U "__user" >/dev/null

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
