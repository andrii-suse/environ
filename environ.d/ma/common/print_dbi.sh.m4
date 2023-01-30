if test -z "$1" ; then
    echo "DBI:mysql;mysql_socket=__workdir/.sock"
else
    echo "DBI:mysql:dbname=$1;mysql_socket=__workdir/.sock"
fi
