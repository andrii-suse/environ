#!t/lib/test-in-image.sh postgresql-server
set -euo pipefail
pg1=$(environ pg1)
pg2=$(environ pg2)

$pg1/start
$pg1/status

$pg2/start
$pg2/status

$pg1/create_db test
$pg1/sql_test "create table t1 as select 'x1'"

$pg2/create_db test
$pg2/sql_test "create table t1 as select 'y1'"

test x1 == $($pg1/sql_test "select * from t1")
test y1 == $($pg2/sql_test "select * from t1")

$pg1/sql_test "drop table t1"
test y1 == $($pg2/sql_test "select * from t1")


$pg1/stop

rc=0
$pg1/status || rc=$?

test $rc -gt 0

$pg2/status
$pg2/stop
$pg2/status || rc=$?

test $rc -gt 0
echo PASS $0
