[ -z "__cachedir" ] || [ 0 == __cachedir ] || [ ! -e "__lockdir/.__environ.lock" ] || {
    oldpid=$(cat "__lockdir/.__environ.lock")
    ! kill -0 $oldpid >& /dev/null || (
        >&2 echo "Process ($oldpid) is holding lock (__lockdir/.__environ.lock), cannot continue"
        exit 1
    )
}

ln -sfn __workdir/.pid __lockdir/.__environ.lock
