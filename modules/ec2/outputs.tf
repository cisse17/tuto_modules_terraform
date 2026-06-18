output "ec2_public_ip" {
  value = aws_instance.vm_instance.public_ip
}

output "public_dns" {
  value = aws_instance.vm_instance.public_dns
}

output "instance_id" {
  value = aws_instance.vm_instance.id
}

output "ssh_command" {
  value = "ssh -i ./key/${var.key_name}.pem ubuntu@${aws_instance.vm_instance.public_ip}"
}