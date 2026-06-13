output "vpc_id" {
  value = aws_vpc.main.id
  description = "ID de notre VPC"
}

output "public_subnet_ids" {
    value = aws_subnet.public[*].id
    description = "IDs des sous réseaux publics"
}

output "private_subnet_ids" {
    value = aws_subnet.private[*].id
    description = "IDs des sous réseaux privés"
}