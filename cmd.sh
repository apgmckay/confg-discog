#!/bin/sh
function print_ssm_values {
  echo 
  echo "CONFG_DISCOG SERVICE PARAMS!!!"
  echo
  env | grep CONFG_DISCOG_SERVICE
  echo
  echo "CONFG_DISCOG PLATFORM PARAMS!!!"
  echo
  env | grep CONFG_DISCOG_PLATFORM
  echo
  echo "CONFG_DISCOG APP PARAMS!!!"
  echo
  env | grep CONFG_DISCOG_APP
  echo
  echo
}

echo "cmd: Hello!"
echo "cmd: sleeping for 5"
sleep 5 
echo "cmd: source myconfig.sh"
source /tmp/myconfig.sh
print_ssm_values
echo "cmd: sleeping for 15"
sleep 30
echo "cmd: source myconfig.sh"
source /tmp/myconfig.sh
sleep 30
print_ssm_values
echo "cmd: bye"
