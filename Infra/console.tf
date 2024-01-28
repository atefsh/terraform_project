output "vpc_id" {
    value = aws_vpc.new_vpc.id
}

output "vpc_arn" {
    value = aws_vpc.new_vpc.arn
}

output "vpc_network" {
    value = aws_vpc.new_vpc.cidr_block
}

output "subnet_zone_a_id" {
    value = aws_subnet.new_subnet_zone_a.id
}

output "subnet_zone_a_vpc" {
    value = aws_subnet.new_subnet_zone_a.vpc_id
}

output "subnet_zone_a_arn" {
    value = aws_subnet.new_subnet_zone_a.arn
}

output "subnet_zone_a_availability_zone" {
    value = aws_subnet.new_subnet_zone_a.availability_zone
}

output "subnet_zone_b_id" {
    value = aws_subnet.new_subnet_zone_b.id
}

output "subnet_zone_b_vpc" {
    value = aws_subnet.new_subnet_zone_b.vpc_id
}

output "subnet_zone_b_arn" {
    value = aws_subnet.new_subnet_zone_b.arn
}

output "subnet_zone_b_availability_zone" {
    value = aws_subnet.new_subnet_zone_b.availability_zone
}
