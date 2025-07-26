# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = "main-vpc"
#   }
# }

# resource "aws_subnet" "private_a" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.1.0/24"
#   availability_zone       = "ap-northeast-1a"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "private-subnet-a"
#   }
# }

# resource "aws_subnet" "private_c" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.3.0/24"
#   availability_zone       = "ap-northeast-1c"
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "private-subnet-c"
#   }
# }

# resource "aws_subnet" "public_a" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.0.0/24"
#   availability_zone       = "ap-northeast-1a"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "public-subnet-a"
#   }
# }