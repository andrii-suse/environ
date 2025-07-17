set -euo pipefail
[ -d __datadir ] || mkdir -p __datadir

if [ -e __workdir/.pid ]; then
    oldpid=$(cat __workdir/.pid)
    rc=0
    kill -0 $oldpid >& /dev/null || rc=$?
    test "$rc" -gt 0 || (
        rc=0
        # in docker killed process remains defunc, so we just ingore it
        ps auxwww | grep $oldpid | grep defunc || rc=$?
        [ $rc == 0 ] || {
            >&2 echo "Process {$oldpid} is already running - shut it down first"
            exit 1
        }
    )
    >&2 echo "Removing leftover .pid file of process $oldpid"
    rm __workdir/.pid
fi

[ ! -e __workdir/_lock ] || source __workdir/_lock
pid=$(source __workdir/_exec)

if test "${pid:-0}" -eq "${pid:-1}" 2>/dev/null; then :
else
    test -f __workdir/.pid || sleep 0.01
    test -f __workdir/.pid || sleep 0.02
    test -f __workdir/.pid || sleep 0.1
fi

if [ -e __workdir/.pid ]; then
    pid=$(cat __workdir/.pid)
elif [ -n $pid ] && [ "$pid" -eq "$pid" ] 2>/dev/null; then # if number
    echo $pid > __workdir/.pid
fi

message="Waiting (pid $pid)"
[ ! -x __workdir/print_address ] || message="$message at $(__workdir/print_address)"

echo $message
i=0
while kill -0 $pid 2>/dev/null ; do
    ! __workdir/status >& /dev/null || break
    [ $((i++ % 10)) != 0 ] || echo -n .
    [ $i -ge 100 ] || {
        sleep 0.1
        continue
    }
    >&2 echo "Timeout expired while waiting process {$pid} for to start"
    exit 1
done

__workdir/status
