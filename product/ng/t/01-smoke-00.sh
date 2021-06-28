#!t/lib/test-in-image.sh nginx curl
set -euo pipefail
ng=$(environ ng)

$ng/start
$ng/status

$ng/curl
curl $($ng/print_address)

$ng/stop

rc=0
$ng/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
