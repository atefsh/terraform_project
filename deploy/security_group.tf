#--- Definde security group ---
resource "aws_security_group" "my_security_group" {
  name        = "SSH-HTTP-SG"
  description = "SSH-HTTP-SG"
  vpc_id      = data.terraform_remote_state.remote_state.outputs.vpc_id
  
  dynamic "ingress" {
    for_each = var.security_group_allow_ports
    content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "SSH-HTTP-SecurityGroup"
  }
}