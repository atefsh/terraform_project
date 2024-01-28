resource "aws_lb" "web_lb" {
  name               = "WebServer-LB"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_security_group.id]
  subnets            = [data.terraform_remote_state.remote_state.outputs.subnet_zone_a_id, data.terraform_remote_state.remote_state.outputs.subnet_zone_b_id]

  tags = {
    Name = "WebServer-LB"
  }
}

resource "aws_lb_target_group" "web_lb_tg" {
  name                 = "WebServer-TG"
  vpc_id               = data.terraform_remote_state.remote_state.outputs.vpc_id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 10 # seconds

  tags = {
    Name = "WebServer-LB-TG"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_lb_tg.arn
  }
}