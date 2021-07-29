module "securitygroup" {
  source          = "github.com/asbenso/Modules//SecurityGroup"
  sg_port         = var.sg_port
  vpname          = var.vpname
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  main_vpc_cidr   = var.main_vpc_cidr
}
resource "aws_instance" "jjtech" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = "true"
  subnet_id                   = module.securitygroup.securitygroupsubnetID
  tags = {
    Name = var.name
  }
}

resource "aws_network_interface_sg_attachment" "sg-attachment" {
  security_group_id    = module.securitygroup.securitygroupid
  network_interface_id = aws_instance.jjtech.primary_network_interface_id
}
