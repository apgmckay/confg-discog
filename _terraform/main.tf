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

// resource "aws_secretsmanager_secret" "fixture" {
//   name = var.secrets_store_name
// }
//
// resource "aws_secretsmanager_secret_version" "example" {
//   secret_id     = aws_secretsmanager_secret.fixture.id
//   secret_string = file("test_secret.json")
// }
