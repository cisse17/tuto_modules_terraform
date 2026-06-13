output "web_sg_id" {
  value = aws_security_group.web.id
  description = "ID du security group pour les insatnces web"
}


output "rds_sg_id" {
  value = aws_security_group.rds.id
  description = "ID du security group pour les instances RDS"
}


output "alb_sg_id" {
    value = aws_security_group.alb.id
    description = "ID du security group pour l'ALB"
}