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
    hello_world
    (( $? == 0 )) && exit 0
    exit 1
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
