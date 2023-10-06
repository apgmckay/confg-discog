#!/bin/sh

function print_ssm_values {
  echo
  echo "cmd: APP PARAMS!!!"
  echo
  echo "cmd: app_username: ${APP_USERNAME}"
  echo "cmd: app_password: ${APP_PASSWORD}"
  echo "cmd: app_url: ${APP_URL}"
  echo "cmd: api_token: ${API_TOKEN}"
  echo
  echo "cmd: PLATFORM PARAMS!!!"
  echo 
  echo "cmd: apgmckay: ${APGMCKAY}"  
  echo "cmd: apgmckay2: ${APGMCKAY2}"
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
