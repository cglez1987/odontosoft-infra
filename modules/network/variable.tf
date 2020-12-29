variable "region" {
  type = string
}

variable "stage" {
  type        = string
  description = "Name of the stage to build this module"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_cidr_block2" {
  type    = string
  default = "10.0.2.0/24"
}
