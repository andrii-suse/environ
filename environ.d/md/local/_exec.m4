memcached -d -U __port -p 0 -vv -P __workdir/.pid > __workdir/.cout 2>__workdir/.cerr &

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
