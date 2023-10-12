package main

import (
	confg_discog "confg-discog/pkg"
	"log"
	"os"
)

var interval = 2
var confdLogLevel = "info"
var confdBackend = "ssm"
var confdConfigFile = "/etc/confd/conf.d/myconfig.toml"

func main() {
	var err error

	cd := confg_discog.New()

	cd.SetInterval(interval)
	err = cd.SetConfigFile(confdConfigFile)
	handleErrorExit(err, 1)
	err = cd.SetBackend(confdBackend)
	handleErrorExit(err, 1)
	err = cd.SetLogLevel(confdLogLevel)
	handleErrorExit(err, 1)

	cd.Run()
}

func handleErrorExit(err error, exitCode int) {
	if err != nil {
		log.Printf("%s", err)
		os.Exit(exitCode)
	}
}
