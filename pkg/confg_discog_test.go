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
