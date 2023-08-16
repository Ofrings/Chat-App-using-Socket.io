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
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "Testing load balance"
    }
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

