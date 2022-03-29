#!t/lib/test-in-image.sh postgresql-server
set -euo pipefail
pg1=$(environ pg1)
pg2=$(environ pg2)

$pg1/start
$pg1/status

# $pg2/start
# $pg2/status

$pg2/replicate $pg1

$pg1/create_db test
$pg1/sql_test "create table t1 as select 'x1'"

test x1 == $($pg1/sql -tc "select * from t1" test)
test x1 == $($pg2/sql -tc "select * from t1" test)


echo PASS $0
