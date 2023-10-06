package confg_discog

import (
	"os"
	"os/exec"
	"time"
)

type ConfgDiscog struct {
	interval   int
	backend    string
	logLevel   string
	logPrefix  string
	configFile string
}

func New(runInterval int) ConfgDiscog {
	logPrefix := "confg_discog:"
	return ConfgDiscog{
		interval:  runInterval,
		logPrefix: logPrefix,
	}
}

func (cd *ConfgDiscog) SetInterval(runInterval int) {
	cd.interval = runInterval
}

func (cd *ConfgDiscog) SetBackend(backend string) {
	cd.backend = backend
}

func (cd *ConfgDiscog) SetLogLevel(logLevel string) {
	cd.logLevel = logLevel
}

func (cd *ConfgDiscog) SetConfigFile(configFileName string) {
	cd.configFile = configFileName
}

func (cd *ConfgDiscog) Run() {
	ticker := time.NewTicker(time.Duration(cd.interval) * time.Second)
	defer ticker.Stop()

	for range ticker.C {
		cd.RunConfdOnetime()
	}
}

func (cd *ConfgDiscog) RunConfdOnetime() error {
	var configFileArg []string
	if len(cd.configFile) > 0 {
		configFileArg = []string{"-config-file", cd.configFile}
	}
	confidCommand := []string{"confd", "-onetime", "-backend", cd.backend, "-log-level", cd.logLevel}

	confidCommand = append(confidCommand, configFileArg...)

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
