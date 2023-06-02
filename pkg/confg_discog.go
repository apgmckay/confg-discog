package confg_discog

import (
	"log"
	"os"
	"os/exec"
	"time"
)

type ConfgDiscog struct {
	interval int
}

func New(runInterval int) ConfgDiscog {
	return ConfgDiscog{
		interval: runInterval,
	}
}

func (cg *ConfgDiscog) Run() {
	log.Println("Starting confg-discog")

	confdLogLevel := "info"

	log.Printf("loglevel set to %s\n", confdLogLevel)

	ticker := time.NewTicker(time.Duration(cg.interval) * time.Second)
	defer ticker.Stop()

	for range ticker.C {
		runConfdOnetime(confdLogLevel)
	}
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
