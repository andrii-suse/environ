#!/bin/bash
set -euo pipefail

if [ -z "$@" ]; then

# sudo is needed for docker
deps="m4 bash"
test_deps="make which"
test_in_docker_deps="sudo shadow"

echo "zypper refresh"
echo "zypper -n in $deps $test_deps $test_in_docker_deps"

else
echo zypper -n in "$@"

fi
