resource "aws_instance" "docker_host" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = aws_key_pair.ec2.key_name
  associate_public_ip_address = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    encrypted             = true
    delete_on_termination = true

    tags = {
      Name = "${local.name_prefix}-root"
    }
  }

  monitoring              = true
  disable_api_termination = false

  tags = {
    Name = "${local.name_prefix}-docker-host"
    Role = "docker-host"
  }

  lifecycle {
    ignore_changes = [ami]
  }
}

resource "local_file" "ansible_inventory" {
  filename        = var.ansible_inventory_path
  file_permission = "0644"

  content = <<-EOT
    [docker_hosts]
    ${aws_instance.docker_host.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${abspath(var.private_key_path)} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

    [docker_hosts:vars]
    ansible_python_interpreter=/usr/bin/python3
  EOT

  depends_on = [
    aws_instance.docker_host,
    local_sensitive_file.private_key,
  ]
}
