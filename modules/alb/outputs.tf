output "alb_dns" {
  value = aws_alb.main.dns_name
}

output "url_alb"{
  value = "http://${aws_alb.main.dns_name}"
}

output "zone_id"{
    value = aws_alb.main.zone_id
}
