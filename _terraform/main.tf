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

resource "aws_secretsmanager_secret" "someconfg_password" {
  name = "someconfig_password_1"
}

resource "aws_secretsmanager_secret_version" "someconfig_password" {
  secret_id = aws_secretsmanager_secret.someconfg_password.id
  secret_string = jsonencode({
    username = "admin",
    password = "supersecret"
  })
}
