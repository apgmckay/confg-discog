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
  default = [{
    name  = "app_username"
    value = "andy"
    type  = "String"
    },
    {
      name  = "app_password"
      value = "mysafepassword"
      type  = "SecureString"
    },
    {
      name  = "app_url"
      value = "myapiurl.co.uk"
      type  = "String"
    },
    {
      name  = "api_tokent"
      value = "6f5902ac237024bdd0c176cb93063dc4"
      type  = "SecureString"
    }
  ]
}

variable "template_render" {
  type        = bool
  description = "Render confgd toml config file?"
}

variable "template_output_path" {
  type        = string
  description = "Path of where to render confgd toml template."
}
