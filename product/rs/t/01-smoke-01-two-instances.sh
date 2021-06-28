#!t/lib/test-in-image.sh rsync
set -euo pipefail
rs1=$(environ rs1)
rs2=$(environ rs2)

$rs1/start
$rs1/status

$rs2/start
$rs2/status

$rs1/configure_dir dt $rs1/dt
$rs2/configure_dir dt $rs2/dt
touch $rs1/dt/testX
touch $rs2/dt/testY

$rs1/ls_dt | grep testX
rc=0
$rs1/ls_dt | grep testY || rc=$?
test $rc -gt 0

$rs2/ls_dt | grep testY
rc=0
$rs2/ls_dt | grep testX || rc=$?
test $rc -gt 0

$rs1/stop

rc=0
$rs1/status 2>/dev/null || rc=$?
test $rc -gt 0

$rs2/status
$rs2/stop
$rs2/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
