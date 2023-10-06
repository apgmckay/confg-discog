variable "template_render" {
  type        = bool
  description = "Render confgd toml config file?"
  default     = true
}

variable "confgd_toml_filepath" {
  type        = string
  description = "Path to output confgd toml config file."
  default     = "../confd/conf.d/"
}

variable "confg_discog_config_file" {
  type    = string
  default = "myconfig.toml"
}

variable "confg_discog_app_config_file" {
  type    = string
  default = "myconfig.sh"
}
