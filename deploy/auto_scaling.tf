resource "aws_launch_template" "test_web_LT" {
  name                   = "WebServer-LT"
  image_id               = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name               = aws_key_pair.ssh_key.key_name
  user_data              = filebase64("${path.module}/user_data_launch_template.sh")
  tags = {
    Name = "WebServer-LT"
  }
}

resource "aws_autoscaling_group" "test_web_scaling" {
  name                = "WebServer-Ver-${aws_launch_template.test_web_LT.latest_version}"
  min_size            = var.auto_scaling_min_size
  max_size            = var.auto_scaling_max_size
  min_elb_capacity    = var.auto_scaling_min_elb_capacity

  health_check_type   = "ELB"
  vpc_zone_identifier = [data.terraform_remote_state.remote_state.outputs.subnet_zone_a_id, data.terraform_remote_state.remote_state.outputs.subnet_zone_b_id]
  target_group_arns   = [aws_lb_target_group.web_lb_tg.arn]

  launch_template {
    id      = aws_launch_template.test_web_LT.id
    version = aws_launch_template.test_web_LT.latest_version
  }


  lifecycle {
    create_before_destroy = true
  }
}