variable "region" {
  type = string
}

variable "stage" {
  type = string
  description = "Name of the stage to build this module"
}

variable "app_name" {
  type = string
}

variable "bucket_acl" {
  type = string
  default = "private"
}

variable "bucket_versioning" {
  type = bool
  default = false
}