#!/bin/sh

function print_ssm_values {
  echo "cmd: someconfig_url: ${DATABASE_URL}"
  echo "cmd: someconfig_user: ${DATABASE_USER}"
}

echo "cmd: Hello!"

echo "cmd: sleeping for 5"

sleep 5 

echo "cmd: source myconfig.conf"

source /tmp/myconfig.conf

print_ssm_values

echo "cmd: sleeping for 15"

sleep 15

echo "cmd: source myconfig.conf"

source /tmp/myconfig.conf

print_ssm_values

echo "cmd: bye"
