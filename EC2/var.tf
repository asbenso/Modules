variable "ami_id" {

}
variable "instance_type" {

}
variable "name" {

}

variable "sg_port" {
  description = "list of ports"
  type        = list(any)
  default = [
    { port        = 443
      description = "https port"
    },
    { port        = 8000
      description = "http proxy port"
    },
    { port        = 53
      description = "dns port"
    },
    { port        = 80
      description = "http port"
    },
    { port        = 3389
      description = "rdp port"
    },
    { port        = 22
      description = "ssh port"
    },
    { port        = 25
      description = "smtp port"
    },
    { port        = 123
      description = "NTP port"
    },
    { port        = 2049
      description = "NFS port"
    },
    { port        = 1241
      description = "Nessus port"
    }
  ]
}

variable "main_vpc_cidr" {
}

variable "public_subnets" {
}

variable "private_subnets" {
}
variable "vpname" {
}
