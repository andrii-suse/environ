
if test -z "$1" ; then
    echo "DBI:Pg;host=__datadir"
else
    echo "DBI:Pg:dbname=$1;host=__datadir"
fi
