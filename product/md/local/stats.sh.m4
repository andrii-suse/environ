set -euo pipefail
res=$(printf '\x00\x00\x00\x00\x00\x01\x00\x00stats\r\n' | nc -w1 -u 127.0.0.1 __port | tr -d '\0\1')
echo "${res/$'\r'/}"
