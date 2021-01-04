variable "region" {
  type = string
  default = "us-east-1"
}

variable "stage" {
  type        = string
  description = "Name of the stage to build this module"
  default = "dev"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  type    = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}