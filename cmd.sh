#!/bin/sh
echo hello
sleep 5 
source /tmp/myconfig.conf
echo ${DATABASE_URL} 
echo ${DATABASE_USER}
echo bye
