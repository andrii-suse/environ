mkdir -p __datadir
dbname=${1:-test}
PGHOST=__datadir createdb $dbname
ln -sf __workdir/sql __workdir/sql_$dbname

[ -f __workdir/default_db.cnf ] || echo $dbname > __workdir/default_db.cnf
