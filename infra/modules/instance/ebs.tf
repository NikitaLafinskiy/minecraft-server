resource "aws_ebs_volume" "data" {
  availability_zone = "eu-central-1a"
  type = "gp2"
  size              = 16

  tags = {
    Name = "minecraft data"
  }
}

resource "aws_volume_attachment" "data_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.main_public_instance.id
}