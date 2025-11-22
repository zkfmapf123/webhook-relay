resource "aws_security_group" "webhook_relay_alb_security_group" {
  name        = "webhook-relay-alb-security-group"
  description = "Allow traffic from the internet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    description = "HTTP"
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    description = "HTTPS"
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = []
}

resource "aws_lb" "webhook_relay_alb" {
  name                       = "webhook-relay-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.webhook_relay_alb_security_group.id]
  subnets                    = var.lb_subnet_ids
  enable_deletion_protection = false
  tags = {
    Name = "webhook-relay-alb"
  }
}

resource "aws_lb_listener" "webhook_relay_alb_listener" {
  load_balancer_arn = aws_lb.webhook_relay_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  certificate_arn = var.lb_acm

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webhook_relay_alb_target_group.arn
  }
}

resource "aws_lb_target_group" "webhook_relay_alb_target_group" {
  name        = "webhook-relay-alb-target-group"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "lambda"

  lambda_multi_value_headers_enabled = false

  tags = {
    Name = "webhook-relay-alb-target-group"
  }
}
