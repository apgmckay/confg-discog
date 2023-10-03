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

  get_external_params = length(var.platform_params_path_prefix) > 1 ? 1 : 0
}

// TODO: the conditional grabbing of data ssm_params_by_path creates the following problems that need to be fixed
// -  everything has to be referenced by index. This is an issue for the empty case 

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
  content  = templatefile("${path.module}/templates/myconfig.toml.tmpl", { param_names = local.param_names, platform_param_names = data.aws_ssm_parameters_by_path.params[0].names })
  filename = format("%s/%s", local.templatefilepath, "myconfig.toml")
}

output "template_filepath" {
  description = "Template file rendered to filesystem at value."
  value       = local.templatefilepath
}

output "template_file_contents" {
  description = "Template file contents."
  value       = templatefile("${path.module}/templates/myconfig.toml.tmpl", { param_names = local.param_names, platform_param_names = data.aws_ssm_parameters_by_path.params[0].names })
}
