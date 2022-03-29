pg_basebackup -h __datadir -X stream -w -P -R "$@"
