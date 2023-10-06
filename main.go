package main

import (
	confg_discog "confg-discog/pkg"
)

var interval = 2
var confdLogLevel = "info"
var confdBackend = "ssm"
var confdConfigFile = "/etc/confd/conf.d/myconfig.toml"

func main() {
	cd := confg_discog.New(interval)

	cd.SetConfigFile(confdConfigFile)
	cd.SetBackend(confdBackend)
	cd.SetLogLevel(confdLogLevel)

	cd.Run()
}
