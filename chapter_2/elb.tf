resource "aws_security_group" "elb" {
  name = "terraform-example-elb"

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_elb" "example" {
  name = "terraform-asg-example"
  availability_zones = ["us-east-1a", "us-east-1b"]
  security_groups = [aws_security_group.elb.id]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = var.server_port
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:${var.server_port}/"
    timeout = 3
    unhealthy_threshold = 2
  }
}