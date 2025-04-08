resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/19"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
  }

  depends_on = [ aws_vpc.main ]
}