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

To build:

```
function confg_discog_build_and_run {
  go build -o confg_discog
  docker build . -t confg_discog
  docker run -e AWS_REGION=${AWS_REGION} -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} -it confg_discog 
}
$ confg_discog_build_and_run 
```

You should recieve an output something like the below, if you change your ssm parameter between the second sleep in [cmd.sh](cmd.sh); the value set to someconfig_url and someconfig_user will be those stored in ssm parameter store.

```
Sending build context to Docker daemon  370.4MB

Step 1/8 : FROM dockage/confd:latest
 ---> 729bfb969995
Step 2/8 : COPY confg_discog /usr/bin/confg-discog
 ---> Using cache
 ---> 03871afa8d0c
Step 3/8 : COPY confd/conf.d/myconfig.toml /etc/confd/conf.d/myconfig.toml
 ---> Using cache
 ---> 4910bbfd6f74
Step 4/8 : COPY confd/conf.d/myconfig.conf.tmpl /etc/confd/templates/myconfig.conf.tmpl
 ---> Using cache
 ---> 06dfad23f7b4
Step 5/8 : COPY entrypoint.sh /usr/bin/entrypoint
 ---> Using cache
 ---> 29ffb1f061da
Step 6/8 : COPY cmd.sh /usr/bin/cmd
 ---> Using cache
 ---> f373354e10d3
Step 7/8 : ENTRYPOINT ["/usr/bin/entrypoint"]
 ---> Using cache
 ---> 2d85c44b20b1
Step 8/8 : CMD ["/usr/bin/cmd"]
 ---> Using cache
 ---> 555229ddacf6
Successfully built 555229ddacf6
Successfully tagged confg_discog:latest
entrypoint: starting
entrypoint: config-discog started
cmd: Hello!
cmd: sleeping for 5
2023/06/03 17:05:23 entrypoint: Hello!
2023/06/03 17:05:23 entrypoint: new ConfgDiscog!
2023/06/03 17:05:23 entrypoint: set backend == ssm
2023/06/03 17:05:23 entrypoint: ConfgDiscog Running!
2023/06/03 17:05:23 entrypoint: loglevel set to info
2023/06/03 17:05:25 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-03T17:05:25Z 3769e7cfc73e confd[14]: INFO Backend set to ssm
2023-06-03T17:05:25Z 3769e7cfc73e confd[14]: INFO Starting confd
2023-06-03T17:05:25Z 3769e7cfc73e confd[14]: INFO Backend source(s) set to 
2023-06-03T17:05:26Z 3769e7cfc73e confd[14]: INFO Target config /tmp/myconfig.conf out of sync
2023-06-03T17:05:26Z 3769e7cfc73e confd[14]: INFO Target config /tmp/myconfig.conf has been updated
2023/06/03 17:05:27 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-03T17:05:27Z 3769e7cfc73e confd[28]: INFO Backend set to ssm
2023-06-03T17:05:27Z 3769e7cfc73e confd[28]: INFO Starting confd
2023-06-03T17:05:27Z 3769e7cfc73e confd[28]: INFO Backend source(s) set to 
cmd: source myconfig.conf
cmd: someconfig_url: example.com
cmd: someconfig_user: andy
cmd: someconfig_password: {password:supersecret,username:admin,admin_password:somepassword}
cmd: sleeping for 15
2023/06/03 17:05:29 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-03T17:05:29Z 3769e7cfc73e confd[43]: INFO Backend set to ssm
2023-06-03T17:05:29Z 3769e7cfc73e confd[43]: INFO Starting confd
2023-06-03T17:05:29Z 3769e7cfc73e confd[43]: INFO Backend source(s) set to 
2023/06/03 17:05:31 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-03T17:05:31Z 3769e7cfc73e confd[57]: INFO Backend set to ssm
2023-06-03T17:05:31Z 3769e7cfc73e confd[57]: INFO Starting confd
2023-06-03T17:05:31Z 3769e7cfc73e confd[57]: INFO Backend source(s) set to 
2023/06/03 17:05:33 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-03T17:05:33Z 3769e7cfc73e confd[70]: INFO Backend set to ssm
2023-06-03T17:05:33Z 3769e7cfc73e confd[70]: INFO Starting confd
2023-06-03T17:05:33Z 3769e7cfc73e confd[70]: INFO Backend source(s) set to 
2023/06/03 17:05:35 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-03T17:05:35Z 3769e7cfc73e confd[84]: INFO Backend set to ssm
2023-06-03T17:05:35Z 3769e7cfc73e confd[84]: INFO Starting confd
2023-06-03T17:05:35Z 3769e7cfc73e confd[84]: INFO Backend source(s) set to 
2023/06/03 17:05:37 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-03T17:05:37Z 3769e7cfc73e confd[97]: INFO Backend set to ssm
2023-06-03T17:05:37Z 3769e7cfc73e confd[97]: INFO Starting confd
2023-06-03T17:05:37Z 3769e7cfc73e confd[97]: INFO Backend source(s) set to 
2023/06/03 17:05:39 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-03T17:05:39Z 3769e7cfc73e confd[111]: INFO Backend set to ssm
2023-06-03T17:05:39Z 3769e7cfc73e confd[111]: INFO Starting confd
2023-06-03T17:05:39Z 3769e7cfc73e confd[111]: INFO Backend source(s) set to 
2023/06/03 17:05:41 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-03T17:05:41Z 3769e7cfc73e confd[125]: INFO Backend set to ssm
2023-06-03T17:05:41Z 3769e7cfc73e confd[125]: INFO Starting confd
2023-06-03T17:05:41Z 3769e7cfc73e confd[125]: INFO Backend source(s) set to 
2023/06/03 17:05:43 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
cmd: source myconfig.conf
cmd: someconfig_url: example.com
cmd: someconfig_user: andy
cmd: someconfig_password: {password:supersecret,username:admin,admin_password:somepassword}
cmd: bye
entrypoint: after eval
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
