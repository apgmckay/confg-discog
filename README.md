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
test
after
hello from cmd
2023/06/02 17:16:14 Starting confg-discog
2023/06/02 17:16:14 loglevel set to info
2023-06-02T17:16:16Z da6a1dc7b16a confd[14]: INFO Backend set to ssm
2023-06-02T17:16:16Z da6a1dc7b16a confd[14]: INFO Starting confd
2023-06-02T17:16:16Z da6a1dc7b16a confd[14]: INFO Backend source(s) set to 
2023-06-02T17:16:16Z da6a1dc7b16a confd[14]: INFO Target config /tmp/myconfig.conf out of sync
2023-06-02T17:16:16Z da6a1dc7b16a confd[14]: INFO Target config /tmp/myconfig.conf has been updated
2023-06-02T17:16:18Z da6a1dc7b16a confd[28]: INFO Backend set to ssm
2023-06-02T17:16:18Z da6a1dc7b16a confd[28]: INFO Starting confd
2023-06-02T17:16:18Z da6a1dc7b16a confd[28]: INFO Backend source(s) set to 
cmd config url: some.example.com
cmd config user: andy
2023-06-02T17:16:20Z da6a1dc7b16a confd[43]: INFO Backend set to ssm
2023-06-02T17:16:20Z da6a1dc7b16a confd[43]: INFO Starting confd
2023-06-02T17:16:20Z da6a1dc7b16a confd[43]: INFO Backend source(s) set to 
2023-06-02T17:16:22Z da6a1dc7b16a confd[63]: INFO Backend set to ssm
2023-06-02T17:16:22Z da6a1dc7b16a confd[63]: INFO Starting confd
2023-06-02T17:16:22Z da6a1dc7b16a confd[63]: INFO Backend source(s) set to 
2023-06-02T17:16:24Z da6a1dc7b16a confd[77]: INFO Backend set to ssm
2023-06-02T17:16:24Z da6a1dc7b16a confd[77]: INFO Starting confd
2023-06-02T17:16:24Z da6a1dc7b16a confd[77]: INFO Backend source(s) set to 
2023-06-02T17:16:26Z da6a1dc7b16a confd[90]: INFO Backend set to ssm
2023-06-02T17:16:26Z da6a1dc7b16a confd[90]: INFO Starting confd
2023-06-02T17:16:26Z da6a1dc7b16a confd[90]: INFO Backend source(s) set to 
2023-06-02T17:16:28Z da6a1dc7b16a confd[104]: INFO Backend set to ssm
2023-06-02T17:16:28Z da6a1dc7b16a confd[104]: INFO Starting confd
2023-06-02T17:16:28Z da6a1dc7b16a confd[104]: INFO Backend source(s) set to 
2023-06-02T17:16:30Z da6a1dc7b16a confd[118]: INFO Backend set to ssm
2023-06-02T17:16:30Z da6a1dc7b16a confd[118]: INFO Starting confd
2023-06-02T17:16:30Z da6a1dc7b16a confd[118]: INFO Backend source(s) set to 
2023-06-02T17:16:32Z da6a1dc7b16a confd[133]: INFO Backend set to ssm
2023-06-02T17:16:32Z da6a1dc7b16a confd[133]: INFO Starting confd
2023-06-02T17:16:32Z da6a1dc7b16a confd[133]: INFO Backend source(s) set to 
cmd config url: some.example.com
cmd config user: andy
bye from cmd
after eval
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
