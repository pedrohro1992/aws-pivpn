# data "aws_ami" "ubuntu" {
#   most_recent = true
#
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-22.04-amd64-server-*"]
#   }
#
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#
#   owners = ["099720109477"] # Canonical
# }

data "aws_vpc" "this" {
  tags = {
    Name = "cacetinho-empresa-us-east-1-vpc"
  }
}

# data "aws_subnets" "public" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.this.id]
#   }
#   tags = {
#     Tier = "Private"
#   }
# }
