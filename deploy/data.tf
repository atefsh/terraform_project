data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }
}

data "terraform_remote_state" "remote_state" {
  backend = "s3"
  config = {
    bucket = "atefs-terraform-project"
    key = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}