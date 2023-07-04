#!t/lib/test-in-image.sh rsync
set -euo pipefail
rs=$(environ rs)

$rs/start
$rs/status

$rs/configure_dir test $rs/dt

touch $rs/dt/file1.dat

$rs/ls_test | grep file1.dat

mkdir $rs/dt/subdir
touch $rs/dt/subdir/file2.dat
$rs/ls_test /subdir/ | grep file2.dat

$rs/stop

rc=0
$rs/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
