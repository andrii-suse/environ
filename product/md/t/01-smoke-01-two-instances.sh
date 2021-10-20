#!t/lib/test-in-image.sh memcached netcat-openbsd
set -euo pipefail
md1=$(environ md1)
md2=$(environ md2)

$md1/start
$md1/status

$md2/start
$md2/status


$md1/set AA XX
$md2/set AA YY
$md1/get_test XX == AA
$md2/get_test XX != AA
$md2/get_test YY == AA


$md1/stop

rc=0
$md1/status 2>/dev/null || rc=$?
test $rc -gt 0

$md2/status
$md2/stop
$md2/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
