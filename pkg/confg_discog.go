package confg_discog

import (
	"log"
	"os"
	"os/exec"
	"time"
)

type ConfgDiscog struct {
	interval int
	backend  string
	logLevel string
}

func New(runInterval int) ConfgDiscog {
	log.Println("entrypoint: new ConfgDiscog!")
	return ConfgDiscog{
		interval: runInterval,
	}
}

func (cd *ConfgDiscog) SetInterval(runInterval int) {
	log.Println("entrypoint: set interval == %d\n", runInterval)
	cd.interval = runInterval
}

func (cd *ConfgDiscog) SetBackend(backend string) {
	log.Printf("entrypoint: set backend == %s\n", backend)
	cd.backend = backend
}

func (cd *ConfgDiscog) SetLogLevel(logLevel string) {
	log.Printf("entrypoint: set backend == %s\n", logLevel)
	cd.logLevel = logLevel
}

func (cd *ConfgDiscog) Run() {
	log.Println("entrypoint: ConfgDiscog Running!")

	confdLogLevel := "info"

	log.Printf("entrypoint: loglevel set to %s\n", confdLogLevel)

	ticker := time.NewTicker(time.Duration(cd.interval) * time.Second)
	defer ticker.Stop()

	for range ticker.C {
		cd.runConfdOnetime()
	}
}

func (cd *ConfgDiscog) runConfdOnetime() error {
	confidCommand := []string{"confd", "-onetime", "-backend", cd.backend, "-log-level", cd.logLevel}
	log.Printf("entrypoint: starting command: %v", confidCommand)
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
