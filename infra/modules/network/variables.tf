variable "vpc" {
  type = map(string)
}

variable "public_subnet_a" {
  type = map(string)
}

variable "igw_name" {
  type = string
}

variable "public_route_table_a" {
  type = map(string)
}