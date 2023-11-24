if [[ $1 == -* ]] ; then
mariadb --batch --socket=__workdir/.sock "$@"
elif [ -z "$2" ]; then
    if [ "$(basename $0)" == sql ]; then
        if [ -f __workdir/default_db.cnf ] && [ "$#" == 1 ]; then
            mariadb "$(cat __workdir/default_db.cnf)" --batch --socket=__workdir/.sock -Ne "$*"
        else
            mariadb --batch --socket=__workdir/.sock -Ne "$*"
        fi
    else
        db=${0#*_}
        if [ "$#" == 0 ]; then
            mariadb "$db" --socket=__workdir/.sock
        else
            mariadb $db --socket=__workdir/.sock  --batch -Ne "$@"
        fi
    fi
else
db=$1
shift
mariadb "$db" --batch --socket=__workdir/.sock -Ne "$@"
fi
