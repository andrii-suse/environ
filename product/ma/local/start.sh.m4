set -e
[ -d __workdir/dt ] || mkdir __workdir/dt
[ -f __datadir/ibdata1 ] || __workdir/init_datadir

eatmydata=$(which eatmydata 2>/dev/null) || :

$eatmydata /usr/sbin/mariadbd --datadir=__datadir --user=$USER --socket=__workdir/.sock --skip-networking --disable-ssl --log-error=__workdir/.cerr --pid-file=__workdir/.pid "$@" &

sleep 0.1

(r=150; while ! __workdir/status >& /dev/null ; do ((--r))||exit 1; sleep 0.1 ;done)
