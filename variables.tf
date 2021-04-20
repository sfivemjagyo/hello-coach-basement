variable "cluster_name" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "github_token" {
  type = string
}

variable "keypair" {
  type = string
}

variable "global_tags" {
  type = map(any)
  default = {
    Owner = "Mark Jagyo"
  }
}

