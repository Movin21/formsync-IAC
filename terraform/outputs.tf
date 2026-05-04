output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.docker_host.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.docker_host.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.docker_host.public_dns
}

output "instance_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.docker_host.private_ip
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.ec2.id
}

output "ssh_command" {
  description = "Convenience SSH command"
  value       = "ssh -i ${var.private_key_path} ubuntu@${aws_instance.docker_host.public_ip}"
}

output "ansible_inventory_path" {
  description = "Path to the generated Ansible inventory"
  value       = local_file.ansible_inventory.filename
}
