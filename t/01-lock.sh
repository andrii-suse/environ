#!t/lib/test-in-image.sh
set -euxo pipefail
which mktemp || exit 0
tempdir=$(mktemp -d)
tempdir1=$tempdir/1
tempdir2=$tempdir/2

mkdir $tempdir1
mkdir $tempdir2

in_cleanup=0
success=0
args="$@"

d=lib/environ

function cleanup {
    [ "$in_cleanup" != 1 ] || return
    in_cleanup=1
    [ -z "$tempdir" ] || rm -r "$tempdir"
    tempdir=''
    [ $success == 1 ] || echo FAIL $args
    [ $success != 1 ] || echo PASS $args
}

trap cleanup INT TERM EXIT

x=$( cd $tempdir1 && environ --localdir "$d" fk1)
y=$( cd $tempdir2 && environ --localdir "$d" fk1)

$x/start
rc=0
$y/start >& /dev/null || rc=$?

[ $rc -gt 0 ] || (
    >&2 echo second process expected to fail
    exit 1
)

$x/status
$x/stop
$x/status || rc=$?
[ $rc -gt 0 ] || (
    >&2 echo status is expected to fail
    exit 1
)

success=1
