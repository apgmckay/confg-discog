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
## Config

To config confd to try this out you will need to run the terraform code in the [_terraform](_terraform) directory.

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

You should recieve an output something like the below, if you change your ssm parameter between the second sleep in cmd.sh; the key thing to notice in this output is the 

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
