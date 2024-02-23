//tODO Adicionar dynamic_block para regras de ingress e egress do security_group
resource "aws_security_group" "wireguard" {
  description = "Wireguard VPN Security group"
  name        = "${var.cluster_name}-wireguard"
  vpc_id      = data.aws_vpc.this.id
  tags = {
    Application = "wireguard"
  }
}

resource "aws_security_group_rule" "wireguard_ssh_port" {
  description       = "Enable ssh to Wireguard server"
  type              = "ingress"
  security_group_id = aws_security_group.wireguard.id

  from_port   = var.ssh_server_port
  to_port     = var.ssh_server_port
  protocol    = var.server_protocol
  cidr_blocks = var.public_cidr_blocks
}

resource "aws_security_group_rule" "wireguard_vpn_port" {
  description       = "Enable ssh to Wireguard server"
  type              = "ingress"
  security_group_id = aws_security_group.wireguard.id

  from_port   = var.wireguard_port
  to_port     = var.wireguard_port
  protocol    = var.wireguard_protocol
  cidr_blocks = var.public_cidr_blocks
}

resource "aws_security_group_rule" "ansible_egress" {
  description       = "Allow communicate with the internet"
  type              = "egress"
  security_group_id = aws_security_group.wireguard.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = var.public_cidr_blocks
}
