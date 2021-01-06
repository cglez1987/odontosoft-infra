variable "region" {
  type = string
}

variable "availability_zones" {
  type        = list(any)
  description = "List of AZs to use"
}

variable "stage" {
  type        = string
  description = "Name of the stage to build this module"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "Cidr to use in the VPC"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "List of cidr to use as public subnets"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "List of cidr to use as private subnets"
}
