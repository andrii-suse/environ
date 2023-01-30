[ -d __datadir ] || mkdir -p __datadir
[ -d __workdir/tmp ] || mkdir -p __workdir/tmp
[ -d __workdir/log ] || mkdir -p __workdir/log
[ -d __workdir/dt ]  || mkdir -p __workdir/dt

if [[ $(/usr/sbin/nginx -v 2>&1) =~ 1.[2-9] ]]; then
    /usr/sbin/nginx -c __workdir/nginx.conf -p __datadir -e __workdir/log/error.log
else
    rc=0
    /usr/sbin/nginx -c __workdir/nginx.conf -p __datadir || rc=$?
    [ $rc == 0 ] || (
        >&2 echo old nginx versions cannot be started as non-root?
        exit 1
    )
fi
