resource "aws_secretsmanager_secret" "webhook_relay_secret" {
  name = "webhook-relay-secret"
}
