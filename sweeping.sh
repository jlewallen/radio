#!/bin/bash

set -x

while true; do
	NAME=`date +"%Y%m%d_%H%M%S"`
	timeout 10m hackrf_sweep -f400:520 -w10000 -l32 > $NAME.sweep
done
