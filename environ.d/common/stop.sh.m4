set -euo pipefail

if [ -e __workdir/.pid ]; then
    kill "$(cat __workdir/.pid)"
    cnt=50
    # wait ~5 sec, then kill hard
    while kill -0 "$(cat __workdir/.pid)" && ! ps -p "$(cat __workdir/.pid)" | grep -q defunc ; do
        sleep 0.1
        if [ $((cnt--)) -le 1 ]; then
            kill -9 "$(cat __workdir/__service/.pid)"
            sleep 0.1
            break
        fi
    done >& /dev/null
fi

rc=0
__workdir/status >& /dev/null || rc=$?

test $rc == 0 || {
    [ ! -e __workdir/_unlock ] || source __workdir/_unlock
    exit 0
}
>2 echo Failed to stop
exit 1
