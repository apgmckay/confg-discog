module "app" {
  source                      = "./module/parameters"
  platform_params_path_prefix = "/test"
  parameter_prefix            = "app"
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
  template_render      = var.template_render
  template_output_path = var.confgd_toml_filepath
}
