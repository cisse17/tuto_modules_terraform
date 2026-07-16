
resource "aws_instance" "vm_instance"{
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    security_groups = var.security_group_ids
    key_name = var.key_name

    user_data = var.user_data != "" ? var.user_data : null

    tags = {
        Name = "instance-${var.project_name}-${var.env}"
    }
}