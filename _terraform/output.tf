output "someconfig_url" {
  value     = aws_ssm_parameter.someconfig_url
  sensitive = true
}

output "someconfig_user" {
  value     = aws_ssm_parameter.someconfig_user
  sensitive = true
}

output "someconfg_password_v_id" {
  value = aws_secretsmanager_secret_version.example_secret_version.version_id
}
