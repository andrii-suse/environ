set -euo pipefail
ap=$(environ ap)

$ap/configure_ssl
$ap/start
$ap/status

$ap/curl | grep 'Index of'
curl -sk https://$($ap/print_address) | grep 'Index of'

$ap/stop

rc=0
$ap/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
