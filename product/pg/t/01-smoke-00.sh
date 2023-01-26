#!t/lib/test-in-image.sh postgresql-server
set -euo pipefail
pg=$(environ pg)

$pg/start
$pg/status

$pg/create_db tst
$pg/sql_tst "create table t1 as select 'x1'"

test x1 == $($pg/sql -t -c "select * from t1" tst)
test x1 == $($pg/sql_tst "select * from t1")

$pg/sql_test x1 == "select * from t1"
$pg/sql_test x2 != "select * from t1"

rc=0
$pg/sql_test x2 == "select * from t1" || rc=$?
test $rc -gt 0

$pg/stop

rc=0
$pg/status || rc=$?

test $rc -gt 0
echo PASS $0
