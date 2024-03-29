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

  formater_string = "export %s={{getv \"%s\"}}" # TODO: it could be interesting to expose this as a var, that might solve the problem of different config types

  ssm_external_param_names_path      = [for v in var.external_params_path_prefix : format("/%s/%s", local.default_prefix, v)]
  ssm_external_param_names_all       = [for v in data.aws_ssm_parameters_by_path.params : v.names]
  ssm_external_param_names_flattened = flatten(local.ssm_external_param_names_all)

  ssm_external_param_names_upper = [for v in local.ssm_external_param_names_flattened : trim(replace(upper(v), "/", "_"), "_")]
  ssm_external_param_names_bash  = [for i, v in local.ssm_external_param_names_flattened : format(local.bash_formater_string, local.ssm_external_param_names_upper[i], v)]

  input_app_param_names = [for key, value in local.ssm_param_prefixed_objects : value.name]

  bash_formater_string       = "export %s={{getv \"%s\"}}"
  input_app_param_names_bash = [for key, value in local.input_app_param_names : format(local.bash_formater_string, trim(replace(upper(value), "/", "_"), "_"), value)]

  tf_confd_toml_template_file = "${path.module}/templates/myconfig.toml.tmpl"
  tf_confd_sh_template_file   = "${path.module}/templates/myconfig.sh.tmpl"

  cgd_config_toml_file = templatefile(format("%s", local.tf_confd_toml_template_file), {
    app_param_names      = local.input_app_param_names,
    external_param_names = local.ssm_external_param_names_flattened,
    confd_src_file       = var.confg_discog_src_file,
    confd_dest_file      = var.confg_discog_dest_file
  })

  cgd_bash_runtime_file = templatefile(format("%s", local.tf_confd_sh_template_file), { external_param_names = local.ssm_external_param_names_bash, app_param_names = local.input_app_param_names_bash })
}

data "aws_ssm_parameters_by_path" "params" {
  count     = length(local.ssm_external_param_names_path)
  path      = local.ssm_external_param_names_path[count.index]
  recursive = true
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
  filename = format("%s", var.confg_discog_config_file)
}

resource "local_file" "confg_discog_template_bash" {
  count    = var.tf_template_render == true ? 1 : 0
  content  = local.cgd_bash_runtime_file
  filename = format("%s", var.confg_discog_app_config_file)
}
