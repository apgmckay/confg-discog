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

  get_platform_params      = length(var.platform_params_path_prefix) > 1 ? 1 : 0
  ssm_platform_param_names = [for v in data.aws_ssm_parameters_by_path.params[0].names : v]
  platform_param_names     = [for v in local.ssm_platform_param_names : format("export %s={{getv \"%s\"}}", upper(split(var.platform_params_path_prefix, v)[1]), v)]

  tf_confd_toml_template_file = "${path.module}/templates/myconfig.toml.tmpl"
  tf_confd_sh_template_file   = "${path.module}/templates/myconfig.sh.tmpl"

  input_app_param_names = [for key, value in local.ssm_param_prefixed_objects : value.name]
  app_param_names       = [for key, value in local.input_app_param_names : format("export %s={{getv \"%s\"}}", upper(split(format("%s/", local.prefix), value)[1]), value)]

  cgd_config_toml_file = local.get_platform_params == 1 ? templatefile(format("%s", local.tf_confd_toml_template_file), {
    app_param_names      = local.input_app_param_names,
    platform_param_names = data.aws_ssm_parameters_by_path.params[0].names,
    confd_src_file       = var.confg_discog_src_file,
    confd_dest_file      = var.confg_discog_dest_file
    }) : templatefile(format("%s", local.tf_confd_toml_template_file), {
    app_param_names      = local.input_app_param_names,
    platform_param_names = [],
    confd_src_file       = var.confg_discog_src_file,
    confd_dest_file      = var.confg_discog_dest_file
  })

  cgd_bash_runtime_file = templatefile(format("%s", local.tf_confd_sh_template_file), { platform_param_names = local.platform_param_names, app_param_names = local.app_param_names })
}

data "aws_ssm_parameters_by_path" "params" {
  count = local.get_platform_params
  path  = var.platform_params_path_prefix
}

resource "aws_ssm_parameter" "params" {
  count = length(var.params)
  name  = local.ssm_param_prefixed_objects[count.index].name
  type  = local.ssm_param_prefixed_objects[count.index].type
  value = local.ssm_param_prefixed_objects[count.index].value
}

resource "local_file" "confg_discog_template_toml" {
  count    = var.tf_template_render == true ? 1 : 0
  content  = local.cgd_config_toml_file
  filename = format("%s/%s", var.tf_confg_discog_template_output_path, var.tf_confg_discog_config_file)
}

resource "local_file" "confg_discog_template_bash" {
  count    = var.tf_template_render == true ? 1 : 0
  content  = local.cgd_bash_runtime_file
  filename = format("%s/%s", var.tf_confg_discog_template_output_path, var.confg_discog_app_config_file)
}
