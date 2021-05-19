set -euo pipefail
fk1=$(environ fk1)
fk2=$(environ fk2)

$fk1/start
$fk1/status

$fk2/start
$fk2/status

$fk1/status
$fk1/stop

rc=0
$fk1/status 2>/dev/null || rc=$?
test $rc -gt 0

$fk2/status
$fk2/stop
$fk2/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
