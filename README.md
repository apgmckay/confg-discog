# Confg-DisCog

The full disography of the 80's hair metal sensation Confg-DisCog.

```
 $$$$$$\                       $$$$$$\                   $$$$$$$\  $$\            $$$$$$\                      
$$  __$$\                     $$  __$$\                  $$  __$$\ \__|          $$  __$$\                     
$$ /  \__| $$$$$$\  $$$$$$$\  $$ /  \__|$$$$$$\          $$ |  $$ |$$\  $$$$$$$\ $$ /  \__| $$$$$$\   $$$$$$\  
$$ |      $$  __$$\ $$  __$$\ $$$$\    $$  __$$\ $$$$$$\ $$ |  $$ |$$ |$$  _____|$$ |      $$  __$$\ $$  __$$\ 
$$ |      $$ /  $$ |$$ |  $$ |$$  _|   $$ /  $$ |\______|$$ |  $$ |$$ |\$$$$$$\  $$ |      $$ /  $$ |$$ /  $$ |
$$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |     $$ |  $$ |        $$ |  $$ |$$ | \____$$\ $$ |  $$\ $$ |  $$ |$$ |  $$ |
\$$$$$$  |\$$$$$$  |$$ |  $$ |$$ |     \$$$$$$$ |        $$$$$$$  |$$ |$$$$$$$  |\$$$$$$  |\$$$$$$  |\$$$$$$$ |
 \______/  \______/ \__|  \__|\__|      \____$$ |        \_______/ \__|\_______/  \______/  \______/  \____$$ |
                                       $$\   $$ |                                                    $$\   $$ |
                                       \$$$$$$  |                                                    \$$$$$$  |
                                        \______/                                                      \______/
```

