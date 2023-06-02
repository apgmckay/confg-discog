package main

import (
	confg_discog "confg-discog/pkg"
)

var interval = 2
var confdLogLevel = "info"

func main() {
	cd := confg_discog.New(interval)
	cd.Run()
}
