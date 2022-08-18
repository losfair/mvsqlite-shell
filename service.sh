#!/bin/bash

LD_PRELOAD=/root/libmvsqlite_preload.so RUST_LOG=info exec postlite
