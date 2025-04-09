data "aws_ebs_snapshot" "ebs_volume" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "volume-size"
    values = ["16"]
  }

  filter {
    name   = "tag:Name"
    values = ["minecraft data"]
  }
}

resource "aws_ebs_volume" "data" {
  availability_zone = "eu-central-1a"
  type = "gp2"
  size              = 16
  snapshot_id = data.aws_ebs_snapshot.ebs_volume.id

  tags = {
    Name = "minecraft data"
  }
}

resource "aws_volume_attachment" "data_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.main_public_instance.id

  provisioner "remote-exec" {
    connection {
        type     = "ssh"
        user     = "ubuntu"
        host     = "${aws_instance.main_public_instance.public_ip}"
        private_key = var.private_ssh_key
    }
    inline = [
      "sudo mkdir /data",
      "sudo mount /dev/nvme1n1 /data",
      "sudo docker compose up -d",
    ]
  }
}

// TODO: check why the server freezes when doing sudo docker ps -a, try to connect to it in minecraft, check whether the container has any errors