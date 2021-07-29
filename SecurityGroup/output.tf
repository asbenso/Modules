output "securitygroupid" {
  value = aws_security_group.allow_tls.id
}

output "securitygroupsubnetID" {
  value = module.vpcnetwork.Public-subnet-id
}
