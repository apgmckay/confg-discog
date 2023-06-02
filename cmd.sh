#!/bin/sh
echo hello
sleep 5 
source /tmp/myconfig.conf
echo ${DATABASE_URL} 
echo ${DATABASE_USER}
sleep 15
source /tmp/myconfig.conf
echo ${DATABASE_URL} 
echo ${DATABASE_USER}
echo bye
