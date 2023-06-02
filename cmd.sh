#!/bin/sh

function print_ssm_values {
  echo "cmd someconfig_url: ${DATABASE_URL}"
  echo "cmd someconfig_user: ${DATABASE_USER}"
}

echo "hello from cmd"
sleep 5 
source /tmp/myconfig.conf
print_ssm_values
sleep 15
source /tmp/myconfig.conf
print_ssm_values
echo "bye from cmd"
