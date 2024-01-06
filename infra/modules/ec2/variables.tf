variable "ec2" {
  type = map(string)
}

variable "ec2_security_group_name" {
  type = string
}


variable "vpc_id" {
  type = string
}

variable "public_subnet_a_id" {
  type = string
}

variable "key_name" {
  default = "ec2_key"
}


variable "domain_name" {
  default = "done-api.com"
}