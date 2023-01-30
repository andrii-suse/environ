#!t/lib/test-in-image.sh memcached netcat-openbsd
set -euo pipefail
md=$(environ md)

$md/start
$md/status

$md/set AA BB
test BB == $($md/get AA)
$md/get_test BB == AA

$md/stop

rc=0
$md/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
