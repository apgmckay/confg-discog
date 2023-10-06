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

variable "tf_confd_toml_template_file" {
  type        = string
  description = "Confd toml template file name this can be a relative path from the calling tf module."
  default     = "templates/myconfig.toml.tmpl"
}

variable "tf_confd_sh_template_file" {
  type        = string
  description = "Confd sh template file name, this can be a relative path from the calling tf module."
  default     = "templates/myconfig.sh.tmpl"
}
