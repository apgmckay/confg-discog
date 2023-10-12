package confg_discog

import (
	"errors"
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

var UnsupportedBackendErr = errors.New("ERROR: Unspported backend.")
var UnspportedLogLevel = errors.New("ERROR: Unspported log level.")
var ConfigFileNotExistsErr = errors.New("ERROR: Config file not exists.")

func New() ConfgDiscog {
	logPrefix := "confg_discog:"
	return ConfgDiscog{
		logPrefix: logPrefix,
	}
}

func (cd *ConfgDiscog) SetInterval(runInterval int) {
	cd.interval = runInterval
}

func (cd *ConfgDiscog) SetBackend(backend string) error {
	var err error
	switch backend {
	case "ssm":
		cd.backend = backend
	default:
		cd.backend = ""
		err = UnsupportedBackendErr
	}
	return err
}

func (cd *ConfgDiscog) SetLogLevel(logLevel string) error {
	var err error
	switch logLevel {
	case "panic":
		cd.logLevel = logLevel
	case "fatal":
		cd.logLevel = logLevel
	case "error":
		cd.logLevel = logLevel
	case "warn":
		cd.logLevel = logLevel
	case "info":
		cd.logLevel = logLevel
	case "debug":
		cd.logLevel = logLevel
	default:
		cd.logLevel = ""
		err = UnspportedLogLevel
	}
	return err
}

func (cd *ConfgDiscog) SetConfigFile(configFileName string) error {
	var err error
	if _, err := os.Stat(configFileName); err == nil {
		cd.configFile = configFileName
	} else {
		cd.configFile = ""
		err = ConfigFileNotExistsErr
	}
	return err
}

func (cd *ConfgDiscog) Run() {
	ticker := time.NewTicker(time.Duration(cd.interval) * time.Second)
	defer ticker.Stop()

	for range ticker.C {
		cd.RunConfdOnetime()
	}
}

func (cd *ConfgDiscog) RunConfdOnetime() error {
	configFileArg := []string{"-config-file", cd.configFile}
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
