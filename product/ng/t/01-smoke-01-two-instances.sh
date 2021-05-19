set -euo pipefail
ng1=$(environ ng1)
ng2=$(environ ng2)

$ng1/start
$ng1/status

$ng2/start
$ng2/status

touch $ng1/dt/testX
touch $ng2/dt/testY

$ng1/curl | grep testX
rc=0
$ng1/curl | grep testY || rc=$?
test $rc -gt 0

$ng2/curl | grep testY
rc=0
$ng2/curl | grep testX || rc=$?
test $rc -gt 0

$ng1/stop

rc=0
$ng1/status 2>/dev/null || rc=$?
test $rc -gt 0

$ng2/status
$ng2/stop
$ng2/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
