if [[ $1 == -* ]] ; then
mariadb --batch --socket=__workdir/.sock "$@"
elif [ -z "$2" ]; then
    if [ "$(basename $0)" == sql ]; then
        if [ -f __workdir/default_db.cnf ] && [ "$#" == 1 ]; then
            mariadb "$(cat __workdir/default_db.cnf)" --batch --ssl-verify-server-cert=0 --socket=__workdir/.sock -Ne "$*"
        else
            mariadb --batch --ssl-verify-server-cert=0 --socket=__workdir/.sock -Ne "$*"
        fi
    else
        db=${0#*_}
        if [ "$#" == 0 ]; then
            mariadb "$db" --ssl-verify-server-cert=0 --socket=__workdir/.sock
        else
            mariadb $db --ssl-verify-server-cert=0 --socket=__workdir/.sock  --batch -Ne "$@"
        fi
    fi
else
db=$1
shift
mariadb "$db" --batch --ssl-verify-server-cert=0 --socket=__workdir/.sock -Ne "$@"
fi
