#!/bin/bash
set -euo pipefail

# sudo is needed for docker
deps="m4 bash"
test_deps="make which"
test_in_docker_deps="sudo shadow"

echo "zypper -n in $deps $test_deps $test_in_docker_deps"
