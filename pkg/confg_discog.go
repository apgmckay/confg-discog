package confg_discog

import (
	"log"
	"os"
	"os/exec"
	"time"
)

type ConfgDiscog struct {
	interval  int
	backend   string
	logLevel  string
	logPrefix string
}

func New(runInterval int) ConfgDiscog {
	logPrefix := "entrypoint:"
	log.Printf("%s new ConfgDiscog!", logPrefix)
	return ConfgDiscog{
		interval:  runInterval,
		logPrefix: logPrefix,
	}
}

func (cd *ConfgDiscog) SetInterval(runInterval int) {
	log.Printf("%s set interval == %d\n", cd.logPrefix, runInterval)
	cd.interval = runInterval
}

func (cd *ConfgDiscog) SetBackend(backend string) {
	log.Printf("%s set backend == %s\n", cd.logPrefix, backend)
	cd.backend = backend
}

func (cd *ConfgDiscog) SetLogLevel(logLevel string) {
	log.Printf("%s set backend == %s\n", cd.logPrefix, logLevel)
	cd.logLevel = logLevel
}

func (cd *ConfgDiscog) Run() {
	log.Printf("%s ConfgDiscog Running!", cd.logPrefix)

	confdLogLevel := "info"

	log.Printf("%s loglevel set to %s\n", cd.logPrefix, confdLogLevel)

	ticker := time.NewTicker(time.Duration(cd.interval) * time.Second)
	defer ticker.Stop()

	for range ticker.C {
		cd.runConfdOnetime()
	}
}

func (cd *ConfgDiscog) runConfdOnetime() error {
	confidCommand := []string{"confd", "-onetime", "-backend", cd.backend, "-log-level", cd.logLevel}
	log.Printf("%s starting command: %v", cd.logPrefix, confidCommand)
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
