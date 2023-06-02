package main

import (
	"log"
	"os"
	"os/exec"
)

var confdRunIntervalSeconds = 2

func main() {
	log.Println("Starting confg-discog")

	confdLogLevel := "info"

	log.Printf("loglevel set to %s\n", confdLogLevel)

	runConfdOnetime(confdLogLevel)
}

func runConfdOnetime(logLevel string) error {
	confidCommand := []string{"confd", "-backend", "ssm", "-log-level", logLevel}
	err := runCommand(confidCommand[0], confidCommand[1:])
	if err != nil {
		return err
	}
	return nil
}

func runCommand(command string, args []string) error {
	cmd := exec.Command(command, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		return err
	}
	return nil
}
