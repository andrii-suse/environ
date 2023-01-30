set -e
[ -d __datadir ] || mkdir __datadir

eatmydata=$(which eatmydata 2>/dev/null) || :

$eatmydata __bindir/../scripts/mysql_install_db --no-defaults --data=__datadir --log-error=__workdir/.install | head -n 3
