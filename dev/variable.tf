variable "region" {
  type = string
}

variable "stage" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets_cidr" {
  type = list(any)
}

variable "private_subnets_cidr" {
  type = list(any)
}


variable "availability_zones" {
  type = list(any)
}

variable "elb_protocol" {
  type = string
}

variable "elb_port" {
  type = number
}

variable "elb_is_internal" {
  type = bool
}

variable "elb_hc_path" {
  type = string
}

variable "ami_names_to_filter" {
  type = list(any)
}

variable "launch_template_name" {
  type = string
}

variable "lt_instance_type" {
  type = string
}

variable "lt_key_pair_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "bucket_acl" {
  type = string
}

variable "bucket_versioning" {
  type = bool
}
