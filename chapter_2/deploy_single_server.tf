resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port = var.server_port
    protocol = "tcp"
    to_port = var.server_port
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "instance_security"
  }
}
resource "aws_launch_configuration" "example" {
  image_id = "ami-40d28157"
  instance_type = "t2.micro"
  security_groups = [
    aws_security_group.instance.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}
data "aws_availability_zones" "all" {}
// create an auto scaling group(ASG)
resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  availability_zones = [
    "us-east-1a",
    "us-east-1b"]
  load_balancers = [
    aws_elb.example.name]
  health_check_type = "ELB"
  max_size = 10
  min_size = 2
  tag {
    key = "Name"
    propagate_at_launch = true
    value = "terraform-asg-example"
  }
}