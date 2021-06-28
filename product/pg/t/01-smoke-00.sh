#!t/lib/test-in-image.sh postgresql-server
set -euo pipefail
pg=$(environ pg)

$pg/start
$pg/status

$pg/create_db test
$pg/sql_test "create table t1 as select 'x1'"

test x1 == $($pg/sql -t -c "select * from t1" test)
test x1 == $($pg/sql_test "select * from t1")

$pg/stop

rc=0
$pg/status || rc=$?

test $rc -gt 0
echo PASS $0
