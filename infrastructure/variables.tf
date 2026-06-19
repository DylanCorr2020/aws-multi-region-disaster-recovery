
variable "instance_type" {
  description = "EC2 instance type used by the primary and DR instances"
  type        = string
  default     = "t2.micro"
}

variable "ami_eu_west_1" {
  description = "Ubuntu AMI used for the primary EC2 instance in eu-west-1"
  type        = string
  default     = "ami-0de864d6a3bd20ea8"
}

variable "ami_eu_west_2" {
  description = "Ubuntu AMI used for the disaster recovery EC2 instance in eu-west-2"
  type        = string
  default     = "ami-0d114020bf27f27cf"
}

variable "alert_email" {
  description = "Email address used for SNS disaster recovery notifications"
  type        = string
  default     = "dylancorr.g@gmail.com"
}

variable "project_name" {
  description = "Project name used for resource tagging"
  type        = string
  default     = "pilot-light-dr"
}


variable "aws_route53_zone" {
  description = "domain name"
  type = string
  default = "pilotlight.xyz"
  
}
