variable "vpc_id" {
  default = ""
}

variable "lb_subnet_ids" {
  description = "LB subnet IDs - public subnets"
  default     = []
}

variable "lambda_subnet_ids" {
  description = "Lambda subnet IDs - private subnets"
  default     = []
}

variable "lb_acm" {
  description = "ACM certificate ARN"
  default     = ""
}

variable "lb_domain" {
  description = "LB domain"
  default     = ""
}


