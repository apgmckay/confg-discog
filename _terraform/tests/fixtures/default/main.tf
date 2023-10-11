module "app" {
  source                      = "../../../"
  external_params_path_prefix = ["platform", "service"]

  parameter_prefix = "app"
  params = [{
    name  = "app_username"
    value = "andy"
    type  = "String"
    },
    {
      name  = "app_password"
      value = "mysafepassword"
      type  = "SecureString"
    },
    {
      name  = "app_url"
      value = "myapiurl.co.uk"
      type  = "String"
    },
    {
      name  = "api_token"
      value = "6f5902ac237024bdd0c176cb93063dc4"
      type  = "SecureString"
    }
  ]

  tf_template_render           = var.tf_template_render
  confg_discog_config_file     = "../../../confd/conf.d/myconfig.toml"
  confg_discog_app_config_file = "../../../confd/conf.d/myconfig.sh"
  // NOTE: these two config vars represent the actual config on disk in the app runtime, they are the files that confd uses to render it params.
  confg_discog_src_file  = "myconfig.sh.tmpl"
  confg_discog_dest_file = "/tmp/myconfig.sh"
}
