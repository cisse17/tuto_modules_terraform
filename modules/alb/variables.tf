variable "project_name" {
  type = string
  default = "bassirou"
  description = "Nom du projet"
}

variable "env" {
  type = string
  default = "dev"
}

variable "vpc_id" {
  type = string
  description = "IDs du VPC"
}

variable "security_group_id" {
  type = string
  description = "IDs du security group des instances"
}

variable "instance_ids"{
    type = list(string) 
}

variable "subnet_ids" {
  type = list(string)
  description = "IDs des sous réseaux publics "
}