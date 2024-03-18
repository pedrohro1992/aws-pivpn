data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "this" {
  tags = {
    Name = "cacetinho-empresa-us-east-1-vpc"
  }
}

data "aws_subnet" "public" {
  // Gambiarra pra poder usar o data source pra uma subnet
  count = 1
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  tags = {
    Tier = "Public"
  }
  //Definir CIDR Block da subnet desejada- DebTec 01
  cidr_block = "10.0.1.0/24"
}
