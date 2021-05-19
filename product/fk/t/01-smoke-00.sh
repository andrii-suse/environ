set -euo pipefail
fk=$(environ fk)

$fk/start
$fk/status
$fk/stop

rc=0
$fk/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
