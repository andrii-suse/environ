#!t/lib/test-in-image.sh apache2 curl
set -euo pipefail
ap1=$(environ ap1)
ap2=$(environ ap2)

$ap1/start
$ap1/status

$ap2/start
$ap2/status

touch $ap1/dt/testX
touch $ap2/dt/testY

$ap1/curl | grep testX
rc=0
$ap1/curl | grep testY || rc=$?
test $rc -gt 0

$ap2/curl | grep testY
rc=0
$ap2/curl | grep testX || rc=$?
test $rc -gt 0

$ap1/stop

rc=0
$ap1/status 2>/dev/null || rc=$?
test $rc -gt 0

$ap2/status
$ap2/stop
$ap2/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $@
