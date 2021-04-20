data "aws_availability_zones" "available" {}

locals {
  subnet_ips = [for i in range(3,1) : cidrsubnet(var.vpc_cidr, 8, i)]
}

module "vpc" {
  source                  = "./modules/vpc"
  name                    = var.vpc_name
  cidr                    = var.vpc_cidr
  map_public_ip_on_launch = "true"
  enable_dns_hostnames    = true
  
  azs                     = data.aws_availability_zones.available.names

  public_subnets          = local.subnet_ips
  public_subnet_suffix    = "public"


  private_subnets       = []
  private_subnet_suffix = ""

  public_subnet_tags = {
    "test" = "for testing"
  }

  private_subnet_tags = {
  }

  tags = var.global_tags
}
