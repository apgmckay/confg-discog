resource "aws_ssm_parameter" "fixture" {
  name        = var.parameter_store_name
  description = "Test fixture for ssm parameter store"
  type        = "String"
  value       = var.parameter_store_value
}

resource "aws_secretsmanager_secret" "fixture" {
  name = var.secrets_store_name
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.fixture.id
  secret_string = file("test_secret.json")
}

resource "aws_sns_topic" "my_topic" {
  name = var.sns_topic_name
}

output "topic_arn" {
  value = aws_sns_topic.my_topic.arn
}
