#!/usr/bin/env bash

OPTIONS=()

function options() {
  upper=$(echo "$1" | upper)
  lower=$(echo "$1" | lower)
  OPTIONS[$lower]="$2"

  eval export OPTION_$upper="$2"
}


while getopts ":a:" opt; do
  case $opt in
    a)
      echo "-a was triggered, Parameter: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
