#!/bin/bash

# Run this file to run all the tests, once
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

if [[ ! -d "${DIR}/Bash-Automated-Testing-System" ]]; then
  git clone --recursive https://github.com/pi-top/Bash-Automated-Testing-System
fi

"${DIR}/tests/Bash-Automated-Testing-System/bats-core/bin/bats" "${DIR}/tests/"*".bats"
