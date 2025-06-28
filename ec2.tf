# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
data "aws_ami" "ubuntu" { #"ubuntu"のところは任意の名前。わかりやすく
  most_recent = true      #一致したAMIがあった時に、最新の物を使うために必要。

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # このIDはCanonical社（Ubuntuの公式開発元）の AWS アカウントID
}

# resource "aws_instance" "kdg-aws-20250622" {
#   ami = data.aws_ami.ubuntu.id #上記のdataを参照してる。ubuntuは任意でつけたラベル名のとこ。
#   # AWS の無力枠を使いたいため t3.micro を使う
#   instance_type = "t3.micro"

#   tags = {
#     Name     = "kdg-aws-20250622",
#     UserDate = "true"
#   }

#   vpc_security_group_ids = [aws_security_group.ssh_enable.id] # EC2インスタンスとセキュリティグループの関連付け。vpc_security_group_ids：このパラメータは EC2 が所属する VPCセキュリティグループのIDのリスト を指定します。aws_security_group.ssh_enable.id：先に定義したセキュリティグループ ssh_enable の ID を取得しています。[...]：配列の形式で渡す必要があるので、角括弧で囲んでいます（複数指定も可能）。

#   key_name = aws_key_pair.matsushita_20250622.id #
# }




resource "aws_security_group" "example" {
  name        = "example"
  description = "example"
  vpc_id      = data.aws_vpc.main.id #data.を追加するように言われた


  tags = {
    Name = "example"
  }
}


variable "ssh_key" { # これは説明
  description = "EC2 で使う SSH Key"
  type        = string
}

# key 名は任意の名前で良い。GitHub の key と同じように作業しているPCの名前がおすすめ
resource "aws_key_pair" "matsushita_20250622" {
  key_name   = "matsushita-20250622"
  public_key = var.ssh_key
}