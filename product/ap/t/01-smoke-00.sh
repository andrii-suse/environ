set -euo pipefail
ap=$(environ ap)

$ap/start
$ap/status

$ap/curl
curl $($ap/print_address)


$ap/stop

rc=0
$ap/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
