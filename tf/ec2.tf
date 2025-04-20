###############################################################################
# EC2 Instance
###############################################################################

data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "this" {
  ami                                  = data.aws_ssm_parameter.al2023_ami.value
  instance_type                        = "t2.micro"
  subnet_id                            = aws_subnet.public_a.id
  key_name                             = "koujienami" # 既存キーペア名
  vpc_security_group_ids               = [aws_security_group.ec2.id]
  monitoring                           = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"

  tags = {
    Name = "aws-study-ec2"
  }
}
