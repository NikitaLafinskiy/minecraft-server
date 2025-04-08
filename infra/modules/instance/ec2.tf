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
  instance_type = "t3.micro"
  user_data = "${file("scripts/init.sh")}"

  subnet_id = var.subnet_id

  // Use docker-compose (for simplicity purposes) in order to start a simple volume and a pod running a minecraft server, mount the EBS volume to a location
  // within the instance (mount the device file to a location) and later use it when mounting the volume to the pod (mount it from a local instance location) 

  provisioner "remote-exec" {
    connection {
        type     = "ssh"
        user     = "ubuntu"
        host     = self.public_ip
        private_key = vars.private_ssh_key
    }

    inline = [

    ]
  }

  tags = {
    Name = "minecraft-server"
  }
}