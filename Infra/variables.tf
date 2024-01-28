variable "region" {
  description = "Which region ?"
  default = "us-east-1"
}

variable "default_tags"{
    description = "Default tags for all AWS resources"
    type = map
    default = {
      Owner = "Atef Shehadeh"
      Stage = "Development"
    }
}

variable "private_ip_address" {
  default = "10.4.0.0"
}

variable "vpc_netmask" {
  default = "/16"
}

variable "private_ip_address_zone_a" {
  default = "10.4.1.0"
}

variable "private_ip_address_zone_b" {
  default = "10.4.10.0"
}

variable "zone_netmask" {
  default = "/24"
}

variable "public_cidr_block" {
  default = "0.0.0.0/0"
}