resource "aws_instance" "pivpn_instance" {
  # ami                         = "ami-0c7217cdde317cfec" //TODO Resolver o Data para AMI
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.pivpn.id]
  associate_public_ip_address = true

  subnet_id = data.aws_subnet.public[0].id

  depends_on = [aws_security_group_rule.pivpn_vpn_port]

  tags = {
    Name = "PiVPN"
    App  = "pivpn"
  }
}

resource "aws_eip" "pivpn_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "pivpn_eip_association" {
  instance_id   = aws_instance.pivpn_instance.id
  allocation_id = aws_eip.pivpn_eip.id
}