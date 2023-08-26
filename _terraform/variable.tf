variable "parameter_prefix" {
  type        = string
  default     = "config_discog"
  description = "prefix that will be appended to all parameter namespace, this will appear in the format /confg_discog/var.parameter_prefix/"
}

variable "params" {
  type = list(object({
    name  = string
    value = string
    type  = string
  }))
  description = "names values and types of the parameter that are going to be stored"
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
    }
  ]
}
