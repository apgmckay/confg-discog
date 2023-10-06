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
	cd := confg_discog.New(interval)

	err = cd.SetConfigFile(confdConfigFile)
	HandleErrorExit(err, 1)
	err = cd.SetBackend(confdBackend)
	HandleErrorExit(err, 1)
	err = cd.SetLogLevel(confdLogLevel)
	HandleErrorExit(err, 1)
	cd.Run()
}

func HandleErrorExit(err error, exitCode int) {
	if err != nil {
		log.Printf("%s", err)
		os.Exit(exitCode)
	}
}
