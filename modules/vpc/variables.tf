variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "public_subnet_suffix" {
  type = string
}

variable "private_subnet_suffix" {
  type = string
}

variable "enable_dns_hostnames" {
  type = string
}

variable "public_subnets" {
  type    = list(string)
  default = []
}

variable "private_subnets" {
  type    = list(string)
  default = []
}

variable "azs" {
  type    = list(string)
  default = [""]
}

variable "map_public_ip_on_launch" {
  type = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}


