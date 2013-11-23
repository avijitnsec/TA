#!/bin/bash
echo $1
FILE_DIR=/data/local/tmp 
cd /data/local/tmp
export LD_LIBRARY_PATH=/data/local/tmp:$LD_LIBRARY_PATH
echo "Current dir:"
echo `pwd`
chmod 0777 iofuzz
./iofuzz  -nc 10000000 $1