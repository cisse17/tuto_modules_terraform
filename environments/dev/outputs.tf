output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "ec2_instances" {
  description = "informations sur les instances"
  value = {
    ec2_1 = {
      public_ip  = module.ec2_1.ec2_public_ip
      public_dns = module.ec2_1.public_dns
      ssh        = module.ec2_1.ssh_command
    }
    ec2_2 = {
      public_ip  = module.ec2_2.ec2_public_ip
      public_dns = module.ec2_2.public_dns
      ssh        = module.ec2_2.ssh_command
    }
  }

}


output "load_balancer_url" {
  value = module.alb.url_alb
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}