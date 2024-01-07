#!/bin/sh

HERE="$(dirname "$(realpath "$0")")"
MINIMAL_TEST="scripts/minimal_init.lua"

cd $HERE/..

run() {
  nvim --headless --noplugin -u "${MINIMAL_TEST}" \
    -c "PlenaryBustedDirectory $1 { minimal_init = './${MINIMAL_TEST}' }"
}

case "$2" in
'--summary')
  run tests/$1 2>/dev/null | grep -E '^\S*(Success|Fail(ed)?|Errors?)\s*:'
  ;;
*)
  run tests/$1
  ;;
esac
