variable "env" {
  type = string
  description = "Environnement (dev, staging, prod)"
  default = "dev"
}

variable "project_name"{
    type = string
    description = "Nom du projet"
    default = "bassirou"
}


variable "vpc_cidr" {
    type = string
    description = "CIDR Block pour le VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs"{
    type = list(string)
    description = "CIDR pour les sous réseaux publics"
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnet_cidrs" {
    type = list(string)
    description = "CIDR pour les sous réseaux privés"
    default = [ "10.0.3.0/24", "10.0.4.0/24"]
  
}

variable "availability_zones" {
    type = list(string)
    description = "listes des zones de disponibilités"
    default = [ "eu-west-3a", "eu-west-3b" ]
  
}
