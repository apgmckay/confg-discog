// TODO: this is currently wrong
// output "config_discog_params_names" {
//   value       = local.ssm_param_prefixed_objects[*].name
//   description = "Current confg_discog parameter names"
// }
//

output "template_filepath" {
  description = "Template file rendered to filesystem at value."
  value       = local.templatefilepath
}

output "template_confgd_config_toml_contents" {
  description = "Template file contents."
  value       = local.cgd_config_toml_file
}
