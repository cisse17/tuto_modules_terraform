resource "aws_alb" "main"{
    name = "alb-${var.project_name}-${var.env}"
    internal = false
    load_balancer_type = "application"
    subnets = var.subnet_ids
    security_groups = [var.security_group_id]

    tags = {
        Name = "alb-${var.project_name}"
        Env = var.env
    }
}


resource "aws_alb_target_group" "main"{
    name = "alb-target-group-${var.project_name}-${var.env}"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      enabled = true
      path = "/"
      port = "traffic-port" 
      protocol = "HTTP"
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 5
      interval = 30
      matcher = "200"
    }

    deregistration_delay = 30

    tags = {
        Name = "alb-target-group-${var.project_name}-${var.env}"
    }
}

resource "aws_alb_target_group_attachment" "instances"{
    count = length(var.instance_ids)
    target_group_arn = aws_alb_target_group.main.arn
    target_id = var.instance_ids[count.index]
    port = 80
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.main.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.main.arn
  }

  tags = {
    Name = "http-listener-${var.project_name}-${var.env}"
  }
}
