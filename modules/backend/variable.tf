variable "region" {
  type = string
}

variable "stage" {
  type        = string
  description = "Name of the stage to build this module"
}

variable "vpc_id" {
  type        = string
  description = "VPC Id for elb target group"
}

variable "elb_protocol" {
  type        = string
  description = "Protocol used by Elastic Load Balancer"
}

variable "elb_port" {
  type        = number
  description = "Port used by Elastic Load Balancer"
}

variable "elb_is_internal" {
  type        = bool
  description = "Value to config whether the Elastic Load Balancer is internal or no"
  default     = false
}

variable "elb_hc_path" {
  type        = string
  description = "Path to check the elastic load balancer healthcheck"
  default     = "/"
}

variable "ami_names_to_filter" {
  type        = list(any)
  description = "List of AMI names to filter"
}

variable "launch_template_name" {
  type        = string
  description = "Name of Launch Template"
}

variable "lt_instance_type" {
  type        = string
  description = "Instance type for launch template"
}

variable "lt_key_pair_name" {
  type        = string
  description = "Key pair name for launch template"
}

variable "elb_security_groups" {
  type        = list(any)
  description = "List of security groups for Elastic Load Balancer"
}

variable "launch_template_security_groups" {
  type        = list(any)
  description = "List of security groups for Launch Template"
}

variable "elb_subnets" {
  type        = list(any)
  description = "List of subnets for Elastic Load Balancer"
}

variable "asg_subnets" {
  type        = list(any)
  description = "List of subnets for Auto Scaling Group"
}

variable "asg_max_instances" {
  type        = number
  description = "Maximum number of EC2 instances in auto scaling group"
}

variable "asg_min_instances" {
  type        = number
  description = "Minimum number of EC2 instances in auto scaling group"
}

variable "asg_desired_instances" {
  type        = number
  description = "Desired number of EC2 instances in auto scaling group"
}
