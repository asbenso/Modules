resource "aws_vpc" "Main" {                # Creating VPC here
  cidr_block           = var.main_vpc_cidr # Defining the CIDR block use 10.0.0.0/24 for demo
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpname
  }

}

resource "aws_subnet" "publicsubnets" { # Creating Public Subnet
  vpc_id                  = aws_vpc.Main.id
  cidr_block              = var.public_subnets # CIDR block of public subnet
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpname}-publicsubnets"
  }
}

resource "aws_subnet" "privatesubnets" { # Creating Priate Subnet
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.private_subnets # CIDR block of private subnets
  tags = {
    Name = "${var.vpname}-privatesubnets"
  }
}

resource "aws_internet_gateway" "IGW" { # Creating Internet Gateway
  vpc_id = aws_vpc.Main.id              # vpc_id will be generated after we create VPC
  tags = {
    Name = "${var.vpname}-IGW"
  }
}

resource "aws_route_table" "PublicRT" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "${var.vpname}-PublicRT"
  }
}

resource "aws_eip" "nateIP" { # Creating Elastic IP
  vpc        = true
  depends_on = [aws_internet_gateway.IGW]
}

resource "aws_nat_gateway" "NATgw" { # Creating Nat Gateway
  allocation_id = aws_eip.nateIP.id
  subnet_id     = aws_subnet.publicsubnets.id
  tags = {
    Name = "${var.vpname}-NATgw"
  }
}

resource "aws_route_table" "PrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.NATgw.id
  }
  tags = {
    Name = "${var.vpname}-PrivateRT"
  }
}

resource "aws_route_table_association" "PrivateRTassociation" {
  subnet_id      = aws_subnet.privatesubnets.id
  route_table_id = aws_route_table.PrivateRT.id
}
resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id      = aws_subnet.publicsubnets.id
  route_table_id = aws_route_table.PublicRT.id
}
