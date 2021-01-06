variable "region" {
  type    = string
  default = "us-east-1"
}

variable "stage" {
  type        = string
  description = "Name of the stage to build this module"
  default     = "dev"
}

variable "vpc_name" {
  type    = string
  default = "my_vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  type    = list(any)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}
