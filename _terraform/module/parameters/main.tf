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


  cgd_config_toml_file = local.get_external_params == 1 ? templatefile("${path.module}/templates/myconfig.toml.tmpl", { param_names = local.param_names, platform_param_names = data.aws_ssm_parameters_by_path.params[0].names }) : templatefile("${path.module}/templates/myconfig.toml.tmpl", { param_names = local.param_names, platform_param_names = [] })

  cgd_bash_runtime_file = templatefile("${path.module}/templates/myconfig.sh.tmpl", { param_names = local.param_names, platform_param_names = data.aws_ssm_parameters_by_path.params[0].names, platform_param_name_bash_env_vars = local.ssm_param_names_split })


  ssm_param_names       = [for v in data.aws_ssm_parameters_by_path.params[0].names : v]
  ssm_param_names_upper = [for v in local.ssm_param_names : upper(v)]
  ssm_param_names_split = [for v in local.ssm_param_names_upper : trimprefix(v, "/TEST/")]


  param_bash_env_vars = [for key, value in data.aws_ssm_parameters_by_path.params[0] : value]
  get_external_params = length(var.platform_params_path_prefix) > 1 ? 1 : 0
}

output "value" {
  value = local.ssm_param_names_split
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
  content  = local.cgd_config_toml_file
  filename = format("%s/%s", local.templatefilepath, "myconfig.toml")
}

resource "local_file" "confg_discog_template_bash" {
  count    = var.template_render == true ? 1 : 0
  content  = local.cgd_bash_runtime_file
  filename = format("%s/%s", local.templatefilepath, "myconfig.sh")
}
