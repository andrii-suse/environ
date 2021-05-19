[ -f __workdir/.pid ] || ( >&2 echo Pid file not found {__workdir/.pid}; exit 1 )

( kill -0 $(cat __workdir/.pid) && ! ps -p "$(cat __workdir/.pid)" | grep -q defunc && echo seems running ) || ( >&2 echo seems be down; exit 1 )
