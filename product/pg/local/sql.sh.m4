if [[ $1 == -* ]] ; then
PGHOST=__datadir psql -P pager=off "$@"
elif [ -z "$2" ]; then
    if [ "$(basename $0)" == sql ]; then
        if [ -f __workdir/default_db.cnf ] && [ "$#" == 1 ]; then
            PGHOST=__datadir psql "$(cat __workdir/default_db.cnf)" -P pager=off -t -c "$@"
        else
            PGHOST=__datadir psql "$@"
        fi
    else
        db=${0/*_}
        if [ "$#" == 0 ]; then
            PGHOST=__datadir psql $db
        else
            PGHOST=__datadir psql $db -P pager=off -t -c "$*"
        fi
    fi
else
db=$1
shift
PGHOST=__datadir psql $db -P pager=off -t -c "$*"
fi
