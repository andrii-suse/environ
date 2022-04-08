#!t/lib/test-in-image.sh mariadb-server
set -euo pipefail
ma=$(environ ma)

$ma/start
$ma/status

$ma/create_db tst
$ma/sql_tst "create table t1 as select 'x1'"

test x1 == $($ma/sql --batch -Ne "select * from t1" tst)
test x1 == $($ma/sql_tst "select * from t1")

$ma/stop

rc=0
$ma/status || rc=$?

test $rc -gt 0
echo PASS $0
