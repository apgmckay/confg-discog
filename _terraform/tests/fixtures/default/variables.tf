variable "tf_template_render" {
  type        = bool
  description = "Render confgd toml config file?"
  default     = true
}

variable "confg_discog_config_file" {
  type = string
}

variable "confg_discog_app_config_file" {
  type = string
}

variable "external_params_path_prefix" {
  type = list(string)
}
