variable "region" {
  type = string
  default = "us-east-1"
}

variable "stage" {
  type = string
  description = "Name of the stage to build this module"
  default = "dev"
}