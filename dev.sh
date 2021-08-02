#!/bin/bash

# Run this file (with 'entr' installed) to watch all files and rerun tests on changes
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

find "${DIR}" -type d | entr "${DIR}/test.sh"
