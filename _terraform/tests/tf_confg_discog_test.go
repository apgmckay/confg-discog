package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestFixturesDefault(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables and check they have the expected values.
	//	output := terraform.Output(t, terraformOptions, "hello_world")
	//	assert.Equal(t, "Hello, World!", output)
}
