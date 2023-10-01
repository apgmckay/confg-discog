output "config_discog_params_names" {
  value       = local.ssm_param_prefixed_objects[*].name
  description = "Current confg_discog parameter names"
}
