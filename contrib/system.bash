#!/usr/bin/env bash

# Require Mac OS X
if [ "$(uname)" != "Darwin" ]; then
  echo "This only works on Mac OS X" 1>&2
  exit 1
fi
