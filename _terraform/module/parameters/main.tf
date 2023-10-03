locals {
  default_prefix = "confg_discog"
  input_prefix   = var.parameter_prefix
  prefix         = format("/%s/%s", local.default_prefix, local.input_prefix)

  ssm_param_prefixed_objects = [
    for obj in var.params :
    {
      name  = format("%s/%s", local.prefix, obj.name)
      value = obj.value
      type  = obj.type
    }
  ]
  param_names      = [for key, value in local.ssm_param_prefixed_objects : value.name]
  templatefilepath = var.template_output_path


  confgd_toml_file = local.get_external_params == 1 ? templatefile("${path.module}/templates/myconfig.toml.tmpl", { param_names = local.param_names, platform_param_names = data.aws_ssm_parameters_by_path.params[0].names }) : templatefile("${path.module}/templates/myconfig.toml.tmpl", { param_names = local.param_names, platform_param_names = [] })

  get_external_params = length(var.platform_params_path_prefix) > 1 ? 1 : 0
}

data "aws_ssm_parameters_by_path" "params" {
  count = local.get_external_params
  path  = var.platform_params_path_prefix
}

resource "aws_ssm_parameter" "params" {
  count = length(var.params)
  name  = local.ssm_param_prefixed_objects[count.index].name
  type  = local.ssm_param_prefixed_objects[count.index].type
  value = local.ssm_param_prefixed_objects[count.index].value
}

resource "local_file" "confg_discog_template_toml" {
  count    = var.template_render == true ? 1 : 0
  content  = local.confgd_toml_file
  filename = format("%s/%s", local.templatefilepath, "myconfig.toml")
}
