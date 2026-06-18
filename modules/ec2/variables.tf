
variable "ami" {
  type = string
}

variable "instance_type"{
    type = string
    default = "t2.micro"
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "key_name"{
    type = string
    default = "terraformcloud"
}

variable "env" {
  type = string
  default = "dev"
}

variable "project_name" {
  type = string
  default = "bassirou"
}