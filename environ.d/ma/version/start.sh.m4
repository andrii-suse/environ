set -e
[ -d __workdir/dt ] || mkdir __workdir/dt
[ -f __datadir/ibdata1 ] || __workdir/init_datadir

__bindir/mariadbd --datadir=__datadir --user=$USER --socket=__workdir/.sock --skip-networking --log-error=__workdir/.cerr --pid-file=__workdir/.pid "$@" &

sleep 1
__workdir/status >& /dev/null || sleep 1
__workdir/status >& /dev/null || sleep 1
