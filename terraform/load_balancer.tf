resource "aws_lb" "omarLB" {
  name               = "omar-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  security_groups    = [aws_security_group.OmarGroup.id]
  enable_deletion_protection = false

  enable_http2 = true

  enable_cross_zone_load_balancing = true


}

resource "aws_lb_listener" "omar-lb-listener" {
  load_balancer_arn = aws_lb.omarLB.arn
  port              = 80
  protocol          = "HTTP"
  
    default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target-group.id
  }

}

resource "aws_security_group" "OmarGroup" {
  name        = "OmarGroup"
  description = "Test Acklen Avenue"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group"
  }
 
}

resource "aws_lb_target_group" "target-group" {
  name     = "TargetGroupLB"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "instance"
}


resource "aws_lb_target_group_attachment" "lb_attach_a" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.ec2_instance_1.id
  
}

resource "aws_lb_target_group_attachment" "lb_attach_b" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.ec2_instance_2.id
  
}




