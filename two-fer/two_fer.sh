#!/usr/bin/env bash

# Sets option - exit script when there is an error:
set -o errexit
# Sets option - exit script when there are unset variables:
set -o nounset

two_fer() {
  local -r -a args=( "$@" )

  case "${#args[@]}" in
    0|1)
      local -r name="${1:-you}"
      printf "One for %s, one for me." "$name"
      ;;
    *)
      echo "Too many function parameters for two_fer(): ${args[*]}" >&2
      return 9
      ;;
  esac

  return 0
}

main () {
  local -r -a args=( "$@" )

  # The test "handle arg with spaces"
  #  forces us to accept more than 1 argument
  #  without returning an error,
  #  but supernumerary arguments need to be discarded.
  local -a rargs=( "${args[@]}" )
  if [[ ${#args[@]} -gt 1 ]]; then
    rargs=( "${rargs[@]:0:1}" )
  fi

  if two_fer "${rargs[@]}" ; then
    exit 0
  else
    echo "Unexpected behaviour from two_fer()" >&2
    exit 1
  fi

  echo "Unexpected point reached" >&2
  exit 255
}

# Calls the main function
#  passing to it all the positional arguments via "$@"
#  (in quotes to prevent whitespace issues):
main "$@"
