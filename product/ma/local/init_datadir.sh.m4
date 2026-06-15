set -e
[ -d __datadir ] || mkdir __datadir

eatmydata=$(which eatmydata 2>/dev/null) || :

$eatmydata mariadb-install-db --no-defaults --data=__datadir --log-error=__workdir/.install ${eatmydata:+--innodb-use-native-aio=0} | head -n 10
