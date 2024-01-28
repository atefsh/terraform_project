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

variable "instance_type" {
    description = "Instance type"
    default = "t2.micro"
}

variable "security_group_allow_ports" {
    description = "Which ports to open ?"
    type = list
    // Open SSH and HTTP
    default = ["22", "80"]
}

variable "auto_scaling_min_size" {
    default = 2
}

variable "auto_scaling_max_size" {
    default = 2
}

variable "auto_scaling_min_elb_capacity" {
    default = 2
}