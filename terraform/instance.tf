resource "aws_instance" "wireguard_instance" {
  ami                         = "ami-0c7217cdde317cfec" //TODO Resolver o Data para AMI
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.wireguard.id]
  associate_public_ip_address = true

  subnet_id = "subnet-059ecb67aa70fbcaa" //TODO Depois de resolver a conf da vpn, preciso resolver o data pro subnet 

  depends_on = [aws_security_group_rule.wireguard_vpn_port]

  tags = {
    Name = "Wireguard-VPN"
    App  = "wireguard"
  }
}

resource "aws_eip" "wireguard_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "wireguard_eip_association" {
  instance_id   = aws_instance.wireguard_instance.id
  allocation_id = aws_eip.wireguard_eip.id
}

