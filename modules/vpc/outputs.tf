output "default_vpc_id" {
  description = "The ID of the Default VPC"
  value       = concat(aws_vpc.this.*.id, [""])[0]
}

output "default_vpc_arn" {
  description = "The ARN of the Default VPC"
  value       = concat(aws_vpc.this.*.arn, [""])[0]
}

output "default_vpc_cidr_block" {
  description = "The CIDR block of the Default VPC"
  value       = concat(aws_vpc.this.*.cidr_block, [""])[0]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public.*.arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.public.*.cidr_block
}

output "public_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = aws_subnet.public.*.ipv6_cidr_block
}