package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"time"
)

var confdRunIntervalSeconds = 2

func main() {
	log.Println("Starting confg-discog")

	confdLogLevel := "info"

	log.Printf("loglevel set to %s\n", confdLogLevel)

	ticker := time.NewTicker(time.Duration(confdRunIntervalSeconds) * time.Second)
	done := make(chan bool)

	go func() {
		fmt.Println("starting")
		for {
			select {
			case <-done:
				return
			case <-ticker.C:
				/*
					NOTE: drop error here is by design
				*/
				runConfdOnetime(confdLogLevel)
			}
		}
	}()

	fmt.Scanln()
	ticker.Stop()
	done <- true
	// fmt.Println("Stopped.")
}

func runConfdOnetime(logLevel string) error {
	confidCommand := []string{"confd", "-onetime", "-backend", "ssm", "-log-level", logLevel}
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
