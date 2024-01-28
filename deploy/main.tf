provider "aws" {
  region = var.region

  default_tags {
    tags = var.default_tags
  }
}

terraform {
  backend "s3" {
    bucket = "atefs-terraform-project"
    key = "deploy/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "my_webserver_zone_a" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  subnet_id = data.terraform_remote_state.remote_state.outputs.subnet_zone_a_id
  user_data              = file("user_data_instance.sh")
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "public_instance_zone_A"
  }
}

resource "aws_instance" "my_webserver_zone_b" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  subnet_id = data.terraform_remote_state.remote_state.outputs.subnet_zone_b_id
  user_data              = file("user_data_instance.sh")
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "public_instance_zone_B"
  }
}