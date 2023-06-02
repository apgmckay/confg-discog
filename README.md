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
test
after
hello
2023/06/02 16:24:39 Starting confg-discog
2023/06/02 16:24:39 loglevel set to info
2023-06-02T16:24:39Z e6ac152e9e56 confd[13]: INFO Backend set to ssm
2023-06-02T16:24:39Z e6ac152e9e56 confd[13]: INFO Starting confd
2023-06-02T16:24:39Z e6ac152e9e56 confd[13]: INFO Backend source(s) set to 
2023-06-02T16:24:39Z e6ac152e9e56 confd[13]: INFO Target config /tmp/myconfig.conf out of sync
2023-06-02T16:24:39Z e6ac152e9e56 confd[13]: INFO Target config /tmp/myconfig.conf has been updated
db.example.com
hello
db.example.com
hello
bye
after eval
```

This is basically just a wraper around [confd](https://github.com/kelseyhightower/confd) with some shell redirection to hang this on an entrypoint of a docker container. This allows for config and secrets to be loaded synamically inside of a container from any backend supported by confd.
