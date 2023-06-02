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
hello from cmd
2023/06/02 16:44:05 Starting confg-discog
2023/06/02 16:44:05 loglevel set to info
2023-06-02T16:44:07Z 3a63172cba85 confd[14]: INFO Backend set to ssm
2023-06-02T16:44:07Z 3a63172cba85 confd[14]: INFO Starting confd
2023-06-02T16:44:07Z 3a63172cba85 confd[14]: INFO Backend source(s) set to 
2023-06-02T16:44:07Z 3a63172cba85 confd[14]: INFO Target config /tmp/myconfig.conf out of sync
2023-06-02T16:44:07Z 3a63172cba85 confd[14]: INFO Target config /tmp/myconfig.conf has been updated
2023-06-02T16:44:09Z 3a63172cba85 confd[28]: INFO Backend set to ssm
2023-06-02T16:44:09Z 3a63172cba85 confd[28]: INFO Starting confd
2023-06-02T16:44:09Z 3a63172cba85 confd[28]: INFO Backend source(s) set to 
cmd db url: db.example2.com
cmd db user: test
2023-06-02T16:44:11Z 3a63172cba85 confd[44]: INFO Backend set to ssm
2023-06-02T16:44:11Z 3a63172cba85 confd[44]: INFO Starting confd
2023-06-02T16:44:11Z 3a63172cba85 confd[44]: INFO Backend source(s) set to 
2023-06-02T16:44:13Z 3a63172cba85 confd[59]: INFO Backend set to ssm
2023-06-02T16:44:13Z 3a63172cba85 confd[59]: INFO Starting confd
2023-06-02T16:44:13Z 3a63172cba85 confd[59]: INFO Backend source(s) set to 
2023-06-02T16:44:15Z 3a63172cba85 confd[74]: INFO Backend set to ssm
2023-06-02T16:44:15Z 3a63172cba85 confd[74]: INFO Starting confd
2023-06-02T16:44:15Z 3a63172cba85 confd[74]: INFO Backend source(s) set to 
2023-06-02T16:44:17Z 3a63172cba85 confd[89]: INFO Backend set to ssm
2023-06-02T16:44:17Z 3a63172cba85 confd[89]: INFO Starting confd
2023-06-02T16:44:17Z 3a63172cba85 confd[89]: INFO Backend source(s) set to 
2023-06-02T16:44:19Z 3a63172cba85 confd[103]: INFO Backend set to ssm
2023-06-02T16:44:19Z 3a63172cba85 confd[103]: INFO Starting confd
2023-06-02T16:44:19Z 3a63172cba85 confd[103]: INFO Backend source(s) set to 
2023-06-02T16:44:21Z 3a63172cba85 confd[117]: INFO Backend set to ssm
2023-06-02T16:44:21Z 3a63172cba85 confd[117]: INFO Starting confd
2023-06-02T16:44:21Z 3a63172cba85 confd[117]: INFO Backend source(s) set to 
2023-06-02T16:44:21Z 3a63172cba85 confd[117]: INFO /tmp/myconfig.conf has md5sum 79a6ed64d03a7b116744f36a3f13940a should be 72b1af80140ab6de65ebdbba20350a67
2023-06-02T16:44:21Z 3a63172cba85 confd[117]: INFO Target config /tmp/myconfig.conf out of sync
2023-06-02T16:44:21Z 3a63172cba85 confd[117]: INFO Target config /tmp/myconfig.conf has been updated
2023-06-02T16:44:23Z 3a63172cba85 confd[131]: INFO Backend set to ssm
2023-06-02T16:44:23Z 3a63172cba85 confd[131]: INFO Starting confd
2023-06-02T16:44:23Z 3a63172cba85 confd[131]: INFO Backend source(s) set to 
cmd db url: db.example.com
cmd db user: test
bye from cmd
after eval
```

This is basically just a wraper around [confd](https://github.com/kelseyhightower/confd) with some shell redirection to hang this on an entrypoint of a docker container. This allows for config and secrets to be loaded synamically inside of a container from any backend supported by confd.
