module "platform" {
  source = "../../../"

  parameter_prefix = "platform"
  params = [{
    name  = "app_username"
    value = "andy"
    type  = "String"
    },
    {
      name  = "da_connection_string"
      value = "mongo://somenonrealconnectionstring.eu_west_1.com"
      type  = "String"
    },
    {
      name  = "otel_collector_endpoint"
      value = "otel://otelsubdomain.eu_west_1.com"
      type  = "String"
    },
    {
      name  = "new_relic_dashboard"
      value = "http://newrelic.eu_west_1.com"
      type  = "String"
    },
  ]
  tf_template_render = false
}

module "service" {
  source = "../../../"

  parameter_prefix = "service"
  params = [{
    name  = "sidecar_service"
    value = "https://somesidecarurl.simplebusiness.me"
    type  = "String"
    },
  ]
  tf_template_render = false
}
