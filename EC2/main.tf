module "securitygroup" {
  source  = "github.com/asbenso/Modules//SecurityGroup"
  sg_port = var.sg_port
}

resource "aws_instance" "jjtech" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  network_interface_id = aws_network_interface.securitygroupint.id
  tags = {
    Name = var.name
  }
}

resource "aws_network_interface" "securitygroupint" {
  security_groups = module.securitygroup.securitygroupid
}
