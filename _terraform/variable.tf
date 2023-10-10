variable "platform_params_path_prefix" {
  type        = string
  description = "Prefix path that will be used to gather pre existing parameters."
  default     = ""
}

variable "parameter_prefix" {
  type        = string
  default     = "bnw"
  description = "Prefix that will be appended to all parameter namespace, this will appear in the format `/confg_discog/var.parameter_prefix/`."
}

variable "params" {
  type = list(object({
    name  = string
    value = string
    type  = string
  }))
  description = "Names values and types of the parameter that are going to be created/updated."
}

variable "template_render" {
  type        = bool
  description = "Render confgd toml config file?"
}

variable "confg_discog_template_output_path" {
  type        = string
  description = "Path of where to render confgd toml template."
}

variable "confg_discog_config_file" {
  type        = string
  description = "Confd toml config file name."
}

variable "confg_discog_app_config_file" {
  type        = string
  description = "Confd bash confg file for apps."
}

variable "confg_discog_src_file" {
  type = string
}

variable "confg_discog_dest_file" {
  type = string
}
