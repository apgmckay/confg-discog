locals {
  # TODO: If the intent is for this to be a temporary scratch dir then this needs to be more random to prevent naming collisions
  confgd_toml_filepath = "../some_newdir/"
}

module "platform" {
  source           = "./module/parameters"
  parameter_prefix = "platform"
  params = [{
    name  = "db_connection_string"
    value = "mongodb://some-connection-string/"
    type  = "String"
    },
    {
      name  = "db_name"
      value = "app_name"
      type  = "SecureString"
    },
    {
      name  = "redis_connection_string"
      value = "some-elasticache-endpoint.cache.amazonaws.com"
      type  = "String"
    }
  ]
  template_output_path = local.confgd_toml_filepath
}


module "app" {
  source           = "./module/parameters"
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
      name  = "api_tokent"
      value = "6f5902ac237024bdd0c176cb93063dc4"
      type  = "SecureString"
    }
  ]
  template_output_path = local.confgd_toml_filepath
}
