resource "aws_instance" "ec2_instance_1" {
  ami           = "ami-0ccabb5f82d4c9af5" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
  tags = {
    Name = "EC2-1"
  }
}

resource "aws_instance" "ec2_instance_2" {
  ami           = "ami-0ccabb5f82d4c9af5"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_b.id

  tags = {
    Name = "EC2-2"
  }
}
