package main

import (
	confg_discog "confg-discog/pkg"
	"log"
)

var interval = 2
var confdLogLevel = "info"
var confdBackend = "ssm"

func main() {
	log.Println("entrypoint: Hello!")
	cd := confg_discog.New(interval)
	cd.SetBackend(confdBackend)
	cd.Run()
}
