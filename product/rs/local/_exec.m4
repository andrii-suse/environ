[ -d __datadir ] || mkdir -p __datadir
rsync --daemon --port=__port --config=__workdir/rsyncd.conf

[ -f __workdir/.pid ] || sleep 0.1 || \
[ -f __workdir/.pid ] || sleep 0.1 || \
[ -f __workdir/.pid ] || sleep 0.1 || \
[ -f __workdir/.pid ] || sleep 0.1 || \
[ -f __workdir/.pid ] || sleep 0.1
[ -f __workdir/.pid ]

kill -0 $(cat __workdir/.pid) || sleep 0.1 || \
kill -0 $(cat __workdir/.pid) || sleep 0.1 || \
kill -0 $(cat __workdir/.pid) || sleep 0.1 || \
kill -0 $(cat __workdir/.pid) || sleep 0.1 || \
kill -0 $(cat __workdir/.pid) || sleep 0.1 || \
kill -0 $(cat __workdir/.pid)
