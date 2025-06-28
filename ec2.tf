# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
data "aws_ami" "ubuntu" { #"ubuntu"のところは任意の名前。わかりやすく
    most_recent = true #一致したAMIがあった時に、最新の物を使うために必要。

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

resource "aws_instance" "kdg-aws-20250622" {
    ami           = data.aws_ami.ubuntu.id #上記のdataを参照してる。ubuntuは任意でつけたラベル名のとこ。
    # AWS の無力枠を使いたいため t3.micro を使う
    instance_type = "t3.micro"

    tags = {
        Name     = "kdg-aws-20250622",
    }
}