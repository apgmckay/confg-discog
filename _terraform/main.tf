# TODO: this should be moved into tests
module "app" {
  source = "./module/parameters"

  # TODO: this should be a list
  platform_params_path_prefix = "/test/"
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

  # TODO: this will need delting
  template_render = var.template_render

  confg_discog_template_output_path = "../confd/conf.d/"
  confg_discog_config_file          = "myconfig.toml"
  confg_discog_app_config_file      = "myconfig.sh"
  confg_discog_src_file             = "myconfig.sh.tmpl"
  confg_discog_dest_file            = "/tmp/myconfig.sh"
}
