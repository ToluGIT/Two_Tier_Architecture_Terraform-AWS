resource "aws_launch_template" "template" {
  name_prefix   = "asg-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  key_name = "aws_key"

  user_data = filebase64("user-data.sh")

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_instance_profile.name
  }

  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_security_group.id]
  }

  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      encrypted             = true
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg-instance"
    }
  }
}
