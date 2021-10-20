last=${@:$#} # last parameter
other=${*%${!#}} # all parameters except the last
set -euo pipefail
res=$(__workdir/get $last)
test $other $res || ( echo FAILED: $other $res ; exit 1 )
