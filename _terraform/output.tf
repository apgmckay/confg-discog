output "someconfig_url" {
  value     = aws_ssm_parameter.someconfig_url
  sensitive = true
}

output "someconfig_user" {
  value     = aws_ssm_parameter.someconfig_user
  sensitive = true
}

output "secret_name" {
  value = local.secret_name
}
