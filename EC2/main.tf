module "securitygroup" {
  source          = "github.com/asbenso/Modules//SecurityGroup"
  sg_port         = var.sg_port
  vpname          = var.vpname
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  main_vpc_cidr   = var.main_vpc_cidr
}

resource "aws_instance" "jjtech" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = module.securitygroup.securitygroupid
  subnet_id       = var.public_subnets
  tags = {
    Name = var.name
  }
}
