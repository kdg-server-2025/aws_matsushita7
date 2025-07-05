variable "vpc_id" { # これはvpc_idってどんな変数？という説明。
  description = "VPCのID"
  type        = string
}

data "aws_vpc" "main" { # aws_vpcはデータソースの種類。今回AWSを利用しているので。
  id = var.vpc_id       # 変数 vpc_id に指定された VPC の ID を元に、既存の VPC を検索している
}


resource "aws_security_group" "ssh_enable" { # セキュリティグループ作成の宣言。
  vpc_id = data.aws_vpc.main.id
  name   = "ssh-enable" # AWS コンソールなどで表示されるセキュリティグループの名前
  tags = {
    Name = "ssh-enable",
  }
}


resource "aws_vpc_security_group_egress_rule" "any" {
  security_group_id = aws_security_group.ssh_enable.id

  cidr_ipv4 = "0.0.0.0/0"
  # any
  ip_protocol = "-1"

  tags = {
    Name = "any",
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_enable" {

  security_group_id = aws_security_group.ssh_enable.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22

  tags = {
    Name = "ssh-enable",
  }
}