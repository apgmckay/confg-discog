package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

/*
	NOTE: The ordering of TestTFModuleConfigDiscogRenderOn is intentionally last here so that it
	can be used to bootstrap confg_discog_build_and_run to perform local end-to-end tests.
*/

var skipTeardown = true

func TestTFModuleConfigDiscogRenderOff(t *testing.T) {
	tfInputDir := "./fixtures/default"
	tfInputs := map[string]interface{}{
		"tf_template_render":           false,
		"confg_discog_config_file":     "confd/conf.d/myconfig.toml",
		"confg_discog_app_config_file": "confd/conf.d/myconfig.sh",
		"external_params_path_prefix":  []string{"platform", "service"},
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tfInputDir,
		Vars:         tfInputs,
	})

	if !skipTeardown {
		defer terraform.Destroy(t, terraformOptions)
	}

	terraform.InitAndApply(t, terraformOptions)

	if FileExists(fmt.Sprintf("%s/%s", tfInputDir, tfInputs["confg_discog_config_file"])) {
		t.Logf("\nFile %s should NOT exists, it does.", fmt.Sprintf("%s/%s", tfInputDir, tfInputs["confg_discog_config_file"]))
		t.Fail()
	}
}

func TestTFModuleConfigDiscogRenderOn(t *testing.T) {
	tfSetupOptions := setupTerraform(t)
	if !skipTeardown {
		defer terraform.Destroy(t, tfSetupOptions)
	}
	terraform.InitAndApply(t, tfSetupOptions)

	tfInputDir := "./fixtures/default"
	tfInputs := map[string]interface{}{
		"tf_template_render":           true,
		"confg_discog_config_file":     "confd/conf.d/myconfig.toml",
		"confg_discog_app_config_file": "confd/conf.d/myconfig.sh",
		"external_params_path_prefix":  []string{"platform", "service"}, // NOTE: This can be updated to be []string{}, to test if no params are set with `confg_discog_build_and_run`.
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tfInputDir,
		Vars:         tfInputs,
	})

	if !skipTeardown {
		defer terraform.Destroy(t, terraformOptions)
	}

	terraform.InitAndApply(t, terraformOptions)

	if !FileExists(fmt.Sprintf("%s/%s", tfInputDir, tfInputs["confg_discog_config_file"])) {
		t.Logf("\nFile %s does NOT exists, it should.", fmt.Sprintf("%s/%s", tfInputDir, tfInputs["confg_discog_config_file"]))
		t.Fail()
	}
}
func FileExists(filename string) bool {
	_, err := os.Stat(filename)
	if os.IsNotExist(err) {
		return false
	}
	return err == nil
}

func setupTerraform(t *testing.T) *terraform.Options {
	terraformOptions := &terraform.Options{
		TerraformDir: "./fixtures/setup/",
	}
	return terraformOptions
}
