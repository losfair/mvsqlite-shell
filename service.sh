#!/bin/bash

set -e
LD_PRELOAD=/root/libmvsqlite_preload.so postlite &
tinyproxy -d -c /root/tinyproxy.conf &
wait -n
