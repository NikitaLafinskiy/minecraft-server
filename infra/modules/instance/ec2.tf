data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "main_public_instance" {
  ami           = data.aws_ami.ubuntu.id

  instance_type = "t3.small"
  availability_zone = "eu-central-1a"
  security_groups = [
    aws_security_group.allow_http.id,
    aws_security_group.allow_ssh.id,
  ]

  user_data = file("${path.module}/scripts/init.sh")

  subnet_id = var.subnet_id

  provisioner "file" {
    connection {
      type     = "ssh"
      user     = "ubuntu"
      host     = self.public_ip
      private_key = var.private_ssh_key
    }

    source = "${path.module}/scripts/docker-compose.yaml"
    destination = "/home/ubuntu/docker-compose.yaml"
  }

  tags = {
    Name = "minecraft-server"
  }
}