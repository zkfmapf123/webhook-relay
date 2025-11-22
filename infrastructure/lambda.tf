resource "aws_iam_role" "webhook_relay_lambda_role" {
  name = "webhook-relay-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "webhook_relay_lambda_policy" {
  role = aws_iam_role.webhook_relay_lambda_role.id
  policy = jsonencode({
    "Statement" : [
      {
        "Sid" : "Logs",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:logs:*:*:*"
      },
      {
        "Sid" : "SecretsManager",
        "Action" : [
          "secretsmanager:*"
        ],
        "Effect" : "Allow",
        "Resource" : aws_secretsmanager_secret.webhook_relay_secret.arn
      },
      {
        "Sid" : "EC2NetworkInterface",
        "Action" : [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSubnets",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
    ],
    "Version" : "2012-10-17"
  })
}

resource "aws_security_group" "webhook_relay_lambda_security_group" {
  name        = "webhook-relay-lambda-security-group"
  description = "Allow traffic from ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 0
    description     = "Allow traffic from ALB"
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.webhook_relay_alb_security_group.id]
  }
  egress = []
}

resource "aws_lambda_permission" "webhook_relay_lambda_permission" {
  statement_id  = "AllowALBInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.webhook_relay_lambda.function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.webhook_relay_alb_target_group.arn
}

resource "aws_lambda_function" "webhook_relay_lambda" {
  function_name = "webhook-relay-lambda"
  role          = aws_iam_role.webhook_relay_lambda_role.arn
  handler       = "main.Handler"
  runtime       = "provided.al2023"
  filename      = "webhook-relay.zip"

  memory_size   = 128
  timeout       = 30
  architectures = ["arm64"]

  environment {
    variables = {
      SECRET_NAME = aws_secretsmanager_secret.webhook_relay_secret.name
    }
  }

  vpc_config {
    subnet_ids         = var.lambda_subnet_ids
    security_group_ids = [aws_security_group.webhook_relay_lambda_security_group.id]
  }
}
