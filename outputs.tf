output "aws_availability_zones" {
  value = data.aws_availability_zones.workzone.names
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region_name" {
  value = data.aws_region.current.name
}

output "instance_ip" {
  value = aws_instance.Ubuntu.public_ip
}

output "ami_id" {
  value = data.aws_ami.latest_ubuntu_linux.id
}