locals {
  secret_name = format("someconfig_password_%s", substr(random_uuid.id.id, 0, 6))
}

resource "aws_ssm_parameter" "someconfig_url" {
  name        = "someconfig_url"
  description = "Test fixture for ssm parameter store"
  type        = "String"
  value       = var.someconfig_url_value
}

resource "aws_ssm_parameter" "someconfig_user" {
  name        = "someconfig_user"
  description = "Test fixture for ssm parameter store"
  type        = "String"
  value       = var.someconfig_user_value
}

resource "aws_ssm_parameter" "someconfig_secret_version" {
  name        = "someconfig_secret_version"
  description = "latest secret version id"
  type        = "String"
  value       = aws_secretsmanager_secret_version.someconfig_password.version_id
}

resource "random_uuid" "id" {

}

resource "aws_secretsmanager_secret" "someconfg_password" {
  name = local.secret_name
}

resource "aws_secretsmanager_secret_version" "someconfig_password" {
  secret_id = aws_secretsmanager_secret.someconfg_password.id
  secret_string = jsonencode({
    username = "admin",
    password = "supersecret"
  })
}
