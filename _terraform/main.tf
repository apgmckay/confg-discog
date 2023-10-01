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
}
