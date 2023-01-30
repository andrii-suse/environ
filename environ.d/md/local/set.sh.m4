name=${1}
shift
data="$@"
l=${#data}

res="$(printf '\x00\x00\x00\x00\x00\x01\x00\x00set '$name' 0 3600 '$l'\r\n'$data'\r\n' | nc -w1 -u 127.0.0.1 __port | tr -d '\0\1')"
res="${res/$'\r'/}"
[ "$res" == STORED ] || ( >&2 echo FAILED: $res; exit 1 )
