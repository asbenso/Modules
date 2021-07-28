module "vpcnetwork" {
  source = ".//c/Users/Euroil Ltd/Documents/JJtechdevwork/Atom/JJtechterraform/Modules/VPC"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpcnetwork.Vpc-id

  dynamic "ingress" {
    for_each = var.sg_port
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
