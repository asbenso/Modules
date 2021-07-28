output "Vpc-id" {
  value = aws_vpc.Main.id
}
output "Vpc-ARN" {
  value = aws_vpc.Main.arn
}

output "Private-subnet-id" {
  value = aws_subnet.privatesubnets.id
}

output "Public-subnet-id" {
  value = aws_subnet.publicsubnets.id
}

output "Elastic-ip" {
  value = aws_eip.nateIP.public_ip
}

output "Natgateway-id" {
  value = aws_nat_gateway.NATgw.id
}
output "Internet-gateway-id" {
  value = aws_nat_gateway.NATgw.id
}
