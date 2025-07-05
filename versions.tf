terraform { 
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }

    required_version = "1.11.4"

    backend "s3" {
        bucket = "kdg-aws-2025-matsushita"
        key    = "iam/terraform.tfstate"
        region = "ap-northeast-1"
        # tfstate の暗号化を有効にする
        encrypt = true
    }
}