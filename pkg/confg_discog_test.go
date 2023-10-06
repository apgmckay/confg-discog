package confg_discog

import (
	"fmt"
	"reflect"
	"testing"
)

func TestNew(t *testing.T) {
	expected := 1
	cd := New(expected)

	if cd.interval != expected {
		t.Logf("expected: %d got: %d", expected, cd.interval)
		t.Fail()
	}

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
	cd := New(1)
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
	cd := New(1)
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
		input    string
		expected string
	}{
		{"info", "info"},
	}
	cd := New(1)
	for _, v := range tests {
		cd.SetBackend(v.input)
		got := cd.backend
		if got != v.expected {
			t.Logf("expected: %s got: %s", v.expected, got)
			t.Fail()
		}
	}

}
