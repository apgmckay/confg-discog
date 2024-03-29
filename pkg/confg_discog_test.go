package confg_discog

import (
	"fmt"
	"os"
	"reflect"
	"testing"
)

func TestNew(t *testing.T) {
	cd := New()

	expectedType := "confg_discog.ConfgDiscog"
	got := fmt.Sprintf("%s", reflect.TypeOf(cd))

	if expectedType != got {
		t.Logf("expected: %s got: %s", expectedType, got)
		t.Fail()
	}
}
func TestSetInterval(t *testing.T) {
	tests := []struct {
		input    int
		expected int
	}{
		{10, 10},
	}
	cd := New()
	for _, v := range tests {
		cd.SetInterval(v.input)

		got := cd.interval
		if got != v.expected {
			t.Logf("expected: %d got: %d", v.expected, got)
			t.Fail()
		}
	}

}

func TestSetBackend(t *testing.T) {
	tests := []struct {
		input         string
		expected      string
		expectedError error
	}{
		{"ssm", "ssm", nil},
		{"dynamodb", "", UnsupportedBackendErr},
		{"redis", "", UnsupportedBackendErr},
		{"vault", "", UnsupportedBackendErr},
		{"zookeeper", "", UnsupportedBackendErr},
		{"etcd", "", UnsupportedBackendErr},
		{"console", "", UnsupportedBackendErr},
		{"badInput", "", UnsupportedBackendErr},
	}
	cd := New()
	for _, v := range tests {
		gotErr := cd.SetBackend(v.input)
		got := cd.backend
		if cd.backend != v.expected {
			t.Logf("expected: %s got: %s", v.expected, got)
			t.Fail()
		}

		if gotErr != v.expectedError {
			t.Logf("expectedError: %s got: %s", v.expectedError, gotErr)
			t.Fail()
		}
	}
}

func TestLogLevel(t *testing.T) {
	tests := []struct {
		input         string
		expected      string
		expectedError error
	}{
		{"debug", "debug", nil},
		{"info", "info", nil},
		{"warn", "warn", nil},
		{"error", "error", nil},
		{"fatal", "fatal", nil},
		{"panic", "panic", nil},
		{"badInput", "", UnspportedLogLevel},
	}
	cd := New()
	for _, v := range tests {
		gotErr := cd.SetLogLevel(v.input)
		got := cd.logLevel
		if got != v.expected {
			t.Logf("expected: %s got: %s", v.expected, got)
			t.Fail()
		}

		if gotErr != v.expectedError {
			t.Logf("expected: %s got: %s", v.expectedError, gotErr)
			t.Fail()
		}
	}

}

func TestSetConfigFile(t *testing.T) {
	tests := []struct {
		input         string
		expected      string
		expectedError error
	}{
		{"./test.toml", "./test.toml", nil},
		{"./test_2.toml", "./test_2.toml", nil},
		{"./no_file.toml", "", ConfigFileNotExistsErr},
		{"./no_file_2.toml", "", ConfigFileNotExistsErr},
		{"./no_file_3.toml", "", ConfigFileNotExistsErr},
	}
	cd := New()

	for _, v := range tests {
		if v.expectedError == nil {
			createFile(v.input)
		}

		gotErr := cd.SetConfigFile(v.input)
		got := cd.configFile
		if got != v.expected {
			t.Logf("expected: %s got: %s", v.expected, got)
			t.Fail()
		}
		if gotErr != v.expectedError {
			t.Logf("expected: %s got: %s", v.expected, gotErr)
		}

		if v.expectedError == nil {
			os.Remove(v.input)
		}
	}
}

func createFile(name string) error {
	f, err := os.Create(name)
	if err != nil {
		return err
	}
	f.Close()
	return nil
}
