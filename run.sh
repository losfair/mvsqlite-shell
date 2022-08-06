#!/bin/bash

set -e

if [ -z "$MVSQLITE_DATA_PLANE" ]; then
  echo "MVSQLITE_DATA_PLANE is not set"
  exit 1
fi

if [ -z "$1" ]; then
  echo "database name required"
  exit 1
fi

export RUST_LOG=info
LD_PRELOAD=/root/libmvsqlite_preload.so sqlite3 "$1"
