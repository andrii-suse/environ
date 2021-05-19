set -euo pipefail
rs=$(environ rs)

$rs/start
$rs/status

$rs/configure_dir test $rs/dt

touch $rs/dt/file1.dat

$rs/ls_test | grep file1.dat

$rs/stop

rc=0
$rs/status 2>/dev/null || rc=$?

test $rc -gt 0
echo PASS $0
