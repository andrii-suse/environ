[ -d __datadir ] || ( mkdir __datadir && __workdir/init_datadir )
pg_ctl -D __datadir -l __workdir/log_test_postgresql start -w
