if [[ $1 == -* ]] ; then
__bindir/mysql --batch --socket=__workdir/.sock "$@"
elif [ -z "$2" ]; then
    if [ "$(basename $0)" == sql ]; then
        if [ -f __workdir/default_db.cnf ] && [ "$#" == 1 ]; then
            __bindir/mysql "$(cat __workdir/default_db.cnf)" --batch --socket=__workdir/.sock -Ne "$*"
        else
            __bindir/mysql --batch --socket=__workdir/.sock -Ne "$*"
        fi
    else
        db=${0#*_}
        if [ "$#" == 0 ]; then
            __bindir/mysql "$db" --socket=__workdir/.sock
        else
            __bindir/mysql $db --socket=__workdir/.sock  --batch -Ne "$@"
        fi
    fi
else
db=$1
shift
__bindir/mysql "$db" --batch --socket=__workdir/.sock -Ne "$@"
fi
