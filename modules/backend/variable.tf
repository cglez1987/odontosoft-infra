variable "region" {
  type    = string
  default = "us-east-1"
}

variable "stage" {
  type        = string
  description = "Name of the stage to build this module"
  default     = "dev"
}

variable "elb_protocol" {
  description = "Protocol used by Elastic Load Balancer"
  default     = "HTTP"
}

variable "elb_port" {
  description = "Port used by Elastic Load Balancer"
  default     = 80
}

variable "elb_is_internal" {
  description = "Boolean value to config whether the Elastic Load Balancer is internal or no"
  default     = false
}

variable "elb_hc_path" {
  description = "Path to check the elastic load balancer healthcheck"
  default = "/"
}

variable "ami_names_to_filter" {
  description = "List of AMI names to filter"
  default     = ["amzn2-ami-hvm-*-x86_64-gp2"]
}

variable "launch_template_name" {
  description = "Name of Launch Template"
  default     = "app_backend"
}

variable "lt_instance_type" {
  description = "Instance type for launch template"
  default     = "t2.micro"
}

variable "lt_key_pair_name" {
  description = "Key pair name for launch template"
  default     = "HildaKeyPair"
}
