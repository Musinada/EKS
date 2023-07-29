variable "access_key" {
  default = "<YOUR-AWS-ACCESS-KEY>"
}
variable "secret_key" {
  default = "<YOUR-AWS-SECRET-KEY>"
}

variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "Instance Type"
  default = "t2.medium"
}

variable "vpc" [
  description = "cluster vpc"
  default = "EKS-VPC"
]