Based on [confd](https://github.com/kelseyhightower/confd).

## Config

To try this out you will need to run the terraform code in the [_terraform](_terraform) directory.

This can be done with a basic terraform init, plan and apply.

Make a note of the parameter you use to populate these ssm parameters.

Go through the instructions in Development.

## Development

### Testing

*Unit* tests can be ran for the golang package like so.

```
$ cd pkg/ $ go test ./...
$ go test ./...
```

*Terraform* tests can be ran for the terraform module.

```
$ cd _terraform/tests/
$ go test 
```

You can set skipTeardown in the terraform tests to true, then perform end to end testing by setting up the following function in your shell alias and reloading.

```
function confg_discog_build_and_run {
  go build -o confg_discog
  docker build . -t confg_discog
  docker run -e AWS_REGION=${AWS_REGION} -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} -it confg_discog 
}
```
Then running. 
 
```
$ confg_discog_build_and_run 
```

You should recieve an output something like the below, if you change your ssm parameter between the second sleep in [cmd.sh](cmd.sh); the value set to someconfig_url and someconfig_user will be those stored in ssm parameter store.

```
Sending build context to Docker daemon   1.13GB
Step 1/8 : FROM dockage/confd:latest
 ---> 729bfb969995
Step 2/8 : COPY confg_discog /usr/bin/confg-discog
 ---> Using cache
 ---> db49897fdd90
Step 3/8 : COPY _terraform/tests/fixtures/default/confd/conf.d/myconfig.toml /etc/confd/conf.d/myconfig.toml
 ---> Using cache
 ---> 413c62bc3721
Step 4/8 : COPY _terraform/tests/fixtures/default/confd/conf.d/myconfig.sh /etc/confd/templates/myconfig.sh.tmpl
 ---> Using cache
 ---> c90898ad4310
Step 5/8 : COPY entrypoint.sh /usr/bin/entrypoint
 ---> Using cache
 ---> a85e8047c5d8
Step 6/8 : COPY cmd.sh /usr/bin/cmd
 ---> Using cache
 ---> 4a342f278f43
Step 7/8 : ENTRYPOINT ["/usr/bin/entrypoint"]
 ---> Using cache
 ---> 254664d9fcf5
Step 8/8 : CMD ["/usr/bin/cmd"]
 ---> Using cache
 ---> a77b088d5100
Successfully built a77b088d5100
Successfully tagged confg_discog:latest
entrypoint: starting
entrypoint: config-discog started
cmd: Hello!
cmd: sleeping for 5
2023-10-11T17:34:21Z 5588d7ab011c confd[14]: INFO Backend set to ssm
2023-10-11T17:34:21Z 5588d7ab011c confd[14]: INFO Starting confd
2023-10-11T17:34:21Z 5588d7ab011c confd[14]: INFO Backend source(s) set to 
2023-10-11T17:34:22Z 5588d7ab011c confd[14]: INFO Target config /tmp/myconfig.sh out of sync
2023-10-11T17:34:22Z 5588d7ab011c confd[14]: INFO Target config /tmp/myconfig.sh has been updated
2023-10-11T17:34:23Z 5588d7ab011c confd[30]: INFO Backend set to ssm
2023-10-11T17:34:23Z 5588d7ab011c confd[30]: INFO Starting confd
2023-10-11T17:34:23Z 5588d7ab011c confd[30]: INFO Backend source(s) set to 
cmd: source myconfig.sh
LOAD EXTERNAL ENVS

LOAD APP ENVS


CONFG_DISCOG SERVICE PARAMS!!!

CONFG_DISCOG_SERVICE_SIDECAR_SERVICE=https://somesidecarurl.simplebusiness.me

CONFG_DISCOG PLATFORM PARAMS!!!

CONFG_DISCOG_PLATFORM_NEW_RELIC_DASHBOARD=http://newrelic.eu_west_1.com
CONFG_DISCOG_PLATFORM_DA_CONNECTION_STRING=mongo://somenonrealconnectionstring.eu_west_1.com
CONFG_DISCOG_PLATFORM_APP_USERNAME=andy
CONFG_DISCOG_PLATFORM_OTEL_COLLECTOR_ENDPOINT=otel://otelsubdomain.eu_west_1.com

CONFG_DISCOG APP PARAMS!!!

CONFG_DISCOG_APP_APP_USERNAME=andy
CONFG_DISCOG_APP_API_TOKEN=6f5902ac237024bdd0c176cb93063dc4
CONFG_DISCOG_APP_APP_PASSWORD=mysafepassword
CONFG_DISCOG_APP_APP_URL=myapiurl.co.uk


cmd: sleeping for 15
```

This is basically just a wraper around [confd](https://github.com/kelseyhightower/confd) with some shell redirection to hang this on an entrypoint of a docker container. This allows for config and secrets to be loaded synamically inside of a container from any backend supported by confd.

This util needs to be kept light in terms of runtime since we don't want to starve the application of CPU usage or memory.

```
Mem: 8182292K used, 7982016K free, 712888K shrd, 439800K buff, 4087056K cached
CPU:   1% usr   0% sys   0% nic  98% idle   0% io   0% irq   0% sirq
Load average: 0.38 0.24 0.26 2/1709 137
  PID  PPID USER     STAT   VSZ %VSZ CPU %CPU COMMAND
    8     1 root     S     686m   4%   4   0% confg-discog
   80     0 root     S     1596   0%   2   0% sh
    1     0 root     S     1588   0%   7   0% {entrypoint} /bin/sh /usr/bin/entrypoint /usr/bin/cmd
    9     1 root     S     1588   0%   1   0% {cmd} /bin/sh /usr/bin/cmd
  108    80 root     R     1528   0%   4   0% top
```

## TODO

- Figure out how we can debug this when running in a docker container on a orchestrator ECS or K8. This will involve where to send logs or prehaps having an SNS topic that can tell us when we are getting errors from the runs of confd.
- Generally a bit of thought needs to go into secrets for the following points:
  - Figure out a sensible way of injecting secrets manager version.
  - How are platform secrets passed.
