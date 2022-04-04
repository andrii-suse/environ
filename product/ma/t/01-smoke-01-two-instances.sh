#!t/lib/test-in-image.sh mariadb-server
set -euo pipefail
ma1=$(environ ma1)
ma2=$(environ ma2)

$ma1/start
$ma1/status

$ma2/start
$ma2/status

$ma1/create_db tst
$ma1/sql_tst "create table t1 as select 'x1'"

$ma2/create_db tst
$ma2/sql_tst "create table t1 as select 'y1'"

test x1 == $($ma1/sql_tst "select * from t1")
test y1 == $($ma2/sql_tst "select * from t1")

$ma1/sql_tst "drop table t1"
test y1 == $($ma2/sql_tst "select * from t1")

$ma1/stop

rc=0
$ma1/status || rc=$?

test $rc -gt 0

$ma2/status
$ma2/stop
$ma2/status || rc=$?

test $rc -gt 0
echo PASS $0
