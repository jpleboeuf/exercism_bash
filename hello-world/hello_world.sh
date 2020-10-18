#!/usr/bin/env bash

# Sets option - exit script when there is an error:
set -o errexit
# Sets option - exit script when there are unset variables:
set -o nounset

hello_world() {
  echo "Hello, World!"
  return 0
}

main () {
  local -r -a args=( "$@" )

  if [[ -z "${args[*]}" ]]; then
    if hello_world; then
      exit 0
    else
      exit 1
    fi
  else
    echo "Too many command line parameters: ${args[*]}"
    exit 9
  fi

  exit 999
}

# Calls the main function
#  passing to it all the positional arguments via "$@"
#  (in quotes to prevent whitespace issues):
main "$@"
