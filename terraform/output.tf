output "public-eip" {
  value = aws_eip.wireguard_eip.public_ip
}
