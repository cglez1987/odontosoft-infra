terraform {
  backend "s3" {
    bucket = "odontosoft-infra-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
