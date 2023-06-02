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
 ---> 4cfb159ca15e
Step 3/8 : COPY confd/conf.d/myconfig.toml /etc/confd/conf.d/myconfig.toml
 ---> Using cache
 ---> e509d572cb41
Step 4/8 : COPY confd/conf.d/myconfig.conf.tmpl /etc/confd/templates/myconfig.conf.tmpl
 ---> Using cache
 ---> 13d9b5a3438b
Step 5/8 : COPY entrypoint.sh /usr/bin/entrypoint
 ---> Using cache
 ---> be423a48c4c6
Step 6/8 : COPY cmd.sh /usr/bin/cmd
 ---> Using cache
 ---> 0f0c1e588230
Step 7/8 : ENTRYPOINT ["/usr/bin/entrypoint"]
 ---> Using cache
 ---> 1c277a27e456
Step 8/8 : CMD ["/usr/bin/cmd"]
 ---> Using cache
 ---> 8a11e8afaf54
Successfully built 8a11e8afaf54
Successfully tagged confg_discog:latest
entrypoint: starting
entrypoint: config-discog started
cmd: Hello!
cmd: sleeping for 5
2023/06/02 19:31:44 entrypoint: Hello!
2023/06/02 19:31:44 entrypoint: new ConfgDiscog!
2023/06/02 19:31:44 entrypoint: set backend == ssm
2023/06/02 19:31:44 entrypoint: ConfgDiscog Running!
2023/06/02 19:31:44 entrypoint: loglevel set to info
2023/06/02 19:31:46 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-02T19:31:46Z df9f33632d8d confd[14]: INFO Backend set to ssm
2023-06-02T19:31:46Z df9f33632d8d confd[14]: INFO Starting confd
2023-06-02T19:31:46Z df9f33632d8d confd[14]: INFO Backend source(s) set to 
2023-06-02T19:31:46Z df9f33632d8d confd[14]: INFO Target config /tmp/myconfig.conf out of sync
2023-06-02T19:31:46Z df9f33632d8d confd[14]: INFO Target config /tmp/myconfig.conf has been updated
2023/06/02 19:31:48 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-02T19:31:48Z df9f33632d8d confd[28]: INFO Backend set to ssm
2023-06-02T19:31:48Z df9f33632d8d confd[28]: INFO Starting confd
2023-06-02T19:31:48Z df9f33632d8d confd[28]: INFO Backend source(s) set to 
cmd: source myconfig.conf
cmd: someconfig_url: ␡test
cmd: someconfig_user: test
cmd: sleeping for 15
2023/06/02 19:31:50 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-02T19:31:50Z df9f33632d8d confd[43]: INFO Backend set to ssm
2023-06-02T19:31:50Z df9f33632d8d confd[43]: INFO Starting confd
2023-06-02T19:31:50Z df9f33632d8d confd[43]: INFO Backend source(s) set to 
2023/06/02 19:31:52 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-02T19:31:52Z df9f33632d8d confd[57]: INFO Backend set to ssm
2023-06-02T19:31:52Z df9f33632d8d confd[57]: INFO Starting confd
2023-06-02T19:31:52Z df9f33632d8d confd[57]: INFO Backend source(s) set to 
2023/06/02 19:31:54 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-02T19:31:54Z df9f33632d8d confd[73]: INFO Backend set to ssm
2023-06-02T19:31:54Z df9f33632d8d confd[73]: INFO Starting confd
2023-06-02T19:31:54Z df9f33632d8d confd[73]: INFO Backend source(s) set to 
2023/06/02 19:31:56 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-02T19:31:56Z df9f33632d8d confd[87]: INFO Backend set to ssm
2023-06-02T19:31:56Z df9f33632d8d confd[87]: INFO Starting confd
2023-06-02T19:31:56Z df9f33632d8d confd[87]: INFO Backend source(s) set to 
2023/06/02 19:31:58 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-02T19:31:58Z df9f33632d8d confd[101]: INFO Backend set to ssm
2023-06-02T19:31:58Z df9f33632d8d confd[101]: INFO Starting confd
2023-06-02T19:31:58Z df9f33632d8d confd[101]: INFO Backend source(s) set to 
2023/06/02 19:32:00 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-02T19:32:00Z df9f33632d8d confd[116]: INFO Backend set to ssm
2023-06-02T19:32:00Z df9f33632d8d confd[116]: INFO Starting confd
2023-06-02T19:32:00Z df9f33632d8d confd[116]: INFO Backend source(s) set to 
2023/06/02 19:32:02 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
2023-06-02T19:32:02Z df9f33632d8d confd[131]: INFO Backend set to ssm
2023-06-02T19:32:02Z df9f33632d8d confd[131]: INFO Starting confd
2023-06-02T19:32:02Z df9f33632d8d confd[131]: INFO Backend source(s) set to 
cmd: source myconfig.conf
cmd: someconfig_url: ␡test
cmd: someconfig_user: test
cmd: bye
2023/06/02 19:32:04 entrypoint: starting command: [confd -onetime -backend ssm -log-level ]
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
- Test out with secrets manager through parameter store.
