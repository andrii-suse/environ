set -euo pipefail
ap=$(environ ap)

$ap/configure_add_https
$ap/start
$ap/status

$ap/curl
curl $($ap/print_address)

$ap/curl_https -I / | grep '200 OK'
curl -ksI https://$($ap/print_address_https)/ | grep '200 OK'

curl --cacert ca/ca.pem -ksI https://$($ap/print_address_https)/ | grep '200 OK'


# cannot connect without certificate
curl -s $($ap/print_address_https) | grep '400 Bad Request'
rc=0
curl -s https://$($ap/print_address_https) || rc=$?
test $rc -gt 0

$ap/stop
$ap/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
