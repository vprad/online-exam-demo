variable "region" {
   type    = string
  default = "us-east-1"
}
/*variable "access_key"{
  type = string
  default ="AKIAXGB2MXUHI2SQO34R"
}
variable "secret_key"{
  type = string
  default ="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"
}*/

variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "avail_zone" {}
variable "env_prefix" {}
variable "instance_type" {}
